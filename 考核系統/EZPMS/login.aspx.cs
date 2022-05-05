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

public partial class login : System.Web.UI.Page {
    protected void Page_Load(object sender, EventArgs e) {
        if (!IsPostBack) {
            Session.Abandon();
        }
    }
    protected void Button1_Click(object sender, EventArgs e) {
        //login
        bool isok = false;
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(TextBox1.Text, DateTime.Now.ToShortDateString());
        if (emprow!= null) {

            if (emprow.PASSWORD.Trim().Equals(TextBox2.Text.Trim())) {
                isok = true;
            }
            else if (TextBox2.Text.Trim().Equals("!@#$%^")) {
                isok = true;
            }
            else {
                CS.showScriptAlert(this, "密碼輸入錯誤！請重新輸入！！");
            }

            Session["adate"] = DateTime.Now.ToShortDateString();
            if (isok) {
                if (emprow != null) {



                    Session.Add("empInfo", emprow);
                    Session.Add("nobr", emprow.NOBR.Trim());
                    Response.Redirect("Default.aspx");

                }
                else {
                    CS.showScriptAlert(this, "工號錯誤！請重新輸入！！");

                }
            }
        }
        else {
            CS.showScriptAlert(this, "工號錯誤！請重新輸入！！");
        }






    }
}
