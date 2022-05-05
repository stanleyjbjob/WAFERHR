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
    public HrDSTableAdapters.CalendarTableAdapter CalendarTA = new HrDSTableAdapters.CalendarTableAdapter();
    public HrDSTableAdapters.AbsTableAdapter AbsTA = new HrDSTableAdapters.AbsTableAdapter();
    public HrDSTableAdapters.OtTableAdapter OtTA = new HrDSTableAdapters.OtTableAdapter();

    public HrDS oHrDS;

    public DataRow[] rows;

    public string Nobr, Rote, RoteName, R, OnTime, OffTime, Time, T1, T2, T, tr, html;

    protected void Page_Load(object sender, EventArgs e)
    {
        oHrDS = new HrDS();

        if (!this.IsPostBack) {
            txtDate.Text = DateTime.Now.Date.ToShortDateString();
            try {
                txtDate.Text = Convert.ToDateTime(Request["date"]).ToShortDateString();
            }
            catch {
            }

            cldAbs.SelectedDate = DateTime.Parse(txtDate.Text);

            btnSubmit.OnClientClick = "returnValue = " + form1.ID + "." + txtDate.ID + ".value;self.close();";
            btnCancel.OnClientClick = "returnValue = '" + txtDate.Text + "';self.close();";
        }

        Nobr = Request["nobr"];
        CalendarTA.FillByNobr(oHrDS.Calendar, Nobr);
        AbsTA.Fill(oHrDS.Abs, Nobr);
        OtTA.Fill(oHrDS.Ot, Nobr);
    }

    protected void cldAbs_DayRender(object sender, DayRenderEventArgs e) {
        tr = "";
        rows = oHrDS.Calendar.Select("ADATE = '" + e.Day.Date + "'");
        if (rows.Length > 0) {
            HrDS.CalendarRow rc = (HrDS.CalendarRow)rows[0];
            Rote = rc.ROTE.Trim();
            RoteName = rc.IsROTENAMENull() ? "" : rc.ROTENAME.Trim();
            R = ((Rote != "00") ? Rote : "假日") + "班";
            OnTime = rc.IsON_TIMENull() ? "" : rc.ON_TIME.Trim();
            OffTime = rc.IsOFF_TIMENull() ? "" : rc.OFF_TIME.Trim();
            Time = OnTime + "-" + OffTime;
            T1 = rc.IsT1Null() ? "" : rc.T1.Trim();
            T2 = rc.IsT2Null() ? "" : rc.T2.Trim();
            T = T1 + "-" + T2;

            tr = "<tr><td" + (cbColor.Checked ? " bgcolor='#FFC0C0'" : "") + ">" + R + "</td></tr>";
            tr += "<tr><td" + (cbColor.Checked ? " bgcolor='#FFFFC0'" : "") + ">" + Time + "</td></tr>";
            tr += "<tr><td" + (cbColor.Checked ? " bgcolor='#C0FFFF'" : "") + ">" + T + "</td></tr>";

            //請假
            rows = oHrDS.Abs.Select("BDATE = '" + e.Day.Date + "'");
            foreach (HrDS.AbsRow ra in rows)
                tr += "<tr><td" + (cbColor.Checked ? " bgcolor='" + ((ra.YEAR_REST.Trim() == "1" || ra.YEAR_REST.Trim() == "3" || ra.YEAR_REST.Trim() == "5") ? "Thistle" : "Red") + "'" : "") + ">" + ra.H_NAME.Trim() + ra.TOL_HOURS.ToString() + ra.UNIT.Trim() + "</td></tr>";

            //加班
            rows = oHrDS.Ot.Select("BDATE = '" + e.Day.Date + "'");
            foreach (HrDS.OtRow ro in rows)
                tr += "<tr><td" + (cbColor.Checked ? " bgcolor='Yellow'" : "") + ">加班：" + Convert.ToString(ro.REST_HRS + ro.OT_HRS) + "小時" + "</td></tr>";
        }

        html = "<font size='1'><table width='100%' border='0'>" + tr + "</table></font>";
        Label lb = new Label();
        lb.Text = html;
        e.Cell.Controls.Add(lb);
    }

    protected void cldAbs_SelectionChanged(object sender, EventArgs e) {
        txtDate.Text = cldAbs.SelectedDate.ToShortDateString();
    }
}
