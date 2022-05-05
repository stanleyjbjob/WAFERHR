using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;

/// <summary>
/// RoteWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class RoteWS : System.Web.Services.WebService {
    public RoteDSTableAdapters.BaseRelRotetTableAdapter BaseRelRotetTA = new RoteDSTableAdapters.BaseRelRotetTableAdapter();
    public RoteDSTableAdapters.HoliRelHolicdTableAdapter HoliRelHolicdTA = new RoteDSTableAdapters.HoliRelHolicdTableAdapter();
    public RoteDSTableAdapters.TMTABLETableAdapter TMTABLETA = new RoteDSTableAdapters.TMTABLETableAdapter();
    public RoteDSTableAdapters.ATTENDTableAdapter ATTENDTA = new RoteDSTableAdapters.ATTENDTableAdapter();
    public RoteDSTableAdapters.ROTECHGTableAdapter ROTECHGTA = new RoteDSTableAdapters.ROTECHGTableAdapter();

    //Shift 調班單
    public ShiftDSTableAdapters.wfShiftAppMTableAdapter wfShiftAppMTA = new ShiftDSTableAdapters.wfShiftAppMTableAdapter(); 
    public ShiftDSTableAdapters.wfShiftAppSTableAdapter wfShiftAppSTA = new ShiftDSTableAdapters.wfShiftAppSTableAdapter();

    public RoteDS oRoteDS;

    public DataRow[] rows, rowsA, rowsB, rowsM, rowsS;

    public RoteWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true;

        string ProcessID = FlowCS.GetProcessID("ApView", ID);

        oRoteDS = new RoteDS();

        rowsM = wfShiftAppMTA.GetDataByProcessID(ProcessID).Select();
        if (rowsM.Length > 0)
        {
            ShiftDS.wfShiftAppMRow rm = (ShiftDS.wfShiftAppMRow)rowsM[0];
            rowsS = wfShiftAppSTA.GetDataByProcessID(rm.sProcessID).Select();

            foreach (ShiftDS.wfShiftAppSRow rs in rowsS)
            {
                DateTime dateB , dateE;
                dateB = rs.dAim;
                dateE = rs.dAuthority;

                for (DateTime i = rs.dAim; i <= dateB.AddMonths(3); i = i.AddMonths(1))
                {
                    TmTable(rs.sNobr, rs.sNobr, i, rm.sName);
                    AttEnd(rs.sNobr, rs.sNobr, i, rm.sName);
                }

                //如果兩者相調月份不同  20080306 by ming 用珍
                if (rs.dAim.Month != rs.dAuthority.Month)
                {
                    for (DateTime i = rs.dAuthority; i <= dateE.AddMonths(3); i = i.AddMonths(1))
                    {
                        TmTable(rs.sNobr, rs.sNobr, i, rm.sName);
                        AttEnd(rs.sNobr, rs.sNobr, i, rm.sName);
                    }
                }

                //如果是短調
                if (rs.sNobr != rs.sNobrB)
                {
                    TmTable(rs.sNobrB, rs.sNobrB, rs.dAuthority, rm.sName);
                    AttEnd(rs.sNobrB, rs.sNobrB, rs.dAuthority, rm.sName);

                    //如果兩者相調月份不同 20080306 by ming 用珍
                    if (rs.dAim.Month != rs.dAuthority.Month)
                    {
                        TmTable(rs.sNobrB, rs.sNobrB, rs.dAim, rm.sName);
                        AttEnd(rs.sNobrB, rs.sNobrB, rs.dAim, rm.sName);
                    }
                }
            }
        }
        //for (int i = 2; i < 12; i++)
        //{
        //    DateTime date = new DateTime(2008, i, 1);
        //    TmTable("00001", "99999", date, "曾昭明");
        //    AttEnd("00001", "99999", date, "曾昭明");
        //}

        return isPass;
    }

    //排班以每個人及每個月為基準

    //取得整月的開始日期或結束日期(cat = "s" = 開始)
    public DateTime GetDate(DateTime date, string cat) {
        int yy = date.Year;
        int mm = date.Month;
        int dd = (cat == "s") ? 1 : DateTime.DaysInMonth(yy, mm);

        return new DateTime(yy, mm, dd);
    }

    public string GetYYMM(DateTime date) {
        int yy = date.Year - 1911;
        int mm = date.Month;

        return yy.ToString().PadLeft(3, char.Parse("0")) + mm.ToString().PadLeft(2, char.Parse("0"));
    }

    //產生TMTABLE
    public void TmTable(string nobrS, string nobrE, DateTime date, string KeyMan) {
        //將整個月的日期區間轉換出來
        DateTime adate, ddate;
        adate = GetDate(date, "s");
        ddate = GetDate(date, "");

        //取得本月yymm跟上個月的yymm
        string yymmNow, yymmOld;
        yymmNow = GetYYMM(date.Date);
        yymmOld = GetYYMM(date.Date.AddMonths(-1));

        //取得個人或全公司排班基本資料
        BaseRelRotetTA.Fill(oRoteDS.BaseRelRotet, adate, ddate, nobrS, nobrE, yymmOld);

        string sInHoli; //假日輪班
        string sRote;   //班別代碼
        string sDay;    //每日代碼(欄位專用)
        int iNO;   //上班輪的最後一個班別
        DateTime dDateS, dDateE;   //當月日期開始及結束
        Hashtable htRote; //班表暫存區R1-R10

        //那些人需要產生班表
        rows = BaseRelRotetTA.GetDataByGetDate(nobrS, nobrE, yymmOld).Select("", "NOBR");
        foreach (RoteDS.BaseRelRotetRow rb in rows) {
            iNO = Convert.ToInt32(rb.NO);

            //刪除TMTABLE相關資料
            TMTABLETA.Delete(yymmNow, rb.NOBR.Trim());

            //新增一筆資料
            RoteDS.TMTABLERow rt = oRoteDS.TMTABLE.NewTMTABLERow();
            rt.YYMM = yymmNow;
            rt.NOBR = rb.NOBR.Trim();

            //第一次先加入每個日期的班別，因為可能會有人到職未滿一個月或是一個月沒有31天
            for (int i = 1; i <= 31; i++)
                rt["D" + i.ToString()] = "";

            //開始替每個人產生輪班資料，由於每個人於當月有可能會有異動
            rowsA = oRoteDS.BaseRelRotet.Select("NOBR = '" + rb.NOBR.Trim() + "'", "ADATE");
            foreach (RoteDS.BaseRelRotetRow rbA in rowsA) {
                //先依照假日輪班來決定是否要參考行事曆(Holi)
                sInHoli = rbA.INHOLI.Trim();
                htRote = new Hashtable();

                //將輪班班別放入Hashtable(htRote)
                for (int i = 1; i <= 10; i++) {
                    sRote = "R" + i.ToString(); //先將欄位名稱拼出來並檢查該欄位是否存在
                    if (oRoteDS.BaseRelRotet.Columns.Contains(sRote)) {
                        sRote = rbA[sRote].ToString().Trim();
                        //判斷值的字串是否大於零
                        if (sRote.Length > 0)
                            htRote.Add(i, sRote);
                    }
                }

                //由於一個月可能有一次以上的異動班別，因此需要一段區間來當做班別的產生
                dDateS = (rbA.ADATE.Date <= adate.Date) ? adate.Date : rbA.ADATE.Date;
                dDateE = (rbA.DDATE >= ddate.Date) ? ddate.Date : rbA.DDATE.Date;

                //行事曆
                HoliRelHolicdTA.FillByHolicd(oRoteDS.HoliRelHolicd, rbA.HOLI_CODE.Trim(), adate, ddate);

                for (DateTime i = dDateS; i <= dDateE; i = i.AddDays(1)) {
                    sDay = "D" + i.Day.ToString();  //每日欄位名稱

                    //行事曆
                    rowsB = oRoteDS.HoliRelHolicd.Select("H_DATE = '" + i.Date + "'");
                    if (rowsB.Length > 0 && sInHoli != "1") {
                        rt[sDay] = "00";

                        if (sInHoli == "2")
                            continue;
                    }

                    //輪班頻率
                    switch (rbA.FREQ.Trim()) {
                        case "1":  //每日
                            //用本月第一天所要接續的班進行遞增(目前班別小於總班別進行加1否則班別序等於1)
                            iNO = (iNO < htRote.Count) ? ++iNO : 1;
                            break;
                        case "2":   //每週
                            //判斷是否為星期一，是星期一就跳下週的輪班序；否則就照原本輪班序跑
                            iNO = (i.DayOfWeek.ToString() == "Monday") ? ((iNO < htRote.Count) ? ++iNO : 1) : iNO;
                            break;
                        case "3":   //每月
                            iNO = (i.Day == 1) ? ((iNO < htRote.Count) ? ++iNO : 1) : iNO;
                            break;
                        case "4":   //自訂天數
                            break;
                        case "5":   //指定一週
                            break;
                        case "6":   //上下月
                            break;
                        default:    //不可預期
                            break;
                    }

                    rt[sDay] = htRote[iNO];

                    //假日輪班
                    switch (sInHoli) {
                        case "1":   //1.假日輪班
                            break;
                        case "2":   //2.影響輪班頻率
                            rt[sDay] = (rowsB.Length > 0) ? "00" : htRote[iNO];
                            break;
                        case "3":   //3.不影響輪班頻率
                            rt[sDay] = (rowsB.Length > 0) ? "00" : htRote[iNO];
                            break;
                        default:    //不可預期
                            break;
                    }

                    //把短期調班的日期訂正過來
                    rowsB = ROTECHGTA.GetData(i.Date, rb.NOBR.Trim()).Select();
                    if (rowsB.Length > 0) {
                        RoteDS.ROTECHGRow rr = (RoteDS.ROTECHGRow)rowsB[0];
                        rt[sDay] = (rb.NOBR.Trim() == rr.NOBR.Trim()) ? rr.ROTE.Trim() : rr.B_ROTE.Trim();
                    }
                } //end for
            }

            rt.KEY_MAN = KeyMan + "e";
            rt.KEY_DATE = DateTime.Now;
            rt.NO = iNO;
            rt.HOLIS = 0;
            rt.FREQ_NO = 0;
            oRoteDS.TMTABLE.AddTMTABLERow(rt);
        }

        TMTABLETA.Update(oRoteDS.TMTABLE);
    }

    //產生個人班表
    public void AttEnd(string nobrS, string nobrE, DateTime date, string KeyMan) {
        //將整個月的日期區間轉換出來
        DateTime adate, ddate;
        adate = GetDate(date, "s");
        ddate = GetDate(date, "");

        //取得本月yymm跟上個月的yymm
        string yymmNow, yymmOld;
        yymmNow = GetYYMM(date.Date);
        yymmOld = GetYYMM(date.Date.AddMonths(-1));

        string sRote;   //班別代碼

        //那些人需要產生班表
        rows = BaseRelRotetTA.GetDataByGetDate(nobrS, nobrE, yymmNow).Select("", "NOBR");
        foreach (RoteDS.BaseRelRotetRow rb in rows) {
            //帶出欲產生月份的排班資料(TMTABLE)
            rowsA = TMTABLETA.GetDataByYYMM(yymmNow, rb.NOBR.Trim()).Select();
            if (rowsA.Length > 0) {
                //先刪除原本的資料(整月)
                ATTENDTA.Delete(rb.NOBR.Trim(), adate, ddate);

                RoteDS.TMTABLERow rt = (RoteDS.TMTABLERow)rowsA[0];
                //將輪班班別放入Hashtable(htRote)
                for (DateTime i = adate; i <= ddate;i = i.AddDays(1)) {
                    sRote = "D" + i.Day.ToString(); //先將欄位名稱拼出來並檢查該欄位是否存在
                    if (oRoteDS.TMTABLE.Columns.Contains(sRote)) {
                        sRote = rt[sRote].ToString().Trim();
                        //判斷值的字串是否大於零
                        if (sRote.Length > 0) {
                            RoteDS.ATTENDRow ra = oRoteDS.ATTEND.NewATTENDRow();
                            ra.NOBR = rb.NOBR.Trim();
                            ra.ADATE = i;
                            ra.ROTE = sRote;
                            ra.KEY_MAN = KeyMan + "e";
                            ra.KEY_DATE = DateTime.Now;
                            ra.LATE_MINS = 0;
                            ra.E_MINS = 0;
                            ra.ABS = false;
                            ra.ADJ_CODE = "";
                            ra.CANT_ADJ = false;
                            ra.SER = 0;
                            ra.NIGHT_HRS = 0;
                            ra.FOODAMT = 0;
                            ra.FOODSALCD = "";
                            ra.FORGET = 0;
                            ra.ATT_HRS = 0;
                            ra.ROTEAMT = 0;
                            ra.ROTESALCD = "";
                            ra.AMT = 0;
                            ra.MONTHAMT = 0;
                            oRoteDS.ATTEND.AddATTENDRow(ra);
                        }
                    }
                }   //end for
            }   //end if rowsA
        }

        ATTENDTA.Update(oRoteDS.ATTEND);
    }
}