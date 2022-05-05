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

public partial class qQuestionaryM : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.TRQTableAdapter taTRQ = new QuestionaryDSTableAdapters.TRQTableAdapter();

    public QuestionaryDS oQuestionaryDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oQuestionaryDS = new QuestionaryDS();
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (e.Values["TRQCODE"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "代碼為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        if (e.Values["TRQNAME"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "名稱為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        if (taTRQ.GetDataByTRQCODE(e.Values["TRQCODE"].ToString().Trim()).Rows.Count > 0)
        {
            lblMsg.Text = "代碼重複";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        e.Values["KEY_MAN"] = sa.UserInfo.GetClientIP();
        e.Values["KEY_DATE"] = DateTime.Now;
    }

    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
        //mv.ActiveViewIndex = 0;
        lblMsg.Text = "新增完成";
    }

    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        if (e.NewValues["TRQNAME"].ToString().Trim().Length == 0)
        {
            lblMsg.Text = "名稱為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }

        e.NewValues["KEY_MAN"] = sa.UserInfo.GetClientIP();
        e.NewValues["KEY_DATE"] = DateTime.Now;
    }

    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
        //mv.ActiveViewIndex = 0;
        lblMsg.Text = "修改完成";
    }

    protected void fv_ModeChanged(object sender, EventArgs e)
    {
        //mv.ActiveViewIndex = 0;
        gv.SelectedIndex = -1;
    }

    protected void gv_SelectedIndexChanged(object sender, EventArgs e)
    {
        fv.ChangeMode(FormViewMode.Edit);
        //mv.ActiveViewIndex = 1;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        LinkButton lbtnDelete = (LinkButton)e.Row.FindControl("lbtnDelete");
        if (lbtnDelete != null)
        {
            lbtnDelete.CommandName = lbtnDelete.CommandArgument.ToString().Trim() != "0" ? "" : "Delete";
            lbtnDelete.OnClientClick = lbtnDelete.CommandArgument.ToString().Trim() != "0" ? "alert('子類別尚有項目，因此不可刪除');" : lbtnDelete.OnClientClick;
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "New")
        {
            fv.ChangeMode(FormViewMode.Insert);
            mv.ActiveViewIndex = 1;
        }
        else if (e.CommandName == "Add")
        {
            string link = "MyFrame.aspx?url=qQuestionaryS.aspx?Code=" + e.CommandArgument.ToString();
            string script = "var sFeatures = 'dialogWidth:880px;dialogHeight:400px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = aspnetForm;" +
                "window.showModalDialog('" + link + "', obj, sFeatures);" +
                "self.location = 'qQuestionaryM.aspx';";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
        }
        else if (e.CommandName == "View")
        {
            string link = "MyFrame.aspx?url=qQuestionaryView.aspx?Code=" + e.CommandArgument.ToString();
            string script = "var sFeatures = 'dialogWidth:880px;dialogHeight:800px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = aspnetForm;" +
                "window.showModalDialog('" + link + "', obj, sFeatures);"; ;
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
        }
        else if (e.CommandName == "HEADER" || e.CommandName == "FOOTER" || e.CommandName == "CONTENT")
        {
            mv.ActiveViewIndex = 1;
            btnUpdate.CommandName = e.CommandName;
            btnUpdate.CommandArgument = e.CommandArgument.ToString();

            rows = taTRQ.GetData().Select("AUTOKEY = " + Convert.ToInt32(btnUpdate.CommandArgument));
            QuestionaryDS.TRQRow rq = (QuestionaryDS.TRQRow)rows[0];
            txt.Value = rq[btnUpdate.CommandName].ToString();
        }
    }

    protected void btnUpdate_Click(object sender, EventArgs e)
    {
        sdsGV.UpdateCommand = "UPDATE TRQ SET " + btnUpdate.CommandName + " = @value WHERE AUTOKEY = " + Convert.ToInt32(btnUpdate.CommandArgument);

        Parameter pr = new Parameter("value");
        pr.Type = TypeCode.String;
        pr.DefaultValue = txt.Value;
        sdsGV.UpdateParameters.Add(pr);
        sdsGV.Update();
        mv.ActiveViewIndex = 0;
        gv.DataBind();

        lblMsg.Text = "修改完成";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 0;
        gv.DataBind();
    }
}
