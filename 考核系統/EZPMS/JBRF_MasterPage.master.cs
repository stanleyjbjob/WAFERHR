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

public partial class JBRF_MasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            if (Session["nobr"] != null) {
                ViewState["nobr"] = Session["nobr"].ToString();
            }
        }


        if (Session["nobr"] == null){
            try
            {
                Session.Add("nobr", ViewState["nobr"].ToString());
                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(ViewState["nobr"].ToString(), DateTime.Now.ToShortDateString());
                Session.Add("empInfo", emprow);
            }
            catch
            {
                Response.Redirect("http://172.20.1.151/ez-portal/Default.aspx");
            }
        }


        if (Session["empInfo"] == null) {
            Session.Add("nobr", ViewState["nobr"].ToString());
            EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(ViewState["nobr"].ToString(), DateTime.Now.ToShortDateString());
            Session.Add("empInfo", emprow);
        }
    }
}
