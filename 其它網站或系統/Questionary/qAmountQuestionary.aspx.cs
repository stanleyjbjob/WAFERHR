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

public partial class qAmountQuestionary : System.Web.UI.Page
{
    //Questionary
    public QuestionaryDSTableAdapters.qBaseMTableAdapter qBaseMTA = new QuestionaryDSTableAdapters.qBaseMTableAdapter();
    public QuestionaryDSTableAdapters.qBaseSTableAdapter qBaseSTA = new QuestionaryDSTableAdapters.qBaseSTableAdapter();
    public QuestionaryDSTableAdapters.qTypeTableAdapter qTypeTA = new QuestionaryDSTableAdapters.qTypeTableAdapter();
    public QuestionaryDSTableAdapters.qQuestionaryTableAdapter qQuestionaryTA = new QuestionaryDSTableAdapters.qQuestionaryTableAdapter();

    //Hr
    public QuestionaryDSTableAdapters.TrattRelBaseTableAdapter TrattRelBaseTA = new QuestionaryDSTableAdapters.TrattRelBaseTableAdapter();
    public QuestionaryDSTableAdapters.TRASKDTTableAdapter TRASKDTTA = new QuestionaryDSTableAdapters.TRASKDTTableAdapter();


    public QuestionaryDS oQuestionaryDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oQuestionaryDS = new QuestionaryDS();

        Session["IWantASessionCookie"] = true;

        if (!IsPostBack)
        {
            ScriptManager.RegisterClientScriptBlock(upl, typeof(string), "DateFormatScript", jbmodule.Web.ui.DateFormatScript(), true);
            txtDateB.Attributes.Add("onkeyup", "date_format('" + txtDateB.ClientID + "')");
            txtDateE.Attributes.Add("onkeyup", "date_format('" + txtDateE.ClientID + "')");

            txtDateB.Text = DateTime.Now.AddYears(-1911).ToShortDateString();
            txtDateE.Text = DateTime.Now.AddYears(-1911).AddMonths(1).ToShortDateString();
        }
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        Session.Clear();

        string yymm, ser, coscode, cosname, QuestionaryCode, QuestionaryName;
        yymm = ddlYYMM.SelectedItem.Value;
        ser = ddlSer.SelectedItem.Value;
        coscode = ddlCosCode.SelectedItem.Value;
        cosname = ddlCosCode.SelectedItem.Text;
        QuestionaryCode = ddlQuestionaryCode.SelectedItem.Value;
        QuestionaryName = ddlQuestionaryCode.SelectedItem.Text;

        DateTime dateB, dateE;
        dateB = DateTime.Now;
        dateE = dateB;
        try
        {
            dateB = Convert.ToDateTime(txtDateB.Text).AddYears(1911);
            dateE = Convert.ToDateTime(txtDateE.Text).AddYears(1911);
        }
        catch
        {
            lblMsg.Text = "日期格式錯誤";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        TrattRelBaseTA.FillByCosCode(oQuestionaryDS.TrattRelBase, yymm, ser, coscode);

        if (oQuestionaryDS.TrattRelBase.Rows.Count > 0)
        {
            qTypeTA.Fill(oQuestionaryDS.qType);
            qBaseMTA.Fill(oQuestionaryDS.qBaseM);
            qBaseSTA.Fill(oQuestionaryDS.qBaseS);

            QuestionaryDS.qTypeRow rt;
            rows = oQuestionaryDS.qType.Select("sCode = '" + QuestionaryCode + yymm + ser + coscode + "'");
            if (rows.Length == 0)
            {
                rt = oQuestionaryDS.qType.NewqTypeRow();
            }
            else
            {
                rt = (QuestionaryDS.qTypeRow)rows[0];
            }

            rt.sCode = QuestionaryCode + yymm + ser + coscode;
            rt.sName = QuestionaryName + "-" + cosname;
            rt.sQuestionaryCode = QuestionaryCode;
            rt.sQuestionaryName = QuestionaryName;
            rt.dDateB = dateB;
            rt.dDateE = dateE;
            rt.iTotalFraction = 0;
            rt.sKeyMan = sa.UserInfo.GetClientIP();
            rt.dKeyDate = DateTime.Now;

            rows = oQuestionaryDS.qType.Select("sCode = '" + QuestionaryCode + yymm + ser + coscode + "'");
            if (rows.Length == 0)
            {
                oQuestionaryDS.qType.AddqTypeRow(rt);
            }

            int a = 0;
            foreach (QuestionaryDS.TrattRelBaseRow rtb in oQuestionaryDS.TrattRelBase.Rows)
            {
                rows = oQuestionaryDS.qBaseM.Select("sCode = '" + rt.sCode + rtb.IDNO.Trim() + "'");
                if (rows.Length > 0)
                    continue;

                QuestionaryDS.qBaseMRow rbm = oQuestionaryDS.qBaseM.NewqBaseMRow();
                rbm.sCode = rt.sCode + rtb.IDNO.Trim();
                rbm.sTypeCode = rt.sCode;
                rbm.sNobr = rtb.IDNO.Trim();
                //rbm.sPW = rtb.IsPASSWORDNull() ? "0000" : (rtb.PASSWORD.Trim().Length == 0) ? "0000" : rtb.PASSWORD.Trim();
                rbm.sPW = DateTime.Now.Ticks.ToString() + a.ToString();
                rbm.sName = rtb.NAME_C.Trim();
                rbm.sDeptCode = rtb.D_NO.Trim();
                rbm.sDeptName = rtb.D_NAME.Trim();
                rbm.dAmountDate = DateTime.Now;
                rbm.dSchoolDateB = Convert.ToDateTime(rtb.COSDATEB.ToShortDateString() + " " + rtb.COSTIMEB.Trim() + ":00");
                rbm.dSchoolDateE = Convert.ToDateTime(rtb.COSDATEE.ToShortDateString() + " " + rtb.COSTIMEE.Trim() + ":00");
                rbm.sDocentCode = rtb.IsTCR_NONull() ? "" : rtb.TCR_NO.Trim();
                rbm.sDocentName = rtb.IsTCR_NAMENull() ? "" : rtb.TCR_NAME.Trim();
                rbm.sYYMM = yymm;
                rbm.sSer = ser;
                rbm.sCourseCode = coscode;
                rbm.sCourseName = cosname;
                rbm.iTotalFraction = 0;
                oQuestionaryDS.qBaseM.AddqBaseMRow(rbm);

                a++;
            }

            lblMsg.Text = "預覽名單產生完成，共產生" + a.ToString() + "筆";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);

            mv.ActiveViewIndex = 1;
            DataView dv = new DataView(oQuestionaryDS.qBaseM);
            dv.RowFilter = "sTypeCode = '" + rt.sCode + "'";
            gv.DataSource = dv;
            gv.DataBind();

            dv = new DataView(oQuestionaryDS.qType);
            dv.RowFilter = "sCode = '" + rt.sCode + "'";
            fv.DataSource = dv;
            fv.DataBind();

            qQuestionaryTA.FillByTRQCODE(oQuestionaryDS.qQuestionary, QuestionaryCode);

            Session["oQuestionaryDS"] = oQuestionaryDS;
            Session["sTypeCode"] = rt.sCode;
        }
        else
        {
            lblMsg.Text = "目前此課程並沒有受訓名單";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }

        btnSubmit.Visible = true;
        btnCancel.Visible = true;
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        if (Session["oQuestionaryDS"] == null)
        {
            lblMsg.Text = "因為時間閒置過久，導致記憶體暫存的資料不見了，請重新產生預覽名單";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            mv.ActiveViewIndex = 0;
            return;
        }

        oQuestionaryDS = (QuestionaryDS)Session["oQuestionaryDS"];

        rows = oQuestionaryDS.qBaseM.Select("sTypeCode = '" + Session["sTypeCode"].ToString() + "'");
        foreach (QuestionaryDS.qBaseMRow rbm in oQuestionaryDS.qBaseM.Rows)
        {
            rows = oQuestionaryDS.qBaseS.Select("sBaseCode = '" + rbm.sCode + "'");
            if (rows.Length > 0)
                continue;

            foreach (QuestionaryDS.qQuestionaryRow rq in oQuestionaryDS.qQuestionary.Rows)
            {
                QuestionaryDS.qBaseSRow rbs = oQuestionaryDS.qBaseS.NewqBaseSRow();
                rbs.sBaseCode = rbm.sCode;
                rbs.sQuestionaryCode = rq.IsTRQCODENull() ? "" : rq.TRQCODE.Trim();
                rbs.sCastCode = rq.IsVALCODENull() ? "" : rq.VALCODE.Trim();
                rbs.sCate = rq.IsCATENull() ? "1" : rq.CATE.Trim();
                if (rbs.sCate == "1" && !rq.IsASKCODENull()) rbs.sThemeCode = rq.ASKCODE.Trim();
                oQuestionaryDS.qBaseS.AddqBaseSRow(rbs);
            }
        }

        qTypeTA.Update(oQuestionaryDS.qType);
        qBaseMTA.Update(oQuestionaryDS.qBaseM);
        qBaseSTA.Update(oQuestionaryDS.qBaseS);

        lblMsg.Text = "存入完成";
        btnSubmit.Visible = false;
        btnCancel.Visible = false;
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        Session.Clear();
        mv.ActiveViewIndex = 0;
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);
    }
}