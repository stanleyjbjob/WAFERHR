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

public partial class EMP_EFF002_4 : System.Web.UI.Page
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

        if (!IsPostBack)
        {
            Page.ClientScript.RegisterClientScriptInclude("FTB-FreeTextBox", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-FreeTextBox.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Utility", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Utility.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Toolbars", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ToolbarItems.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-ImageGallery", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ImageGallery.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Pro", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Pro.js"));


            if (Session["EFFSInfo"] != null)
            {
                Hashtable ht = (Hashtable)Session["EFFSInfo"];
                EFFDS.EFFS_ATTENDRow attrow = (EFFDS.EFFS_ATTENDRow)ht["attend"];
                EFFDS.EFFS_BASERow baserow = (EFFDS.EFFS_BASERow)ht["base"];
                _yy.Text = attrow.yy.ToString();
                _seq.Text = attrow.seq.ToString();
                _nobr.Text = baserow.nobr;
                _temp.Text = baserow.templetID;


                if (attrow.StdDate <= DateTime.Now && attrow.EndDate >= DateTime.Now)
                {
                    FormView1.Visible = true;

                    ViewState["isOver"] = false;

                }
                else
                {
                    ViewState["isOver"] = true;
                    GridView2.Columns[GridView2.Columns.Count - 1].Visible = false;

                FormView1.Visible = false;
                }
             
            }
            note.Text = DataClass.getNote("EMP.EFF002.aspx.4");
        }
    }
    protected void FormView1_ItemInserted1(object sender, FormViewInsertedEventArgs e)
    {
        GridView2.DataBind();
    }
    protected void FormView1_ItemInserting1(object sender, FormViewInsertEventArgs e)
    {
        e.Values["yy"] = int.Parse(_yy.Text);
        e.Values["seq"] = int.Parse(_seq.Text);
        e.Values["nobr"] = _nobr.Text;
        e.Values["keydate"] = DateTime.Now;
        DropDownList ddl = (DropDownList)FormView1.FindControl("DropDownList2");
        e.Values["eduCateItemID"] = ddl.SelectedValue;

    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView2.DataBind();
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["keydate"] = DateTime.Now;
        DropDownList ddl = (DropDownList)FormView1.FindControl("DropDownList2");
        e.NewValues["eduCateItemID"] = ddl.SelectedValue;
    }
    int SelectedIndex = -1;
    protected void FormView1_ModeChanged(object sender, EventArgs e)
    {
        if (FormView1.CurrentMode == FormViewMode.Edit)
        {
            DropDownList ddl = (DropDownList)FormView1.FindControl("DropDownList2");
            SelectedIndex = ddl.SelectedIndex;


        }

    }
    protected void FormView1_DataBound(object sender, EventArgs e)
    {
        if (FormView1.CurrentMode == FormViewMode.Edit)
        {
            DropDownList ddl = (DropDownList)FormView1.FindControl("DropDownList2");
            ddl.SelectedIndex = SelectedIndex;


        }
    }
    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            if (bool.Parse(ViewState["isOver"].ToString()))
            {
                Button bt = (Button)e.Row.FindControl("Button1");
                bt.Enabled = false;
            }
        }
    }
}
