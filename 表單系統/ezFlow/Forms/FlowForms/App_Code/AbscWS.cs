using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;

/// <summary>
/// AbsccWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class AbscWS : System.Web.Services.WebService {
    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.EmpTableAdapter EmpTA = new FlowDSTableAdapters.EmpTableAdapter();

    //Form
    public AbscDSTableAdapters.wfAbscAppMTableAdapter wfAbscAppMTA = new AbscDSTableAdapters.wfAbscAppMTableAdapter();
    public AbscDSTableAdapters.wfAbscAppSTableAdapter wfAbscAppSTA = new AbscDSTableAdapters.wfAbscAppSTableAdapter();
    public AbscDSTableAdapters.ABSTableAdapter ABSTA = new AbscDSTableAdapters.ABSTableAdapter();
    public AbscDSTableAdapters.ABS1TableAdapter ABS1TA = new AbscDSTableAdapters.ABS1TableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public AbscDS oAbscDS;

    public DataRow[] rows;

    public AbscWS() { }

    [WebMethod]
    public bool Run(int ID) {
        bool isPass = true; //true表示成功
        oFlowDS = new FlowDS();
        oAbscDS = new AbscDS();

        //string ProcessID = FlowCS.GetProcessID("ApView", ID);
        string ProcessID = ID.ToString();

        EmpTA.Fill(oFlowDS.Emp);
        wfAbscAppMTA.FillByProcessID(oAbscDS.wfAbscAppM, ProcessID);
        wfAbscAppSTA.FillByProcessID(oAbscDS.wfAbscAppS, ProcessID);

        if (oAbscDS.wfAbscAppM.Rows.Count == 0 || oAbscDS.wfAbscAppS.Rows.Count == 0)
            return false;

        //WebServices開始
        AbscDS.wfAbscAppMRow rm;
        rm = (AbscDS.wfAbscAppMRow)oAbscDS.wfAbscAppM.Rows[0];
        rm.sState = "5";
        wfAbscAppMTA.Update(rm);
        wfAbscAppMTA.FillByProcessID(oAbscDS.wfAbscAppM, ProcessID);
        rm = (AbscDS.wfAbscAppMRow)oAbscDS.wfAbscAppM.Rows[0];

        foreach (AbscDS.wfAbscAppSRow rs in oAbscDS.wfAbscAppS.Rows) {
            if (rs.sState != "2")
            {
                if (rs.sHcode != "O")
                {
                    ABSTA.Delete(rs.sNobr, rs.dStrDate.Date, rs.sStrTime);
                }
                else
                {
                    ABS1TA.Delete(rs.sNobr, rs.dStrDate.Date, rs.sStrTime);
                }

                rs.sState = "3";

                //刷卡轉出勤
                TransCardWS oTransCardWS = new TransCardWS();
                oTransCardWS.AttCardEnd(rs.sNobr, rs.dStrDate, rm.sName + "e", true, true, true);
            }
        }

        wfAbscAppSTA.Update(oAbscDS.wfAbscAppS);
        rm.dDateD = DateTime.Now;
        rm.sState = "6";    //WebServices結束
        wfAbscAppMTA.Update(rm);

        return isPass;
    }
}