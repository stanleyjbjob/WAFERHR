using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Booking_Check : System.Web.UI.Page
{
    //Flow
    public FlowDSTableAdapters.wfSignTableAdapter wfSignTA = new FlowDSTableAdapters.wfSignTableAdapter();

    //Form
    public BookingDSTableAdapters.wfBookingAppMTableAdapter wfBookingAppMTA = new BookingDSTableAdapters.wfBookingAppMTableAdapter();
    public BookingDSTableAdapters.wfBookingAppSTableAdapter wfBookingAppSTA = new BookingDSTableAdapters.wfBookingAppSTableAdapter();
    public BookingDSTableAdapters.wfBookingSetTableAdapter wfBookingSetTA = new BookingDSTableAdapters.wfBookingSetTableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public BookingDS oBookingDS;

    protected void Page_Load(object sender, EventArgs e)
    {
        oFlowDS = new FlowDS();
        oBookingDS = new BookingDS();

        lblMsg.Text = "";

        if (Request.Url.Query.Length == 0 || Request.Cookies["ezFlow"] == null)
        {
            lblMsg.Text = "表單資訊錯誤，請重新開啟";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            Response.Redirect("http://" + Request.Url.Host + "/ezFlow/ezClient/Default.aspx?action=logout");
        }

        string RequestName = Request.QueryString.AllKeys[0];
        string RequestValue = Request[RequestName];
        lblNobr.Text = Request.Cookies["ezFlow"]["Emp_id"];
        btnSign.Visible = (RequestName == "ApParm");

        if (!this.IsPostBack)
        {
            lblUrl.Text = Request.Url.Query;
            lblProcessID.Text = FlowCS.GetProcessID(RequestName, int.Parse(RequestValue));

            wfBookingAppMTA.FillByProcessID(oBookingDS.wfBookingAppM, lblProcessID.Text);
            if (oBookingDS.wfBookingAppM.Rows.Count > 0)
            {
                BookingDS.wfBookingAppMRow rm = (BookingDS.wfBookingAppMRow)oBookingDS.wfBookingAppM.Rows[0];
                rblCheck.ClearSelection();
                rblCheck.Items.FindByValue(rm.bSign ? "1" : "0").Selected = true;
            }

            wfBookingSetTA.Fill(oBookingDS.wfBookingSet);
            if (oBookingDS.wfBookingSet.Rows.Count == 0)
            {
                lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            BookingDS.wfBookingSetRow r = (BookingDS.wfBookingSetRow)oBookingDS.wfBookingSet.Rows[0];
            lblNote.Text = r.sCheckNote;
            pNote.Visible = r.bSignNote;
        }

    }

    protected void btnSign_Click(object sender, EventArgs e)
    {
        wfBookingAppMTA.FillByProcessID(oBookingDS.wfBookingAppM, lblProcessID.Text);
        wfBookingAppSTA.FillByProcessID(oBookingDS.wfBookingAppS, lblProcessID.Text);
        wfSignTA.Fill(oFlowDS.wfSign);

        if (oBookingDS.wfBookingAppM.Rows.Count == 0)
        {
            lblMsg.Text = "找不到重要的簽核資料，請洽管理人員";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseData = new HrBaseData(lblNobr.Text);

        BookingDS.wfBookingAppMRow rm = (BookingDS.wfBookingAppMRow)oBookingDS.wfBookingAppM.Rows[0];
        rm.sNote = txtNote.Text;
        rm.bSign = rblCheck.SelectedItem.Value == "1";
        rm.sConditions1 = oHrBaseData.iCateOrder.ToString();
        rm.sState = (!rm.bSign) ? "2" : rm.sState;
        rm.dDateD = DateTime.Now;

        foreach (BookingDS.wfBookingAppSRow rs in oBookingDS.wfBookingAppS.Rows)
        {
            rs.bSign = rblCheck.SelectedItem.Value == "1";
            rs.sState = (!rm.bSign) ? "2" : rm.sState;
        }

        FlowDS.wfSignRow rn = oFlowDS.wfSign.NewwfSignRow();
        rn.sFromCode = "Booking";
        rn.sFromName = "設施設備單";
        rn.sProcessID = lblProcessID.Text;
        rn.idProcess = int.Parse(rn.sProcessID);
        rn.sNobr = oHrBaseData.sNobr;
        rn.sName = oHrBaseData.sName;
        rn.sDept = oHrBaseData.sDept;
        rn.sDeptName = oHrBaseData.sDeptName;
        rn.sNote = rm.sNote;
        rn.bSign = rm.bSign;
        rn.dKeyDate = rm.dDateD;
        oFlowDS.wfSign.AddwfSignRow(rn);

        wfBookingAppSTA.Update(oBookingDS.wfBookingAppS);
        wfBookingAppMTA.Update(rm);

        localhost.Service oService = new localhost.Service();

        if (!oService.WorkFinish(Convert.ToInt32(Request["ApParm"])))
        {
            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "AlertMsg", "alert('流程發生問題，您核准的動作可能無法完成。');self.close();", true);
        }
        else
        {
            wfSignTA.Update(oFlowDS.wfSign);

            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "OKMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "OKMsg", "self.location='../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "'", true);
        }
    }
}
