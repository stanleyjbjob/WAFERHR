using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;

/// <summary>
/// AbsWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class AbsWS : System.Web.Services.WebService
{
    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.EmpTableAdapter EmpTA = new FlowDSTableAdapters.EmpTableAdapter();
    public FlowDSTableAdapters.WorkAgentTableAdapter WorkAgentTA = new FlowDSTableAdapters.WorkAgentTableAdapter();

    //Form
    public AbsDSTableAdapters.wfAbsAppMTableAdapter wfAbsAppMTA = new AbsDSTableAdapters.wfAbsAppMTableAdapter();
    public AbsDSTableAdapters.wfAbsAppSTableAdapter wfAbsAppSTA = new AbsDSTableAdapters.wfAbsAppSTableAdapter();
    public AbsDSTableAdapters.ABSTableAdapter ABSTA = new AbsDSTableAdapters.ABSTableAdapter();
    public AbsDSTableAdapters.ABS1TableAdapter ABS1TA = new AbsDSTableAdapters.ABS1TableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public AbsDS oAbsDS;

    public DataRow[] rows;

    public AbsWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true; //true表示成功
        oFlowDS = new FlowDS();
        oAbsDS = new AbsDS();

        string ProcessID = FlowCS.GetProcessID("ApView", ID);
        ProcessID = ID.ToString();

        EmpTA.Fill(oFlowDS.Emp);
        wfAbsAppMTA.FillByProcessID(oAbsDS.wfAbsAppM, ProcessID);
        wfAbsAppSTA.FillByProcessID(oAbsDS.wfAbsAppS, ProcessID);

        if (oAbsDS.wfAbsAppM.Rows.Count == 0 || oAbsDS.wfAbsAppS.Rows.Count == 0)
        {
            return false;
        }

        //WebServices開始
        AbsDS.wfAbsAppMRow rm;
        rm = (AbsDS.wfAbsAppMRow)oAbsDS.wfAbsAppM.Rows[0];
        rm.sState = "5";
        wfAbsAppMTA.Update(rm);
        wfAbsAppMTA.FillByProcessID(oAbsDS.wfAbsAppM, ProcessID);
        rm = (AbsDS.wfAbsAppMRow)oAbsDS.wfAbsAppM.Rows[0];

        //ABSTA.Fill(oAbsDS.ABS);
        //ABS1TA.Fill(oAbsDS.ABS1);
        AbsDS.ABSRow ra;
        AbsDS.ABS1Row ra1;
        AbsCS.AbsCalculation oAbsCalculation;
        DateTime DateTimeB, DateTimeE;
        bool isAbs; //true表示沒有請假
        string sub, body;
        foreach (AbsDS.wfAbsAppSRow rs in oAbsDS.wfAbsAppS.Rows)
        {
            if (rs.sState != "2")
            {
                //傳送信件
                rows = BaseDataFlowTA.GetDataByNobr(rs.sAgentNobr1).Select();
                if (rs.sAgentNobr1.Length > 0 && rows.Length > 0)
                {
                    FlowDS.BaseDataFlowRow rf = (FlowDS.BaseDataFlowRow)rows[0];

                    sub = "職務代理人通知";
                    body = rs.sAgentName1 + "您好：<br>由於 " + rs.sName + " 於 " + rs.dStrDateFull.ToString() + " 到 " + rs.dEndDateFull.ToString() + " 請假(" + rs.sHname + ")" + "請您為職務代理人，特此通知。";

                    FlowCS.SendMail(rf.email, sub, body);
                }

                //通知
                WorkAgentTA.Fill(oFlowDS.WorkAgent, rs.sNobr);
                foreach (FlowDS.WorkAgentRow rw in oFlowDS.WorkAgent.Rows)
                {
                    sub = "職務代理人通知";
                    body = rw.Emp_nameTarget + "您好：<br>由於 " + rs.sName + " 於 " + rs.dStrDateFull.ToString() + " 到 " + rs.dEndDateFull.ToString() + " 請假(" + rs.sHname + ")" + "請您為職務代理人，特此通知。";

                    FlowCS.SendMail(rw.Emp_emailTarget, sub, body);
                }

                sub = rs.sName + rs.sJoblName + "請假核准通知";
                body = "您好：<br> " + rs.sName + rs.sJoblName + " 於 " + rs.dStrDateFull.ToString() + " 到 " + rs.dEndDateFull.ToString() + " 請假(" + rs.sHname + ")" + "，特此通知。";

                if (rs.sJobName.IndexOf("處長") != -1)
                {
                    //FlowCS.SendMail("ClareYang@waferworks.com", sub, body);
                    FlowCS.SendMail("tinachu@waferworks.com", sub, body);
                }

                //啟動代理機制
                rows = oFlowDS.Emp.Select("id = '" + rs.sNobr + "'");
                if (rows.Length > 0)
                {
                    FlowDS.EmpRow re = (FlowDS.EmpRow)rows[0];
                    re.isNeedAgent = true;
                    re.dateB = rs.dStrDateFull;
                    re.dateE = rs.dEndDateFull;
                }

                string sAname = rs.IssReserve1Null() ? "" : rs.sReserve1;

                //利用請假計算核心帶出請假天(筆)數及每一天的時數
                oAbsCalculation = AbsCS.CalculationAbs(rs.sNobr, rs.sHcode, rs.dStrDate, rs.dEndDate, rs.sStrTime, rs.sEndTime, sAname,0);

                isAbs = true;
                //以天數來跑每一天的回圈
                foreach (AbsCS.DayDate dd in oAbsCalculation.dDayDate)
                {
                    if (dd != null && dd.iDay > 0 || dd.iHour > 0)
                    {
                        //rows = oAbsDS.ABS.Select("NOBR = '" + rs.sNobr + "' AND BDATE = '" + dd.dDateB.ToShortDateString() + "' AND BTIME <> '' AND ETIME <> ''");
                        rows = ABSTA.GetDataByKey(rs.sNobr, dd.dDateB.Date).Select();
                        foreach (AbsDS.ABSRow ra2 in rows)
                        {
                            DateTimeB = ra2.BDATE.Date.AddMinutes(FlowCS.GetMinutes(ra2.BTIME.Trim()));
                            DateTimeE = ra2.BDATE.Date.AddMinutes(FlowCS.GetMinutes(ra2.ETIME.Trim()));

                            //不在此請假區間方可寫入請假資料表
                            isAbs = !((DateTimeB < dd.dDatetimeE) && (DateTimeE > dd.dDatetimeB));

                            if (!isAbs)
                                break;
                        }

                        //從此開始寫入
                        if (isAbs)
                        {
                            if (rs.sHcode == "O")
                            {
                                ra1 = oAbsDS.ABS1.NewABS1Row();
                                FlowCS.SetRowDefaultValue(ra1);
                                ra1.NOBR = rs.sNobr;
                                ra1.BDATE = dd.dDateB.Date;
                                ra1.EDATE = dd.dDateB.Date;
                                ra1.BTIME = dd.sTimeB;
                                ra1.ETIME = dd.sTimeE;
                                ra1.H_CODE = rs.sHcode;
                                ra1.TOL_HOURS = ((!rs.IssReserve2Null()) && (rs.sReserve2 == "1")) ? rs.iTotalHour : (oAbsCalculation.sHcodeUnit == "天") ? Convert.ToDecimal(dd.iDay) : Convert.ToDecimal(dd.iHour);
                                ra1.KEY_MAN = rm.sName + "e";
                                ra1.DEPT = rs.sDept;
                                ra1.NOTE = rs.sNote;
                                ra1.YYMM = HrCS.SetYYMM(dd.dDateB.Date);
                                ra1.SERNO = FlowCS.GetSerno("T", rs.dKeyDate);
                                oAbsDS.ABS1.AddABS1Row(ra1);

                                ABS1TA.Update(ra1);
                            }
                            else
                            {
                                ra = oAbsDS.ABS.NewABSRow();
                                FlowCS.SetRowDefaultValue(ra);
                                ra.NOBR = rs.sNobr;
                                ra.BDATE = dd.dDateB.Date;
                                ra.EDATE = dd.dDateB.Date;
                                ra.BTIME = dd.sTimeB;
                                ra.ETIME = dd.sTimeE;
                                ra.H_CODE = rs.sHcode;
                                ra.TOL_HOURS = (oAbsCalculation.sHcodeUnit == "天") ? Convert.ToDecimal(dd.iDay) : Convert.ToDecimal(dd.iHour);
                                ra.KEY_MAN = rm.sName + "e";
                                ra.YYMM = HrCS.SetYYMM(dd.dDateB.Date);
                                ra.NOTE = rs.sNote;
                                ra.A_NAME = sAname;
                                ra.SERNO = FlowCS.GetSerno("S", rs.dKeyDate);
                                oAbsDS.ABS.AddABSRow(ra);

                                ABSTA.Update(ra);
                            }

                            //刷卡轉出勤
                            TransCardWS oTransCardWS = new TransCardWS();
                            oTransCardWS.AttCardEnd(rs.sNobr, dd.dDateB.Date, rm.sName + "e", true, true, true);
                        }
                    }
                }

                rs.sState = "3";
            }
        }

        EmpTA.Update(oFlowDS.Emp);
        wfAbsAppSTA.Update(oAbsDS.wfAbsAppS);
        rm = (AbsDS.wfAbsAppMRow)oAbsDS.wfAbsAppM.Rows[0];
        rm.dDateD = DateTime.Now;
        rm.sState = "6";    //WebServices結束
        wfAbsAppMTA.Update(rm);

        return isPass;
    }
}