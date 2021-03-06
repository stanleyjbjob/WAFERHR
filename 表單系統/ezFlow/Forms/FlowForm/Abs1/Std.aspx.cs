using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using System.Transactions;
using Bll.MT.Vdb;

public partial class Abs1_Std : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "Abs1";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            lblNobrAppM.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"].ToUpper() : lblNobrAppM.Text;
            lblProcessID.Text = Guid.NewGuid().ToString();  //產生一組暫存的序號
            lblAddGuid.Text = Guid.NewGuid().ToString();
            txtDateB.SelectedDate = DateTime.Now.Date;
            txtDateE.SelectedDate = DateTime.Now.Date;

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
            txtNameAgent_DataBind();

            txtHcode_DataBind();

            SetRoteTime(lblNobrAppM.Text, DateTime.Now.Date);
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
            Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);
            var rsDept = oDeptDao.GetDeptm();

            //特殊規則 75層級以下的 就抓到75的人向下 75以上的 採用本層
            Bll.Bas.Dept oDept = new Bll.Bas.Dept();
            string sDept = oDept.GetDeptByTree(lblDeptCodeAppM.Text, rsDept);

            Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
            var rsBas = oBasDao.GetBaseByNobr(lblNobrAppM.Text);
            var rsBasByDept = oBasDao.GetBaseByDept(sDept , "2");

            foreach (var rBasByDept in rsBasByDept)
                if (!rsBas.Where(p => p.Nobr == rBasByDept.Nobr).Any())
                    rsBas.Add(rBasByDept);

            txtNameAppS.DataSource = rsBas;
            txtNameAppS.DataTextField = "Name";
            txtNameAppS.DataValueField = "Nobr";
            txtNameAppS.DataBind();
        }
    }

    private void txtNameAgent_DataBind()
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);

        Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);
        var rsDept = oDeptDao.GetDeptm();

        string Dept = lblDeptCodeAppM.Text.Trim();
        var rDept = rsDept.Where(p => p.Code == Dept).FirstOrDefault();
        if (rDept != null && Dept == "3010")
            Dept = rDept.ParentCode;

        var rsBas = oBasDao.GetBaseByDept(Dept, "2");

        List<Bll.MT.Vdb.TextValueRow> rs = new List<Bll.MT.Vdb.TextValueRow>();
        Bll.MT.Vdb.TextValueRow r;

        foreach (var rBas in rsBas)
        {
            if (rBas.Nobr.Trim() != lblNobrAppS.Text.Trim())
            {
                r = new Bll.MT.Vdb.TextValueRow();
                r.Text = rBas.Name.Trim();
                r.Value = rBas.Nobr.Trim();
                rs.Add(r);
            }
        }

        r = new Bll.MT.Vdb.TextValueRow();
        r.Text = "吳凱仁,Kai,IOT00003";
        r.Value = "IOT00003";
        rs.Add(r);

        txtNameAgent1.DataSource = rs;
        txtNameAgent1.DataTextField = "Text";
        txtNameAgent1.DataValueField = "Value";
        txtNameAgent1.DataBind();
    }

    private void txtHcode_DataBind()
    {
        List<TextValueRow> Vdb = new List<TextValueRow>();

        TextValueRow rVdb;

        rVdb = new TextValueRow();
        rVdb.Text = "國內出差(台中以南)";
        rVdb.Value = "H4";// "H3-1";
        Vdb.Add(rVdb);

        rVdb = new TextValueRow();
        rVdb.Text = "國內出差(宜、花、東)";
        rVdb.Value = "H5";// "H3-2";
        Vdb.Add(rVdb);

        rVdb = new TextValueRow();
        rVdb.Text = "國外出差";
        rVdb.Value = "H1";
        Vdb.Add(rVdb);

        rVdb = new TextValueRow();
        rVdb.Text = "外出-業務";
        rVdb.Value = "H6";// "H3-3";
        Vdb.Add(rVdb);

        rVdb = new TextValueRow();
        rVdb.Text = "外出-代班";
        rVdb.Value = "H7";// "H3-4";
        Vdb.Add(rVdb);

        txtHcode.DataSource = Vdb;
        txtHcode.DataTextField = "Text";
        txtHcode.DataValueField = "Value";
        txtHcode.DataBind();

        txtHcode_SelectedIndexChanged(txtHcode, null);
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

            txtNameAppS.Enabled = rForm.bAgentApp;
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

        txtHcode_SelectedIndexChanged(null, null);
        txtNameAgent_DataBind();
    }
    #endregion

    private void SetRoteTime(string sNobr, DateTime dDate)
    {
        txtTimeB.Text = "0000";
        txtTimeE.Text = "0000";

        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var rAttend = oAttendDao.GetAttend(sNobr, dDate).FirstOrDefault();

        if (rAttend != null)
        {
            Dal.Dao.Att.RoteDao oRoteDao = new Dal.Dao.Att.RoteDao(dcHR.Connection);
            var rRote = oRoteDao.GetRoteDetail(new List<string>() { rAttend.RoteCode }).FirstOrDefault();

            if (rRote != null)
            {
                txtTimeB.Text = rRote.OnTime;

                if (rRote.OffTime.CompareTo("2400") >= 0)
                {
                    txtDateE.SelectedDate = txtDateE.SelectedDate.Value.AddDays(1);
                    txtTimeE.Text = (Convert.ToInt32(rRote.OffTime) - 2400).ToString("0000");
                }
                else
                    txtTimeE.Text = rRote.OffTime;
            }
        }
    }

    #region 代理人1工號及姓名
    protected void txtNameAgent1_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        SetName1(e.Text);
    }
    protected void txtNameAgent1_DataBound(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //    SetName1(lblNobrAppM.Text);
    }
    protected void txtNameAgent1_TextChanged(object sender, EventArgs e)
    {
        RadComboBox txt = sender as RadComboBox;
        RadComboBoxItem li = txt.SelectedItem;

        if (li != null)
            SetName1(li);
        else if (txtNameAgent1.Text.Trim().Length > 0)
            SetName1(txtNameAgent1.Text);
    }
    private void SetName1(RadComboBoxItem li)
    {
        if (li != null)
        {
            txtNameAgent1.ClearSelection();
            li.Selected = true;
            SetName1(li.Value);
        }
    }
    private void SetName1(string sNobr)
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBas = oBasDao.GetBase(sNobr).FirstOrDefault();

        if (rBas != null)
        {
            lblNobrAgent1.Text = rBas.Nobr;
            txtNameAgent1.Text = rBas.Name;
            txtNameAgent1.ToolTip = rBas.Name;
        }
        else
            txtNameAgent1.Text = txtNameAgent1.ToolTip;
    }
    #endregion

    protected void txtDateB_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        txtDateE.SelectedDate = txtDateB.SelectedDate.GetValueOrDefault(DateTime.Now).Date;
        SetRoteTime(lblNobrAppS.Text, txtDateB.SelectedDate.GetValueOrDefault(DateTime.Now).Date);
        txtHcode_SelectedIndexChanged(null, null);
    }

    protected void txtHcode_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        lblBalance.Text = "0";
        lblBalanceUnit.Text = "";

        string Nobr = lblNobrAppS.Text;
        DateTime DateB = txtDateB.SelectedDate.Value;
        string Hcode = txtHcode.SelectedItem != null ? txtHcode.SelectedItem.Value : "";

        //Hcode = Hcode.IndexOf("H3") != -1 ? "H3" : Hcode;

        //計算目前正在進行的流程時數
        var rsAppAbs = (from c in dcForm.wfAppAbs
                        where c.sNobr == Nobr
                        && c.sHcode == Hcode
                        && (c.sProcessID == lblProcessID.Text || (c.idProcess != 0 && c.sState == "1"))
                        select new Bll.Att.Vdb.AbsDataTable
                        {
                            DateB = c.dDateB.Date,
                            Hcode = c.sHcode,
                            Use = c.iUse.GetValueOrDefault(0),
                        }).ToList();

        Dal.Dao.Att.AbsDao oAbsDao = new Dal.Dao.Att.AbsDao(dcHR.Connection);
        //var rBalance = oAbsDao.GetBalanceNew(Nobr, DateB, Hcode, true, rsAppAbs).FirstOrDefault();

        var rBalance = oAbsDao.GetBalance(Nobr, DateB, "", null, null, null, null, true, rsAppAbs).Where(p => p.Hcode == Hcode).FirstOrDefault();

        Dal.Dao.Att.HcodeDao oHcodeDao = new Dal.Dao.Att.HcodeDao(dcHR.Connection);
        var rHcode = oHcodeDao.GetHocdeDetail(Hcode , false).FirstOrDefault();

        if (rHcode.CheckBalance)
        {
            if (rBalance != null)
            {
                lblBalance.Text = rBalance.Balance.ToString();
                lblBalanceUnit.Text = rBalance.HcodeUnit == Bll.MT.mtEnum.HcodeUnit.Day ? "天" : "小時";
            }
            else
            {
                lblBalance.Text = "沒有產生得假資料";
            }
        }
        else
            lblBalance.Text = "不用檢查";
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {

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

        if (txtDateB.SelectedDate == null || txtDateE.SelectedDate == null)
        {
            RadWindowManager1.RadAlert("您的開始或結束日期沒有輸入正確", 300, 100, "警告訊息", "", "");
            return;
        }

        //二擇一
        if (lblNobrAgent1.Text.Trim().Length == 0)
        {
            RadWindowManager1.RadAlert("您的代理人沒有輸入正確", 300, 100, "警告訊息", "", "");
            return;
        }

        string Nobr = lblNobrAppS.Text;
        string NobrAgent1 = lblNobrAgent1.Text;
        string Hcode = txtHcode.SelectedItem.Value;
        //Hcode = Hcode.IndexOf("H3") != -1 ? "H3" : Hcode;
        string HcodeName = txtHcode.SelectedItem.Text;
        DateTime DateB = txtDateB.SelectedDate.Value;
        DateTime DateE = txtDateE.SelectedDate.Value;
        string TimeB = txtTimeB.Text;
        string TimeE = txtTimeE.Text;
        string Note = txtNote.Text.Trim();
        string AgentNote = "";// txtNoteAgent.Text;

        if (Note.Length == 0)
        {
            RadWindowManager1.RadAlert("您的事由沒有輸入", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Att.HcodeDao oHcodeDao = new Dal.Dao.Att.HcodeDao(dcHR.Connection);
        var rHcode = oHcodeDao.GetHocdeDetail(Hcode, false).First();

        if (Nobr == NobrAgent1)
        {
            RadWindowManager1.RadAlert("代理人員與被申請人不可相同", 300, 100, "警告訊息", "", "");
            return;
        }

        //任何假要在5天內申請 暫時
        //if (DateB.Date.AddDays(5) < DateTime.Now.Date)
        //{
        //    RadWindowManager1.RadAlert("您請的假，沒有在5天內申請完畢，請洽人事單位", 300, 100, "警告訊息", "", "");
        //    return;
        //}

        Dal.Dao.Sal.SalaryLockDao oSalaryLockDao = new Dal.Dao.Sal.SalaryLockDao(dcHR.Connection);
        string YYMM = oSalaryLockDao.GetSalaryYymm(Nobr, DateB);

        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBasS = oBasDao.GetBaseByNobr(Nobr, DateTime.Now.Date).FirstOrDefault();

        var rSalaryLockBegin = oSalaryLockDao.GetSalaryLockBegin(DateB, DateE, rBasS.Saladr).Where(p => p.Date == DateB).FirstOrDefault();
        if (rSalaryLockBegin != null)
        {
            RadWindowManager1.RadAlert("您申請的日期，薪資已鎖檔，請洽人事單位", 300, 100, "警告訊息", "", "");
            return;
        }

        DateTime DateTimeB = DateB.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB));
        DateTime DateTimeE = DateE.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE));
        if (DateTimeB >= DateTimeE)
        {
            RadWindowManager1.RadAlert("您的開始日期時間不能大於或等於結束日期時間", 300, 100, "警告訊息", "", "");
            return;
        }

        int iTimeB = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB);
        int iTimeE = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE);
        int iTemp;

        //iTemp = iTimeB % 30;
        //iTimeB -= iTemp;
        //TimeB = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeB);

        //iTemp = (30 - (iTimeE % 30));
        //iTimeE = iTemp == 30 ? iTimeE : iTimeE + iTemp;
        //TimeE = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeE);

        //檢查重複的資料
        var lsAppS = (from c in dcForm.wfAppAbs
                      where (c.sProcessID == lblProcessID.Text || (c.idProcess != 0 && c.sState == "1"))
                      && c.sNobr == Nobr
                      select c).ToList();

        if (lsAppS.Where(c => c.dDateTimeB < DateTimeE && c.dDateTimeE > DateTimeB).Any())
        {
            RadWindowManager1.RadAlert("資料重複或流程正在進行中", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Att.AbsDao oAbsDao = new Dal.Dao.Att.AbsDao(dcHR.Connection);

        var rsAbs = oAbsDao.GetAbs(Nobr, DateB.AddDays(-1), DateE, false);
        if (rsAbs.Where(c => c.DateTimeB < DateTimeE && c.DateTimeE > DateTimeB).Any())
        {
            RadWindowManager1.RadAlert("人事資料重複", 300, 100, "警告訊息", "", "");
            return;
        }

        var Calculate = oAbsDao.GetCalculate(Nobr, Hcode, DateB, DateE, TimeB, TimeE, false, true, 0, false, "", true);

        if (Calculate.TotalUse <= 0)
        {
            RadWindowManager1.RadAlert("計算時數不可以為零", 300, 100, "警告訊息", "", "");
            return;
        }

        decimal iBalance = 0;

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

        var rBasAgent1 = oBasDao.GetBase(NobrAgent1).FirstOrDefault();

        ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);
        int iProcessID = oService.GetProcessID();

        var rs = new wfAppAbs();
        rs.sFormCode = _FormCode;
        rs.sProcessID = iProcessID.ToString();
        rs.idProcess = iProcessID;
        rs.sNobr = Nobr;
        rs.sName = rEmpS.EmpName;
        rs.sDept = rEmpS.DeptCode;
        rs.sDeptName = rEmpS.DeptName;
        rs.sJob = rEmpS.JobCode;
        rs.sJobName = rEmpS.JobName;
        rs.sRote = rBasS.Rotet;
        rs.sRole = rEmpS.RoleId;
        rs.dDateB = DateB;
        rs.dDateE = DateE;
        rs.sTimeB = TimeB;
        rs.sTimeE = TimeE;
        rs.dDateTimeB = DateTimeB;
        rs.dDateTimeE = DateTimeE;
        rs.sHcode = Hcode;
        rs.sHname = HcodeName;
        rs.iDay = 0;
        rs.iHour = 0;
        rs.iTotalDay = 0;
        rs.iTotalHour = 0;
        rs.iUse = Calculate.TotalUse;
        rs.iBalance = iBalance;
        rs.sUnit = rHcode.Unit == Bll.MT.mtEnum.HcodeUnit.Day ? "天" : "小時";
        rs.bExceptionHour = false;
        rs.iExceptionHour = 0;
        rs.sSalYYMM = YYMM;
        rs.bSign = true;
        rs.sState = "1";
        rs.sAgentNobr = NobrAgent1;
        rs.sAgentName = rBasAgent1 != null ? rBasAgent1.NameC + " " +rBasAgent1.NameE : "";
        rs.sAgentNote = AgentNote;
        rs.sReserve1 = rBasS.DeptsCode; //業務部女專
        rs.sGuid = Guid.NewGuid().ToString();
        rs.bAuth = rEmpS.Auth;
        rs.sNote = txtNote.Text;
        rs.dKeyDate = DateTime.Now;
        rs.sInfo = rs.sName + "," + rs.dDateB.ToShortDateString() + "," + rs.sTimeB + "~" + rs.dDateE.ToShortDateString() + "," + rs.sTimeE + ",請" + rs.sHname + rs.iUse.ToString() + rs.sUnit + "," + rs.sNote + "," + rs.sAgentNote;
        rs.sMailBody = MessageSendMail.AbsBody(rs.sNobr, rs.sName, rs.sDeptName, rs.sHname, rs.dDateB, rs.sTimeB, rs.dDateE, rs.sTimeE, rs.iUse.GetValueOrDefault(0), rs.sUnit, rs.sNote, rs.sAgentNote);
        dcForm.wfAppAbs.InsertOnSubmit(rs);

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

        var rBasM = oBasDao.GetBaseByNobr(lblNobrAppM.Text, DateTime.Now.Date).FirstOrDefault();
        var rsHcode = oHcodeDao.GetHocdeDetail();

        List<wfFormAppInfo> lsFormAppInfo = new List<wfFormAppInfo>();

        List<string> lsSendMail = new List<string>();
        lsSendMail.Add("");    //給主管審核用

        string sSubject = "【通知】(" + rs.sNobr + ")" + rs.sName + " 之公出單，請進入系統簽核";
        string sAgengSubject = "【通知】(" + rs.sNobr + ")" + rs.sName + " 之公出單，您是他的代理人";
        string sBody = "";
        string sInfo = rs.sInfo;

        sBody += rs.sMailBody;

        //當角色不同時，就將資料寫入ProcessFlowShare
        if (rEmpM.RoleId != rs.sRole)
            oService.FlowShare(rs.idProcess, rs.sRole, rs.sNobr);

        //代理人通知
        if (rs.sAgentNobr != null && rs.sAgentNobr.Trim().Length > 0)
        {
            var rAgent = (from c in dcFlow.Emp
                          where c.id == rs.sAgentNobr.Trim()
                          select c).FirstOrDefault();

            if (rAgent != null && rAgent.email.Trim().Length > 0)
                lsSendMail.Add(rAgent.email.Trim());
        }

        var rFormAppInfo = new wfFormAppInfo();
        rFormAppInfo.idProcess = iProcessID;
        rFormAppInfo.sProcessID = rFormAppInfo.idProcess.ToString();
        rFormAppInfo.sNobr = rs.sNobr;
        rFormAppInfo.sName = rs.sName;
        rFormAppInfo.sState = "1";
        rFormAppInfo.sInfo = sInfo;
        rFormAppInfo.sGuid = rs.sGuid;
        dcFlow.wfFormAppInfo.InsertOnSubmit(rFormAppInfo);

        foreach (var s in lsSendMail)
        {
            var rSendMail = new wfSendMail();
            rSendMail.sProcessID = iProcessID.ToString();
            rSendMail.idProcess = iProcessID;
            rSendMail.sGuid = Guid.NewGuid().ToString();
            rSendMail.sToAddress = s;
            rSendMail.sSubject = s == "" ? sSubject : sAgengSubject;
            rSendMail.sBody = sBody;
            rSendMail.bOnly = s != "";
            rSendMail.sKeyMan = lblNobrAppM.Text;
            rSendMail.dKeyDate = DateTime.Now;
            dcFlow.wfSendMail.InsertOnSubmit(rSendMail);
        }

        Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);
        var rsDept = oDeptDao.GetDeptm(rs.sDept);

        var rDept = rsDept.Where(p => p.Code == rs.sDept).FirstOrDefault();
        var sDay = rs.sUnit == "天" ? Convert.ToInt32(rs.iUse).ToString("00") : Convert.ToInt32(rs.iUse / 8).ToString("00");

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
        rAppM.bAuth = rs.bAuth;
        rAppM.bSign = true;
        rAppM.sInfo = sInfo;
        rAppM.sState = "1";
        rAppM.sConditions1 = "00"; //目前所簽核到的部門
        rAppM.sConditions2 = sDay;
        rAppM.sConditions3 = rs.sNobr;   //總經理直接離開
        rAppM.sConditions4 = rs.sHcode != "H1" ? "H3" : rs.sHcode;
        rAppM.sMailSubject = sSubject;
        rAppM.sMailBdoy = sBody;
        dcFlow.wfFormApp.InsertOnSubmit(rAppM);

        dcForm.SubmitChanges();
        dcFlow.SubmitChanges();

        string Url = FlowFrom.Tools.GetFlowImageUrl("Std", "", "", iProcessID.ToString());

        if (oService.FlowStart(iProcessID, lblFlowTreeID.Text, rs.sRole, rs.sNobr, lblRoleAppM.Text, lblNobrAppM.Text))
            Response.Redirect(Url);
        //RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '" + Url + "';", true);
        //RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + iProcessID.ToString() + "';", true);
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
            case "Absd":
                DialogPage = "Absd.aspx";

                string Date = txtDateB.SelectedDate.GetValueOrDefault(DateTime.Now.Date).ToShortDateString();
                string Hcode = txtHcode.SelectedItem.Value;

                DialogParmDetail += "&Date=" + Date + "&Hcode=" + Hcode;
                break;
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