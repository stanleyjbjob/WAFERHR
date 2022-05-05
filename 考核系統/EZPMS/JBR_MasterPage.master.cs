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

public partial class JBR_MasterPage : System.Web.UI.MasterPage
{
    protected string deptm = "";
    protected void Page_Load(object sender, EventArgs e) {
        try
        {
            if (Request.QueryString["nobr"] != null)
            {
                Session["nobr"] = Request.QueryString["nobr"].ToString();
                ViewState["nobr"] = Request.QueryString["nobr"].ToString();
                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(Request.QueryString["nobr"].ToString(), DateTime.Now.ToShortDateString());
                Session.Add("empInfo", emprow);
            }
            else
            {

                if (!IsPostBack)
                {
                    if (Session["nobr"] != null)
                    {
                        ViewState["nobr"] = Session["nobr"].ToString();
                    }
                }


                if (Session["nobr"] == null)
                {
                    Session.Add("nobr", ViewState["nobr"].ToString());
                    EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(ViewState["nobr"].ToString(), DateTime.Now.ToShortDateString());
                    Session.Add("empInfo", emprow);
                }


                if (Session["empInfo"] == null)
                {
                    Session.Add("nobr", ViewState["nobr"].ToString());
                    EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(ViewState["nobr"].ToString(), DateTime.Now.ToShortDateString());
                    Session.Add("empInfo", emprow);
                }

            }

            EFFDS.EMPINFODataTableRow emprow1 = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            deptm = emprow1.DEPTM;
           
            if (emprow1.MANG)
            {
                //if (emprow1.MANGE) {
                //    mang.Items[4].Enabled = true;
                //    mang.Items[3].Enabled = true;
                //}
                //else {
                //    mang.Items[4].Enabled = false;
                //    mang.Items[3].Enabled = false;
                //}

                fieldset_mang.Visible = true;
                fieldset_empMenu.Visible = true;
                fieldset_adminMenu.Visible = false;
            }
            else
            {
                fieldset_mang.Visible = false;
                fieldset_empMenu.Visible = true;
                fieldset_adminMenu.Visible = false;
            }

            if (DataClass.IsAdmin(emprow1.NOBR.Trim()))
            {
                fieldset_adminMenu.Visible = true;

            }
        }
        catch
        {

            Response.Redirect(Page.Server.MapPath(".") + "/login.aspx");
        }
    }
}
