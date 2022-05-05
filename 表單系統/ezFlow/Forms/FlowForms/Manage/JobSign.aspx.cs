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

public partial class Manage_JobSign : System.Web.UI.Page
{
    public FlowDSTableAdapters.wfEncodeTableAdapter wfEncodeTA = new FlowDSTableAdapters.wfEncodeTableAdapter();
    public FlowDSTableAdapters.wfJobSignTableAdapter wfJobSignTA = new FlowDSTableAdapters.wfJobSignTableAdapter();

    public FlowDS oFlowDS;

    protected void Page_Load(object sender, EventArgs e)
    {
        oFlowDS = new FlowDS();
        lblMsg.Text = "";
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (e.Values["sJob"].ToString().Length == 0)
        {
            lblMsg.Text = "職等S不允許空白";
            e.Cancel = true;
            return;
        }

        if (e.Values["iDay"].ToString().Length == 0)
        {
            lblMsg.Text = "天數S不允許空白";
            e.Cancel = true;
            return;
        }

        if (e.Values["sJobE"].ToString().Length == 0)
        {
            lblMsg.Text = "職等E不允許空白";
            e.Cancel = true;
            return;
        }

        if (e.Values["iDayE"].ToString().Length == 0)
        {
            lblMsg.Text = "天數E不允許空白";
            e.Cancel = true;
            return;
        }

        if (e.Values["sSignCode"].ToString().Length == 0)
        {
            lblMsg.Text = "流程編碼不允許空白";
            e.Cancel = true;
            return;
        }

        if (e.Values["sForm"].ToString().Length == 0)
        {
            lblMsg.Text = "表單名稱不允許空白";
            e.Cancel = true;
            return;
        }
    }

    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        lblMsg.Text = "新增完成";
        gv.DataBind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        object x = wfJobSignTA.QuerySignCode(txtJob.Text, Convert.ToInt32(txtDay.Text));
        if (x != null)
            lblMsg.Text = x.ToString();
    }
}
