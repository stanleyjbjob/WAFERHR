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

public partial class Mang_EFF001 : System.Web.UI.Page
{
    public new void RegisterOnSubmitStatement(string key, string script)
    {
        ScriptManager.RegisterOnSubmitStatement(this, typeof(Page), key, script);
    }

    [Obsolete]
    public override void RegisterStartupScript(string key, string script)
    {
        string newScript = script.Replace("FTB_AddEvent(window,'load',function () {", "").Replace("});", "");
        ScriptManager.RegisterStartupScript(this, typeof(Page), key, newScript, false);
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack) {
            Page.ClientScript.RegisterClientScriptInclude("FTB-FreeTextBox", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-FreeTextBox.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Utility", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Utility.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Toolbars", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ToolbarItems.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-ImageGallery", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ImageGallery.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Pro", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Pro.js"));

            if (Session["empInfo"] != null) 
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                DataClass dc = new DataClass();
                mang_nobr.Text = row.NOBR;
                EFFDS.EMPINFODataTableDataTable empdt = dc.getDeptMChildEmpInfo(row.DEPTM,row.NOBR,DateTime.Now.ToShortDateString());
                GridView2.DataSource = empdt;
                GridView2.DataBind();
               
            }
            note.Text = DataClass.getNote("Mang.EFF001.aspx");
        }
    }
    void setValue(string nobr)
    {
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(nobr, DateTime.Now.ToShortDateString());
        if (emprow != null)
        {
            name_c.Text = emprow.NAME_C;
            lb_nobr.Text = emprow.NOBR;
            indt.Text = emprow.INDT.ToShortDateString();
            dept.Text = emprow.DEPTNAME;
            deps.Text = emprow.DEPTSNAME;
            job.Text = emprow.JOBNAME;
            jobl.Text = emprow.JOBLNAME;

        }
    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        setValue(GridView2.SelectedValue.ToString());
        MultiView1.ActiveViewIndex = 1;
      
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            e.Values["nobr"] = lb_nobr.Text;
            e.Values["mangname"] = mang_nobr.Text;
            e.Values["keydate"] = DateTime.Now;
        }
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["keydate"] = DateTime.Now;

    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView1.DataBind();
    }
    protected void FormView1_ModeChanged(object sender, EventArgs e)
    {

    }
    protected void FormView1_ModeChanging(object sender, FormViewModeEventArgs e)
    {

    }
}
