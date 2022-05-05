using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;


/// <summary>
/// RepairWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class RepairWS : System.Web.Services.WebService
{
    //Form
    public RepairDSTableAdapters.wfRepairAppMTableAdapter wfRepairAppMTA = new RepairDSTableAdapters.wfRepairAppMTableAdapter();
    public RepairDSTableAdapters.wfRepairAppSTableAdapter wfRepairAppSTA = new RepairDSTableAdapters.wfRepairAppSTableAdapter();
    public RepairDSTableAdapters.REPAIRTableAdapter REPAIRTA = new RepairDSTableAdapters.REPAIRTableAdapter();
    public RepairDSTableAdapters.OTTableAdapter OTTA = new RepairDSTableAdapters.OTTableAdapter();

    //Hr
    public HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();

    //Abs如果選補休假
    public OtDSTableAdapters.ABSTableAdapter ABSTA = new OtDSTableAdapters.ABSTableAdapter();
    public OtDSTableAdapters.AbsCheckTableAdapter AbsCheckTA = new OtDSTableAdapters.AbsCheckTableAdapter();

    //DataSet
    public RepairDS oRepairDS;
    public HrDS oHrDS;
    public OtDS oOtDS;

    public DataRow[] rows;

    public RepairWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true; //true表示成功
        oRepairDS = new RepairDS();
        oHrDS = new HrDS();
        oOtDS = new OtDS();

        //string ProcessID = FlowCS.GetProcessID("ApView", ID);
        string ProcessID = ID.ToString();

        wfRepairAppMTA.FillByProcessID(oRepairDS.wfRepairAppM, ProcessID);
        wfRepairAppSTA.FillByProcessID(oRepairDS.wfRepairAppS, ProcessID);

        if (oRepairDS.wfRepairAppM.Rows.Count == 0 || oRepairDS.wfRepairAppS.Rows.Count == 0)
            return false;

        //WebServices開始
        RepairDS.wfRepairAppMRow rm;
        rm = (RepairDS.wfRepairAppMRow)oRepairDS.wfRepairAppM.Rows[0];
        rm.sState = "5";
        wfRepairAppMTA.Update(rm);
        wfRepairAppMTA.FillByProcessID(oRepairDS.wfRepairAppM, ProcessID);
        rm = (RepairDS.wfRepairAppMRow)oRepairDS.wfRepairAppM.Rows[0];

        REPAIRTA.Fill(oRepairDS.REPAIR);
        RepairDS.REPAIRRow rr;
        RepairDS.OTRow ro;
        OtDS.ABSRow ra;
        HrBaseData oHrBaseData;
        DateTime DateTimeB, DateTimeE;
        bool isRepair = true; //true表示沒有請假
        string yymm = Convert.ToString(DateTime.Now.AddMonths(1).Year - 1911) + DateTime.Now.AddMonths(1).Month.ToString().PadLeft(2, char.Parse("0"));
        yymm = yymm.PadLeft(5, char.Parse("0"));
        foreach (RepairDS.wfRepairAppSRow rs in oRepairDS.wfRepairAppS.Rows)
        {
            rows = oRepairDS.REPAIR.Select("NOBR = '" + rs.sNobr + "' AND BDATE >= '" + rs.dStrDate.ToShortDateString() + "' AND BDATE <= '" + rs.dEndDate.ToShortDateString() + "' AND BTIME <> '' AND ETIME <> ''");
            foreach (RepairDS.REPAIRRow r in rows)
            {
                DateTimeB = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.BTIME.Trim()));
                DateTimeE = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.ETIME.Trim()));

                //不在此請假區間方可寫入請假資料表
                isRepair = !((DateTimeB < rs.dEndDateTime) && (DateTimeE > rs.dStrDateTime));

                if (!isRepair)
                    break;
            }

            string sernoR = FlowCS.GetSerno("R", rs.dStrDate);
            string sernoO = FlowCS.GetSerno("O", rs.dStrDate);

            //從此開始寫入
            if (isRepair)
            {
                rr = oRepairDS.REPAIR.NewREPAIRRow();
                rr.NOBR = rs.sNobr;
                rr.BDATE = rs.dStrDate;
                rr.BTIME = rs.sStrTime;
                rr.ETIME = rs.sEndTime;
                rr.OT_HRS = rs.iTotalHours;
                rr.YYMM = HrCS.SetYYMM(rr.BDATE);    //計薪年月// yymm;
                rr.REASON = rm.sReason;
                rr.PLACE = rm.sAddress;
                rr.WORKS = rm.sContent;
                rr.IMPROVE = rm.sAmend;
                rr.TR_AMT = rm.iTraffic;
                rr.VI_AMT = rm.iSpirit;
                rr.TOT_AMT = rr.TR_AMT + rr.VI_AMT;
                rr.KEY_MAN = rm.sName + "e";
                rr.KEY_DATE = DateTime.Now;
                rr.SERNO = sernoR;
                oRepairDS.REPAIR.AddREPAIRRow(rr);
            }

            isRepair = true;

            //新增加班資料
            rows = OTTA.GetDataByKey(rs.sNobr, rs.dStrDate).Select();
            foreach (RepairDS.OTRow r in rows)
            {
                DateTimeB = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.BTIME.Trim()));
                DateTimeE = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.ETIME.Trim()));

                //不在此請假區間方可寫入請假資料表
                isRepair = !((DateTimeB < rs.dEndDateTime) && (DateTimeE > rs.dStrDateTime));

                if (!isRepair)
                    break;
            }

            DateTime d = new DateTime(rs.dStrDate.AddMonths(6).Year, rs.dStrDate.AddMonths(6).Month, DateTime.DaysInMonth(rs.dStrDate.AddMonths(6).Year, rs.dStrDate.AddMonths(6).Month));  //瑤姐說要取到6個月的月底20100507 //rs.dStrDate.Date.AddMonths(6);
            DateTime d1 = DateTime.Parse(rs.dStrDate.Year.ToString() + "/12/31");

            if (isRepair)
            {
                oHrBaseData = new HrBaseData(rs.sNobr);

                ATTENDTA.FillByDate(oHrDS.ATTEND, rs.sNobr, rs.dStrDate);
                if (oHrDS.ATTEND.Rows.Count > 0 && rs.sRoteCode == "0")
                {
                    HrDS.ATTENDRow ra1 = (HrDS.ATTENDRow)oHrDS.ATTEND.Rows[0];
                    rs.sRoteCode = ra1.ROTE.Trim();
                }

                ro = oRepairDS.OT.NewOTRow();
                FlowCS.SetRowDefaultValue(ro);
                ro.NOBR = rs.sNobr;
                ro.BDATE = rs.dStrDate;
                ro.BTIME = rs.sStrTime;
                ro.ETIME = rs.sEndTime;
                ro.TOT_HOURS = rs.iTotalHours;
                ro.OT_HRS = (rs.sOtcatCode == "1") ? ro.TOT_HOURS : 0;
                ro.REST_HRS = (rs.sOtcatCode == "2") ? ro.TOT_HOURS : 0;
                ro.OT_DEPT = oHrBaseData.sDepts.Trim();
                ro.KEY_MAN = rm.sName + "e";
                ro.KEY_DATE = DateTime.Now;
                ro.NOTE = rm.sReason;
                ro.YYMM = HrCS.SetYYMM(ro.BDATE);    //計薪年月
                ro.OT_EDATE = d;// >= d1 ? d1 : d;
                ro.OT_ROTE = rs.sRoteCode == "0" ? "A" : rs.sRoteCode;  //班別
                ro.OTRATE_CODE = oHrBaseData.sCalot;    //班別群組  
                ro.SERNO = sernoO;
                ro.DIFF = rs.iTotalDiff;
                ro.EAT = rs.bEat;
                ro.RES = rs.bRes;
                ro.REPAIR = true;
                oRepairDS.OT.AddOTRow(ro);
            }

            //如果選補休
            if (rs.sOtcatCode == "2")
            {
                isRepair = true;

                rows = AbsCheckTA.GetDataByNobr(rs.sNobr, rs.dStrDate, rs.dEndDate).Select();
                foreach (OtDS.AbsCheckRow r in rows)
                {
                    DateTimeB = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.BTIME.Trim()));
                    DateTimeE = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.ETIME.Trim()));

                    //不在此請假區間方可寫入請假資料表
                    isRepair = !((DateTimeB < rs.dEndDateTime) && (DateTimeE > rs.dStrDateTime));

                    if (!isRepair)
                        break;
                }

                if (isRepair)
                {
                    ra = oOtDS.ABS.NewABSRow();
                    FlowCS.SetRowDefaultValue(ra);
                    ra.NOBR = rs.sNobr;
                    ra.BDATE = rs.dStrDate;
                    //ra.EDATE = DateTime.Parse(ra.BDATE.AddMonths(2).Year.ToString() + "/" + ra.BDATE.AddMonths(2).Month.ToString() + "/25");
                    ra.EDATE = d;// >= d1 ? d1 : d;
                    ra.BTIME = rs.sStrTime;
                    ra.ETIME = rs.sEndTime;
                    ra.H_CODE = "W2";
                    ra.TOL_HOURS = rs.iTotalHours;
                    ra.KEY_MAN = rm.sName + "e";
                    ra.KEY_DATE = DateTime.Now;
                    ra.YYMM = HrCS.SetYYMM(ra.BDATE); 
                    ra.NOTEDIT = false; //不行修改-與計算薪資有關
                    ra.NOTE = rs.sOtcatName;
                    ra.SYSCREATE = false; //系統產生-跟特休有關
                    ra.TOL_DAY = 0; //沒用到
                    //ra.TRANS_CODE = false;  //不知道
                    //ra.D_TOL_HOURS = 0;
                    //ra.ATT = false; //跟遲到有關
                    ra.SERNO = "";
                    oOtDS.ABS.AddABSRow(ra);
                }
            }

            rs.sState = "3";
        }

        OTTA.Update(oRepairDS.OT);
        ABSTA.Update(oOtDS.ABS);
        REPAIRTA.Update(oRepairDS.REPAIR);
        wfRepairAppSTA.Update(oRepairDS.wfRepairAppS);
        rm = (RepairDS.wfRepairAppMRow)oRepairDS.wfRepairAppM.Rows[0];
        rm.dDateD = DateTime.Now;
        rm.sState = "6";    //WebServices結束
        wfRepairAppMTA.Update(rm);

        return isPass;
    }
}