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

public partial class Absc_Check : System.Web.UI.Page
{
    //Flow
    public FlowDSTableAdapters.wfSignTableAdapter wfSignTA = new FlowDSTableAdapters.wfSignTableAdapter();

    //Form
    public AbscDSTableAdapters.wfAbscAppMTableAdapter wfAbscAppMTA = new AbscDSTableAdapters.wfAbscAppMTableAdapter();
    public AbscDSTableAdapters.wfAbscAppSTableAdapter wfAbscAppSTA = new AbscDSTableAdapters.wfAbscAppSTableAdapter();
    public AbscDSTableAdapters.wfAbscSetTableAdapter wfAbscSetTA = new AbscDSTableAdapters.wfAbscSetTableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public AbscDS oAbscDS;

    protected void Page_Load(object sender, EventArgs e) {
        oFlowDS = new FlowDS();
        oAbscDS = new AbscDS();

        lblMsg.Text = "";

        if (Request.Url.Query.Length == 0 || Request.Cookies["ezFlow"] == null) {
            lblMsg.Text = "表單資訊錯誤，請重新開啟";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            Response.Redirect("http://" + Request.Url.Host + "/ezFlow/ezClient/Default.aspx?action=logout");
        }

        string RequestName = Request.QueryString.AllKeys[0];
        string RequestValue = Request[RequestName];
        lblNobr.Text = Request.Cookies["ezFlow"]["Emp_id"];
        btnSign.Visible = (RequestName == "ApParm");

        if (!this.IsPostBack) {
            lblUrl.Text = Request.Url.Query;
            lblProcessID.Text = FlowCS.GetProcessID(RequestName, int.Parse(RequestValue));

            wfAbscAppMTA.FillByProcessID(oAbscDS.wfAbscAppM, lblProcessID.Text);
            if (oAbscDS.wfAbscAppM.Rows.Count > 0) {
                AbscDS.wfAbscAppMRow rm = (AbscDS.wfAbscAppMRow)oAbscDS.wfAbscAppM.Rows[0];
                rblCheck.ClearSelection();
                rblCheck.Items.FindByValue(rm.bSign ? "1" : "0").Selected = true;
            }

            wfAbscSetTA.Fill(oAbscDS.wfAbscSet);
            if (oAbscDS.wfAbscSet.Rows.Count == 0) {
                lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            AbscDS.wfAbscSetRow r = (AbscDS.wfAbscSetRow)oAbscDS.wfAbscSet.Rows[0];
            lblNote.Text = r.sCheckNote;
            pNote.Visible = r.bSignNote;
        }

    }

    protected void btnSign_Click(object sender, EventArgs e) {
        wfAbscAppMTA.FillByProcessID(oAbscDS.wfAbscAppM, lblProcessID.Text);
        wfAbscAppSTA.FillByProcessID(oAbscDS.wfAbscAppS, lblProcessID.Text);
        wfSignTA.Fill(oFlowDS.wfSign);

        if (oAbscDS.wfAbscAppM.Rows.Count == 0) {
            lblMsg.Text = "找不到重要的簽核資料，請洽管理人員";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseData = new HrBaseData(lblNobr.Text);

        AbscDS.wfAbscAppMRow rm = (AbscDS.wfAbscAppMRow)oAbscDS.wfAbscAppM.Rows[0];
        rm.sNote = txtNote.Text;
        rm.bSign = rblCheck.SelectedItem.Value == "1";
        rm.sConditions1 = oHrBaseData.iCateOrder.ToString();
        rm.sState = (!rm.bSign) ? "2" : rm.sState;
        rm.dDateD = DateTime.Now;

        foreach (AbscDS.wfAbscAppSRow rs in oAbscDS.wfAbscAppS.Rows)
        {
            rs.bSign = rblCheck.SelectedItem.Value == "1";
            rs.sState = (!rs.bSign) ? "2" : rs.sState;
        }

        FlowDS.wfSignRow rn = oFlowDS.wfSign.NewwfSignRow();
        rn.sFromCode = "Absc";
        rn.sFromName = "銷假單";
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

        wfAbscAppSTA.Update(oAbscDS.wfAbscAppS);
        wfAbscAppMTA.Update(rm);

        localhost.Service oService = new localhost.Service();

        if (!oService.WorkFinish(Convert.ToInt32(Request["ApParm"]))) {
            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "AlertMsg", "alert('流程發生問題，您核准的動作可能無法完成。');self.close();", true);
        }
        else {
            wfSignTA.Update(oFlowDS.wfSign);

            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "OKMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "OKMsg", "self.location='../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "'", true);
        }
    }

    protected void gvAppS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        LinkButton lbtn = (LinkButton)e.Row.FindControl("lbtnState");

        if (lbtn != null)
        {
            string CommandArgument = lbtn.CommandArgument.ToString();
            lbtn.Text = (wfAbscAppSTA.GetDataByAutoKey(int.Parse(CommandArgument)).Select("sState <> '2'").Length > 0) ? "此筆駁回" : "核准";
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
            wfAbscAppSTA.FillByAutoKey(oAbscDS.wfAbscAppS, int.Parse(CommandArgument));
            if (oAbscDS.wfAbscAppS.Rows.Count > 0)
            {
                AbscDS.wfAbscAppSRow r = (AbscDS.wfAbscAppSRow)oAbscDS.wfAbscAppS.Rows[0];
                r.sState = (r.sState == "1") ? "2" : "1";
                wfAbscAppSTA.Update(r);
                gvAppS.DataBind();
            }
        }
    }
}
