﻿using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class HR_EFF016 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void FormView2_ItemInserted(object sender, FormViewInsertedEventArgs e) {
        GridView1.DataBind();
    }
    protected void FormView2_ItemUpdated(object sender, FormViewUpdatedEventArgs e) {
        GridView1.DataBind();
    }
}
