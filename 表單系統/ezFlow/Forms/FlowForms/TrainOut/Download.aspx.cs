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

public partial class TrainOut_Download : System.Web.UI.Page {
    public FlowDSTableAdapters.wfUpFileTableAdapter wfUpFileTA = new FlowDSTableAdapters.wfUpFileTableAdapter();
    public FlowDS oFlowDS;

    protected void Page_Load(object sender, EventArgs e) {
        oFlowDS = new FlowDS();

        if (!this.IsPostBack) {
            lblNobr.Text = Request["nobr"];
            lblProcessID.Text = Request["id"];
        }

        lblMsg.Text = "";
    }

    protected void gvUpload_RowCommand(object sender, GridViewCommandEventArgs e) {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName == "Download") {
            FlowDS.wfUpFileRow r = (FlowDS.wfUpFileRow)wfUpFileTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];

            string FN = Server.MapPath("../Upload/" + r.sServerName);
            FileInfo fi = new FileInfo(FN);

            if (fi.Exists) {
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
            else {
                lblMsg.Text = "系統找不到檔案";
            }
        }
    }
}
