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

public partial class TrainIn_Std : System.Web.UI.Page
{
    public TrainDSTableAdapters.TRCOSTableAdapter TRCOSTA = new TrainDSTableAdapters.TRCOSTableAdapter();
    public TrainDSTableAdapters.TRATTTableAdapter TRATTTA = new TrainDSTableAdapters.TRATTTableAdapter();

    public TrainDSTableAdapters.wfTrainInAppTableAdapter wfTrainInAppTA = new TrainDSTableAdapters.wfTrainInAppTableAdapter();

    public TrainDS oTrainDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oTrainDS = new TrainDS();
        TRCOSTA.Fill(oTrainDS.TRCOS);
        wfTrainInAppTA.Fill(oTrainDS.wfTrainInApp);

        if (!this.IsPostBack)
            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
    }

    protected void GV_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lblDateTimeB, lblDateTimeE, lblTcrName, lblSign, lblEXPECT;
        lblDateTimeB = (Label)e.Row.FindControl("lblDateTimeB");
        lblDateTimeE = (Label)e.Row.FindControl("lblDateTimeE");
        lblTcrName = (Label)e.Row.FindControl("lblTcrName");
        lblSign = (Label)e.Row.FindControl("lblSign");
        lblEXPECT = (Label)e.Row.FindControl("lblEXPECT");

        LinkButton lbtnCosData, lbtnSign;
        lbtnCosData = (LinkButton)e.Row.FindControl("lbtnCosData");
        lbtnSign = (LinkButton)e.Row.FindControl("lbtnSign");

        Button btnY = (Button)e.Row.FindControl("btnY");

        if (lblDateTimeB != null)
        {
            string sCosCode, sSer, sYYMM;
            sCosCode = lblDateTimeB.Text.Trim();
            sSer = lblDateTimeE.Text.Trim();
            sYYMM = lblTcrName.Text.Trim();

            rows = oTrainDS.TRCOS.Select("COSCODE = '" + sCosCode + "' AND SER = '" + sSer + "' AND YYMM = '" + sYYMM + "'");
            if (rows.Length > 0)
            {
                TrainDS.TRCOSRow rtc = (TrainDS.TRCOSRow)rows[0];
                lblDateTimeB.Text = rtc.COSDATEB.ToShortDateString() + " " + rtc.COSTIMEB.Trim();
                lblDateTimeE.Text = rtc.COSDATEE.ToShortDateString() + " " + rtc.COSTIMEE.Trim();
                lblTcrName.Text = sCosCode + sYYMM + sSer;
                lbtnCosData.CommandArgument = sCosCode + sYYMM + sSer;
                lbtnSign.CommandArgument = sCosCode + sYYMM + sSer;
                btnY.CommandArgument = lbtnSign.CommandArgument;

                if (rtc.SIGNDATE_B.Date <= DateTime.Now.Date && DateTime.Now.Date <= rtc.SIGNDATE_E.Date)
                {
                    lbtnSign.CommandName = "Sign";
                    lbtnSign.Text = "我要報名";

                    //超過報名人數
                    if (TRATTTA.GetDataByKey(lbtnSign.CommandArgument).Rows.Count >= rtc.TR_CNT)
                    {
                        lbtnSign.CommandName = "Need";
                        lbtnSign.Text = "額滿";
                    }
                    else
                    {
                        rows = TRATTTA.GetDataByKey(lbtnSign.CommandArgument).Select("IDNO = '" + lblNobr.Text + "'");
                        if (rows.Length > 0)
                        {
                            lbtnSign.Text = "我要取消報名";
                            lblEXPECT.Text = "請輸入您不參加的理由";

                            TrainDS.TRATTRow rtt = (TrainDS.TRATTRow)rows[0];
                            if ((rtt.SELCODE.Trim() == "1"))
                            {
                                lbtnSign.CommandName = "Need";
                                lbtnSign.Text = "必修課程";
                            }
                        }
                    }

                    //簽核中
                    rows = oTrainDS.wfTrainInApp.Select("sCourseCode = '" + sCosCode + "' AND sSer = '" + sSer + "' AND sYYMM = '" + sYYMM + "' AND sNobr = '" + lblNobr.Text + "' AND sState = '1'");
                    if (rows.Length > 0)
                    {
                        lbtnSign.CommandName = "";
                        lbtnSign.Text = "簽核中";
                    }

                    btnY.CommandName = lbtnSign.CommandName;

                    lblSign.Text = lbtnSign.Text;
                    lbtnSign.Visible = (lbtnSign.CommandName == "Sign");
                    lblSign.Visible = (lbtnSign.CommandName != "Sign");

                    if (btnY.CommandName == "Sign")
                        btnY.OnClientClick = "return confirm('您確定「" + lbtnSign.Text + "」本課程嗎？(會上呈主管)');";
                    else if (btnY.CommandName == "Need")
                        btnY.OnClientClick = "alert('請洽人事單位取消此課程。');";
                    else
                        btnY.OnClientClick = "alert('主管正在簽核中。');";
                }
                else
                {
                    lbtnSign.Visible = false;
                    lblSign.Visible = true;
                }
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
        else if (CommandName == "Sign") //報名
        {
            TRCOSTA.FillByKey(oTrainDS.TRCOS, CommandArgument);
            TRATTTA.FillByKey(oTrainDS.TRATT, CommandArgument);

            GridViewRow row = (GridViewRow)(((Button)e.CommandSource).NamingContainer);
            TextBox txtEXPECT = (TextBox)row.FindControl("txtEXPECT");

            string HrMail = ConfigurationSettings.AppSettings["HrMail"];
            bool isPassAll = false; //是否有通過
            int iError = 0; //失敗筆數
            int iOK = 1;    //成功筆數
            string body = "";
            
            if (oTrainDS.TRCOS.Rows.Count > 0)
            {
                TrainDS.TRCOSRow rtc = (TrainDS.TRCOSRow)oTrainDS.TRCOS.Rows[0];

                rows = oTrainDS.TRATT.Select("IDNO = '" + lblNobr.Text + "'");

                if (rows.Length > 0)  //刪除報名資料
                {
                    rows[0].Delete();
                    lblMsg.Text = "取消報名成功，待主管核准";
                }
                else
                {
                    TrainDS.TRATTRow rtt = oTrainDS.TRATT.NewTRATTRow();
                    rtt.COSCODE = rtc.COSCODE.Trim();
                    rtt.YYMM = rtc.YYMM.Trim();
                    rtt.SER = rtc.SER.Trim();
                    rtt.IDNO = lblNobr.Text;
                    rtt.SELCODE = "2";
                    rtt.ATTHRS = 0;
                    rtt.ABSHRS = 0;
                    rtt.SCORE = 0;
                    rtt.COSCLOSE = false;
                    rtt.SHAREFEE = false;
                    rtt.ABS = false;
                    rtt.NOTE = "";
                    rtt.HOMEWORK = false;
                    rtt.KEY_DATE = DateTime.Now.Date;
                    rtt.KEY_MAN = "User";
                    rtt.FEE = 0;
                    rtt.ONLINESIGN = true;
                    rtt.EXPECT = txtEXPECT.Text;
                    rtt.TR_ASDATE = DateTime.Now.Date;	//這行要由參加寫入
                    rtt.LAT_NO = 0;
                    rtt.EAR_NO = 0;
                    oTrainDS.TRATT.AddTRATTRow(rtt);
                    lblMsg.Text = "報名成功，待主管核准";
                }
                
                //ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), CommandName, "alert('" + lblMsg.Text + "');", true);
                //TRCOSTA.Fill(oTrainDS.TRCOS);
                //GV.DataBind();

                HrBaseData oHrBaseData = new HrBaseData(lblNobr.Text);

                //流程開始傳簽
                localhost.Service oService = new localhost.Service();

                TrainDS.wfTrainInAppRow rti = oTrainDS.wfTrainInApp.NewwfTrainInAppRow();
                rti.idProcess = oService.GetProcessID();
                rti.sProcessID = rti.idProcess.ToString();
                rti.iCateOrder = oHrBaseData.iCateOrder;
                rti.bDelay = false;
                rti.dDateA = DateTime.Now;
                rti.bAuth = true;
                rti.bSign = true;
                rti.sCourseCode = rtc.COSCODE.Trim();
                rti.sYYMM = rtc.YYMM.Trim();
                rti.sSer = rtc.SER.Trim();
                rti.sNobr = lblNobr.Text;
                rti.sState = "1";
                rti.sReserve1 = txtEXPECT.Text;
                rti.sConditions1 = oHrBaseData.iCateOrder.ToString();
                rti.sConditions2 = rows.Length.ToString();
                oTrainDS.wfTrainInApp.AddwfTrainInAppRow(rti);

                try
                {
                    body = "[AppM];";
                    foreach (DataColumn dc in oTrainDS.wfTrainInApp.Columns)
                    {
                        if (rti[dc] != null)
                            body += dc.ToString() + "=" + rti[dc].ToString() + ";";
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
                    wfTrainInAppTA.Update(oTrainDS.wfTrainInApp);
                    FlowCS.SendMail(HrMail, "02;TrainIn;" + rti.idProcess.ToString() + ";", body);
                    lblMsg.Text = "流程傳送成功";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');close();", true);
                }
                else
                {
                    lblMsg.Text = iError > 0 ? "有部份流程傳送失敗" : "流程傳送成功";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                }

                //if (oService.FlowStart(rti.idProcess, Request["idFlowTree"], Request["idRole_Start"], Request["idEmp_Start"], Request["idRole_Start"], Request["idEmp_Start"]))
                //{
                //    //TRATTTA.Update(oTrainDS.TRATT);
                //    wfTrainInAppTA.Update(oTrainDS.wfTrainInApp);
                //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + rti.sProcessID + "';", true);
                //}
                //else
                //{
                //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('流程傳送失敗');", true);
                //}
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

    [System.Web.Services.WebMethodAttribute(), System.Web.Script.Services.ScriptMethodAttribute()]
    public static string GetDynamicContent(string contextKey)
    {
        return default(string);
    }
}