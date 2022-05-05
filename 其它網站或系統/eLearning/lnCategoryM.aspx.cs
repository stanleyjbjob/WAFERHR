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

public partial class lnCategoryM : System.Web.UI.Page
{
    private LnDSTableAdapters.lnCategoryMTableAdapter lnCategoryMTA = new LnDSTableAdapters.lnCategoryMTableAdapter();
    private LnDSTableAdapters.lnCategorySTableAdapter lnCategorySTA = new LnDSTableAdapters.lnCategorySTableAdapter();

    private LnDS oLnDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.ucEdit.mpeCommandEvent += new CommandEventHandler(ucEdit_mpeCommandEvent);
    }

    private void ucEdit_mpeCommandEvent(object sender, CommandEventArgs e)
    {
        mpePopupEdit.Show();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
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

        try
        {
            e.Values["iOrder"] = Convert.ToInt32(e.Values["iOrder"]);
        }
        catch
        {
            int i = 1;
            while (lnCategoryMTA.GetData().Select("lnCategoryL_sCode = '" + e.Values["lnCategoryL_sCode"].ToString() + "' AND iOrder = " + i).Length > 0)
                i++;

            e.Values["iOrder"] = i;
        }

        if (lnCategoryMTA.GetDataByKey(e.Values["sCode"].ToString().Trim()).Rows.Count > 0)
        {
            mp.Msg = "代碼重複";
            e.Cancel = true;
        }

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

        try
        {
            e.NewValues["iOrder"] = Convert.ToInt32(e.NewValues["iOrder"]);
        }
        catch
        {
            int i = 1;
            while (lnCategoryMTA.GetData().Select("lnCategoryL_sCode = '" + e.NewValues["lnCategoryL_sCode"].ToString() + "' AND iOrder = " + i).Length > 0)
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
        else if (cn == "lnCategoryMEdit")
        {
            mpePopupEdit.Show();
            lblEditID.Text = ca;

            lnCategoryMEdit();
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

    private void lnCategoryMEdit()
    {
        List<ListItem> llU = new List<ListItem>();
        List<ListItem> llD = new List<ListItem>();

        int iCategoryCodeLen = -1, iCategoryNameLen = -1, iCodeLen = -1, iNameLen = -1; ;
        string sCategoryCode, sCategoryName;
        lnCategoryMTA.Fill(oLnDS.lnCategoryM);
        lnCategorySTA.Fill(oLnDS.lnCategoryS);
        foreach (LnDS.lnCategorySRow r in oLnDS.lnCategoryS.Rows)
        {
            if (iCategoryCodeLen == -1)
                iCategoryCodeLen = JBLib.Module.MyCS.GetCountStringLength(oLnDS.lnCategoryM, "sCode", "", "sCode DESC");

            if (iCategoryNameLen == -1)
                iCategoryNameLen = JBLib.Module.MyCS.GetCountStringLength(oLnDS.lnCategoryM, "sName", "", "sName DESC");

            if (iCodeLen == -1)
                iCodeLen = JBLib.Module.MyCS.GetCountStringLength(oLnDS.lnCategoryS, "sCode", "", "sCode DESC");

            if (iNameLen == -1)
                iNameLen = JBLib.Module.MyCS.GetCountStringLength(oLnDS.lnCategoryS, "sName", "", "sName DESC");

            rows = oLnDS.lnCategoryM.Select("sCode = '" + r.lnCategoryM_sCode + "'");
            if (rows.Length > 0)
            {
                LnDS.lnCategoryMRow rl = rows[0] as LnDS.lnCategoryMRow;
                sCategoryCode = JBLib.Module.MyCS.GetFillString("", iCategoryCodeLen - Encoding.Default.GetBytes(rl.sCode).Length) + rl.sCode;
                sCategoryName = JBLib.Module.MyCS.GetFillString("", iCategoryNameLen - Encoding.Default.GetBytes(rl.sName).Length) + rl.sName;
            }
            else
            {
                sCategoryCode = JBLib.Module.MyCS.GetFillString("", iCategoryCodeLen - Encoding.Default.GetBytes("").Length);
                sCategoryName = JBLib.Module.MyCS.GetFillString("", iCategoryNameLen - Encoding.Default.GetBytes("").Length);
            }

            llU.Add(new ListItem("[" + sCategoryCode + "|" + sCategoryName + "]" +
                "[" + JBLib.Module.MyCS.GetFillString("", iCodeLen - Encoding.Default.GetBytes(r.sCode).Length) + r.sCode + "|" +
                 JBLib.Module.MyCS.GetFillString("", iNameLen - Encoding.Default.GetBytes(r.sName).Length) + r.sName + "]", r.sCode));
        }

        foreach (ListItem li in llU)
        {
            rows = oLnDS.lnCategoryS.Select("sCode = '" + li.Value + "'");
            if (rows.Length > 0)
            {
                LnDS.lnCategorySRow r = rows[0] as LnDS.lnCategorySRow;
                if (r.lnCategoryM_sCode == lblEditID.Text)
                    llD.Add(li);
            }
        }

        //把從上邊移到下邊的刪除(上邊)
        foreach (ListItem li in llD)
            if (llU.Contains(li))
                llU.Remove(li);

        this.ucEdit.SetListBox(llU, llD);
    }

    protected void btnExitEdit_Click(object sender, EventArgs e)
    {
        mpePopupEdit.Hide();
        gv.DataBind();
    }

    protected void btnSaveLogin_Click(object sender, EventArgs e)
    {
        mpePopupEdit.Show();

        ListBox lb = this.ucEdit.GetListBox();
        ListItem li;
        bool bHave = true;

        lnCategorySTA.Fill(oLnDS.lnCategoryS);
        foreach (LnDS.lnCategorySRow r in oLnDS.lnCategoryS.Rows)
        {
            bHave = r.lnCategoryM_sCode == lblEditID.Text;
            li = lb.Items.FindByValue(r.sCode);
            if (li != null && !bHave)
                r.lnCategoryM_sCode = lblEditID.Text;
            else if (li == null && bHave)
                r.lnCategoryM_sCode = "0";
        }

        lnCategorySTA.Update(oLnDS.lnCategoryS);
        mp.Msg = "儲存完成";

        lnCategoryMEdit();
    }
}
