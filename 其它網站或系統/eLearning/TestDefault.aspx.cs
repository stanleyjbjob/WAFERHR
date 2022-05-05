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
using System.Text;

using CustomSecurity;

public partial class TestDefault : System.Web.UI.Page
{
    private TsDSTableAdapters.tsBaseMTableAdapter tsBaseMTA = new TsDSTableAdapters.tsBaseMTableAdapter();
    private TsDSTableAdapters.tsBaseSTableAdapter tsBaseSTA = new TsDSTableAdapters.tsBaseSTableAdapter();
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private TsDSTableAdapters.tsQuestionsSTableAdapter tsQuestionsSTA = new TsDSTableAdapters.tsQuestionsSTableAdapter();
    private TsDSTableAdapters.tsEaxminationTableAdapter tsEaxminationTA = new TsDSTableAdapters.tsEaxminationTableAdapter();
    private TsDSTableAdapters.tsChooseTableAdapter tsChooseTA = new TsDSTableAdapters.tsChooseTableAdapter();
    private TsDSTableAdapters.tsTitleTableAdapter tsTitleTA = new TsDSTableAdapters.tsTitleTableAdapter();
    private SysDSTableAdapters.BaseTtsTableAdapter BaseTtsTA = new SysDSTableAdapters.BaseTtsTableAdapter();

    private TsDS oTsDS;

    private DataRow[] rows;

    private int x, y;

    private mpUser mp;

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = ((mpUser)Master);
        mp.Msg = "";
        lblUserID.Text = ((CustomIdentity)Context.User.Identity).Name;

        oTsDS = new TsDS();

        if (!this.IsPostBack)
        {
            lblSecond.Text = JBLib.Module.MyCS.GetDefault("tsTest").Count > 0 ? JBLib.Module.MyCS.GetDefault("tsTest")["iSecond"].ToString() : "0";
            plOverflow.Attributes.Add("style", "overflow-x: hidden; overflow-y: auto; height: 350px; padding: 0 17px 0 0");
        }
    }

    protected void mu_MenuItemClick(object sender, MenuEventArgs e)
    {
        lblMsg.Text = "";
        lblMenu.Text = e.Item.Value;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        Label lblRepeat = e.Row.FindControl("lblRepeat") as Label;
        Label lblRepeatNow = e.Row.FindControl("lblRepeatNow") as Label;
        Button btnSelect = (Button)e.Row.FindControl("btnSelect");
        if (btnSelect != null)
        {
            if (mu.SelectedItem.Value == "0")
                btnSelect.Visible = false;
            else if (mu.SelectedItem.Value == "1")
            {
                btnSelect.Text = "考試";
                btnSelect.OnClientClick = "";
                btnSelect.CommandName = "tsTest";
            }
            else if (mu.SelectedItem.Value == "2")
            {
                btnSelect.Text = "重考";
                btnSelect.OnClientClick = "return confirm('您確定要重新考試嗎？');";
                btnSelect.CommandName = "ReTest";
                btnSelect.Enabled = Convert.ToInt32(lblRepeat.Text) > Convert.ToInt32(lblRepeatNow.Text);
                btnSelect.Text = btnSelect.Enabled ? btnSelect.Text : "已達上限";
            }
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string cn, ca;
        cn = e.CommandName;
        ca = e.CommandArgument.ToString();

        lblKeyID.Text = ca;

        if (cn == "tsTest")
        {
            mpePopupTest.Show();

            tsBaseMTA.FillByGuid(oTsDS.tsBaseM, lblKeyID.Text);

            if (oTsDS.tsBaseM.Rows.Count > 0)
            {
                TsDS.tsBaseMRow rm = (TsDS.tsBaseMRow)oTsDS.tsBaseM.Rows[0];
                lblBaseMAutoKey.Text = rm.iAutoKey.ToString();
                lblQuestionsMCode.Text = rm.tsQuestionsM_sCode;

                tsQuestionsMTA.FillByKey(oTsDS.tsQuestionsM, lblQuestionsMCode.Text);
                if (oTsDS.tsQuestionsM.Rows.Count > 0)
                {
                    TsDS.tsQuestionsMRow rqm = (TsDS.tsQuestionsMRow)oTsDS.tsQuestionsM.Rows[0];
                    lblDragNameTest.Text = rqm.sName;
                    lblRandomEaxm.Text = rqm.bRandomEaxm.ToString();    //是否要亂數排序考題
                    lblRandomChoose.Text = rqm.bRandomChoose.ToString();    //是否要亂數排序答案
                    lblHeader.Text = rqm.IssHeaderNull() ? "" : rqm.sHeader;    //表頭
                    lblNotice.Text = rqm.IssNoticeNull() ? "" : rqm.sNotice;    //注意事項
                    lblFooter.Text = rqm.IssFooterNull() ? "" : rqm.sFooter;    //表尾
                    lblMinute.Text = rqm.iMinute.ToString();    //可考時間
                    lblRespondMode.Text = rqm.sRespondMode; //出題方式
                    lblTitleM.Text = rqm.tsTitleM_sCode;    //評等群組

                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", GetTimeOutScript(Form.ClientID, txtShowTime.ClientID, txtOutTime.ClientID, btnSubmit.ClientID, Convert.ToString((rqm.iMinute * 60 * 1000) + (Convert.ToInt32(lblSecond.Text) * 1000))), true);

                    //判斷是否已出考題
                    if (tsBaseSTA.GetDataByBaseM_iAutoKey(rm.iAutoKey).Rows.Count == 0)
                    {
                        //先不管幾題，全部亂排
                        tsQuestionsSTA.FillByNewID(oTsDS.tsQuestionsS, lblQuestionsMCode.Text);

                        if (oTsDS.tsQuestionsS.Rows.Count > 0)
                        {
                            TsDS.tsQuestionsSRow rqs;
                            TsDS.tsBaseSRow rbs;

                            int iMax = rqm.iMax <= oTsDS.tsQuestionsS.Rows.Count ? rqm.iMax : oTsDS.tsQuestionsS.Rows.Count;    //最大考題數
                            for (int i = 0; i < iMax; i++)
                            {
                                rqs = (TsDS.tsQuestionsSRow)oTsDS.tsQuestionsS.Rows[i];
                                rbs = oTsDS.tsBaseS.NewtsBaseSRow();
                                rbs.tsBaseM_iAutoKey = rm.iAutoKey;
                                rbs.tsEaxmination_iAutoKey = rqs.tsEaxmination_iAutoKey;
                                rbs.tsChoose_iAutoKey = -1;
                                rbs.bPass = false;
                                rbs.iFraction = 0;
                                oTsDS.tsBaseS.AddtsBaseSRow(rbs);
                            }

                            tsBaseSTA.Update(oTsDS.tsBaseS);
                        }
                    }
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
    }

    protected void btnExitTest_Click(object sender, EventArgs e)
    {
        mpePopupTest.Hide();
        gv.DataBind();
    }

    protected void btnStart_Click(object sender, EventArgs e)
    {
        mpePopupTest.Show();

        //產生考生考題
        tsBaseMTA.FillByGuid(oTsDS.tsBaseM, lblKeyID.Text);
        if (oTsDS.tsBaseM.Rows.Count > 0)
        {
            TsDS.tsBaseMRow rbm = (TsDS.tsBaseMRow)oTsDS.tsBaseM.Rows[0];

            rbm.dWriteDate = DateTime.Now;
            tsBaseMTA.Update(oTsDS.tsBaseM);

            //加上已考時間
            lblTime.ToolTip = DateTime.Now.AddMinutes(rbm.iMinute).ToString();

            //試窗關閉功能關掉
            btnExitTest.Enabled = false;

            //交卷按鈕打開
            btnSubmit.Visible = true;

            //計數器打開
            tmTest.Interval = (Convert.ToInt32(lblMinute.Text) * 60 * 1000) + (Convert.ToInt32(lblSecond.Text) * 1000);
            tmTest.Enabled = true;

            mv.ActiveViewIndex = Convert.ToInt32(lblRespondMode.Text); //作答方式(全部/類別/逐一)
            mp.Msg = "開始考試囉";

            dlCategory.DataSource = sdsCategory;
            dlCategory.DataBind();
        }
    }

    protected void dlCategory_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        DataList dlBaseS = e.Item.FindControl("dlBaseS") as DataList;
        SqlDataSource sdsBaseS = (SqlDataSource)e.Item.FindControl("sdsBaseS");
        SqlDataSource sdsBaseSNewID = (SqlDataSource)e.Item.FindControl("sdsBaseSNewID");
        lblCategoryCode.Text = (e.Item.FindControl("lblCategoryCode") as Label).Text;   //考題類別丟到外面

        dlBaseS.DataSource = Convert.ToBoolean(lblRandomEaxm.Text) ? sdsBaseSNewID : sdsBaseS;
        dlBaseS.DataBind();
    }

    protected void dlBaseS_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Panel plAnswer = e.Item.FindControl("plAnswer") as Panel;
        DataList dlAnswer = e.Item.FindControl("dlAnswer") as DataList;
        TextBox txtAnswer = e.Item.FindControl("txtAnswer") as TextBox;
        SqlDataSource sdsAnswer = (SqlDataSource)e.Item.FindControl("sdsAnswer");
        SqlDataSource sdsAnswerNewID = (SqlDataSource)e.Item.FindControl("sdsAnswerNewID");
        Label lblSn = (Label)e.Item.FindControl("lblSn");
        lblEaxminationAutoKey.Text = ((Label)e.Item.FindControl("lblEaxminationAutoKey")).Text; //考題代碼丟到外面

        y++;
        lblSn.Text = y.ToString().PadLeft(3, char.Parse("0"));

        plAnswer.Visible = lblCategoryCode.Text == "1"; //是非題
        dlAnswer.Visible = lblCategoryCode.Text == "2" || lblCategoryCode.Text == "3";  //選擇、複選
        txtAnswer.Visible = lblCategoryCode.Text == "4";    //問答

        dlAnswer.DataSource = Convert.ToBoolean(lblRandomChoose.Text) ? sdsAnswerNewID : sdsAnswer;
        dlAnswer.DataBind();
    }

    protected void dlAnswer_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        AjaxControlToolkit.MutuallyExclusiveCheckBoxExtender mecbeAnswer = e.Item.FindControl("mecbeAnswer") as AjaxControlToolkit.MutuallyExclusiveCheckBoxExtender;
        mecbeAnswer.Enabled = lblCategoryCode.Text != "3";
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //試窗關閉功能打開
        btnExitTest.Enabled = true;

        //計數器關閉
        tmTest.Enabled = false;

        //交卷按鈕關閉
        btnSubmit.Visible = false;

        mv.ActiveViewIndex = 0;

        tsBaseMTA.FillByAutoKey(oTsDS.tsBaseM, Convert.ToInt32(lblBaseMAutoKey.Text));
        tsBaseSTA.FillByBaseM_iAutoKey(oTsDS.tsBaseS, Convert.ToInt32(lblBaseMAutoKey.Text));

        int i = 0, j = 0;  //答對題數，多少分
        TsDS.tsBaseMRow rm;
        TsDS.tsBaseSRow rs;

        if (oTsDS.tsBaseM.Rows.Count > 0)
        {
            rm = (TsDS.tsBaseMRow)oTsDS.tsBaseM.Rows[0];

            //分類
            foreach (DataListItem dliC in dlCategory.Items)
            {
                DataList dlBaseS = (DataList)dliC.FindControl("dlBaseS");
                Label lblCategoryCode = (Label)dliC.FindControl("lblCategoryCode"); //分類代碼

                //題目
                foreach (DataListItem dliB in dlBaseS.Items)
                {
                    DataList dlAnswer = (DataList)dliB.FindControl("dlAnswer"); //考題(選擇複選使用)
                    CheckBox cbAnswerYes, cbAnswerNo, cbAnswer;
                    cbAnswerYes = (CheckBox)dliB.FindControl("cbAnswerYes");    //是非使用(對)
                    cbAnswerNo = (CheckBox)dliB.FindControl("cbAnswerNo");  //是非使用(錯)
                    int iAnswer = (cbAnswerYes.Checked || cbAnswerNo.Checked) ? cbAnswerYes.Checked ? 1 : 0 : -1;  //-1代表沒有做此題
                    TextBox txtAnswer = (TextBox)dliB.FindControl("txtAnswer"); //答案問答題
                    Label lblEaxminationAutoKey = (Label)dliB.FindControl("lblEaxminationAutoKey"); //考題代碼
                    Label lblBaseSAutoKey = (Label)dliB.FindControl("lblBaseSAutoKey"); //考題代碼(填入)
                    Label lblAnswer = (Label)dliB.FindControl("lblAnswer"); //答案(是非用)/問答統計字數
                    Label lblFraction = (Label)dliB.FindControl("lblFraction"); //題目分數

                    rows = oTsDS.tsBaseS.Select("iAutoKey = " + Convert.ToInt32(lblBaseSAutoKey.Text));
                    if (rows.Length > 0)
                    {
                        rs = rows[0] as TsDS.tsBaseSRow;
                        lblCategoryCode.ToolTip = (lblCategoryCode.Text == "2" || lblCategoryCode.Text == "3") ? "2" : lblCategoryCode.Text;

                        switch (lblCategoryCode.ToolTip)
                        {
                            case "1":  //是非題
                                rs.tsChoose_iAutoKey = iAnswer;
                                rs.bPass = iAnswer == Convert.ToInt32(lblAnswer.Text);
                                break;
                            case "2":   //選擇題或複選題
                                bool bAnswer = true;   //記錄是否完全正確
                                string sAnswer = ",";    //記錄複選的答案
                                iAnswer = -1;   //記錄單選那一個
                                foreach (DataListItem dliA in dlAnswer.Items)
                                {
                                    cbAnswer = (CheckBox)dliA.FindControl("cbAnswer");
                                    bAnswer = bAnswer && Convert.ToBoolean(cbAnswer.ValidationGroup) == cbAnswer.Checked;   //一定一直要是正確的，否則一次不同就不會再正確了
                                    iAnswer = cbAnswer.Checked ? Convert.ToInt32(cbAnswer.ToolTip) : iAnswer;
                                    sAnswer += cbAnswer.Checked ? (Convert.ToInt32(cbAnswer.ToolTip) + ",") : "";
                                }

                                rs.bPass = bAnswer;
                                rs.tsChoose_iAutoKey = iAnswer; //複選題不可參考此，但一樣會存入
                                rs.sAnswer = sAnswer; //複選題參考此，但選擇題一樣會存入                              
                                break;
                            case "4":   //問答題
                                rs.sAnswer = txtAnswer.Text;
                                rs.bPass = txtAnswer.Text.Trim().Length > Convert.ToInt32(lblAnswer.Text);
                                break;
                            default:
                                break;
                        }

                        i += rs.bPass ? 1 : 0;
                        rs.iFraction = rs.bPass ? Convert.ToInt32(lblFraction.Text) : rs.iFraction;
                        j += rs.iFraction;
                    }
                }
            }

            tsBaseSTA.Update(oTsDS.tsBaseS);

            TimeSpan ts = DateTime.Now - Convert.ToDateTime(lblTime.ToolTip);

            //評量抬頭
            rm.tsTitle_sCode = Convert.ToString(tsTitleTA.ScalarQueryCode(j, lblTitleM.Text));

            //計算時間
            rm.iMinute = ts.TotalMinutes >= 1 ? Convert.ToInt32(Math.Round(ts.TotalMinutes, 0)) : 1;
            rm.iFraction = j;
            tsBaseMTA.Update(rm);
        }

        mp.Msg = "計分完成，共答對" + i.ToString() + "題，計" + j.ToString() + "分";
        lblMsg.Text = mp.Msg;
        string script = "alert('" + lblMsg.Text + "');self.location = '" + this.Page.Request.Url.Segments[this.Page.Request.Url.Segments.Length - 1] + "';";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", script, true);
        gv.DataBind();
    }

    protected void tmTest_Tick(object sender, EventArgs e)
    {
        DateTime date = Convert.ToDateTime(lblTime.ToolTip);
        TimeSpan ts = date - DateTime.Now;
        mpePopupTest.Show();
        tmTest.Interval = 1000;
        lblTime.Text = ts.Minutes.ToString() + " : " + ts.Seconds.ToString();

        if (date <= DateTime.Now)
        {
            mpePopupTest.Hide();
            btnSubmit_Click(sender, e);
            lblTime.Text = "0 : 0";
        }
    }

    public string GetTimeOutScript(string FromID, string ShowTimeID, string OutTimeID, string SubmitID, string Minute)
    {
        FileStream fs = new FileStream(Server.MapPath("Script/TimeOut.txt"), FileMode.Open, FileAccess.Read);
        StreamReader sr = new StreamReader(fs, Encoding.GetEncoding("big5"));
        string Script = sr.ReadToEnd();
        sr.Close();
        fs.Close();

        Script = Script.Replace("<FormID>", FromID);
        Script = Script.Replace("<ShowTimeID>", ShowTimeID);
        Script = Script.Replace("<OutTimeID>", OutTimeID);
        Script = Script.Replace("<SubmitID>", SubmitID);
        Script = Script.Replace("<Minute>", Minute);

        return Script;
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