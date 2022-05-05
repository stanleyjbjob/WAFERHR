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

public partial class qWrite : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.TRQTableAdapter taTRQ = new QuestionaryDSTableAdapters.TRQTableAdapter();
    public QuestionaryDSTableAdapters.qBaseMTableAdapter qBaseMTA = new QuestionaryDSTableAdapters.qBaseMTableAdapter();
    public QuestionaryDSTableAdapters.qBaseSTableAdapter qBaseSTA = new QuestionaryDSTableAdapters.qBaseSTableAdapter();
    public QuestionaryDSTableAdapters.qTypeTableAdapter qTypeTA = new QuestionaryDSTableAdapters.qTypeTableAdapter();

    public QuestionaryDS oQuestionaryDS;

    public DataRow[] rows;

    public string Code, tmp1, tmp2;
    public int x = 0, y = 0;

    public string TypeCode, Nobr, PW;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oQuestionaryDS = new QuestionaryDS();

        //?TypeCode=A0109212091OA09&Nobr=120596&PW=8447

        TypeCode = Request.QueryString["TypeCode"];
        Nobr = Request.QueryString["Nobr"];
        PW = Request.QueryString["PW"];

        qBaseMTA.FillByCode(oQuestionaryDS.qBaseM, TypeCode + Nobr, PW);
        qBaseSTA.FillByBaseCode(oQuestionaryDS.qBaseS, TypeCode + Nobr);
        qTypeTA.FillByCode(oQuestionaryDS.qType, TypeCode);

        rows = oQuestionaryDS.qBaseM.Select("sCode = '" + TypeCode + Nobr + "' AND sPW = '" + PW + "'");
        if (rows.Length == 0)
        {
            lblMsg.Text = "問卷不存在，請重新登入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');close();", true);
            upl.Visible = false;
            return;
        }

        QuestionaryDS.qBaseMRow rbm = (QuestionaryDS.qBaseMRow)rows[0];
        lblNobr.Text = rbm.sNobr;
        lblName.Text = rbm.sName;
        lblCosName.Text = rbm.sCourseName;
        lblTcrName.Text = rbm.IssDocentNameNull() ? "" : rbm.sDocentName;
        lblDateW.Text = rbm.IsdWriteDateNull() ? "" : rbm.dWriteDate.ToString();
        lblDate.Text = rbm.IsdSchoolDateBNull() || rbm.IsdSchoolDateENull() ? "" : rbm.dSchoolDateB.ToShortDateString() + "-" + rbm.dSchoolDateE.ToShortDateString();

        rows = oQuestionaryDS.qType.Select("sCode = '" + TypeCode + "'");
        if (rows.Length == 0)
        {
            lblMsg.Text = "問卷不存在，請重新登入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            upl.Visible = false;
            return;
        }

        QuestionaryDS.qTypeRow rt = (QuestionaryDS.qTypeRow)rows[0];
        if (DateTime.Now.Date < rt.dDateB)
        {
            lblMsg.Text = "還沒有開始填寫問卷";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            btnSubmit.Visible = false;
        }

        if (DateTime.Now.Date > rt.dDateE)
        {
            lblMsg.Text = "填寫問卷時間已經超過了";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            btnSubmit.Visible = false;
        }

        Code = rt.sQuestionaryCode; //問卷代碼
        lblCode.Text = Code;

        taTRQ.FillByTRQCODE(oQuestionaryDS.TRQ, Code);

        if (Code == null || oQuestionaryDS.TRQ.Rows.Count == 0)
        {
            lblMsg.Text = "系統參數不正確，請重新進入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            upl.Visible = false;
            return;
        }

        QuestionaryDS.TRQRow rqm = (QuestionaryDS.TRQRow)oQuestionaryDS.TRQ.Rows[0];
        lblTitle.Text = rqm.IsCONTENTNull() ? "" : rqm.CONTENT;
        lblHeader.Text = rqm.IsHEADERNull() ? "" : rqm.HEADER;
        lblFooter.Text = rqm.IsFOOTERNull() ? "" : rqm.FOOTER;
    }


    protected void dlQuestionary_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Label lblCastContent = (Label)e.Item.FindControl("lblCastContent");
        Label lblCastCate = (Label)e.Item.FindControl("lblCastCate");
        Label lblCastCode = (Label)e.Item.FindControl("lblCastCode");   //中分類代碼
        RadioButtonList rblCate = (RadioButtonList)e.Item.FindControl("rblCate");
        TextBox txtCate = (TextBox)e.Item.FindControl("txtCate");

        if (lblCastContent != null)
        {
            x++;
            lblCastContent.Text = x.ToString().PadLeft(2, char.Parse("0")) + "." + lblCastContent.Text;

            rblCate.Visible = (lblCastCate.Text == "2");
            txtCate.Visible = (lblCastCate.Text != "1");

            rows = oQuestionaryDS.qBaseS.Select("sQuestionaryCode = '" + Code + "' AND sCastCode = '" + lblCastCode.Text + "' AND sCate <> '1'");
            if (rows.Length > 0)
            {
                QuestionaryDS.qBaseSRow rbs = (QuestionaryDS.qBaseSRow)rows[0];
                if (!rbs.IsiFractionNull())
                    rblCate.Items.FindByValue(((rbs.iFraction == 1) ? "1" : "0")).Selected = true;

                if (!rbs.IssFractionNull())
                    txtCate.Text = rbs.sFraction;
            }
        }
    }

    protected void dlCast_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Label lblThemeContent = (Label)e.Item.FindControl("lblThemeContent");
        Label lblCastCode = (Label)e.Item.FindControl("lblCastCode");
        Label lblThemeCode = (Label)e.Item.FindControl("lblThemeCode");
        RadioButton r1, r2, r3, r4, r5;
        r1 = (RadioButton)e.Item.FindControl("rbFraction1");
        r2 = (RadioButton)e.Item.FindControl("rbFraction2");
        r3 = (RadioButton)e.Item.FindControl("rbFraction3");
        r4 = (RadioButton)e.Item.FindControl("rbFraction4");
        r5 = (RadioButton)e.Item.FindControl("rbFraction5");

        if (lblThemeContent != null)
        {
            tmp1 = lblCastCode.Text;
            if (tmp1 != tmp2)
            {
                y = 0;
                tmp2 = tmp1;
            }

            r1.Visible = r1.Text.Trim().Length > 0;
            r2.Visible = r2.Text.Trim().Length > 0;
            r3.Visible = r3.Text.Trim().Length > 0;
            r4.Visible = r4.Text.Trim().Length > 0;
            r5.Visible = r5.Text.Trim().Length > 0;

            y++;
            lblThemeContent.Text = "　" + y.ToString().PadLeft(2, char.Parse("0")) + "." + lblThemeContent.Text;

            if (lblThemeCode != null)
            {
                rows = oQuestionaryDS.qBaseS.Select("sQuestionaryCode = '" + Code + "' AND sCastCode = '" + lblCastCode.Text + "' AND sThemeCode = '" + lblThemeCode.Text + "'");
                if (rows.Length > 0)
                {
                    QuestionaryDS.qBaseSRow rbs = (QuestionaryDS.qBaseSRow)rows[0];
                    if (!rbs.IsiFractionNull())
                    {
                        switch (rbs.iFraction)
                        {
                            case 5:
                                r5.Checked = true;
                                break;
                            case 4:
                                r4.Checked = true;
                                break;
                            case 3:
                                r3.Checked = true;
                                break;
                            case 2:
                                r2.Checked = true;
                                break;
                            case 1:
                                r1.Checked = true;
                                break;
                        }
                    }
                } //enf if
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        //中分類
        foreach (DataListItem dliQ in dlQuestionary.Items)
        {
            DataList dlCast = (DataList)dliQ.FindControl("dlCast");
            Label lblCastCate = (Label)dliQ.FindControl("lblCastCate");
            Label lblCastCode = (Label)dliQ.FindControl("lblCastCode");   //中分類代碼
            RadioButtonList rblCate = (RadioButtonList)dliQ.FindControl("rblCate");
            TextBox txtCate = (TextBox)dliQ.FindControl("txtCate");

            QuestionaryDS.qBaseSRow rbs;
            rows = oQuestionaryDS.qBaseS.Select("sQuestionaryCode = '" + Code + "' AND sCastCode = '" + lblCastCode.Text + "' AND sCate <> '1'");
            if (rows.Length > 0)
            {
                rbs = (QuestionaryDS.qBaseSRow)rows[0];
                if (rblCate.SelectedItem != null) rbs.iFraction = int.Parse(rblCate.SelectedItem.Value);
                rbs.sFraction = txtCate.Text;
            }

            //小分類
            foreach (DataListItem dilC in dlCast.Items)
            {
                Label lblThemeCode = (Label)dilC.FindControl("lblThemeCode");
                RadioButton r1, r2, r3, r4, r5;
                r1 = (RadioButton)dilC.FindControl("rbFraction1");
                r2 = (RadioButton)dilC.FindControl("rbFraction2");
                r3 = (RadioButton)dilC.FindControl("rbFraction3");
                r4 = (RadioButton)dilC.FindControl("rbFraction4");
                r5 = (RadioButton)dilC.FindControl("rbFraction5");

                rows = oQuestionaryDS.qBaseS.Select("sQuestionaryCode = '" + Code + "' AND sCastCode = '" + lblCastCode.Text + "' AND sThemeCode = '" + lblThemeCode.Text + "'");
                if (rows.Length > 0)
                {
                    rbs = (QuestionaryDS.qBaseSRow)rows[0];
                    if (r1.Checked || r2.Checked || r3.Checked || r4.Checked || r5.Checked)
                        rbs.iFraction = r1.Checked ? 1 : r2.Checked ? 2 : r3.Checked ? 3 : r4.Checked ? 4 : r5.Checked ? 5 : 0;
                } //enf if
            }
        }

        qBaseSTA.Update(oQuestionaryDS.qBaseS);

        //處理其它資料
        string iTotalFraction = oQuestionaryDS.qBaseS.Compute("Avg(iFraction)", "sQuestionaryCode = '" + Code + "' AND sCate = '1'").ToString();
        oQuestionaryDS.qBaseM.Rows[0]["dWriteDate"] = DateTime.Now;
        oQuestionaryDS.qBaseM.Rows[0]["iTotalFraction"] = (iTotalFraction.Length == 0) ? 0 : int.Parse(iTotalFraction);
        qBaseMTA.Update(oQuestionaryDS.qBaseM);

        rows = oQuestionaryDS.qBaseS.Select("sQuestionaryCode = '" + Code + "' AND sCate = '1'");
        foreach (QuestionaryDS.qBaseSRow rbs in rows)
        {
            //寫入到HR的資料表
        }

        lblMsg.Text = "填寫完成";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }
}