using System;
using System.Web;
using System.Collections;
using System.Web.Services;
using System.Web.Services.Protocols;
using System.Data;

/// <summary>
/// BookingWS 的摘要描述
/// </summary>
[WebService(Namespace = "http://tempuri.org/")]
[WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
public class BookingWS : System.Web.Services.WebService
{
    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.EmpTableAdapter EmpTA = new FlowDSTableAdapters.EmpTableAdapter();

    //Form
    public BookingDSTableAdapters.wfBookingAppMTableAdapter wfBookingAppMTA = new BookingDSTableAdapters.wfBookingAppMTableAdapter();
    public BookingDSTableAdapters.wfBookingAppSTableAdapter wfBookingAppSTA = new BookingDSTableAdapters.wfBookingAppSTableAdapter();
    public BookingDSTableAdapters.wfBookingTableAdapter wfBookingTA = new BookingDSTableAdapters.wfBookingTableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public BookingDS oBookingDS;

    public DataRow[] rows;

    public BookingWS() { }

    [WebMethod]
    public bool Run(int ID)
    {
        bool isPass = true; //true表示成功
        oFlowDS = new FlowDS();
        oBookingDS = new BookingDS();

        string ProcessID = FlowCS.GetProcessID("ApView", ID);

        EmpTA.Fill(oFlowDS.Emp);
        wfBookingAppMTA.FillByProcessID(oBookingDS.wfBookingAppM, ProcessID);
        wfBookingAppSTA.FillByProcessID(oBookingDS.wfBookingAppS, ProcessID);

        if (oBookingDS.wfBookingAppM.Rows.Count == 0 || oBookingDS.wfBookingAppS.Rows.Count == 0)
        {
            return false;
        }

        //WebServices開始
        BookingDS.wfBookingAppMRow rm;
        rm = (BookingDS.wfBookingAppMRow)oBookingDS.wfBookingAppM.Rows[0];
        rm.sState = "5";
        wfBookingAppMTA.Update(rm);
        wfBookingAppMTA.FillByProcessID(oBookingDS.wfBookingAppM, ProcessID);
        rm = (BookingDS.wfBookingAppMRow)oBookingDS.wfBookingAppM.Rows[0];

        wfBookingTA.Fill(oBookingDS.wfBooking);
        BookingDS.wfBookingRow rb;
        bool isBooking; //true表示沒有借出
        foreach (BookingDS.wfBookingAppSRow rs in oBookingDS.wfBookingAppS.Rows)
        {
            isBooking = true;
            //從此開始寫入
            if (wfBookingTA.GetDataByKey(rs.dEndDateTime, rs.dStrDateTime, rs.sClassCode, rs.sTypeCode).Rows.Count == 0)
            {
                rb = oBookingDS.wfBooking.NewwfBookingRow();
                foreach (DataColumn dc in oBookingDS.wfBookingAppS.Columns)
                    if (oBookingDS.wfBooking.Columns.Contains(dc.ToString()) && dc.ToString() != "iAutoKey")
                        rb[dc.ToString()] = rs[dc];
                rb.sKeyMan = rm.sName + "e";
                oBookingDS.wfBooking.AddwfBookingRow(rb);
            }

            rs.sState = "3";
        }

        wfBookingAppSTA.Update(oBookingDS.wfBookingAppS);
        wfBookingTA.Update(oBookingDS.wfBooking);
        rm = (BookingDS.wfBookingAppMRow)oBookingDS.wfBookingAppM.Rows[0];
        rm.dDateD = DateTime.Now;
        rm.sState = "3";    //WebServices結束
        wfBookingAppMTA.Update(rm);

        return isPass;
    }
}