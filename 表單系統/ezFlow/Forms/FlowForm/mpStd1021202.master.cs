using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class mpStd1021202 : System.Web.UI.MasterPage
{
    public string sFormCode
    {
        get { return lblTitle.ToolTip; }
        set { lblTitle.ToolTip = value; }
    }

    public string sAppNobr
    {
        get { return lblNobrAppM.Text; }
        set { lblNobrAppM.Text = value; }
    }

    private dcFlowDataContext dcFlow = new dcFlowDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        RadScriptManager.RegisterClientScriptInclude(this, typeof(Page), this.GetType().ToString(), Page.ResolveUrl("~/js/MyTools.js"));

        SetDefault();
    }

    private void SetDefault()
    {
        var rForm = (from c in dcFlow.wfForm
                     where c.sFormCode == lblTitle.ToolTip
                     select c).FirstOrDefault();

        if (rForm != null)
        {
            lblTitle.Text = rForm.sFormName;
            //lblNote.Text = rForm.sStdNote;
        }
    }
    protected void btnReturn_Click(object sender, EventArgs e)
    {
        Response.Redirect(System.Web.Configuration.WebConfigurationManager.AppSettings["localhostDefault"]);
    }
    protected void btnReturn_Click1(object sender, EventArgs e)
    {
        Response.Redirect(System.Web.Configuration.WebConfigurationManager.AppSettings["localhostDefault"]);
    }
}
