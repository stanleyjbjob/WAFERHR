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

public partial class HR_EFF006 : System.Web.UI.Page
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
    protected void FormView2_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView2.DataBind();

    }
    protected void FormView2_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView2.DataBind();

    }
    protected void FormView3_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView3.DataBind();

    }
    protected void FormView3_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView3.DataBind();

    }
    protected void FormView4_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView4.DataBind();

    }
    protected void FormView4_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView4.DataBind();

    }
    protected void FormView5_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView5.DataBind();

    }
    protected void FormView5_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView5.DataBind();

    }
    protected void FormView6_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView6.DataBind();
    }
    protected void FormView6_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView6.DataBind();
    }
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e) {
    }
    protected void GridView7_SelectedIndexChanged(object sender, EventArgs e) {
        lb_cate_id.Text = ((DropDownList)GridView7.SelectedRow.FindControl("DropDownList1effcateName")).SelectedValue;

    }
    protected void FormView7_ItemInserting(object sender, FormViewInsertEventArgs e) {
        e.Values["templetID"] = GridView1.SelectedValue;
       

    }
    protected void FormView7_ItemUpdating(object sender, FormViewUpdateEventArgs e) {
        e.NewValues["templetID"] = GridView1.SelectedValue;
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e) {

    }
    protected void FormView3_ItemInserting(object sender, FormViewInsertEventArgs e) {
        e.Values["templetID"] = GridView1.SelectedValue;
        e.Values["effsCateID"] = GridView7.SelectedValue;
        e.Values["typeID"] = "";
    }
    protected void FormView3_ItemUpdating(object sender, FormViewUpdateEventArgs e) {
        e.NewValues["templetID"] = GridView1.SelectedValue;
        e.NewValues["effsCateID"] = GridView7.SelectedValue;
        
        e.NewValues["typeID"] = "";
        
    }
}
