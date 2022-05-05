using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Text;

using CustomSecurity;

public partial class tsResult : System.Web.UI.Page
{
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private TsDSTableAdapters.tsBaseMTableAdapter tsBaseMTA = new TsDSTableAdapters.tsBaseMTableAdapter();
    private SysDSTableAdapters.BaseTtsTableAdapter BaseTtsTA = new SysDSTableAdapters.BaseTtsTableAdapter();

    private TsDS oTsDS;
    private SysDS oSysDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.ucResult.mpeCommandEvent += new CommandEventHandler(ucResult_mpeCommandEvent);
    }

    private void ucResult_mpeCommandEvent(object sender, CommandEventArgs e)
    {
        mpePopupQuestionsM.Show();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
        oTsDS = new TsDS();
        oSysDS = new SysDS();

        UserID = ((CustomIdentity)Context.User.Identity).Name;
    }

    protected void btnResult_Click(object sender, EventArgs e)
    {
        mpePopupQuestionsM.Show();
        SetBaseData();
    }

    protected void ddlDept_SelectedIndexChanged(object sender, EventArgs e)
    {
        mpePopupQuestionsM.Show();
        SetBaseData();
    }

    protected void btnExitQuestionsM_Click(object sender, EventArgs e)
    {
        mpePopupQuestionsM.Hide();
    }

    private void SetBaseData()
    {
        string sDept = ddlDept.SelectedItem.Value;

        lblQuestionsMID.Text = "";

        List<ListItem> llU = new List<ListItem>();
        List<ListItem> llD = new List<ListItem>();
        ListBox lbD = this.ucResult.GetListBox();

        foreach (ListItem li in lbD.Items)
            llD.Add(li);

        ListItem lii;

        int sNobrLen = -1;
        BaseTtsTA.FillByDeptCode(oSysDS.BaseTts, sDept);
        foreach (SysDS.BaseTtsRow rb in oSysDS.BaseTts.Rows)
        {
            if (sNobrLen == -1)
                sNobrLen = JBLib.Module.MyCS.GetCountStringLength(oSysDS.BaseTts, "sNobr", "", "");

            lii = new ListItem("[" + JBLib.Module.MyCS.GetFillString("", sNobrLen - Encoding.Default.GetBytes(rb.sNobr).Length) + rb.sNobr + "]" + rb.sNamec, rb.sNobr);

            if (!llD.Contains(lii))
                llU.Add(lii);
        }

        this.ucResult.SetListBox(llU, llD);
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        mpePopupQuestionsM.Show();

        string sQuestionsM_sCode = ddlQuestionsM.SelectedItem.Value;
        if (sQuestionsM_sCode == "0")
        {
            mp.Msg = "請選擇考卷";
            return;
        }

        tsBaseMTA.FillByCode(oTsDS.tsBaseM, sQuestionsM_sCode);
        BaseTtsTA.Fill(oSysDS.BaseTts);
        ListBox lb = this.ucResult.GetListBox();
        DateTime d = DateTime.Now;
        TsDS.tsBaseViewRow rbv;
        SysDS.BaseTtsRow rb;
        foreach (ListItem li in lb.Items)
        {
            rows = oTsDS.tsBaseM.Select("sNobr = '" + li.Value + "'", "dAmountDate DESC");

            rbv = oTsDS.tsBaseView.NewtsBaseViewRow();
            rbv.bAdd = cbPass.Checked || rows.Length == 0;
            rbv.bSend = cbPass.Checked || rows.Length == 0;
            rbv.bHave = (rows.Length > 0);
            rbv.sTitleCode = rows.Length > 0 ? Convert.ToString(rows[0]["tsTitle_sCode"]) : "";
            rbv.sNobr = li.Value;
            rbv.sName = li.Text;

            rows = oSysDS.BaseTts.Select("sNobr = '" + li.Value + "'");
            if (rows.Length > 0)
            {
                rb = rows[0] as SysDS.BaseTtsRow;
                rbv.sDeptName = rb.sDeptName;
            }

            oTsDS.tsBaseView.AddtsBaseViewRow(rbv);
        }

        mp.Msg = oTsDS.tsBaseView.Rows.Count > 0 ? "預覽資料" : "無資料";
        gv.DataSource = oTsDS.tsBaseView;
        gv.DataBind();
        plSave.Visible = oTsDS.tsBaseView.Rows.Count > 0;

        mpePopupQuestionsM.Hide();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        CheckBox cbSend, cbAdd;
        Label lblNobr;

        Hashtable htMail = JBLib.Module.MyCS.GetDefault("mail");
        Hashtable htSys = JBLib.Module.MyCS.GetDefault("sys");

        if (htMail.Count == 0 || htSys.Count == 0)
        {
            mp.Msg = "系統預設值不正確";
            return;
        }

        string sQuestionsM_sCode = ddlQuestionsM.SelectedItem.Value;
        tsBaseMTA.FillByCode(oTsDS.tsBaseM, sQuestionsM_sCode);
        BaseTtsTA.Fill(oSysDS.BaseTts);
        DateTime d = DateTime.Now;
        TsDS.tsBaseMRow rbm;
        SysDS.BaseTtsRow rb;

        string to;
        foreach (GridViewRow gvr in gv.Rows)
        {
            cbSend = gvr.FindControl("cbSend") as CheckBox;
            cbAdd = gvr.FindControl("cbAdd") as CheckBox;
            lblNobr = gvr.FindControl("lblNobr") as Label;

            if ((cbAdd != null) && cbAdd.Checked)
            {
                rows = oSysDS.BaseTts.Select("sNobr = '" + lblNobr.Text + "'");

                rbm = oTsDS.tsBaseM.NewtsBaseMRow();
                rbm.tsQuestionsM_sCode = sQuestionsM_sCode;
                rbm.sGuid = Guid.NewGuid().ToString();
                rbm.iMinute = 0;
                rbm.sNobr = lblNobr.Text;
                rbm.sName = "";
                rbm.sPW = Guid.NewGuid().ToString();
                rbm.dAmountDate = d;
                rbm.iFraction = 0;
                rbm.tsTitle_sCode = "";

                if (rows.Length > 0)
                {
                    rb = rows[0] as SysDS.BaseTtsRow;
                    rbm.sName = rb.sNamec;

                    to = Convert.ToString(htSys["mail"]);
                    //傳送通知
                    if (cbSend.Checked)
                    {
                        to = rb.sEmail.Length == 0 ? to : rb.sEmail;
                        JBLib.Module.MyCS.SendMail(Convert.ToString(htMail["host"]), Convert.ToString(htSys["mail"]), Convert.ToBoolean(htMail["auth"]), Convert.ToString(htMail["user"]), Convert.ToString(htMail["pass"]), to, "線上考試通知", "線上考試通知");
                    }
                }

                oTsDS.tsBaseM.AddtsBaseMRow(rbm);
            }

            cbSend.Enabled = false;
            cbAdd.Enabled = false;
        }

        tsBaseMTA.Update(oTsDS.tsBaseM);

        mp.Msg = "儲存完成";
        plSave.Visible = false;
    }
}