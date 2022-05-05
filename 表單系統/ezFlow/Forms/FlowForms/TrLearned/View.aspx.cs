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

public partial class TrLearned_View : System.Web.UI.Page
{
    string FilterItm = "";
    TrLearnedDSTableAdapters.wfTrLearnedAppMTableAdapter TrLearnedTA = new TrLearnedDSTableAdapters.wfTrLearnedAppMTableAdapter();
    TrLearnedDS.wfTrLearnedAppMDataTable TrLearnedDT = new TrLearnedDS.wfTrLearnedAppMDataTable();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (ViewState["FilterExp"] != null)
            sdsS.FilterExpression = ViewState["FilterExp"].ToString();
        if (!IsPostBack)
        {
            txtDateB.Text = DateTime.Now.AddMonths(-12).ToShortDateString();
            txtDateE.Text = DateTime.Now.ToShortDateString(); 
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        switch (ddlSrhItm.SelectedValue)
        {
            case "ALL":
                FilterItm = "";
                break;
            case "sName":
                FilterItm = ddlSrhItm.SelectedValue + " like '%" + txtSrhText.Text + "%'";
                break;
            default:
                FilterItm = ddlSrhItm.SelectedValue + "='" + txtSrhText.Text + "'";
                break;
        }
        sdsS.FilterExpression = FilterItm;
        gvS.DataBind();
    }

    protected void ddlSrhItm_SelectedIndexChanged(object sender, EventArgs e)
    {

        switch (ddlSrhItm.SelectedValue)
        {
            case "ALL":
                txtSrhText.Enabled = false;
                txtSrhText.Text = "";
                break;
            default:
                txtSrhText.Enabled = true;
                break;
        }

    }
    protected void gvS_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();
        TrLearnedTA.FillByProcess(TrLearnedDT, CommandArgument.ToString());
        if (CommandName != "Sort" && CommandArgument.Length > 0)
        {
            DataRowCollection rows = TrLearnedDT.Rows;
            if (rows.Count > 0)
            {
                TrLearnedDS.wfTrLearnedAppMRow r = (TrLearnedDS.wfTrLearnedAppMRow)rows[0];
                if (CommandName == "Upload")
                {
                    string link = "MyFrame.aspx?url=Upload.aspx?nobr=" + r.sNobr + "&id=" + r.sProcessID;
                    string script = "var sFeatures = 'dialogWidth:600px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                        "var obj = form1;" +
                        "window.showModalDialog('" + link + "', obj, sFeatures);";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
                }
                if (CommandName == "Del")
                {
                    r.sState = "4";
                    TrLearnedTA.Update(r);
                    gvS.DataBind();
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('刪除完成');", true);
                }
                if (CommandName == "Print")
                {
                    HrDSTableAdapters.TRLEARNEDTableAdapter Hr_TrlearnedTA = new HrDSTableAdapters.TRLEARNEDTableAdapter();
                    HrDS.TRLEARNEDDataTable Hr_TrlearnedDT = new HrDS.TRLEARNEDDataTable();
                    Hr_TrlearnedTA.FillByProcess(Hr_TrlearnedDT, CommandArgument.ToString());
                    if (Hr_TrlearnedDT.Rows.Count == 0)
                    {
                        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Print", "alert('查無資料!!')", true);
                        return;
                    }
                    string link = "MyFrame.aspx?url=Preview.aspx?idProcess=" + r.sProcessID;
                    string script = "var sFeatures = 'dialogWidth:800px;dialogHeight:800px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                        "var obj = form1;" +
                        "window.showModalDialog('" + link + "', obj, sFeatures);";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Print", script, true);
                }
            }
            if (CommandName == "Services")
            {
                string msg = "呼叫失敗";
                TrLearnWs oWS = new TrLearnWs();
                if (oWS.Run(int.Parse(CommandArgument)))
                    msg = "呼叫成功";

                gvS.DataBind();
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + msg + "');", true);
            }
            if (CommandName == "Restart")
            {
                string msg = "重送失敗";
                TrLearnedTA.FillByProcess(TrLearnedDT, CommandArgument);

                localhost.Service oService = new localhost.Service();
                int ProcessID = oService.GetProcessID();

                if (TrLearnedDT.Rows.Count > 0)
                {
                    TrLearnedDS.wfTrLearnedAppMRow rm = (TrLearnedDS.wfTrLearnedAppMRow)TrLearnedDT.Rows[0];
                    rm.idProcess = ProcessID;
                    rm.sProcessID = ProcessID.ToString();
                    rm.sState = "1";
                    TrLearnedTA.Update(TrLearnedDT);
                    msg = "重送成功";
                }
                gvS.DataBind();
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + msg + "');", true);
            }

        }
    }

    protected void gvS_DataBound(object sender, EventArgs e)
    {
        ViewState["FilterExp"] = sdsS.FilterExpression;
    }    
    protected void mu_MenuItemClick(object sender, MenuEventArgs e)
    {
        gvS.SelectedIndex = -1;        
    }
    protected void cbDateRange_CheckedChanged(object sender, EventArgs e)
    {
        SetTimeRangeState(cbDateRange.Checked);
    }
    void SetTimeRangeState(bool State)
    {
        if (State)
        {
            txtDateB.Enabled = true;
            txtDateE.Enabled = true;
            ibtnDateB.Enabled = true;
            ibtnDateE.Enabled = true;
        }
        else
        {
            txtDateB.Enabled = false;
            txtDateE.Enabled = false;
            ibtnDateB.Enabled = false;
            ibtnDateE.Enabled = false;
        }
    }
}
