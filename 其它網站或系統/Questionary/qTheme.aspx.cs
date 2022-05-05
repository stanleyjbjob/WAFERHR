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

public partial class qTheme : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.TRASKCDTableAdapter taTRASKCD = new QuestionaryDSTableAdapters.TRASKCDTableAdapter();

    public QuestionaryDS oQuestionaryDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oQuestionaryDS = new QuestionaryDS();
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (e.Values["ASKCODE"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "代碼為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        if (e.Values["ASKDESCRC"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "內容為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        if (e.Values["VALCODE"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "評量抬頭沒有選項，請先行新增";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        if (taTRASKCD.GetDataByASKCODE(e.Values["ASKCODE"].ToString().Trim()).Rows.Count > 0)
        {
            lblMsg.Text = "代碼重複";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        e.Values["ASKDESCRE"] = " ";
        e.Values["TEMPLATE"] = " ";
        e.Values["TCR_NO"] = " ";
        e.Values["KEY_MAN"] = sa.UserInfo.GetClientIP();
        e.Values["KEY_DATE"] = DateTime.Now;
    }

    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
        lblMsg.Text = "新增完成";
    }

    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        if (e.NewValues["ASKDESCRC"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "內容為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        if (e.NewValues["VALCODE"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "評量抬頭沒有選項，請先行新增";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        e.NewValues["KEY_MAN"] = sa.UserInfo.GetClientIP();
        e.NewValues["KEY_DATE"] = DateTime.Now;
    }

    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
        lblMsg.Text = "修改完成";
    }

    protected void fv_ModeChanged(object sender, EventArgs e)
    {
        //gv.SelectedIndex = -1;
    }

    protected void gv_SelectedIndexChanged(object sender, EventArgs e)
    {
        fv.ChangeMode(FormViewMode.Edit);
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "New")
        {
            fv.ChangeMode(FormViewMode.Insert);
        }
    }
}
