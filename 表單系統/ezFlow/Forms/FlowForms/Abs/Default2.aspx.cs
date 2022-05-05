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

public partial class Abs_Default2 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        GridView1.DataSource = new JbHrCL.AbsCS().GetAbsPersonal("880162", Convert.ToDateTime("2009/7/28"), Convert.ToDateTime("2008/1/1"), Convert.ToDateTime("2009/7/28"), "3", "4");
        GridView1.DataBind();
    }
}
