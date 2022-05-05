using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Ot_Batch : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "Ot";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            if (Request.QueryString["Parm"] != null)
            {
                string RequestQueryString = Bll.Tools.Decryption.Decrypt(Request.QueryString["Parm"]);
                var dc = Bll.Tools.DataTrans.QueryStringToDictionary(RequestQueryString);

                if (dc.ContainsKey("ValidateKey"))
                {
                    string sValidateKey = dc["ValidateKey"];

                    DateTime Date = DateTime.Now;

                    var r = (from c in dcFlow.wfWebValidate
                             where c.sValidateKey == sValidateKey
                             select c).FirstOrDefault();

                    if (r != null)
                    {
                        if (r.dDateWriter >= DateTime.Now.AddMinutes(-1))
                        {
                            lblFormCode.Text = dc["FormCode"];
                            lblNobr.Text = dc["NobrM"];
                            lblProcessID.Text = dc["ProcessID"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();
                        }
                    }
                }
            }

            txtDate.SelectedDate = DateTime.Now.Date;

            ddlOtCat_DataBind();
            ddlOtrcd_DataBind();
        }
    }

    private void ddlOtCat_DataBind()
    {
        RadComboBoxItem it = new RadComboBoxItem();
        it.Text = "加班費";
        it.Value = "1";

        ddlOtCat.Items.Add(it);

        it = new RadComboBoxItem();
        it.Text = "補休假";
        it.Value = "2";

        ddlOtCat.Items.Add(it);
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

        //ddlDepts.DataSource = rsDepts;
        //ddlDepts.DataTextField = "Name";
        //ddlDepts.DataValueField = "Code";
        //ddlDepts.DataBind();
    }

    public class OtRow
    {
        public int AutoKey { set; get; }
        public int ProcessID { set; get; }
        public string Nobr { set; get; }
        public string Name { set; get; }
        public string RoteCode { set; get; }
        public string RoteName { set; get; }
        public DateTime DateB { set; get; }
        public DateTime DateE { set; get; }
        public string TimeB { set; get; }
        public string TimeE { set; get; }
        public decimal Hour { set; get; }
        public string OnCardTime { set; get; }
        public string OffCardTime { set; get; }
        public decimal CalculateHour { set; get; }
        public bool IsAttcardDay7 { set; get; }

    }

    protected void gv_NeedDataSource(object sender, Telerik.Web.UI.GridNeedDataSourceEventArgs e)
    {
        DateTime Date = txtDate.SelectedDate.GetValueOrDefault(DateTime.Now).Date;
        string OtCat = ddlOtCat.SelectedItem.Value;
        string Otrcd = ddlOtrcd.SelectedItem.Value;

        //利用部門找出可代申請工號
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rsBase = oBasDao.GetBaseByNobr(lblNobr.Text, "2");

        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        var rsAttend = oAttendDao.GetAttend(Date);

        Dal.Dao.Att.AttcardDao oAttcardDao = new Dal.Dao.Att.AttcardDao(dcHR.Connection);
        var rsAttcard = oAttcardDao.GetAttcard(Date);

        var lsAttend = (from a in rsAttend
                        join b in rsBase on a.Nobr equals b.Nobr
                        orderby a.Nobr
                        select a).ToList();

        var lsAttcard = (from a in rsAttcard
                         join b in rsBase on a.Nobr equals b.Nobr
                         orderby a.Nobr
                         select a).ToList();

        var rsOt = (from c in dcForm.wfAppOt
                    where c.sFormCode == "Ot"
                    && Date.AddDays(-2).Date <= c.dDateB1.Date
                    && c.dDateB1.Date >= Date.Date
                    && (c.sState == "1" || c.sProcessID == lblProcessID.Text)
                    select c).ToList();

        Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(dcHR.Connection);
        Dal.Dao.Att.RoteDao oRoteDao = new Dal.Dao.Att.RoteDao(dcHR.Connection);

        var rsRote = oRoteDao.GetRoteDetail();
        var lsRote = oRoteDao.GetRote();

        List<OtRow> lsOt = new List<OtRow>();

        foreach (var rAttcard in lsAttcard)
        {
            var rBase = rsBase.Where(p => p.Nobr == rAttcard.Nobr).FirstOrDefault();
            if (rBase == null)
                continue;

            OtRow rOt = new OtRow();
            rOt.Nobr = rAttcard.Nobr;
            rOt.Name = rBase.NameC;
            rOt.DateB = rAttcard.Date;
            rOt.DateE = rAttcard.Date;
            rOt.TimeB = rAttcard.OnCardTime48;
            rOt.TimeE = rAttcard.OffCardTime48;
            rOt.Hour = 0;
            rOt.OnCardTime = rAttcard.OnCardTime48;
            rOt.OffCardTime = rAttcard.OffCardTime48;
            rOt.CalculateHour = 0;

            var rAttend = lsAttend.Where(p => p.Nobr == rAttcard.Nobr).FirstOrDefault();
            if (rAttend == null)
                continue;

            string RoteCode = rAttend.RoteCode;
            if (RoteCode != "00")
            {
                var rRote = rsRote.Where(p => p.RoteCode == rAttend.RoteCode).FirstOrDefault();
                if (rRote != null)
                    rOt.OnCardTime = rRote.OtBeginTime;
            }
            else
            {
                //取出真實班別
                RoteCode = rAttend.RoteCodeH;
            }

            rOt.RoteCode = RoteCode;

            var rrRote = lsRote.Where(p => p.RoteCode == RoteCode).FirstOrDefault();
            if (rrRote == null)
                continue;

            rOt.RoteName = rrRote.RoteName;

            if (rOt.OnCardTime.Length == 4 && rOt.OffCardTime.Length == 4)
            {
                int iTimeB = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(rOt.OnCardTime);
                int iTimeE = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(rOt.OffCardTime);
                int iTemp;

                iTemp = (30 - (iTimeB % 30));
                iTimeB = iTemp == 30 ? iTimeB : iTimeB + iTemp;
                string TimeB = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeB);

                iTemp = iTimeE % 30;
                iTimeE -= iTemp;
                string TimeE = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeE);

                rOt.TimeB = TimeB;
                rOt.TimeE = TimeE;

                DateTime DateB1 = rOt.DateB;
                DateTime DateE1 = rOt.DateE;
                string TimeB1 = rOt.TimeB;
                string TimeE1 = rOt.TimeE;

                //轉成24小時制
                if (rOt.TimeB.CompareTo("2400") >= 0)
                {
                    rOt.DateB = rOt.DateB.AddDays(1);
                    rOt.TimeB = (Convert.ToInt32(rOt.TimeB) - 2400).ToString("0000");
                }

                if (rOt.TimeE.CompareTo("2400") >= 0)
                {
                    rOt.DateE = rOt.DateE.AddDays(1);
                    rOt.TimeE = (Convert.ToInt32(rOt.TimeE) - 2400).ToString("0000");
                }

                rOt.CalculateHour = oOtDao.GetCalculate(rOt.Nobr, OtCat, DateB1, DateE1, TimeB1, TimeE1, Otrcd, 0, RoteCode);
                rOt.Hour = rOt.CalculateHour;

                if (!rsOt.Where(p => p.sNobr == rAttcard.Nobr && p.dDateB1 == DateB1).Any())
                    if (!oOtDao.GetOt(rAttcard.Nobr, DateB1).Any())
                        if (rOt.Hour >= 1)
                            lsOt.Add(rOt);
            }
        }

        gv.DataSource = lsOt;
    }

    protected void gv_ItemDataBound(object sender, Telerik.Web.UI.GridItemEventArgs e)
    {
    }

    protected void txtDate_SelectedDateChanged(object sender, Telerik.Web.UI.Calendar.SelectedDateChangedEventArgs e)
    {
        gv.Rebind();
    }

    protected void btnSave_Click(object sender, EventArgs e)
    {
        string OtCat = ddlOtCat.SelectedItem.Value;
        string Otrcd = ddlOtrcd.SelectedItem.Value;

        List<wfAppOt> lsOt = new List<wfAppOt>();

        Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(dcHR.Connection);
        Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
        Dal.Dao.Att.AttcardDao oAttcardDao = new Dal.Dao.Att.AttcardDao(dcHR.Connection);
        Dal.Dao.Bas.DeptDao oDeptDao = new Dal.Dao.Bas.DeptDao(dcHR.Connection);

        foreach (GridDataItem row in gv.SelectedItems)
        {
            string Nobr = Convert.ToString(row["Nobr"].Text);
            string Name = Convert.ToString(row["Name"].Text);
            string RoteName = Convert.ToString(row["RoteName"].Text);
            DateTime DateB = Convert.ToDateTime(row["DateB"].Text);
            DateTime DateE = Convert.ToDateTime(row["DateE"].Text);
            string TimeB = Convert.ToString(row["TimeB"].Text);
            string TimeE = Convert.ToString(row["TimeE"].Text);

            decimal Hour = Convert.ToDecimal(row["Hour"].Text);

            Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
            var rBasS = oBasDao.GetBaseByNobr(Nobr, DateB).FirstOrDefault();

            if (rBasS == null)
                continue;

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

            var rAttend = oAttendDao.GetAttend(Nobr, DateB).FirstOrDefault();
            if (rAttend == null)
                continue;

            DateTime DateB1 = DateB;
            DateTime DateE1 = DateE;
            string TimeB1 = TimeB;
            string TimeE1 = TimeE;

            oOtDao.ConvertTime24To48(Nobr, ref  DateB1, ref DateE1, ref TimeB1, ref TimeE1); 

            wfAppOt rs = new wfAppOt();

            rs.sFormCode = _FormCode;
            rs.sProcessID = lblProcessID.Text;
            rs.idProcess = 0;
            rs.sNobr = Nobr;
            rs.sName = Name;
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
            rs.dDateTimeB1 = rs.dDateB1.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(rs.sTimeB1));
            rs.dDateTimeE1 = rs.dDateE1.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(rs.sTimeE1));
            rs.dDateB = DateB;
            rs.dDateE = DateE;
            rs.sTimeB = TimeB;
            rs.sTimeE = TimeE;
            rs.dDateTimeB = rs.dDateTimeB1;
            rs.dDateTimeE = rs.dDateTimeE1;
            rs.sOtcatCode = OtCat;
            rs.sOtcatName = ddlOtCat.SelectedItem.Text;
            rs.sOtrcdCode = Otrcd;
            rs.sOtrcdName = ddlOtrcd.SelectedItem.Text;
            rs.sRoteCode = rAttend.RoteCodeH;
            rs.sRoteName = RoteName;
            rs.sOtDeptCode = "";
            rs.iTotalHour1 = Hour;
            rs.iTotalHour = Hour;
            rs.bExceptionHour = false;
            rs.iExceptionHour = 0;
            rs.sReserve1 = "0";
            rs.sSalYYMM = "";
            rs.bSign = true;
            rs.sState = "0";
            rs.sGuid = Guid.NewGuid().ToString();
            rs.bAuth = rEmpS.Auth;
            rs.sNote = "Batch";
            rs.dKeyDate = DateTime.Now;
            rs.sInfo = rs.sName + "," + rs.dDateB.ToShortDateString() + "," + rs.sTimeB + "~" + rs.dDateE.ToShortDateString() + "," + rs.sTimeE + "," + rs.iTotalHour.ToString() + "小時," + rs.sNote;
            rs.sMailBody = MessageSendMail.OtBody(rs.sNobr, rs.sName, rs.sDeptName, rs.sRoteName, rs.dDateB, rs.sTimeB, rs.sTimeE, rs.iTotalHour, rs.sOtcatName, rs.sNote);

            lsOt.Add(rs);
        }

        if (lsOt.Count == 0)
        {
            RadWindowManager1.RadAlert("您沒有選擇任何一筆資料進行動作", 300, 100, "警告訊息", "", "");
            return;
        }

        dcForm.wfAppOt.InsertAllOnSubmit(lsOt);
        dcForm.SubmitChanges();

        gv.Rebind();

        RadScriptManager.RegisterClientScriptBlock(this, typeof(Page), this.GetType().ToString(), "GetRadWindow().close();", true);
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gv.Rebind();
    }
}