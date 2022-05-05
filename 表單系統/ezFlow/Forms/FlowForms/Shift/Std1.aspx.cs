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

public partial class Shift_Std1 : System.Web.UI.Page
{
    //HR
    public HrDSTableAdapters.BaseDataTableAdapter BaseDataTA = new HrDSTableAdapters.BaseDataTableAdapter();
    public HrDSTableAdapters.ROTETableAdapter ROTETA = new HrDSTableAdapters.ROTETableAdapter();

    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.ProcessFlowShareTableAdapter ProcessFlowShareTA = new FlowDSTableAdapters.ProcessFlowShareTableAdapter();
    public FlowDSTableAdapters.ProcessApViewTableAdapter ProcessApViewTA = new FlowDSTableAdapters.ProcessApViewTableAdapter();
    public FlowDSTableAdapters.ProcessApParmTableAdapter ProcessApParmTA = new FlowDSTableAdapters.ProcessApParmTableAdapter();

    //Form
    public ShiftDSTableAdapters.wfShiftAppMTableAdapter wfShiftAppMTA = new ShiftDSTableAdapters.wfShiftAppMTableAdapter();
    public ShiftDSTableAdapters.wfShiftAppSTableAdapter wfShiftAppSTA = new ShiftDSTableAdapters.wfShiftAppSTableAdapter();
    public ShiftDSTableAdapters.ATTENDTableAdapter ATTENDTA = new ShiftDSTableAdapters.ATTENDTableAdapter();
    public ShiftDSTableAdapters.ROTECHGTableAdapter ROTECHGTA = new ShiftDSTableAdapters.ROTECHGTableAdapter();
    public ShiftDSTableAdapters.wfShiftSetTableAdapter wfShiftSetTA = new ShiftDSTableAdapters.wfShiftSetTableAdapter();

    //DataSet
    public HrDS oHrDS;
    public FlowDS oFlowDS;
    public ShiftDS oShiftDS;

    public DataRow[] rows;

    //?idFlowTree=19&idRole_Start=T20000A7&idEmp_Start=96015&idRole_Agent=&idEmp_Agent=

    protected void Page_Load(object sender, EventArgs e) {
        oHrDS = new HrDS();
        oFlowDS = new FlowDS();
        oShiftDS = new ShiftDS();

        lblMsg.Text = "";

        if (!this.IsPostBack) {
            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
            lblProcessID.Text = DateTime.Now.Ticks.ToString() + "#" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序

            wfShiftSetTA.Fill(oShiftDS.wfShiftSet);
            if (oShiftDS.wfShiftSet.Rows.Count == 0) {
                lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            ShiftDS.wfShiftSetRow r = (ShiftDS.wfShiftSetRow)oShiftDS.wfShiftSet.Rows[0];
            lblNote.Text = r.sStdNote;

            SetDefault();
        }
    }

    public void SetDefault() {
        lblNobrB.Text = lblNobr.Text;
        txtAuthority.Text = DateTime.Now.ToShortDateString();
        txtAim.Text = txtAuthority.Text;

        ddlName.DataBind();
        ddlNameB.DataBind();
        ddlRote.DataBind();
        ddlRoteB.DataBind();
        ddlRotet.DataBind();
        ddlRotetB.DataBind();

        ListItem liA, liB;
        liA = ddlName.Items.FindByValue(lblNobr.Text);
        liB = ddlNameB.Items.FindByValue(lblNobr.Text);

        if (liA != null && liB != null) {
            liA.Selected = true;
            liB.Selected = true;
            txtName.Text = liA.Text;
            txtNameB.Text = liB.Text;

            //設定調班日期
            txtAuthority.Text = SetDate(lblNobr.Text).ToShortDateString();
            txtAim.Text = SetDate(lblNobrB.Text).ToShortDateString();

            SetSelect();
        }

        int RoteCate = int.Parse(ddlRoteCate.SelectedItem.Value);

        ddlNameB.Enabled = RoteCate == 1;
        txtNameB.Enabled = RoteCate == 1;
        txtAim.Enabled = RoteCate == 1;
        ddlRote.Enabled = false;
        ddlRoteB.Enabled = RoteCate == 2;
        ddlRotet.Enabled = false;
        ddlRotetB.Enabled = RoteCate == 2;

        ddlRote.Visible = RoteCate == 1;
        ddlRoteB.Visible = RoteCate == 1;
        ddlRotet.Visible = RoteCate == 2;
        ddlRotetB.Visible = RoteCate == 2;
    }

    public void SetSelect() {
        try {
            txtAim.Text = (ddlRoteCate.SelectedItem.Value == "1") ? txtAim.Text : txtAuthority.Text;

            ListItem li = ddlNameB.Items.FindByValue(lblNobrB.Text);
            if (ddlRoteCate.SelectedItem.Value == "2" && li != null) {
                ddlNameB.ClearSelection();
                li.Selected = true;
            }

            //設定班別代碼
            ddlRote.ClearSelection();
            ddlRoteB.ClearSelection();

            ddlRote.Items.FindByValue(SetRote(lblNobr.Text, DateTime.Parse(txtAuthority.Text))).Selected = true;
            ddlRoteB.Items.FindByValue(SetRote(lblNobrB.Text, DateTime.Parse(txtAim.Text))).Selected = true;

            ddlRotet.ClearSelection();
            ddlRotetB.ClearSelection();

            ddlRotet.Items.FindByValue(SetRotet(lblNobr.Text)).Selected = true;
            ddlRotetB.Items.FindByValue(SetRotet(lblNobrB.Text)).Selected = true;
        }
        catch {
            lblMsg.Text = "由於日期格式錯誤或沒有填寫，因此班別代碼會發生錯誤，請輸入正確的日期及工號！";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
    }

    protected void ddlName_SelectedIndexChanged(object sender, EventArgs e) {
        lblNobr.Text = ddlName.SelectedItem.Value;
        txtName.Text = ddlName.SelectedItem.Text;

        lblNobrB.Text = (ddlRoteCate.SelectedItem.Value == "1") ? ddlNameB.SelectedItem.Value : lblNobr.Text;
        txtNameB.Text = (ddlRoteCate.SelectedItem.Value == "1") ? ddlNameB.SelectedItem.Text : txtName.Text;

        txtAuthority.Text = (((DropDownList)sender).ID == "ddlName") ? SetDate(lblNobr.Text).ToShortDateString() : txtAuthority.Text;
        txtAim.Text = (((DropDownList)sender).ID == "ddlNameB") ? SetDate(lblNobrB.Text).ToShortDateString() : txtAim.Text;

        SetSelect();
    }

    protected void txtName_TextChanged(object sender, EventArgs e) {
        ListItem liA, liB;
        liA = ddlName.Items.FindByValue(txtName.Text) != null ? ddlName.Items.FindByValue(txtName.Text) : ddlName.Items.FindByText(txtName.Text);
        liB = ddlNameB.Items.FindByValue(txtNameB.Text) != null ? ddlNameB.Items.FindByValue(txtNameB.Text) : ddlNameB.Items.FindByText(txtNameB.Text);
        liB = (ddlRoteCate.SelectedItem.Value == "1") ? liB : liA;

        if (liA != null) {
            lblNobr.Text = liA.Value;
            txtName.Text = liA.Text;

            ddlName.ClearSelection();
            liA.Selected = true;

            txtAuthority.Text = (((TextBox)sender).ID == "txtName") ? SetDate(lblNobr.Text).ToShortDateString() : txtAuthority.Text;
        }
        else {
            lblNobr.Text = "00000";
            txtName.Text = "";
        }

        if (liB != null) {
            lblNobrB.Text = (ddlRoteCate.SelectedItem.Value == "1") ? liB.Value : lblNobr.Text;
            txtNameB.Text = (ddlRoteCate.SelectedItem.Value == "1") ? liB.Text : txtName.Text;

            ddlNameB.ClearSelection();
            liB.Selected = true;

            txtAim.Text = (((TextBox)sender).ID == "txtNameB") ? SetDate(lblNobrB.Text).ToShortDateString() : txtAim.Text;
        }
        else {
            lblNobrB.Text = "00000";
            txtNameB.Text = "";
        }

        SetSelect();
    }

    protected void txtAuthority_TextChanged(object sender, EventArgs e) {
        DateTime dateA, dateB;

        try {
            dateA = DateTime.Parse(txtAuthority.Text);
            dateB = DateTime.Parse(txtAim.Text);

            SetSelect();
        }
        catch {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
    }

    protected void ddlRoteCate_SelectedIndexChanged(object sender, EventArgs e) {
        SetDefault();
    }

    //設定日期
    public DateTime SetDate(string nobr) {
        DateTime date = DateTime.Now.Date;
        ATTENDTA.FillByNOBR(oShiftDS.ATTEND, nobr);

        rows = oShiftDS.ATTEND.Select("ADATE >= '" + date.ToShortDateString() + "'", "ADATE");
        foreach (ShiftDS.ATTENDRow r in rows) {
            if (r.ROTE.Trim() != "00") {
                return r.ADATE;
            }
        }

        return date;
    }

    //設定班別代碼
    public string SetRote(string nobr, DateTime date) {
        string rote = "00";
        ATTENDTA.FillByNOBR(oShiftDS.ATTEND, nobr);

        rows = oShiftDS.ATTEND.Select("ADATE = '" + date.ToShortDateString() + "'");
        if (rows.Length > 0) {
            ShiftDS.ATTENDRow r = (ShiftDS.ATTENDRow)rows[0];
            rote = r.ROTE.Trim();
        }

        return rote;
    }

    //設定輪班代碼
    public string SetRotet(string nobr) {
        string rotet = "";
        BaseDataTA.FillByNobr(oHrDS.BaseData, nobr);

        if (oHrDS.BaseData.Rows.Count > 0) {
            HrDS.BaseDataRow r = (HrDS.BaseDataRow)oHrDS.BaseData.Rows[0];
            rotet = r.ROTET.Trim();
        }

        return rotet;
    }

    protected void btnAdd_Click(object sender, EventArgs e) {
        //檢查工號是否不存在
        if (txtName.Text.Length == 0 || txtNameB.Text.Length == 0) {
            lblMsg.Text = "有一位員工工號並不存在！";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //調班日期不可空白或錯誤的
        DateTime dateA, dateB;
        try {
            dateA = DateTime.Parse(txtAuthority.Text);
            dateB = DateTime.Parse(txtAim.Text);
        }
        catch {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (ddlRoteCate.SelectedItem.Value == "1") {
            //調班日期不可為假日班
            if (ddlRote.SelectedItem.Value == "00" || ddlRoteB.SelectedItem.Value == "00") {
                lblMsg.Text = "換班日期不可為假日班";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            if (lblNobr.Text == lblNobrB.Text) {
                lblMsg.Text = "換班人員不可相同！";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            //確定互調班別是否正確
            if (CheckRote(lblNobr.Text, txtAuthority.Text, lblNobrB.Text, txtAim.Text)) {
                lblMsg.Text = "其中有一位員工被換班日期不是假日班";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }
        else {
            if (ddlRotet.SelectedItem.Value == ddlRotetB.SelectedItem.Value) {
                lblMsg.Text = "換班班別不可相同";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }

        //檢查hr是否有相同資料
        if ((ROTECHGTA.GetDataByKey(dateB, lblNobr.Text, ddlRoteB.SelectedItem.Value).Rows.Count > 0) || (ROTECHGTA.GetDataByKey(dateA, lblNobrB.Text, ddlRote.SelectedItem.Value).Rows.Count > 0)) {
            lblMsg.Text = "人事資料中已有一筆相同的資料(ROTECHG)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if ((ddlRoteCate.SelectedItem.Value == "1") && ((ATTENDTA.GetDataByKey(lblNobr.Text, dateB, ddlRoteB.SelectedItem.Value).Rows.Count > 0) || (ATTENDTA.GetDataByKey(lblNobrB.Text, dateA, ddlRote.SelectedItem.Value).Rows.Count > 0))) {
            lblMsg.Text = "人事資料中已有一筆相同的資料(ATTEND)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查Flow是否有相同資料進行中
        wfShiftAppSTA.FillByKey(oShiftDS.wfShiftAppS, ddlRoteCate.SelectedItem.Value, lblNobr.Text, dateA, lblNobrB.Text, dateB);
        if (oShiftDS.wfShiftAppS.Select("sState = '1'").Length > 0) {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (oShiftDS.wfShiftAppS.Select("sState = '0' AND sProcessID = '" + lblProcessID.Text + "'").Length > 0) {
            lblMsg.Text = "您已申請一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseDataA, oHrBaseDataB;
        oHrBaseDataA = new HrBaseData(lblNobr.Text);
        oHrBaseDataB = new HrBaseData(lblNobrB.Text);

        wfShiftAppSTA.Fill(oShiftDS.wfShiftAppS);
        ShiftDS.wfShiftAppSRow rs = oShiftDS.wfShiftAppS.NewwfShiftAppSRow();
        rs.sProcessID = lblProcessID.Text;
        rs.idProcess = 0;
        rs.sRoteCate = ddlRoteCate.SelectedItem.Value;
        rs.sRoteCateName = ddlRoteCate.SelectedItem.Text;
        rs.sNobr = lblNobr.Text;
        rs.sName = txtName.Text;
        rs.sDept = oHrBaseDataA.sDept;
        rs.sDeptName = oHrBaseDataA.sDeptName;
        rs.sJob = oHrBaseDataA.sJob;
        rs.sJobName = oHrBaseDataA.sJobName;
        rs.sJobl = oHrBaseDataA.sJobl;
        rs.sJoblName = oHrBaseDataA.sJoblName;
        rs.sEmpcd = oHrBaseDataA.sEmpcd;
        rs.sEmpcdName = oHrBaseDataA.sEmpcdName;
        rs.sRote = (ddlRoteCate.SelectedItem.Value == "1") ? ddlRote.SelectedItem.Value : ddlRotet.SelectedItem.Value;
        rs.sRoteName = (ddlRoteCate.SelectedItem.Value == "1") ? ddlRote.SelectedItem.Text : ddlRotet.SelectedItem.Text;
        rs.dAuthority = DateTime.Parse(txtAuthority.Text);
        rs.sNobrB = lblNobrB.Text;
        rs.sNameB = txtNameB.Text;
        rs.sDeptB = oHrBaseDataB.sDept;
        rs.sDeptNameB = oHrBaseDataB.sDeptName;
        rs.sRoteB = (ddlRoteCate.SelectedItem.Value == "1") ? ddlRoteB.SelectedItem.Value : ddlRotetB.SelectedItem.Value;
        rs.sRoteNameB = (ddlRoteCate.SelectedItem.Value == "1") ? ddlRoteB.SelectedItem.Text : ddlRotetB.SelectedItem.Text;
        rs.dAim = DateTime.Parse(txtAim.Text);
        rs.bSign = true;
        rs.sState = "0";
        rs.bAuth = true;
        rs.sNote = txtNote.Text;
        rs.dKeyDate = DateTime.Now;
        oShiftDS.wfShiftAppS.AddwfShiftAppSRow(rs);

        wfShiftAppSTA.Update(oShiftDS.wfShiftAppS);
        gvAppS.DataBind();
    }

    //確定互調班別是否正確
    public bool CheckRote(string nobrA, string dateA, string nobrB, string dateB) {
        bool isNotV = false;

        ATTENDTA.FillByNOBR(oShiftDS.ATTEND, nobrA);
        rows = oShiftDS.ATTEND.Select("ADATE = '" + dateB + "'");

        if (rows.Length == 0) {
            return true;
        }

        ShiftDS.ATTENDRow r;
        r = (ShiftDS.ATTENDRow)rows[0];
        isNotV = r.ROTE.Trim() != "00";

        ATTENDTA.FillByNOBR(oShiftDS.ATTEND, nobrB);
        rows = oShiftDS.ATTEND.Select("ADATE = '" + dateA + "'");

        if (rows.Length == 0) {
            return true;
        }

        r = (ShiftDS.ATTENDRow)rows[0];
        isNotV = r.ROTE.Trim() != "00";

        return isNotV;
    }

    protected void btnSign_Click(object sender, EventArgs e) {
        if (gvAppS.Rows.Count == 0) {
            lblMsg.Text = "您並未申請任何資料，請先申請至少一筆資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //預設一個暫存的陣列
        ArrayList alShiftAppS = new ArrayList();
        wfShiftAppMTA.Fill(oShiftDS.wfShiftAppM);
        wfShiftAppSTA.FillByProcessID(oShiftDS.wfShiftAppS, lblProcessID.Text);
        ProcessFlowShareTA.Fill(oFlowDS.ProcessFlowShare);

        localhost.Service oService = new localhost.Service();

        //以部門+職稱=角色來決定流程走向
        string RoleID;
        bool isPassAll = false;
        int iError = 0, iOK = 0;
        foreach (ShiftDS.wfShiftAppSRow rs in oShiftDS.wfShiftAppS.Rows) {
            RoleID = rs.sDept + rs.sJob;
            if (!alShiftAppS.Contains(RoleID)) {
                //流程從這裡開始
                lblProcessID.Text = oService.GetProcessID().ToString();

                string Nobr = "";
                //找出相同角色的人來傳送流程
                rows = oShiftDS.wfShiftAppS.Select("sDept = '" + rs.sDept + "' AND sJob = '" + rs.sJob + "'", "sNobr");
                foreach (ShiftDS.wfShiftAppSRow rs1 in rows) {
                    rs1.sProcessID = lblProcessID.Text;
                    rs1.idProcess = int.Parse(lblProcessID.Text);
                    rs1.sState = "1";   //啟動流程為簽核狀態
                    Nobr = rs1.sNobr;
                    //rs1.dKeyDate = DateTime.Now;    //重新更改簽核正確時間

                    //當角色不同時，就將資料寫入ProcessFlowShare
                    if (Request["idRole_Start"] != RoleID) {
                        oService.FlowShare(int.Parse(lblProcessID.Text), RoleID, rs1.sNobr);
                    }
                }

                HrBaseData oHrBaseDataM, oHrBaseDataS;
                oHrBaseDataM = new HrBaseData(Request["idEmp_Start"]);
                oHrBaseDataS = new HrBaseData(Nobr);

                ShiftDS.wfShiftAppMRow rm = oShiftDS.wfShiftAppM.NewwfShiftAppMRow();
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
                rm.bAuth = true;
                rm.bSign = true;
                rm.sState = "1";
                rm.sConditions1 = rm.iCateOrder.ToString(); //目前所簽核到的部門
                oShiftDS.wfShiftAppM.AddwfShiftAppMRow(rm);

                try {
                    //流程序 流程樹 角色代碼 工號 申請者角色代碼 申請者工號
                    //(oService.FlowStart(iProcessID, Request["idFlowTree"], "請假人角色代碼", "請假人工號", Request["idRole_Agent"], Request["idEmp_Agent"]))
                    isPassAll = oService.FlowStart(int.Parse(lblProcessID.Text), Request["idFlowTree"], RoleID, Nobr, Request["idRole_Start"], Request["idEmp_Start"]);
                    iOK++;
                }
                catch {
                    isPassAll = false;
                }

                if (isPassAll) {
                    wfShiftAppMTA.Update(oShiftDS.wfShiftAppM);
                    wfShiftAppSTA.Update(oShiftDS.wfShiftAppS);
                    ProcessFlowShareTA.Update(oFlowDS.ProcessFlowShare);
                }
                else {
                    iError++;
                    oShiftDS.wfShiftAppM.AcceptChanges();
                    oShiftDS.wfShiftAppS.AcceptChanges();
                    oFlowDS.ProcessFlowShare.AcceptChanges();
                }

                //暫存部門
                alShiftAppS.Add(RoleID);
            }
        }

        if (iOK == 1)
        {
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "';", true);
        }
        else
        {
            lblMsg.Text = iError > 0 ? "有部份流程傳送失敗" : "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }

        lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
        lblProcessID.Text = DateTime.Now.Ticks.ToString() + "#" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序
    }

    protected void lbtn_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        string link = "MyFrame.aspx?url=" + lbtn.CommandName + ".aspx?nobr=" + lblNobr.Text + "&id=" + lblProcessID.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = form1;" +
            "window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
    }
}
