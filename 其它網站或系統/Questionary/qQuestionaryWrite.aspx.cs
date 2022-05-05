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

public partial class qQuestionaryWrite : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblNobr.Text = Request.Cookies["Questionary"]["Nobr"];
        lblName.Text = Request.Cookies["Questionary"]["Name"];
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Write")
        {
            string link = "MyFrame.aspx?url=qQuestionaryView.aspx?Code=" + e.CommandArgument.ToString();
            string script = "var sFeatures = 'dialogWidth:880px;dialogHeight:800px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = aspnetForm;" +
                "window.showModalDialog('" + link + "', obj, sFeatures);";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
        }
    }
}
