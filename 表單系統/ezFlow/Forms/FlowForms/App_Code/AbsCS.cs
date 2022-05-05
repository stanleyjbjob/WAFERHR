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

using System.Collections;

/// <summary>
/// AbsCS 的摘要描述
/// </summary>
public class AbsCS
{
    public AbsCS() { }

    //計算請假天數、時數、總天數、總時數 Class
    public class AbsCalculation
    {
        public double iDay;    //天數
        public double iHour;   //時數
        public double iTotalDay;   //總天數
        public double iTotalHour;  //總時數
        public Double iMin;
        public double iWorkHour;    //計算原本應上班工時(總)
        public double iWorkHourAvg; //計算原本應上班工時(平)
        public double iWorkHourMin;   //最小請假時數
        public double iHcodeMin;    //請假代碼的最小時數
        public string sHcodeUnit;   //請假代碼的最小時數單位
        public bool bHcodeMin;  //是否符合最小請假時數true=符合
        public string sSex; //請假性別
        public bool bDiscontent;    //請假時(還有)餘額不足時，是否最後一次允許通過
        public double iAbsUint;    //請假最小間距
        public bool bAbsUint;    //是否符合最小隔格true=符合
        public double iDateMin; //請假計算數值
        public string sDateUnit;    //請假計數單位
        public bool bInHoliday; //假日是否要計算
        public bool bBalance;   //剩餘時數是否足夠
        public bool bOt;
        public DayDate[] dDayDate; //每一天的日期

        public AbsCalculation()
        {
            iDay = 0;
            iHour = 0;
            iTotalDay = 0;
            iTotalHour = 0;
            iMin = 0;
            iWorkHour = 0;
            iWorkHourAvg = 0;
            iWorkHourMin = 0;
            iHcodeMin = 0;
            sHcodeUnit = "小時";
            bHcodeMin = true;
            sSex = "";
            bDiscontent = false;
            iAbsUint = 0;
            bAbsUint = true;
            iDateMin = 0;
            sDateUnit = "年";
            bBalance = false;
            bOt = false;
        }
    }

    //每一天的日期
    public class DayDate
    {
        public string sRote;    //每一天的班別
        public DateTime dDateA; //系統每一天的開始日期
        public DateTime dDateD;  //系統每一天的結束日期
        public string sTimeA;   //系統每天開始時間
        public string sTimeD;   //系統每天結束時間
        public DateTime dDatetimeA; //系統每天的開始日期時間
        public DateTime dDatetimeD; //系統每天的結束日期時間
        public DateTime dDateB; //每一天的開始日期
        public DateTime dDateE;  //每一天的結束日期
        public string sTimeB;   //每天開始時間
        public string sTimeE;   //每天結束時間
        public DateTime dDatetimeB; //每天的開始日期時間
        public DateTime dDatetimeE; //每天的結束日期時間
        public double iDay; //每一天的請假天數
        public double iHour;    //每一天的時數
        public double iOldHour; //原本的每一天的時數
        public double iOldMin;  //原本的每一天的分鐘數
        public double iOt;  //為了合晶每天非法加班時數
        public string sTime;    //為了合晶真正的下班時間
        public DateTime dDatetime;  //實際下班日期時間
        public bool bDate;  //為了合晶判斷是否為下午
        public bool bAllDay;    //為了合晶判斷是否請全天
        public bool bOt;    //為了合晶判斷是否為未休假時數
        public DayRes[] dDayRes;    //每一天的休息時間
        public string sResB;    //中間休息開始時間定義
        public string sResE;    //中間休息結束時間定義

        public DayDate()
        {
            dDateA = DateTime.Now;
            dDateD = DateTime.Now;
            sTimeA = "0000";
            sTimeD = "0000";
            dDatetimeA = DateTime.Now;
            dDatetimeD = DateTime.Now;
            dDateB = DateTime.Now;
            dDateE = DateTime.Now;
            sTimeB = "0000";
            sTimeE = "0000";
            dDatetimeB = DateTime.Now;
            dDatetimeE = DateTime.Now;
            iDay = 0;
            iHour = 0;
            iOldHour = 0;
            iOldMin = 0;
            iOt = 0;
            sTime = "0000";
            dDatetime = DateTime.Now;
            bDate = false;
            bAllDay = false;
            bOt = false;
            sResB = "0000";
            sResE = "0000";
        }
    }

    //每一天的休息時間
    public class DayRes
    {
        public DateTime dDateB; //開始休息日期
        public DateTime dDateE;  //結束休息日期
        public double iHours;   //休息總時數
        public double iMinute; //休息總分鐘數

        public DayRes()
        {
            dDateB = DateTime.Now.Date;
            dDateE = DateTime.Now.Date;
            iHours = 0;
            iMinute = 0;
        }
    }

    //設定休息時間
    public static DayRes SetDayRes(DateTime date, string timeB, string timeE)
    {
        timeB = timeB.Trim();
        timeE = timeE.Trim();

        DayRes oDayRes = new DayRes();

        if ((timeB.Length > 0) && (timeE.Length > 0))
        {
            oDayRes.dDateB = date.Date.AddMinutes(FlowCS.GetMinutes(timeB));
            oDayRes.dDateE = date.Date.AddMinutes(FlowCS.GetMinutes(timeE));
            TimeSpan ts = oDayRes.dDateE - oDayRes.dDateB;
            oDayRes.iHours = ts.TotalHours;
            oDayRes.iMinute = ts.TotalMinutes;
        }

        return oDayRes;
    }

    //判斷是否不到最小間隔時數
    public static bool isAbsUint(double absUnit, double absHour)
    {
        //間隔單位一定要大於零而且請假時間也要大於零
        while ((absUnit > 0) && (absHour > 0) && (absHour >= absUnit))
            absHour -= absUnit;


        return (absHour == 0) || (absUnit == 0);
    }

    public static double calAbsUint(double absUnit, double absHour)
    {
        double i = 0;
        //間隔單位一定要大於零而且請假時間也要大於零
        while ((absUnit > 0) && (absHour > 0) && (i < absHour))
            i += absUnit;

        return i;
    }

    //計算請假天數、時數、總天數、總時數(請假計算核心)
    public static AbsCalculation CalculationAbs(string Nobr, string HoliCode, DateTime DateB, DateTime DateE, string TimeB, string TimeE, string sName, decimal iProceedingHour)
    {
        List<string> arrHoliDay = new List<string>();
        arrHoliDay.Add("00");
        arrHoliDay.Add("0X");
        arrHoliDay.Add("0Y");
        arrHoliDay.Add("0Z");

        DateTime DateTimeB, DateTimeE;
        DateTimeB = DateB.AddMinutes(FlowCS.GetMinutes(TimeB));
        DateTimeE = DateE.AddMinutes(FlowCS.GetMinutes(TimeE));

        HrDSTableAdapters.WorkDayTableAdapter taWorkDay = new HrDSTableAdapters.WorkDayTableAdapter();
        HrDSTableAdapters.HCODETableAdapter taHCODE = new HrDSTableAdapters.HCODETableAdapter();
        HrDS oHrDS = new HrDS();
        DataRow[] rows;

        AbsCalculation oAbsCalculation = new AbsCalculation();

        //取得假別相關資料
        rows = taHCODE.GetData().Select("H_CODE = '" + HoliCode + "'");
        if (rows.Length == 0)
            return oAbsCalculation;

        HrDS.HCODERow r = (HrDS.HCODERow)rows[0];
        oAbsCalculation.iHcodeMin = r.MIN_NUM;
        oAbsCalculation.sHcodeUnit = r.UNIT.Trim();
        oAbsCalculation.sSex = r.SEX.Trim();
        oAbsCalculation.bDiscontent = r.DISCONTENT;
        oAbsCalculation.iAbsUint = Convert.ToDouble(r.ABSUNIT);
        oAbsCalculation.iDateMin = Convert.ToDouble(r.DATEMIN);
        oAbsCalculation.sDateUnit = r.DATEUNIT;
        oAbsCalculation.bInHoliday = r.IN_HOLI;
        TimeSpan ts;
        ts = DateTimeE.Date - DateB.Date;
        oAbsCalculation.dDayDate = new DayDate[ts.Days + 1];  //取得最大天數所以用計算後的結束時間來減沒計算的開始時間
        int d = 0;

        decimal iRoteHour = 0;
        //設定每天請假的上下班時間及休息時間
        for (DateTime i = DateB.Date; i <= DateTimeE.Date; i = i.Date.AddDays(1))
        {
            rows = taWorkDay.GetDataByDate(Nobr, i).Select();
            if (rows.Length > 0)
            {
                HrDS.WorkDayRow rw = (HrDS.WorkDayRow)rows[0];
                oAbsCalculation.dDayDate[d] = new DayDate();
                oAbsCalculation.dDayDate[d].sRote = rw.ROTE.Trim();

                oAbsCalculation.dDayDate[d].dDateA = i.Date;
                oAbsCalculation.dDayDate[d].dDateD = i.Date;
                oAbsCalculation.dDayDate[d].sTimeA = rw.ON_TIME.Trim();
                oAbsCalculation.dDayDate[d].sTimeD = rw.OFF_TIME.Trim();
                oAbsCalculation.dDayDate[d].dDatetimeA = i.AddMinutes(FlowCS.GetMinutes(rw.ON_TIME.Trim()));
                oAbsCalculation.dDayDate[d].dDatetimeD = i.AddMinutes(FlowCS.GetMinutes(rw.OFF_TIME.Trim()));

                oAbsCalculation.dDayDate[d].dDateB = i.Date;
                oAbsCalculation.dDayDate[d].dDateE = i.Date;
                oAbsCalculation.dDayDate[d].sTimeB = ((oAbsCalculation.dDayDate[d].dDatetimeA <= DateTimeB) && (oAbsCalculation.dDayDate[d].dDatetimeD > DateTimeB)) ? TimeB : oAbsCalculation.dDayDate[d].sTimeA;  //如果請假開始時間等於當天上班時間，就以請假開始時間做當天計算
                oAbsCalculation.dDayDate[d].sTimeE = ((oAbsCalculation.dDayDate[d].dDatetimeA < DateTimeE) && (oAbsCalculation.dDayDate[d].dDatetimeD >= DateTimeE)) ? TimeE : oAbsCalculation.dDayDate[d].sTimeD;  //如果請假結束時間等於當天上班時間，就以請假結束時間做當天計算
                oAbsCalculation.dDayDate[d].dDatetimeB = i.AddMinutes(FlowCS.GetMinutes(oAbsCalculation.dDayDate[d].sTimeB));
                oAbsCalculation.dDayDate[d].dDatetimeE = i.AddMinutes(FlowCS.GetMinutes(oAbsCalculation.dDayDate[d].sTimeE));

                oAbsCalculation.dDayDate[d].iDay = 1;
                oAbsCalculation.dDayDate[d].iOt = Convert.ToDouble(rw.MO_HRS);
                oAbsCalculation.dDayDate[d].iHour = Convert.ToDouble(rw.WK_HRS);
                iRoteHour = iRoteHour == 0 ? rw.WK_HRS : iRoteHour;
                oAbsCalculation.dDayDate[d].iOldHour = oAbsCalculation.dDayDate[d].iHour;
                oAbsCalculation.dDayDate[d].iOldMin = oAbsCalculation.dDayDate[d].iHour * 60;
                oAbsCalculation.dDayDate[d].sTime = rw.ATT_END.Trim();
                oAbsCalculation.dDayDate[d].dDatetime = i.AddMinutes(FlowCS.GetMinutes(oAbsCalculation.dDayDate[d].sTime));
                oAbsCalculation.dDayDate[d].dDayRes = new DayRes[4];    //休息時間分為四個時段，必需寫死，增加休息時間於此
                string res = rw.ROTE.Trim() != "P" && rw.ROTE.Trim() != "S" && rw.RES_E_TIME.Trim().Length > 0 ? ((Convert.ToInt32(rw.RES_E_TIME.Trim()) + 30) % 20) == 0 ? Convert.ToString(Convert.ToInt32(rw.RES_E_TIME.Trim()) + 30) : rw.RES_E_TIME : rw.RES_E_TIME;    //如果休息時間尾數是30分鐘的都要算1小時，所以再加30分鐘
                oAbsCalculation.dDayDate[d].dDayRes[0] = SetDayRes(i, rw.RES_B_TIME, res);
                oAbsCalculation.dDayDate[d].dDayRes[1] = SetDayRes(i, rw.RES_B2_TIME, rw.RES_E2_TIME);
                oAbsCalculation.dDayDate[d].dDayRes[2] = SetDayRes(i, rw.RES_B3_TIME, rw.RES_E3_TIME);
                oAbsCalculation.dDayDate[d].dDayRes[3] = SetDayRes(i, rw.RES_B4_TIME, rw.RES_E4_TIME);
                oAbsCalculation.dDayDate[d].sResB = rw.RES_B1_TIME.Trim();
                oAbsCalculation.dDayDate[d].sResE = rw.RES_E1_TIME.Trim();
            }
            d++;
        }

        double tsDiff = 0;
        double tsDiffM = 0;
        double th = 0;

        string sRote = "";

        //更正每天請假天數及時數並加總
        foreach (DayDate dd in oAbsCalculation.dDayDate)
        {
            if (dd != null)
            {
                //條件有重複性，但因為日後有可能各有不同，因此不做條件合併處理(公因式分解)
                //請假結束時間只要大於當天上班開始時間而且請假開始時間要小於當天上班結束時間，就代表此天要做計算
                if (DateTimeE > dd.dDatetimeB && DateTimeB < dd.dDatetimeE)
                {
                    //產假一律過
                    if (r.IN_HOLI)
                    {
                        dd.iDay = 1;
                        dd.iHour = 8;

                        oAbsCalculation.iTotalDay += dd.iDay;
                        oAbsCalculation.iTotalHour += dd.iHour;
                    }
                    else if (arrHoliDay.Contains(dd.sRote))//如果等於假日班
                    {
                        //如果假日班不用計算
                        if (!oAbsCalculation.bInHoliday)
                        {
                            dd.iDay = 0;
                            dd.iHour = 0;
                        }

                        oAbsCalculation.iTotalDay += dd.iDay;
                        oAbsCalculation.iTotalHour += dd.iHour;
                    }
                    else
                    {
                        oAbsCalculation.iTotalDay += dd.iDay;
                        oAbsCalculation.iTotalHour += dd.iHour;

                        tsDiff = 0;
                        th = 0;

                        //如果開始時間等於申請開始時間，申請結束時間大於或等於「實際」的下班時間 
                        if ((dd.dDatetimeA == dd.dDatetimeB) && (dd.dDatetimeE >= dd.dDatetime))
                        {
                            dd.bAllDay = true;
                        }
                        else if (dd.dDatetimeA == dd.dDatetimeB)    //如果開始時間等於申請開始時間
                        {
                            //dd.dDatetimeB = (dd.sTimeA == "0815") ? dd.dDatetimeA.Date.AddMinutes(FlowCS.GetMinutes("0800")) : dd.dDatetimeB;   //E班要變成早上八點上班，比較好計算



                            foreach (DayRes dr in dd.dDayRes)
                            {
                                //休息時間大於零
                                if (dr.iMinute > 0 && ((dd.dDatetimeB <= dr.dDateE) && (dd.dDatetimeE >= dr.dDateB)))
                                {
                                    dr.dDateB = ((dd.dDatetimeB <= dr.dDateB) && (dd.dDatetimeE >= dr.dDateB)) ? dr.dDateB : dd.dDatetimeB;
                                    dr.dDateE = ((dd.dDatetimeB <= dr.dDateE) && (dd.dDatetimeE >= dr.dDateE)) ? dr.dDateE : dd.dDatetimeE;

                                    ts = dr.dDateE - dr.dDateB;
                                    dr.iHours = ts.TotalHours;
                                    dr.iMinute = ts.TotalMinutes;
                                    tsDiff += dr.iHours;
                                    tsDiffM += dr.iMinute;
                                }
                            }

                            ts = dd.dDatetimeE - dd.dDatetimeB;
                            //th = (ts.TotalHours >= dd.iOldHour) ? dd.iOldHour : ts.TotalHours;
                            th = ts.TotalHours; //20090310 by ming
                            dd.iDay = (th - tsDiff) / dd.iHour;
                            dd.iHour = th - tsDiff;
                            oAbsCalculation.iMin = (ts.TotalMinutes - tsDiffM);

                        }
                        else if (dd.dDatetimeB >= dd.dDatetime) //申請開始時間大於或等於「實際」的下班時間  ※請未休假加班時數
                        {
                            dd.bOt = true;
                            oAbsCalculation.bOt = true;

                            foreach (DayRes dr in dd.dDayRes)
                            {
                                //休息時間大於零
                                if (dr.iMinute > 0 && ((dd.dDatetimeB <= dr.dDateE) && (dd.dDatetimeE >= dr.dDateB)))
                                {
                                    dr.dDateB = ((dd.dDatetimeB <= dr.dDateB) && (dd.dDatetimeE >= dr.dDateB)) ? dr.dDateB : dd.dDatetimeB;
                                    dr.dDateE = ((dd.dDatetimeB <= dr.dDateE) && (dd.dDatetimeE >= dr.dDateE)) ? dr.dDateE : dd.dDatetimeE;

                                    ts = dr.dDateE - dr.dDateB;
                                    dr.iHours = ts.TotalHours;
                                    dr.iMinute = ts.TotalMinutes;
                                    tsDiff += dr.iHours;
                                    tsDiffM += dr.iMinute;
                                }
                            }

                            ts = dd.dDatetimeE - dd.dDatetimeB;
                            //th = (ts.TotalHours >= dd.iOldHour) ? dd.iOldHour : ts.TotalHours;
                            th = ts.TotalHours; //20090310 by ming
                            dd.iDay = (th - tsDiff) / dd.iHour;
                            dd.iHour = th - tsDiff;
                            oAbsCalculation.iMin = (ts.TotalMinutes - tsDiffM);
                        }
                        else if (dd.dDatetimeE >= dd.dDatetime)  //申請結束時間大於或等於「實際」的下班時間 
                        {
                            dd.bDate = true;
                            //dd.dDatetimeA = (dd.sTimeA == "0815") ? dd.dDatetimeA.Date.AddMinutes(FlowCS.GetMinutes("0800")) : dd.dDatetimeA;   //E班要變成早上八點上班，比較好計算
                            dd.dDatetimeE = dd.dDatetime; //如果是真的，那麼結束時間就等於「真正的」下班時間

                            foreach (DayRes dr in dd.dDayRes)
                            {
                                //休息時間大於零
                                if (dr.iMinute > 0 && ((dd.dDatetimeA <= dr.dDateE) && (dd.dDatetimeB >= dr.dDateB)))
                                {
                                    dr.dDateB = ((dd.dDatetimeA <= dr.dDateB) && (dd.dDatetimeB >= dr.dDateB)) ? dr.dDateB : dd.dDatetimeA;
                                    dr.dDateE = ((dd.dDatetimeA <= dr.dDateE) && (dd.dDatetimeB >= dr.dDateE)) ? dr.dDateE : dd.dDatetimeB;

                                    ts = dr.dDateE - dr.dDateB;
                                    dr.iHours = ts.TotalHours;
                                    dr.iMinute = ts.TotalMinutes;
                                    tsDiff += dr.iHours;
                                    tsDiffM += dr.iMinute;
                                }
                            }

                            th = dd.iOldHour;
                            ts = dd.dDatetimeB - dd.dDatetimeA;
                            double thA = ts.TotalHours;
                            dd.iDay = (th - (thA - tsDiff)) / dd.iHour;
                            dd.iHour = th - (thA - tsDiff);
                            oAbsCalculation.iMin = dd.iOldMin - (ts.TotalMinutes - tsDiffM);
                        }
                        else    //申請開始時間大於開始時間
                        {


                            foreach (DayRes dr in dd.dDayRes)
                            {
                                //休息時間大於零
                                if (dr.iMinute > 0 && ((dd.dDatetimeB <= dr.dDateE) && (dd.dDatetimeE >= dr.dDateB)))
                                {
                                    dr.dDateB = ((dd.dDatetimeB <= dr.dDateB) && (dd.dDatetimeE >= dr.dDateB)) ? dr.dDateB : dd.dDatetimeB;
                                    dr.dDateE = ((dd.dDatetimeB <= dr.dDateE) && (dd.dDatetimeE >= dr.dDateE)) ? dr.dDateE : dd.dDatetimeE;

                                    ts = dr.dDateE - dr.dDateB;
                                    dr.iHours = ts.TotalHours;
                                    dr.iMinute = ts.TotalMinutes;
                                    tsDiff += dr.iHours;
                                    tsDiffM += dr.iMinute;
                                }
                            }

                            ts = dd.dDatetimeE - dd.dDatetimeB;
                            th = (ts.TotalHours >= dd.iOldHour) ? dd.iOldHour : ts.TotalHours;
                            dd.iDay = (th - tsDiff) / dd.iHour;
                            dd.iHour = th - tsDiff;
                            oAbsCalculation.iMin = (ts.TotalMinutes - tsDiffM);

                        }

                        //B3跟C3班特休假特別計算規則
                        if (((dd.sRote == "B3" || dd.sRote == "C3" || dd.sRote == "S3" || dd.sRote == "Q3" || dd.sRote == "B5" || dd.sRote == "C5") && (HoliCode == "A" || HoliCode == "M")) || HoliCode == "D")
                        {
                            sRote = dd.sRote;
                            dd.iHour = dd.sTimeB.CompareTo(dd.sResB) < 0 ? 4 : 0;
                            dd.iHour += dd.sTimeE.CompareTo(dd.sResB) > 0 ? 4 : 0;

                            dd.iDay = dd.sTimeB.CompareTo(dd.sResB) < 0 ? 0.5 : 0;
                            dd.iDay += dd.sTimeE.CompareTo(dd.sResB) > 0 ? 0.5 : 0;
                        }
                        else
                        {
                            dd.iDay = calAbsUint(oAbsCalculation.iHcodeMin, dd.iDay - 0.07);    //20101005 by 亞妮 為修正以0.5為計算單位，取最大值0.7先減，再做進位計算

                            dd.iHour = oAbsCalculation.sHcodeUnit == "小時" && oAbsCalculation.iHcodeMin > dd.iHour ? oAbsCalculation.iHcodeMin : dd.iHour;
                            dd.iDay = oAbsCalculation.sHcodeUnit == "天" && oAbsCalculation.iHcodeMin > dd.iDay ? oAbsCalculation.iHcodeMin : dd.iDay;
                        }
                    }
                }
                else
                {
                    dd.iDay = 0;
                    dd.iHour = 0;
                }

                //請補休計算方式不同 by 合晶 再改一定要收錢
                //if (HoliCode != "K")
                if (((dd.sRote == "B3" || dd.sRote == "C3" || dd.sRote == "S3" || dd.sRote == "Q3" || dd.sRote == "B5" || dd.sRote == "C5") && (HoliCode == "A" || HoliCode == "M")) || HoliCode == "D")
                { }
                else
                {
                    //dd.iHour = (dd.bAllDay) ? dd.iHour : (calAbsUint(0.5, dd.iHour) >= dd.iOldHour) ? dd.iOldHour : (calAbsUint(0.5, dd.iHour));
                    dd.iHour = (dd.bAllDay) ? dd.iHour : (calAbsUint(oAbsCalculation.iHcodeMin, dd.iHour) >= dd.iOldHour) ? dd.iOldHour : (calAbsUint(oAbsCalculation.iHcodeMin, dd.iHour));
                    //20101001 by ming ===== 亞妮：從一天8.4改成8   dd.iHour = dd.iHour - ((dd.bDate && !dd.bAllDay) ? 0.1 : 0);  //為了合晶請下午則算4.4個小時
                }

                oAbsCalculation.iDay += dd.iDay;
                oAbsCalculation.iHour += dd.iHour;

                //B班的人計算跟別人不一樣
                if (dd.sRote == "B")
                {
                    oAbsCalculation.iDay -= 0.1;
                }
            }
        }

        oAbsCalculation.bHcodeMin = (oAbsCalculation.sHcodeUnit == "天") ? (oAbsCalculation.iDay >= oAbsCalculation.iHcodeMin) : (oAbsCalculation.iHour >= oAbsCalculation.iHcodeMin);
        oAbsCalculation.bAbsUint = isAbsUint(oAbsCalculation.iAbsUint, (oAbsCalculation.sHcodeUnit == "天") ? (oAbsCalculation.iDay - oAbsCalculation.iHcodeMin) : (oAbsCalculation.iHour - oAbsCalculation.iHcodeMin));

        if (((sRote == "B3" || sRote == "C3" || sRote == "S3" || sRote == "Q3") && (HoliCode == "A" || HoliCode == "M")) || HoliCode == "D")
        {
            oAbsCalculation.bBalance = IsBalance(Nobr, HoliCode, DateTimeB, Convert.ToDecimal(oAbsCalculation.iDay), Convert.ToDecimal(oAbsCalculation.iHour), sName, iProceedingHour, iRoteHour);
            oAbsCalculation.iHour = 0;
        }
        else
        {
            oAbsCalculation.iDay = (oAbsCalculation.sHcodeUnit == "天") ? calAbsUint(oAbsCalculation.iHcodeMin, oAbsCalculation.iDay - 0.04) : 0;    //要減二小時約0.1天
            oAbsCalculation.iHour = (oAbsCalculation.sHcodeUnit == "小時") ? oAbsCalculation.iHour : 0; //為了合晶請下午則算4.4個小時
            oAbsCalculation.bBalance = IsBalance(Nobr, HoliCode, DateB, Convert.ToDecimal(oAbsCalculation.iDay), Convert.ToDecimal(oAbsCalculation.iHour), sName, iProceedingHour, iRoteHour);
        }
        //oAbsCalculation.iDay = (oAbsCalculation.sHcodeUnit == "天") ? oAbsCalculation.iDay : 0;
        //oAbsCalculation.iHour = (oAbsCalculation.sHcodeUnit == "小時") ? oAbsCalculation.iHour : 0;

        return oAbsCalculation;
    }

    public static bool IsBalance(string sNobr, string sHcode, DateTime dDate, decimal DayB, decimal HourB, string sName, decimal iProceedingHour  , decimal iRoteHour)
    {
        AbsDSTableAdapters.HcodeTableAdapter HcodeTA = new AbsDSTableAdapters.HcodeTableAdapter();
        AbsDSTableAdapters.AbsTableAdapter AbsTA = new AbsDSTableAdapters.AbsTableAdapter();

        bool isPass = false;
        AbsDS.AbsInfoDataDataTable AbsInfoDataDT = new AbsCS().GetAbsInfo(sNobr, dDate.Date);
        DataRow[] rows;

        //卡住生失效日及喪假所需的祭拜者姓名
        rows = HcodeTA.GetData().Select("sHCode = '" + sHcode + "'");
        if (rows.Length > 0)
        {
            AbsDS.HcodeRow rh = (AbsDS.HcodeRow)rows[0];
            sHcode = rh.sYearRest == "0" ? sHcode : rh.sYearRest;   //特、彈、補

            rows = AbsInfoDataDT.Select("sHoliCode = '" + sHcode + "' AND sName = '" + sName + "'");

            if (rows.Length > 0)
            {
                AbsDS.AbsInfoDataRow ra = (AbsDS.AbsInfoDataRow)rows[0];

                //如果要檢查
                if (ra.bChe)
                {
                    //如果是生理假
                    if (ra.sHoliCode == "C1")
                    {
                        DateTime dDateB, dDateE;
                        dDateE = dDate.Day > 25 ? new DateTime(dDate.AddMonths(1).Year, dDate.AddMonths(1).Month, 25) : new DateTime(dDate.Year, dDate.Month, 25);
                        dDateB = new DateTime(dDateE.AddMonths(-1).Year, dDateE.AddMonths(-1).Month, 26);
                        string sHour = AbsTA.GetDataByDate(sNobr, "0", dDateB, dDateE).Compute("SUM(iUse)", "sHoliCode = '" + sHcode + "'").ToString();
                        decimal iHour = sHour != null && sHour.Trim().Length > 0 ? Convert.ToDecimal(sHour) : 0;

                        isPass = true;
                        if ((iHour + HourB + iProceedingHour) > Convert.ToDecimal(25.2))
                            isPass = false;

                        //rows = AbsTA.GetDataByDate(sNobr, "0", new DateTime(dDate.Year, 1, 1), dDate).Select("sHoliCode = '" + sHcode + "'", "dDateB DESC");
                        //if (rows.Length > 0)
                        //{
                        //    AbsDS.AbsRow rc = (AbsDS.AbsRow)rows[0];
                        //    TimeSpan ts = dDate - rc.dDateB;
                        //    isPass = ts.Days >= 20; //預設大於28天 0980908 by 亞妮 //0980915又改回20天
                        //}
                        //else
                        //    isPass = true;
                    }
                    else if (ra.sHoliCode == "P1")
                    {
                        DateTime dDateB, dDateE;
                        dDateB = new DateTime(dDate.Year, dDate.Month, 1);
                        dDateE = new DateTime(dDate.Year, dDate.Month, DateTime.DaysInMonth(dDate.Year, dDate.Month));
                        string sHour = AbsTA.GetDataByDate(sNobr, "0", dDateB, dDateE).Compute("SUM(iUse)", "sHoliCode = '" + sHcode + "'").ToString();
                        decimal iHour = sHour != null && sHour.Trim().Length > 0 ? Convert.ToDecimal(sHour) : 0;

                        isPass = true;
                        if ((iHour + HourB + iProceedingHour) > iRoteHour)
                            isPass = false;
                    }
                    else if (ra.sHoliCode == "B1")  //家庭照顧假..全年以7日為限併入事假計算 0991214 by 瓊瑩
                    {
                        isPass = true;
                        string sHour = AbsTA.GetDataByDate(sNobr, "0", new DateTime(DateTime.Now.Year, 1, 1), new DateTime(DateTime.Now.Year, 12, 31)).Compute("Sum(iUse)", "sHoliCode = '" + sHcode + "'").ToString();
                        if (sHour != null && sHour.Trim().Length > 0)
                        {
                            decimal iHour = Convert.ToDecimal(sHour);
                            if ((iHour + HourB) > Convert.ToDecimal(58.8))
                                isPass = false;
                        }

                        isPass = isPass ? (ra.iBalance - ((ra.sUint == "天") ? DayB : HourB) - iProceedingHour) >= 0 : isPass;
                    }
                    else if (ra.sHoliCode == "")
                    {
                    }
                    else
                        isPass = (ra.iBalance - ((ra.sUint == "天") ? DayB : HourB) - iProceedingHour) >= 0;
                }
                else
                    isPass = true;
            }
        }

        return isPass;
    }

    //剩餘時數false = 不足時數
    public static bool isBalance(string Nobr, string Hcode, DateTime Date, decimal DayB, decimal HourB, bool bHcodeMin, bool bAbsUint)
    {
        HrDSTableAdapters.ROTETableAdapter ROTETA = new HrDSTableAdapters.ROTETableAdapter();
        HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();
        HrDSTableAdapters.HCODETableAdapter taHCODE = new HrDSTableAdapters.HCODETableAdapter();
        AbsDSTableAdapters.AbsInfoTableAdapter AbsInfoTA = new AbsDSTableAdapters.AbsInfoTableAdapter();

        AbsDS oAbsDS = new AbsDS();
        DataRow[] rows;

        DateTime DateB, DateE, DateI, DateJ, DateX, DateY;
        DateB = new DateTime(Date.Year, 1, 1);
        DateE = new DateTime(Date.Year, 12, 31);
        DateI = new DateTime(Date.Year, 7, 1);
        DateJ = new DateTime(Date.Year, 12, 31);
        DateX = new DateTime(Date.Year, 1, 1);
        DateY = new DateTime(Date.Year, 6, 30);
        decimal min_num = 0;

        //先以H_CODE找出YEAR_REST可應付特、彈、補
        rows = taHCODE.GetData().Select("H_CODE = '" + Hcode + "'");
        if (rows.Length > 0)
        {
            HrDS.HCODERow rh = (HrDS.HCODERow)rows[0];
            Hcode = (rh.YEAR_REST.Trim() == "0") ? Hcode : rh.YEAR_REST.Trim();
            min_num = Convert.ToDecimal(rh.MIN_NUM);

            if ((Hcode == "2" || Hcode == "4" || Hcode == "6") && (!rh.CHE))
                return true;    //遇到特、彈、補如果又不用檢查，就直接讓他出去吧            
        }

        //if (Date < DateI)
        //    AbsInfoTA.Fill(oAbsDS.AbsInfo, Nobr, DateB, DateE, Date);
        //else
        //    AbsInfoTA.FillByDateW1(oAbsDS.AbsInfo, Nobr, DateB, DateE, Date, DateI, DateJ, DateY, DateX);

        AbsInfoTA.FillByDateW1(oAbsDS.AbsInfo, Nobr, DateB, DateE, Date);

        rows = oAbsDS.AbsInfo.Select("H_CODE = '" + Hcode + "'");

        decimal max = 0, balance = 0, use = 0;
        if (rows.Length > 0)
        {
            //如果遇到生理假 20080227 by ming 用珍
            if (Hcode == "C1")
            {
                DateTime DateA = Date.Day >= 26 ? Date : Date.AddMonths(-1);
                DateB = new DateTime(DateA.Year, Date.Month, 26);
                DateE = new DateTime(DateA.AddMonths(1).Year, DateA.AddMonths(1).Month, 25);

                DataRow[] rows1 = AbsInfoTA.GetData(Nobr, DateB, DateE, Date).Select("H_CODE = '" + Hcode + "'");
                if (rows1.Length > 0)
                {
                    AbsDS.AbsInfoRow ri = (AbsDS.AbsInfoRow)rows1[0];

                    //尋找出勤資料
                    rows1 = ATTENDTA.GetDataByDate(Nobr, Date.Date).Select();
                    if (rows1.Length > 0)
                    {
                        HrDS.ATTENDRow ra = (HrDS.ATTENDRow)rows1[0];

                        //尋找班別資料
                        rows1 = ROTETA.GetDataByRote(ra.ROTE.Trim()).Select();
                        if (rows.Length > 0)
                        {
                            HrDS.ROTERow rr = (HrDS.ROTERow)rows1[0];

                            balance = rr.WK_HRS - ri.TOL_HOURS;
                            use = (ri.UNIT.Trim() == "天") ? (balance - DayB) : (balance - HourB);

                            if (use >= 0)
                                return true;
                        }
                    }
                }

                return false;
            }

            AbsDS.AbsInfoRow r = (AbsDS.AbsInfoRow)rows[0];
            //如果遇到有關聯的假…
            rows = oAbsDS.AbsInfo.Select("DCODE = '" + r.H_CODE.Trim() + "'");
            if (rows.Length > 0)
            {
                AbsDS.AbsInfoRow r1 = (AbsDS.AbsInfoRow)rows[0];
                max = Convert.ToDecimal(r.MAX_NUM) + Convert.ToDecimal(r1.MAX_NUM);
                balance = max - r.TOL_HOURS - r1.TOL_HOURS;
            }
            else
            {
                max = Convert.ToDecimal(r.MAX_NUM);
                balance = max - r.TOL_HOURS;
            }

            decimal d = (r.UNIT.Trim() == "天") ? (DayB) : (HourB);
            use = (r.UNIT.Trim() == "天") ? (balance - DayB) : (balance - HourB);

            //最大值等於0或是剩餘時數大於等於0都可以或是餘數大於零但是照樣可以請 20080213 by ming
            return (!r.CHE) || ((use >= 0) && (bHcodeMin) && (bAbsUint)) || ((use == 0) && (r.DISCONTENT));
        }
        else if (Hcode == "2" || Hcode == "4" || Hcode == "6")
        {
            return false;
        }

        return true;
    }

    private AbsDSTableAdapters.AbsTableAdapter AbsTA = new AbsDSTableAdapters.AbsTableAdapter();
    private AbsDSTableAdapters.Abs1TableAdapter Abs1TA = new AbsDSTableAdapters.Abs1TableAdapter();
    private AbsDSTableAdapters.AbstTableAdapter AbstTA = new AbsDSTableAdapters.AbstTableAdapter();
    private AbsDSTableAdapters.HcodeTableAdapter HcodeTA = new AbsDSTableAdapters.HcodeTableAdapter();

    private AbsDS oAbsDS;
    private AbsDS.AbsInfoDataRow r;
    private decimal iMax, iUse, iUseH;

    private DataRow[] rows;

    //計算請假資料
    public AbsDS.AbsInfoDataDataTable GetAbsInfo(string sNobr, DateTime dDate)
    {
        oAbsDS = new AbsDS();

        DateTime dDateB, dDateE;
        dDateB = new DateTime(dDate.Year, 1, 1);
        dDateE = new DateTime(dDate.Year, 12, 31);
        //InsertAbs246(sNobr, dDateB, dDateE, dDate, "1", "2", "特休");
        //InsertAbs246(sNobr, dDateB, dDateE, dDate, "3", "4", "補休");
        //InsertAbs246(sNobr, dDateB, dDateE, dDate, "5", "6", "彈休");

        InsertAbs246(sNobr, dDate, "1", "2", "特休", dDateB, dDateE);
        InsertAbs246(sNobr, dDate, "3", "4", "補休", dDateB, dDateE);
        InsertAbs246(sNobr, dDate, "5", "6", "彈休", dDateB, dDateE);

        InsertAbsT(sNobr, dDate);
        InsertAbsDcode(sNobr, dDateB, dDateE, dDate);

        return oAbsDS.AbsInfoData;
    }

    //特休、補休、彈休計算
    private void InsertAbs246(string sNobr, DateTime dDate, string sCatAdd, string sCatSubtract, string sHoliName, DateTime dDateB, DateTime dDateE)
    {
        AbsEntitleForOldHRMRepo REPO = new AbsEntitleForOldHRMRepo();

        AbsDS.ABS_ENTITLEDataTable dtEntitleByYearRest = REPO.GetEntitleByYearRest(sNobr, sCatAdd, dDate, dDate);

        if (dtEntitleByYearRest != null && dtEntitleByYearRest.Rows.Count > 0)
        {
            AbsDS.ABS_ENTITLERow[] rsEntitleByYearRest = dtEntitleByYearRest.Select(string.Format("BeginDate<='{0}' and EndDate>='{1}'", dDate, dDate), "EndDate,BeginDate") as AbsDS.ABS_ENTITLERow[];

            decimal Entitle = 0;
            decimal Taken = 0;
            decimal Balance = 0;

            foreach (AbsDS.ABS_ENTITLERow r1 in rsEntitleByYearRest)
            {
                Entitle += r1.Entitle;
                Taken += r1.Taken;
                Balance += r1.Balance;
            }

            AbsDS.ABS_ENTITLERow rEntitleByYearRest = rsEntitleByYearRest[0];

            AbsDSTableAdapters.HcodeTableAdapter HcodeTA = new AbsDSTableAdapters.HcodeTableAdapter();
            AbsDS.HcodeRow rHcode = HcodeTA.GetData().Select("sHCode = '" + rEntitleByYearRest.H_CODE + "'")[0] as AbsDS.HcodeRow;

            r = oAbsDS.AbsInfoData.NewAbsInfoDataRow();
            SetAbsInfoRowData(sCatSubtract, sHoliName, rHcode.bInHoli, Convert.ToDecimal(rHcode.iMin), rHcode.iAbsUnit, rHcode.sUint,
                Taken, Entitle, Balance, rHcode.sYearRest, rHcode.sDcode, rHcode.bChe, rHcode.bDiscontent, rHcode.bDisplayForm, dDateB, dDateE, "");
            oAbsDS.AbsInfoData.AddAbsInfoDataRow(r);
        }
    }

    //特休、補休、彈休計算
    private void InsertAbs246(string sNobr, DateTime dDateB, DateTime dDateE, DateTime dDate, string sCatAdd, string sCatSubtract, string sHoliName)
    {
        rows = AbsTA.GetData(sNobr, sCatAdd, dDateB, dDate, "").Select();
        if (rows.Length > 0)
        {
            iMax = Convert.ToDecimal(AbsTA.GetData(sNobr, sCatAdd, dDateB, dDate, "").Compute("Sum(iUse)", ""));

            iUse = 0;
            if (AbsTA.GetData(sNobr, sCatSubtract, dDateB, dDateE, "").Rows.Count > 0)
                iUse = Convert.ToDecimal(AbsTA.GetData(sNobr, sCatSubtract, dDateB, dDateE, "").Compute("Sum(iUse)", ""));

            AbsDS.AbsRow ra = (AbsDS.AbsRow)rows[0];
            r = oAbsDS.AbsInfoData.NewAbsInfoDataRow();
            SetAbsInfoRowData(sCatSubtract, sHoliName, ra.bInHoli, Convert.ToDecimal(ra.iMin), ra.iInterval, ra.sUint, iUse, iMax, iMax - iUse, ra.sYearRest, ra.sDcode, ra.bChe, ra.bDiscontent, ra.bDisplayform, dDateB, dDateE, "");
            oAbsDS.AbsInfoData.AddAbsInfoDataRow(r);
        }
    }

    //產生得假資料，如喪假、產假、婚假，以請假當天尋找得假資料，生失效日為已休的計算區間，喪假必須例外處理
    private void InsertAbsT(string sNobr, DateTime dDate)
    {
        AbsDS.AbsDataTable AbsDT = new AbsDS.AbsDataTable();

        string sT1, sT2, sT3, sName;
        rows = AbstTA.GetData(sNobr, dDate.Date).Select();

        ArrayList al, als;

        foreach (AbsDS.AbstRow ra in rows)
        {
            al = new ArrayList();
            als = new ArrayList();
            //關聯對沖假
            sT1 = ra.IssT1Null() ? "" : ra.sT1;
            sT2 = ra.IssT1Null() ? "" : ra.sT2;
            sT3 = ra.IssT1Null() ? "" : ra.sT3;

            al.Add(ra.sHoliCode);
            al.Add(sT1);
            al.Add(sT2);
            al.Add(sT3);

            //沖假對象(只有喪假會有此情況)
            sName = ra.IssNameNull() ? "" : ra.sName;

            AbsTA.Fill(AbsDT, sNobr, "0", ra.dDateB, ra.dDateE, "");

            iMax = ra.iUse;
            iUse = 0;

            if (AbsDT.Rows.Count > 0)
            {
                foreach (string s in al)
                {
                    if (AbsDT.Select("sHoliCode = '" + s + "' AND sName = '" + sName + "'").Length > 0 && !als.Contains(s))
                        iUse += Convert.ToDecimal(AbsDT.Compute("Sum(iUse)", "sHoliCode = '" + s + "' AND sName = '" + sName + "'"));

                    als.Add(s);
                }
            }

            r = oAbsDS.AbsInfoData.NewAbsInfoDataRow();
            SetAbsInfoRowData(ra.sHoliCode, ra.sHoliName, ra.bInHoli, Convert.ToDecimal(ra.iMin), ra.iInterval, ra.sUint, iUse, iMax, iMax - iUse, ra.sYearRest, ra.sDcode, ra.bChe, ra.bDiscontent, ra.bDisplayform, ra.dDateB, ra.dDateE, ra.sName);
            oAbsDS.AbsInfoData.AddAbsInfoDataRow(r);
        }
    }

    //最大可休時數或天數相關假，如事假、病假，並將關聯相加，以及一般的假，例如公出、公傷
    private void InsertAbsDcode(string sNobr, DateTime dDateB, DateTime dDateE, DateTime dDate)
    {
        AbsDS.AbsDataTable AbsDT = new AbsDS.AbsDataTable();
        AbsDS.Abs1DataTable Abs1DT = new AbsDS.Abs1DataTable();
        AbsTA.FillByDate(AbsDT, sNobr, "0", dDateB, dDateE);
        Abs1TA.Fill(Abs1DT, sNobr, dDateB, dDateE);

        HcodeTA.Fill(oAbsDS.Hcode);
        foreach (AbsDS.HcodeRow ra in oAbsDS.Hcode.Rows)
        {
            if (ra.sYearRest == "0")
            {
                if (oAbsDS.AbsInfoData.Select("sHoliCode = '" + ra.sHCode + "'").Length == 0)
                {
                    iMax = Convert.ToDecimal(ra.iMax);
                    iUse = 0;
                    iUseH = 0;

                    if (AbsDT.Select("sHoliCode = '" + ra.sHCode + "'").Length > 0)
                    {
                        iUseH = Convert.ToDecimal(AbsDT.Compute("Sum(iUse)", "sHoliCode = '" + ra.sHCode + "'"));
                        iUse += iUseH;
                    }

                    if (AbsDT.Select("sHoliCode = '" + ra.sDcode + "'").Length > 0)
                        iUse += Convert.ToDecimal(AbsDT.Compute("Sum(iUse)", "sHoliCode = '" + ra.sDcode + "'"));

                    //再加上被併的假的最大值
                    rows = oAbsDS.Hcode.Select("sHCode = '" + ra.sDcode + "'");
                    if (rows.Length > 0)
                    {
                        AbsDS.HcodeRow rh = (AbsDS.HcodeRow)rows[0];
                        iMax += Convert.ToDecimal(rh.iMax);
                    }

                    //公出
                    if (Abs1DT.Select("sHoliCode = '" + ra.sHCode + "'").Length > 0)
                    {
                        iUseH = Convert.ToDecimal(Abs1DT.Compute("Sum(iUse)", "sHoliCode = '" + ra.sHCode + "'"));
                        iUse += iUseH;
                    }

                    if (Abs1DT.Select("sHoliCode = '" + ra.sDcode + "'").Length > 0)
                        iUse += Convert.ToDecimal(Abs1DT.Compute("Sum(iUse)", "sHoliCode = '" + ra.sDcode + "'"));

                    ////再加上被併的假的最大值
                    //rows = oAbsDS.Hcode.Select("sHCode = '" + ra.sDcode + "'");
                    //if (rows.Length > 0)
                    //{
                    //    AbsDS.HcodeRow rh = (AbsDS.HcodeRow)rows[0];
                    //    iMax += Convert.ToDecimal(rh.iMax);
                    //}

                    r = oAbsDS.AbsInfoData.NewAbsInfoDataRow();
                    SetAbsInfoRowData(ra.sHCode, ra.sHName, ra.bInHoli, Convert.ToDecimal(ra.iMin), ra.iAbsUnit, ra.sUint, iUseH, iMax, iMax - iUse, ra.sYearRest, ra.sDcode, ra.bChe, ra.bDiscontent, ra.bDisplayForm, dDateB, dDateE, "");
                    oAbsDS.AbsInfoData.AddAbsInfoDataRow(r);
                }
            }
        }
    }

    private void SetAbsInfoRowData(string sHoliCode, string sHoliName, bool bInHoli, decimal iMin, decimal iInterval, string sUint, decimal iUse, decimal iMax, decimal iBalance, string sYearRest, string sDcode, bool bChe, bool bDiscontent, bool bDisplayform, DateTime dDateB, DateTime dDateE, string sName)
    {
        r.sHoliCode = sHoliCode;
        r.sHoliName = sHoliName;
        r.bInHoli = bInHoli;
        r.iMin = iMin;
        r.iInterval = iInterval;
        r.sUint = sUint;
        r.iUse = iUse;
        r.iMax = iMax;
        r.iBalance = iBalance;
        r.sYearRest = sYearRest;
        r.sDcode = sDcode;
        r.bChe = bChe;
        r.bDiscontent = bDiscontent;
        r.bDisplayform = bDisplayform;
        r.dDateB = dDateB;
        r.dDateE = dDateE;
        r.sName = sName;
    }
}