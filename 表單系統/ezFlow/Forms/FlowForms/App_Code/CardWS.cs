using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;

/// <summary>
/// CardWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class CardWS : System.Web.Services.WebService {
    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();

    //Form
    public CardDSTableAdapters.wfCardAppMTableAdapter wfCardAppMTA = new CardDSTableAdapters.wfCardAppMTableAdapter();
    public CardDSTableAdapters.wfCardAppSTableAdapter wfCardAppSTA = new CardDSTableAdapters.wfCardAppSTableAdapter();
    public CardDSTableAdapters.CARDTableAdapter CARDTA = new CardDSTableAdapters.CARDTableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public CardDS oCardDS;

    public DataRow[] rows;

    public CardWS() { }

    [WebMethod]
    public bool Run(int ID) {
        bool isPass = true; //true表示成功
        oFlowDS = new FlowDS();
        oCardDS = new CardDS();

        //string ProcessID = FlowCS.GetProcessID("ApView", ID);
        string ProcessID = ID.ToString();

        wfCardAppMTA.FillByProcessID(oCardDS.wfCardAppM, ProcessID);
        wfCardAppSTA.FillByProcessID(oCardDS.wfCardAppS, ProcessID);

        if (oCardDS.wfCardAppM.Rows.Count == 0 || oCardDS.wfCardAppS.Rows.Count == 0) {
            return false;
        }

        //WebServices開始
        CardDS.wfCardAppMRow rm;
        rm = (CardDS.wfCardAppMRow)oCardDS.wfCardAppM.Rows[0];
        rm.sState = "5";
        wfCardAppMTA.Update(rm);
        wfCardAppMTA.FillByProcessID(oCardDS.wfCardAppM, ProcessID);
        rm = (CardDS.wfCardAppMRow)oCardDS.wfCardAppM.Rows[0];

        //CARDTA.Fill(oCardDS.CARD);
        CardDS.CARDRow rc;
        foreach (CardDS.wfCardAppSRow rs in oCardDS.wfCardAppS.Rows)
        {
            if (rs.sTime.Trim().Length == 4 && CARDTA.GetDataByKey(rs.sNobr, rs.dDate.Date, rs.sTime.Trim()).Rows.Count == 0)
            {
                rc = oCardDS.CARD.NewCARDRow();
                FlowCS.SetRowDefaultValue(rc);
                rc.CODE = "1";
                rc.NOBR = rs.sNobr;
                rc.ADATE = Convert.ToInt32(rs.sTime) >= 2400 ? rs.dDate.AddDays(1).Date : rs.dDate.Date;
                rc.ONTIME = Convert.ToInt32(rs.sTime) >= 2400 ? Convert.ToString(Convert.ToInt32(rs.sTime) - 2400).PadLeft(4, char.Parse("0")) : rs.sTime;
                rc.CARDNO = rs.sNobr;
                rc.KEY_MAN = rm.sName + "e";
                rc.REASON = rs.sReserve2;
                rc.LOS = true;
                rc.SERNO = FlowCS.GetSerno("F", rc.ADATE);
                oCardDS.CARD.AddCARDRow(rc);

                try
                {
                    CARDTA.Update(oCardDS.CARD);
                }
                catch { }

                //刷卡轉出勤
                TransCardWS oTransCardWS = new TransCardWS();
                oTransCardWS.AttCardEnd(rs.sNobr, rs.dDate, rm.sName + "e", true, true, true);
            }

            rs.sState = "3";
        }

        wfCardAppSTA.Update(oCardDS.wfCardAppS);
        rm = (CardDS.wfCardAppMRow)oCardDS.wfCardAppM.Rows[0];
        rm.dDateD = DateTime.Now;
        rm.sState = "6";    //WebServices結束
        wfCardAppMTA.Update(rm);

        return isPass;
    }
}

