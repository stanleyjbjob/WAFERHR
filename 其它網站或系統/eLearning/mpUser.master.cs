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
using System.Threading;

using CustomSecurity;

public partial class mpUser : System.Web.UI.MasterPage
{
    private SysDSTableAdapters.sysCustomerDataTableAdapter sysCustomerDataTA = new SysDSTableAdapters.sysCustomerDataTableAdapter();

    private int RoleID;

    public string Msg
    {
        get { return lblMsg.Text; }
        set { lblMsg.Text = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        //string str1 = ((CustomIdentity)Thread.CurrentPrincipal.Identity).UserFullName;
        //role.Text = Thread.CurrentPrincipal.IsInRole("Administrator").ToString();

        ltModalProgress.Text = "<script type='text/javascript' language='javascript'>var ModalProgress = '" + ModalProgress.ClientID + "';</script>";

        lblUserName.Text = ((CustomIdentity)Context.User.Identity).UserFullName;
        Session.Remove("SelectedNode");

        RoleID = Convert.ToInt32(((CustomIdentity)Context.User.Identity).UserRole);
        lbtnLearning.Visible = LoginCS.IsAuth(lbtnLearning.ToolTip, RoleID);
        lbtnManage.Visible = LoginCS.IsAuth(lbtnManage.ToolTip, RoleID);
        lbtnTest.Visible = LoginCS.IsAuth(lbtnTest.ToolTip, RoleID);

        this.Page.Title = LoginCS.GetPageTitle(Request.Path.Substring(Request.Path.LastIndexOf("/") + 1, (Request.Path.Length - (Request.Path.LastIndexOf("/") + 1))));
    }
}