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

public partial class Abs_SignState : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack) {
            lblNobr.Text = Request["nobr"];
            lblEmpID.Text = lblNobr.Text;

            ddlName.DataBind();
            txtName_TextChanged(null, null);
        }
    }

    protected void ddlName_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblNobr.Text = ddlName.SelectedItem.Value;
        txtName.Text = ddlName.SelectedItem.Text;
    }

    protected void txtName_TextChanged(object sender, EventArgs e)
    {
        ListItem li, liA, liB;
        liA = ddlName.Items.FindByValue(txtName.Text) != null ? ddlName.Items.FindByValue(txtName.Text) : ddlName.Items.FindByText(txtName.Text);
        liB = ddlName.Items.FindByValue(lblNobr.Text) != null ? ddlName.Items.FindByValue(lblNobr.Text) : ddlName.Items.FindByText(lblNobr.Text);
        li = (liA != null) ? liA : liB;

        lblNobr.Text = "000000";
        txtName.Text = "";
        if (li != null)
        {
            lblNobr.Text = li.Value;
            txtName.Text = li.Text;

            ddlName.ClearSelection();
            li.Selected = true;
        }
    }

    protected void ddlName_DataBound(object sender, EventArgs e)
    {
        HrBaseData oHrBaseData = new HrBaseData(lblNobr.Text);
        if (!oHrBaseData.bMang)
        {
            DropDownList ddl = new DropDownList();

            foreach (ListItem li in ddlName.Items)
            {
                oHrBaseData = new HrBaseData(li.Value);
                if (oHrBaseData.bMang)
                    ddl.Items.Add(li);
            }

            foreach (ListItem li in ddl.Items)
                ddlName.Items.Remove(li);
        }
    }
}
