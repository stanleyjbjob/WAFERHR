using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.IO;
using System.Transactions;

public partial class Abs_Std : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "Abs";

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

            txtTime_DataBind();

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

    private void txtTime_DataBind()
    {
        List<Bll.MT.Vdb.TextValueRow> rs;
        Bll.MT.Vdb.TextValueRow r;

        rs = new List<Bll.MT.Vdb.TextValueRow>();

        r = new Bll.MT.Vdb.TextValueRow();
        r.Text = "09:00";
        r.Value = "0900";
        rs.Add(r);

        r = new Bll.MT.Vdb.TextValueRow();
        r.Text = "13:00";
        r.Value = "1300";
        rs.Add(r);

        txtTimeB.DataSource = rs;
        txtTimeB.DataTextField = "Text";
        txtTimeB.DataValueField = "Value";
        txtTimeB.DataBind();

        rs = new List<Bll.MT.Vdb.TextValueRow>();

        r = new Bll.MT.Vdb.TextValueRow();
        r.Text = "12:00";
        r.Value = "1200";
        rs.Add(r);

        r = new Bll.MT.Vdb.TextValueRow();
        r.Text = "17:30";
        r.Value = "1730";
        rs.Add(r);

        txtTimeE.DataSource = rs;
        txtTimeE.DataTextField = "Text";
        txtTimeE.DataValueField = "Value";
        txtTimeE.DataBind();
    }

    private void txtHcode_DataBind()
    {
        Dal.Dao.Att.HcodeDao oHcodeDao = new Dal.Dao.Att.HcodeDao(dcHR.Connection);
        var rsHcode = oHcodeDao.GetHocde();

        txtHcode.DataSource = rsHcode;
        txtHcode.DataTextField = "NameC";
        txtHcode.DataValueField = "Code";
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

        SetRoteTime(lblNobrAppS.Text, txtDateB.SelectedDate.GetValueOrDefault(DateTime.Now.Date));
        txtNameAgent_DataBind();
    }
    #endregion

    private void SetRoteTime(string sNobr, DateTime dDate)
    {
        txtTimeB.ClearSelection();
        txtTimeE.ClearSelection();

        if (txtTimeB.Items.FindItemByValue("0900") != null)
            txtTimeB.Items.FindItemByValue("0900").Selected = true;
        if (txtTimeE.Items.FindItemByValue("1730") != null)
            txtTimeE.Items.FindItemByValue("1730").Selected = true;

        //Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        //var rAttend = oAttendDao.GetAttend(sNobr, dDate).FirstOrDefault();

        //if (rAttend != null)
        //{
        //    Dal.Dao.Att.RoteDao oRoteDao = new Dal.Dao.Att.RoteDao(dcHR.Connection);
        //    var rRote = oRoteDao.GetRoteDetail(new List<string>() { rAttend.RoteCode }).FirstOrDefault();

        //    if (rRote != null)
        //    {
        //        txtTimeB.Text = rRote.OnTime;

        //        if (rRote.OffTime.CompareTo("2400") >= 0)
        //        {
        //            txtDateE.SelectedDate = txtDateE.SelectedDate.Value.AddDays(1);
        //            txtTimeE.Text = (Convert.ToInt32(rRote.OffTime) - 2400).ToString("0000");
        //        }
        //        else
        //            txtTimeE.Text = rRote.OffTime;
        //    }
        //}
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
        string Hcode =txtHcode.SelectedItem != null ?  txtHcode.SelectedItem.Value : "";

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

        var rBalance = oAbsDao.GetBalance(Nobr, DateB , "" , null , null , null , null , true , rsAppAbs).Where(p => p.Hcode == Hcode).FirstOrDefault();

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

    protected void gvAppS_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        var rs = (from c in dcForm.wfAppAbs
                  where c.sProcessID == lblProcessID.Text
                  select c).ToList();

        gvAppS.DataSource = rs;
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        if (txtDateB.SelectedDate == null || txtDateE.SelectedDate == null)
        {
            RadWindowManager1.RadAlert("您的開始或結束日期沒有輸入正確", 300, 100, "警告訊息", "", "");
            return;
        }

        string Nobr = lblNobrAppS.Text;
        string NobrAgent1 = lblNobrAgent1.Text;
        string Hcode = txtHcode.SelectedItem.Value;
        DateTime DateB = txtDateB.SelectedDate.Value;
        DateTime DateE = txtDateE.SelectedDate.Value;
        string TimeB = txtTimeB.SelectedItem.Value;
        string TimeE = txtTimeE.SelectedItem.Value;
        string Note = txtNote.Text.Trim();
        string AgentNote = "";// txtNoteAgent.Text;

        if (Note.Length == 0)
        {
            RadWindowManager1.RadAlert("您的請假原因沒有輸入", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Att.HcodeDao oHcodeDao = new Dal.Dao.Att.HcodeDao(dcHR.Connection);
        var rHcode = oHcodeDao.GetHocdeDetail(Hcode).First();

        if (txtNameAgent1.Items.Count > 1)
        {
            //二擇一
            if (lblNobrAgent1.Text.Trim().Length == 0)
            {
                RadWindowManager1.RadAlert("您的代理人沒有輸入正確", 300, 100, "警告訊息", "", "");
                return;
            }

            if (Nobr == NobrAgent1)
            {
                RadWindowManager1.RadAlert("代理與被申請人不可相同", 300, 100, "警告訊息", "", "");
                return;
            }
        }

        DateTime DateTimeB = DateB.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB));
        DateTime DateTimeE = DateE.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE));
        if (DateTimeB >= DateTimeE)
        {
            RadWindowManager1.RadAlert("您的開始日期時間不能大於或等於結束日期時間", 300, 100, "警告訊息", "", "");
            return;
        }

        if (DateTime.Now.Date.AddMonths(2) < DateTimeB)
        {
            RadWindowManager1.RadAlert("您所申請的日期不可以大於2個月之後，請洽人事單位", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Sal.SalaryLockDao oSalaryLockDao = new Dal.Dao.Sal.SalaryLockDao(dcHR.Connection);
        string YYMM = oSalaryLockDao.GetSalaryYymm(Nobr, DateB);

        //病假可於三天內補請，生理假可次日。其他假別最晚於當日請（可請未來及當日的假）。
        //if (DateB.Date < DateTime.Now.Date)
        //{
        //    bool bError = true;

        //    //病假可於三天內補請
        //    if (Hcode == "C" && DateB.Date.AddDays(3) >= DateTime.Now.Date)
        //        bError = false;

        //    //生理假可次日
        //    if (Hcode == "13" && DateB.Date.AddDays(1) >= DateTime.Now.Date)
        //        bError = false;

        //    if (bError)
        //    {
        //        //RadWindowManager1.RadAlert("病假可於三天內補請，生理假可次日。其他假別最晚於當日請", 300, 100, "警告訊息", "", "");
        //        //return;
        //    }
        //}

        //任何假要在5天內申請 暫時
        //if (DateB.Date.AddDays(5) < DateTime.Now.Date)
        //{
        //    RadWindowManager1.RadAlert("您請的假，沒有在5天內申請完畢，請洽人事單位", 300, 100, "警告訊息", "", "");
        //    return;
        //}

        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBasS = oBasDao.GetBaseByNobr(Nobr, DateTime.Now.Date).FirstOrDefault();

        var rSalaryLockBegin = oSalaryLockDao.GetSalaryLockBegin(DateB, DateE, rBasS.Saladr).Where(p => p.Date == DateB).FirstOrDefault();
        if (rSalaryLockBegin != null)
        {
            RadWindowManager1.RadAlert("您申請的日期，薪資已鎖檔，請洽人事單位", 300, 100, "警告訊息", "", "");
            return;
        }

        if (Hcode == "E")
            DateE = DateB.AddDays(55);

        if (Hcode == "C1")
        {
            if (DateB.Date != DateE.Date)
            {
                RadWindowManager1.RadAlert("生理假不可以跨天請", 300, 100, "警告訊息", "", "");
                return;
            }

            DateTime dDateA = new DateTime(DateB.Year, DateB.Month, 26);   //預設以請假當月1日為準
            DateTime dDateD = new DateTime(DateB.AddMonths(1).Year, DateB.AddMonths(1).Month, 25);

            var rSalaryMonthDay = oSalaryLockDao.GetSalaryMonthDay().FirstOrDefault();

            if (rSalaryMonthDay != null)
                if (DateB.Day < rSalaryMonthDay.Day)
                {
                    dDateA = new DateTime(DateB.AddMonths(-1).Year, DateB.AddMonths(-1).Month, 26);   //預設以請假當月1日為準
                    dDateD = new DateTime(DateB.Year, DateB.Month, 25);
                }

            //檢查重複的資料
            var dtApp = from c in dcForm.wfAppAbs
                        where (c.sProcessID == lblProcessID.Text || (c.idProcess != 0 && c.sState == "1"))
                        && c.sNobr == Nobr
                        && c.sHcode == Hcode
                        && c.dDateB.Date >= dDateA.Date
                        && c.dDateB.Date <= dDateD.Date
                        select c;

            if (dtApp.Any())
            {
                RadWindowManager1.RadAlert("同月份不可申請兩筆生理假(包含流程進行中)", 300, 100, "警告訊息", "", "");
                return;
            }
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
        var rsAppS = (from c in dcForm.wfAppAbs
                      where (c.sProcessID == lblProcessID.Text || (c.idProcess != 0 && c.sState == "1"))
                      && c.sNobr == Nobr
                      select c).ToList();

        if (rsAppS.Where(c => c.dDateTimeB < DateTimeE && c.dDateTimeE > DateTimeB).Any())
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

        var Calculate = oAbsDao.GetCalculate(Nobr, Hcode, DateB, DateE, TimeB, TimeE, true, true, 0, false, "", true);

        if (Calculate.TotalUse <= 0)
        {
            RadWindowManager1.RadAlert("計算時數不可以為零", 300, 100, "警告訊息", "", "");
            return;
        }

        decimal iBalance = 0;

        //檢查剩餘時數
        if (rHcode.CheckBalance)
        {
            //計算目前正在進行的流程時數
            var rsAppSWhere = (from c in rsAppS
                               where c.sHcode == Hcode
                               select new Bll.Att.Vdb.AbsDataTable
                               {
                                   DateB = c.dDateB.Date,
                                   Hcode = c.sHcode,
                                   Use = c.iUse.GetValueOrDefault(0),
                               }).ToList();

            DateTime DateB1 = DateB;
            DateTime DateE1 = DateB;
            string TimeB1 = TimeB;
            string TimeE1 = TimeE;

            oAbsDao.ConvertTime24To48(Nobr, ref DateB1, ref DateE1, ref TimeB1, ref TimeE1);

            //var rBalance = oAbsDao.GetBalanceNew(Nobr, DateB1, Hcode, true, rsAppSWhere).FirstOrDefault();
            var rBalance = oAbsDao.GetBalance(Nobr, DateB1 , "" , null , null , null , null , true , rsAppSWhere).Where(p => p.Hcode == Hcode).FirstOrDefault();

            if (rBalance == null || (rBalance.Balance - Calculate.TotalUse) < 0 || (rBalance.BalanceGroup - Calculate.TotalUse) < 0)
            {
                RadWindowManager1.RadAlert("剩餘時數不足(包含流程進行中)", 300, 100, "警告訊息", "", "");
                return;
            }

            iBalance = rBalance.Balance;
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

        var rBasAgent1 = oBasDao.GetBase(NobrAgent1).FirstOrDefault();

        var rs = new wfAppAbs();
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
        rs.dDateB = DateB;
        rs.dDateE = DateE;
        rs.sTimeB = TimeB;
        rs.sTimeE = TimeE;
        rs.dDateTimeB = DateTimeB;
        rs.dDateTimeE = DateTimeE;
        rs.sHcode = Hcode;
        rs.sHname = rHcode.NameC;
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
        rs.sState = "0";
        rs.sAgentNobr = NobrAgent1;
        rs.sAgentName = rBasAgent1 != null ? rBasAgent1.NameC + " " + rBasAgent1.NameE : "";
        rs.sAgentNote = AgentNote;
        rs.sReserve1 = rBasS.DeptsCode; //業務部女專
        rs.sGuid = Guid.NewGuid().ToString();
        rs.bAuth = rEmpS.Auth;
        rs.sNote = txtNote.Text;
        rs.dKeyDate = DateTime.Now;
        rs.sInfo = rs.sName + "," + rs.dDateB.ToShortDateString() + "," + rs.sTimeB + "~" + rs.dDateE.ToShortDateString() + "," + rs.sTimeE + ",請" + rs.sHname + rs.iUse.ToString() + rs.sUnit + "," + rs.sNote + "," + rs.sAgentNote;
        rs.sMailBody = MessageSendMail.AbsBody(rs.sNobr, rs.sName, rs.sDeptName, rs.sHname, rs.dDateB, rs.sTimeB, rs.dDateE, rs.sTimeE, rs.iUse.GetValueOrDefault(0), rs.sUnit, rs.sNote, rs.sAgentNote);
        dcForm.wfAppAbs.InsertOnSubmit(rs);

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
            var r = (from c in dcForm.wfAppAbs
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
                            dcForm.wfAppAbs.DeleteOnSubmit(r);

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

        var rsApp = (from c in dcForm.wfAppAbs
                     where c.sProcessID == sProcessID
                     select c).ToList();

        var gAppS = (rsApp.GroupBy(p => new { p.sNobr, p.sHcode })).ToList();

        var rsFile = (from c in dcFlow.wfFormUploadFile
                      where c.sProcessID == sProcessID
                      select c).ToList();

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

        Dal.Dao.Att.HcodeDao oHcodeDao = new Dal.Dao.Att.HcodeDao(dcHR.Connection);
        var rsHcode = oHcodeDao.GetHocdeDetail();

        //某些假別要判斷是否上傳附件(客制需求)
        bool bFilePass = true;

        foreach (var rAppS in rsApp)
        {
            var rHcode = rsHcode.Where(p => p.CheckUploadFlie && p.Code == rAppS.sHcode).FirstOrDefault();
            if (rHcode != null)
            {
                var rFile = rsFile.Where(p => p.sKey == rAppS.sGuid).FirstOrDefault();
                if (rFile == null)
                    bFilePass = false;
            }
        }

        var lsNobr = rsApp.Select(p => p.sNobr).Distinct().ToList();

        var rsAppAgent = (from c in dcForm.wfAppAgent
                          where lsNobr.Contains(c.sNobr)
                          select c).ToList();

        lsNobr = rsApp.Select(p => p.sAgentNobr).Distinct().ToList();
        lsNobr = lsNobr.Union(rsApp.Select(p => p.sAgentNobr2).Distinct().ToList()).Distinct().ToList();

        var rsEmp = (from c in dcFlow.Emp
                     where lsNobr.Contains(c.id)
                     select c).ToList();

        if (!bFilePass)
        {
            RadWindowManager1.RadAlert("某些假別需要上傳附件", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
            return;
        }

        List<string> arrNobr = new List<string>();
        arrNobr.Add("102063");
        arrNobr.Add("192009");

        List<string> lsDept = rsApp.Select(p => p.sDept).Distinct().ToList();
        Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);
        var rsDept = oDeptDao.GetDeptm(lsDept, new List<string>() { });

        ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

        List<wfFormAppInfo> lsFormAppInfo = new List<wfFormAppInfo>();

        int x = 0, y = 0;
        int iProcessID = 0;
        foreach (var rsAppS in gAppS)
        {
            List<string> lsSendMail = new List<string>();
            lsSendMail.Add("");    //給主管審核用

            string sSubject = "【通知】(" + rsAppS.First().sNobr + ")" + rsAppS.First().sName + " 之請假單，請進入系統簽核";
            string sAgengSubject = "【通知】(" + rsAppS.First().sNobr + ")" + rsAppS.First().sName + " 之請假單，您是他的代理人";
            string sBody = "";

            iProcessID = oService.GetProcessID();
            string sInfo = "";

            foreach (var rAppS in rsAppS)
            {
                sBody += rAppS.sMailBody;

                //更改附檔流程序號
                var rsFileWhere = rsFile.Where(p => p.sKey == rAppS.sGuid);
                foreach (var rFileWhere in rsFileWhere)
                {
                    rFileWhere.sProcessID = iProcessID.ToString();
                    rFileWhere.idProcess = iProcessID;
                }

                rAppS.sProcessID = iProcessID.ToString();
                rAppS.idProcess = iProcessID;
                rAppS.sState = "1"; //開始

                //當角色不同時，就將資料寫入ProcessFlowShare
                if (rEmpM.RoleId != rAppS.sRole)
                    oService.FlowShare(rAppS.idProcess, rAppS.sRole, rAppS.sNobr);

                //代理人通知
                var rsAppAgentWhere = (from c in rsAppAgent
                                       where c.sNobr == rAppS.sNobr
                                       select c).ToList();

                foreach (var rAppAgent in rsAppAgent)
                    if (rAppAgent.sAgentMail.Trim().Length > 0)
                        lsSendMail.Add(rAppAgent.sAgentMail.Trim());

                if (rAppS.sAgentNobr != null && rAppS.sAgentNobr.Trim().Length > 0)
                {
                    var rAgent = (from c in rsEmp
                                  where c.id == rAppS.sAgentNobr.Trim()
                                  select c).FirstOrDefault();

                    if (rAgent != null && rAgent.email.Trim().Length > 0)
                        lsSendMail.Add(rAgent.email.Trim());
                }

                if (rAppS.sAgentNobr2 != null && rAppS.sAgentNobr2.Trim().Length > 0)
                {
                    var rAgent = (from c in rsEmp
                                  where c.id == rAppS.sAgentNobr2.Trim()
                                  select c).FirstOrDefault();

                    if (rAgent != null && rAgent.email.Trim().Length > 0)
                        lsSendMail.Add(rAgent.email.Trim());
                }

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

            var rRoleAgent = (from c in dcFlow.Role
                              where c.Emp_id.Trim() == rsAppS.First().sAgentNobr.Trim()
                              select c).FirstOrDefault();

            if (rRoleAgent == null) return;

            //dcFlow.wfFormAppInfo.InsertAllOnSubmit(lsFormAppInfo);

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

            var rDept = rsDept.Where(p => p.Code == rsAppS.First().sDept).FirstOrDefault();
            var sDay = rsAppS.First().sUnit == "天" ? Convert.ToInt32(rsAppS.Max(p => p.iUse)).ToString("00") : Convert.ToInt32(rsAppS.Max(p => p.iUse) / 8).ToString("00");

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
            rAppM.sConditions1 = "00"; //目前所簽核到的部門
            rAppM.sConditions2 = sDay;
            rAppM.sConditions3 = rsApp.First().sNobr;   //總經理直接離開
            rAppM.sMailSubject = sSubject;
            rAppM.sMailBdoy = sBody;
            dcFlow.wfFormApp.InsertOnSubmit(rAppM);

            dcForm.SubmitChanges();
            dcFlow.SubmitChanges();

            x++;
            if (oService.FlowStart(iProcessID, lblFlowTreeID.Text, rsAppS.First().sRole, rsAppS.First().sNobr, lblRoleAppM.Text, lblNobrAppM.Text, false))
                y++;
        }

        string Url = FlowFrom.Tools.GetFlowImageUrl("Std", "", "", iProcessID.ToString());

        if (x == y && y > 0)
        {
            RadWindowManager1.RadAlert("您的申請單已成功送出了", 300, 100, "警告訊息", "", "");
            Response.Redirect(Url);
        }
        else if (y > 0)
        {
            RadWindowManager1.RadAlert("流程傳送成功 但有部份流程失敗", 300, 100, "警告訊息", "", "");
            Response.Redirect(Url);
        }
        else
            RadWindowManager1.RadAlert("流程傳送失敗", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息

        //if (x == y && y > 0)
        //    RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '" + Url + "';", true);
        //else if (y > 0)
        //    RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "alert('流程傳送成功 但有部份流程失敗');self.location = '"+ Url + "';", true);
        //else
        //    RadWindowManager1.RadAlert("流程傳送失敗", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
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