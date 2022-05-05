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

public partial class TrainIn_CosData : System.Web.UI.Page
{
    public FlowDSTableAdapters.wfUpFileTableAdapter wfUpFileTA = new FlowDSTableAdapters.wfUpFileTableAdapter();
    public TrainDSTableAdapters.TRCOSTableAdapter TRCOSTA = new TrainDSTableAdapters.TRCOSTableAdapter();

    public FlowDS oFlowDS;
    public TrainDS oTrainDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        oFlowDS = new FlowDS();
        oTrainDS = new TrainDS();

        if (!this.IsPostBack)
        {
            lblProcessID.Text = Request["key"];

            TRCOSTA.FillByKey(oTrainDS.TRCOS, lblProcessID.Text);
            if (oTrainDS.TRCOS.Rows.Count > 0)
            {
                TrainDS.TRCOSRow rtc = (TrainDS.TRCOSRow)oTrainDS.TRCOS.Rows[0];
                lblCosName.Text = rtc.DESCR.Trim().Replace("\n", "<BR>");
                lblTR_PERSON.Text = !rtc.IsTR_PERSONNull() && rtc.TR_PERSON.Trim().Length > 0 ? rtc.TR_PERSON.Trim().Replace("\n", "<BR>") : lblTR_PERSON.Text;
                lblCOSINTRO.Text = !rtc.IsCOSINTRONull() && rtc.COSINTRO.Trim().Length > 0 ? rtc.COSINTRO.Trim().Replace("\n", "<BR>") : lblCOSINTRO.Text;
                lblMENO.Text = !rtc.IsMENONull() && rtc.MENO.Trim().Length > 0 ? rtc.MENO.Trim().Replace("\n", "<BR>") : lblMENO.Text;
            }
        }

        lblMsg.Text = "";
    }

    protected void gvUpload_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName == "Download")
        {
            FlowDS.wfUpFileRow r = (FlowDS.wfUpFileRow)wfUpFileTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];

            string FN = Server.MapPath("../Upload/" + r.sServerName);
            FileInfo fi = new FileInfo(FN);

            if (fi.Exists)
            {
                if (CommandName == "Download")
                {
                    Response.ClearHeaders();
                    Response.Clear();
                    Response.AddHeader("Accept-Language", "zh-tw");
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(r.sUpName, System.Text.Encoding.UTF8));

                    Response.AddHeader("Content-Length", fi.Length.ToString());
                    Response.ContentType = "application/octet-stream";
                    Response.WriteFile(fi.FullName);
                    Response.Flush();
                    Response.End();
                }
            }
            else
            {
                lblMsg.Text = "系統找不到檔案";
            }
        }
    }
}