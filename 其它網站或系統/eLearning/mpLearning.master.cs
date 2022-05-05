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

public partial class mpLearning : System.Web.UI.MasterPage
{
    int RoleID;

    protected void Page_Load(object sender, EventArgs e)
    {
        ltModalProgress.Text = "<script type='text/javascript' language='javascript'>var ModalProgress = '" + ModalProgress.ClientID + "';</script>";

        if (Session["RoleID"] == null || Session["UserID"] == null)
        {
            Page.ClientScript.RegisterStartupScript(typeof(string), "key", "alert('您沒有權限，請重新進入');", true);
            Response.Redirect("Default.aspx");
            return;
        }

        RoleID = Convert.ToInt32(Session["RoleID"]);
        lbtnLearning.Visible = LoginCS.IsAuth(lbtnLearning.ToolTip, RoleID);
        lbtnManage.Visible = LoginCS.IsAuth(lbtnManage.ToolTip, RoleID);
        lbtnTest.Visible = LoginCS.IsAuth(lbtnTest.ToolTip, RoleID);
    }
}