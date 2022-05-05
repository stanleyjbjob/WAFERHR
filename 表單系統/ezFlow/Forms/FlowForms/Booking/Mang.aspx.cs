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

public partial class Booking_Mang : System.Web.UI.Page
{
    //Flow
    FlowDSTableAdapters.SysAdminTableAdapter SysAdminTA = new FlowDSTableAdapters.SysAdminTableAdapter();

    //From
    BookingDSTableAdapters.wfBookingClassTableAdapter wfBookingClassTA = new BookingDSTableAdapters.wfBookingClassTableAdapter();
    BookingDSTableAdapters.wfBookingTypeTableAdapter wfBookingTypeTA = new BookingDSTableAdapters.wfBookingTypeTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";

        if (!this.IsPostBack)
        {
            string LoginID = (Request.Cookies["ezFlow"] == null) ? Request["idEmp_Start"] : Request.Cookies["ezFlow"]["Emp_id"];

            if (SysAdminTA.GetDataByKey(LoginID).Rows.Count == 0)
            {
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您沒有權限可進入此頁面，請洽管理人員');", true);
                upl.Visible = false;
                return;
            }
        }
    }

    protected void fvClass_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (e.Values["sClassCode"].ToString().Length == 0)
        {
            lblMsg.Text = "類別代碼不可空白";
            e.Cancel = true;
        }

        if (e.Values["sClassName"].ToString().Length == 0)
        {
            lblMsg.Text = "類別名稱不可空白";
            e.Cancel = true;
        }

        if (wfBookingClassTA.GetDataByClassCode(e.Values["sClassCode"].ToString()).Rows.Count > 0)
        {
            lblMsg.Text = "類別代碼重複";
            e.Cancel = true;
        }

        if (!e.Cancel)
        {
            lblMsg.Text = "新增完成";
            e.Values["sKeyMan"] = Request["idEmp_Start"];
            e.Values["dKeyDate"] = DateTime.Now;
        }

        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }

    protected void fvClass_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvClass.DataBind();
    }

    protected void fvClass_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        if (e.NewValues["sClassName"].ToString().Length == 0)
        {
            lblMsg.Text = "類別名稱不可空白";
            e.Cancel = true;
        }

        if (!e.Cancel)
        {
            lblMsg.Text = "修改完成";
            e.NewValues["sKeyMan"] = Request["idEmp_Start"];
            e.NewValues["dKeyDate"] = DateTime.Now;
        }

        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }

    protected void fvClass_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvClass.SelectedIndex = -1;
        gvClass.DataBind();
    }

    protected void gvClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        fvClass.ChangeMode(FormViewMode.Edit);
    }

    protected void gvClass_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        LinkButton lbDelete = (LinkButton)e.Row.FindControl("lbDelete");

        if (lbDelete != null)
        {
            //檢查子類別是否還有主類別的代碼
            lbDelete.OnClientClick = (wfBookingTypeTA.GetDataByClassCode(lbDelete.CommandArgument).Rows.Count > 0) ? "return confirm('下層還有子類別，您確定要全部刪除嗎？');" : lbDelete.OnClientClick;
        }
    }

    protected void gvClass_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        wfBookingTypeTA.DeleteQueryClassCode(e.Keys["sClassCode"].ToString());
    }

    protected void gvClass_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "New")
        {
            string link = "MyFrame.aspx?url=TypeMang.aspx?ClassCode=" + e.CommandArgument.ToString();
            string script = "var sFeatures = 'dialogWidth:600px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = form1;" +
                "window.showModalDialog('" + link + "', obj, sFeatures);";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "New", script, true);
        }
    } 
}
