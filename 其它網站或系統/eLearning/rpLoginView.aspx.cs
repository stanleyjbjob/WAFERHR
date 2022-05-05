using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

using CustomSecurity;

public partial class rpLoginView : System.Web.UI.Page
{
    private SysDSTableAdapters.hrEmpBaseTableAdapter ta_hrEmpBase = new SysDSTableAdapters.hrEmpBaseTableAdapter();
    private SysDSTableAdapters.BaseTtsTableAdapter BaseTtsTA = new SysDSTableAdapters.BaseTtsTableAdapter();

    private SysDS oSysDS;

    private string UserID;

    private mpSystem mp;

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
        UserID = ((CustomIdentity)Context.User.Identity).Name;

        oSysDS = new SysDS();
    }
    protected void btnExport_Click(object sender, EventArgs e)
    {
        gv.Columns[3].Visible = false;
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
    protected void gv_DataBound(object sender, EventArgs e)
    {
        DataRow[] rows;
        BaseTtsTA.Fill(oSysDS.BaseTts);
        foreach (GridViewRow r in gv.Rows)
        {
            if (r.RowType == DataControlRowType.DataRow)
            {
                rows = oSysDS.BaseTts.Select("sNobr = '" + r.Cells[0].Text + "'");
                if (rows.Length > 0)
                {
                    SysDS.BaseTtsRow rb = rows[0] as SysDS.BaseTtsRow;
                    r.Cells[1].Text = rb.sNamec.Trim();
                }
            }
        }
    }
}
