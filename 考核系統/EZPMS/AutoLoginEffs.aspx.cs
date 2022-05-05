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

public partial class AutoLoginEffs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

        if (Request.QueryString["UDI"] == null)
            return;

        string nobr = Request.QueryString["UDI"].ToString();


        bool isok = true;
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(nobr, DateTime.Now.ToShortDateString());
        if (emprow != null)
        {
          
            

            Session["adate"] = DateTime.Now.ToShortDateString();
            if (isok)
            {
                if (emprow != null)
                {



                    Session.Add("empInfo", emprow);
                    Session.Add("nobr", emprow.NOBR.Trim());
                    Response.Redirect("Default.aspx");

                }
                else
                {
                    Response.Redirect("login.aspx");

                }
            }
        }
        else
        {
            Response.Redirect("login.aspx");
        }


    }
}
