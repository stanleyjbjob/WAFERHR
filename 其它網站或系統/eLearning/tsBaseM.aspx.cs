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

using CustomSecurity;

public partial class tsBaseM : System.Web.UI.Page
{
    private TsDSTableAdapters.tsBaseMTableAdapter tsBaseMTA = new TsDSTableAdapters.tsBaseMTableAdapter();
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private SysDSTableAdapters.BaseTtsTableAdapter BaseTtsTA = new SysDSTableAdapters.BaseTtsTableAdapter();


    private SysDS oSysDS;
    private TsDS oTsDS;
    private int x, y;

    private string UserID;

    private mpSystem mp;

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
        UserID = ((CustomIdentity)Context.User.Identity).Name;

        oTsDS = new TsDS();
        oSysDS = new SysDS();

        if (!this.IsPostBack)
            plOverflow.Attributes.Add("style", "overflow-x: hidden; overflow-y: auto; height: 300px; padding: 0 17px 0 0");
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string cn, ca;
        cn = e.CommandName;
        ca = e.CommandArgument.ToString();

        lblKeyID.Text = ca;

        if (cn == "tsTestView")
        {
            mpePopupTest.Show();

            tsBaseMTA.FillByGuid(oTsDS.tsBaseM, lblKeyID.Text);

            if (oTsDS.tsBaseM.Rows.Count > 0)
            {
                TsDS.tsBaseMRow rm = (TsDS.tsBaseMRow)oTsDS.tsBaseM.Rows[0];
                lblBaseMAutoKey.Text = rm.iAutoKey.ToString();
                lblQuestionsMCode.Text = rm.tsQuestionsM_sCode;
                lblNobr.Text = rm.sNobr;

                tsQuestionsMTA.FillByKey(oTsDS.tsQuestionsM, lblQuestionsMCode.Text);
                if (oTsDS.tsQuestionsM.Rows.Count > 0)
                {
                    TsDS.tsQuestionsMRow rqm = (TsDS.tsQuestionsMRow)oTsDS.tsQuestionsM.Rows[0];
                    lblDragNameTest.Text = rqm.sName;
                    lblHeader.Text = rqm.IssHeaderNull() ? "" : rqm.sHeader;    //表頭
                    lblNotice.Text = rqm.IssNoticeNull() ? "" : rqm.sNotice;    //注意事項
                    lblFooter.Text = rqm.IssFooterNull() ? "" : rqm.sFooter;    //表尾       

                    mv.ActiveViewIndex = 1;
                }
            }
        }
        else if (cn == "ReTest")
        {
            tsBaseMTA.FillByGuid(oTsDS.tsBaseM, lblKeyID.Text);
            if (oTsDS.tsBaseM.Rows.Count > 0)
            {
                TsDS.tsBaseMRow rm = (TsDS.tsBaseMRow)oTsDS.tsBaseM.Rows[0], rm1;
                rm1 = oTsDS.tsBaseM.NewtsBaseMRow();
                rm1.tsQuestionsM_sCode = rm.tsQuestionsM_sCode;
                rm1.sGuid = Guid.NewGuid().ToString();
                rm1.iMinute = 0;
                rm1.sNobr = rm.sNobr;
                rm1.sPW = Guid.NewGuid().ToString();
                rm1.sName = "";
                rm1.dAmountDate = DateTime.Now;
                rm1.iFraction = 0;
                rm1.tsTitle_sCode = "";
                oTsDS.tsBaseM.AddtsBaseMRow(rm1);
                tsBaseMTA.Update(rm1);
                gv.DataBind();
                mp.Msg = "重考設定完成";
            }
        }
        else if (cn == "Del")
        {
            tsBaseMTA.FillByGuid(oTsDS.tsBaseM, lblKeyID.Text);
            if (oTsDS.tsBaseM.Rows.Count > 0)
            {
                TsDS.tsBaseMRow rm = (TsDS.tsBaseMRow)oTsDS.tsBaseM.Rows[0];
                tsBaseMTA.Delete(rm.iAutoKey);
                gv.DataBind();
                mp.Msg = "刪除完成";
            }
        }
        else if (cn == "Export")
        {
            gv.AllowPaging = false;
            gv.AllowSorting = false;
            gv.Columns[0].Visible = false;
            gv.DataBind();
            sa.gv.ExportXls(gv);
        }
    }

    public override void VerifyRenderingInServerForm(Control control) { }

    protected void btnExitTest_Click(object sender, EventArgs e)
    {
        mpePopupTest.Hide();
    }

    protected void dlCategory_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        DataList dlBaseS = e.Item.FindControl("dlBaseS") as DataList;
        SqlDataSource sdsBaseS = (SqlDataSource)e.Item.FindControl("sdsBaseS");
        lblCategoryCode.Text = (e.Item.FindControl("lblCategoryCode") as Label).Text;   //考題類別丟到外面

        dlBaseS.DataSource = sdsBaseS;
        dlBaseS.DataBind();
    }

    protected void dlBaseS_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Panel plAnswer = e.Item.FindControl("plAnswer") as Panel;
        DataList dlAnswer = e.Item.FindControl("dlAnswer") as DataList;
        CheckBox cbAnswerYes, cbAnswerNo;
        cbAnswerYes = (CheckBox)e.Item.FindControl("cbAnswerYes");    //是非使用(對)
        cbAnswerNo = (CheckBox)e.Item.FindControl("cbAnswerNo");  //是非使用(錯)
        TextBox txtAnswer = e.Item.FindControl("txtAnswer") as TextBox;
        SqlDataSource sdsAnswer = (SqlDataSource)e.Item.FindControl("sdsAnswer");
        lblAnswer.Text = ((Label)e.Item.FindControl("lblAnswer")).Text; //答案(是非用)/問答統計字數
        lblFraction.Text = ((Label)e.Item.FindControl("lblFraction")).Text; //題目分數
        lblPass.Text = ((Label)e.Item.FindControl("lblPass")).Text; //題目分數
        lblChooseAutoKey.Text = ((Label)e.Item.FindControl("lblChooseAutoKey")).Text; //題目分數
        Label lblSn = (Label)e.Item.FindControl("lblSn");
        lblEaxminationAutoKey.Text = ((Label)e.Item.FindControl("lblEaxminationAutoKey")).Text; //考題代碼丟到外面

        y++;
        lblSn.Text = y.ToString().PadLeft(3, char.Parse("0"));

        plAnswer.Visible = lblCategoryCode.Text == "1"; //是非題
        dlAnswer.Visible = lblCategoryCode.Text == "2" || lblCategoryCode.Text == "3";  //選擇、複選
        txtAnswer.Visible = lblCategoryCode.Text == "4";    //問答

        e.Item.BackColor = Convert.ToBoolean(lblPass.Text) ? e.Item.BackColor : System.Drawing.Color.Pink;

        if (lblChooseAutoKey.Text != "-1" && lblCategoryCode.Text == "1")//是非題
        {
            cbAnswerYes.Checked = lblChooseAutoKey.Text == "1";
            cbAnswerNo.Checked = lblChooseAutoKey.Text == "0";
        }

        dlAnswer.DataSource = sdsAnswer;
        dlAnswer.DataBind();
    }

    protected void dlAnswer_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        CheckBox cbAnswer = e.Item.FindControl("cbAnswer") as CheckBox;
        if (lblChooseAutoKey.Text != "-1" && lblCategoryCode.Text == "2")   //選擇題
            cbAnswer.Checked = lblChooseAutoKey.Text == cbAnswer.ToolTip;
        else if (lblChooseAutoKey.Text != "-1" && lblCategoryCode.Text == "3")  //複選題
            cbAnswer.Checked = lblAnswer.Text.IndexOf("," + cbAnswer.ToolTip + ",") >= 0;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        Button btnExport = e.Row.FindControl("btnExport") as Button;
        if (btnExport != null)
            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnExport);
    }

    protected void gv_DataBound(object sender, EventArgs e)
    {
        DataRow[] rows;
        BaseTtsTA.Fill(oSysDS.BaseTts);
        foreach (GridViewRow r in gv.Rows)
        {
            if (r.RowType == DataControlRowType.DataRow)
            {
                rows = oSysDS.BaseTts.Select("sNobr = '" + r.Cells[2].Text + "'");
                if (rows.Length > 0)
                {
                    SysDS.BaseTtsRow rb = rows[0] as SysDS.BaseTtsRow;
                    r.Cells[3].Text = rb.sNamec.Trim();
                }                
            }
        }
    }

    protected void dlView_ItemCommand(object source, DataListCommandEventArgs e)
    {
        mpePopupTest.Show();

        string cn, ca;
        cn = e.CommandName;
        ca = e.CommandArgument.ToString();

        lblKeyID.Text = ca;

        if (cn == "View")
        {
            tsBaseMTA.FillByGuid(oTsDS.tsBaseM, lblKeyID.Text);

            if (oTsDS.tsBaseM.Rows.Count > 0)
            {
                TsDS.tsBaseMRow rm = (TsDS.tsBaseMRow)oTsDS.tsBaseM.Rows[0];
                lblBaseMAutoKey.Text = rm.iAutoKey.ToString();
                lblQuestionsMCode.Text = rm.tsQuestionsM_sCode;
                lblNobr.Text = rm.sNobr;

                mv.ActiveViewIndex = 1;
            }
        }
    }

    protected void btnPrv_Click(object sender, EventArgs e)
    {
        mpePopupTest.Show();
        mv.ActiveViewIndex = 0;
        dlView.DataBind();
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblSearch.Text = txtSearch.Text.Trim().Length == 0 ? "a" : txtSearch.Text.Trim();
        gv.DataBind();
    }
    protected void ddlQuestionsM_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (ddlQuestionsM.Items.Count > 0)
        {
            lblSearch.Text = ddlQuestionsM.SelectedItem.Value;
            gv.DataBind();
        }
    }
    protected void fvBaseM_DataBound(object sender, EventArgs e)
    {
        Label lblNobr, lblName;
        lblNobr = fvBaseM.FindControl("lblNobr") as Label;
        lblName = fvBaseM.FindControl("lblName") as Label;

        if (lblNobr != null && lblName != null)
        {
            DataRow[] rows = BaseTtsTA.GetDataByNobr(lblNobr.Text).Select();
            if (rows.Length > 0)
            {
                SysDS.BaseTtsRow rb = rows[0] as SysDS.BaseTtsRow;
                lblName.Text = rb.sNamec;
            }
        }
    }

}