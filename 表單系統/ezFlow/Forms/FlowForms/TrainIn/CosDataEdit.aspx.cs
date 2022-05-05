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

public partial class TrainIn_CosDataEdit : System.Web.UI.Page
{
    public TrainDSTableAdapters.TRCOSTableAdapter TRCOSTA = new TrainDSTableAdapters.TRCOSTableAdapter();

    public TrainDS oTrainDS;

    public string id;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oTrainDS = new TrainDS();

        if (Request.QueryString["id"] == null)
        {
            lblMsg.Text = "您沒有權限";
            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "key", "alert('" + lblMsg.Text + "');close();", true);
            mv.ActiveViewIndex = -1;
            return;
        }

        id = Request.QueryString["id"];

        if (!IsPostBack)
            setDefault(id);
    }

    public void setDefault(string id)
    {
        TRCOSTA.FillByKey(oTrainDS.TRCOS, id);
        if (oTrainDS.TRCOS.Rows.Count > 0)
        {
            TrainDS.TRCOSRow rt = (TrainDS.TRCOSRow)oTrainDS.TRCOS.Rows[0];
            lblCOSINTRO.Text = rt.IsCOSINTRONull() ? "" : rt.COSINTRO.Trim();
            //lblBENEFIT.Text = rt.IsBENEFITNull() ? "" : rt.BENEFIT.Trim();
            lblTR_PERSON.Text = rt.IsTR_PERSONNull() ? "" : rt.TR_PERSON.Trim();
            lblMENO.Text = rt.IsMENONull() ? "" : rt.MENO.Trim();

            btnEdit1.CommandArgument = lblCOSINTRO.Text;
            //btnEdit2.CommandArgument = lblBENEFIT.Text;
            btnEdit3.CommandArgument = lblTR_PERSON.Text;
            btnEdit4.CommandArgument = lblMENO.Text;
        }
    }

    protected void btnEdit_Command(object sender, CommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        txt.Value = CommandArgument;
        btnUpdate.CommandName = CommandName;
        btnUpdate.CommandArgument = id;

        mv.ActiveViewIndex = 1;
    }

    protected void btnUpdate_Command(object sender, CommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        TRCOSTA.FillByKey(oTrainDS.TRCOS, CommandArgument);

        if (oTrainDS.TRCOS.Rows.Count > 0)
        {
            TrainDS.TRCOSRow rt = (TrainDS.TRCOSRow)oTrainDS.TRCOS.Rows[0];
            rt[CommandName] = txt.Value;

            TRCOSTA.Update(rt);
            setDefault(CommandArgument);
        }

        lblMsg.Text = "儲存完成";
        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "key", "alert('" + lblMsg.Text + "');", true);
        mv.ActiveViewIndex = 0;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 0;
    }
}