using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;

/// <summary>
/// TrainOutWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TrainOutWS : System.Web.Services.WebService {
     //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.WorkAgentTableAdapter WorkAgentTA = new FlowDSTableAdapters.WorkAgentTableAdapter();

    //Form
    public TrainDSTableAdapters.wfTrainAppMTableAdapter wfTrainAppMTA = new TrainDSTableAdapters.wfTrainAppMTableAdapter();
    public TrainDSTableAdapters.wfTrainAppSTableAdapter wfTrainAppSTA = new TrainDSTableAdapters.wfTrainAppSTableAdapter();
    public TrainDSTableAdapters.TRCOSFTableAdapter TRCOSFTA = new TrainDSTableAdapters.TRCOSFTableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public TrainDS oTrainDS;

    public DataRow[] rows;

    public TrainOutWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true; //true表示成功
        oFlowDS = new FlowDS();
        oTrainDS = new TrainDS();

        string ProcessID = FlowCS.GetProcessID("ApView", ID);
        ProcessID = ID.ToString();

        wfTrainAppMTA.FillByProcessID(oTrainDS.wfTrainAppM, ProcessID);
        wfTrainAppSTA.FillByProcessID(oTrainDS.wfTrainAppS, ProcessID);

        if (oTrainDS.wfTrainAppM.Rows.Count == 0 || oTrainDS.wfTrainAppS.Rows.Count == 0)
        {
            return false;
        }

        //WebServices開始
        TrainDS.wfTrainAppMRow rm;
        rm = (TrainDS.wfTrainAppMRow)oTrainDS.wfTrainAppM.Rows[0];
        rm.sState = "5";
        wfTrainAppMTA.Update(rm);
        wfTrainAppMTA.FillByProcessID(oTrainDS.wfTrainAppM, ProcessID);
        rm = (TrainDS.wfTrainAppMRow)oTrainDS.wfTrainAppM.Rows[0];

        TRCOSFTA.Fill(oTrainDS.TRCOSF);
        TrainDS.TRCOSFRow rt;
        foreach (TrainDS.wfTrainAppSRow rs in oTrainDS.wfTrainAppS.Rows)
        {
            if (rs.sState != "2")
            {
                TrainDS.TRCOSFRow r = oTrainDS.TRCOSF.NewTRCOSFRow();
                r.COURSE = rm.sCourseName;
                r.DATE_B = rm.dDateTimeB;
                r.DATE_E = rm.dDateTimeE;
                r.TR_HRS = Convert.ToDouble(rm.iTotalHours);
                r.COS_FEE = Convert.ToDouble(rs.iCosfee);
                r.IDNO = rs.sNobr;
                r.TR_COMP = rm.sCompany;
                //r.COM_PAY = double.Parse(0);
                //r.EMP_PAY = double.Parse(0);
                r.KEY_MAN = rm.sName;
                r.KEY_DATE = DateTime.Now.Date;
                r.SEQ = "";
                r.ABORAD = false;
                r.ABS = false;
                r.CLOSE_ = false;
                r.COUNTRY = "";
                r.AT_HRS = 0;
                r.TR_TYPE = "BB";
                r.TR_MENO = "";
                r.PROVE = "";
                r.TR_REPO = true;
                r.TR_MENO1 = "";
                r.TR_ASDATE = DateTime.Now.Date;
                r.TR_ASNO = "";
                r.APPLYNO = AutoNumber(rm.dDateTimeE);
                r.HANDOUT = "";
                r.RECEIVER = "";
                r.PLANIN = false;
                r.PLANTO = false;
                r.TR_PERSON = "";
                r.TR_ISO = "";
                r.TR_INOUT = "";
                r.TR_TEACH = "";
                oTrainDS.TRCOSF.AddTRCOSFRow(r);
                
                rs.sState = "3";

                rm.sReserve2 = r.APPLYNO;
                rs.sReserve2 = r.APPLYNO;
            }
        }

        TRCOSFTA.Update(oTrainDS.TRCOSF);
        wfTrainAppSTA.Update(oTrainDS.wfTrainAppS);
        rm = (TrainDS.wfTrainAppMRow)oTrainDS.wfTrainAppM.Rows[0];
        rm.dDateD = DateTime.Now;
        rm.sState = "3";    //WebServices結束
        wfTrainAppMTA.Update(rm);

        return isPass;
    }
    public string AutoNumber(DateTime dTime)
    {
        int CurrentNum;
        if (TRCOSFTA.GetCurrentApplyno(dTime.Year.ToString()) != null)
        {            
            CurrentNum = Convert.ToInt32(TRCOSFTA.GetCurrentApplyno(dTime.Year.ToString()));
            if (CurrentNum == dTime.Year * 1000 + 999)
                throw new Exception("流水編號已達上限");
        }
        else
            CurrentNum = dTime.Year * 1000;
        int Num = CurrentNum + 1;
        return "B" + Num;
    }
}

