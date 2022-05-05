using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Collections.Generic;

/// <summary>
/// OtCS 的摘要描述
/// </summary>
public class OtCS {
    public OtCS() { }

    //計算加班核心
    public class OtCalculation {
        public double iHour;   //時數
        public double iMinute;  //分鐘數
        public double iResHour; //休息時數
        public double iResMinute;   //休息分鐘數
        public double iTotalHour;
        public double iTotalMinute;
        public string sRote;
        public DayRes[] dDayRes;

        public OtCalculation() {
            iHour = 0;
            iMinute = 0;
            iResHour = 0;
            iResMinute = 0;
            iTotalHour = 0;
            iTotalMinute = 0;
            sRote = "";
        }
    }

    //休息時間
    public class DayRes {
        public DateTime dDateB; //開始休息日期
        public DateTime dDateE;  //結束休息日期
        public double iHours;   //休息總時數
        public double iMinute; //休息總分鐘數
        public bool bHave;  //此時段是否有在加班時間裡面

        public DayRes() {
            dDateB = DateTime.Now.Date;
            dDateE = DateTime.Now.Date;
            iHours = 0;
            iMinute = 0;
            bHave = false;

        }
    }

    //設定休息時間
    public static DayRes SetDayRes(DayRes[] dDayRes, DateTime datetimeB, DateTime datetimeE, DateTime date, string timeB, string timeE) {
        timeB = timeB.Trim();
        timeE = timeE.Trim();

        DayRes oDayRes = new DayRes();

        if ((timeB.Length > 0) && (timeE.Length > 0)) {
            oDayRes.dDateB = date.Date.AddMinutes(FlowCS.GetMinutes(timeB));
            oDayRes.dDateE = date.Date.AddMinutes(FlowCS.GetMinutes(timeE));
            TimeSpan ts = oDayRes.dDateE - oDayRes.dDateB;
            oDayRes.iHours = ts.TotalHours;
            oDayRes.iMinute = ts.TotalMinutes;
            oDayRes.bHave = (isWorkTime(dDayRes, oDayRes)) && (oDayRes.iMinute > 0) && ((datetimeB < oDayRes.dDateE) && (datetimeE > oDayRes.dDateB));
        }

        return oDayRes;
    }

    //判斷陣列裡的時間是否與現在要加入的時間重複
    public static bool isWorkTime(DayRes[] dDayRes, DayRes oDayRes) {
        foreach (DayRes dr in dDayRes)
            if ((dr != null) && (dr.dDateB < oDayRes.dDateE) && (dr.dDateE > oDayRes.dDateB))
                return false;

        return true;
    }

    //取得班別
    public static string GetRote(string nobr, DateTime date, string rote, bool day) {
        HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();
        FlowDSTableAdapters.wfRoteTableAdapter wfRoteTA = new FlowDSTableAdapters.wfRoteTableAdapter();

        DataRow[] rows;
        DateTime dateT;

        string Holiday = wfRoteTA.QueryByKey("Holiday");
        string Rote = Holiday != null ? Holiday : "00";

        if (rote != Rote)
            return rote;

        dateT = date;
        do {
            dateT = dateT.AddDays((day) ? 1 : -1);
            rows = ATTENDTA.GetDataByDate(nobr, dateT).Select();

            if (rows.Length > 0) {
                HrDS.ATTENDRow ra = (HrDS.ATTENDRow)rows[0];
                rote = ra.ROTE.Trim();
            }
        } while ((rote == Rote) && (rows.Length > 0));

        return rote;
    }

    //計算加班時間
    public static OtCalculation CalculationOt(string nobr, string rote,DateTime date, DateTime datetimeB, DateTime datetimeE) {
        HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();
        HrDSTableAdapters.ROTETableAdapter ROTETA = new HrDSTableAdapters.ROTETableAdapter();
        FlowDSTableAdapters.wfRoteTableAdapter wfRoteTA = new FlowDSTableAdapters.wfRoteTableAdapter();
        OtDSTableAdapters.HOLITableAdapter HOLITA = new OtDSTableAdapters.HOLITableAdapter();

        HrDS oHrDS = new HrDS();
        DataRow[] rows;


        List<string> arrHoliDay = new List<string>();
        arrHoliDay.Add("00");
        arrHoliDay.Add("0X");
        arrHoliDay.Add("0Y");
        arrHoliDay.Add("0Z");

        string Holiday = wfRoteTA.QueryByKey("Holiday");
        string Rote = Holiday != null ? Holiday : "00";

        OtCalculation oOtCalculation = new OtCalculation();

        ATTENDTA.FillByWorkDay(oHrDS.ATTEND, nobr, "", date, datetimeE.Date);
        oOtCalculation.dDayRes = new DayRes[oHrDS.ATTEND.Count + (oHrDS.ATTEND.Count * 4)]; //計算休息次數包含上班時間(最大次數)

        int j = 0;
        bool isRote;
        foreach (HrDS.ATTENDRow ra in oHrDS.ATTEND.Rows) {
            rote = (rote == "0") ? ra.ROTE.Trim() : rote;

            if (j == 0)
                oOtCalculation.sRote = rote;

            rote = GetRote(nobr, ra.ADATE, rote, false);
            rote = GetRote(nobr, ra.ADATE, rote, true);

            isRote = (ra.ADATE.DayOfWeek.ToString("d") == "6" || ra.ADATE.DayOfWeek.ToString("d") == "0" || HOLITA.GetDataByDate(ra.ADATE.Date).Rows.Count > 0) && (rote == "B"); //假日來上B班
            isRote = rote == "C" ? true : isRote;   //C班永遠不扣休息時間

            rows = ROTETA.GetDataByRote(rote).Select();
            if (rows.Length > 0) {
                HrDS.ROTERow rr = (HrDS.ROTERow)rows[0];

                if (!isRote)    //假日或國定假日(B,C,F,G)來上[B]班的人不會減休息吃飯時間
                {
                    //上班時間及休息時間
                    oOtCalculation.dDayRes[j] = (!arrHoliDay.Contains(ra.ROTE.Trim())) ? SetDayRes(oOtCalculation.dDayRes, datetimeB, datetimeE, ra.ADATE, rr.ON_TIME, rr.OFF_TIME) : null;
                    j++; oOtCalculation.dDayRes[j] = SetDayRes(oOtCalculation.dDayRes, datetimeB, datetimeE, ra.ADATE, rr.RES_B_TIME, rr.RES_E_TIME);
                    j++; oOtCalculation.dDayRes[j] = SetDayRes(oOtCalculation.dDayRes, datetimeB, datetimeE, ra.ADATE, rr.RES_B2_TIME, rr.RES_E2_TIME);
                    j++; oOtCalculation.dDayRes[j] = SetDayRes(oOtCalculation.dDayRes, datetimeB, datetimeE, ra.ADATE, rr.RES_B3_TIME, rr.RES_E3_TIME);
                    j++; oOtCalculation.dDayRes[j] = SetDayRes(oOtCalculation.dDayRes, datetimeB, datetimeE, ra.ADATE, rr.RES_B4_TIME, rr.RES_E4_TIME);
                }
            }

            j++;
        }

        TimeSpan ts;
        //計算休息時間
        foreach (DayRes dr in oOtCalculation.dDayRes) {
            if ((dr != null) && (dr.bHave) && (dr.iHours > 0)) {
                dr.dDateB = ((datetimeB <= dr.dDateB) && (datetimeE >= dr.dDateB)) ? dr.dDateB : datetimeB;
                dr.dDateE = ((datetimeB <= dr.dDateE) && (datetimeE >= dr.dDateE)) ? dr.dDateE : datetimeE;

                ts = dr.dDateE - dr.dDateB;
                dr.iHours = ts.TotalHours;
                dr.iMinute = ts.TotalMinutes;
                oOtCalculation.iResHour += dr.iHours;
                oOtCalculation.iResMinute += dr.iMinute;
            }
        }

        ts = datetimeE - datetimeB;
        oOtCalculation.iTotalHour = ts.TotalHours - (ts.TotalHours % 0.5);
        oOtCalculation.iTotalMinute = ts.TotalMinutes;
        oOtCalculation.iHour = ts.TotalHours - oOtCalculation.iResHour - ((ts.TotalHours - oOtCalculation.iResHour) % 0.5);// oOtCalculation.iTotalHour - oOtCalculation.iResHour;
        oOtCalculation.iMinute = oOtCalculation.iTotalMinute - oOtCalculation.iResMinute;

        return oOtCalculation;
    }

    //總加班時數
    public static decimal GetOtTotalHours(string nobr, string yymm)
    {
        HrDSTableAdapters.OtTableAdapter OtTA = new HrDSTableAdapters.OtTableAdapter();
        decimal Hours = Convert.ToDecimal(OtTA.GetOtTotalHrs(nobr, yymm));
        return Hours;
    }
}
