using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;


/// <summary>
/// TransCardWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TransCardWS : System.Web.Services.WebService
{
    public TransCardDSTableAdapters.ATTENDTableAdapter ATTENDTA = new TransCardDSTableAdapters.ATTENDTableAdapter();
    public TransCardDSTableAdapters.ATTCARDTableAdapter ATTCARDTA = new TransCardDSTableAdapters.ATTCARDTableAdapter();
    public TransCardDSTableAdapters.CARDTableAdapter CARDTA = new TransCardDSTableAdapters.CARDTableAdapter();
    public TransCardDSTableAdapters.CARDLOSDTableAdapter CARDLOSDTA = new TransCardDSTableAdapters.CARDLOSDTableAdapter();
    public TransCardDSTableAdapters.AbsCheckTableAdapter AbsCheckTA = new TransCardDSTableAdapters.AbsCheckTableAdapter();
    public TransCardDSTableAdapters.WorkDayTableAdapter WorkDayTA = new TransCardDSTableAdapters.WorkDayTableAdapter();

    public TransCardDS oTransCardDS;

    public DataRow[] rows, rowsA, rowsB, rowsM, rowsS;

    public TransCardWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        return true;
    }

    public void AttCardEnd(string nobr, DateTime date, string KeyMan, bool chkAttcard, bool chkAttend, bool ezAttcard)
    {
        AttCardEnd1(nobr, date.AddDays(-1).Date, KeyMan, chkAttcard, chkAttend, ezAttcard);
        AttCardEnd1(nobr, date.Date, KeyMan, chkAttcard, chkAttend, ezAttcard);
    }

    //轉換時間及判斷異常(工號，日期，登入者，轉換時間，判斷異常，簡單轉換時間)
    public void AttCardEnd1(string nobr, DateTime date, string KeyMan, bool chkAttcard, bool chkAttend, bool ezAttcard)
    {
        oTransCardDS = new TransCardDS();
        WorkDayTA.FillByDate(oTransCardDS.WorkDay, nobr, date); //工作天相關資料

        string timeB, timeE;    //最早與最晚上下班時間
        DateTime datetimeB, datetimeE;  //最早與最晚上下班日期時間
        string timeA, timeD;    //實際上班與下班時間
        DateTime datetimeA, datetimeD;    //實際上班與下班日期時間

        //班別及時間的相關資料
        if (oTransCardDS.WorkDay.Rows.Count > 0)
        {
            TransCardDS.WorkDayRow rw = (TransCardDS.WorkDayRow)oTransCardDS.WorkDay.Rows[0];

            //假日班無需判斷
            if (rw.ROTE.Trim() != "00")
            {
                //前一天的下班時間等於今天的上班時間，今天的下班時間等於明天的最早上班時間
                timeE = GetOFFTIME2(nobr, date.Date);
                timeB = GetOFFTIME2(nobr, date.AddDays(-1).Date);
                timeB = timeB.Length > 0 ? timeB : timeE;    //也許第一天上班就要判斷，那就要用今天的最晚下班時間為今天的最早上班時間
                datetimeB = date.Date.AddMinutes(FlowCS.GetMinutes(timeB)); //因為是24小時制，所以要用今天的日期加上昨天的最晚下班時間
                datetimeE = date.AddDays(1).Date.AddMinutes(FlowCS.GetMinutes(timeE));  //因為是24小時制，所以要用明天的日期加上今天的最晚下班時間

                //填入該員工的刷卡資料
                CARDTA.FillByDate(oTransCardDS.CARD, nobr, datetimeB.AddDays(-1).Date, datetimeE.AddDays(1).Date);  //為防止例外情況，所以開始時間減1天，結束時間加1天

                //將資料填入暫存的Card的資料表裡，以利判斷
                TransCardDS.CardRow rc1;
                foreach (TransCardDS.CARDRow rc in oTransCardDS.CARD.Rows)
                {
                    rc1 = oTransCardDS.Card.NewCardRow();
                    rc1.dDate = rc.ADATE.Date;
                    rc1.sTime = rc.ONTIME.Trim();
                    rc1.dDateTime = rc1.dDate.AddMinutes(FlowCS.GetMinutes(rc1.sTime));
                    rc1.bLos = CARDLOSDTA.GetDataByCode(rc.REASON.Trim()).Rows.Count > 0;   //是否忘刷

                    //判斷刷卡時間是否在最早與最晚的上下班時間裡
                    if ((datetimeB <= rc1.dDateTime) && (rc1.dDateTime <= datetimeE))
                        oTransCardDS.Card.AddCardRow(rc1);
                }

                //寫入ATTCARD
                if (chkAttcard)
                {
                    ATTCARDTA.FillByDate(oTransCardDS.ATTCARD, nobr, date);
                    foreach (TransCardDS.ATTCARDRow r in oTransCardDS.ATTCARD.Rows) r.Delete(); //先刪除當天的資料
                    int j = ezAttcard ? (oTransCardDS.Card.Rows.Count > 0 ? 1 : 0) : Convert.ToInt32(Math.Ceiling(Convert.ToDouble(oTransCardDS.Card.Rows.Count) / 2));  //先除以2，再無條件進位

                    TransCardDS.ATTCARDRow rac;
                    int t, x1, x2;
                    for (int i = 0; i < j; i++)
                    {
                        x1 = (i == 0) ? 0 : (i * 2);
                        x2 = ezAttcard ? (oTransCardDS.Card.Rows.Count - 1) : (x1 + 1); //採用簡單判斷法，則取總筆數減1即可

                        rac = oTransCardDS.ATTCARD.NewATTCARDRow();
                        rac.NOBR = nobr;
                        rac.ADATE = date;
                        rac.T1 = "";
                        rac.T2 = "";
                        rac.CODE = "";
                        rac.SER = 1;
                        rac.KEY_MAN = KeyMan;
                        rac.KEY_DATE = DateTime.Now;
                        rac.DD1 = "";
                        rac.DD2 = "";
                        rac.LOST1 = false;
                        rac.LOST2 = false;
                        rac.TT1 = "";
                        rac.TT2 = "";
                        rac.NOMODY = false;

                        //T1的時間
                        rc1 = (TransCardDS.CardRow)oTransCardDS.Card.Rows[x1];
                        rac.T1 = date.Date < rc1.dDate.Date ? Convert.ToString(int.Parse(rc1.sTime) + 2400) : rc1.sTime;
                        t = FlowCS.GetMinutes(rac.T1);
                        rac.TT1 = (t > 1440) ? FlowCS.GetTimeSplit(DateTime.Now.Date.AddMinutes(t - 1440)) : rac.T1;    //有可能超過24小時，因此需要先轉換成24小時制

                        //有(x2)以上的刷卡資料(T2的時間)
                        if (oTransCardDS.Card.Rows.Count > x2 && oTransCardDS.Card.Rows.Count > 1)
                        {
                            rc1 = (TransCardDS.CardRow)oTransCardDS.Card.Rows[x2];
                            rac.T2 = date.Date < rc1.dDate.Date ? Convert.ToString(int.Parse(rc1.sTime) + 2400) : rc1.sTime;
                            t = FlowCS.GetMinutes(rac.T2); //24小時制
                            rac.TT2 = (t > 1440) ? FlowCS.GetTimeSplit(DateTime.Now.Date.AddMinutes(t - 1440)) : rac.T2;    //有可能超過24小時，因此需要先轉換成24小時制
                        }

                        oTransCardDS.ATTCARD.AddATTCARDRow(rac);
                    }

                    ATTCARDTA.Update(oTransCardDS.ATTCARD);
                }   //end if 寫入ATTCARD

                //判斷出勤寫入ATTEND
                if (chkAttend)
                {
                    AbsCheckTA.FillByNobr(oTransCardDS.AbsCheck, nobr, date);   //當天請假資料

                    //呼叫請假計算的服務
                    AbsCS.AbsCalculation oAbsCalculation, oAbsCalculationR;
                    oAbsCalculationR = AbsCS.CalculationAbs(nobr, "B", rw.ADATE, rw.ADATE, rw.ON_TIME.Trim(), rw.OFF_TIME.Trim(), "",0);

                    //先重新組合請假資料
                    TransCardDS.AbsRow r1;
                    foreach (TransCardDS.AbsCheckRow rac in oTransCardDS.AbsCheck.Rows)
                    {
                        //開始與結束時間一定要有值
                        if (rac.BTIME.Trim().Length > 0 && rac.ETIME.Trim().Length > 0)
                        {
                            r1 = oTransCardDS.Abs.NewAbsRow();
                            r1.dDateB = rac.BDATE.Date;
                            r1.dDateE = rac.BDATE.Date;
                            r1.sTimeB = rac.BTIME.Trim();
                            r1.sTimeE = rac.ETIME.Trim();
                            r1.dDateTimeB = r1.dDateB.AddMinutes(FlowCS.GetMinutes(r1.sTimeB));
                            r1.dDateTimeE = r1.dDateE.AddMinutes(FlowCS.GetMinutes(r1.sTimeE));
                            r1.sHcode = rac.H_CODE.Trim();
                            r1.sUnit = rac.UNIT.Trim();
                            r1.iTotal = rac.TOL_HOURS;
                            r1.iDay = (r1.sUnit == "天") ? r1.iTotal : r1.iTotal / rw.WK_HRS;
                            r1.iHour = (r1.sUnit == "小時") ? r1.iTotal : r1.iTotal * rw.WK_HRS;
                            r1.iMin = r1.iHour * 60;
                            oTransCardDS.Abs.AddAbsRow(r1);
                        }
                    }

                    ATTENDTA.FillByDate(oTransCardDS.ATTEND, nobr, date);
                    //先判斷有沒有當天的出勤資料
                    if (oTransCardDS.ATTEND.Rows.Count > 0)
                    {
                        DateTime datetimeX, datetimeY;
                        DateTime datetimeI, datetimeJ;
                        bool bTemp;
                        TimeSpan tsTemp;
                        int i, j;

                        TransCardDS.ATTENDRow ra = (TransCardDS.ATTENDRow)oTransCardDS.ATTEND.Rows[0];
                        ra.LATE_MINS = 0;   //遲到分鐘數
                        ra.E_MINS = 0;  //早退分鐘數
                        ra.ABS = false; //是否有請假(true == 曠職)
                        ra.FORGET = oTransCardDS.Card.Select("bLos = 1").Length;    //忘刷次數

                        timeA = rw.ON_TIME.Trim();   //實際上班時間
                        timeD = rw.OFF_TIME.Trim(); //實際下班時間
                        datetimeA = date.Date.AddMinutes(FlowCS.GetMinutes(timeA)); //實際上班時間
                        datetimeD = date.Date.AddMinutes(FlowCS.GetMinutes(timeD)); //實際下班時間

                        //忘刷次數小於等於1：比對請假資料
                        //忘刷次數大於等於2：比對上下班時間
                        //請假時間不正確再比對請假資料

                        //有刷卡資料
                        if (oTransCardDS.Card.Rows.Count > 0)
                        {
                            datetimeB = ((TransCardDS.CardRow)oTransCardDS.Card.Rows[0]).dDateTime; //實際上班刷卡時間

                            //===============================判斷遲到分鐘數========================================================
                            datetimeJ = datetimeA.AddMinutes(Convert.ToDouble(rw.ALLLATES));    //先加入可遲到分鐘數
                            datetimeX = datetimeJ.AddMinutes(Convert.ToDouble(rw.ALLLATES1));   //再加入彈性分鐘數
                            if (datetimeB > datetimeX)
                            {
                                //檢查是否有請假資料
                                bTemp = true;   //true == 無請假資料
                                datetimeI = datetimeB;  //放入暫存的時間裡

                                //先判斷上班刷卡是否在休息時間裡，如果是，那麼就把上班刷卡時間變成該休息時間之開始時間
                                if (oAbsCalculationR.dDayDate.Length > 0)
                                    foreach (AbsCS.DayRes dr in oAbsCalculationR.dDayDate[0].dDayRes)
                                        datetimeI = (datetimeI > dr.dDateB && datetimeI <= dr.dDateE) ? dr.dDateB : datetimeI;

                                i = 0;
                                TransCardDS.AbsRow raa;
                                //請假索引每次遞增1，如果請假的開始時間大於上班時間，那麼就歸0重找一次
                                while ((oTransCardDS.Abs.Rows.Count > 0) && (i < oTransCardDS.Abs.Rows.Count))
                                {
                                    raa = (TransCardDS.AbsRow)oTransCardDS.Abs.Rows[i];

                                    //先判斷上班刷卡是否在休息時間裡，如果是，那麼就把上班刷卡時間變成該休息時間之開始時間
                                    if (oAbsCalculationR.dDayDate.Length > 0)                                    
                                        foreach (AbsCS.DayRes dr in oAbsCalculationR.dDayDate[0].dDayRes)                                        
                                            datetimeI = (datetimeI > dr.dDateB && datetimeI <= dr.dDateE) ? dr.dDateB : datetimeI;
  
                                    //上班刷卡時間是否於請假時間裡(抓到的這筆有可能並不是由上班時間所請的假)
                                    if ((datetimeI >= raa.dDateTimeB) && (datetimeI <= raa.dDateTimeE))
                                    {
                                        r1 = raa;

                                        //如果請假開始時間小於或等於實際上班時間就出去(特別狀況，小狐狸可能沒有判斷)
                                        if (raa.dDateTimeB <= datetimeA)    //此處可能有爭議，因為我是抓實際上班時間來判斷
                                        {
                                            bTemp = false;
                                            break;
                                        }
                                        else
                                        {
                                            i = -1;
                                            datetimeI = r1.dDateTimeB.AddMinutes(-1);  //datetimeI是此次請假的開始時間減1分鐘才不會有重複的問題
                                        }
                                    }

                                    i++;
                                }

                                //無請假資料
                                if (bTemp)
                                {
                                    datetimeI = (datetimeI == datetimeB) ? datetimeI : datetimeI.AddMinutes(1); //如果跟原本的刷卡時間不同，代表有特別狀況，應把原本的1分鐘加回來
                                    tsTemp = datetimeI - datetimeX;
                                    oAbsCalculation = AbsCS.CalculationAbs(nobr, "B", datetimeX.Date, datetimeI.Date, FlowCS.GetTimeSplit(datetimeX), FlowCS.GetTimeSplit(datetimeI), "",0);
                                    //先判斷刷卡時間是否在下班時間之後
                                    i = (datetimeD <= datetimeB) ? Convert.ToInt32(Convert.ToDouble(rw.WK_HRS) * 60) : Convert.ToInt32(tsTemp.TotalMinutes);
                                    ra.LATE_MINS = Convert.ToDecimal(i);
                                }
                            }   //end if 判斷遲到分鐘數

                            //有可能沒有第2筆刷卡資料，為了判是否有早退，只好借由T1的刷卡時間來判斷
                            i = (oTransCardDS.Card.Rows.Count > 1) ? (oTransCardDS.Card.Rows.Count - 1) : 0;
                            datetimeE = ((TransCardDS.CardRow)oTransCardDS.Card.Rows[i]).dDateTime;  //實際下班刷卡時間

                            //可遲到分鐘數與彈性分鐘數同時存在時，那以可遲到分鐘數先使用，再使用彈性分鐘數
                            //刷卡時間必須是加入可遲到分鐘數的時間 到 加入彈性分鐘數的時間的裡面
                            tsTemp = ((datetimeJ < datetimeB) && (datetimeB <= datetimeX)) ? (datetimeB - datetimeJ) : (datetimeB - datetimeB);
                            datetimeY = datetimeD.AddMinutes(tsTemp.TotalMinutes);

                            //==========================判斷早退分鐘數=================================================
                            if (datetimeE < datetimeY)
                            {
                                //檢查是否有請假資料
                                bTemp = true;   //true == 無請假資料
                                datetimeI = datetimeE;  //放入暫存的時間裡

                                //先判斷下班刷卡是否在休息時間裡，如果是，那麼就把下班刷卡時間變成該休息時間之結束時間
                                if (oAbsCalculationR.dDayDate.Length > 0)
                                    foreach (AbsCS.DayRes dr in oAbsCalculationR.dDayDate[0].dDayRes)
                                        datetimeI = (datetimeI >= dr.dDateB && datetimeI < dr.dDateE) ? dr.dDateE : datetimeI;
                                i = 0;
                                TransCardDS.AbsRow raa;
                                //請假索引每次遞增1，如果請假的結束時間小於下班時間，那麼就歸0重找一次
                                while ((oTransCardDS.Abs.Rows.Count > 0) && (i < oTransCardDS.Abs.Rows.Count))
                                {
                                    raa = (TransCardDS.AbsRow)oTransCardDS.Abs.Rows[i];

                                    //先判斷下班刷卡是否在休息時間裡，如果是，那麼就把下班刷卡時間變成該休息時間之結束時間
                                    if (oAbsCalculationR.dDayDate.Length > 0)
                                        foreach (AbsCS.DayRes dr in oAbsCalculationR.dDayDate[0].dDayRes)
                                            datetimeI = (datetimeI >= dr.dDateB && datetimeI < dr.dDateE) ? dr.dDateE : datetimeI;

                                    //最後下班時間與某段休息時間相撞，因此直接取下班時間當結束時間
                                    datetimeI = datetimeI >= datetimeE ? datetimeE : datetimeI;

                                    //下班刷卡時間是否於請假時間裡(抓到的這筆有可能並不是由下班時間所請的假)
                                    if ((datetimeI >= raa.dDateTimeB) && (datetimeI <= raa.dDateTimeE))
                                    {
                                        r1 = raa;

                                        //如果請假結束時間大於或等於實際下班時間就出去(特別狀況，小狐狸可能沒有判斷)
                                        if (raa.dDateTimeE >= datetimeD)    //此處可能有爭議，因為我是抓實際下班時間來判斷
                                        {
                                            bTemp = false;
                                            break;
                                        }
                                        else
                                        {
                                            i = -1;
                                            datetimeI = r1.dDateTimeE.AddMinutes(1);  //datetimeI是此次請假的結束時間加1分鐘才不會有重複的問題
                                        }
                                    }

                                    i++;
                                }

                                //無請假資料
                                if (bTemp)
                                {
                                    datetimeI = (datetimeI == datetimeE) ? datetimeI : datetimeI.AddMinutes(-1); //如果跟原本的刷卡時間不同，代表有特別狀況，應把原本的1分鐘減回來
                                    tsTemp = datetimeY - datetimeI;
                                    oAbsCalculation = AbsCS.CalculationAbs(nobr, "B", datetimeI.Date, datetimeY.Date, FlowCS.GetTimeSplit(datetimeI), FlowCS.GetTimeSplit(datetimeY), "",0);
                                    //先判斷刷卡時間是否在上班時間之前
                                    i = (datetimeI <= datetimeJ) ? Convert.ToInt32(Convert.ToDouble(rw.WK_HRS) * 60) : Convert.ToInt32(tsTemp.TotalMinutes);
                                    ra.E_MINS = Convert.ToDecimal(i);
                                }
                            }
                        }
                        else
                        {
                            //無刷卡資料(有可能曠職)
                            //如果有一筆請假資料，但沒有請足時數，需要算出遲到或早退時間

                            //檢查是否有請假資料
                            bTemp = true;   //true == 無請假資料
                            i = 0;
                            j = 0;
                            TransCardDS.AbsRow raa;
                            datetimeX = datetimeA;
                            datetimeY = datetimeD;
                            //請假索引每次遞增1
                            while ((oTransCardDS.Abs.Rows.Count > 0) && (i < oTransCardDS.Abs.Rows.Count))
                            {
                                raa = (TransCardDS.AbsRow)oTransCardDS.Abs.Rows[i];
                                //因為請假有可能會有很多筆資料，所以我要抓取當天中，最早的請假時間與最晚的請假時間來當做刷卡時間

                                datetimeX = (i == 0) ? raa.dDateTimeB : ((raa.dDateTimeB < datetimeX) ? raa.dDateTimeB : datetimeX);    //最早的請假時間
                                datetimeY = (i == 0) ? raa.dDateTimeE : ((raa.dDateTimeE > datetimeY) ? raa.dDateTimeE : datetimeY);    //最晚的請假時間

                                j += Convert.ToInt32(raa.iMin); //計算所有假的總分鐘數

                                i++;
                            }

                            if (j > 0)
                            {
                                i = Convert.ToInt32(rw.WK_HRS * 60);    //全日工作分鐘數

                                //如果請假分鐘數不足全日工作分鐘數
                                if (j < i)
                                {
                                    //如果請假開始時間大於上班時間
                                    if (datetimeA < datetimeX)
                                    {
                                        oAbsCalculation = AbsCS.CalculationAbs(nobr, "A", datetimeA.Date, datetimeX.Date, FlowCS.GetTimeSplit(datetimeA), FlowCS.GetTimeSplit(datetimeX) , "",0);
                                        ra.LATE_MINS = Convert.ToDecimal(oAbsCalculation.iHour * 60);
                                    }

                                    //如果請假結束時間小於下班時間
                                    if (datetimeD > datetimeY)
                                    {
                                        oAbsCalculation = AbsCS.CalculationAbs(nobr, "A", datetimeY.Date, datetimeD.Date, FlowCS.GetTimeSplit(datetimeY), FlowCS.GetTimeSplit(datetimeD) , "",0);
                                        ra.E_MINS = Convert.ToDecimal(oAbsCalculation.iHour * 60);
                                    }

                                }
                            }
                            else
                                ra.ABS = true;  //曠職
                        }

                        //如果不是簡單判斷法而且當天請假筆數大於1
                        if (!ezAttcard && oTransCardDS.Abs.Rows.Count > 0)
                        {

                        }

                        ra.KEY_MAN = KeyMan;
                        ra.KEY_DATE = DateTime.Now;
                        ATTENDTA.Update(oTransCardDS.ATTEND);
                    }   //end if 判斷ATTEND有1筆資料
                }   //end if 判斷出勤寫入ATTEND
            }   //end if 假日班無需判斷
        }   //end if 班別及時間的相關資料
    }

    //取得最早與最晚的上下班時間
    public string GetOFFTIME2(string nobr, DateTime date)
    {
        string time = "";
        rows = WorkDayTA.GetDataByDate(nobr, date).Select();
        return (rows.Length > 0) ? ((TransCardDS.WorkDayRow)rows[0]).OFFTIME2.Trim() : time;
    }
}