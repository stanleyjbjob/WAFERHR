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

public partial class Card_TransCard : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnTest_Click(object sender, EventArgs e)
    {
        DateTime dateA, dateB;
        dateA = DateTime.Now;
        TransCardWS oTransCardWS = new TransCardWS();
        oTransCardWS.AttCardEnd(txtNobr.Text, Convert.ToDateTime(txtDate.Text), "JouMing", true, true, true);
        dateB = DateTime.Now;

        TimeSpan ts = dateB - dateA;
        lblTime.Text = ts.TotalSeconds.ToString();
    }
}
