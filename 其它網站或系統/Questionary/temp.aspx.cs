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

public partial class temp : System.Web.UI.Page
{
    public string TypeCode, Nobr, PW;

    protected void Page_Load(object sender, EventArgs e)
    {
        TypeCode = Request.QueryString["TypeCode"];
        Nobr = Request.QueryString["Nobr"];
        PW = Request.QueryString["PW"];

        string link = "MyFrame.aspx?url=qWrite.aspx?Code=" + TypeCode + "&TypeCode=" + TypeCode + "&Nobr=" + Nobr + "&PW=" + PW;
        string script = "var sFeatures = 'dialogWidth:880px;dialogHeight:800px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = form1;" +
            "window.showModalDialog('" + link + "', obj, sFeatures);window.close();";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Write", script, true);
    }
}
