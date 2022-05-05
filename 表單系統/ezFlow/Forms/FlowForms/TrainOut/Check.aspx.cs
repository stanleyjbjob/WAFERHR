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
using System.IO;

public partial class TrainOut_Check : System.Web.UI.Page
{
    //Flow
    public FlowDSTableAdapters.wfSignTableAdapter wfSignTA = new FlowDSTableAdapters.wfSignTableAdapter();
    public FlowDSTableAdapters.wfUpFileTableAdapter wfUpFileTA = new FlowDSTableAdapters.wfUpFileTableAdapter();

    //Form
    public TrainDSTableAdapters.wfTrainAppMTableAdapter wfTrainAppMTA = new TrainDSTableAdapters.wfTrainAppMTableAdapter();
    public TrainDSTableAdapters.wfTrainAppSTableAdapter wfTrainAppSTA = new TrainDSTableAdapters.wfTrainAppSTableAdapter();
    public TrainDSTableAdapters.wfTrainAppNTableAdapter wfTrainAppNTA = new TrainDSTableAdapters.wfTrainAppNTableAdapter();
    public TrainDSTableAdapters.wfTrainSetTableAdapter wfTrainSetTA = new TrainDSTableAdapters.wfTrainSetTableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public TrainDS oTrainDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        oFlowDS = new FlowDS();
        oTrainDS = new TrainDS();

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
        rblCheck.Visible = (RequestName == "ApParm");
        plSign.Visible = (RequestName == "ApParm");

        if (!this.IsPostBack)
        {
            lblUrl.Text = Request.Url.Query;
            lblProcessID.Text = FlowCS.GetProcessID(RequestName, int.Parse(RequestValue));

            wfTrainAppMTA.FillByProcessID(oTrainDS.wfTrainAppM, lblProcessID.Text);
            if (oTrainDS.wfTrainAppM.Rows.Count > 0)
            {
                TrainDS.wfTrainAppMRow rm = (TrainDS.wfTrainAppMRow)oTrainDS.wfTrainAppM.Rows[0];
                rblCheck.ClearSelection();
                rblCheck.Items.FindByValue(rm.bSign ? "1" : "0").Selected = true;
                lblCharge.Text = rm.iCharge.ToString();
                lblCharge.ToolTip = lblCharge.Text;
                rblBounty.ClearSelection();
                rblBounty.Items.FindByValue((rm.iBounty == 1) ? "1" : "0").Selected = true;
                txtBounty.Text = String.Format("{0:N0}", rm.iBounty * 100);
                txtBounty.ToolTip = txtBounty.Text;
                lblBounty.Text = txtBounty.Text;
                rblBaker.ClearSelection();
                rblBaker.Items.FindByValue(rm.sBakerday == "0" ? "0" : "1").Selected = true;
                lblSum.Text = convertNum(rm.iCharge);
                gvAppS.DataBind();

                rblBounty_SelectedIndexChanged(sender, e);
            }

            wfTrainSetTA.Fill(oTrainDS.wfTrainSet);
            if (oTrainDS.wfTrainSet.Rows.Count == 0)
            {
                lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            TrainDS.wfTrainSetRow r = (TrainDS.wfTrainSetRow)oTrainDS.wfTrainSet.Rows[0];
            lblNote.Text = r.sCheckNote;
            pNote.Visible = r.bSignNote;

            lbtnFileManage.Visible = wfUpFileTA.GetDataByProcessID(lblProcessID.Text).Rows.Count > 0;
        }

    }

    protected void lbtn_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        string link = "MyFrame.aspx?url=" + lbtn.CommandName + ".aspx?nobr=" + lblNobr.Text + "&id=" + lblProcessID.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = " + Form.ClientID + ";" +
            "window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Download", script, true);
    }

    protected void gvAppS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string RequestName = Request.QueryString.AllKeys[0];
        Label lblSign = (Label)e.Row.FindControl("lblSign");
        Label lblState = (Label)e.Row.FindControl("lblState");
        RadioButtonList rblSign = (RadioButtonList)e.Row.FindControl("rblSign");
        if (lblSign != null)
        {
            wfTrainAppSTA.FillByKey(oTrainDS.wfTrainAppS, int.Parse(lblSign.Text));
            if (oTrainDS.wfTrainAppS.Rows.Count > 0)
            {
                TrainDS.wfTrainAppSRow rs = (TrainDS.wfTrainAppSRow)oTrainDS.wfTrainAppS.Rows[0];
                rblSign.ClearSelection();
                rblSign.Items.FindByValue(rs.bSign ? "1" : "0").Selected = true;

                e.Row.Visible = (rs.bSign || (RequestName != "ApParm"));
                e.Row.ForeColor = (rs.bSign) ? e.Row.ForeColor : System.Drawing.Color.Red;
                lblState.Text = rs.bSign ? "核准" : "駁回";
                rblSign.Visible = (RequestName == "ApParm");
                lblState.Visible = (RequestName != "ApParm");
            }
        }
    }

    protected void gvAppS_DataBound(object sender, EventArgs e)
    {
        wfTrainAppSTA.FillByProcessID(oTrainDS.wfTrainAppS, lblProcessID.Text);

        lblCountT.Text = oTrainDS.wfTrainAppS.Rows.Count.ToString();
        lblCount.Text = oTrainDS.wfTrainAppS.Select("bSign = 1").Length.ToString();
    }

    protected void btnSign_Click(object sender, EventArgs e)
    {
        wfTrainAppMTA.FillByProcessID(oTrainDS.wfTrainAppM, lblProcessID.Text);
        wfTrainAppSTA.FillByProcessID(oTrainDS.wfTrainAppS, lblProcessID.Text);
        wfTrainAppNTA.FillByProcessID(oTrainDS.wfTrainAppN, lblProcessID.Text);
        wfSignTA.Fill(oFlowDS.wfSign);

        if (oTrainDS.wfTrainAppM.Rows.Count == 0)
        {
            lblMsg.Text = "找不到重要的簽核資料，請洽管理人員";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        decimal Bounty = 0;
        try {
            Bounty = Convert.ToDecimal(txtBounty.Text);
        }
        catch
        {
            lblMsg.Text = "補助百分比格式不正確";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (rblBaker.SelectedItem.Value == "1" && txtBaker.Text.Trim().Length == 0)
        {
            lblMsg.Text = "請輸入研習心得分享日期(不一定要日期格式)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseData = new HrBaseData(lblNobr.Text);

        TrainDS.wfTrainAppMRow rm = (TrainDS.wfTrainAppMRow)oTrainDS.wfTrainAppM.Rows[0];
        rm.sNote = txtNote.Text;
        rm.bSign = rblCheck.SelectedItem.Value == "1";
        rm.sConditions1 = oHrBaseData.iCateOrder.ToString();
        rm.sState = (!rm.bSign) ? "2" : rm.sState;
        rm.dDateD = DateTime.Now;
        rm.sBakerday = txtBaker.Text.Trim().Length > 0 ? txtBaker.Text : "0";

        Label lblSign;
        RadioButtonList rblSign;
        foreach (GridViewRow r in gvAppS.Rows)
        {
            lblSign = (Label)r.FindControl("lblSign");
            rblSign = (RadioButtonList)r.FindControl("rblSign");
            if (rblSign != null)
            {
                rows = oTrainDS.wfTrainAppS.Select("iAutoKey = " + int.Parse(lblSign.Text));
                if (rows.Length > 0)
                {
                    TrainDS.wfTrainAppSRow rs = (TrainDS.wfTrainAppSRow)rows[0];
                    rs.bSign = (rblSign.SelectedItem.Value == "1" && rblCheck.SelectedItem.Value == "1");
                    rs.sState = (!rs.bSign) ? "2" : rs.sState;
                }
            }
        }

        FlowDS.wfSignRow rn = oFlowDS.wfSign.NewwfSignRow();
        rn.sFromCode = "TrainOut";
        rn.sFromName = "外訓單";
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

        TrainDS.wfTrainAppNRow rnn = oTrainDS.wfTrainAppN.NewwfTrainAppNRow();
        rnn.sProcessID = lblProcessID.Text;
        rnn.idProcess = int.Parse(rnn.sProcessID);
        rnn.iBounty = Bounty / 100;
        rnn.sBakerday = txtBaker.Text.Trim().Length > 0 ? txtBaker.Text : "0";
        oTrainDS.wfTrainAppN.AddwfTrainAppNRow(rnn);
        

        wfTrainAppSTA.Update(oTrainDS.wfTrainAppS);
        wfTrainAppMTA.Update(rm);

        localhost.Service oService = new localhost.Service();

        if (!oService.WorkFinish(Convert.ToInt32(Request["ApParm"])))
        {
            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "AlertMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "AlertMsg", "alert('流程發生問題，您核准的動作可能無法完成。');self.close();", true);
        }
        else
        {
            wfTrainAppNTA.Update(oTrainDS.wfTrainAppN);
            wfSignTA.Update(oFlowDS.wfSign);

            if (!Page.ClientScript.IsStartupScriptRegistered(typeof(string), "OKMsg"))
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "OKMsg", "self.location='../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "'", true);
        }
    }

    //零壹貳參肆伍陸柒捌玖拾
    public string convertNum(int num)
    {
        string[] chFont = { "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾" };
        string[] chLv = { "", "拾", "佰", "仟", "萬" };
        string numS, numS1;
        string ch = "";
        int numCount = num.ToString().Length - 1;
        int j = 0;

        for (int i = 0; i <= numCount; i++)
        {
            numS1 = "0";
            j = i + 1;
            numS = num.ToString().Substring(i, 1);
            if (j <= numCount) numS1 = num.ToString().Substring(j, 1);


            if ((numCount - i) > 4)
            {
                ch += chFont[int.Parse(numS)] + chLv[numCount - 4 - i];
            }
            else
            {
                ch += chFont[int.Parse(numS)] + chLv[numCount - i];
            }
        }

        return ch + "元整";
    }

    protected void rblBounty_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (rblBounty.SelectedItem.Value == "1")
        {
            txtBounty.ToolTip = txtBounty.Text;
            txtBounty.Text = "100";
        }
        else
        {
            txtBounty.Text = txtBounty.ToolTip;
        }

        txtBounty_TextChanged(sender, e);
    }

    protected void txtBounty_TextChanged(object sender, EventArgs e)
    {
        int lblChargeV = int.Parse(lblCharge.ToolTip);

        int total = 0, diff = 0, diff1 = 0;
        diff = lblChargeV / int.Parse(lblCountT.Text);
        total = diff * int.Parse(lblCount.Text);
        if (lblCountT.Text == lblCount.Text)
            diff1 = (lblChargeV - total);

        total += diff1;
        lblCharge.Text = total.ToString();
        if (txtBounty.Text != "100")
        {
            if (lblCharge.Text.Trim().Length > 0 && txtBounty.Text.Trim().Length > 0)
            {
                try
                {
                    int txtBountyV = int.Parse(txtBounty.Text);
                    double calculation = (total * txtBountyV) / 100;
                    string PartP = Convert.ToString(Math.Round(total - calculation, 0));

                    PartP = (PartP.Length >= 3) ? PartP.Substring(0, PartP.Length - 2) + "00" : PartP;
                    lblPartP.Text = PartP;

                    int PartCom = total - int.Parse(PartP);
                    lblPartCom.Text = PartCom.ToString();
                }
                catch
                {
                    lblCharge.Text = lblCharge.ToolTip;
                    txtBounty.Text = "100";
                    lblMsg.Text = "格式不正確";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                    return;
                }
            }

            rblBounty.ClearSelection();
            rblBounty.Items.FindByValue("0").Selected = true;
        }
        else
        {
            lblPartP.Text = "0";
            lblPartCom.Text = lblCharge.Text;
        }

        lblSum.Text = (lblPartCom.Text != "") ? convertNum(int.Parse(lblPartCom.Text)) : "";
    }

    protected void rblSign_SelectedIndexChanged(object sender, EventArgs e)
    {
        int i = 0;
        RadioButtonList rblSign;
        foreach (GridViewRow r in gvAppS.Rows)
        {
            rblSign = (RadioButtonList)r.FindControl("rblSign");
            if (rblSign != null)
                if (rblSign.SelectedItem.Value == "1")
                    i++;
        }

        lblCount.Text = i.ToString();

        rblBounty_SelectedIndexChanged(sender, e);
    }
}