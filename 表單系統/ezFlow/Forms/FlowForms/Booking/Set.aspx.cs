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

public partial class Booking_Set : System.Web.UI.Page
{
    FlowDSTableAdapters.SysAdminTableAdapter SysAdminTA = new FlowDSTableAdapters.SysAdminTableAdapter();

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

    protected void fvSet_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["sKeyMan"] = (Request.Cookies["ezFlow"] == null) ? Request["idEmp_Start"] : Request.Cookies["ezFlow"]["Emp_id"];
        e.NewValues["dKeyDate"] = DateTime.Now;

        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('更新成功');", true);
    }
}
