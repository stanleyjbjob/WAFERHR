using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

public partial class Abs_Std1 : System.Web.UI.Page {    //HR
    public HrDSTableAdapters.ROTETableAdapter ROTETA = new HrDSTableAdapters.ROTETableAdapter();
    public HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();
    public HrDSTableAdapters.HCODETableAdapter HCODETA = new HrDSTableAdapters.HCODETableAdapter();

    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.wfRoteTableAdapter wfRoteTA = new FlowDSTableAdapters.wfRoteTableAdapter();
    public FlowDSTableAdapters.wfUpFileTableAdapter wfUpFileTA = new FlowDSTableAdapters.wfUpFileTableAdapter();
    public FlowDSTableAdapters.WorkAgentTableAdapter WorkAgentTA = new FlowDSTableAdapters.WorkAgentTableAdapter();

    //Form
    public AbsDSTableAdapters.wfAbsAppMTableAdapter wfAbsAppMTA = new AbsDSTableAdapters.wfAbsAppMTableAdapter();
    public AbsDSTableAdapters.wfAbsAppSTableAdapter wfAbsAppSTA = new AbsDSTableAdapters.wfAbsAppSTableAdapter();
    public AbsDSTableAdapters.wfAbsSetTableAdapter wfAbsSetTA = new AbsDSTableAdapters.wfAbsSetTableAdapter();
    public AbsDSTableAdapters.AbsInfoTableAdapter AbsInfoTA = new AbsDSTableAdapters.AbsInfoTableAdapter();
    public AbsDSTableAdapters.AbsCheckTableAdapter AbsCheckTA = new AbsDSTableAdapters.AbsCheckTableAdapter();

    //DataSet
    public HrDS oHrDS;
    public FlowDS oFlowDS;
    public AbsDS oAbsDS;

    //Row
    AbsDS.wfAbsSetRow rDef;

    public DataRow[] rows;

    //?idFlowTree=19&idRole_Start=T20000A7&idEmp_Start=96015&idRole_Agent=&idEmp_Agent=

    protected void Page_Load(object sender, EventArgs e) {
        oHrDS = new HrDS();
        oFlowDS = new FlowDS();
        oAbsDS = new AbsDS();

        lblMsg.Text = "";

        //帶入系統預設值
        wfAbsSetTA.Fill(oAbsDS.wfAbsSet);
        if (oAbsDS.wfAbsSet.Rows.Count == 0) {
            lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員(Default)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        rDef = (AbsDS.wfAbsSetRow)oAbsDS.wfAbsSet.Rows[0];
        lblNote.Text = rDef.sStdNote;

        if (!this.IsPostBack) {
            SetDefault();

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
            lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序

            ddlName.DataBind();
            txtName_TextChanged(null, null);
        }
    }

    //設定表單預設值
    public void SetDefault() {
        ddlName.Visible = rDef.bAgentApp;
        txtName.ReadOnly = !rDef.bAgentApp;

        lbtnSignState.Visible = rDef.bSignState;
        //lbtnSearchAbsInfo.Visible = rDef.bBalanceH;
    }

    //設定各假別代碼及日期
    public void SetHcode() {
        //假別代碼
        //lblSickie.Text = wfHcodeTA.QueryByKey("Sickie").ToString();
        //lblLeave.Text = wfHcodeTA.QueryByKey("Leave").ToString();
        //lblCare.Text = wfHcodeTA.QueryByKey("Care").ToString();
        //lblCatamenia.Text = wfHcodeTA.QueryByKey("Catamenia").ToString();
    }

    protected void ddlName_SelectedIndexChanged(object sender, EventArgs e) {
        lblNobr.Text = ddlName.SelectedItem.Value;
        txtName.Text = ddlName.SelectedItem.Text;

        txtDateB.Text = SetDate(lblNobr.Text).ToShortDateString();
        txtDateE.Text = txtDateB.Text;

        SetTime(lblRote.Text);

        bindAbsInfo(lblNobr.Text);
    }

    protected void txtName_TextChanged(object sender, EventArgs e) {
        ListItem li, liA, liB;
        liA = ddlName.Items.FindByValue(txtName.Text) != null ? ddlName.Items.FindByValue(txtName.Text) : ddlName.Items.FindByText(txtName.Text);
        liB = ddlName.Items.FindByValue(lblNobr.Text) != null ? ddlName.Items.FindByValue(lblNobr.Text) : ddlName.Items.FindByText(lblNobr.Text);
        li = (liA != null) ? liA : liB;

        lblNobr.Text = "000000";
        txtName.Text = "";
        if (li != null) {
            lblNobr.Text = li.Value;
            txtName.Text = li.Text;

            ddlName.ClearSelection();
            li.Selected = true;
        }

        txtDateB.Text = SetDate(lblNobr.Text).ToShortDateString();
        txtDateE.Text = txtDateB.Text;

        SetTime(lblRote.Text);

        bindAbsInfo(lblNobr.Text);
    }

    //代理職
    protected void ddlAgent_SelectedIndexChanged(object sender, EventArgs e) {
        txtAgent.Text = ddlAgent.SelectedItem.Text;
    }

    protected void txtAgent_TextChanged(object sender, EventArgs e) {
        ListItem li;
        li = ddlAgent.Items.FindByValue(txtAgent.Text) != null ? ddlAgent.Items.FindByValue(txtAgent.Text) : ddlAgent.Items.FindByText(txtAgent.Text);

        txtAgent.Text = "";
        if (li != null) {
            txtAgent.Text = li.Text;

            ddlAgent.ClearSelection();
            li.Selected = true;
        }
    }

    protected void txtDate_TextChanged(object sender, EventArgs e) {
        DateTime dateB, dateE;

        try {
            dateB = DateTime.Parse(txtDateB.Text);

            if (((TextBox)sender).ID == "txtDateB") {
                txtDateE.Text = txtDateB.Text;

                if (rDef.bAttend && (!isNeedWork(lblNobr.Text, ddlHcode.SelectedItem.Value, dateB))) {
                    lblMsg.Text = "此天沒有您的排班資料，請通知人事單位幫您產生(ATTEND)";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                    return;
                }

                rows = ATTENDTA.GetDataByNOBR(lblNobr.Text).Select("ADATE = '" + dateB.ToShortDateString() + "'", "ADATE");
                if (rows.Length > 0) {
                    HrDS.ATTENDRow r = (HrDS.ATTENDRow)rows[0];
                    lblRote.Text = r.ROTE.Trim();
                }

                SetTime(lblRote.Text);
            }
            else {
                dateE = DateTime.Parse(txtDateE.Text);
            }
        }
        catch {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3(兩個日期會同時判斷)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
    }

    //protected void ibtnDate_Command(object sender, CommandEventArgs e) {
    //    string date = e.CommandName == "txtDateB" ? txtDateB.Text : txtDateE.Text;
    //    string dateScript = form1.ID + "." + e.CommandName + ".value = txtDate;";
    //    dateScript += (e.CommandName == "txtDateB") ? form1.ID + ".txtDateE.value = txtDate;" : "";

    //    string link = "MyFrame.aspx?url=Calendar.aspx?nobr=" + lblNobr.Text + "&date=" + date;
    //    string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:550px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
    //        "var obj = form1;" +
    //        "var txtDate = window.showModalDialog('" + link + "', obj, sFeatures);" + dateScript;
    //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Calendar", script, true);
    //}

    protected void lbtnHoliday_Click(object sender, EventArgs e)
    {
        string link = "MyFrame.aspx?url=Calendar.aspx?nobr=" + lblNobr.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:550px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = form1;" +
            "var txtDate = window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Calendar", script, true);
    }

    protected void lbtn_Click(object sender, EventArgs e) {
        LinkButton lbtn = (LinkButton)sender;
        string link = "MyFrame.aspx?url=" + lbtn.CommandName + ".aspx?nobr=" + lblNobr.Text + "&id=" + lblProcessID.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = form1;" +
            "window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
    }

    protected void gvAppS_RowCommand(object sender, GridViewCommandEventArgs e) {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (e.CommandName == "Upload") {
            string link = "MyFrame.aspx?url=Upload.aspx?nobr=" + CommandArgument + "&id=" + lblProcessID.Text;
            string script = "var sFeatures = 'dialogWidth:600px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = form1;" +
                "window.showModalDialog('" + link + "', obj, sFeatures);";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
        }

        if (CommandName == "Del") {
            AbsDS.wfAbsAppSRow rs = (AbsDS.wfAbsAppSRow)wfAbsAppSTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];

            rows = wfUpFileTA.GetDataByProcessID(lblProcessID.Text).Select("sNobr = '" + rs.sNobr + "'");

            foreach (FlowDS.wfUpFileRow r in rows) {
                string FN = Server.MapPath("../Upload/" + r.sServerName);
                FileInfo fi = new FileInfo(FN);

                if (fi.Exists) {
                    fi.Delete();
                    r.Delete();
                    lblMsg.Text = "刪除完成";
                }
                else {
                    lblMsg.Text = "系統找不到檔案";
                }
            }

            wfUpFileTA.Update(rows);
            rs.Delete();
            wfAbsAppSTA.Update(rs);
            gvAppS.DataBind();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e) {
        string nobr = lblNobr.Text.Trim();
        string hcode = ddlHcode.SelectedItem.Value.Trim();

        //最大筆數
        if (gvAppS.Rows.Count >= rDef.iAppCount) {
            lblMsg.Text = "一次只能申請" + rDef.iAppCount.ToString() + "筆";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查工號是否不存在
        if (txtName.Text.Length == 0) {
            lblMsg.Text = "員工工號並不存在";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查日期
        DateTime dateB, dateE;
        try {
            dateB = DateTime.Parse(txtDateB.Text).Date;
            dateE = DateTime.Parse(txtDateE.Text).Date;
        }
        catch {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3(兩個日期會同時判斷)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查時間
        int timeB, timeE;
        try {
            timeB = int.Parse(txtTimeB.Text);
            timeE = int.Parse(txtTimeE.Text);
        }
        catch {
            lblMsg.Text = "時間格式不正確，請重新輸入。例：0930(兩個時間會同時判斷)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查結束時間是否比開始時間小
        DateTime dateBfull, dateEfull;
        dateBfull = dateB.AddMinutes(FlowCS.GetMinutes(txtTimeB.Text));
        dateEfull = dateE.AddMinutes(FlowCS.GetMinutes(txtTimeE.Text));
        if (dateBfull >= dateEfull) {
            lblMsg.Text = "結束日期時間不可小於等於申請日期時間";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (!cbCal.Checked)
        {
            //檢查排班資料
            if (rDef.bAttend && (!isNeedWork(nobr, hcode, dateB)))
            {
                lblMsg.Text = "此天沒有您的排班資料，請通知人事單位幫您產生(ATTEND)";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }

        //檢查延遲送單是否不允許送單(產假或其它假可跨假日IN_HOLI)
        string Holiday = wfRoteTA.QueryByKey("Holiday");
        string Rote = Holiday != null ? Holiday : "00";
        Rote = (HCODETA.GetData().Select("H_CODE = '" + hcode + "' AND IN_HOLI = 1").Length > 0) ? "" : Rote;
        if (Convert.ToInt32(ATTENDTA.QueryByWorkDay(nobr, Rote, dateB, DateTime.Now.Date)) > rDef.iDelay) {
            lblMsg.Text = "請假時間不可超過" + rDef.iDelay.ToString() + "天以後";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查是否需要輸入職務代理人
        if (txtAgent.Text.Length == 0 && rDef.bAgentWork) {
            lblMsg.Text = "職務代理人一定要輸入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查事由是否需要輸入且空白
        if (txtNote.Text.Length == 0 && rDef.bNote)
        {
            lblMsg.Text = "事由一定要輸入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (!cbCal.Checked)
        {
            //檢查申請時間是否在當日區間裡
            if (!isWorkTime(nobr, dateBfull, dateB))
            {
                lblMsg.Text = "您的請假開始日期不在當日的上班時間裡";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            //檢查結束時間是否在當日區間裡
            if (!isWorkTime(nobr, dateEfull, dateB))
            {
                lblMsg.Text = "您的請假結束日期不在當日的上班時間裡";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }

        HrBaseData oHrBaseDataM, oHrBaseDataS;
        oHrBaseDataM = new HrBaseData(Request.QueryString["idEmp_Start"]);
        oHrBaseDataS = new HrBaseData(nobr);

        //計算請假時數
        AbsCS.AbsCalculation oAbsCalculation = AbsCS.CalculationAbs(nobr, hcode, dateB, dateE, txtTimeB.Text, txtTimeE.Text, "",0);

        //限定性別申請假別
        if ((oAbsCalculation.sSex != "") && (oAbsCalculation.sSex != oHrBaseDataS.sSex)) {
            lblMsg.Text = "此假只限" + ((oAbsCalculation.sSex == "M") ? "男性" : "女性") + "可申請";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (!cbCal.Checked)
        {
            //檢查是否請假時數為零(省略，由最小請假時間檢查)
            //檢查是否符合最小請假時數
            if (!oAbsCalculation.bHcodeMin)
            {
                lblMsg.Text = "您請假必需大於或等於" + oAbsCalculation.iHcodeMin.ToString() + oAbsCalculation.sHcodeUnit;
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            //是否除得盡
            if (!oAbsCalculation.bAbsUint)
            {
                lblMsg.Text = "您請的假必需是" + oAbsCalculation.iAbsUint + oAbsCalculation.sHcodeUnit + "的倍數(一定要可以整除)";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }
        else
        {
            decimal h = 0;
            try
            {
                h = Convert.ToDecimal(txtHour.Text);
            }
            catch
            {
                lblMsg.Text = "您手動輸入的時數格式不正確";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }

        //是否剩餘時數是否足夠
        //if (!isBalance(nobr, hcode, Convert.ToDecimal(oAbsCalculation.iTotalDay), Convert.ToDecimal(oAbsCalculation.iTotalHour))) {
        //    lblMsg.Text = "您請的假剩餘時數不足";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        //是否剩餘時數是否足夠(ABST)暫時無法寫

        //檢查hr是否有相同資料
        if (isHrTimeCheck(nobr, dateBfull, dateEfull)) {
            lblMsg.Text = "您的請假日期已在人事單位裡";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查flow是否有相同資料
        if (wfAbsAppSTA.GetDataByFlowCheck(dateEfull, dateBfull, nobr).Rows.Count > 0) {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (wfAbsAppSTA.GetDataByNowFlowCheck(dateEfull, dateBfull, lblProcessID.Text, nobr).Rows.Count > 0) {
            lblMsg.Text = "您已申請一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //從這裡開始新增資料
        wfAbsAppSTA.Fill(oAbsDS.wfAbsAppS);
        AbsDS.wfAbsAppSRow rs = oAbsDS.wfAbsAppS.NewwfAbsAppSRow();
        rs.sProcessID = lblProcessID.Text;
        rs.idProcess = 0;
        rs.sNobr = nobr;
        rs.sName = oHrBaseDataS.sName;
        rs.sDept = oHrBaseDataS.sDept;
        rs.sDeptName = oHrBaseDataS.sDeptName;
        rs.sJob = oHrBaseDataS.sJob;
        rs.sJobName = oHrBaseDataS.sJobName;
        rs.sJobl = oHrBaseDataS.sJobl;
        rs.sJoblName = oHrBaseDataS.sJoblName;
        rs.sEmpcd = oHrBaseDataS.sEmpcd;
        rs.sEmpcdName = oHrBaseDataS.sEmpcdName;
        rs.dStrDateFull = dateBfull;
        rs.dEndDateFull = dateEfull;
        rs.dStrDate = dateB.Date;
        rs.dEndDate = dateE.Date;
        rs.sStrTime = txtTimeB.Text;
        rs.sEndTime = txtTimeE.Text;
        rs.sHcode = hcode;
        rs.sHname = ddlHcode.SelectedItem.Text;
        rs.iHour = cbCal.Checked ? Convert.ToDecimal(txtHour.Text) : Convert.ToDecimal(oAbsCalculation.iHour);
        rs.iTotalHour = cbCal.Checked ? Convert.ToDecimal(txtHour.Text) : Convert.ToDecimal(oAbsCalculation.iTotalHour);
        rs.iDay = cbCal.Checked ? 0 : Convert.ToDecimal(oAbsCalculation.iDay);
        rs.iTotalDay = Convert.ToDecimal(oAbsCalculation.iTotalDay);
        rs.sSalYYMM = HrCS.SetYYMM(rs.dStrDate.Date);
        rs.sReserve2 = cbCal.Checked ? "1" : "0";   //計算休息時間
        rs.sReserve3 = cbCal.Checked ? "是" : "否";   //計算休息時間
        rs.bSign = true;
        rs.sState = "0";
        rs.sAgentNobr1 = (txtAgent.Text.Length > 0) ? ddlAgent.SelectedItem.Value : "";
        rs.sAgentName1 = (txtAgent.Text.Length > 0) ? ddlAgent.SelectedItem.Text : "";
        rs.bAuth = true;
        rs.sNote = txtNote.Text.Trim();
        rs.dKeyDate = DateTime.Now;
        rs.sReserve1 = ddlCat.SelectedItem.Text;    //公出類別
        oAbsDS.wfAbsAppS.AddwfAbsAppSRow(rs);
        wfAbsAppSTA.Update(oAbsDS.wfAbsAppS);

        gvAppS.DataBind();
    }

    protected void btnSign_Click(object sender, EventArgs e) {
        if (gvAppS.Rows.Count == 0) {
            lblMsg.Text = "您並未申請任何資料，請先申請至少一筆資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //預設一個暫存的陣列
        ArrayList alAppS = new ArrayList();
        wfAbsAppMTA.Fill(oAbsDS.wfAbsAppM);
        wfAbsAppSTA.FillByProcessID(oAbsDS.wfAbsAppS, lblProcessID.Text);
        wfUpFileTA.FillByProcessID(oFlowDS.wfUpFile, lblProcessID.Text);

        HrBaseData oHrBaseDataM, oHrBaseDataS;

        localhost.Service oService = new localhost.Service();

        //以部門+職稱+天數=關鍵來決定流程走向 , 角色 , 工號
        string Key, RoleID;
        bool isPassAll = false; //是否有通過
        int iError = 0; //失敗筆數
        int iOK = 0;    //成功筆數
        foreach (AbsDS.wfAbsAppSRow rs in oAbsDS.wfAbsAppS.Rows) {
            Key = rs.sDept + rs.sJob + rs.iDay.ToString();
            RoleID = rs.sDept + rs.sJob;
            if (!alAppS.Contains(Key)) {
                //流程從這裡開始
                lblProcessID.Text = oService.GetProcessID().ToString();

                //找出相同的關鍵來傳送流程
                rows = oAbsDS.wfAbsAppS.Select("sDept = '" + rs.sDept + "' AND sJob = '" + rs.sJob + "' AND iDay = " + rs.iDay);
                foreach (AbsDS.wfAbsAppSRow r in rows) {
                    r.sProcessID = lblProcessID.Text;
                    r.idProcess = int.Parse(lblProcessID.Text);
                    r.sState = "1";   //啟動流程為簽核狀態
                    //rs1.dKeyDate = DateTime.Now;    //重新更改簽核正確時間

                    //通知代理人 2008/2/1 by ming 用珍
                    DataRow[] rowsMail = BaseDataFlowTA.GetDataByNobr(r.sAgentNobr1).Select();
                    if (r.sAgentNobr1.Length > 0 && rowsMail.Length > 0)
                    {
                        FlowDS.BaseDataFlowRow rf = (FlowDS.BaseDataFlowRow)rowsMail[0];

                        string sub = "職務代理人通知(流程尚在簽核中)";
                        string body = r.sAgentName1 + "您好：<br>由於 " + r.sName + " 於 " + r.dStrDateFull.ToString() + " 到 " + r.dEndDateFull.ToString() + " 請假(" + r.sHname + ")" + "請您為職務代理人，特此通知。";

                        FlowCS.SendMail(rf.email, sub, body);
                    }

                    //通知
                    WorkAgentTA.Fill(oFlowDS.WorkAgent, r.sNobr);
                    foreach (FlowDS.WorkAgentRow rw in oFlowDS.WorkAgent.Rows)
                    {
                        string sub = "職務代理人通知(流程尚在簽核中)";
                        string body = rw.Emp_nameTarget + "您好：<br>由於 " + r.sName + " 於 " + r.dStrDateFull.ToString() + " 到 " + r.dEndDateFull.ToString() + " 請假(" + r.sHname + ")" + "請您為職務代理人，特此通知。";

                        FlowCS.SendMail(rw.Emp_emailTarget, sub, body);
                    }

                    //當角色不同時，就將資料寫入ProcessFlowShare
                    if (Request["idRole_Start"] != RoleID)
                        oService.FlowShare(int.Parse(lblProcessID.Text), RoleID, r.sNobr);

                    //附加檔案
                    rows = oFlowDS.wfUpFile.Select("sNobr = '" + r.sNobr + "'");
                    foreach (FlowDS.wfUpFileRow rf in rows) {
                        rf.sProcessID = lblProcessID.Text;
                        rf.idProcess = int.Parse(lblProcessID.Text);
                    }
                }

                oHrBaseDataM = new HrBaseData(Request["idEmp_Start"]);
                oHrBaseDataS = new HrBaseData(rs.sNobr);

                AbsDS.wfAbsAppMRow rm = oAbsDS.wfAbsAppM.NewwfAbsAppMRow();
                rm.sProcessID = lblProcessID.Text;
                rm.idProcess = int.Parse(lblProcessID.Text);
                rm.sNobr = oHrBaseDataM.sNobr;
                rm.sName = oHrBaseDataM.sName;
                rm.sDept = oHrBaseDataM.sDept;
                rm.sDeptName = oHrBaseDataM.sDeptName;
                rm.sJob = oHrBaseDataM.sJob;
                rm.sJobName = oHrBaseDataM.sJobName;
                rm.sJobl = oHrBaseDataM.sJobl;
                rm.sJoblName = oHrBaseDataM.sJoblName;
                rm.iCateOrder = oHrBaseDataS.iCateOrder;    //被申請者的部門層級
                rm.bDelay = false;  //是否有延遲需要補單
                rm.dDateA = DateTime.Now;
                rm.bAuth = oHrBaseDataS.bMang; //是否是主管
                rm.bSign = true;
                rm.iTotalDay = rs.iTotalDay;
                rm.sState = "1";
                rm.sConditions1 = rm.iCateOrder.ToString(); //目前所簽核到的部門
                oAbsDS.wfAbsAppM.AddwfAbsAppMRow(rm);

                try {
                    //流程序 流程樹 角色代碼 工號 申請者角色代碼 申請者工號
                    //(oService.FlowStart(iProcessID, Request["idFlowTree"], "請假人角色代碼", "請假人工號", Request["idRole_Agent"], Request["idEmp_Agent"]))
                    isPassAll = oService.FlowStart(int.Parse(lblProcessID.Text), Request["idFlowTree"], RoleID, rs.sNobr, Request["idRole_Start"], Request["idEmp_Start"]);
                    iOK++;
                }
                catch {
                    isPassAll = false;
                }

                if (isPassAll) {
                    wfAbsAppMTA.Update(oAbsDS.wfAbsAppM);
                    wfAbsAppSTA.Update(oAbsDS.wfAbsAppS);
                    wfUpFileTA.Update(oFlowDS.wfUpFile);
                }
                else {
                    iError++;
                    oAbsDS.wfAbsAppM.AcceptChanges();
                    oAbsDS.wfAbsAppS.AcceptChanges();
                    oFlowDS.wfUpFile.AcceptChanges();
                }

                alAppS.Add(Key);    //暫存關鍵
            }
        }

        if (iOK == 1) {
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "';", true);
        }
        else {
            lblMsg.Text = iError > 0 ? "有部份流程傳送失敗" : "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }

        lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
        lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序
    }

    //設定日期
    public DateTime SetDate(string nobr) {
        DateTime date = DateTime.Now.Date;
        string Holiday = wfRoteTA.QueryByKey("Holiday");
        string Rote = Holiday != null ? Holiday : "00";

        rows = ATTENDTA.GetDataByNOBR(nobr).Select("ADATE >= '" + date.ToShortDateString() + "'", "ADATE");
        foreach (HrDS.ATTENDRow r in rows) {
            if (r.ROTE.Trim() != Rote) {
                lblRote.Text = r.ROTE;  //指定班別
                return r.ADATE;
            }
        }

        return date;
    }

    //設定時間
    public void SetTime(string rote) {
        rows = ROTETA.GetDataByRote(rote).Select();

        if (rows.Length > 0) {
            HrDS.ROTERow r = (HrDS.ROTERow)rows[0];
            txtTimeB.Text = r.ON_TIME.Trim().Length > 0 ? r.ON_TIME.Trim() : "0000";
            txtTimeE.Text = r.OFF_TIME.Trim().Length > 0 ? r.OFF_TIME.Trim() : "0000";
        }
    }

    //判別日期是否需要出勤true = 有排班資料
    public bool isNeedWork(string nobr, string hcode, DateTime date) {
        string Holiday = wfRoteTA.QueryByKey("Holiday");
        string Rote = Holiday != null ? Holiday : "00";
        Rote = (HCODETA.GetData().Select("H_CODE = '" + hcode + "' AND IN_HOLI = 1").Length > 0) ? "" : Rote;

        rows = ATTENDTA.GetDataByNOBR(nobr).Select("ADATE = '" + date.ToShortDateString() + "' AND ROTE <> '" + Rote + "'", "ADATE");

        return rows.Length > 0;
    }

    //請假時間是否落在上班時間裡false = 沒有落在上班時間裡
    public bool isWorkTime(string nobr, DateTime date, DateTime dateB)
    {
        rows = ATTENDTA.GetDataByNOBR(nobr).Select("ADATE = '" + dateB.ToShortDateString() + "'");
        if (rows.Length > 0)
        {
            HrDS.ATTENDRow ra = (HrDS.ATTENDRow)rows[0];

            rows = ROTETA.GetDataByRote(ra.ROTE.Trim()).Select();
            if (rows.Length > 0)
            {
                HrDS.ROTERow rr = (HrDS.ROTERow)rows[0];

                DateTime dateBfull, dateEfull;
                dateBfull = dateB.Date.AddMinutes(FlowCS.GetMinutes(rr.ON_TIME.Trim()));
                dateEfull = date.Date.AddMinutes(FlowCS.GetMinutes(rr.OFF_TIME.Trim()));

                string Holiday = wfRoteTA.QueryByKey("Holiday");
                string Rote = Holiday != null ? Holiday : "00";

                //等於假日或是開始時間小於等於申請時間而且結束時間大於等於申請時間
                return (rr.ROTE.Trim() == Rote) || ((dateBfull <= date) && (dateEfull >= date));
            }
        }

        return false;
    }

    //剩餘時數false = 不足時數
    public bool isBalance(string nobr, string hcode, decimal DayB, decimal HourB) {
        DateTime Date = DateTime.Now.Date, DateB, DateE;
        DateB = new DateTime(Date.Year, 1, 1);
        DateE = new DateTime(Date.Year, 12, DateTime.DaysInMonth(Date.Year, 12));

        AbsInfoTA.Fill(oAbsDS.AbsInfo, nobr, DateB, DateE, Date);
        rows = oAbsDS.AbsInfo.Select("H_CODE = '" + hcode + "'");

        decimal max = 0, balance = 0, use = 0;
        if (rows.Length > 0) {
            AbsDS.AbsInfoRow r = (AbsDS.AbsInfoRow)rows[0];
            //如果遇到有關聯的假…
            rows = oAbsDS.AbsInfo.Select("DCODE = '" + r.H_CODE.Trim() + "'");
            if (rows.Length > 0) {
                AbsDS.AbsInfoRow r1 = (AbsDS.AbsInfoRow)rows[0];
                max = Convert.ToDecimal(r.MAX_NUM) + Convert.ToDecimal(r1.MAX_NUM);
                balance = max - r.TOL_HOURS - r1.TOL_HOURS;
            }
            else {
                max = Convert.ToDecimal(r.MAX_NUM);
                balance = max - r.TOL_HOURS;
            }

            use = (r.UNIT.Trim() == "天") ? (balance - DayB) : (balance - HourB);

            //處理ABST得假資料表
            if (r.CHE) {

            }

            //最大值等於0或是剩餘時數大於等於0都可以
            return (!r.CHE) || (use >= 0);
        }

        return false;
    }

    //hr是否有相同資料false = 沒有相同資料
    public bool isHrTimeCheck(string nobr, DateTime dateB, DateTime dateE) {
        rows = AbsCheckTA.GetDataByNobr(nobr, dateB.Date, dateE.Date).Select();

        DateTime dateBfull, dateEfull;
        foreach (AbsDS.AbsCheckRow r in rows) {
            dateBfull = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.BTIME));
            dateEfull = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.ETIME));

            return ((dateBfull < dateE) && (dateEfull > dateB));
        }

        return false;
    }

    public void bindAbsInfo(string nobr) {
        DateTime Date = DateTime.Now.Date, DateB, DateE;
        DateB = new DateTime(Date.Year, 1, 1);
        DateE = new DateTime(Date.Year, 12, DateTime.DaysInMonth(Date.Year, 12));

        AbsInfoTA.Fill(oAbsDS.AbsInfo, nobr, DateB, DateE, Date);
        rows = oAbsDS.AbsInfo.Select("DISPLAYFORM = 1", "H_CODE");
        DataTable dtAbsInfo = new DataTable();
        dtAbsInfo.Columns.Add("sName", typeof(string)).DefaultValue = "";
        foreach (AbsDS.AbsInfoRow r in rows)
            dtAbsInfo.Columns.Add(r.H_CODE.Trim(), typeof(decimal)).DefaultValue = 0;

        DataRow ra;
        ra = dtAbsInfo.NewRow();
        ra["sName"] = "全部";
        foreach (AbsDS.AbsInfoRow r in oAbsDS.AbsInfo.Rows) {
            if (dtAbsInfo.Columns.Contains(r.H_CODE.Trim()))
                ra[r.H_CODE.Trim()] = r.MAX_NUM;
        }
        dtAbsInfo.Rows.Add(ra);

        ra = dtAbsInfo.NewRow();
        ra["sName"] = "已用";
        foreach (AbsDS.AbsInfoRow r in oAbsDS.AbsInfo.Rows) {
            if (dtAbsInfo.Columns.Contains(r.H_CODE.Trim()))
                ra[r.H_CODE.Trim()] = r.TOL_HOURS;
        }
        dtAbsInfo.Rows.Add(ra);

        ra = dtAbsInfo.NewRow();
        ra["sName"] = "剩餘";
        foreach (AbsDS.AbsInfoRow r in oAbsDS.AbsInfo.Rows) {
            if (dtAbsInfo.Columns.Contains(r.H_CODE.Trim())) {
                //如果遇到有關聯的假…
                rows = oAbsDS.AbsInfo.Select("DCODE = '" + r.H_CODE.Trim() + "'");
                if (rows.Length > 0) {
                    AbsDS.AbsInfoRow r1 = (AbsDS.AbsInfoRow)rows[0];
                    ra[r.H_CODE.Trim()] = Convert.ToDecimal(r.MAX_NUM) + Convert.ToDecimal(r1.MAX_NUM) - r.TOL_HOURS - r1.TOL_HOURS;
                }
                else {
                    ra[r.H_CODE.Trim()] = Convert.ToDecimal(r.MAX_NUM) - r.TOL_HOURS;
                }
            }
        }
        dtAbsInfo.Rows.Add(ra);

        DataColumnCollection dcc = dtAbsInfo.Columns;
        dcc["sName"].ColumnName = " ";
        foreach (DataColumn dc in dcc) {
            rows = oAbsDS.AbsInfo.Select("H_CODE = '" + dc.ColumnName + "'");
            if (rows.Length > 0) {
                AbsDS.AbsInfoRow r = (AbsDS.AbsInfoRow)rows[0];
                dc.ColumnName = r.H_NAME.Trim() + "(" + r.UNIT.Trim() + ")";
            }
        }

        //gvInfo.DataSource = dtAbsInfo;
        //gvInfo.DataBind();
    }
}