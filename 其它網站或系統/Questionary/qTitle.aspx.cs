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

public partial class qTitle : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.TRVALCDTableAdapter taTRVALCD = new QuestionaryDSTableAdapters.TRVALCDTableAdapter();

    public QuestionaryDS oQuestionaryDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oQuestionaryDS = new QuestionaryDS();
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (e.Values["VALCODE"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "代碼為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        if (taTRVALCD.GetDataByVALCODE(e.Values["VALCODE"].ToString().Trim()).Rows.Count > 0)
        {
            lblMsg.Text = "代碼重複";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        e.Values["L1CAP"] = e.Values["L1CAP"].ToString().Trim().Length > 0 ? e.Values["L1CAP"] : " ";
        e.Values["L2CAP"] = e.Values["L2CAP"].ToString().Trim().Length > 0 ? e.Values["L2CAP"] : " ";
        e.Values["L3CAP"] = e.Values["L3CAP"].ToString().Trim().Length > 0 ? e.Values["L3CAP"] : " ";
        e.Values["L4CAP"] = e.Values["L4CAP"].ToString().Trim().Length > 0 ? e.Values["L4CAP"] : " ";
        e.Values["L5CAP"] = e.Values["L5CAP"].ToString().Trim().Length > 0 ? e.Values["L5CAP"] : " ";

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
        e.NewValues["L1CAP"] = e.NewValues["L1CAP"].ToString().Trim().Length > 0 ? e.NewValues["L1CAP"] : " ";
        e.NewValues["L2CAP"] = e.NewValues["L2CAP"].ToString().Trim().Length > 0 ? e.NewValues["L2CAP"] : " ";
        e.NewValues["L3CAP"] = e.NewValues["L3CAP"].ToString().Trim().Length > 0 ? e.NewValues["L3CAP"] : " ";
        e.NewValues["L4CAP"] = e.NewValues["L4CAP"].ToString().Trim().Length > 0 ? e.NewValues["L4CAP"] : " ";
        e.NewValues["L5CAP"] = e.NewValues["L5CAP"].ToString().Trim().Length > 0 ? e.NewValues["L5CAP"] : " ";

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
}
