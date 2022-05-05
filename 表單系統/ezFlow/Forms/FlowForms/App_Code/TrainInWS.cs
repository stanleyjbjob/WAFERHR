using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;


/// <summary>
/// TrainInWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class TrainInWS : System.Web.Services.WebService {
    //HR
    public TrainDSTableAdapters.TRATTTableAdapter TRATTTA = new TrainDSTableAdapters.TRATTTableAdapter();

    //Form
    public TrainDSTableAdapters.wfTrainInAppTableAdapter wfTrainInAppTA = new TrainDSTableAdapters.wfTrainInAppTableAdapter();

    //DataSet
    public TrainDS oTrainDS;

    public DataRow[] rows;

    public TrainInWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true; //true表示成功
        oTrainDS = new TrainDS();

        string ProcessID = FlowCS.GetProcessID("ApView", ID);

        wfTrainInAppTA.FillByProcessID(oTrainDS.wfTrainInApp, ProcessID);

        if (oTrainDS.wfTrainInApp.Rows.Count == 0)
            return false;

        //WebServices開始
        TrainDS.wfTrainInAppRow rm;
        rm = (TrainDS.wfTrainInAppRow)oTrainDS.wfTrainInApp.Rows[0];
        rm.sState = "5";
        wfTrainInAppTA.Update(rm);
        wfTrainInAppTA.FillByProcessID(oTrainDS.wfTrainInApp, ProcessID);
        rm = (TrainDS.wfTrainInAppRow)oTrainDS.wfTrainInApp.Rows[0];

        string key = rm.sCourseCode + rm.sYYMM + rm.sSer;

        TRATTTA.FillByKey(oTrainDS.TRATT, key);
        rows = oTrainDS.TRATT.Select("IDNO = '" + rm.sNobr + "'");

        if (rows.Length > 0)  //刪除報名資料
        {
            rows[0].Delete();
        }
        else
        {
            TrainDS.TRATTRow rtt = oTrainDS.TRATT.NewTRATTRow();
            rtt.COSCODE = rm.sCourseCode;
            rtt.YYMM = rm.sYYMM;
            rtt.SER = rm.sSer;
            rtt.IDNO = rm.sNobr;
            rtt.SELCODE = "2";
            rtt.ATTHRS = 0;
            rtt.ABSHRS = 0;
            rtt.SCORE = 0;
            rtt.COSCLOSE = false;
            rtt.SHAREFEE = false;
            rtt.ABS = false;
            rtt.NOTE = "";
            rtt.HOMEWORK = false;
            rtt.KEY_DATE = DateTime.Now.Date;
            rtt.KEY_MAN = "UserF";
            rtt.FEE = 0;
            rtt.ONLINESIGN = true;  //線上報名
            rtt.EXPECT = rm.sReserve1;
            rtt.TR_ASDATE = DateTime.Now.Date;	//這行要由參加寫入
            rtt.LAT_NO = 0;
            rtt.EAR_NO = 0;
            oTrainDS.TRATT.AddTRATTRow(rtt);
        }

        TRATTTA.Update(oTrainDS.TRATT);
        rm.dDateD = DateTime.Now;
        rm.sState = "3";    //WebServices結束
        wfTrainInAppTA.Update(rm);

        return isPass;
    }   
}

