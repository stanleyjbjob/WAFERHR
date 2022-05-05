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

public partial class Booking_View : System.Web.UI.Page
{
    FlowDSTableAdapters.SysAdminTableAdapter SysAdminTA = new FlowDSTableAdapters.SysAdminTableAdapter();
    BookingDSTableAdapters.wfBookingAppSTableAdapter wfBookingAppSTA = new BookingDSTableAdapters.wfBookingAppSTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
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

    protected void gvS_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName != "Sort" && CommandArgument.Length > 0)
        {
            DataRowCollection rows = wfBookingAppSTA.GetDataByAutoKey(Convert.ToInt32(CommandArgument)).Rows;

            if (rows.Count > 0)
            {
                BookingDS.wfBookingAppSRow r = (BookingDS.wfBookingAppSRow)rows[0];
                if (CommandName == "Del")
                {
                    r.sState = "4";
                    wfBookingAppSTA.Update(r);

                    gvS.DataBind();
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('刪除完成');", true);
                }
            }
        }
    }
}
