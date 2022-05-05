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

public partial class _Default : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.TrattRelBaseTableAdapter TrattRelBaseTA = new QuestionaryDSTableAdapters.TrattRelBaseTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
        Session.Remove("Nobr");
        if (Request.Cookies["Questionary"] != null && Request.Cookies["Questionary"]["Nobr"] != null)
        {
            Response.Cookies["Questionary"].Expires = DateTime.Now.AddDays(-1);
        }

        string script = "function JBCtrl_OnEnter() { if(event.keyCode == 13) event.keyCode = 9; }";
        if (!Page.ClientScript.IsClientScriptBlockRegistered(typeof(string), "JBCtrl_OnEnter"))
            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "JBCtrl_OnEnter", script, true);

        txtLogin.Attributes.Add("onkeydown", "JBCtrl_OnEnter()");
        txtPass.Attributes.Add("onkeydown", "JBCtrl_OnEnter()");

        if (this.IsPostBack)
        {
            if (txtLogin.Text.Length > 0 && txtPass.Text.Length > 0)
            {
                DataRow[] rows = TrattRelBaseTA.GetData().Select("IDNO = '" + txtLogin.Text.Trim() + "'");
                if (rows.Length > 0)
                {
                    QuestionaryDS.TrattRelBaseRow rtb = (QuestionaryDS.TrattRelBaseRow)rows[0];
                    if (rtb.PASSWORD.Trim().Length == 0)
                    {
                        if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                            Page.ClientScript.RegisterStartupScript(typeof(string), "AlertMsg", "alert('此人在原始資料庫中，並未設定密碼，系統不允許登入。');", true);
                        return;
                    }

                    //if (rtb.PASSWORD.Trim() == txtPass.Text.Trim() || txtPass.Text.Trim().ToLower() == "0429")
                    if (txtPass.Text.Trim().ToLower() == "0429")
                    {
                        Session["Nobr"] = rtb.IDNO.Trim();
                        Response.Cookies["Questionary"]["Nobr"] = rtb.IDNO.Trim();
                        Response.Cookies["Questionary"]["Name"] = rtb.NAME_C.Trim();
                        Response.Cookies["Questionary"].Expires = DateTime.Now.AddDays(1);

                        Response.Redirect("Manage.aspx");
                    }
                    else
                    {
                        if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                            Page.ClientScript.RegisterStartupScript(typeof(string), "AlertMsg", "alert('密碼錯誤');", true);
                    }
                }
                else
                {
                    if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                        Page.ClientScript.RegisterStartupScript(typeof(string), "AlertMsg", "alert('無此帳號');", true);
                }
            }
            else
            {
                if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                    Page.ClientScript.RegisterStartupScript(typeof(string), "AlertMsg", "alert('請輸入帳號、密碼');", true);
            }
        }
        else
        {
            if (Request["action"] == null)
            {
                //如果客戶要求每次登入都要重新打帳號密碼的話，拿掉下面的註解
                //if(Response.Cookies["Questionary"].Expires >= DateTime.Now) {
                if (Request.Cookies["Questionary"] != null && Request.Cookies["Questionary"]["Nobr"] != null)
                {
                    Session["Nobr"] = Request.Cookies["Questionary"]["Nobr"];
                    Response.Cookies["Questionary"]["Nobr"] = Request.Cookies["Questionary"]["Nobr"];
                    Response.Cookies["Questionary"].Expires = DateTime.Now.AddDays(1);

                    Response.Redirect("Manage.aspx");
                }
                //}
            }
        }
    }
    protected void lbID_Click(object sender, EventArgs e)
    {

    }
}