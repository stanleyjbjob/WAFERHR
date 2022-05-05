using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class rpCourseView : System.Web.UI.Page
{
    private SysDSTableAdapters.hrEmpBaseTableAdapter ta_hrEmpBase = new SysDSTableAdapters.hrEmpBaseTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {

    }

    protected void btnExport_Click(object sender, EventArgs e)
    {
        gv.AllowPaging = false;
        gv.AllowSorting = false;
        gv.DataBind();
        sa.gv.ExportXls(gv);
    }

    public override void VerifyRenderingInServerForm(Control control) { }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lblNobr = e.Row.FindControl("lblNobr") as Label;
        Label lblName = e.Row.FindControl("lblName") as Label;

        if (lblNobr != null && lblName != null)
        {
            DataRow[] rows = ta_hrEmpBase.GetDataByNobr(lblNobr.Text).Select();

            if (rows.Length > 0)
            {
                SysDS.hrEmpBaseRow r = rows[0] as SysDS.hrEmpBaseRow;
                lblName.Text = r.sNameC;
            }
        }
    }
}
