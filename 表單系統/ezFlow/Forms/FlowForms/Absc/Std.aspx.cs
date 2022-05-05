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

public partial class Absc_Std : System.Web.UI.Page
{
    //HR
    public HrDSTableAdapters.ROTETableAdapter ROTETA = new HrDSTableAdapters.ROTETableAdapter();
    public HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();
    public HrDSTableAdapters.HCODETableAdapter HCODETA = new HrDSTableAdapters.HCODETableAdapter();
    public HrDSTableAdapters.AbsTableAdapter AbsTA = new HrDSTableAdapters.AbsTableAdapter();

    //Flow
    public FlowDSTableAdapters.wfRoteTableAdapter wfRoteTA = new FlowDSTableAdapters.wfRoteTableAdapter();

    //Form
    public AbscDSTableAdapters.wfAbscAppMTableAdapter wfAbscAppMTA = new AbscDSTableAdapters.wfAbscAppMTableAdapter();
    public AbscDSTableAdapters.wfAbscAppSTableAdapter wfAbscAppSTA = new AbscDSTableAdapters.wfAbscAppSTableAdapter();
    public AbscDSTableAdapters.wfAbscSetTableAdapter wfAbscSetTA = new AbscDSTableAdapters.wfAbscSetTableAdapter();

    //DataSet
    public HrDS oHrDS;
    public AbscDS oAbscDS;

    //Row
    AbscDS.wfAbscSetRow rDef;

    public DataRow[] rows;

    //?idFlowTree=19&idRole_Start=T20000A7&idEmp_Start=96015&idRole_Agent=&idEmp_Agent=

    protected void Page_Load(object sender, EventArgs e) {
        oHrDS = new HrDS();
        oAbscDS = new AbscDS();

        lblMsg.Text = "";

        //帶入系統預設值
        wfAbscSetTA.Fill(oAbscDS.wfAbscSet);
        if (oAbscDS.wfAbscSet.Rows.Count == 0) {
            lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員(Default)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        rDef = (AbscDS.wfAbscSetRow)oAbscDS.wfAbscSet.Rows[0];
        lblNote.Text = rDef.sStdNote;

        if (!this.IsPostBack) {
            SetDefault();

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? FlowCS.GetDecode(Request.QueryString["idEmp_Start"]) : lblNobr.Text;
            lblEmpID.Text = lblNobr.Text;
            lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序

            ddlName.DataBind();
            txtName_TextChanged(null, null);
            ddlDate.DataBind();
            ddlTime.DataBind();
            lblBind();
        }
    }

    //設定表單預設值
    public void SetDefault() {
        ddlName.Visible = rDef.bAgentApp;
        txtName.ReadOnly = !rDef.bAgentApp;
        lbtnSignState.Visible = rDef.bSignState;
    }

    protected void ddlName_SelectedIndexChanged(object sender, EventArgs e) {
        lblNobr.Text = ddlName.SelectedItem.Value;
        txtName.Text = ddlName.SelectedItem.Text;

        ddlDate.DataBind();
        lblBind();
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

            ddlDate.DataBind();
            lblBind();
        }
    }

    protected void ddlDate_SelectedIndexChanged(object sender, EventArgs e) {
        ddlTime.DataBind();
        lblBind();
    }

    protected void ddlTime_SelectedIndexChanged(object sender, EventArgs e) {
        lblBind();
    }

    public void lblBind() {
        lblHcode.Text = "";
        lblHours.Text = "";

        DateTime date;
        string time;
        try {
            date = DateTime.Parse(ddlDate.SelectedItem.Value);
            time = ddlTime.SelectedItem.Value;
        }
        catch {
            date = DateTime.Now.Date;
            time = "0000";
        }

        rows = AbsTA.GetDataByDate(lblNobr.Text, date, time).Select();
        if (rows.Length > 0) {
            HrDS.AbsRow r = (HrDS.AbsRow)rows[0];
            lblHcode.Text = r.H_NAME.Trim();
            lblHcode.ToolTip = r.H_CODE.Trim();
            lblHours.Text = r.TOL_HOURS.ToString() + r.UNIT.Trim();
            lblHours.ToolTip = r.TOL_HOURS.ToString();
        }
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

        if (CommandName == "Del") {
            AbscDS.wfAbscAppSRow rs = (AbscDS.wfAbscAppSRow)wfAbscAppSTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];

            rs.Delete();
            wfAbscAppSTA.Update(rs);
            gvAppS.DataBind();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e) {
        string nobr = lblNobr.Text.Trim();

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

        DateTime date;
        string time;
        try {
            date = DateTime.Parse(ddlDate.SelectedItem.Value);
            time = ddlTime.SelectedItem.Value;
        }
        catch {
            lblMsg.Text = "日期格式不正確，請重新選取。";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查延遲送單是否不允許送單(產假或其它假可跨假日IN_HOLI)
        string Holiday = wfRoteTA.QueryByKey("Holiday");
        string Rote = Holiday != null ? Holiday : "00";
        Rote = (HCODETA.GetData().Select().Length > 0) ? "" : Rote;
        if (Convert.ToInt32(ATTENDTA.QueryByWorkDay(nobr, Rote, date, DateTime.Now.Date)) > rDef.iDelay) {
            lblMsg.Text = "銷假時間不可超過" + rDef.iDelay.ToString() + "天以後";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查事由是否需要輸入且空白
        if (txtNote.Text.Length == 0 && rDef.bNote) {
            lblMsg.Text = "事由一定要輸入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseDataM, oHrBaseDataS;
        oHrBaseDataM = new HrBaseData(FlowCS.GetDecode(Request.QueryString["idEmp_Start"]));
        oHrBaseDataS = new HrBaseData(nobr);

        //檢查hr是否有相同資料
        rows = AbsTA.GetDataByDate(lblNobr.Text, date, time).Select();
        if (rows.Length == 0) {
            lblMsg.Text = "您的請假日期沒有在人事單位裡";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrDS.AbsRow ri = (HrDS.AbsRow)rows[0];
        DateTime dateBfull, dateEfull;
        dateBfull = date.AddMinutes(FlowCS.GetMinutes(ri.BTIME.Trim(), true));
        dateEfull = date.AddMinutes(FlowCS.GetMinutes(ri.ETIME.Trim(), false));

        //檢查flow是否有相同資料
        if (wfAbscAppSTA.GetDataByFlowCheck(dateEfull, dateBfull, nobr).Rows.Count > 0) {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (wfAbscAppSTA.GetDataByNowFlowCheck(dateEfull, dateBfull, lblProcessID.Text, nobr).Rows.Count > 0) {
            lblMsg.Text = "您已申請一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //從這裡開始新增資料
        wfAbscAppSTA.Fill(oAbscDS.wfAbscAppS);
        AbscDS.wfAbscAppSRow rs = oAbscDS.wfAbscAppS.NewwfAbscAppSRow();
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
        rs.dStrDate = date.Date;
        rs.dEndDate = date.Date;
        rs.sStrTime = ri.BTIME.Trim();
        rs.sEndTime = ri.ETIME.Trim();
        rs.sHcode = ri.H_CODE.Trim();
        rs.sHname = ri.H_NAME.Trim();
        rs.iTotalHour =(ri.UNIT.Trim() == "小時")? ri.TOL_HOURS : 0;
        rs.iTotalDay = (ri.UNIT.Trim() == "天") ? ri.TOL_HOURS : 0;
        rs.bSign = true;
        rs.sState = "0";
        rs.bAuth = true;
        rs.sNote = txtNote.Text.Trim();
        rs.dKeyDate = DateTime.Now;
        oAbscDS.wfAbscAppS.AddwfAbscAppSRow(rs);
        wfAbscAppSTA.Update(oAbscDS.wfAbscAppS);

        gvAppS.DataBind();
    }

    protected void btnSign_Click(object sender, EventArgs e)
    {
        if (gvAppS.Rows.Count == 0)
        {
            lblMsg.Text = "您並未申請任何資料，請先申請至少一筆資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        string HrMail = ConfigurationSettings.AppSettings["HrMail"];

        string body = "";
        //預設一個暫存的陣列
        ArrayList alAppS = new ArrayList();
        wfAbscAppMTA.Fill(oAbscDS.wfAbscAppM);
        wfAbscAppSTA.FillByProcessID(oAbscDS.wfAbscAppS, lblProcessID.Text);

        HrBaseData oHrBaseDataM, oHrBaseDataS;

        localhost.Service oService = new localhost.Service();

        //以部門+職稱+天數=關鍵來決定流程走向 , 角色 , 工號
        string Key, RoleID;
        bool isPassAll = false; //是否有通過
        int iError = 0; //失敗筆數
        int iOK = 0;    //成功筆數
        foreach (AbscDS.wfAbscAppSRow rs in oAbscDS.wfAbscAppS.Rows)
        {
            Key = rs.sDept + rs.sJob;
            RoleID = rs.sDept + rs.sJob;
            //if (!alAppS.Contains(Key)) {
            //流程從這裡開始
            lblProcessID.Text = oService.GetProcessID().ToString();

            //找出相同的關鍵來傳送流程
            //rows = oAbscDS.wfAbscAppS.Select("sDept = '" + rs.sDept + "' AND sJob = '" + rs.sJob + "'");
            //foreach (AbscDS.wfAbscAppSRow r in rows) {
            rs.sProcessID = lblProcessID.Text;
            rs.idProcess = int.Parse(lblProcessID.Text);
            rs.sState = "1";   //啟動流程為簽核狀態
            //rs1.dKeyDate = DateTime.Now;    //重新更改簽核正確時間

            //當角色不同時，就將資料寫入ProcessFlowShare
            //if (Request["idRole_Start"] != RoleID)
            //    oService.FlowShare(int.Parse(lblProcessID.Text), RoleID, r.sNobr);
            //}

            oHrBaseDataM = new HrBaseData(FlowCS.GetDecode(Request.QueryString["idEmp_Start"]));
            oHrBaseDataS = new HrBaseData(rs.sNobr);

            AbscDS.wfAbscAppMRow rm = oAbscDS.wfAbscAppM.NewwfAbscAppMRow();
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
            rm.iTotalCount = gvAppS.Rows.Count;
            rm.sState = "1";
            rm.sConditions1 = rm.iCateOrder.ToString(); //目前所簽核到的部門
            oAbscDS.wfAbscAppM.AddwfAbscAppMRow(rm);

            try
            {
                //流程序 流程樹 角色代碼 工號 申請者角色代碼 申請者工號
                //(oService.FlowStart(iProcessID, Request["idFlowTree"], "請假人角色代碼", "請假人工號", Request["idRole_Agent"], Request["idEmp_Agent"]))
                //isPassAll = oService.FlowStart(int.Parse(lblProcessID.Text), Request["idFlowTree"], RoleID, rs.sNobr, Request["idRole_Start"], Request["idEmp_Start"]);

                body = "[AppM];";
                foreach (DataColumn dc in oAbscDS.wfAbscAppM.Columns)
                {
                    if (rm[dc] != null)
                        body += dc.ToString() + "=" + rm[dc].ToString() + ";";
                }

                body += "[AppS];";
                foreach (DataColumn dc in oAbscDS.wfAbscAppS.Columns)
                {
                    if (oAbscDS.wfAbscAppS.Rows[0][dc] != null)
                        body += dc.ToString() + "=" + oAbscDS.wfAbscAppS.Rows[0][dc].ToString() + ";";
                }

                iOK++;

                isPassAll = true;

            }
            catch
            {
                isPassAll = false;
            }

            if (isPassAll)
            {
                wfAbscAppMTA.Update(oAbscDS.wfAbscAppM);
                wfAbscAppSTA.Update(oAbscDS.wfAbscAppS);

                FlowCS.SendMail(HrMail, "01;Absc;" + lblProcessID.Text + ";", body);
            }
            else
            {
                iError++;
                oAbscDS.wfAbscAppM.AcceptChanges();
                oAbscDS.wfAbscAppS.AcceptChanges();
            }

            alAppS.Add(Key);    //暫存關鍵
            //}
        }

        if (iOK > 0)
        {
            lblMsg.Text = "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            //ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "';", true);
        }
        else
        {
            lblMsg.Text = iError > 0 ? "有部份流程傳送失敗" : "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }

        lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? FlowCS.GetDecode(Request.QueryString["idEmp_Start"]) : lblNobr.Text;
        lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序
    }

    protected void ddlName_DataBound(object sender, EventArgs e)
    {
        HrBaseData oHrBaseData = new HrBaseData(lblEmpID.Text);
        if (!oHrBaseData.bMang)
        {
            DropDownList ddl = new DropDownList();

            foreach (ListItem li in ddlName.Items)
            {
                oHrBaseData = new HrBaseData(li.Value);
                if (oHrBaseData.bMang)
                    ddl.Items.Add(li);
            }

            foreach (ListItem li in ddl.Items)
                ddlName.Items.Remove(li);
        }
    }

}