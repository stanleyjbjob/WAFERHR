using System;
using System.Collections.Generic;
using System.Linq;
using System.Transactions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Ot_Std : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "Ot";

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

            ddlOtCat_DataBind();
            ddlRote_DataBind();
            ddlOtrcd_DataBind();
            ddlDepts_DataBind();

            SetTime(lblNobrAppM.Text, DateTime.Now.Date);
            SetCardTime(lblNobrAppM.Text, DateTime.Now.Date);
            SetRote(lblNobrAppM.Text, DateTime.Now.Date);
            SetDepts(lblNobrAppM.Text);
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

    private void ddlOtCat_DataBind()
    {
        RadComboBoxItem it = new RadComboBoxItem();
        //it.Text = "加班費";
        //it.Value = "1";

        //ddlOtCat.Items.Add(it);

        it = new RadComboBoxItem();
        it.Text = "補休假";
        it.Value = "2";

        ddlOtCat.Items.Add(it);
    }

    private void ddlRote_DataBind()
    {
        Dal.Dao.Att.RoteDao oRoteDao = new Dal.Dao.Att.RoteDao(dcHR.Connection);
        var rsRote = oRoteDao.GetRoteByOt();

        ddlRote.DataSource = rsRote;
        ddlRote.DataTextField = "RoteName";
        ddlRote.DataValueField = "RoteCode";
        ddlRote.DataBind();
    }

    private void ddlOtrcd_DataBind()
    {
        Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(dcHR.Connection);
        var rsOtrcd = oOtDao.GetOtrcd();

        ddlOtrcd.DataSource = rsOtrcd;
        ddlOtrcd.DataTextField = "Name";
        ddlOtrcd.DataValueField = "Code";
        ddlOtrcd.DataBind();
    }

    private void ddlDepts_DataBind()
    {
        Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);
        var rsDepts = oDeptDao.GetDepts();

        ddlDepts.DataSource = rsDepts;
        ddlDepts.DataTextField = "Name";
        ddlDepts.DataValueField = "Code";
        ddlDepts.DataBind();
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

        txtDateB_SelectedDateChanged(null, null);
        SetDepts(lblNobrAppS.Text);
    }
    #endregion

    private void SetTime(string sNobr, DateTime dDate)
    {
        txtTimeB.Text = "0000";
        txtTimeE.Text = "0000";

        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var rAttend = oAttendDao.GetAttend(sNobr, dDate).FirstOrDefault();

        Dal.Dao.Att.AttcardDao oAttcardDao = new Dal.Dao.Att.AttcardDao(dcHR.Connection);
        var rAttcard = oAttcardDao.GetAttcard(sNobr, dDate).FirstOrDefault();

        if (rAttend != null)
        {
            Dal.Dao.Att.RoteDao oRoteDao = new Dal.Dao.Att.RoteDao(dcHR.Connection);
            var rRote = oRoteDao.GetRoteDetail(new List<string>() { rAttend.RoteCode }).FirstOrDefault();

            if (rRote != null)
            {
                //平日 先帶入下班時間
                if (rRote.RoteCode != "00")
                {
                    txtTimeB.Text = rRote.OffTime;
                    txtTimeE.Text = rRote.OffTime;
                }
                else
                {
                    //假日帶入刷卡T1的時間
                    if (rAttcard != null && rAttcard.OnCardTime48.Length > 0)
                        txtTimeB.Text = rAttcard.OnCardTime48;
                }

                //共同帶入刷卡下班時間
                if (rAttcard != null && rAttcard.OffCardTime48.Length > 0)
                    txtTimeE.Text = rAttcard.OffCardTime48;
            }
        }
    }

    private void SetCardTime(string sNobr, DateTime dDate)
    {
        lblCardTime.Text = "";

        string Card = GetCardTime(sNobr, dDate.AddDays(-1));
        if (Card.Length > 0)
            lblCardTime.Text = Card;

        Card = GetCardTime(sNobr, dDate);
        if (Card.Length > 0)
        {
            if (lblCardTime.Text.Length > 0)
                lblCardTime.Text += "<BR>";
            lblCardTime.Text += Card;
        }

        Card = GetCardTime(sNobr, dDate.AddDays(1));
        if (Card.Length > 0)
        {
            if (lblCardTime.Text.Length > 0)
                lblCardTime.Text += "<BR>";
            lblCardTime.Text += Card;
        }
    }

    private string GetCardTime(string sNobr, DateTime dDate)
    {
        string Card = "";

        Dal.Dao.Att.CardDao oCardDao = new Dal.Dao.Att.CardDao(dcHR.Connection);
        var rsCard = oCardDao.GetData(sNobr, dDate.Date);
        if (rsCard.Count > 0)
        {
            Card = dDate.ToShortDateString() + "-";

            foreach (var rCard in rsCard)
                Card += rCard.OnTime + ",";
        }

        return Card;
    }

    private void SetRote(string sNobr, DateTime dDate)
    {
        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var rAttend = oAttendDao.GetAttend(sNobr, dDate).FirstOrDefault();

        string RoteCode = oAttendDao.GetAttendFixedRoteCode(sNobr, dDate);
        if (rAttend != null)
            RoteCode = rAttend.RoteCodeH;

        if (ddlRote.Items.FindItemByValue(RoteCode) != null)
            ddlRote.Items.FindItemByValue(RoteCode).Selected = true;
    }

    private void SetDepts(string sNobr)
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBasS = oBasDao.GetBaseByNobr(sNobr, DateTime.Now.Date).FirstOrDefault();

        if (ddlDepts.Items.FindItemByValue(rBasS.DeptsCode) != null)
            ddlDepts.Items.FindItemByValue(rBasS.DeptsCode).Selected = true;
    }

    private void SetTransDateTime()
    {
        if (txtTimeB.Text.CompareTo("2400") >= 0)
        {
            //txtDateB.SelectedDate = txtDateB.SelectedDate.Value.AddDays(1);
            //txtTimeB.Text = (Convert.ToInt32(txtTimeB.Text) - 2400).ToString("0000");
            txtTimeB.Text = "0000";
        }

        if (txtTimeE.Text.CompareTo("2400") >= 0)
        {
            //txtDateE.SelectedDate = txtDateE.SelectedDate.Value.AddDays(1);
            //txtTimeE.Text = (Convert.ToInt32(txtTimeE.Text) - 2400).ToString("0000");
            txtTimeE.Text = "0000";
        }
    }

    protected void txtDateB_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        string Nobr = lblNobrAppS.Text;
        DateTime Date = txtDateB.SelectedDate.GetValueOrDefault(DateTime.Now).Date;

        txtDateE.SelectedDate = Date;
        SetTime(Nobr, Date);
        SetCardTime(Nobr, Date);
        SetRote(Nobr, Date);

        //如果選擇非假日，要鎖住班別不讓他選
        ddlRote.Enabled = true;
        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var rAttend = oAttendDao.GetAttend(Nobr, Date).FirstOrDefault();
        if (rAttend != null && rAttend.RoteCode != "00")
            ddlRote.Enabled = false;

        SetTransDateTime();
    }

    protected void gvAppS_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        var rs = (from c in dcForm.wfAppOt
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
        string OtCat = ddlOtCat.SelectedItem.Value;
        string Otrcd = ddlOtrcd.SelectedItem.Value;
        string Rote = ddlRote.SelectedItem.Value;
        string Depts = ddlDepts.SelectedItem.Value;
        DateTime DateB = txtDateB.SelectedDate.Value;
        DateTime DateE = txtDateE.SelectedDate.Value;
        string TimeB = txtTimeB.Text;
        string TimeE = txtTimeE.Text;
        string Note = txtNote.Text.Trim();


        if (Note.Length == 0)
        {
            RadWindowManager1.RadAlert("您的加班原因沒有輸入", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBasS = oBasDao.GetBaseByNobr(Nobr, DateB).FirstOrDefault();

        if (rBasS == null)
        {
            RadWindowManager1.RadAlert("基本資料不正確，請洽人事單位", 300, 100, "警告訊息", "", "");
            return;
        }

        if (TimeB.Length != 4 || TimeE.Length != 4)
        {
            RadWindowManager1.RadAlert("您所輸入的時間不正確", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var rAttend = oAttendDao.GetAttend(Nobr, DateB).FirstOrDefault();

        //if (rAttend.RoteCode == "00")
        //{
        //    int iTimeB = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB);
        //    int iTimeE = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE);
        //    int iTemp;

        //    iTemp = (30 - (iTimeB % 30));
        //    iTimeB = iTemp == 30 ? iTimeB : iTimeB + iTemp;
        //    TimeB = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeB);

        //    iTemp = iTimeE % 30;
        //    iTimeE -= iTemp;
        //    TimeE = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeE);
        //}

        if (rAttend.RoteCode != "00")
        {
            RadWindowManager1.RadAlert("非假日不允許申請加班", 300, 100, "警告訊息", "", "");
            return;
        }

        DateTime DateTimeB = DateB.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB));
        DateTime DateTimeE = DateE.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE));
        if (DateTimeB >= DateTimeE)
        {
            RadWindowManager1.RadAlert("您的開始日期時間不能大於或等於結束日期時間", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Sal.SalaryLockDao oSalaryLockDao = new Dal.Dao.Sal.SalaryLockDao(dcHR.Connection);
        string YYMM = oSalaryLockDao.GetSalaryYymm(Nobr, DateB);

        var rSalaryLockBegin = oSalaryLockDao.GetSalaryLockBegin(DateB, DateE, rBasS.Saladr).Where(p => p.Date == DateB).FirstOrDefault();
        if (rSalaryLockBegin != null)
        {
            RadWindowManager1.RadAlert("您申請的日期，薪資已鎖檔，請洽人事單位", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Att.AttcardDao oAttcardDao = new Dal.Dao.Att.AttcardDao(dcHR.Connection);
        if (!oAttcardDao.IsCardTime(Nobr, DateB, TimeB, TimeE))
        {
            RadWindowManager1.RadAlert("您所申請的時間不在刷卡時間裡", 300, 100, "警告訊息", "", "");
            return;
        }

        //檢查重複的資料
        var rsAppS = (from c in dcForm.wfAppOt
                      where (c.sProcessID == lblProcessID.Text || (c.idProcess != 0 && c.sState == "1"))
                      && c.sNobr == Nobr
                      select c).ToList();

        if (rsAppS.Where(c => c.dDateTimeB < DateTimeE && c.dDateTimeE > DateTimeB).Any())
        {
            RadWindowManager1.RadAlert("資料重複或流程正在進行中", 300, 100, "警告訊息", "", "");
            return;
        }

        Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(dcHR.Connection);
        var rsOt = oOtDao.GetOt(Nobr, DateB.AddDays(-1).Date, DateE.AddDays(1).Date);

        if (rsOt.Where(p => p.DateTimeB < DateTimeE && p.DateTimeE > DateTimeB).Any())
        {
            RadWindowManager1.RadAlert("人事資料重複", 300, 100, "警告訊息", "", "");
            return;
        }

        var Calculate = oOtDao.GetCalculate(Nobr, OtCat, DateB, DateE, TimeB, TimeE, Otrcd, 0, Rote, true, true);

        //var Calculate = oOtDao.GetCalculate(Nobr, OtCat, DateB, DateE, TimeB, TimeE, Otrcd, 0, "", true, true);

        if (Calculate < 0.5M)
        {
            RadWindowManager1.RadAlert("計算時數必須大於0.5小時", 300, 100, "警告訊息", "", "");
            return;
        }

        //如果假日來加班，超過8小時 一待當做8小時 20160222
        bool bExceptionHour = false;
        decimal iExceptionHour = 0;
        decimal Calculate1 = Calculate;
        if (Calculate >= 8)
        {
            iExceptionHour = 8;
            Calculate = 8;
            bExceptionHour = true;
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

        DateTime DateB1 = DateB;
        DateTime DateE1 = DateE;
        string TimeB1 = TimeB;
        string TimeE1 = TimeE;

        oOtDao.ConvertTime24To48(Nobr, ref  DateB1, ref DateE1, ref TimeB1, ref TimeE1); 

        var rs = new wfAppOt();
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
        rs.dDateB1 = DateB1;
        rs.dDateE1 = DateE1;
        rs.sTimeB1 = TimeB1;
        rs.sTimeE1 = TimeE1;
        rs.dDateTimeB1 = DateTimeB;
        rs.dDateTimeE1 = DateTimeE;
        rs.dDateB = DateB;
        rs.dDateE = DateE;
        rs.sTimeB = TimeB;
        rs.sTimeE = TimeE;
        rs.dDateTimeB = DateTimeB;
        rs.dDateTimeE = DateTimeE;
        rs.sOtcatCode = OtCat;
        rs.sOtcatName = ddlOtCat.SelectedItem.Text;
        rs.sOtrcdCode = Otrcd;
        rs.sOtrcdName = ddlOtrcd.SelectedItem.Text;
        rs.sRoteCode = Rote;
        rs.sRoteName = ddlRote.SelectedItem.Text;
        rs.sOtDeptCode = Depts;
        rs.sOtDeptName = ddlDepts.SelectedItem.Text;
        rs.iTotalHour1 = Calculate1;
        rs.iTotalHour = Calculate;
        rs.bExceptionHour = bExceptionHour;
        rs.iExceptionHour = iExceptionHour;
        rs.sSalYYMM = YYMM;
        rs.bSign = true;
        rs.sState = "0";
        rs.sGuid = Guid.NewGuid().ToString();
        rs.bAuth = rEmpS.Auth;
        rs.sNote = txtNote.Text;
        rs.dKeyDate = DateTime.Now;
        rs.sInfo = rs.sName + "," + rs.dDateB.ToShortDateString() + "," + rs.sTimeB + "~" + rs.dDateE.ToShortDateString() +","+ rs.sTimeE + "," + rs.iTotalHour.ToString() + "小時," + rs.sNote;
        rs.sMailBody = MessageSendMail.OtBody(rs.sNobr, rs.sName, rs.sDeptName, rs.sRoteName, rs.dDateB, rs.sTimeB, rs.sTimeE, rs.iTotalHour, rs.sOtcatName, rs.sNote);
        dcForm.wfAppOt.InsertOnSubmit(rs);

        dcForm.SubmitChanges();

        gvAppS.Rebind();

        lblAddGuid.Text = Guid.NewGuid().ToString();
    }

    protected void gvAppS_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Del")
        {
            var r = (from c in dcForm.wfAppOt
                     where c.iAutoKey == Convert.ToInt32(ca)
                     select c).FirstOrDefault();

            if (r != null)
            {
                if (cn == "Del")
                {
                    dcForm.wfAppOt.DeleteOnSubmit(r);

                    dcFlow.SubmitChanges();
                    dcForm.SubmitChanges();

                    gvAppS.Rebind();
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

        var rsApp = (from c in dcForm.wfAppOt
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
            string sSubject = "【通知】(" + rsAppS.First().sNobr + ")" + rsAppS.First().sName + " 之加班單，請進入系統簽核";
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

            //dcFlow.wfFormAppInfo.InsertAllOnSubmit(lsFormAppInfo);

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
            rAppM.sConditions1 = "00"; //目前所簽核到的部門
            rAppM.sMailSubject = sSubject;
            rAppM.sMailBdoy = sBody;
            dcFlow.wfFormApp.InsertOnSubmit(rAppM);

            dcForm.SubmitChanges();
            dcFlow.SubmitChanges();

            x++;
            if (oService.FlowStart(iProcessID, lblFlowTreeID.Text, rsAppS.First().sRole, rsAppS.First().sNobr, lblRoleAppM.Text, lblNobrAppM.Text , false))
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

        string DialogParm = "NobrM=" + NobrM + "&NobrS=" + NobrS + "&ValidateKey=" + ValidateKey + "&ProcessID=" + ProcessID + "&Key1=" + Key1 + "&Key2=" + Key2 + "&FormCode=" + _FormCode + "&Std=1";
        string DialogParmDetail = "";

        string rw = "rwMT";
        switch (Case)
        {
            case "Flow":
                DialogPage = "../MT/Flow.aspx";
                break;
            case "Calendar":
                DialogPage = "../MT/Calendar.aspx";
                break;
            case "Batch":
                DialogPage = "Batch.aspx";
                rw = "rwBatch";
                break;
            case "BatchByNobr":
                DialogPage = "BatchByNobr.aspx";
                rw = "rwBatch";
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

        RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "window.radopen('" + DialogPage + "?Parm=" + DialogParm + "', '" + rw + "');", true);
    }

    protected void btnDate_Click(object sender, EventArgs e)
    {
        txtDateB_SelectedDateChanged(null, null);
    }
    protected void btnTransCard_Click(object sender, EventArgs e)
    {
        string Nobr = lblNobrAppS.Text;
        DateTime Date = txtDateB.SelectedDate.GetValueOrDefault(DateTime.Now.Date);

        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var rAttend = oAttendDao.GetAttend(Nobr, Date).FirstOrDefault();

        if (rAttend != null)
        {
            string RoteCode = rAttend.RoteCode;

            if (RoteCode == "00")
            {
                //置換假日真實新班別
                RoteCode = ddlRote.SelectedItem.Value;

                oAttendDao.SaveAttend(Nobr, Date, RoteCode);
            }

            Dal.Dao.Att.TransCardDao oTransCardDao = new Dal.Dao.Att.TransCardDao(dcHR.Connection);
            oTransCardDao.TransCard(Nobr, Nobr, "0", "z", Date, Date, Nobr, true, true, true, "", "JB-TRANSCARD", true, 1);

            SetTime(Nobr, Date);
            SetCardTime(Nobr, Date);
            SetTransDateTime();
        }
    }
    protected void btnBatch_Click(object sender, EventArgs e)
    {
        RadButton btn = sender as RadButton;
        if (btn != null)
        {
            string cn = btn.CommandName;

            Dialog(cn, lblNobrAppM.Text, lblNobrAppS.Text, lblProcessID.Text, lblAddGuid.Text);
        }
    }
    protected void btnBatchByNobr_Click(object sender, EventArgs e)
    {
        RadButton btn = sender as RadButton;
        if (btn != null)
        {
            string cn = btn.CommandName;

            Dialog(cn, lblNobrAppM.Text, lblNobrAppS.Text, lblProcessID.Text, lblAddGuid.Text);
        }
    }
}