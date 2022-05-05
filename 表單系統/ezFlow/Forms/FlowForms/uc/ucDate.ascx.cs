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

public partial class Abs_ucDate : System.Web.UI.UserControl {

    public TextBox txtNobr = new TextBox();
    public CheckBox cbColor = new CheckBox();
    public DataRow[] rows;
    protected void Page_Load(object sender, EventArgs e) {
        txtNobr.Text = "020227";
        cbColor.Checked = true;
    }

    protected void ibtnDate_Click(object sender, ImageClickEventArgs e) {
        cDate.Visible = !cDate.Visible;

        DateTime dateB, dateE;
        dateB = new DateTime(DateTime.Now.Year, 1, 1);
        dateE = new DateTime(DateTime.Now.Year, 12, DateTime.DaysInMonth(DateTime.Now.Year, 12));
    }

    protected void cDate_SelectionChanged(object sender, EventArgs e) {
        cDate.Visible = false;
        txtDate.Text = cDate.SelectedDate.ToShortDateString();
    }

    protected void cDate_DayRender(object sender, DayRenderEventArgs e) {
        string html = "";
        string tr = "";

   
    }
}
