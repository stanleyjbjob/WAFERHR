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

public partial class sysRole : System.Web.UI.Page
{
    private SysDSTableAdapters.sysFileStructureTableAdapter sysFileStructureTA = new SysDSTableAdapters.sysFileStructureTableAdapter();
    private SysDSTableAdapters.sysRoleTableAdapter sysRoleTA = new SysDSTableAdapters.sysRoleTableAdapter();
    private SysDSTableAdapters.sysLoginTableAdapter sysLoginTA = new SysDSTableAdapters.sysLoginTableAdapter();
    private SysDSTableAdapters.sysLoginUserTableAdapter sysLoginUserTA = new SysDSTableAdapters.sysLoginUserTableAdapter();
    private SysDSTableAdapters.sysCustomerDataTableAdapter sysCustomerDataTA = new SysDSTableAdapters.sysCustomerDataTableAdapter();

    private SysDS oSysDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.ucAuthRole.mpeCommandEvent += new CommandEventHandler(ucAuthRole_mpeCommandEvent);
        this.ucAuthLogin.mpeCommandEvent += new CommandEventHandler(ucAuthLogin_mpeCommandEvent);
    }

    private void ucAuthRole_mpeCommandEvent(object sender, CommandEventArgs e)
    {
        mpePopupRole.Show();
    }

    private void ucAuthLogin_mpeCommandEvent(object sender, CommandEventArgs e)
    {
        mpePopupLogin.Show();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        mp = (mpSystem)Master;
        mp.Msg = "";
        oSysDS = new SysDS();

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

        int i = 1;
        while (sysRoleTA.GetDataByKey(i).Rows.Count > 0)
            i = i * 2;

        e.Values["iKey"] = i;
        e.Values["dDateA"] = new DateTime(1900, 1, 1);
        e.Values["dDateD"] = new DateTime(9999, 12, 31);
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
        else if (cn == "sysRoleEdit")
        {
            mpePopupRole.Show();
            lblRoleID.Text = ca;

            List<ListItem> llU = new List<ListItem>();
            List<ListItem> llD = new List<ListItem>();

            int sKeyLen = -1;
            sysFileStructureTA.Fill(oSysDS.sysFileStructure);
            foreach (SysDS.sysFileStructureRow r in oSysDS.sysFileStructure.Rows)
            {
                if (sKeyLen == -1)
                    sKeyLen = JBLib.Module.MyCS.GetCountStringLength(oSysDS.sysFileStructure, "sKey", "", "");

                llU.Add(new ListItem("[" + JBLib.Module.MyCS.GetFillString("", sKeyLen - Encoding.Default.GetBytes(r.sKey).Length) + r.sKey + "]" + r.sFileTitle, r.sKey));
            }

            foreach (ListItem li in llU)
            {
                rows = oSysDS.sysFileStructure.Select("sKey = '" + li.Value + "'");
                if (rows.Length > 0)
                {
                    SysDS.sysFileStructureRow r = rows[0] as SysDS.sysFileStructureRow;
                    if (JBLib.Module.MyCS.GetAuth(r.sysRole_iKey, lblRoleID.Text))
                        llD.Add(li);
                }
            }

            //把從上邊移到下邊的刪除(上邊)
            foreach (ListItem li in llD)
                if (llU.Contains(li))
                    llU.Remove(li);

            this.ucAuthRole.SetListBox(llU, llD);
        }
        else if (cn == "sysLoginUserEdit")
        {
            mpePopupLogin.Show();
            lblLoginID.Text = ca;

            sysLoginUserEdit();
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

    //帳號權限
    private void sysLoginUserEdit()
    {
        List<ListItem> llU = new List<ListItem>();
        List<ListItem> llD = new List<ListItem>();

        int sysRole_iKeyLen = -1, sEmailLen = -1, sNameCLen = -1;
        sysLoginTA.Fill(oSysDS.sysLogin);
        foreach (SysDS.sysLoginRow r in oSysDS.sysLogin.Rows)
        {
            if (sysRole_iKeyLen == -1)
                sysRole_iKeyLen = JBLib.Module.MyCS.GetCountStringLength(oSysDS.sysLogin, "sysRole_iKey", "", "");
            if (sEmailLen == -1)
                sEmailLen = JBLib.Module.MyCS.GetCountStringLength(oSysDS.sysLogin, "sEmail", "sEmail IS NOT NULL", "");
            if (sNameCLen == -1)
                sNameCLen = JBLib.Module.MyCS.GetCountStringLength(oSysDS.sysLogin, "sNameC", "sNameC IS NOT NULL", "");

            llU.Add(new ListItem("[" + JBLib.Module.MyCS.GetFillString("", sysRole_iKeyLen - Encoding.Default.GetBytes(r.sysRole_iKey.ToString()).Length) + r.sysRole_iKey.ToString() + "]" +
                "[" + JBLib.Module.MyCS.GetFillString("", sEmailLen - Encoding.Default.GetBytes(r.IssEmailNull() ? "" : r.sEmail).Length) + (r.IssEmailNull() ? "" : r.sEmail) + "]" +
                "[" + JBLib.Module.MyCS.GetFillString("", sNameCLen - Encoding.Default.GetBytes(r.IssNameCNull() ? "" : r.sNameC).Length) + (r.IssNameCNull() ? "" : r.sNameC) + "]" +
                r.sUserID, r.sUserID));
        }

        foreach (ListItem li in llU)
        {
            rows = oSysDS.sysLogin.Select("sUserID = '" + li.Value + "'");
            if (rows.Length > 0)
            {
                SysDS.sysLoginRow r = rows[0] as SysDS.sysLoginRow;
                if (r.sysRole_iKey == Convert.ToInt32(lblLoginID.Text))
                    llD.Add(li);
            }
        }

        //把從上邊移到下邊的刪除(上邊)
        foreach (ListItem li in llD)
            if (llU.Contains(li))
                llU.Remove(li);

        this.ucAuthLogin.SetListBox(llU, llD);
    }

    protected void btnExitRole_Click(object sender, EventArgs e)
    {
        mpePopupRole.Hide();
    }
    protected void btnSaveRole_Click(object sender, EventArgs e)
    {
        mpePopupRole.Show();

        ListBox lb = this.ucAuthRole.GetListBox();
        ListItem li;
        bool bHave = true;

        sysFileStructureTA.Fill(oSysDS.sysFileStructure);
        foreach (SysDS.sysFileStructureRow r in oSysDS.sysFileStructure.Rows)
        {
            bHave = JBLib.Module.MyCS.GetAuth(r.sysRole_iKey, lblRoleID.Text);
            li = lb.Items.FindByValue(r.sKey);
            if (li != null && !bHave)
                r.sysRole_iKey += Convert.ToInt32(lblRoleID.Text);
            else if (li == null && bHave)
                r.sysRole_iKey -= Convert.ToInt32(lblRoleID.Text);
        }

        sysFileStructureTA.Update(oSysDS.sysFileStructure);
        mp.Msg = "修改完成";
    }

    protected void btnExitLogin_Click(object sender, EventArgs e)
    {
        mpePopupLogin.Hide();
    }

    protected void btnSaveLogin_Click(object sender, EventArgs e)
    {
        mpePopupLogin.Show();

        ListBox lb = this.ucAuthLogin.GetListBox();
        ListItem li;
        bool bHave = true;

        sysLoginUserTA.Fill(oSysDS.sysLoginUser);
        foreach (SysDS.sysLoginUserRow r in oSysDS.sysLoginUser.Rows)
        {
            bHave = r.sysRole_iKey == Convert.ToInt32(lblLoginID.Text);
            li = lb.Items.FindByValue(r.sUserID);
            if (li != null && !bHave)
                r.sysRole_iKey = Convert.ToInt32(lblLoginID.Text);
            else if (li == null && bHave)
                r.sysRole_iKey = 0;
        }

        sysLoginUserTA.Update(oSysDS.sysLoginUser);
        mp.Msg = "修改完成";
        sysLoginUserEdit();
    }
}