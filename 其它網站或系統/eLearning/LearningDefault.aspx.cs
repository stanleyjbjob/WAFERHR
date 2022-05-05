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

public partial class LearningDefault : System.Web.UI.Page
{
    private LnDSTableAdapters.lnCategoryTableAdapter lnCategoryTA = new LnDSTableAdapters.lnCategoryTableAdapter();
    private LnDSTableAdapters.lnCategoryLTableAdapter lnCategoryLTA = new LnDSTableAdapters.lnCategoryLTableAdapter();
    private LnDSTableAdapters.lnCategoryMTableAdapter lnCategoryMTA = new LnDSTableAdapters.lnCategoryMTableAdapter();
    private LnDSTableAdapters.lnCategorySTableAdapter lnCategorySTA = new LnDSTableAdapters.lnCategorySTableAdapter();
    private LnDSTableAdapters.lnViewTableAdapter lnViewTA = new LnDSTableAdapters.lnViewTableAdapter();

    private LnDSTableAdapters.lnUpFileTableAdapter lnUpFileTA = new LnDSTableAdapters.lnUpFileTableAdapter();
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private TsDSTableAdapters.tsBaseMTableAdapter tsBaseMTA = new TsDSTableAdapters.tsBaseMTableAdapter();

    private SysDSTableAdapters.hrEmpBaseTableAdapter hrEmpBaseTA = new SysDSTableAdapters.hrEmpBaseTableAdapter();

    private SysDS oSysDS;
    private LnDS oLnDS;
    private TsDS oTsDS;

    private DataRow[] rows, rowsL, rowsM, rowsS;

    private string UserID;

    private mpUser mp;

    private string Dept, Job;

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpUser)Master;
        mp.Msg = "";

        oSysDS = new SysDS();
        oLnDS = new LnDS();
        oTsDS = new TsDS();
        UserID = ((CustomIdentity)Context.User.Identity).Name;

        if (!this.IsPostBack)
        {
            SetNodeValues();
            plOverflow.Attributes.Add("style", "overflow-x: hidden; overflow-y: auto; height: 450px; padding: 0 17px 0 0");
        }

        rows = hrEmpBaseTA.GetDataByNobr(UserID).Select();
        if (rows.Length > 0)
        {
            SysDS.hrEmpBaseRow r = rows[0] as SysDS.hrEmpBaseRow;
            Dept = r.IssDeptmNull() ? "" : r.sDept.Trim();
            Job = r.IssJobNull() ? "" : r.sJob.Trim();
        }
    }

    protected void mu_MenuItemClick(object sender, MenuEventArgs e)
    {
        lblMenu.Text = e.Item.Value;
    }

    public void SetNodeValues()
    {
        mu.Items.Clear();

        lnCategoryTA.Fill(oLnDS.lnCategory);
        lnCategoryLTA.Fill(oLnDS.lnCategoryL);
        lnCategoryMTA.Fill(oLnDS.lnCategoryM);

        MenuItem miL, miM;
        rowsL = oLnDS.lnCategoryL.Select("", "iOrder");
        foreach (LnDS.lnCategoryLRow rl in rowsL)
        {
            if (UserID.IndexOf("o") == -1 || rl.sCode == "BM")
            {
                if (oLnDS.lnCategory.Select("sCodeL = '" + rl.sCode + "'").Length > 0)
                {
                    miL = new MenuItem();
                    miL.Text = "<font size='3'><b>" + rl.sName + "</b></font>";
                    miL.Value = rl.sCode;
                    miL.Selectable = false;
                    mu.Items.Add(miL);

                    rowsM = oLnDS.lnCategoryM.Select("lnCategoryL_sCode = '" + miL.Value + "'", "iOrder");
                    foreach (LnDS.lnCategoryMRow rm in rowsM)
                    {
                        if (oLnDS.lnCategory.Select("sCodeM = '" + rm.sCode + "'").Length > 0)
                        {
                            miM = new MenuItem();
                            miM.Text = rm.sName;
                            miM.Value = rm.sCode;
                            miL.ChildItems.Add(miM);
                        }
                    }
                }
            }
        }
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        Button btnCategory = e.Row.FindControl("btnCategory") as Button;
        if (btnCategory != null)
        {
            rows = lnCategorySTA.GetDataByKey(btnCategory.CommandArgument).Select();
            if (rows.Length > 0)
            {
                LnDS.lnCategorySRow r = rows[0] as LnDS.lnCategorySRow;
                string sDept, sJob;
                sDept = r.IssDeptNull() ? "" : r.sDept;
                sJob = r.IssJobNull() ? "" : r.sJob;
                e.Row.Visible = sDept.IndexOf("*") >= 0 || sJob.IndexOf("*") >= 0
                    || sDept.IndexOf("," + Dept + ",") >= 0
                    || sJob.IndexOf("," + Job + ",") >= 0;
            }
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string cn, ca;
        cn = e.CommandName;
        ca = e.CommandArgument.ToString();

        if (cn == "lnCategory")
        {
            lblKeyID.Text = ca;
            lblKeyID.ToolTip = DateTime.Now.ToString();
            mpePopup.X = 0;
            mpePopup.Show();
        }
    }

    public void SetViewCount()
    {
        LnDS.lnCategorySRow rc;
        LnDS.lnViewRow rv;
        bool isOK = true;
        lnViewTA.FillByKey(oLnDS.lnView, UserID, lblKeyID.Text);

        //超過多久時間再計算一次
        //if (oLnDS.lnView.Rows.Count > 0)
        //{
        //    rv = (LnDS.lnViewRow)oLnDS.lnView.Rows[0];
        //    isOK = rv.dDateTimeB.AddMinutes(2) < datetimeB;
        //}

        if (isOK)
        {
            DateTime datetimeB = Convert.ToDateTime(lblKeyID.ToolTip);
            DateTime datetimeE = DateTime.Now;

            TimeSpan ts = datetimeE - datetimeB;
            rv = oLnDS.lnView.NewlnViewRow();
            rv.sUserID = UserID;
            rv.lnCategoryS_sCode = lblKeyID.Text;
            rv.dDateTimeB = datetimeB;
            rv.dDateTimeE = datetimeE;
            rv.iTime = Convert.ToInt32(ts.TotalSeconds);
            oLnDS.lnView.AddlnViewRow(rv);

            lnViewTA.Update(oLnDS.lnView);

            //累加
            lnCategorySTA.FillByKey(oLnDS.lnCategoryS, lblKeyID.Text);
            if (oLnDS.lnCategoryS.Rows.Count > 0)
            {
                rc = (LnDS.lnCategorySRow)oLnDS.lnCategoryS.Rows[0];
                rc.iView++;

                lnCategorySTA.Update(oLnDS.lnCategoryS);
            }
        }
    }

    protected void gvUpload_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        Button btnDownload = (Button)e.Row.FindControl("btnDownload");
        Button btnPlay = (Button)e.Row.FindControl("btnPlay");

        if (btnDownload != null)
        {
            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnDownload);
            //ScriptManager.GetCurrent(this).RegisterPostBackControl(lbtnPlay);

            btnDownload.Visible = btnDownload.Text == "1";
            btnPlay.Visible = btnPlay.Text == "2";

            btnDownload.Text = "下載";
            btnPlay.Text = "播放";
        }
    }

    protected void gvUpload_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        mpePopup.Show();
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Download" || cn == "Play")
        {
            LnDS.lnUpFileRow r = (LnDS.lnUpFileRow)lnUpFileTA.GetData().Select("iAutoKey = " + int.Parse(ca))[0];

            string FN = Server.MapPath("./Upload/" + r.sServerName);
            FileInfo fi = new FileInfo(FN);

            if (cn == "Download")
            {
                if (fi.Exists)
                {
                    Response.ClearHeaders();
                    Response.Clear();
                    Response.AddHeader("Accept-Language", "zh-tw");
                    Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(r.sUpName, System.Text.Encoding.UTF8));
                    Response.AddHeader("Content-Length", fi.Length.ToString());
                    Response.ContentType = "application/octet-stream";
                    Response.WriteFile(fi.FullName);
                    Response.Flush();
                    Response.End();
                }
                else
                {
                    lblMsg.Text = "系統找不到檔案";
                }
            }
            else if (cn == "Play")
            {

                mpc.MovieURL = "Upload/" + r.sServerName;
                mpePopupMovie.X = 620;
                mpePopupMovie.Show();
                btnExit.Enabled = false;
            }

            gvUpload.DataBind();
        }
    }

    protected void dlTest_ItemCommand(object source, DataListCommandEventArgs e)
    {
        mpePopup.Show();
        string cn, ca;
        cn = e.CommandName;
        ca = e.CommandArgument.ToString();

        if (cn == "Sign")
        {
            mp.Msg = "您已經報名過囉";

            tsBaseMTA.FillByNobr(oTsDS.tsBaseM, UserID);
            rows = oTsDS.tsBaseM.Select("tsQuestionsM_sCode = '" + ca + "'");

            if (rows.Length == 0)
            {
                DateTime d = DateTime.Now;
                TsDS.tsBaseMRow rbm = oTsDS.tsBaseM.NewtsBaseMRow();
                rbm.tsQuestionsM_sCode = ca;
                rbm.sGuid = Guid.NewGuid().ToString();
                rbm.iMinute = 0;
                rbm.sNobr = UserID;
                rbm.sPW = Guid.NewGuid().ToString();
                rbm.sName = "";
                rbm.dAmountDate = d;
                rbm.iFraction = 0;
                rbm.tsTitle_sCode = "";
                oTsDS.tsBaseM.AddtsBaseMRow(rbm);
                tsBaseMTA.Update(oTsDS.tsBaseM);

                mp.Msg = "報名成功";
            }
            gvUpload.DataBind();
        }
    }

    protected void btnExit_Click(object sender, EventArgs e)
    {
        mpePopup.Hide();
        SetViewCount();
        gv.DataBind();
    }
    protected void btnExitMovie_Click(object sender, EventArgs e)
    {
        btnExit.Enabled = true;
        mpePopup.Show();
        mpePopupMovie.Hide();
        gvUpload.DataBind();
    }

}