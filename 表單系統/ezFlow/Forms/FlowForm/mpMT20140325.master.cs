using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class mpMT20140325 : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {
        RadScriptManager.RegisterClientScriptInclude(this, typeof(Page), this.GetType().ToString(), Page.ResolveUrl("~/js/MyTools.js"));
    }
}
