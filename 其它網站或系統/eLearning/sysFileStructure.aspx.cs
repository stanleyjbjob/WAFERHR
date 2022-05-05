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

public partial class sysFileStructure : System.Web.UI.Page
{
    private SysDSTableAdapters.sysFileStructureTableAdapter sysFileStructureTA = new SysDSTableAdapters.sysFileStructureTableAdapter();
    private SysDSTableAdapters.sysRoleTableAdapter sysRoleTA = new SysDSTableAdapters.sysRoleTableAdapter();

    private SysDS oSysDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

    protected override void OnInit(EventArgs e)
    {
        base.OnInit(e);
        this.ucAuthRole.mpeCommandEvent += new CommandEventHandler(ucAuthRole_mpeCommandEvent);
    }

    private void ucAuthRole_mpeCommandEvent(object sender, CommandEventArgs e)
    {
        mpePopupRole.Show();
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

        try
        {
            e.Values["iOrder"] = Convert.ToInt32(e.Values["iOrder"]);
        }
        catch
        {
            int i = 1;
            while (sysFileStructureTA.GetDataByParentKey(e.Values["sParentKey"].ToString()).Select("iOrder = " + i).Length > 0)
                i++;

            e.Values["iOrder"] = i;
        }

        if (sysFileStructureTA.GetDataByKey(e.Values["sKey"].ToString().Trim()).Rows.Count > 0)
        {
            mp.Msg = "代碼重複";
            e.Cancel = true;
        }

        e.Values["sCat"] = "A";
        e.Values["sysRole_iKey"] = 0;
        e.Values["dDateA"] = new DateTime(1900, 1, 1);
        e.Values["dDateD"] = new DateTime(9999, 12, 31);
        //e.Values["iOrder"] = e.Values["iOrder"].ToString().Length > 0 ? e.Values["iOrder"] : 0;
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
            while (sysFileStructureTA.GetDataByKey(e.NewValues["sParentKey"].ToString()).Select("iOrder = " + i).Length > 0)
                i++;

            e.NewValues["iOrder"] = i;
        }

        e.NewValues["sCat"] = "A";
        //e.NewValues["iOrder"] = e.NewValues["iOrder"].ToString().Length > 0 ? e.NewValues["iOrder"] : 0;
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

        if (cn == "sysFileStructureEdit")
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

            sysFileStructureTA.Fill(oSysDS.sysFileStructure);
            rows = oSysDS.sysFileStructure.Select("sKey = '" + lblRoleID.Text + "'");
            if (rows.Length > 0)
            {
                SysDS.sysFileStructureRow r = (SysDS.sysFileStructureRow)rows[0];
                foreach (ListItem li in llU)
                    if ((r.sysRole_iKey != 0) && JBLib.Module.MyCS.GetAuth(r.sysRole_iKey , li.Value))
                        llD.Add(li);

                //把從上邊移到下邊的刪除(上邊)
                foreach (ListItem li in llD)
                    if (llU.Contains(li))
                        llU.Remove(li);

                this.ucAuthRole.SetListBox(llU, llD);
            }
        }
        else if (cn == "Add")
        {
            mpePopupFV.Show();
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

        sysFileStructureTA.Fill(oSysDS.sysFileStructure);
        rows = oSysDS.sysFileStructure.Select("sKey = '" + lblRoleID.Text + "'");
        if (rows.Length > 0)
        {
            SysDS.sysFileStructureRow rfs = (SysDS.sysFileStructureRow)rows[0];
            int iKey = 0;
            foreach (ListItem li in lb.Items)
                iKey += Convert.ToInt32(li.Value);

            if (iKey != rfs.sysRole_iKey)
            {
                rfs.sysRole_iKey = iKey;
                sysFileStructureTA.Update(rfs);
            }

            mp.Msg = "修改完成";
            gv.DataBind();
        }
    }
}