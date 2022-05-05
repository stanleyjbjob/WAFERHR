using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;


/// <summary>
/// ShiftWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class ShiftWS : System.Web.Services.WebService
{
    //HR
    public HrDSTableAdapters.BaseDataTableAdapter BaseDataTA = new HrDSTableAdapters.BaseDataTableAdapter();
    public HrDSTableAdapters.ROTETableAdapter ROTETA = new HrDSTableAdapters.ROTETableAdapter();

    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.ProcessFlowShareTableAdapter ProcessFlowShareTA = new FlowDSTableAdapters.ProcessFlowShareTableAdapter();
    public FlowDSTableAdapters.ProcessApViewTableAdapter ProcessApViewTA = new FlowDSTableAdapters.ProcessApViewTableAdapter();
    public FlowDSTableAdapters.ProcessApParmTableAdapter ProcessApParmTA = new FlowDSTableAdapters.ProcessApParmTableAdapter();

    //Form
    public ShiftDSTableAdapters.wfShiftAppMTableAdapter wfShiftAppMTA = new ShiftDSTableAdapters.wfShiftAppMTableAdapter();
    public ShiftDSTableAdapters.wfShiftAppSTableAdapter wfShiftAppSTA = new ShiftDSTableAdapters.wfShiftAppSTableAdapter();
    public ShiftDSTableAdapters.wfSignTableAdapter wfSignTA = new ShiftDSTableAdapters.wfSignTableAdapter();
    public ShiftDSTableAdapters.BASETTSTableAdapter BASETTSTA = new ShiftDSTableAdapters.BASETTSTableAdapter();
    public ShiftDSTableAdapters.ATTENDTableAdapter ATTENDTA = new ShiftDSTableAdapters.ATTENDTableAdapter();
    public ShiftDSTableAdapters.ROTECHGTableAdapter ROTECHGTA = new ShiftDSTableAdapters.ROTECHGTableAdapter();

    //DataSet
    public HrDS oHrDS;
    public FlowDS oFlowDS;
    public ShiftDS oShiftDS;

    public DataRow[] rows, rowsA, rowsB;

    public ShiftWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true;
        oHrDS = new HrDS();
        oFlowDS = new FlowDS();
        oShiftDS = new ShiftDS();

        string ProcessID = FlowCS.GetProcessID("ApView", ID);

        wfShiftAppMTA.FillByProcessID(oShiftDS.wfShiftAppM, ProcessID);
        wfShiftAppSTA.FillByProcessID(oShiftDS.wfShiftAppS, ProcessID);
        ROTECHGTA.Fill(oShiftDS.ROTECHG);
        BASETTSTA.Fill(oShiftDS.BASETTS);

        if (oShiftDS.wfShiftAppM.Rows.Count == 0 || oShiftDS.wfShiftAppS.Rows.Count == 0)
            return false;

        //WebServices開始
        ShiftDS.wfShiftAppMRow rm;
        ShiftDS.ROTECHGRow rr;
        rm = (ShiftDS.wfShiftAppMRow)oShiftDS.wfShiftAppM.Rows[0];
        rm.sState = "5";
        wfShiftAppMTA.Update(rm);
        wfShiftAppMTA.FillByProcessID(oShiftDS.wfShiftAppM, ProcessID);
        rm = (ShiftDS.wfShiftAppMRow)oShiftDS.wfShiftAppM.Rows[0];

        foreach (ShiftDS.wfShiftAppSRow rs in oShiftDS.wfShiftAppS.Rows)
        {
            if (rs.sState != "2")
            {
                //先找有沒有完全一樣的
                if (rs.sRoteCate == "1")
                {  //短期調班
                    //if (ROTECHGTA.GetDataByKey(rs.dAuthority, rs.sNobrB, rs.sRote).Rows.Count > 0 || ROTECHGTA.GetDataByKey(rs.dAim, rs.sNobr, rs.sRoteB).Rows.Count > 0)
                    //{
                    //    return false;
                    //}

                    //調班後班別//////////////////////////////////////////////////////////////////
                    rows = ROTECHGTA.GetDataByNobr(rs.dAuthority, rs.sNobrB).Select();
                    //如果沒有完全一樣的就找日期跟工號有沒有一樣的，有則複蓋原本的，如果沒有就新增
                    if (rows.Length == 0)
                        rr = oShiftDS.ROTECHG.NewROTECHGRow();
                    else
                        rr = (ShiftDS.ROTECHGRow)rows[0];

                    rr.ADATE = rs.dAim;
                    rr.NOBR = rs.sNobr;
                    rr.ROTE = rs.sRoteB;
                    rr.CODE = "";
                    rr.KEY_MAN = rm.sName + "eA";
                    rr.KEY_DATE = DateTime.Now;
                    rr.MENO = rs.sNote;
                    rr.B_NOBR = rs.sNobrB;
                    rr.B_ADATE = rs.dAuthority;
                    rr.B_ROTE = rs.sRote;

                    if (rows.Length == 0)
                        oShiftDS.ROTECHG.AddROTECHGRow(rr);

                    rows = ROTECHGTA.GetDataByNobr(rs.dAim, rs.sNobr).Select();
                    //如果沒有完全一樣的就找日期跟工號有沒有一樣的，有則複蓋原本的，如果沒有就新增
                    if (rows.Length == 0)
                        rr = oShiftDS.ROTECHG.NewROTECHGRow();
                    else
                        rr = (ShiftDS.ROTECHGRow)rows[0];

                    rr.ADATE = rs.dAuthority;
                    rr.NOBR = rs.sNobrB;
                    rr.ROTE = rs.sRote;
                    rr.CODE = "";
                    rr.KEY_MAN = rm.sName + "eB";
                    rr.KEY_DATE = DateTime.Now;
                    rr.MENO = rs.sNote;
                    rr.B_NOBR = rs.sNobr;
                    rr.B_ADATE = rs.dAim;
                    rr.B_ROTE = rs.sRoteB;

                    if (rows.Length == 0)
                        oShiftDS.ROTECHG.AddROTECHGRow(rr);

                    //原班別變另一位的班別////////////////////////////////////////////////////////
                    rowsA = ATTENDTA.GetDataByDate(rs.sNobrB, rs.dAuthority).Select();    //被調班者
                    rowsB = ATTENDTA.GetDataByDate(rs.sNobr, rs.dAim).Select();   //調班者

                    rows = ROTECHGTA.GetDataByNobr(rs.dAuthority, rs.sNobr).Select();
                    //如果沒有完全一樣的就找日期跟工號有沒有一樣的，有則複蓋原本的，如果沒有就新增
                    if (rows.Length == 0)
                        rr = oShiftDS.ROTECHG.NewROTECHGRow();
                    else
                        rr = (ShiftDS.ROTECHGRow)rows[0];

                    rr.ADATE = rs.dAuthority;
                    rr.NOBR = rs.sNobr;
                    rr.ROTE = rowsA.Length > 0 ? rowsA[0]["ROTE"].ToString().Trim() : "00";
                    rr.CODE = "";
                    rr.KEY_MAN = rm.sName + "eA";
                    rr.KEY_DATE = DateTime.Now;
                    rr.MENO = rs.sNote;
                    rr.B_NOBR = rs.sNobrB;
                    rr.B_ADATE = rs.dAim;
                    rr.B_ROTE = rowsB.Length > 0 ? rowsB[0]["ROTE"].ToString().Trim() : "00";

                    if (rows.Length == 0)
                        oShiftDS.ROTECHG.AddROTECHGRow(rr);

                    rows = ROTECHGTA.GetDataByNobr(rs.dAim, rs.sNobrB).Select();
                    //如果沒有完全一樣的就找日期跟工號有沒有一樣的，有則複蓋原本的，如果沒有就新增
                    if (rows.Length == 0)
                        rr = oShiftDS.ROTECHG.NewROTECHGRow();
                    else
                        rr = (ShiftDS.ROTECHGRow)rows[0];

                    rr.ADATE = rs.dAim;
                    rr.NOBR = rs.sNobrB;
                    rr.ROTE = rowsB.Length > 0 ? rowsB[0]["ROTE"].ToString().Trim() : "00";
                    rr.CODE = "";
                    rr.KEY_MAN = rm.sName + "eB";
                    rr.KEY_DATE = DateTime.Now;
                    rr.MENO = rs.sNote;
                    rr.B_NOBR = rs.sNobr;
                    rr.B_ADATE = rs.dAuthority;
                    rr.B_ROTE = rowsA.Length > 0 ? rowsA[0]["ROTE"].ToString().Trim() : "00";

                    if (rows.Length == 0)
                        oShiftDS.ROTECHG.AddROTECHGRow(rr);
                }
                else
                {  //長期調班
                    rows = oShiftDS.BASETTS.Select("NOBR = '" + rs.sNobr + "' AND ADATE <= '" + rs.dAuthority + "' AND DDATE >= '" + rs.dAuthority + "'");

                    if (rows.Length == 0)
                        return false;

                    ShiftDS.BASETTSRow rb = (ShiftDS.BASETTSRow)rows[0];

                    //先新增生效的
                    ShiftDS.BASETTSRow rbA = oShiftDS.BASETTS.NewBASETTSRow();
                    rbA.ItemArray = rb.ItemArray;
                    rbA.ROTET = rs.sRoteB;
                    rbA.HOLI_CODE = rs.sReserve1;   //行事曆 20080213 by ming
                    rbA.ADATE = rs.dAuthority;
                    rbA.TTSCODE = "6"; 
                    rbA.DDATE = new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12));
                    rbA.KEY_MAN = rm.sName + "e";
                    oShiftDS.BASETTS.AddBASETTSRow(rbA);

                    //再新增失效的
                    ShiftDS.BASETTSRow rbB = oShiftDS.BASETTS.NewBASETTSRow();
                    rbB.ItemArray = rb.ItemArray;
                    rbB.DDATE = rs.dAuthority.Date.AddSeconds(-1);  //當天減一秒 20080227 by ming 瑤姐
                    oShiftDS.BASETTS.AddBASETTSRow(rbB);

                    //再刪除原本的
                    rb.Delete();

                    //觸發RoteWS執行班表重新產生(由Flow執行動作)
                }

                rs.sState = "3";
            }
        }

        rm = (ShiftDS.wfShiftAppMRow)oShiftDS.wfShiftAppM.Rows[0];
        rm.dDateD = DateTime.Now;
        rm.sState = "3";
        wfShiftAppMTA.Update(oShiftDS.wfShiftAppM);
        wfShiftAppSTA.Update(oShiftDS.wfShiftAppS);
        ROTECHGTA.Update(oShiftDS.ROTECHG);
        BASETTSTA.Update(oShiftDS.BASETTS);

        return isPass;
    }
}