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

using CustomSecurity;


public partial class sysLoginUser : System.Web.UI.Page
{
    private SysDSTableAdapters.sysLoginUserTableAdapter sysLoginUserTA = new SysDSTableAdapters.sysLoginUserTableAdapter();
    private SysDSTableAdapters.sysCustomerDataTableAdapter sysCustomerDataTA = new SysDSTableAdapters.sysCustomerDataTableAdapter();
    private SysDSTableAdapters.sysLoginTimeTableAdapter sysLoginTimeTA = new SysDSTableAdapters.sysLoginTimeTableAdapter();

    private SysDS oSysDS;

    private DataRow[] rows;

    private string UserID;

    private mpSystem mp;

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

        if (sysLoginUserTA.GetDataByKey(e.Values["sUserID"].ToString().Trim()).Rows.Count > 0)
        {
            mp.Msg = "帳號重複";
            e.Cancel = true;
        }

        e.Values["bFirstChange"] = true;
        e.Values["iDayChange"] = 90;
        e.Values["iPwLen"] = 6;
        e.Values["iPwChange"] = 3;
        e.Values["iPwLock"] = 5;
        e.Values["iLockTime"] = 0;
        e.Values["bPwLock"] = false;
        e.Values["dRegDate"] = DateTime.Now;
        e.Values["sKeyMan"] = UserID;
        e.Values["dKeyDate"] = DateTime.Now;
    }

    protected void fv_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        gv.DataBind();
        mp.Msg = "新增完成";

        //新增到基本資料
        sysCustomerDataTA.Fill(oSysDS.sysCustomerData);
        rows = oSysDS.sysCustomerData.Select("sysLoginUser_sUserID = '" + e.Values["sUserID"].ToString() + "'");
        SysDS.sysCustomerDataRow rc;

        if (rows.Length > 0)
            rc = (SysDS.sysCustomerDataRow)rows[0];
        else
            rc = oSysDS.sysCustomerData.NewsysCustomerDataRow();

        rc.sysLoginUser_sUserID = e.Values["sUserID"].ToString();
        rc.sNameC = "";
        rc.dBirthday = new DateTime(1900, 1, 1);
        rc.bSex = true;
        rc.dRegDate = DateTime.Now;

        if (rows.Length == 0)
            oSysDS.sysCustomerData.AddsysCustomerDataRow(rc);

        sysCustomerDataTA.Update(oSysDS.sysCustomerData);
    }

    protected void fv_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        mpePopupFV.Show();

        e.NewValues["iDayChange"] = e.NewValues["iDayChange"].ToString().Trim().Length > 0 ? e.NewValues["iDayChange"] : e.OldValues["iDayChange"];
        e.NewValues["iPwLen"] = e.NewValues["iPwLen"].ToString().Trim().Length > 0 ? e.NewValues["iPwLen"] : e.OldValues["iPwLen"];
        e.NewValues["iPwChange"] = e.NewValues["iPwChange"].ToString().Trim().Length > 0 ? e.NewValues["iPwChange"] : e.OldValues["iPwChange"];
        e.NewValues["iPwLock"] = e.NewValues["iPwLock"].ToString().Trim().Length > 0 ? e.NewValues["iPwLock"] : e.OldValues["iPwLock"];
        e.NewValues["iLockTime"] = e.NewValues["iLockTime"].ToString().Trim().Length > 0 ? e.NewValues["iLockTime"] : e.OldValues["iLockTime"];
        e.NewValues["sKeyMan"] = UserID;
        e.NewValues["dKeyDate"] = DateTime.Now;
    }

    protected void fv_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        gv.DataBind();
        mp.Msg = "修改完成";
        gv.SelectedIndex = -1;
        mpePopupFV.Hide();

        //如果解除鎖定
        if ((Convert.ToBoolean(e.OldValues["bPwLock"]) != Convert.ToBoolean(e.NewValues["bPwLock"])) && !Convert.ToBoolean(e.NewValues["bPwLock"]))
        {
            SysDS.sysLoginTimeRow rlt = oSysDS.sysLoginTime.NewsysLoginTimeRow();
            rlt.sysLoginUser_sUserID = e.NewValues["sUserID"].ToString();
            rlt.sLoginIP = sa.UserInfo.GetClientIP();
            rlt.bLoginSuccess = true;
            rlt.dLoginTime = DateTime.Now;
            oSysDS.sysLoginTime.AddsysLoginTimeRow(rlt);
            sysLoginTimeTA.Update(oSysDS.sysLoginTime);
        }
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
        else if (cn == "sysCustomerData")
        {
            lblCustomerDataID.Text = ca;
            mpePopupCustomerData.Show();
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

    protected void btnExitCustomerData_Click(object sender, EventArgs e)
    {
        mpePopupCustomerData.Hide();
    }
    protected void fvCustomerData_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        mpePopupCustomerData.Show();

        e.NewValues["sKeyMan"] = UserID;
        e.NewValues["dKeyDate"] = DateTime.Now;
    }

    protected void fvCustomerData_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        mp.Msg = "修改完成";
    }
}
