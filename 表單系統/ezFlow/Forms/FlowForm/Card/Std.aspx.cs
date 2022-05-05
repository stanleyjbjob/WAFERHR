using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using System.Transactions;
public partial class Card_Std : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "Card";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblNobrAppM.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"].ToUpper() : lblNobrAppM.Text;
            lblProcessID.Text = Guid.NewGuid().ToString();  //產生一組暫存的序號
            lblAddGuid.Text = Guid.NewGuid().ToString();
            txtDate.SelectedDate = DateTime.Now.Date;
            txtTime.Text = "0800";

            if (User.Identity.IsAuthenticated && User.Identity.Name.Trim().Length > 0)
            {
                lblNobrAppM.Text = User.Identity.Name;
                Session["Emp_id"] = User.Identity.Name.Trim();
                Response.Cookies["ezFlow"]["Emp_id"] = User.Identity.Name.Trim();
                Response.Cookies["ezFlow"].Expires = DateTime.Now.AddDays(1);
            }

            lblNobrAppM.Text = lblNobrAppM.Text.Trim().Length == 0 ? " " : lblNobrAppM.Text;

            SetInfoAppM();
            SetDefault();

            txtNameAppS_DataBind();
            ddlReason_DataBind();
        }
    }

    #region 載入相關預設值
    private void SetInfoAppM()
    {
        var rEmpM = (from role in dcFlow.Role
                     join emp in dcFlow.Emp on role.Emp_id equals emp.id
                     join dept in dcFlow.Dept on role.Dept_id equals dept.id
                     join pos in dcFlow.Pos on role.Pos_id equals pos.id
                     where role.Emp_id == lblNobrAppM.Text
                     select new
                     {
                         RoleId = role.id,
                         EmpNobr = emp.id,
                         EmpName = emp.name,
                         DeptCode = dept.id,
                         DeptName = dept.name,
                         JobCode = pos.id,
                         JobName = pos.name,
                         Auth = role.deptMg.Value,
                     }).FirstOrDefault();

        if (rEmpM != null)
        {
            lblRoleAppM.Text = rEmpM.RoleId;
            lblNobrAppM.Text = rEmpM.EmpNobr;
            lblNameAppM.Text = rEmpM.EmpName;
            lblDeptCodeAppM.Text = rEmpM.DeptCode;
            lblDeptNameAppM.Text = rEmpM.DeptName;
            lblJobNameAppM.Text = rEmpM.JobName;
        }
    }

    private void txtNameAppS_DataBind()
    {
        if (lblDeptCodeAppM.Text.Trim().Length > 0)
        {
            Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
            var rBas = oBasDao.GetBaseByNobr(lblNobrAppM.Text, DateTime.Now.Date).FirstOrDefault();

            Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);
            var rsDept = oDeptDao.GetDeptm();

            //助理再往上一層
            if (rBas != null && rBas.Mang1)
            {
                var rDept = rsDept.Where(p => p.Code == lblDeptCodeAppM.Text).FirstOrDefault();
                if (rDept != null)
                    lblDeptCodeAppM.Text = rDept.ParentCode;
            }

            Bll.Bas.Dept oDept = new Bll.Bas.Dept();
            string sDept = oDept.GetDeptByTree(lblDeptCodeAppM.Text, rsDept);

            var rsBas = oBasDao.GetBaseByNobr(lblNobrAppM.Text, "2");
            var rsBasByDept = oBasDao.GetBaseByDept(sDept, "2");

            foreach (var rBasByDept in rsBasByDept)
                if (!rsBas.Where(p => p.Nobr == rBasByDept.Nobr).Any())
                    rsBas.Add(rBasByDept);

            txtNameAppS.DataSource = rsBas;
            txtNameAppS.DataTextField = "Name";
            txtNameAppS.DataValueField = "Nobr";
            txtNameAppS.DataBind();
        }
    }

    private void ddlReason_DataBind()
    {
        Dal.Dao.Att.CardLosdDao oCardLosdDao = new Dal.Dao.Att.CardLosdDao(dcHR.Connection);
        var rs = oCardLosdDao.GetData();

        ddlReason.DataSource = rs;
        ddlReason.DataTextField = "Name";
        ddlReason.DataValueField = "Code";
        ddlReason.DataBind();
    }

    private void SetDefault()
    {
        (Page.Master as mpStd1021202).sFormCode = _FormCode;
        (Page.Master as mpStd1021202).sAppNobr = lblNobrAppM.Text;

        var rForm = (from c in dcFlow.wfForm
                     where c.sFormCode == _FormCode
                     select c).FirstOrDefault();

        if (rForm != null)
        {
            lblFlowTreeID.Text = rForm.sFlowTree;
            lblNote.Text = rForm.sStdNote;
            Title = rForm.sFormName;
        }
    }
    #endregion

    #region 申請人工號及姓名
    protected void txtNameAppS_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        SetName(e.Text);
    }
    protected void txtNameAppS_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
            SetName(lblNobrAppM.Text);
    }
    protected void txtNameAppS_TextChanged(object sender, EventArgs e)
    {
        RadComboBox txt = sender as RadComboBox;
        RadComboBoxItem li = txt.SelectedItem;

        if (li != null)
            SetName(li);
        else if (txtNameAppS.Text.Trim().Length > 0)
            SetName(txtNameAppS.Text);
    }
    private void SetName(RadComboBoxItem li)
    {
        if (li != null)
        {
            txtNameAppS.ClearSelection();
            li.Selected = true;
            SetName(li.Value);
        }
    }
    private void SetName(string sNobr)
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBas = oBasDao.GetBase(sNobr).FirstOrDefault();

        if (rBas != null)
        {
            lblNobrAppS.Text = rBas.Nobr;
            txtNameAppS.Text = rBas.Name;
            txtNameAppS.ToolTip = rBas.Name;
        }
        else
            txtNameAppS.Text = txtNameAppS.ToolTip;
    }
    #endregion

    protected void gvAppS_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        var rs = (from c in dcForm.wfAppCard
                  where c.sProcessID == lblProcessID.Text
                  select c).ToList();

        gvAppS.DataSource = rs;
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string Nobr = lblNobrAppS.Text;
        DateTime Date = txtDate.SelectedDate.GetValueOrDefault(DateTime.Now);
        string Time = txtTime.Text.Trim();
        string Reason = ddlReason.SelectedItem.Value;
        string ReasonName = ddlReason.SelectedItem.Text;
        string Note = txtNote.Text;

        if (Time.Length != 4)
        {
            RadWindowManager1.RadAlert("時間格式不正確", 300, 100, "警告訊息", "", "");
            return;
        }

        if (Convert.ToInt32(Time) >= 2400)
        {
            RadWindowManager1.RadAlert("刷卡時間是採用24小時制，請輸入正確", 300, 100, "警告訊息", "", "");
            return;
        }

        if (Note.Length == 0)
        {
            RadWindowManager1.RadAlert("您的原因沒有輸入", 300, 100, "警告訊息", "", "");
            return;
        }

        var rsAppS = (from c in dcForm.wfAppCard
                      where (c.sProcessID == lblProcessID.Text || (c.idProcess != 0 && c.sState == "1"))
                      && c.sNobr == Nobr
                      select c).ToList();

        //檢查重複的資料
        var rS = (from c in rsAppS
                  where (c.sProcessID == lblProcessID.Text || (c.idProcess != 0 && c.sState == "1"))
                  && c.dDate == Date
                  && c.sTime == Time
                  select c).ToList();

        if (rS.Any())
        {
            RadWindowManager1.RadAlert("資料重複或流程正在進行中", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Att.CardDao oCardDao = new Dal.Dao.Att.CardDao(dcHR.Connection);
        var rCard = oCardDao.GetData(Nobr, Date, Time).FirstOrDefault();

        if (rCard != null)
        {
            RadWindowManager1.RadAlert("人事單位已有重複的資料", 300, 100, "警告訊息", "", "");
            return;
        }

        DateTime DateB = Date;
        DateTime DateE = Date;
        string TimeB = Time;
        string TimeE = Time;

        //判定是否有超過三次

        //借用加班的24轉48來判定日期
        Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(dcHR.Connection);
        oOtDao.ConvertTime24To48(Nobr, ref DateB, ref DateE, ref TimeB, ref TimeE);

        Dal.Dao.Sal.SalaryLockDao oSalaryLockDao = new Dal.Dao.Sal.SalaryLockDao(dcHR.Connection);
        var TwoDate = oSalaryLockDao.GetSalDate(DateB);

        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var lsDate = oAttendDao.GetAttendByForget(Nobr, TwoDate.DateA, TwoDate.DateD);

        if (!lsDate.Contains(DateB))
            lsDate.Add(DateB);

        foreach (var r in rsAppS)
        {
            DateB = r.dDate;
            DateE = r.dDate;
            TimeB = r.sTime;
            TimeE = r.sTime;

            oOtDao.ConvertTime24To48(Nobr, ref DateB, ref DateE, ref TimeB, ref TimeE);

            if (!lsDate.Contains(DateB))
                lsDate.Add(DateB);
        }

        var rEmpS = (from role in dcFlow.Role
                     join emp in dcFlow.Emp on role.Emp_id equals emp.id
                     join dept in dcFlow.Dept on role.Dept_id equals dept.id
                     join pos in dcFlow.Pos on role.Pos_id equals pos.id
                     where role.Emp_id == Nobr
                     select new
                     {
                         RoleId = role.id,
                         EmpNobr = emp.id,
                         EmpName = emp.name,
                         DeptCode = dept.id,
                         DeptName = dept.name,
                         JobCode = pos.id,
                         JobName = pos.name,
                         Auth = role.deptMg.Value,
                     }).FirstOrDefault();

        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBasS = oBasDao.GetBaseByNobr(Nobr, DateTime.Now.Date).FirstOrDefault();

        var rs = new wfAppCard();
        rs.sFormCode = _FormCode;
        rs.sProcessID = lblProcessID.Text;
        rs.idProcess = 0;
        rs.sNobr = Nobr;
        rs.sName = rEmpS.EmpName;
        rs.sDept = rEmpS.DeptCode;
        rs.sDeptName = rEmpS.DeptName;
        rs.sJob = rEmpS.JobCode;
        rs.sJobName = rEmpS.JobName;
        rs.sRote = rBasS.Rotet;
        rs.sRole = rEmpS.RoleId;
        rs.dDate = Date;
        rs.sTime = Time;
        rs.dDateTime = Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(Time));
        rs.sReasonCode = Reason;
        rs.sReasonName = ReasonName;
        rs.bSign = true;
        rs.sState = "0";
        rs.bAuth = rEmpS.Auth;
        rs.sNote = txtNote.Text;
        rs.dKeyDate = DateTime.Now;
        rs.sInfo = rs.sName + "," + rs.dDate.ToShortDateString() + "," + rs.sTime + "," + rs.sNote;
        rs.sMailBody = MessageSendMail.CardBoy(rs.sNobr, rs.sName, rs.sDeptName, rs.dDate, rs.sTime, rs.sNote);
        rs.sGuid = Guid.NewGuid().ToString();
        dcForm.wfAppCard.InsertOnSubmit(rs);

        dcForm.SubmitChanges();

        gvAppS.Rebind();

        lblAddGuid.Text = Guid.NewGuid().ToString();
    }

    protected void gvAppS_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Del" || cn == "Upload")
        {
            var r = (from c in dcForm.wfAppCard
                     where c.iAutoKey == Convert.ToInt32(ca)
                     select c).FirstOrDefault();

            if (r != null)
            {
                if (cn == "Del")
                {
                    var rsF = (from c in dcFlow.wfFormUploadFile
                               where c.sKey == r.sGuid
                               select c).ToList();

                    using (TransactionScope scope = new TransactionScope())
                    {
                        try
                        {
                            foreach (var rF in rsF)
                            {
                                string FN = Server.MapPath("~/Upload/" + rF.sServerName);
                                FileInfo fi = new FileInfo(FN);

                                if (fi.Exists)
                                    fi.Delete();
                            }

                            dcFlow.wfFormUploadFile.DeleteAllOnSubmit(rsF);
                            dcForm.wfAppCard.DeleteOnSubmit(r);

                            dcFlow.SubmitChanges();
                            dcForm.SubmitChanges();

                            scope.Complete();
                        }
                        catch (Exception ex)
                        {
                            RadWindowManager1.RadAlert("刪除失敗", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
                            scope.Dispose();
                        }
                    }

                    gvAppS.Rebind();
                }
                else if (cn == "Upload")
                {
                    Dialog(cn, lblNobrAppM.Text, lblNobrAppS.Text, lblProcessID.Text, r.sGuid);
                }
            }
        }
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        var rSysVar = (from c in dcFlow.SysVar
                       select c).FirstOrDefault();
        if (rSysVar == null || rSysVar.sysClose == null || rSysVar.sysClose.Value)
        {
            RadWindowManager1.RadAlert("系統維護中，請稍後再送出表單", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
            return;
        }

        string sProcessID = lblProcessID.Text;

        var rsApp = (from c in dcForm.wfAppCard
                     where c.sProcessID == sProcessID
                     select c).ToList();

        var gAppS = (rsApp.GroupBy(p => new { p.sNobr })).ToList();

        if (!gAppS.Any())
        {
            RadWindowManager1.RadAlert("您並未申請任何資料，請先申請至少一筆資料", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
            return;
        }

        var rEmpM = (from role in dcFlow.Role
                     join emp in dcFlow.Emp on role.Emp_id equals emp.id
                     join dept in dcFlow.Dept on role.Dept_id equals dept.id
                     join pos in dcFlow.Pos on role.Pos_id equals pos.id
                     where role.Emp_id == lblNobrAppM.Text
                     select new
                     {
                         RoleId = role.id,
                         EmpNobr = emp.id,
                         EmpName = emp.name,
                         DeptCode = dept.id,
                         DeptName = dept.name,
                         JobCode = pos.id,
                         JobName = pos.name,
                         Auth = role.deptMg.Value,
                     }).FirstOrDefault();

        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBasM = oBasDao.GetBaseByNobr(lblNobrAppM.Text, DateTime.Now.Date).FirstOrDefault();

        var lsNobr = rsApp.Select(p => p.sNobr).Distinct().ToList();

        var rsEmp = (from c in dcFlow.Emp
                     where lsNobr.Contains(c.id)
                     select c).ToList();

        List<string> lsDept = rsApp.Select(p => p.sDept).Distinct().ToList();
        Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);
        var rsDept = oDeptDao.GetDeptm(lsDept, new List<string>() { });

        ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

        List<wfFormAppInfo> lsFormAppInfo = new List<wfFormAppInfo>();

        int x = 0, y = 0;
        int iProcessID = 0;
        foreach (var rsAppS in gAppS)
        {
            string sSubject = "【通知】(" + rsAppS.First().sNobr + ")" + rsAppS.First().sName + " 之忘刷單，請進入系統簽核";
            string sBody = "";

            iProcessID = oService.GetProcessID();
            string sInfo = "";

            foreach (var rAppS in rsAppS)
            {
                sBody += rAppS.sMailBody;

                rAppS.sProcessID = iProcessID.ToString();
                rAppS.idProcess = iProcessID;
                rAppS.sState = "1"; //開始

                //當角色不同時，就將資料寫入ProcessFlowShare
                if (rEmpM.RoleId != rAppS.sRole)
                    oService.FlowShare(rAppS.idProcess, rAppS.sRole, rAppS.sNobr);

                sInfo += rAppS.sInfo + "<BR>";

                var rFormAppInfo = new wfFormAppInfo();
                rFormAppInfo.idProcess = iProcessID;
                rFormAppInfo.sProcessID = rFormAppInfo.idProcess.ToString();
                rFormAppInfo.sNobr = rAppS.sNobr;
                rFormAppInfo.sName = rAppS.sName;
                rFormAppInfo.sState = "1";
                rFormAppInfo.sInfo = sInfo;
                rFormAppInfo.sGuid = rAppS.sGuid;
                //lsFormAppInfo.Add(rFormAppInfo);
                dcFlow.wfFormAppInfo.InsertOnSubmit(rFormAppInfo);
            }

            var rSendMail = new wfSendMail();
            rSendMail.sProcessID = iProcessID.ToString();
            rSendMail.idProcess = iProcessID;
            rSendMail.sGuid = Guid.NewGuid().ToString();
            rSendMail.sToAddress = "";
            rSendMail.sSubject = sSubject;
            rSendMail.sBody = sBody;
            rSendMail.bOnly = false;
            rSendMail.sKeyMan = lblNobrAppM.Text;
            rSendMail.dKeyDate = DateTime.Now;
            dcFlow.wfSendMail.InsertOnSubmit(rSendMail);

            var rDept = rsDept.Where(p => p.Code == rsAppS.First().sDept).FirstOrDefault();

            var rAppM = new wfFormApp();
            rAppM.sFormCode = _FormCode;
            rAppM.sFormName = "";
            rAppM.sProcessID = iProcessID.ToString();
            rAppM.idProcess = iProcessID;
            rAppM.sNobr = lblNobrAppM.Text;
            rAppM.sName = rBasM.NameC;
            rAppM.sDept = rBasM.DeptmCode;
            rAppM.sDeptName = rBasM.DeptmName;
            rAppM.sJob = rBasM.JobCode;
            rAppM.sJobName = rBasM.JobName;
            rAppM.sRole = rEmpM.RoleId;
            rAppM.iCateOrder = rDept != null ? Convert.ToInt32(rDept.Tree) : 0;    //被申請者的部門層級
            rAppM.bDelay = false;  //是否有延遲需要補單
            rAppM.dDateTimeA = DateTime.Now;
            rAppM.bAuth = rsAppS.First().bAuth;
            rAppM.bSign = true;
            rAppM.sInfo = sInfo;
            rAppM.sState = "1";
            rAppM.sConditions1 = rAppM.iCateOrder.ToString(); //目前所簽核到的部門
            rAppM.sMailSubject = sSubject;
            rAppM.sMailBdoy = sBody;
            dcFlow.wfFormApp.InsertOnSubmit(rAppM);

            dcForm.SubmitChanges();
            dcFlow.SubmitChanges();

            x++;
            if (oService.FlowStart(iProcessID, lblFlowTreeID.Text, rsAppS.First().sRole, rsAppS.First().sNobr, lblRoleAppM.Text, lblNobrAppM.Text))
                y++;
        }

        if (x == y && y > 0)
            RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + iProcessID.ToString() + "';", true);
        else if (y > 0)
            RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "alert('流程傳送成功 但有部份流程失敗');self.location = '../../FlowImage/Output.aspx?idProcess=" + iProcessID.ToString() + "';", true);
        else
            RadWindowManager1.RadAlert("流程傳送失敗", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
    }
    protected void Dialog_Click(object sender, EventArgs e)
    {
        RadButton btn = sender as RadButton;
        if (btn != null)
        {
            string cn = btn.CommandName;

            Dialog(cn, lblNobrAppM.Text, lblNobrAppS.Text, lblProcessID.Text, lblAddGuid.Text);
        }
    }

    private void Dialog(string Case, string NobrM = "", string NobrS = "", string ProcessID = "", string Key1 = "", string Key2 = "")
    {
        string DialogPage = "";

        string ValidateKey = Guid.NewGuid().ToString();

        //string DialogParm = "Nobr=" + Nobr + "&ValidateKey=" + ValidateKey + "&Key=" + Key + "&FormCode=" + _FormCode;
        //string DialogParmDetail = "";

        string DialogParm = "NobrM=" + NobrM + "&NobrS=" + NobrS + "&ValidateKey=" + ValidateKey + "&ProcessID=" + ProcessID + "&Key1=" + Key1 + "&Key2=" + Key2 + "&FormCode=" + _FormCode + "&Std=1";
        string DialogParmDetail = "";

        switch (Case)
        {
            case "Flow":
                DialogPage = "../MT/Flow.aspx";

                break;
            case "Calendar":
                DialogPage = "../MT/Calendar.aspx";

                break;
            case "Upload":
                DialogPage = "../MT/Upload.aspx";

                break;
            default:
                break;
        }

        DialogParm = Bll.Tools.Decryption.Encrypt(DialogParm + DialogParmDetail);

        var r = new wfWebValidate();
        r.sValidateKey = ValidateKey;
        r.dDateWriter = DateTime.Now;
        r.sParm = DialogParm;
        dcFlow.wfWebValidate.InsertOnSubmit(r);
        dcFlow.SubmitChanges();

        RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "window.radopen('" + DialogPage + "?Parm=" + DialogParm + "', 'rwMT');", true);
    }
}

