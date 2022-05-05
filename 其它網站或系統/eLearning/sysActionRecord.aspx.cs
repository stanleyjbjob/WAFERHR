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

public partial class sysActionRecord : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        Label lblRecord = (Label)e.Row.FindControl("lblRecord");
        if (lblRecord != null)
        {
            lblRecord.Text = lblRecord.Text.Replace("[Old", "<br>[Old");
        }
    }
}
