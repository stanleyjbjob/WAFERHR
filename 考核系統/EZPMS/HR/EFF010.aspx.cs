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

public partial class HR_EFF010 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        MultiView1.ActiveViewIndex = int.Parse(e.Item.Value);
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
       GridView1.DataBind();
    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void FormView2_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView2.DataBind();
    }
    protected void FormView2_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView2.DataBind();
    }
}
