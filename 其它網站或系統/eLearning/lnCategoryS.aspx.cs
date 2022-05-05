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
using System.IO;

using CustomSecurity;

public partial class lnCategoryS : System.Web.UI.Page
{
    private SysDSTableAdapters.sysRoleTableAdapter sysRoleTA = new SysDSTableAdapters.sysRoleTableAdapter();
    private LnDSTableAdapters.lnCategorySTableAdapter lnCategorySTA = new LnDSTableAdapters.lnCategorySTableAdapter();
    private LnDSTableAdapters.lnTestTableAdapter lnTestTA = new LnDSTableAdapters.lnTestTableAdapter();
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private LnDSTableAdapters.lnUpFileTableAdapter lnUpFileTA = new LnDSTableAdapters.lnUpFileTableAdapter();

    private LnDS oLnDS;
    private TsDS oTsDS;
    private SysDS oSysDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.ucAuthRole.mpeCommandEvent += new CommandEventHandler(ucAuthRole_mpeCommandEvent);
        this.ucTest.mpeCommandEvent += new CommandEventHandler(ucTest_mpeCommandEvent);
    }

    private void ucAuthRole_mpeCommandEvent(object sender, CommandEventArgs e)
    {
        mpePopupRole.Show();
    }

    private void ucTest_mpeCommandEvent(object sender, CommandEventArgs e)
    {
        //mpePopupEdit.Show();
        mpePopupTest.Show();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
        lblMsgFile.Text = "";
        oLnDS = new LnDS();
        oTsDS = new TsDS();
        oSysDS = new SysDS();

        UserID = ((CustomIdentity)Context.User.Identity).Name;

        ScriptManager.GetCurrent(this).RegisterPostBackControl(btnViewExport);
    }

    protected void btnExitFV_Click(object sender, EventArgs e)
    {
        fv.ChangeMode(FormViewMode.Insert);
        mpePopupFV.Hide();
    }

    protected void fv_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        mpePopupFV.Show();

        try
        {
            e.Values["iOrder"] = Convert.ToInt32(e.Values["iOrder"]);
        }
        catch
        {
            int i = 1;
            while (lnCategorySTA.GetData().Select("lnCategoryM_sCode = '" + e.Values["lnCategoryM_sCode"].ToString() + "' AND iOrder = " + i).Length > 0)
                i++;

            e.Values["iOrder"] = i;
        }

        if (lnCategorySTA.GetDataByKey(e.Values["sCode"].ToString().Trim()).Rows.Count > 0)
        {
            mp.Msg = "代碼重複";
            e.Cancel = true;
        }

        e.Values["sysRole_iKey"] = Convert.ToInt32(sysRoleTA.GetData().Compute("Sum(iKey)", "").ToString());
        e.Values["iEdition"] = 0;
        e.Values["iView"] = 0;
        e.Values["dDateA"] = new DateTime(1900, 1, 1);
        e.Values["dDateD"] = new DateTime(9999, 12, 31);
        e.Values["sKeyMan"] = UserID;
        e.Values["dKeyDate"] = DateTime.Now;
        e.Values["sDept"] = "*";
        e.Values["sJob"] = "*";
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

        try
        {
            e.NewValues["iOrder"] = Convert.ToInt32(e.NewValues["iOrder"]);
        }
        catch
        {
            int i = 1;
            while (lnCategorySTA.GetData().Select("lnCategoryM_sCode = '" + e.NewValues["lnCategoryM_sCode"].ToString() + "' AND iOrder = " + i).Length > 0)
                i++;

            e.NewValues["iOrder"] = i;
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

        Label lblCat = (Label)e.Row.FindControl("lblCat");
        if (lblCat != null)
            lblCat.Text = lblCat.Text == "1" ? "下載" : "播放";

        Button btnDownload = (Button)e.Row.FindControl("btnDownload");
        if (btnDownload != null)
            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnDownload);

        Button btnExport = e.Row.FindControl("btnExport") as Button;
        if (btnExport != null)
            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnExport);
    }

    protected void gv_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
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
        else if (cn == "lnCategorySRole")
        {
            mpePopupRole.Show();
            lblRoleID.Text = ca;

            List<ListItem> llU = new List<ListItem>();
            List<ListItem> llD = new List<ListItem>();

            int iKeyLen = -1;
            sysRoleTA.Fill(oSysDS.sysRole);
            foreach (SysDS.sysRoleRow r in oSysDS.sysRole.Rows)
            {
                if (iKeyLen == -1)
                    iKeyLen = JBLib.Module.MyCS.GetCountStringLength(oSysDS.sysRole, "iKey", "", "iKey DESC");

                llU.Add(new ListItem("[" + JBLib.Module.MyCS.GetFillString("", iKeyLen - Encoding.Default.GetBytes(r.iKey.ToString()).Length) + r.iKey.ToString() + "]" + r.sName, r.iKey.ToString()));
            }

            lnCategorySTA.Fill(oLnDS.lnCategoryS);
            rows = oLnDS.lnCategoryS.Select("sCode = '" + lblRoleID.Text + "'");
            if (rows.Length > 0)
            {
                LnDS.lnCategorySRow r = rows[0] as LnDS.lnCategorySRow;
                foreach (ListItem li in llU)
                    if ((r.sysRole_iKey != 0) && JBLib.Module.MyCS.GetAuth(r.sysRole_iKey, li.Value))
                        llD.Add(li);

                //把從上邊移到下邊的刪除(上邊)
                foreach (ListItem li in llD)
                    if (llU.Contains(li))
                        llU.Remove(li);

                this.ucAuthRole.SetListBox(llU, llD);
            }
        }
        else if (cn == "lnAuth")
        {
            mpePopupAuth.Show();
            lblAuthID.Text = ca;

            rows = lnCategorySTA.GetDataByKey(lblAuthID.Text).Select();
            if (rows.Length > 0)
            {
                LnDS.lnCategorySRow r = rows[0] as LnDS.lnCategorySRow;
                txtDept.Text = r.IssDeptNull() ? "" : r.sDept;
                txtJob.Text = r.IssJobNull() ? "" : r.sJob;
            }
        }
        else if (cn == "lnCategorySEdit")
        {
            mpePopupEdit.Show();
            lblEditID.Text = ca;

            rows = lnCategorySTA.GetDataByKey(lblEditID.Text).Select();
            if (rows.Length > 0)
            {
                LnDS.lnCategorySRow rcs = (LnDS.lnCategorySRow)rows[0];
                fckContent.Value = rcs.IssContentNull() ? "" : rcs.sContent;
            }
        }
        else if (cn == "Test")
        {
            mpePopupTest.Show();
            lblEditID.Text = ca;
            List<ListItem> llU = new List<ListItem>();
            List<ListItem> llD = new List<ListItem>();
            ListItem li;

            int sCodeLen = -1;
            tsQuestionsMTA.Fill(oTsDS.tsQuestionsM);
            Hashtable ht = new Hashtable();
            //先加上面
            foreach (TsDS.tsQuestionsMRow r in oTsDS.tsQuestionsM.Rows)
            {
                if (sCodeLen == -1)
                    sCodeLen = JBLib.Module.MyCS.GetCountStringLength(oTsDS.tsQuestionsM, "sCode", "", "sCode DESC");

                li = new ListItem("[" + JBLib.Module.MyCS.GetFillString("", sCodeLen - Encoding.Default.GetBytes(r.sCode).Length) + r.sCode.ToString() + "]" + r.sName, r.sCode);
                llU.Add(li);
                ht.Add(r.sCode, li);
            }

            //要加入下面
            lnTestTA.Fill(oLnDS.lnTest);
            rows = oLnDS.lnTest.Select("lnCategoryS_sCode = '" + lblEditID.Text + "'");
            foreach (LnDS.lnTestRow r in rows)
            {
                li = ht[r.tsQuestionsM_sCode] as ListItem;
                llD.Add(li);

                if (ht.ContainsKey(r.tsQuestionsM_sCode))
                    llU.Remove(li);
            }

            this.ucTest.SetListBox(llU, llD);
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

    protected void btnExitRole_Click(object sender, EventArgs e)
    {
        mpePopupRole.Hide();
    }

    protected void btnSaveRole_Click(object sender, EventArgs e)
    {
        mpePopupRole.Show();

        ListBox lb = this.ucAuthRole.GetListBox();

        lnCategorySTA.Fill(oLnDS.lnCategoryS);
        rows = oLnDS.lnCategoryS.Select("sCode = '" + lblRoleID.Text + "'");
        if (rows.Length > 0)
        {
            LnDS.lnCategorySRow r = rows[0] as LnDS.lnCategorySRow;
            int iKey = 0;
            foreach (ListItem li in lb.Items)   //將Box所有權限相加
                iKey += Convert.ToInt32(li.Value);

            if (iKey != r.sysRole_iKey)
            {
                r.sysRole_iKey = iKey;
                lnCategorySTA.Update(r);
            }

            mp.Msg = "修改完成";
            gv.DataBind();
        }
    }

    protected void btnExitEdit_Click(object sender, EventArgs e)
    {
        mpePopupEdit.Hide();
        gv.DataBind();
    }

    protected void gvView_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        mpePopupEdit.Show();
    }

    protected void btnSaveEdit_Click(object sender, EventArgs e)
    {
        mpePopupEdit.Show();

        rows = lnCategorySTA.GetDataByKey(lblEditID.Text).Select();
        if (rows.Length > 0)
        {
            LnDS.lnCategorySRow rcs = (LnDS.lnCategorySRow)rows[0];
            rcs.sContent = fckContent.Value;
            rcs.iEdition = rcs.iEdition + 1;

            lnCategorySTA.Update(rcs);
            mp.Msg = "內容儲存完成";
        }
    }

    protected void btnLink_Click(object sender, EventArgs e)
    {
        //加入考題或考卷的跳出試窗
        Button btn = sender as Button;
        string cn, ca;
        cn = btn.CommandName;
        ca = btn.CommandArgument;

        mpePopupEdit.Show();
        //mpePopupEdit.X = 0;
        //mpePopupTest.X = 650;
        //mpePopupFile.X = 650;
        btnExitEdit.Enabled = false;
        gvView.Enabled = false;
        btnSaveEdit.Enabled = false;

        if (cn == "Test")
        {
            mpePopupTest.Show();

            List<ListItem> llU = new List<ListItem>();
            List<ListItem> llD = new List<ListItem>();
            ListItem li;

            int sCodeLen = -1;
            tsQuestionsMTA.Fill(oTsDS.tsQuestionsM);
            Hashtable ht = new Hashtable();
            //先加上面
            foreach (TsDS.tsQuestionsMRow r in oTsDS.tsQuestionsM.Rows)
            {
                if (sCodeLen == -1)
                    sCodeLen = JBLib.Module.MyCS.GetCountStringLength(oTsDS.tsQuestionsM, "sCode", "", "sCode DESC");

                li = new ListItem("[" + JBLib.Module.MyCS.GetFillString("", sCodeLen - Encoding.Default.GetBytes(r.sCode).Length) + r.sCode.ToString() + "]" + r.sName, r.sCode);
                llU.Add(li);
                ht.Add(r.sCode, li);
            }

            //要加入下面
            lnTestTA.Fill(oLnDS.lnTest);
            rows = oLnDS.lnTest.Select("lnCategoryS_sCode = '" + lblEditID.Text + "'");
            foreach (LnDS.lnTestRow r in rows)
            {
                li = ht[r.tsQuestionsM_sCode] as ListItem;
                llD.Add(li);

                if (ht.ContainsKey(r.tsQuestionsM_sCode))
                    llU.Remove(li);
            }

            this.ucTest.SetListBox(llU, llD);
        }
        else if (cn == "File")
        {
            mpePopupFile.Show();
            gvUpload.DataBind();
        }
    }

    protected void btnExit_Click(object sender, EventArgs e)
    {
        mpePopupTest.Hide();
        mpePopupEdit.Show();
        btnExitEdit.Enabled = true;
        gvView.Enabled = true;
        btnSaveEdit.Enabled = true;
    }

    protected void btnSaveTest_Click(object sender, EventArgs e)
    {
        //mpePopupEdit.Show();
        mpePopupTest.Show();

        ListBox lb = this.ucTest.GetListBox();

        lnTestTA.FillByCategorySCode(oLnDS.lnTest, lblEditID.Text);

        //先刪除
        foreach (LnDS.lnTestRow r in oLnDS.lnTest.Rows)
            if (lb.Items.FindByValue(r.tsQuestionsM_sCode) == null)
                r.Delete();

        //再加入
        foreach (ListItem li in lb.Items)
        {
            rows = oLnDS.lnTest.Select("tsQuestionsM_sCode = '" + li.Value + "'");
            if (rows.Length == 0)
            {
                LnDS.lnTestRow r = oLnDS.lnTest.NewlnTestRow();
                r.lnCategoryS_sCode = lblEditID.Text;
                r.tsQuestionsM_sCode = li.Value;
                r.sKeyMan = UserID;
                r.dKeyDate = DateTime.Now;
                oLnDS.lnTest.AddlnTestRow(r);
            }
        }

        lnTestTA.Update(oLnDS.lnTest);
        mp.Msg = "內容儲存完成";

        mpePopupTest.Hide();
        gv.DataBind();
    }

    protected void gvUpload_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        mpePopupEdit.Show();
        mpePopupFile.Show();

        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName == "Download" || CommandName == "Del")
        {
            LnDS.lnUpFileRow r = (LnDS.lnUpFileRow)lnUpFileTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];

            string FN = Server.MapPath("./Upload/" + r.sServerName);
            FileInfo fi = new FileInfo(FN);

            if (fi.Exists && CommandName == "Download")
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

                gvUpload.DataBind();
            }
            else if (CommandName == "Del")
            {
                if (fi.Exists)
                    fi.Delete();

                r.Delete();
                mp.Msg = "刪除完成";
                lnUpFileTA.Update(r);
                gvUpload.DataBind();
            }
            else
            {
                mp.Msg = "系統找不到檔案";
            }
        }
    }

    protected void btnSaveFile_Click(object sender, EventArgs e)
    {
        mpePopupEdit.Show();
        mpePopupFile.Show();

        //mp.Msg = "檔案上傳成功";
        lblMsgFile.Text = "檔案上傳成功";

        FileUpload file = fu;

        if (!file.HasFile)
        {
            //mp.Msg = "未指定要上傳的檔案";
            lblMsgFile.Text = "未指定要上傳的檔案";
            gvUpload.DataBind();
            return;
        }

        string fileName = Guid.NewGuid().ToString();
        file.PostedFile.SaveAs(Server.MapPath(".") + "\\Upload\\" + fileName + file.FileName.Substring(file.FileName.IndexOf(".")));

        lnUpFileTA.Fill(oLnDS.lnUpFile);

        LnDS.lnUpFileRow r = oLnDS.lnUpFile.NewlnUpFileRow();
        r.lnCategoryS_sCode = lblEditID.Text;
        r.sUpName = file.FileName;
        r.sServerName = fileName + r.sUpName.Substring(r.sUpName.IndexOf("."));
        r.sContent = txtDescription.Text;
        r.sType = file.PostedFile.ContentType;
        r.iSize = (file.PostedFile.ContentLength / 1024) >= 1 ? file.PostedFile.ContentLength / 1024 : 1;
        r.sCat = "1";
        r.sKeyMan = UserID;
        r.dKeyDate = DateTime.Now;
        oLnDS.lnUpFile.AddlnUpFileRow(r);

        lnUpFileTA.Update(oLnDS.lnUpFile);
        txtDescription.Text = "";

        gvUpload.DataBind();
    }
    protected void btnExitAuth_Click(object sender, EventArgs e)
    {
        mpePopupAuth.Hide();
    }
    protected void btnAuthSave_Click(object sender, EventArgs e)
    {
        rows = lnCategorySTA.GetDataByKey(lblAuthID.Text).Select();
        if (rows.Length > 0)
        {
            LnDS.lnCategorySRow r = rows[0] as LnDS.lnCategorySRow;
            r.sDept = SetString(txtDept.Text);
            r.sJob = SetString(txtJob.Text);

            lnCategorySTA.Update(r);
        }
    }

    private string SetString(string s)
    {
        s = s.Trim();
        string b = s.Length > 0 && s.Substring(0, 1) != "," && s.IndexOf("*") == -1 ? "," : "";
        string e = s.Length > 0 && s.Substring(s.Length - 1, 1) != "," && s.IndexOf("*") == -1 ? "," : "";
        s = b + s + e;

        return s;
    }

    protected void btnViewExport_Click(object sender, EventArgs e)
    {
        gvView.AllowPaging = false;
        gvView.AllowSorting = false;
        gvView.Columns[0].Visible = false;
        gvView.DataBind();
        sa.gv.ExportXls(gvView);
    }
}