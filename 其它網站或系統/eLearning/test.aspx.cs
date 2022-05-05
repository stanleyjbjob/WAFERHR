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

public partial class test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        ltModalProgress.Text = "<script type='text/javascript' language='javascript'>var ModalProgress = '" + ModalProgress.ClientID + "';</script>";

        if (!this.IsPostBack)
        {

        }

        string a = Guid.NewGuid().ToString();

        Table Table1 = new Table();
        Table1.Width = 500;
        Table1.BorderWidth = 1;
        for (int i = 0; i < 2; i++)
        {
            TableRow newrow = new TableRow();
            for (int j = 0; j < 3; j++)
            {
                TableCell newcell = new TableCell();
                newcell.Text = i.ToString() + "," + j.ToString();
                newcell.Text = newcell.Text.Replace(",", "<BR>");
                newcell.HorizontalAlign = HorizontalAlign.Center;
                newrow.Cells.Add(newcell);
            }
            Table1.Rows.Add(newrow);
        }
        Page.Controls.Add(Table1);

    }
    protected void Button1_OnClick(object sender, EventArgs e)
    {
        //lblMessage.Text = string.Format("Thanks {0}, we'll give you a call at {1}.", NameTextBox.Text, PhoneNumberTextBox.Text);

    }
    protected void btnExitFV_Click(object sender, EventArgs e)
    {

    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        mpePopupFV.Show();
    }

    protected void Button1_Click(object sender, EventArgs e)
    {

    }
}