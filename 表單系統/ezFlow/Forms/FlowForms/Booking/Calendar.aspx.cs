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

public partial class Booking_Calendar : System.Web.UI.Page
{
    public BookingDSTableAdapters.wfBookingTableAdapter wfBookingTA = new BookingDSTableAdapters.wfBookingTableAdapter();
    BookingDSTableAdapters.wfBookingClassTableAdapter wfBookingClassTA = new BookingDSTableAdapters.wfBookingClassTableAdapter();
    BookingDSTableAdapters.wfBookingTypeTableAdapter wfBookingTypeTA = new BookingDSTableAdapters.wfBookingTypeTableAdapter();

    public BookingDS oBookingDS;

    public DataRow[] rows;

    public DateTime date, dateB, dateE;
    public string Nobr, html, tr;

    protected void Page_Load(object sender, EventArgs e)
    {
        oBookingDS = new BookingDS();
        Nobr = Request["nobr"];
    }

    protected void cldAbs_DayRender(object sender, DayRenderEventArgs e)
    {
        tr = "";
        date = e.Day.Date;
        dateB = new DateTime(date.Year, date.Month, date.Day, 0, 0, 0);
        dateE = new DateTime(date.Year, date.Month, date.Day, 23, 59, 59);

        rows = wfBookingTA.GetDataByClassCode(dateE, dateB, ddlClass.SelectedItem.Value).Select();
        if (rows.Length > 0)
        {
            foreach (BookingDS.wfBookingRow r in rows)
            {
                if (ddlType.SelectedItem.Value == "000000" || r.sTypeCode == ddlType.SelectedItem.Value)
                {
                    tr += "<tr><td" + (cbColor.Checked ? " bgcolor='#FFC0C0'" : "") + ">" + r.sName + "</td></tr>";
                    tr += "<tr><td" + (cbColor.Checked ? " bgcolor='#FFFFC0'" : "") + ">" + r.sDeptName + "</td></tr>";
                    tr += "<tr><td" + (cbColor.Checked ? " bgcolor='#C0FFFF'" : "") + ">" + r.dEndDateTime + "</td></tr>";
                    tr += "<tr><td" + (cbColor.Checked ? " bgcolor='#FFC0FF'" : "") + ">" + r.sTypeName + "</td></tr>";
                }
            }
        }

        html = "<font size='1'><table width='100%' border='0'>" + tr + "</table></font>";
        Label lb = new Label();
        lb.Text = html;
        e.Cell.Controls.Add(lb);
    }
}