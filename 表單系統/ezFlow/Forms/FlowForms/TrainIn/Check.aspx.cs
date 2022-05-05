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

public partial class TrainIn_Check : System.Web.UI.Page
{
    //HR
    public TrainDSTableAdapters.TRCOSTableAdapter TRCOSTA = new TrainDSTableAdapters.TRCOSTableAdapter();

    //Flow
    public FlowDSTableAdapters.wfSignTableAdapter wfSignTA = new FlowDSTableAdapters.wfSignTableAdapter();

    //Form
    public TrainDSTableAdapters.wfTrainInAppTableAdapter wfTrainInAppTA = new TrainDSTableAdapters.wfTrainInAppTableAdapter();

    //DataSet
    public TrainDS oTrainDS;
    public FlowDS oFlowDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        oTrainDS = new TrainDS();
        oFlowDS = new FlowDS();

        TRCOSTA.Fill(oTrainDS.TRCOS);

        lblMsg.Text = "";

        if (Request.Url.Query.Length == 0 || Request.Cookies["ezFlow"] == null)
        {
            lblMsg.Text = "表單資訊錯誤，請重新開啟";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            Response.Redirect("http://" + Request.Url.Host + "/ezFlow/ezClient/Default.aspx?action=logout");
        }

        string RequestName = Request.QueryString.AllKeys[0];
        string RequestValue = Request[RequestName];
        lblNobr.Text = Request.Cookies["ezFlow"]["Emp_id"];
        btnSign.Visible = (RequestName == "ApParm");

        if (!this.IsPostBack)
        {
            lblUrl.Text = Request.Url.Query;
            lblProcessID.Text = FlowCS.GetProcessID(RequestName, int.Parse(RequestValue));

            rows = wfTrainInAppTA.GetDataByProcessID(lblProcessID.Text).Select();

            if (rows.Length > 0)
            {
                TrainDS.wfTrainInAppRow rti = (TrainDS.wfTrainInAppRow)rows[0];
                lblCosCode.Text = rti.sCourseCode;
                lblYYMM.Text = rti.sYYMM;
                lblSer.Text = rti.sSer;
                lblEXPECT.Text = rti.sReserve1.Replace("\n", "<BR>");
                lblSign.Text = Convert.ToInt32(rti.sConditions2) > 0 ? "不參加" : "參加";
                lblEXPECTt.Text = Convert.ToInt32(rti.sConditions2) > 0 ? "不參加的理由：" : lblEXPECTt.Text;

                rblCheck.Items.FindByValue((rti.bSign) ? "1" : "0").Selected = true;
            }
        }
    }

    protected void dlTrtcr_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName == "TcrData")   //講師資料
        {
            string link = "MyFrame.aspx?url=" + CommandName + ".aspx?key=" + CommandArgument;
            string script = "var sFeatures = 'dialogWidth:600px;dialogHeight:100px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = " + form1.ID + ";" +
                "window.showModalDialog('" + link + "', obj, sFeatures);";
            //ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), CommandName, script, true);
        }
    }

    protected void GV_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lblDateTimeB, lblDateTimeE, lblTcrName;
        lblDateTimeB = (Label)e.Row.FindControl("lblDateTimeB");
        lblDateTimeE = (Label)e.Row.FindControl("lblDateTimeE");
        lblTcrName = (Label)e.Row.FindControl("lblTcrName");

        LinkButton lbtnCosData = (LinkButton)e.Row.FindControl("lbtnCosData");

        if (lblDateTimeB != null)
        {
            string sCosCode, sSer, sYYMM;
            sCosCode = lblCosCode.Text;
            sSer = lblSer.Text;
            sYYMM = lblYYMM.Text;

            rows = oTrainDS.TRCOS.Select("COSCODE = '" + sCosCode + "' AND SER = '" + sSer + "' AND YYMM = '" + sYYMM + "'");
            if (rows.Length > 0)
            {
                TrainDS.TRCOSRow rtc = (TrainDS.TRCOSRow)rows[0];
                lblDateTimeB.Text = rtc.COSDATEB.ToShortDateString() + " " + rtc.COSTIMEB.Trim();
                lblDateTimeE.Text = rtc.COSDATEE.ToShortDateString() + " " + rtc.COSTIMEE.Trim();
                lblTcrName.Text = sCosCode + sYYMM + sSer;
                lbtnCosData.CommandArgument = sCosCode + sYYMM + sSer;
            }
        }
    }

    protected void GV_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName == "CosData")   //詳細資料
        {
            string link = "MyFrame.aspx?url=" + CommandName + ".aspx?key=" + CommandArgument;
            string script = "var sFeatures = 'dialogWidth:600px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = " + form1.ID + ";" +
                "window.showModalDialog('" + link + "', obj, sFeatures);";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), CommandName, script, true);
        }
    }

    protected void btnSign_Click(object sender, EventArgs e)
    {
        wfTrainInAppTA.FillByProcessID(oTrainDS.wfTrainInApp, lblProcessID.Text);
        wfSignTA.Fill(oFlowDS.wfSign);

        if (oTrainDS.wfTrainInApp.Rows.Count == 0)
        {
            lblMsg.Text = "找不到重要的簽核資料，請洽管理人員";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseData = new HrBaseData(lblNobr.Text);

        string iCateOrder = oHrBaseData.iCateOrder.ToString();
        FlowDSTableAdapters.ProcessCheckTableAdapter ProcessCheckTA = new FlowDSTableAdapters.ProcessCheckTableAdapter();
        rows = ProcessCheckTA.GetData(int.Parse(lblProcessID.Text), lblNobr.Text).Select();
        if (rows.Length > 0)
        {
            FlowDS.ProcessCheckRow rb = (FlowDS.ProcessCheckRow)rows[0];
            HrDSTableAdapters.DEPTATableAdapter DEPTATA = new HrDSTableAdapters.DEPTATableAdapter();
            rows = DEPTATA.GetData().Select("D_NO = '" + rb.Dept_id + "'");
            if (rows.Length > 0)
            {
                HrDS.DEPTARow rd = (HrDS.DEPTARow)rows[0];
                iCateOrder = rd.DEPT_TREE.ToString();
            }
        }

        TrainDS.wfTrainInAppRow rm = (TrainDS.wfTrainInAppRow)oTrainDS.wfTrainInApp.Rows[0];
        rm.sNote = txtNote.Text;
        rm.bSign = rblCheck.SelectedItem.Value == "1";
        rm.sConditions1 = iCateOrder;
        rm.sState = (!rm.bSign) ? "2" : rm.sState;
        rm.dDateD = DateTime.Now;

        FlowDS.wfSignRow rn = oFlowDS.wfSign.NewwfSignRow();
        rn.sFromCode = "TrainIn";
        rn.sFromName = "內訓單";
        rn.sProcessID = lblProcessID.Text;
        rn.idProcess = int.Parse(rn.sProcessID);
        rn.sNobr = oHrBaseData.sNobr;
        rn.sName = oHrBaseData.sName;
        rn.sDept = oHrBaseData.sDept;
        rn.sDeptName = oHrBaseData.sDeptName;
        rn.sNote = rm.sNote;
        rn.bSign = rm.bSign;
        rn.dKeyDate = rm.dDateD;
        oFlowDS.wfSign.AddwfSignRow(rn);

        wfTrainInAppTA.Update(oTrainDS.wfTrainInApp);

        localhost.Service oService = new localhost.Service();

        if (!oService.WorkFinish(Convert.ToInt32(Request["ApParm"])))
        {
            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "AlertMsg", "alert('流程發生問題，您核准的動作可能無法完成。');self.close();", true);
        }
        else
        {
            wfSignTA.Update(oFlowDS.wfSign);

            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "OKMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "OKMsg", "self.location='../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "'", true);
        }
    }
}