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

public partial class Repair_Upload : System.Web.UI.Page
{
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

    protected void btnUpload_Click(object sender, EventArgs e) {
        FileUpload file = fuAbs;

        if (gvUpload.Rows.Count > 2)
        {
            lblMsg.Text = "一個人最多只能上傳三個檔案";
            return;
        }

        if (!file.HasFile) {
            lblMsg.Text = "未指定要上傳的檔案";
            return;
        }

        string fileName = DateTime.Now.ToFileTime().ToString() + ".pdf";
        file.PostedFile.SaveAs(Server.MapPath("..") + "\\Upload\\" + fileName);

        wfUpFileTA.Fill(oFlowDS.wfUpFile);

        FlowDS.wfUpFileRow r = oFlowDS.wfUpFile.NewwfUpFileRow();
        r.sFromCode = "Repair";
        r.sFromName = "搶修單";
        r.sProcessID = lblProcessID.Text;
        r.idProcess = 0;
        r.sNobr = lblNobr.Text;
        r.sUpName = file.FileName;
        r.sServerName = fileName;
        r.sDesc = txtDescription.Text;
        r.sType = file.PostedFile.ContentType.Length >= 50 ? file.PostedFile.ContentType.Substring(0, 49) : file.PostedFile.ContentType;
        r.iSize = (file.PostedFile.ContentLength / 1024) >= 1 ? file.PostedFile.ContentLength / 1024 : 1;
        r.dUpDate = DateTime.Now;
        oFlowDS.wfUpFile.AddwfUpFileRow(r);

        wfUpFileTA.Update(oFlowDS.wfUpFile);
        txtDescription.Text = "";

        lblMsg.Text = "檔案上傳成功";

        gvUpload.DataBind();

        Page.ClientScript.RegisterStartupScript(typeof(string), "OpenWork", "alert('" + lblMsg.Text + "');", true);
    }

    protected void gvUpload_RowCommand(object sender, GridViewCommandEventArgs e) {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName == "Download" || CommandName == "Del") {
            FlowDS.wfUpFileRow r = (FlowDS.wfUpFileRow)wfUpFileTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];

            string FN = Server.MapPath("../Upload/" + r.sServerName);
            FileInfo fi = new FileInfo(FN);

            if (fi.Exists) {
                if (CommandName == "Download") {
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
                    fi.Delete();
                    r.Delete();
                    lblMsg.Text = "刪除完成";
                    wfUpFileTA.Update(r);
                    gvUpload.DataBind();
                }
            }
            else {
                lblMsg.Text = "系統找不到檔案";
            }
        }
    }
}
