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

public partial class tsQuestionsM : System.Web.UI.Page
{
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private TsDSTableAdapters.tsQuestionsSTableAdapter tsQuestionsSTA = new TsDSTableAdapters.tsQuestionsSTableAdapter();
    private TsDSTableAdapters.tsCategoryTableAdapter tsCategoryTA = new TsDSTableAdapters.tsCategoryTableAdapter();
    private TsDSTableAdapters.tsEaxminationTableAdapter tsEaxminationTA = new TsDSTableAdapters.tsEaxminationTableAdapter();
    private LnDSTableAdapters.lnCategorySTableAdapter lnCategorySTA = new LnDSTableAdapters.lnCategorySTableAdapter();
    private LnDSTableAdapters.lnTestTableAdapter lnTestTA = new LnDSTableAdapters.lnTestTableAdapter();
    private SysDSTableAdapters.sysRoleTableAdapter sysRoleTA = new SysDSTableAdapters.sysRoleTableAdapter();

    private TsDS oTsDS;
    private LnDS oLnDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
        oTsDS = new TsDS();
        oLnDS = new LnDS();

        UserID = ((CustomIdentity)Context.User.Identity).Name;
    }

    protected void btnExitFV_Click(object sender, EventArgs e)
    {
        fv.ChangeMode(FormViewMode.Insert);
        mpePopupFV.Hide();
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        mpePopupFV.Show();

        if (tsQuestionsMTA.GetDataByKey(e.Values["sCode"].ToString()).Rows.Count > 0)
        {
            mp.Msg = "代碼重複";
            e.Cancel = true;
        }

        int iMax = 0, iMinute = 0, iRepeat = 0;
        try
        {
            iMax = Convert.ToInt32(e.Values["iMax"]);
            iMinute = Convert.ToInt32(e.Values["iMinute"]);
            iRepeat = Convert.ToInt32(e.Values["iRepeat"]);
        }
        catch
        {
            e.Values["iMax"] = iMax;
            e.Values["iMinute"] = iMinute;
            e.Values["iRepeat"] = iRepeat;
        }

        e.Values["dDateA"] = new DateTime(1900, 1, 1);
        e.Values["dDateD"] = new DateTime(9999, 12, 31);
        e.Values["sysRole_iKey"] = Convert.ToInt32(sysRoleTA.GetData().Compute("Sum(iKey)", "").ToString());
        e.Values["sKeyMan"] = UserID;
        e.Values["dKeyDate"] = DateTime.Now;
    }

    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
        mp.Msg = "新增完成";
        mpePopupFV.Hide();
    }

    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        mpePopupFV.Show();

        int iMax = 0, iMinute = 0, iRepeat = 0;
        try
        {
            iMax = Convert.ToInt32(e.NewValues["iMax"]);
            iMinute = Convert.ToInt32(e.NewValues["iMinute"]);
            iRepeat = Convert.ToInt32(e.NewValues["iRepeat"]);
        }
        catch
        {
            e.NewValues["iMax"] = iMax;
            e.NewValues["iMinute"] = iMinute;
            e.NewValues["iRepeat"] = iRepeat;
        }

        e.NewValues["sKeyMan"] = UserID;
        e.NewValues["dKeyDate"] = DateTime.Now;
    }

    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
        mp.Msg = "修改完成";
        gv.SelectedIndex = -1;
        mpePopupFV.Hide();
    }

    protected void gv_SelectedIndexChanged(object sender, EventArgs e)
    {
        fv.ChangeMode(FormViewMode.Edit);
        mpePopupFV.Show();
    }

    protected void gv_PageIndexChanged(object sender, EventArgs e)
    {
        gv.SelectedIndex = -1;
        fv.ChangeMode(FormViewMode.Insert);
        fv.DataBind();
    }

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);

        Button btnExport = e.Row.FindControl("btnExport") as Button;
        if (btnExport != null)
            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnExport);
    }

    protected void gv_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        tsQuestionsSTA.DeleteQueryQuestionsM_sCode(e.Keys["sCode"].ToString()); //刪除樣版題庫
        lnTestTA.DeleteQueryQuestionsM_sCode(e.Keys["sCode"].ToString());   //刪除關聯考卷
        mp.Msg = "刪除完成";
        gv.SelectedIndex = -1;
        fv.ChangeMode(FormViewMode.Insert);
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string cn, ca;
        cn = e.CommandName;
        ca = e.CommandArgument.ToString();

        if (cn == "Add")
        {
            mpePopupFV.Show();
        }
        else if (cn == "tsQuestionsS")
        {
            txtSearch.Text = "";
            lblQuestionsSID.Text = ca;
            mpePopupQuestionsS.Show();

            //先倒入下面的資料
            ListItem li;
            lbD.Items.Clear();
            lbD1.Items.Clear();
            tsQuestionsSTA.FillByQuestionsMCode(oTsDS.tsQuestionsS, ca);
            foreach (TsDS.tsQuestionsSRow r in oTsDS.tsQuestionsS.Rows)
            {
                li = new ListItem();
                li.Value = r.tsEaxmination_iAutoKey.ToString();
                li.Text = r.iFraction.ToString();
                lbD.Items.Add(li);

                li = new ListItem();
                li.Value = r.tsEaxmination_iAutoKey.ToString();
                li.Text = r.iFraction.ToString();
                lbD1.Items.Add(li);
            }

            lbD.DataBind();
            lbU.DataBind();
        }
        else if (cn == "sHeader" || cn == "sNotice" || cn == "sFooter")    //編輯頁首、內容、頁尾
        {
            lblDragNameEdit.Text = "編輯" + ((cn == "sHeader") ? "頁首" : (cn == "sNotice") ? "內容" : "頁尾");
            lblEditID.Text = ca;
            btnSaveEdit.ToolTip = cn;
            mpePopupEdit.Show();

            rows =tsQuestionsMTA.GetDataByKey(lblEditID.Text).Select();
            if (rows.Length > 0)
            {
                TsDS.tsQuestionsMRow rqm = rows[0] as TsDS.tsQuestionsMRow;
                fckContent.Value = rqm[cn] != null ? rqm[cn].ToString() : "";
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

    protected void btnDU_Command(object sender, CommandEventArgs e)
    {
        mpePopupQuestionsS.Show();

        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();
        bool isAll = ca == "1";

        ListBox lb = new ListBox();
        ListItem lii;

        int i = 0, j = 0;
        DataTable dt = new DataTable();
        dt.Columns.Add("t", typeof(string)).DefaultValue = "";
        dt.Columns.Add("v", typeof(string)).DefaultValue = "";
        dt.Columns.Add("s", typeof(int)).DefaultValue = i;
        DataRow r;

        if (cn == "D")  //向下移動(加入考題)
        {
            foreach (ListItem li in lbU.Items)
            {
                if ((isAll || li.Selected))
                {
                    lbD.Items.Add(li);

                    lii = new ListItem();
                    lii.Value = li.Value;
                    lii.Text = txtFraction.Text.Trim().Length > 0 ? txtFraction.Text : "0";
                    lbD1.Items.Add(lii);
                }
            }
        }
        else if (cn == "U") //向上移動(移除考題)
        {
            foreach (ListItem li in lbD.Items)
                if ((isAll || li.Selected))
                    lb.Items.Add(li);

            foreach (ListItem li in lb.Items)
            {
                if (lbD.Items.Contains(li))
                    lbD.Items.Remove(li);

                if (lbD1.Items.FindByValue(li.Value) != null)
                    lbD1.Items.Remove(lbD1.Items.FindByValue(li.Value));
            }
        }
        else if (cn == "D1" || cn == "U1")    //考題順序移動
        {
            foreach (ListItem li in lbD.Items)
            {
                if (li.Selected)
                {
                    lii = lbD1.Items.FindByValue(li.Value);
                    if (lii != null)
                    {
                        r = dt.NewRow();
                        r["t"] = lii.Text;
                        r["v"] = lii.Value;
                        //向上移及向下移決定關鍵
                        r["s"] = (cn == "D1") ? (isAll ? i + lbD.Items.Count : i + 1) : (isAll ? i - lbD.Items.Count : i - 1);
                        dt.Rows.Add(r);
                    }
                }

                i++;
            }

            i = 0;
            foreach (ListItem li in lbD.Items)
            {
                if (!li.Selected)
                {
                    lii = lbD1.Items.FindByValue(li.Value);
                    if (lii != null)
                    {
                        while (dt.Select("s = " + i).Length > 0)
                            i++;

                        r = dt.NewRow();
                        r["t"] = lii.Text;
                        r["v"] = lii.Value;
                        r["s"] = i;
                        dt.Rows.Add(r);
                    }
                }
            }

            lbD.Items.Clear();
            lbD1.Items.Clear();
            rows = dt.Select("", "s");
            foreach (DataRow rr in rows)
            {
                lii = new ListItem();
                lii.Text = rr["t"].ToString();
                lii.Value = rr["v"].ToString();
                lbD.Items.Add(lii);

                lii = new ListItem();
                lii.Text = rr["t"].ToString();
                lii.Value = rr["v"].ToString();
                lbD1.Items.Add(lii);
            }
        }

        lbU.DataBind();
        lbD.DataBind();
    }

    protected void btnExitQuestionsS_Click(object sender, EventArgs e)
    {
        mpePopupQuestionsS.Hide();
    }

    protected void ddlCategoryS_SelectedIndexChanged(object sender, EventArgs e)
    {
        mpePopupQuestionsS.Show();
        lbU.DataBind();
    }

    protected void ddlCategory_SelectedIndexChanged(object sender, EventArgs e)
    {
        mpePopupQuestionsS.Show();
        lbU.DataBind();
    }

    protected void lbU_DataBound(object sender, EventArgs e)
    {
        foreach (ListItem li in lbD.Items)
            lbU.Items.Remove(lbU.Items.FindByValue(li.Value));

        lblNum.Text = lbD.Items.Count.ToString();

        int iCategoryNameLen = -1, iCategoryS = -1;
        string sCategoryName, sCategoryS, sContent;    //題型、小分類

        tsEaxminationTA.Fill(oTsDS.tsEaxmination);
        tsCategoryTA.Fill(oTsDS.tsCategory);
        lnCategorySTA.Fill(oLnDS.lnCategoryS);
        foreach (ListItem li in lbU.Items)
        {
            if (iCategoryNameLen == -1) //題型
                iCategoryNameLen = JBLib.Module.MyCS.GetCountStringLength(oTsDS.tsCategory, "sName", "", "");

            if (iCategoryS == -1)   //分類
                iCategoryS = JBLib.Module.MyCS.GetCountStringLength(oLnDS.lnCategoryS, "sName", "", "");

            sContent = "";  //題目
            sCategoryName = JBLib.Module.MyCS.GetFillString("", iCategoryNameLen - Encoding.Default.GetBytes("").Length);
            sCategoryS = JBLib.Module.MyCS.GetFillString("", iCategoryS - Encoding.Default.GetBytes("").Length);
            rows = oTsDS.tsEaxmination.Select("iAutoKey = " + Convert.ToInt32(li.Value));
            if (rows.Length > 0)
            {
                TsDS.tsEaxminationRow rt = rows[0] as TsDS.tsEaxminationRow;
                sContent =(rt.sContent);

                rows = oTsDS.tsCategory.Select("sCode = '" + rt.tsCategory_sCode + "'");
                if (rows.Length > 0)
                {
                    TsDS.tsCategoryRow rc = rows[0] as TsDS.tsCategoryRow;
                    sCategoryName = JBLib.Module.MyCS.GetFillString("", iCategoryNameLen - Encoding.Default.GetBytes(rc.sName).Length) + rc.sName;
                }

                rows = oLnDS.lnCategoryS.Select("sCode = '" + rt.lnCategoryS_sCode + "'");
                if (rows.Length > 0)
                {
                    LnDS.lnCategorySRow rs = rows[0] as LnDS.lnCategorySRow;
                    sCategoryS = JBLib.Module.MyCS.GetFillString("", iCategoryS - Encoding.Default.GetBytes(rs.sName).Length) + rs.sName;
                }
            }

            li.Text = "[" + sCategoryName + "][" + sCategoryS + "]" +  sContent;
            li.Attributes.Add("title", sContent);

            if (txtSearch.Text.Trim().Length > 0)
                li.Enabled = li.Text.ToUpper().IndexOf(txtSearch.Text.ToUpper()) >= 0;
        }
    }

    protected void lbD_DataBound(object sender, EventArgs e)
    {
        int iOrderLen = -1, iCategoryNameLen = -1, iFractionLen = -1;
        string sOrder, sCategoryName, sFraction, sContent;

        int i = 0 ,j = 0;
        tsQuestionsSTA.FillByQuestionsMCode(oTsDS.tsQuestionsS, lblQuestionsSID.Text);
        tsEaxminationTA.Fill(oTsDS.tsEaxmination);
        tsCategoryTA.Fill(oTsDS.tsCategory);
        foreach (ListItem li in lbD.Items)
        {
            i++;

            if (iOrderLen == -1)    //順序
                iOrderLen = oTsDS.tsQuestionsS.Rows.Count.ToString().Length + 1;

            if (iCategoryNameLen == -1) //題型
                iCategoryNameLen = JBLib.Module.MyCS.GetCountStringLength(oTsDS.tsCategory, "sName", "", "");

            if (iFractionLen == -1) //分數
                iFractionLen = JBLib.Module.MyCS.GetCountStringLength(oTsDS.tsQuestionsS, "iFraction", "", "");

            sContent = "";  //題目
            sCategoryName = JBLib.Module.MyCS.GetFillString("", iCategoryNameLen - Encoding.Default.GetBytes("").Length);
            rows = oTsDS.tsEaxmination.Select("iAutoKey = " + Convert.ToInt32(li.Value));
            if (rows.Length > 0)
            {
                TsDS.tsEaxminationRow rt = rows[0] as TsDS.tsEaxminationRow;
                sContent = (rt.sContent);

                rows = oTsDS.tsCategory.Select("sCode = '" + rt.tsCategory_sCode + "'");
                if (rows.Length > 0)
                {
                    TsDS.tsCategoryRow rc = rows[0] as TsDS.tsCategoryRow;
                    sCategoryName = JBLib.Module.MyCS.GetFillString("", iCategoryNameLen - Encoding.Default.GetBytes(rc.sName).Length) + rc.sName;
                }
            }

            sOrder = JBLib.Module.MyCS.GetFillString("", iOrderLen - Encoding.Default.GetBytes(i.ToString()).Length) + i.ToString();

            sFraction = JBLib.Module.MyCS.GetFillString("", iFractionLen - Encoding.Default.GetBytes("").Length);
            if (lbD1.Items.FindByValue(li.Value) != null)
                sFraction = JBLib.Module.MyCS.GetFillString("", iFractionLen - Encoding.Default.GetBytes(lbD1.Items.FindByValue(li.Value).Text).Length) + lbD1.Items.FindByValue(li.Value).Text;

            j += Convert.ToInt32(sFraction);

            li.Text = "[" + sOrder + "][" + sCategoryName + "][" + sFraction + "]" + sContent;
            li.Attributes.Add("title", sContent);
        }

        lblSum.Text = j.ToString();
        lblNum.Text = i.ToString();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        mpePopupQuestionsS.Show();

        tsQuestionsSTA.FillByQuestionsMCode(oTsDS.tsQuestionsS, lblQuestionsSID.Text);
        foreach (TsDS.tsQuestionsSRow r in oTsDS.tsQuestionsS.Rows)
            r.Delete();

        int i = 0;
        foreach (ListItem li in lbD1.Items)
        {
            if (oTsDS.tsQuestionsS.Select("tsQuestionsM_sCode = '" + lblQuestionsSID.Text + "' AND tsEaxmination_iAutoKey = " + Convert.ToInt32(li.Value)).Length == 0)
            {
                i++;
                TsDS.tsQuestionsSRow r = oTsDS.tsQuestionsS.NewtsQuestionsSRow();
                r.tsQuestionsM_sCode = lblQuestionsSID.Text;
                r.tsEaxmination_iAutoKey = Convert.ToInt32(li.Value);
                r.iOrder = i;
                r.iFraction = Convert.ToInt32(li.Text);
                r.sKeyMan = UserID;
                r.dKeyDate = DateTime.Now;
                oTsDS.tsQuestionsS.AddtsQuestionsSRow(r);
            }
        }

        tsQuestionsSTA.Update(oTsDS.tsQuestionsS);
        mp.Msg = "儲存完成";
    }

    protected void btnSaveEdit_Click(object sender, EventArgs e)
    {
        mpePopupEdit.Show();

        rows = tsQuestionsMTA.GetDataByKey(lblEditID.Text).Select();
        if (rows.Length > 0)
        {
            TsDS.tsQuestionsMRow rqm = rows[0] as TsDS.tsQuestionsMRow;
            rqm[btnSaveEdit.ToolTip] = fckContent.Value;
            tsQuestionsMTA.Update(rqm);
            mp.Msg = "內容儲存完成";
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        mpePopupQuestionsS.Show();
        lbU.DataBind();
    }
}