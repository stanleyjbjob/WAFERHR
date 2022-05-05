using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;

public partial class MT_Upload : System.Web.UI.Page
{
    private dcFlowDataContext dcFlow = new dcFlowDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            if (Request.QueryString["Parm"] != null)
            {
                string RequestQueryString = Bll.Tools.Decryption.Decrypt(Request.QueryString["Parm"]);
                var dc = Bll.Tools.DataTrans.QueryStringToDictionary(RequestQueryString);

                if (dc.ContainsKey("ValidateKey"))
                {
                    string sValidateKey = dc["ValidateKey"];

                    DateTime Date = DateTime.Now;

                    var r = (from c in dcFlow.wfWebValidate
                             where c.sValidateKey == sValidateKey
                             select c).FirstOrDefault();

                    if (r != null)
                    {
                        if (r.dDateWriter >= DateTime.Now.AddMinutes(-1))
                        {
                            lblFormCode.Text = dc["FormCode"];
                            lblNobrM.Text = dc["NobrM"];
                            lblNobrS.Text = dc["NobrS"];
                            lblKey1.Text = dc["Key1"];
                            lblProcessID.Text = dc["ProcessID"];
                            lblStd.Text = dc["Std"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();

                            plUpload.Visible = lblStd.Text == "1";
                        }
                    }
                }
            }
        }
    }

    protected void gvFiles_ItemCommand(object sender, GridCommandEventArgs e)
    {
        lblFileMsg.Text = "";

        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Download" || cn == "Del")
        {
            var r = (from c in dcFlow.wfFormUploadFile
                     where c.iAutoKey == Convert.ToInt32(ca)
                     select c).FirstOrDefault();

            if (r != null)
            {
                string FN = Server.MapPath("~/Upload/" + r.sServerName);
                FileInfo fi = new FileInfo(FN);

                if (fi.Exists)
                {
                    if (cn == "Download")
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
                    else
                    {
                        fi.Delete();
                        dcFlow.wfFormUploadFile.DeleteOnSubmit(r);
                        dcFlow.SubmitChanges();
                        lblFileMsg.Text = "刪除完成";
                        gvFiles.DataBind();
                    }
                }
                else
                {
                    lblFileMsg.Text = "系統找不到檔案";
                }
            }
        }
    }

    protected void gvFiles_ItemDataBound(object sender, GridItemEventArgs e)
    {
        //Button btnDownload = e.Item.FindControl("btnDownload") as Button;
        //if (btnDownload != null)
        //    ScriptManager.GetCurrent(this).RegisterPostBackControl(btnDownload);

        RadButton btnDelete = e.Item.FindControl("btnDelete") as RadButton;
        if (btnDelete != null)
            btnDelete.Visible = lblStd.Text == "1";
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        if (fu.UploadedFiles.Count == 0)
        {
            lblFileMsg.Text = "沒有選擇上傳任何檔案";
            return;
        }

        foreach (UploadedFile f in fu.UploadedFiles)
        {
            string ServerName = Guid.NewGuid().ToString();

            var rf = new wfFormUploadFile();
            rf.sFormCode = lblFormCode.Text;
            rf.sFormName = "";
            rf.sProcessID = lblProcessID.Text;
            rf.idProcess = 0;
            rf.sNobr ="";
            rf.sKey = lblKey1.Text;
            rf.sUpName = f.FileName;
            rf.sServerName = ServerName;
            rf.sDescription = txtDescription.Text;
            rf.sType = f.ContentType == null ? "" : f.ContentType;
            rf.iSize =Convert.ToInt32( f.ContentLength / 1024);
            rf.dKeyDate = DateTime.Now;
            dcFlow.wfFormUploadFile.InsertOnSubmit(rf);
            dcFlow.SubmitChanges();

            string path = Server.MapPath("~/Upload/");
            f.SaveAs(path + ServerName, true);
        }

        lblFileMsg.Text = "上傳完成";

        gvFiles.DataBind();
    }
}