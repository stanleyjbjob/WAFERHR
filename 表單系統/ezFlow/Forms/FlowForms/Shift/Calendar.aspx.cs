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

public partial class Abs_Calendar : System.Web.UI.Page
{
    public HrDSTableAdapters.HOLITableAdapter HOLITA = new HrDSTableAdapters.HOLITableAdapter();

    public HrDS oHrDS;

    public DataRow[] rows;

    public string Nobr, tr, html;

    protected void Page_Load(object sender, EventArgs e)
    {
        oHrDS = new HrDS();

        Nobr = Request["nobr"];
        HOLITA.Fill(oHrDS.HOLI);
    }

    protected void cldAbs_DayRender(object sender, DayRenderEventArgs e) {
        tr = "";
        rows = oHrDS.HOLI.Select("H_DATE = '" + e.Day.Date + "' AND HOLI_CODE = '" + ddlHoliday.SelectedItem.Value + "'");
        if (rows.Length > 0) {
            HrDS.HOLIRow rh = (HrDS.HOLIRow)rows[0];

            tr = "<tr><td" + (cbColor.Checked ? " bgcolor='#FFC0C0'" : "") + ">休假</td></tr>";
        }

        html = "<font size='1'><table width='100%' border='0'>" + tr + "</table></font>";
        Label lb = new Label();
        lb.Text = html;
        e.Cell.Controls.Add(lb);
    }
    
    protected void ddlHoliday_SelectedIndexChanged(object sender, EventArgs e)
    {
        cldAbs.DataBind();
    }
}
