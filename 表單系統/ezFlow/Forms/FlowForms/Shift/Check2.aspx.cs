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

public partial class Shift_Check2 : System.Web.UI.Page
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
    public ShiftDSTableAdapters.wfShiftSetTableAdapter wfShiftSetTA = new ShiftDSTableAdapters.wfShiftSetTableAdapter();

    //DataSet
    public HrDS oHrDS;
    public FlowDS oFlowDS;
    public ShiftDS oShiftDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        oHrDS = new HrDS();
        oFlowDS = new FlowDS();
        oShiftDS = new ShiftDS();

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

            wfShiftAppMTA.FillByProcessID(oShiftDS.wfShiftAppM, lblProcessID.Text);
            if (oShiftDS.wfShiftAppM.Rows.Count > 0)
            {
                ShiftDS.wfShiftAppMRow rm = (ShiftDS.wfShiftAppMRow)oShiftDS.wfShiftAppM.Rows[0];
                rblCheck.ClearSelection();
                rblCheck.Items.FindByValue(rm.bSign ? "1" : "0").Selected = true;
            }

            wfShiftSetTA.Fill(oShiftDS.wfShiftSet);
            if (oShiftDS.wfShiftSet.Rows.Count == 0)
            {
                lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            ShiftDS.wfShiftSetRow r = (ShiftDS.wfShiftSetRow)oShiftDS.wfShiftSet.Rows[0];
            lblNote.Text = r.sCheckNote;
            pNote.Visible = r.bSignNote;
        }
    }

    protected void btnSign_Click(object sender, EventArgs e)
    {
        wfShiftAppMTA.FillByProcessID(oShiftDS.wfShiftAppM, lblProcessID.Text);
        wfShiftAppSTA.FillByProcessID(oShiftDS.wfShiftAppS, lblProcessID.Text);
        wfSignTA.Fill(oShiftDS.wfSign);

        if (oShiftDS.wfShiftAppM.Rows.Count == 0)
        {
            lblMsg.Text = "找不到重要的簽核資料，請洽管理人員";
            //Page.ClientScript.RegisterStartupScript(typeof(string), "AlertMsg", "alert('" + lblMsg.Text + "');self.close();", true);
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseData = new HrBaseData(lblNobr.Text);

        ShiftDS.wfShiftAppMRow rm = (ShiftDS.wfShiftAppMRow)oShiftDS.wfShiftAppM.Rows[0];
        rm.sNote = txtNote.Text;
        rm.bSign = rblCheck.SelectedItem.Value == "1";
        rm.sConditions1 = oHrBaseData.iCateOrder.ToString();
        rm.sState = (!rm.bSign) ? "2" : rm.sState;
        rm.dDateD = DateTime.Now;

        foreach (ShiftDS.wfShiftAppSRow rs in oShiftDS.wfShiftAppS.Rows)
        {
            rs.bSign = rblCheck.SelectedItem.Value == "1";
            rs.sState = (!rs.bSign) ? "2" : rs.sState;
        }

        ShiftDS.wfSignRow rn = oShiftDS.wfSign.NewwfSignRow();
        rn.sFromCode = "Shift";
        rn.sFromName = "調班單";
        rn.sProcessID = lblProcessID.Text;
        rn.idProcess = int.Parse(rn.sProcessID);
        rn.sNobr = oHrBaseData.sNobr;
        rn.sName = oHrBaseData.sName;
        rn.sDept = oHrBaseData.sDept;
        rn.sDeptName = oHrBaseData.sDeptName;
        rn.sNote = rm.sNote;
        rn.bSign = rm.bSign;
        rn.dKeyDate = rm.dDateD;
        oShiftDS.wfSign.AddwfSignRow(rn);

        wfShiftAppSTA.Update(oShiftDS.wfShiftAppS);
        wfShiftAppMTA.Update(rm);

        localhost.Service oService = new localhost.Service();

        if (!oService.WorkFinish(Convert.ToInt32(Request["ApParm"])))
        {
            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                //Page.ClientScript.RegisterStartupScript(typeof(string), "AlertMsg", "alert('流程發生問題，您核准的動作可能無法完成。');self.close();", true);
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "AlertMsg", "alert('流程發生問題，您核准的動作可能無法完成。');self.close();", true);
        }
        else
        {
            wfSignTA.Update(oShiftDS.wfSign);

            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "OKMsg"))
                //Page.ClientScript.RegisterStartupScript(typeof(string), "OKMsg", "self.location='../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "'", true);
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "OKMsg", "self.location='../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "'", true);
        }
    }

    protected void gvAppS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        LinkButton lbtn = (LinkButton)e.Row.FindControl("lbtnState");

        if (lbtn != null)
        {
            string CommandArgument = lbtn.CommandArgument.ToString();
            lbtn.Text = (wfShiftAppSTA.GetDataByAutoKey(int.Parse(CommandArgument)).Select("sState <> '2'").Length > 0) ? "此筆駁回" : "核准";
            lbtn.OnClientClick = "return confirm('您確定要" + lbtn.Text + "嗎？');";
            e.Row.Visible = (lbtn.Text != "核准");
            //e.Row.ForeColor = lbtn.Text == "核准" ? System.Drawing.Color.Red : e.Row.ForeColor;
            lbtn.Visible = (Request.QueryString.AllKeys[0] == "ApParm");
        }
    }

    protected void gvAppS_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName == "State")
        {
            wfShiftAppSTA.FillByAutoKey(oShiftDS.wfShiftAppS, int.Parse(CommandArgument));
            if (oShiftDS.wfShiftAppS.Rows.Count > 0)
            {
                ShiftDS.wfShiftAppSRow r = (ShiftDS.wfShiftAppSRow)oShiftDS.wfShiftAppS.Rows[0];
                r.sState = (r.sState == "1") ? "2" : "1";
                wfShiftAppSTA.Update(r);
                gvAppS.DataBind();
            }
        }
    }
}
