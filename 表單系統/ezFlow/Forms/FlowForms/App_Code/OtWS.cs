using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;

/// <summary>
/// OtWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class OtWS : System.Web.Services.WebService
{
    //Form
    public OtDSTableAdapters.wfOtAppMTableAdapter wfOtAppMTA = new OtDSTableAdapters.wfOtAppMTableAdapter();
    public OtDSTableAdapters.wfOtAppSTableAdapter wfOtAppSTA = new OtDSTableAdapters.wfOtAppSTableAdapter();
    public OtDSTableAdapters.OTTableAdapter OTTA = new OtDSTableAdapters.OTTableAdapter();

    //Abs如果選補休假
    public OtDSTableAdapters.ABSTableAdapter ABSTA = new OtDSTableAdapters.ABSTableAdapter();

    //DataSet
    public OtDS oOtDS;

    public DataRow[] rows;

    public OtWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true; //true表示成功
        oOtDS = new OtDS();

        //string ProcessID = FlowCS.GetProcessID("ApView", ID);
        string ProcessID = ID.ToString();

        wfOtAppMTA.FillByProcessID(oOtDS.wfOtAppM, ProcessID);
        wfOtAppSTA.FillByProcessID(oOtDS.wfOtAppS, ProcessID);

        if (oOtDS.wfOtAppM.Rows.Count == 0 || oOtDS.wfOtAppS.Rows.Count == 0)
            return false;

        //WebServices開始
        OtDS.wfOtAppMRow rm;
        rm = (OtDS.wfOtAppMRow)oOtDS.wfOtAppM.Rows[0];
        rm.sState = "5";
        wfOtAppMTA.Update(rm);
        wfOtAppMTA.FillByProcessID(oOtDS.wfOtAppM, ProcessID);
        rm = (OtDS.wfOtAppMRow)oOtDS.wfOtAppM.Rows[0];

        //OTTA.Fill(oOtDS.OT);
        OtDS.OTRow ro;
        OtDS.ABSRow ra;
        OtCS.OtCalculation oOtCalculation;
        DateTime DateTimeB, DateTimeE;
        HrBaseData oHrBaseData;
        bool isOt; //true表示沒有加班
        foreach (OtDS.wfOtAppSRow rs in oOtDS.wfOtAppS.Rows)
        {
            if (rs.sState != "2")
            {
                //計算加班時數
                oHrBaseData = new HrBaseData(rs.sNobr);
                string rotet = rs.sRoteCode == "0" ? oHrBaseData.sRotet : rs.sRoteCode;
                oOtCalculation = OtCS.CalculationOt(rs.sNobr, rotet,rs.dStrDate.Date, rs.dStrDateTime, rs.dEndDateTime);

                isOt = true;

                rows = OTTA.GetDataByKey(rs.sNobr, rs.dStrDate.Date).Select();
                //rows = oOtDS.OT.Select("NOBR = '" + rs.sNobr + "' AND BDATE = '" + rs.dStrDate.ToShortDateString() + "' AND BTIME <> '' AND ETIME <> ''");
                foreach (OtDS.OTRow ro1 in rows)
                {
                    if (ro1.BTIME.Trim().Length == 4 && ro1.ETIME.Trim().Length == 4)
                    {
                        DateTimeB = ro1.BDATE.Date.AddMinutes(FlowCS.GetMinutes(ro1.BTIME.Trim()));
                        DateTimeE = ro1.BDATE.Date.AddMinutes(FlowCS.GetMinutes(ro1.ETIME.Trim()));

                        isOt = !((DateTimeB < rs.dEndDateTime) && (DateTimeE > rs.dStrDateTime));

                        //不在此加班區間方可寫入加班資料表
                        if (!isOt)
                            break;
                    }
                }

                if (isOt)
                {
                    DateTime d = new DateTime(rs.dStrDate.AddMonths(6).Year, rs.dStrDate.AddMonths(6).Month, DateTime.DaysInMonth(rs.dStrDate.AddMonths(6).Year, rs.dStrDate.AddMonths(6).Month));  //瑤姐說要取到6個月的月底20100507 //rs.dStrDate.Date.AddMonths(6);
                    DateTime d1 = DateTime.Parse(rs.dStrDate.Year.ToString() + "/12/31");

                    ro = oOtDS.OT.NewOTRow();
                    FlowCS.SetRowDefaultValue(ro);
                    ro.NOBR = rs.sNobr;
                    ro.BDATE = rs.dStrDate;
                    ro.BTIME = rs.sStrTime;
                    ro.ETIME = rs.sEndTime;
                    ro.TOT_HOURS = !rs.bCal ? Convert.ToDecimal(oOtCalculation.iHour) : rs.iTotalHour;
                    ro.OT_HRS = (rs.sOtcatCode == "1") ? ro.TOT_HOURS : 0;
                    ro.REST_HRS = (rs.sOtcatCode == "2") ? ro.TOT_HOURS : 0;
                    ro.OT_DEPT = oHrBaseData.sDepts.Trim();
                    ro.KEY_MAN = rm.sName + "e";
                    ro.NOTE = rs.sNote;
                    ro.YYMM = HrCS.SetYYMM(rs.dStrDate);    //計薪年月
                    ro.OT_EDATE = d;// d >= d1 ? d1 : d;
                    ro.OT_ROTE = oOtCalculation.sRote;  //班別
                    ro.OTRATE_CODE = oHrBaseData.sCalot;    //班別群組
                    ro.OTRCD = rs.sOtrcdCode;
                    ro.SERNO = FlowCS.GetSerno("O", ro.BDATE);
                    ro.DIFF = rs.iTotalDiff;
                    ro.EAT = rs.bEat;
                    ro.RES = rs.bRes;
                    ro.EAT1 = rs.bEat1;
                    ro.EAT2 = rs.bEat2;
                    ro.EAT3 = rs.bEat3;
                    ro.EAT4 = rs.bEat4;

                    ro.REPAIR = false;
                    oOtDS.OT.AddOTRow(ro);

                    //如果選補休
                    if (rs.sOtcatCode == "2")
                    {
                        ra = oOtDS.ABS.NewABSRow();
                        FlowCS.SetRowDefaultValue(ra);
                        ra.NOBR = rs.sNobr;
                        ra.BDATE = ro.BDATE.Date;
                        ra.EDATE = d;   // d >= d1 ? d1 : d; 
                        ra.BTIME = rs.sStrTime;
                        ra.ETIME = rs.sEndTime;
                        ra.H_CODE = "W2";
                        ra.TOL_HOURS = ro.REST_HRS;
                        ra.KEY_MAN = rm.sName + "e";
                        ra.YYMM = HrCS.SetYYMM(ra.BDATE.Date);
                        ra.NOTE = rs.sOtcatName;
                        ra.SERNO = "";
                        ra.A_NAME = "20100507";
                        oOtDS.ABS.AddABSRow(ra);
                    }
                }

                rs.sState = "3";
            }
        }

        OTTA.Update(oOtDS.OT);
        ABSTA.Update(oOtDS.ABS);
        wfOtAppSTA.Update(oOtDS.wfOtAppS);
        rm = (OtDS.wfOtAppMRow)oOtDS.wfOtAppM.Rows[0];
        rm.dDateD = DateTime.Now;
        rm.sState = "6";    //WebServices結束
        wfOtAppMTA.Update(rm);

        return isPass;
    }
}