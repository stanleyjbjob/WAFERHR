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
using System.IO;

using CustomSecurity;

public partial class tsEaxmination : System.Web.UI.Page
{
    private TsDSTableAdapters.tsEaxminationTableAdapter tsEaxminationTA = new TsDSTableAdapters.tsEaxminationTableAdapter();
    private TsDSTableAdapters.tsChooseTableAdapter tsChooseTA = new TsDSTableAdapters.tsChooseTableAdapter();

    private TsDS oTsDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
        lblMsgImport.Text = "";
        oTsDS = new TsDS();

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

        e.Values["lnCategoryS_sCode"] = ddlCategoryS.SelectedItem.Value;
        //e.Values["tsCategory_sCode"] = ddlCategory.SelectedItem.Value;
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

        Button btnChoose = e.Row.FindControl("btnChoose") as Button;
        if (btnChoose != null)
        {
            rows = tsEaxminationTA.GetDataByKey(int.Parse(btnChoose.CommandArgument)).Select();
            if (rows.Length > 0)
            {
                TsDS.tsEaxminationRow re = (TsDS.tsEaxminationRow)rows[0];
                btnChoose.Enabled = re.tsCategory_sCode == "2" || re.tsCategory_sCode == "3";
            }
        }

        //改變答案是否可以複選
        AjaxControlToolkit.MutuallyExclusiveCheckBoxExtender mecbeAnswer = e.Row.FindControl("mecbeAnswer") as AjaxControlToolkit.MutuallyExclusiveCheckBoxExtender;
        if (mecbeAnswer != null)
        {
            rows = tsEaxminationTA.GetDataByKey(Convert.ToInt32(lblChooseID.Text)).Select();
            if (rows.Length > 0)
            {
                TsDS.tsEaxminationRow re = (TsDS.tsEaxminationRow)rows[0];
                mecbeAnswer.Enabled = re.tsCategory_sCode == "2";
            }
        }

        Button btnExport = e.Row.FindControl("btnExport") as Button;
        if (btnExport != null)
            ScriptManager.GetCurrent(this).RegisterPostBackControl(btnExport);
    }

    protected void gv_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        tsChooseTA.DeleteQueryEaxmination_iAutoKey(Convert.ToInt32(e.Keys["iAutoKey"]));
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
            if (ddlCategoryS.SelectedItem.Value == "a")
            {
                mp.Msg = "請先選擇課程小類別";
                return;
            }

            mpePopupFV.Show();
        }
        else if (cn == "tsChoose")
        {
            lblChooseID.Text = ca;
            gvChoose.DataBind();
            mpePopupChoose.Show();
        }
        else if (cn == "Import")
        {
            mpePopupImport.Show();
            wzImport.ActiveStepIndex = 0;
        }
        else if (cn == "DeleteSelect")
        {
            CheckBox cbDelete;
            TsDS.tsEaxminationRow re;
            foreach (GridViewRow r in gv.Rows)
            {
                cbDelete = r.FindControl("cbDelete") as CheckBox;
                if (cbDelete.Checked)
                {
                    tsEaxminationTA.FillByKey(oTsDS.tsEaxmination, Convert.ToInt32(cbDelete.ToolTip));
                    if (oTsDS.tsEaxmination.Rows.Count > 0)
                    {
                        re = oTsDS.tsEaxmination.Rows[0] as TsDS.tsEaxminationRow;
                        tsChooseTA.DeleteQueryEaxmination_iAutoKey(re.iAutoKey);
                        re.Delete();
                        tsEaxminationTA.Update(re);
                    }
                }
            }

            mp.Msg = "刪除完成";
            gv.DataBind();
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

    protected void ddlCategoryL_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlCategoryM.Items.Clear();
        ddlCategoryM.Items.Add(new ListItem("課程中分類(全部)", "a"));

        ddlCategoryS.Items.Clear();
        ddlCategoryS.Items.Add(new ListItem("課程小分類(全部)", "a"));
    }

    protected void ddlCategoryM_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlCategoryS.Items.Clear();
        ddlCategoryS.Items.Add(new ListItem("課程小分類(全部)", "a"));
    }

    protected void btnExitChoose_Click(object sender, EventArgs e)
    {
        mpePopupChoose.Hide();

        //改變答案選項
        tsChooseTA.FillByEaxmination_iAutoKey(oTsDS.tsChoose, Convert.ToInt32(lblChooseID.Text));
        foreach (GridViewRow r in gvChoose.Rows)
        {
            CheckBox cbAnswer = r.FindControl("cbAnswer") as CheckBox;
            rows = oTsDS.tsChoose.Select("iAutoKey = " + int.Parse(cbAnswer.ToolTip));
            if (rows.Length > 0)
            {
                TsDS.tsChooseRow rc = (TsDS.tsChooseRow)rows[0];
                rc.bAnswer = cbAnswer.Checked;
            }
        }
        tsChooseTA.Update(oTsDS.tsChoose);

        gv.DataBind();
    }

    protected void fvChoose_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        try
        {
            e.Values["iOrder"] = Convert.ToInt32(e.Values["iOrder"]);
        }
        catch
        {
            int i = 1;
            while (tsChooseTA.GetDataByEaxmination_iAutoKey(Convert.ToInt32(lblChooseID.Text)).Select("iOrder = " + i).Length > 0)
                i++;

            e.Values["iOrder"] = i;
        }

        e.Values["bAnswer"] = false;
        e.Values["tsEaxmination_iAutoKey"] = Convert.ToInt32(lblChooseID.Text);
        e.Values["sKeyMan"] = UserID;
        e.Values["dKeyDate"] = DateTime.Now;
    }

    protected void fvChoose_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        mp.Msg = "新增完成";
        gvChoose.DataBind();
    }

    protected void fvChoose_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        try
        {
            e.NewValues["iOrder"] = Convert.ToInt32(e.NewValues["iOrder"]);
        }
        catch
        {
            int i = 1;
            while (tsChooseTA.GetDataByEaxmination_iAutoKey(Convert.ToInt32(lblChooseID.Text)).Select("iOrder = " + i).Length > 0)
                i++;

            e.NewValues["iOrder"] = i;
        }

        e.NewValues["sKeyMan"] = UserID;
        e.NewValues["dKeyDate"] = DateTime.Now;
    }

    protected void fvChoose_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        mp.Msg = "修改完成";
        gvChoose.SelectedIndex = -1;
        gvChoose.DataBind();
    }

    protected void fvChoose_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        mpePopupChoose.Show();
    }

    protected void gvChoose_PageIndexChanged(object sender, EventArgs e)
    {
        gvChoose.SelectedIndex = -1;
        fvChoose.ChangeMode(FormViewMode.Insert);
        fvChoose.DataBind();
    }

    protected void gvChoose_SelectedIndexChanged(object sender, EventArgs e)
    {
        fvChoose.ChangeMode(FormViewMode.Edit);
    }

    protected void gvChoose_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        mp.Msg = "刪除完成";
        gvChoose.SelectedIndex = -1;
        fvChoose.ChangeMode(FormViewMode.Insert);
        mpePopupChoose.Show();
    }

    protected void gvChoose_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        mpePopupChoose.Show();
    }

    protected void wzImport_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        mpePopupImport.Show();

        if (e.NextStepIndex == 1)
        {
            FileInfo fi = new FileInfo(Server.MapPath("./Upload/Eaxmination/" + lblImportID.Text));
            if (!fi.Exists)
            {
                lblMsgImport.Text = "檔案不存在，請重新上傳";
                wzImport.ActiveStepIndex = 0;
                e.Cancel = true;
            }
            else
            {
                lblConn.Text = "Provider=Microsoft.Jet.OLEDB.4.0;" +
                "Data Source=" + Request.PhysicalApplicationPath + @"Upload\Eaxmination\" + lblImportID.Text + ";" +
                "Extended Properties='Excel 8.0;HDR=No;IMEX=1;Persist Security Info=False'";

                System.Data.OleDb.OleDbConnection ExcelConn = new System.Data.OleDb.OleDbConnection(lblConn.Text);
                if (ExcelConn.State == ConnectionState.Closed) ExcelConn.Open();
                DataTable schemaDt = ExcelConn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
                ExcelConn.Close();

                ddlSheet.Items.Clear();
                //工作表選單
                foreach (DataRow dr in schemaDt.Rows)
                    ddlSheet.Items.Add(new ListItem(dr.ItemArray[2].ToString().Replace("$", ""), dr.ItemArray[2].ToString()));
            }
        }
        else if (e.NextStepIndex == 2)
        {
            lblSheet.Text = ddlSheet.SelectedItem.Text;
            lblSheet.ToolTip = ddlSheet.SelectedItem.Value;
            System.Data.OleDb.OleDbConnection ExcelConn = new System.Data.OleDb.OleDbConnection(lblConn.Text);
            if (ExcelConn.State == ConnectionState.Closed) ExcelConn.Open();
            System.Data.OleDb.OleDbDataAdapter daExcel = new System.Data.OleDb.OleDbDataAdapter("Select * From [" + lblSheet.ToolTip + "]", ExcelConn);
            ExcelConn.Close();

            DataTable tbExcel = new DataTable();
            daExcel.Fill(tbExcel);
            ListItem li;

            ddlCategoryCode.Items.Clear();
            ddlContent.Items.Clear();
            ddlAnswer.Items.Clear();
            for (int i = 0; i < tbExcel.Columns.Count; i++)
            {
                li = new ListItem();
                li.Text = tbExcel.Rows[0][i].ToString();
                li.Value = tbExcel.Columns[i].ToString();
                ddlCategoryCode.Items.Add(li);

                li = new ListItem();
                li.Text = tbExcel.Rows[0][i].ToString();
                li.Value = tbExcel.Columns[i].ToString();
                ddlContent.Items.Add(li);

                li = new ListItem();
                li.Text = tbExcel.Rows[0][i].ToString();
                li.Value = tbExcel.Columns[i].ToString();
                ddlAnswer.Items.Add(li);
            }

            ddlCategoryCode.ClearSelection();
            ddlContent.ClearSelection();
            ddlAnswer.ClearSelection();

            ListItem liCategoryCode, liContent, liAnswer;
            liCategoryCode = ddlCategoryCode.Items.FindByText("題型");
            liContent = ddlContent.Items.FindByText("題目");
            liAnswer = ddlAnswer.Items.FindByText("答案");

            if (liCategoryCode != null) liCategoryCode.Selected = true;
            if (liContent != null) liContent.Selected = true;
            if (liAnswer != null) liAnswer.Selected = true;
        }
        else if (e.NextStepIndex == 3)
        {
            lblCategorySCode.Text = ddlCategorySCode.SelectedItem.Text;
            lblCategorySCode.ToolTip = ddlCategorySCode.SelectedItem.Value;
            lblCategoryCode.Text = ddlCategoryCode.SelectedItem.Text;
            lblCategoryCode.ToolTip = ddlCategoryCode.SelectedItem.Value;
            lblContent.Text = ddlContent.SelectedItem.Text;
            lblContent.ToolTip = ddlContent.SelectedItem.Value;
            lblAnswer.Text = ddlAnswer.SelectedItem.Text;
            lblAnswer.ToolTip = ddlAnswer.SelectedItem.Value;
        }
    }
    protected void wzImport_PreviousButtonClick(object sender, WizardNavigationEventArgs e)
    {
        mpePopupImport.Show();

    }
    protected void wzImport_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
    {
        mpePopupImport.Show();
        if (e.NextStepIndex > 0)
        {
            lblMsgImport.Text = "請逐步操作";
            e.Cancel = true;
        }
    }
    protected void wzImport_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        FileInfo fi = new FileInfo(Server.MapPath("./Upload/Eaxmination/" + lblImportID.Text));
        if (!fi.Exists)
        {
            lblMsgImport.Text = "檔案不存在，請重新上傳";
            wzImport.ActiveStepIndex = 0;
            e.Cancel = true;
        }
        else
        {
            tsEaxminationTA.Fill(oTsDS.tsEaxmination);

            System.Data.OleDb.OleDbConnection ExcelConn = new System.Data.OleDb.OleDbConnection(lblConn.Text);
            if (ExcelConn.State == ConnectionState.Closed) ExcelConn.Open();
            System.Data.OleDb.OleDbDataAdapter daExcel = new System.Data.OleDb.OleDbDataAdapter("Select * From [" + lblSheet.ToolTip + "]", ExcelConn);
            ExcelConn.Close();

            DataTable tbExcel = new DataTable();
            daExcel.Fill(tbExcel);

            TsDS.tsEaxminationRow re;
            TsDS.tsChooseRow rc;

            ArrayList al = new ArrayList();
            al.Add(lblCategoryCode.ToolTip);
            al.Add(lblContent.ToolTip);
            al.Add(lblAnswer.ToolTip);

            //先記錄欄位名稱並將第一列刪除
            //object[] oColumns = tbExcel.Rows[0].ItemArray;
            tbExcel.Rows[0].Delete();
            tbExcel.AcceptChanges();

            string sCategory, sContent, sAnswer;
            int i = 0, j = 0, x, iAutoKey = 0;   //應匯入數/總匯入數
            foreach (DataRow dr in tbExcel.Rows)
            {
                i++;
                sCategory = dr[lblCategoryCode.ToolTip].ToString();
                sContent = dr[lblContent.ToolTip].ToString();
                sAnswer = dr[lblAnswer.ToolTip].ToString();
                rows = oTsDS.tsEaxmination.Select("sContent = '" + sContent.Trim() + "'");
                if (rows.Length == 0 || cbRep.Checked)
                {
                    //寫入題目
                    //iAutoKey = tsEaxminationTA.Insert(lblCategorySCode.ToolTip, sCategory, sContent, sCategory == "1" ? Convert.ToInt32(sAnswer) : 0, UserID, DateTime.Now);

                    re = oTsDS.tsEaxmination.NewtsEaxminationRow();
                    re.lnCategoryS_sCode = lblCategorySCode.ToolTip;
                    re.tsCategory_sCode = sCategory;
                    re.sContent = sContent;
                    re.iAnswer = sCategory == "1" ? Convert.ToInt32(sAnswer) : 0;
                    re.sKeyMan = UserID;
                    re.dKeyDate = DateTime.Now;
                    oTsDS.tsEaxmination.AddtsEaxminationRow(re);
                    tsEaxminationTA.Update(re);

                    j++;

                    iAutoKey = Convert.ToInt32(tsEaxminationTA.ScalarQueryContent(sContent));

                    //寫入答案
                    if (iAutoKey > 0 && (sCategory == "2" || sCategory == "3"))
                    {
                        x = 1;

                        //拿一個ddl來用
                        foreach (ListItem li in ddlContent.Items)
                        {
                            if (!al.Contains(li.Value))
                            {
                                sContent = dr[li.Value].ToString();
                                if (sContent.Trim().Length > 0)
                                {
                                    rc = oTsDS.tsChoose.NewtsChooseRow();
                                    rc.tsEaxmination_iAutoKey = iAutoKey;
                                    rc.sContent = sContent;
                                    rc.bAnswer = sAnswer.IndexOf(li.Text) >= 0;
                                    rc.iOrder = x;
                                    rc.sKeyMan = UserID;
                                    rc.dKeyDate = DateTime.Now;
                                    oTsDS.tsChoose.AddtsChooseRow(rc);

                                    x++;
                                }
                            }
                        }
                    }
                }
            }

            tsChooseTA.Update(oTsDS.tsChoose);
            tsEaxminationTA.Update(oTsDS.tsEaxmination);
            mp.Msg = string.Format("應匯入{0}筆，共匯入{1}筆", i, j);
        }
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        string sFileName = Guid.NewGuid().ToString() + ".xls";
        Anthem.FileUpload fu = fuExcel;

        if (!fu.HasFile)
            lblMsgImport.Text = "未指定要上傳的檔案";
        else
        {
            lblExcel.Text = fu.FileName;
            lblExcel.ToolTip = fu.FileName;
            lblImportID.Text = sFileName;
            fu.PostedFile.SaveAs(Server.MapPath(".") + "\\Upload\\Eaxmination\\" + sFileName);
            lblMsgImport.Text = "檔案上傳成功，請按下一步選擇工作表";
        }
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblSearch.Text = txtSearch.Text.Trim().Length == 0 ? "a" : txtSearch.Text;
        gv.DataBind();
    }
}