using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Ot_OtInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            lblNobr.Text = Request["nobr"];

            DateTime dDate = DateTime.Now.Date;

            lblDateB.Text = new DateTime(dDate.Year, 1, 1).ToShortDateString();
            lblDateD.Text = new DateTime(dDate.Year, 12, 31).ToShortDateString();

            gv.DataBind();
        }
    }
}
