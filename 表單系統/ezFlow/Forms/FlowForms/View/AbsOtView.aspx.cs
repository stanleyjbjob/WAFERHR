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

public partial class View_AbsOtView : System.Web.UI.Page
{
    public HrDSTableAdapters.CalendarTableAdapter CalendarTA = new HrDSTableAdapters.CalendarTableAdapter();
    public HrDSTableAdapters.AbsTableAdapter AbsTA = new HrDSTableAdapters.AbsTableAdapter();
    public HrDSTableAdapters.OtTableAdapter OtTA = new HrDSTableAdapters.OtTableAdapter();
    public HrDSTableAdapters.FOODCARDTableAdapter taFOODCARD = new HrDSTableAdapters.FOODCARDTableAdapter();

    public HrDS oHrDS;

    public DataRow[] rows;

    public string Rote, RoteName, R, OnTime, OffTime, Time, T1, T2, T, tr, html;

    protected void Page_Load(object sender, EventArgs e) {
        oHrDS = new HrDS();

        if (!IsPostBack) 
        {
            ddlDept.DataBind();

            lblSql.Text = sdsGV.SelectCommand;

            lblEmpID.Text = Request.QueryString["idEmp_Start"] != null ? FlowCS.GetDecode(Request.QueryString["idEmp_Start"]) : lblEmpID.Text;
            //lblEmpID.Text = Request.QueryString["idEmp_Start"];
            ddlDept.DataBind();
        }

        HrBaseData oHrBaseDataS = new HrBaseData(lblEmpID.Text);

        if (oHrBaseDataS.bMang)
        {
            if (cbAll.Checked)
                sdsGV.SelectCommand = lblSql.Text + " WHERE Dept.path LIKE '" + ddlDept.SelectedItem.Value + "%'";
            else
                sdsGV.SelectCommand = lblSql.Text + " WHERE Dept.path = '" + ddlDept.SelectedItem.Value + "'";
        }else
            sdsGV.SelectCommand = lblSql.Text + " WHERE Emp.id = '" + lblEmpID.Text + "'";

        CalendarTA.FillByNobr(oHrDS.Calendar, lblNobr.Text);
        AbsTA.Fill(oHrDS.Abs, lblNobr.Text);
        OtTA.Fill(oHrDS.Ot, lblNobr.Text);
        taFOODCARD.FillByNobr(oHrDS.FOODCARD, lblNobr.Text);
    }

    protected void btnSearch_Click(object sender, EventArgs e) {
        HrBaseData oHrBaseDataS = new HrBaseData(lblEmpID.Text);

        if (oHrBaseDataS.bMang)
        {
            if (cbAll.Checked)
                sdsGV.SelectCommand = lblSql.Text + " WHERE Dept.path LIKE '" + ddlDept.SelectedItem.Value + "%'";
            else
                sdsGV.SelectCommand = lblSql.Text + " WHERE Dept.path = '" + ddlDept.SelectedItem.Value + "'";
        }
        else
            sdsGV.SelectCommand = lblSql.Text + " WHERE Emp.id = '" + lblEmpID.Text + "'";

        gv.DataBind();
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            //滑鼠移至資料列上的顏色
            e.Row.Attributes.Add("onmouseover", "this.style.backgroundColor='#FFC0FF'");
            //滑鼠點擊後變色
            e.Row.Attributes.Add("onclick", "this.style.backgroundColor='#FF9933'");
            //e.Row.Attributes.Add("onclick", "window.location.href='Login.aspx'");
            if (e.Row.RowState == DataControlRowState.Alternate) {
                //滑鼠離開資料列上的顏色
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='White'");
            }
            else if (e.Row.RowState == DataControlRowState.Normal) {
                //滑鼠離開資料列上的顏色
                e.Row.Attributes.Add("onmouseout", "this.style.backgroundColor='#EFF3FB'");
            }
        }
        if (e.Row.Cells.Count >= 5)//排除錯誤的條件
        {
            Label lblAbs = e.Row.Cells[5].FindControl("lblAbs") as Label;
            HrDS.AbsDataTable AbsDT=HrCS.GetAbs0246ByNobrBdate(e.Row.Cells[1].Text, DateTime.Now);
            if (lblAbs != null && AbsDT.Count>0)
            {
                lblAbs.Text = "";
                foreach (DataRow rw in AbsDT.Rows)
                {
                    HrDS.AbsRow AbsRW = rw as HrDS.AbsRow;
                    HrDS.HCODERow HcodeRW= HrCS.GetHCodeByHcode(AbsRW.H_CODE);
                    lblAbs.Text += AbsRW.H_NAME + " : " + AbsRW.TOL_HOURS.ToString() + HcodeRW.UNIT+"<br>";
                }
            }
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e) {
        if (e.CommandName == "Select") {
            mv.ActiveViewIndex = 1;

            lblNobr.Text = e.CommandArgument.ToString();
            CalendarTA.FillByNobr(oHrDS.Calendar, lblNobr.Text);
            AbsTA.Fill(oHrDS.Abs, lblNobr.Text);
            OtTA.Fill(oHrDS.Ot, lblNobr.Text);
            taFOODCARD.FillByNobr(oHrDS.FOODCARD, lblNobr.Text);
        }
        else if (e.CommandName == "OtCalc")
        {
            mv.ActiveViewIndex = 3;

            lblNobr.Text = e.CommandArgument.ToString();
            CalendarTA.FillByNobr(oHrDS.Calendar, lblNobr.Text);
            AbsTA.Fill(oHrDS.Abs, lblNobr.Text);
            OtTA.Fill(oHrDS.Ot, lblNobr.Text);
            taFOODCARD.FillByNobr(oHrDS.FOODCARD, lblNobr.Text);
        }
        else if (e.CommandName == "Eat")
        {
            mv.ActiveViewIndex = 4;

            lblNobr.Text = e.CommandArgument.ToString();
            CalendarTA.FillByNobr(oHrDS.Calendar, lblNobr.Text);
            AbsTA.Fill(oHrDS.Abs, lblNobr.Text);
            OtTA.Fill(oHrDS.Ot, lblNobr.Text);
            taFOODCARD.FillByNobr(oHrDS.FOODCARD, lblNobr.Text);
        }
    }

    protected void cld_DayRender(object sender, DayRenderEventArgs e)
    {
        tr = "";
        rows = oHrDS.Calendar.Select("ADATE = '" + e.Day.Date + "'");
        if (rows.Length > 0)
        {
            HrDS.CalendarRow rc = (HrDS.CalendarRow)rows[0];
            Rote = rc.ROTE.Trim();
            RoteName = rc.IsROTENAMENull() ? "" : rc.ROTENAME.Trim();
            R = RoteName + "(" + Rote + ")";
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
            if (e.Day.Date <= DateTime.Now.Date)
            {
                rows = oHrDS.Abs.Select("BDATE = '" + e.Day.Date + "'");
                foreach (HrDS.AbsRow ra in rows)
                    if (ra.H_CODE.Trim() != "W3" && ra.H_CODE.Trim() != "W8")
                        tr += "<tr><td" + (cbColor.Checked ? " bgcolor='Red'" : "") + ">" + ra.H_NAME.Trim() + ra.TOL_HOURS.ToString() + ra.UNIT.Trim() + "</td></tr>";
            }

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

    protected void cldEat_DayRender(object sender, DayRenderEventArgs e)
    {
        tr = "";

        rows = oHrDS.Calendar.Select("ADATE = '" + e.Day.Date + "'");
        if (rows.Length > 0)
        {
            HrDS.CalendarRow rc = (HrDS.CalendarRow)rows[0];
            Rote = rc.ROTE.Trim();
            RoteName = rc.IsROTENAMENull() ? "" : rc.ROTENAME.Trim();
            R = RoteName + "(" + Rote + ")";

            tr = "<tr><td" + (cbColor.Checked ? " bgcolor='#FFC0C0'" : "") + ">" + R + "</td></tr>";
        }

        rows = oHrDS.FOODCARD.Select("ADATE = '" + e.Day.Date + "'", "ONTIME2");
        if (rows.Length > 0)
        {
            foreach (HrDS.FOODCARDRow r in rows)
                tr += "<tr><td" + (cbColor.Checked ? " bgcolor='#FFFFC0'" : "") + ">" + r.ONTIME2.Trim() + "</td></tr>";
        }

        html = "<font size='1'><table width='100%' border='0'>" + tr + "</table></font>";
        Label lb = new Label();
        lb.Text = html;
        e.Cell.Controls.Add(lb);
    }

    protected void btnBack_Click(object sender, EventArgs e) {
        mv.ActiveViewIndex = 0;
    }

    protected void cbColor_CheckedChanged(object sender, EventArgs e) {
        plColor.Visible = cbColor.Checked;
    }

    protected void btnSwap_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 2;
        GridView1.DataBind();
        GridView2.DataBind();
    }

    protected void btnSwap1_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 1;
        cld.DataBind();
    }
    protected void ddlYYMM_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlYYMM.SelectedValue == "ALL")
            FormView1.Visible = true;
        else
            FormView1.Visible = false;
    }

}
