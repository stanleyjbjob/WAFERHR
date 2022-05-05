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

public partial class qCastS : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.TRVALGDGTableAdapter taTRVALGDG = new QuestionaryDSTableAdapters.TRVALGDGTableAdapter();

    public string Code;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";

        Code = Request.QueryString["Code"];

        if (Code == null)
        {
            lblMsg.Text = "系統參數不正確，請重新進入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');close();", true);
            upl.Visible = false;
        }
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        try
        {
            e.Values["SORT"] = Convert.ToInt32(e.Values["SORT"]);
        }
        catch
        {
            int i = 1;
            while (taTRVALGDG.GetDataByVALCODE(Code, i).Rows.Count > 0)
                i++;

            e.Values["SORT"] = i;
        }

        if (e.Values["ASKCODE"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "沒有子類別可以新增了";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        e.Values["VALCODE"] = Code;
    }

    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
        lblMsg.Text = "新增完成";
    }

    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        try
        {
            e.NewValues["SORT"] = Convert.ToInt32(e.NewValues["SORT"]);
        }
        catch
        {
            int i = 1;
            while (taTRVALGDG.GetDataByVALCODE(Code, i).Rows.Count > 0)
                i++;

            e.NewValues["SORT"] = i;
        }

        e.NewValues["VALCODE"] = Code;
    }

    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
        lblMsg.Text = "修改完成";
    }

    protected void fv_ModeChanged(object sender, EventArgs e)
    {
        gv.SelectedIndex = -1;
    }

    protected void gv_SelectedIndexChanged(object sender, EventArgs e)
    {
        fv.ChangeMode(FormViewMode.Edit);
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);
    }

    protected void gv_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        fv.ChangeMode(FormViewMode.Insert);
        fv.DataBind();
    }
}
