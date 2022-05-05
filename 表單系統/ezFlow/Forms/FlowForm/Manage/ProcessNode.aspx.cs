using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Transactions;

public partial class Manage_ProcessNode : System.Web.UI.Page
{
    dcFlowDataContext dcFlow = new dcFlowDataContext();
    dcFormDataContext dcForm = new dcFormDataContext();

    string _FormCode = "";

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
                            lblNobr.Text = dc["NobrM"];
                            lblViewUrl.Text = dc["ViewUrl"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();
                        }
                    }
                }
            }

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"].ToUpper() : lblNobr.Text;

            if (Request.Cookies["ezFlow"] != null && Request.Cookies["ezFlow"]["Emp_id"] != null)
                lblNobr.Text = Request.Cookies["ezFlow"]["Emp_id"];

            if (User.Identity.IsAuthenticated && User.Identity.Name.Trim().Length > 0)
                lblNobr.Text = User.Identity.Name;

            //判斷是否為管理者
            var rSysAdmin = (from c in dcFlow.SysAdmin
                             where c.Emp_id == lblNobr.Text
                             select c).FirstOrDefault();

            if (rSysAdmin == null)
            {
                btnSearch.Enabled = false;
                gvAppM.Visible = false;
            }

            var rSysVar = (from c in dcFlow.SysVar
                           select c).FirstOrDefault();

            if (rSysVar != null && lblViewUrl.Text.Length == 0)
                lblViewUrl.Text = rSysVar.urlRoot + "/Forms/";
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvAppM.Rebind();
    }

    protected void gvAppM_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        int ProcessID = 0;

        if (int.TryParse(txtProcessID.Text, out ProcessID))
        {
            ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);
            var Vdb = oService.GetProcessNodeList(ProcessID);

            gvAppM.DataSource = Vdb;
        }
    }

    protected void gvAppM_ItemDataBound(object sender, GridItemEventArgs e)
    {
        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            bool Multi = Convert.ToBoolean(item["Multi"].Text);

            var btnStart = e.Item.FindControl("btnStart") as RadButton;
        }
    }

    protected void gvAppM_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Start")
        {
            int id = Convert.ToInt32(ca);

            ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);
            oService.DeleteProcessNode(id);

            gvAppM.Rebind();

            RadWindowManager1.RadAlert("刪除完成", 300, 100, "警告訊息", "", "");
        }
        else if (cn == "SubProcessFlow")
        {
            int id = Convert.ToInt32(ca);

            //if (rFormMail != null)
            //    Dialog("EditMail", "", "", "", id.ToString(), txtFlowForm.SelectedValue);


        }
    }


    private void Dialog(string Case, string NobrM = "", string NobrS = "", string ProcessID = "", string Key1 = "", string Key2 = "")
    {
        string DialogPage = "";

        string ValidateKey = Guid.NewGuid().ToString();

        string sViewUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/Check.aspx";
        sViewUrl = "";

        string DialogParm = "NobrM=" + NobrM + "&NobrS=" + NobrS + "&ValidateKey=" + ValidateKey + "&ProcessID=" + ProcessID + "&Key1=" + Key1 + "&Key2=" + Key2 + "&FormCode=" + _FormCode + "&ViewUrl=" + sViewUrl + "&Std=1";
        string DialogParmDetail = "";

        switch (Case)
        {
            case "EditMail":
                DialogPage = "EditMail.aspx";
                break;
            default:
                break;
        }

        DialogParm = Bll.Tools.Decryption.Encrypt(DialogParm + DialogParmDetail);

        var r = new wfWebValidate();
        r.sValidateKey = ValidateKey;
        r.dDateWriter = DateTime.Now;
        r.sParm = DialogParm;
        dcFlow.wfWebValidate.InsertOnSubmit(r);
        dcFlow.SubmitChanges();

        RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "window.radopen('" + DialogPage + "?Parm=" + DialogParm + "', 'rwMT');", true);
    }




}