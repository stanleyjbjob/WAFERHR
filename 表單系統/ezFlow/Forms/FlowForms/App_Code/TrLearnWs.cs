using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;


/// <summary>
/// TrLearnWs 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TrLearnWs : System.Web.Services.WebService
{

    HrDSTableAdapters.TRLEARNEDTableAdapter HrTrlearnTA = new HrDSTableAdapters.TRLEARNEDTableAdapter();
    HrDS.TRLEARNEDDataTable HrTrLearnedDT = new HrDS.TRLEARNEDDataTable();
    TrLearnedDSTableAdapters.wfTrLearnedAppMTableAdapter wfTrLearnedTA = new TrLearnedDSTableAdapters.wfTrLearnedAppMTableAdapter();
    TrLearnedDS.wfTrLearnedAppMDataTable wfTrLearnedDT = new TrLearnedDS.wfTrLearnedAppMDataTable();
    TrainDSTableAdapters.TRCOSFTableAdapter TrcosfTA = new TrainDSTableAdapters.TRCOSFTableAdapter();
    TrainDS.TRCOSFDataTable TrcosfDT = new TrainDS.TRCOSFDataTable();

    public TrLearnWs()
    {

        //如果使用設計的元件，請取消註解下行程式碼 
        //InitializeComponent(); 
    }

    [WebMethod]
    public bool Run(int ID)
    {
        string ProcessID = ID.ToString();

        wfTrLearnedTA.FillByProcess(wfTrLearnedDT, ProcessID);
        //資料檢查
        if (wfTrLearnedDT.Rows.Count == 0)
            return false;

        TrLearnedDS.wfTrLearnedAppMRow wfTrLearnedRow = wfTrLearnedDT.Rows[0] as TrLearnedDS.wfTrLearnedAppMRow;
        TrcosfTA.FillByIDandNO(TrcosfDT, wfTrLearnedRow.sNobr, wfTrLearnedRow.sApplyNo);

        if (TrcosfDT.Rows.Count == 0)
            return false;

        //先寫入狀態-WebService開始 sState=5
        wfTrLearnedRow.sState = "5";
        wfTrLearnedTA.Update(wfTrLearnedDT);

        try
        {
            //取出指定的資料
            wfTrLearnedTA.FillByProcess(wfTrLearnedDT, ProcessID);
            wfTrLearnedRow = wfTrLearnedDT.Rows[0] as TrLearnedDS.wfTrLearnedAppMRow;

            //將取出的資料的值指定給HrTrLearned
            HrDS.TRLEARNEDRow HrRow = HrTrLearnedDT.NewTRLEARNEDRow();
            HrRow.bAuth = wfTrLearnedRow.bAuth;
            HrRow.bSign = wfTrLearnedRow.bSign;
            HrRow.dDateB = wfTrLearnedRow.dDateB;
            HrRow.dDateE = wfTrLearnedRow.dDateE;
            HrRow.sTimeB = wfTrLearnedRow.sTimeB;
            HrRow.sTimeE = wfTrLearnedRow.sTimeE;
            HrRow.idProcess = wfTrLearnedRow.idProcess;
            HrRow.iTotalHour = wfTrLearnedRow.iTotalHour;
            HrRow.sApplyNo = wfTrLearnedRow.sApplyNo;
            HrRow.sAddress = wfTrLearnedRow.sAddress;
            HrRow.sComment = wfTrLearnedRow.sComment;
            HrRow.sConditions1 = wfTrLearnedRow.IssConditions1Null() ? "" : wfTrLearnedRow.sConditions1;
            HrRow.sConditions2 = wfTrLearnedRow.IssConditions2Null() ? "" : wfTrLearnedRow.sConditions2;
            HrRow.sConditions3 = wfTrLearnedRow.IssConditions3Null() ? "" : wfTrLearnedRow.sConditions3;
            HrRow.sConditions4 = wfTrLearnedRow.IssConditions4Null() ? "" : wfTrLearnedRow.sConditions4;
            HrRow.sConditions5 = wfTrLearnedRow.IssConditions5Null() ? "" : wfTrLearnedRow.sConditions5;
            HrRow.sContent = wfTrLearnedRow.sContent;
            HrRow.sCourseName = wfTrLearnedRow.sCourseName;
            HrRow.sDept = wfTrLearnedRow.sDept;
            HrRow.sDeptName = wfTrLearnedRow.sDeptName;
            HrRow.sEffor1 = wfTrLearnedRow.IssEffor1Null() ? "" : wfTrLearnedRow.sEffor1;
            HrRow.sEffor2 = wfTrLearnedRow.IssEffor2Null() ? "" : wfTrLearnedRow.sEffor2;
            HrRow.sEffor3 = wfTrLearnedRow.IssEffor3Null() ? "" : wfTrLearnedRow.sEffor3;
            HrRow.sEffor4 = wfTrLearnedRow.IssEffor4Null() ? "" : wfTrLearnedRow.sEffor4;
            HrRow.sJob = wfTrLearnedRow.sJob;
            HrRow.sJobl = wfTrLearnedRow.sJobl;
            HrRow.sJoblName = wfTrLearnedRow.sJoblName;
            HrRow.sJobName = wfTrLearnedRow.sJobName;
            HrRow.sLearned = wfTrLearnedRow.sLearned;
            HrRow.sMangAppraise = wfTrLearnedRow.IssMangAppraiseNull() ? "" : wfTrLearnedRow.sMangAppraise;
            HrRow.sName = wfTrLearnedRow.sName;
            HrRow.sNobr = wfTrLearnedRow.sNobr;
            HrRow.sNote = wfTrLearnedRow.IssNoteNull() ? "" : wfTrLearnedRow.sNote;
            HrRow.sProcessID = wfTrLearnedRow.sProcessID;
            HrRow.sReason = wfTrLearnedRow.sReason;
            HrRow.sReserve1 = wfTrLearnedRow.IssReserve1Null() ? "" : wfTrLearnedRow.sReserve1;
            HrRow.sReserve2 = wfTrLearnedRow.IssReserve2Null() ? "" : wfTrLearnedRow.sReserve2;
            HrRow.sReserve3 = wfTrLearnedRow.IssReserve3Null() ? "" : wfTrLearnedRow.sReserve3;
            HrRow.sState = wfTrLearnedRow.sState;
            HrRow.sTcrName1 = wfTrLearnedRow.IssTcrName1Null() ? "" : wfTrLearnedRow.sTcrName1;
            HrRow.sTcrName2 = wfTrLearnedRow.IssTcrName2Null() ? "" : wfTrLearnedRow.sTcrName2;
            HrRow.sTcrName3 = wfTrLearnedRow.IssTcrName3Null() ? "" : wfTrLearnedRow.sTcrName3;
            HrRow.sTcrName4 = wfTrLearnedRow.IssTcrName4Null() ? "" : wfTrLearnedRow.sTcrName4;
            HrRow.sTcrName5 = wfTrLearnedRow.IssTcrName5Null() ? "" : wfTrLearnedRow.sTcrName5;
            HrRow.sKeyMan = wfTrLearnedRow.sKeyMan;
            HrRow.dKeyDate = wfTrLearnedRow.dKeyDate;

            //更改Trcosf的Tr_repo為True,並寫入現在的日期到TR_ASDATE
            TrainDS.TRCOSFRow TrcosfRow = TrcosfDT.Rows[0] as TrainDS.TRCOSFRow;
            TrcosfRow.TR_REPO = true;
            TrcosfRow.TR_ASDATE = Convert.ToDateTime(DateTime.Now.Date);

            HrTrLearnedDT.AddTRLEARNEDRow(HrRow);
            HrTrlearnTA.Update(HrTrLearnedDT);
            TrcosfTA.Update(TrcosfRow);

            //寫入狀態-WebService結束 sState=6
            //wfTrLearnedTA.FillByProcess(wfTrLearnedDT, ProcessID);
            //wfTrLearnedRow = wfTrLearnedDT.Rows[0] as TrLearnedDS.wfTrLearnedAppMRow;
            wfTrLearnedRow.sState = "6";//WebService結束
            wfTrLearnedTA.Update(wfTrLearnedDT);
        }
        catch(Exception ex)
        {
            return false;
        }

        
        return true;
    }

}

