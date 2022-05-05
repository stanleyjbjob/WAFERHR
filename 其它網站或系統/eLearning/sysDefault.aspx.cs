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

using CustomSecurity;

public partial class sysDefault : System.Web.UI.Page
{
    private SysDSTableAdapters.sysDefaultTableAdapter sysDefaultTA = new SysDSTableAdapters.sysDefaultTableAdapter();
    
    private string UserID;

    protected void Page_Load(object sender, EventArgs e)
    {
        UserID = ((CustomIdentity)Context.User.Identity).Name;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        TextBox txtValue = e.Row.FindControl("txtValue") as TextBox;
        CheckBox cbValue = e.Row.FindControl("cbValue") as CheckBox;

        string[] txt = { "text", "password" };
        string[] cb = { "checkbox" };

        if (txtValue != null)
        {
            if (Array.IndexOf(txt, txtValue.ToolTip) >= 0)
            {
                if (txtValue.ToolTip == "password")
                {
                    if (gv.EditIndex == e.Row.DataItemIndex)
                        txtValue.TextMode = TextBoxMode.Password;
                    else
                        txtValue.Text = "******";
                }

                txtValue.Visible = true;
            }
            else if (Array.IndexOf(cb, txtValue.ToolTip) >= 0)
            {
                cbValue.Checked = (txtValue.Text == "True");
                cbValue.Visible = true;
            }
        }

        if (gv.EditIndex != -1)
        {
            Label lblNull = e.Row.FindControl("lblNull") as Label;
            Label lblTypeP = e.Row.FindControl("lblTypeP") as Label;
            RequiredFieldValidator rfvValue = e.Row.FindControl("rfvValue") as RequiredFieldValidator;
            AjaxControlToolkit.MaskedEditExtender meeValue = e.Row.FindControl("meeValue") as AjaxControlToolkit.MaskedEditExtender;
            AjaxControlToolkit.ValidatorCalloutExtender vceValue = e.Row.FindControl("vceValue") as AjaxControlToolkit.ValidatorCalloutExtender;

            if (lblTypeP != null)
            {
                rfvValue.Enabled = Convert.ToBoolean(lblNull.Text);
                vceValue.Enabled = Convert.ToBoolean(lblNull.Text);
                meeValue.Enabled = lblTypeP.Text == "Number";
            }
        }
    }

    protected void gv_RowUpdating(object sender, GridViewUpdateEventArgs e)
    {
        CheckBox cbValue = gv.Rows[e.RowIndex].FindControl("cbValue") as CheckBox;

        if (cbValue.Visible)
            e.NewValues["sValue"] = cbValue.Checked.ToString();

        e.NewValues["sKeyMan"] = UserID;
    }
}
