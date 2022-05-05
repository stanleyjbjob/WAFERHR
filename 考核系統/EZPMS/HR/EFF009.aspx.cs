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

public partial class HR_EFF009 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["keydate"] = DateTime.Now;
        RadioButtonList rb = (RadioButtonList)FormView1.FindControl("efftype");
        e.Values["type"] = rb.SelectedValue;
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["keydate"] = DateTime.Now;
        RadioButtonList rb = (RadioButtonList)FormView1.FindControl("efftype");
        e.NewValues["type"] = rb.SelectedValue;
    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void FormView1_DataBinding(object sender, EventArgs e)
    {
        
    }
    protected void FormView1_DataBound(object sender, EventArgs e)
    {
        Label lbytpe = (Label)FormView1.FindControl("lb_efftype");
        RadioButtonList rb = (RadioButtonList)FormView1.FindControl("efftype");
        if (lbytpe != null)
        {

                rb.SelectedValue = lbytpe.Text;
           
        }
    }
}
