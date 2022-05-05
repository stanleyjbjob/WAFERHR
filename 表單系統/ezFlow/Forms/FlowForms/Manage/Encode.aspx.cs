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

public partial class Manage_Encode : System.Web.UI.Page
{
    public FlowDSTableAdapters.wfEncodeTableAdapter wfEncodeTA = new FlowDSTableAdapters.wfEncodeTableAdapter();

    public FlowDS oFlowDS;

    protected void Page_Load(object sender, EventArgs e)
    {
        oFlowDS = new FlowDS();
        lblMsg.Text = "";
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        if (e.Values["sEncode"].ToString().Length == 0)
        {
            lblMsg.Text = "編碼欄位不允許空白";
            e.Cancel = true;
            return;
        }

        if (e.Values["sDecode"].ToString().Length == 0)
        {
            lblMsg.Text = "解碼欄位不允許空白";
            e.Cancel = true;
            return;
        }

        if (wfEncodeTA.GetDataByEncode(e.Values["sEncode"].ToString()).Rows.Count > 0)
        {
            lblMsg.Text = "編碼重複";
            e.Cancel = true;
            return;
        }

        if (wfEncodeTA.GetDataByDecode(e.Values["sDecode"].ToString()).Rows.Count > 0)
        {
            lblMsg.Text = "解碼重複";
            e.Cancel = true;
            return;
        }
    }

    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        lblMsg.Text = "新增完成";
        gv.DataBind();
    }

    protected void btnEncode_Click(object sender, EventArgs e)
    {
        txtCode.Text = FlowCS.GetEncode(txtCode.Text);
    }

    protected void btnDecode_Click(object sender, EventArgs e)
    {
        txtCode.Text = FlowCS.GetDecode(txtCode.Text);
    }
}
