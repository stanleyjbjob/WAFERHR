using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Transactions;

public partial class MT_FormMail : System.Web.UI.Page
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
                //btnAdd.Enabled = false;
                //gvAppM.Visible = false;
            }

            SetFlowFromData();

            var rSysVar = (from c in dcFlow.SysVar
                           select c).FirstOrDefault();

            if (rSysVar != null && lblViewUrl.Text.Length == 0)
                lblViewUrl.Text = rSysVar.urlRoot + "/Forms/";
        }
    }

    private void SetFlowFromData()
    {
        var rsForm = (from c in dcFlow.wfForm
                      where c.s5 != "0"
                      orderby c.s5
                      select new
                      {
                          Code = c.sFormCode,
                          Name = c.sFormName,
                      }).ToList();

        txtFlowForm.DataSource = rsForm;
        txtFlowForm.DataTextField = "Name";
        txtFlowForm.DataValueField = "Code";
        txtFlowForm.DataBind();
    }

    protected void gvAppM_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "EditMail")
        {
            int id = Convert.ToInt32(ca);

            var rFormMail = (from c in dcFlow.wfFormMail
                             where c.iAutoKey == id
                             select c).FirstOrDefault();

            if (rFormMail != null)
                Dialog("EditMail", "", "", "", id.ToString() , txtFlowForm.SelectedValue);
        }
        else if (cn == "Del")
        {
            int id = Convert.ToInt32(ca);

            var rFormMail = (from c in dcFlow.wfFormMail
                             where c.iAutoKey == id
                             select c).FirstOrDefault();

            if (rFormMail != null)
            {
                dcFlow.wfFormMail.DeleteOnSubmit(rFormMail);
                dcFlow.SubmitChanges();
                gvAppM.DataBind();
            }
        }
    }
    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string FlowFormCode = txtFlowForm.SelectedValue;
        string Code = txtCode.Text;
        string Name = txtName.Text;

        if (Code.Trim().Length == 0)
        {
            RadWindowManager1.RadAlert("代碼不可以是空白", 300, 100, "警告訊息", "", "");
            return;
        }

        var rFormMail = (from c in dcFlow.wfFormMail
                         where c.sFormCode == FlowFormCode
                         && c.sCode == Code
                         select c).FirstOrDefault();

        if (rFormMail != null)
        {
            RadWindowManager1.RadAlert("你所輸入的代碼已經重複", 300, 100, "警告訊息", "", "");
            return;
        }

        rFormMail = new wfFormMail();
        rFormMail.sFormCode = FlowFormCode;
        rFormMail.sCode = Code;
        rFormMail.sName = txtName.Text;
        rFormMail.sSubject = "";
        rFormMail.sBody = "";
        rFormMail.sKeyMan = lblNobr.Text;
        rFormMail.dKeyDate = DateTime.Now;
        dcFlow.wfFormMail.InsertOnSubmit(rFormMail);
        dcFlow.SubmitChanges();

        gvAppM.DataBind();
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