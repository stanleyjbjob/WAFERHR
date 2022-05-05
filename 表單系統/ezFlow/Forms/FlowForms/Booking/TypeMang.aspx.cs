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

public partial class Booking_TypeMang : System.Web.UI.Page
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

    protected void fvType_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (e.Values["sTypeCode"].ToString().Length == 0)
        {
            lblMsg.Text = "型號代碼不可空白";
            e.Cancel = true;
        }

        if (e.Values["sTypeName"].ToString().Length == 0)
        {
            lblMsg.Text = "型號名稱不可空白";
            e.Cancel = true;
        }

        try
        {
            e.Values["dAdate"] = (e.Values["dAdate"].ToString().Length > 0) ? Convert.ToDateTime(e.Values["dAdate"]) : new DateTime(1900, 1, 1);
            e.Values["dDdate"] = (e.Values["dDdate"].ToString().Length > 0) ? Convert.ToDateTime(e.Values["dDdate"]) : new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12));
        }
        catch
        {
            lblMsg.Text = "日期格式不正確(例：1979/12/3)";
            e.Cancel = true;
        }

        if (wfBookingTypeTA.GetDataByTypeCode(Request["ClassCode"], e.Values["sTypeCode"].ToString()).Rows.Count > 0)
        {
            lblMsg.Text = "型號代碼重複";
            e.Cancel = true;
        }

        if (!e.Cancel)
        {
            lblMsg.Text = "新增完成";
            e.Values["sClassCode"] = Request["ClassCode"];
            e.Values["sKeyMan"] = Request.Cookies["ezFlow"]["Emp_id"];
            e.Values["dKeyDate"] = DateTime.Now;
        }

        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }

    protected void fvType_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gvType.DataBind();
    }

    protected void fvType_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        if (e.NewValues["sTypeName"].ToString().Length == 0)
        {
            lblMsg.Text = "型號名稱不可空白";
            e.Cancel = true;
        }

        try
        {
            e.NewValues["dAdate"] = (e.NewValues["dAdate"].ToString().Length > 0) ? Convert.ToDateTime(e.NewValues["dAdate"]) : new DateTime(1900, 1, 1);
            e.NewValues["dDdate"] = (e.NewValues["dDdate"].ToString().Length > 0) ? Convert.ToDateTime(e.NewValues["dDdate"]) : new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12));
        }
        catch
        {
            lblMsg.Text = "日期格式不正確(例：1979/12/3)";
            e.Cancel = true;
        }

        if (!e.Cancel)
        {
            lblMsg.Text = "修改完成";
            e.NewValues["sKeyMan"] = Request.Cookies["ezFlow"]["Emp_id"];
            e.NewValues["dKeyDate"] = DateTime.Now;
        }

        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }

    protected void fvType_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gvType.SelectedIndex = -1;
        gvType.DataBind();
    }

    protected void gvType_SelectedIndexChanged(object sender, EventArgs e)
    {
        fvType.ChangeMode(FormViewMode.Edit);
    }
}
