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

public partial class Repair_Std : System.Web.UI.Page
{
    //Form
    public RepairDSTableAdapters.wfRepairAppMTableAdapter wfRepairAppMTA = new RepairDSTableAdapters.wfRepairAppMTableAdapter();
    public RepairDSTableAdapters.wfRepairAppSTableAdapter wfRepairAppSTA = new RepairDSTableAdapters.wfRepairAppSTableAdapter();
    public RepairDSTableAdapters.wfRepairSetTableAdapter wfRepairSetTA = new RepairDSTableAdapters.wfRepairSetTableAdapter();
    public RepairDSTableAdapters.REPAIRTableAdapter REPAIRTA = new RepairDSTableAdapters.REPAIRTableAdapter();
    public CardDSTableAdapters.CARDTableAdapter CardTA = new CardDSTableAdapters.CARDTableAdapter();
    public HrDSTableAdapters.ROTETableAdapter RoteTA = new HrDSTableAdapters.ROTETableAdapter();
    public HrDSTableAdapters.ATTENDTableAdapter AttendTA = new HrDSTableAdapters.ATTENDTableAdapter();
    public HrDSTableAdapters.HOLITableAdapter HOLITA = new HrDSTableAdapters.HOLITableAdapter();
    public FlowDSTableAdapters.wfUpFileTableAdapter wfUpFileTA = new FlowDSTableAdapters.wfUpFileTableAdapter();

    public OtDSTableAdapters.wfOtAppSTableAdapter wfOtAppSTA = new OtDSTableAdapters.wfOtAppSTableAdapter();
    public HrDSTableAdapters.ATTCARDTableAdapter ATTCARDTA = new HrDSTableAdapters.ATTCARDTableAdapter();

    public OtDSTableAdapters.OTTableAdapter OTTA = new OtDSTableAdapters.OTTableAdapter();
    public HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();

    //DataSet
    public RepairDS oRepairDS;
    public FlowDS oFlowDS;
    public HrDS.ROTEDataTable RoteDT = new HrDS.ROTEDataTable();
    public HrDS.ATTENDDataTable AttendDT = new HrDS.ATTENDDataTable();
    //Row
    RepairDS.wfRepairSetRow rDef;
    public HrDS.ROTERow rRote;
    public HrDS.ATTENDRow rAtt;
    public DataRow[] rows;
    public HrDS oHrDS;

    //?idFlowTree=19&idRole_Start=T20000A7&idEmp_Start=96015&idRole_Agent=&idEmp_Agent=

    protected void Page_Load(object sender, EventArgs e)
    {
        oRepairDS = new RepairDS();
        oFlowDS = new FlowDS();
        oHrDS = new HrDS();

        lblMsg.Text = "";

        //帶入系統預設值
        wfRepairSetTA.Fill(oRepairDS.wfRepairSet);
        if (oRepairDS.wfRepairSet.Rows.Count == 0)
        {
            lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員(Default)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        rDef = (RepairDS.wfRepairSetRow)oRepairDS.wfRepairSet.Rows[0];
        lblNote.Text = rDef.sStdNote;

        if (!this.IsPostBack)
        {
            SetDefault();

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? FlowCS.GetDecode(Request.QueryString["idEmp_Start"]) : lblNobr.Text;
            lblEmpID.Text = lblNobr.Text;
            lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序

            ddlName.DataBind();
            txtName_TextChanged(null, null);

            //ScriptManager.RegisterClientScriptBlock(upl, typeof(string), "DateFormatScript", jbmodule.Web.ui.DateFormatScript(), true);
            //txtDateB.Attributes.Add("onkeyup", "date_format('" + txtDateB.ID + "')");
            //txtDateB.Text = DateTime.Now.AddYears(-1911).ToShortDateString();
            txtDateB.Text = DateTime.Now.ToShortDateString();
            ddlOtcat.DataBind();
        }
    }

    //設定表單預設值
    public void SetDefault()
    {
        ddlName.Visible = rDef.bAgentApp;
        txtName.ReadOnly = !rDef.bAgentApp;

        lbtnSignState.Visible = rDef.bSignState;
    }

    protected void ddlName_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblNobr.Text = ddlName.SelectedItem.Value;
        txtName.Text = ddlName.SelectedItem.Text;

        ddlOtcat.DataBind();
    }

    protected void txtName_TextChanged(object sender, EventArgs e)
    {
        ListItem li, liA, liB;
        liA = ddlName.Items.FindByValue(txtName.Text) != null ? ddlName.Items.FindByValue(txtName.Text) : ddlName.Items.FindByText(txtName.Text);
        liB = ddlName.Items.FindByValue(lblNobr.Text) != null ? ddlName.Items.FindByValue(lblNobr.Text) : ddlName.Items.FindByText(lblNobr.Text);
        li = (liA != null) ? liA : liB;

        lblNobr.Text = "000000";
        txtName.Text = "";
        if (li != null)
        {
            lblNobr.Text = li.Value;
            txtName.Text = li.Text;

            ddlName.ClearSelection();
            li.Selected = true;

            ddlOtcat.DataBind();
        }
    }

    protected void lbtnHoliday_Click(object sender, EventArgs e)
    {
        string link = "MyFrame.aspx?url=Calendar.aspx?nobr=" + lblNobr.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:550px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = form1;" +
            "var txtDate = window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Calendar", script, true);
    }

    protected void lbtn_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        string link = "MyFrame.aspx?url=" + lbtn.CommandName + ".aspx?nobr=" + lblNobr.Text + "&id=" + lblProcessID.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = form1;" +
            "window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
    }

    protected void gvAppS_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (e.CommandName == "Upload")
        {
            string link = "MyFrame.aspx?url=Upload.aspx?nobr=" + CommandArgument + "&id=" + lblProcessID.Text;
            string script = "var sFeatures = 'dialogWidth:600px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = form1;" +
                "window.showModalDialog('" + link + "', obj, sFeatures);";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string nobr = lblNobr.Text.Trim();

        //最大筆數
        if (gvAppS.Rows.Count >= rDef.iAppCount)
        {
            lblMsg.Text = "一次只能申請" + rDef.iAppCount.ToString() + "筆";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查工號是否不存在
        if (txtName.Text.Length == 0)
        {
            lblMsg.Text = "員工工號並不存在";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查日期
        DateTime dateB, dateE;
        try
        {
            dateB = DateTime.Parse(txtDateB.Text);//.Date.AddYears(1911);
            dateE = dateB;
        }
        catch
        {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3(兩個日期會同時判斷)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查時間
        int timeB, timeE;
        try
        {
            timeB = int.Parse(txtTimeB.Text);
            timeE = int.Parse(txtTimeE.Text);

            //如果開始時間是在當天0800以前，或是結束時間是在隔天0000以後
            lblSpirit.Text = (timeB < 800 || timeE >= 2400) ? "300" : "0";
        }
        catch
        {
            lblMsg.Text = "時間格式不正確，請重新輸入。例：0930(兩個時間會同時判斷)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查結束時間是否比開始時間小
        DateTime dateBfull, dateEfull;
        dateBfull = dateB.AddMinutes(FlowCS.GetMinutes(txtTimeB.Text));
        dateEfull = dateB.AddMinutes(FlowCS.GetMinutes(txtTimeE.Text));
        if (dateBfull >= dateEfull)
        {
            lblMsg.Text = "結束日期時間不可小於等於申請日期時間";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查結束時間是否比開始時間小
        DateTime datetimeB, datetimeE;
        datetimeB = dateB.AddMinutes(FlowCS.GetMinutes(txtTimeB.Text));
        datetimeE = dateE.AddMinutes(FlowCS.GetMinutes(txtTimeE.Text));
        dateEfull = dateB.AddMinutes(FlowCS.GetMinutes(txtTimeE.Text));
        if (datetimeB >= datetimeE)
        {
            lblMsg.Text = "結束日期時間不可小於等於申請日期時間";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        rows = ATTENDTA.GetDataByNOBR(nobr).Select("ADATE = '" + dateB.ToShortDateString() + "'", "ADATE");
        if ((rows.Length == 0))
        {
            lblMsg.Text = "此天沒有您的排班資料，請通知人事單位幫您產生(ATTEND)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrDS.ATTENDRow rat = (HrDS.ATTENDRow)rows[0];

        //檢查是否小於刷卡時間
        ATTCARDTA.FillByKey(oHrDS.ATTCARD, nobr, dateB);
        bool isT1 = false;
        bool isT2 = false;
        if (oHrDS.ATTCARD.Rows.Count > 0)
        {
            HrDS.ATTCARDRow ra = (HrDS.ATTCARDRow)oHrDS.ATTCARD.Rows[0];
            DateTime t1;
            DateTime t2;
            try
            {
                t1 = dateB.AddMinutes(FlowCS.GetMinutes(ra.T1));
                t2 = dateB.AddMinutes(FlowCS.GetMinutes(ra.T2));
                isT1 = (t1 <= dateBfull);
                isT2 = (t2 >= dateEfull);  //刷卡時間一定要比申請結束時間大
            }
            catch { }
        }

        if (!isT1)
        {
            lblMsg.Text = "您的申請開始時間不可小於當日刷卡開始時間";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //6職等以上不檢查刷卡時間
        //if (!isT2 && Convert.ToInt32(oHrBaseDataS.sJobl) <= 5 && !arrHoliDay.Contains( rat.ROTE.Trim()) && oHrBaseDataS.sDept != "101000")
        if (!isT2)
        {
            lblMsg.Text = "您的申請結束時間不可大於當日刷卡結束時間";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseDataM, oHrBaseDataS;
        oHrBaseDataM = new HrBaseData(FlowCS.GetDecode(Request.QueryString["idEmp_Start"]));
        oHrBaseDataS = new HrBaseData(nobr);

        //台風假可以申請加班 20090716 by 瑤姐 & 亞妮 OTHCODE = 'E'
        rows = HOLITA.GetDataByKey(datetimeB.Date, "E").Select("HOLI_CODE = '" + oHrBaseDataS.sHolicd + "'");
        string jobl = oHrBaseDataS.sJobl.Trim().Length == 0 ? "0" : oHrBaseDataS.sJobl;
        string Dept = ",411100,511200,511400,512300,415100,415200,415300,415400,";
        //if (!(Convert.ToInt32(jobl) <= 5 || oHrBaseDataS.sDI == "D" || (Dept.IndexOf("," + oHrBaseDataS.sDept.Trim() + ",") != -1) || rows.Length > 0) && (ddlOtcat.SelectedItem.Value == "1"))
        //{
        //    lblMsg.Text = "您不可申請加班費";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        //檢查hr是否有相同資料
        if (isHrTimeCheck(nobr, datetimeB, datetimeE))
        {
            lblMsg.Text = "您的搶修日期已在人事單位裡";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查flow是否有相同資料
        if (wfRepairAppSTA.GetDataByFlowCheck(datetimeE, datetimeB, nobr).Rows.Count > 0)
        {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (wfRepairAppSTA.GetDataByNowFlowCheck(datetimeE, datetimeB, lblProcessID.Text, nobr).Rows.Count > 0)
        {
            lblMsg.Text = "您已申請一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查flow是否有相同資料
        if (wfOtAppSTA.GetDataByFlowCheck(datetimeE, datetimeB, nobr).Rows.Count > 0)
        {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //判斷區間的刷卡筆數，來判斷是否發給交通津貼
        DateTime rTimeB, rTimeE;
        AttendTA.FillByDate(AttendDT, ddlName.SelectedValue, Convert.ToDateTime(txtDateB.Text));

        if (AttendDT.Rows.Count == 0)
        {
            lblMsg.Text = "您沒有班表資料，請洽人事單位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (new DateTime(2012, 5, 10) > dateB)
        {
            lblMsg.Text = "5/10之前的加班不允許申請";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        rAtt = AttendDT.Rows[0] as HrDS.ATTENDRow;
        RoteTA.FillByRote(RoteDT, rAtt.ROTE);
        rRote = RoteDT.Rows[0] as HrDS.ROTERow;

        //先將下班及最晚下班時間帶入
        rTimeB = Convert.ToDateTime(txtDateB.Text);
        rTimeE = rTimeB;

        rTimeB = rTimeB.AddMinutes(FlowCS.GetMinutes(rRote.OFF_TIME));

        rTimeE = rTimeE.AddDays(1);//假設最晚下班都是隔天
        rTimeE = rTimeE.AddMinutes(FlowCS.GetMinutes(rRote.OFFTIME2));

        //從下班時間計算到申請的結束時間，但是不超過最晚下班時間
        rTimeE = (rTimeE >= datetimeE) ? datetimeE : rTimeE;

        DateTime d1 = Convert.ToDateTime(txtDateB.Text).AddMinutes(FlowCS.GetMinutes(txtTimeB.Text));
        DateTime d2 = Convert.ToDateTime(txtDateB.Text).AddDays(1).AddMinutes(FlowCS.GetMinutes(rRote.OFFTIME2));

        //如果申請日當天的班別為00班，或是開始時間小於當天的最晚下班時間，或是當天下班時間到申請搶修的結束時間大於等於3筆者，視為離廠在進場（下班-搶修進-搶修出）
        //if ((timeB <= Convert.ToInt32(FlowCS.GetMinutes(rRote.OFFTIME2))) || (rAtt.ROTE == "00"))
        if (d1 <= d2 || (rAtt.ROTE == "00"))
            lblTraffic.Text = "300";
        else
        {
            int num = 0;
            if (timeE <= 2400)//如果都在同一天
            {
                num = num + Convert.ToInt32(CardTA.GetCountByNobrTime(ddlName.SelectedValue, Convert.ToDateTime(txtDateB.Text), FlowCS.GetTimeSplit(rTimeB), FlowCS.GetTimeSplit(rTimeE)));
            }
            else//分兩天計算
            {
                num = num + Convert.ToInt32(CardTA.GetCountByNobrTime(ddlName.SelectedValue, Convert.ToDateTime(txtDateB.Text), FlowCS.GetTimeSplit(rTimeB), "2400"));
                num = num + Convert.ToInt32(CardTA.GetCountByNobrTime(ddlName.SelectedValue, Convert.ToDateTime(txtDateB.Text).AddDays(1), "0000", FlowCS.GetTimeSplit(rTimeE)));
            }
            if (num >= 3)
                lblTraffic.Text = "300";
        }

        bool cbCal = cbEat.Checked || cbRes.Checked;
        decimal otHour = 0;
        if (cbCal)
        {
            //if (otHour != 0)
            //{
            try
            {
                otHour = Convert.ToDecimal(txtHour.Text);

                TimeSpan ts1 = datetimeE - datetimeB;
                if (Convert.ToDecimal(ts1.TotalHours) < otHour)
                {
                    lblMsg.Text = "手動輸入時數不可以大於時間相減之總時數";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                    return;
                }
            }
            catch
            {
                lblMsg.Text = "手動輸入加班時數不正確，請重新輸入";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }

        string rotet = ddlRote.SelectedItem.Value == "0" ? oHrBaseDataS.sRotet : ddlRote.SelectedItem.Value;
        OtCS.OtCalculation oOtCalculation = OtCS.CalculationOt(nobr, rotet, dateB, datetimeB, datetimeE);

        if (!cbCal)
        {
            //if (otHour == 0)
            //{
            //檢查是否符合最小請假時數
            if (oOtCalculation.iMinute < oHrBaseDataS.iOtMin)
            {
                lblMsg.Text = "您加班必需大於或等於" + oHrBaseDataS.iOtMin.ToString() + "分鐘，目前申請時數：" + Math.Round(oOtCalculation.iHour, 2) + "小時";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            //是否除得盡
            if (!isAbsUint(oHrBaseDataS.iOtUnit, oOtCalculation.iMinute - oHrBaseDataS.iOtMin))
            {
                lblMsg.Text = "您加班必需是" + oHrBaseDataS.iOtUnit + "分鐘的倍數(一定要可以整除)，目前申請時數：" + Math.Round(oOtCalculation.iHour, 2) + "小時";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
            //}
        }

        TimeSpan ts = datetimeE - datetimeB;

        decimal iOt, iRes, iHrOt = 0, iFlowOt = 0, iFlowRepair = 0;
        decimal iRepairOt = 0, iRepairFlow = 0;
        DateTime dDateB, dDateE;
        dDateE = dateB.Day > 25 ? new DateTime(dateB.AddMonths(1).Year, dateB.AddMonths(1).Month, 25) : new DateTime(dateB.Year, dateB.Month, 25);
        dDateB = new DateTime(dDateE.AddMonths(-1).Year, dDateE.AddMonths(-1).Month, 26);
        OtDS.OTDataTable dtOT = OTTA.GetDataByHour(nobr, dDateB, dDateE);// OTTA.GetDataByOtHour(nobr, HrCS.SetYYMM(dateB));

        if (dtOT.Rows.Count > 0)
        {
            iOt = Convert.ToDecimal(dtOT.Compute("SUM(OT_HRS)", "").ToString());
            //iRes = Convert.ToDecimal(dtOT.Compute("SUM(REST_HRS)", "").ToString());

            iHrOt = iOt;

            if (dtOT.Select("REPAIR = 1").Length > 0)
                iRepairOt = Convert.ToDecimal(dtOT.Compute("SUM(OT_HRS)", "REPAIR = 1").ToString());
        }

        OtDS.wfOtAppSDataTable dtOtAppS = wfOtAppSTA.GetDataByOtHour(nobr, HrCS.SetYYMM(dateB));
        if (dtOtAppS.Rows.Count > 0)
        {
            try
            {
                iOt = Convert.ToDecimal(dtOtAppS.Compute("SUM(iTotalHour)", "sOtcatCode = '1'").ToString());
            }
            catch
            {
                iOt = 0;
            }

            iFlowOt = iOt;
        }

        RepairDS.wfRepairAppSDataTable dtRepairAppS = wfRepairAppSTA.GetDataByOtHour(nobr, HrCS.SetYYMM(dateB));
       
        if (dtRepairAppS.Rows.Count > 0)
        {
            iOt = Convert.ToDecimal(dtRepairAppS.Compute("SUM(iTotalHours)", "").ToString());

            iFlowRepair = iOt;

            if (dtRepairAppS.Select("sOtcatCode = '1'").Length > 0)
                iRepairFlow = Convert.ToDecimal(dtRepairAppS.Compute("SUM(iTotalHours)", "sOtcatCode = '1'").ToString());
        }

        //從這裡開始新增資料
        wfRepairAppSTA.Fill(oRepairDS.wfRepairAppS);
        RepairDS.wfRepairAppSRow rs = oRepairDS.wfRepairAppS.NewwfRepairAppSRow();
        rs.sProcessID = lblProcessID.Text;
        rs.idProcess = 0;
        rs.sNobr = nobr;
        rs.sName = oHrBaseDataS.sName;
        rs.sDept = oHrBaseDataS.sDept;
        rs.sDeptName = oHrBaseDataS.sDeptName;
        rs.sJob = oHrBaseDataS.sJob;
        rs.sJobName = oHrBaseDataS.sJobName;
        rs.sJobl = oHrBaseDataS.sJobl;
        rs.sJoblName = oHrBaseDataS.sJoblName;
        rs.sEmpcd = oHrBaseDataS.sEmpcd;
        rs.sEmpcdName = oHrBaseDataS.sEmpcdName;
        rs.dStrDateTime = datetimeB;
        rs.dEndDateTime = datetimeE;
        rs.dStrDate = dateB.Date;
        rs.dEndDate = dateB.Date;
        rs.sStrTime = txtTimeB.Text;
        rs.sEndTime = txtTimeE.Text;
        rs.sOtcatCode = ddlOtcat.SelectedItem.Value;
        rs.sOtcatName = ddlOtcat.SelectedItem.Text;
        rs.sRoteCode = ddlRote.SelectedItem.Value;
        rs.sRoteName = ddlRote.SelectedItem.Text;
        rs.iTotalHours = Convert.ToDecimal(calAbsUint(0.5, ts.TotalHours));

        rs.iTotalHours = cbCal ? otHour : Convert.ToDecimal(oOtCalculation.iHour);
        rs.iTotalDiff = cbCal ? otHour - Convert.ToDecimal(oOtCalculation.iHour) : 0;    //差異數

        //搶修加班時數不可以超過30小時上限：目前HR的搶修加班時數 + 進行中表單的搶修加班時數 + 目前加班時數
        iOt = iRepairOt + iRepairFlow + rs.iTotalHours;
        if (iOt > 30 && rs.sOtcatCode == "1")
        {
            lblMsg.Text = "您所申請的加班時數超過30小時上限，目前已加班時數" + iOt.ToString() + "請選擇補休假";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //整月加班時數不可以超過46小時的上限：目前HR的加班時數 + 進行中表單的加班時數 + 進行中表單的搶修加班時教 + 目前加班時數
        iOt = iHrOt + iFlowOt + iFlowRepair + rs.iTotalHours;
        if (iOt > 46 && rs.sOtcatCode == "1")
        {
            lblMsg.Text = "(警告)您所申請的加班時數超過46小時上限，目前已加班時數" + iOt.ToString();
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            //return;
        }

        rs.bCal = cbCal;
        rs.bEat = cbEat.Checked;
        rs.bRes = cbRes.Checked;
        rs.sSalYYMM = HrCS.SetYYMM(rs.dStrDate.Date);
        rs.bSign = true;
        rs.sState = "0";
        rs.bAuth = true;
        rs.sNote = txtReason.Text;
        rs.dKeyDate = DateTime.Now;

        oRepairDS.wfRepairAppS.AddwfRepairAppSRow(rs);
        wfRepairAppSTA.Update(oRepairDS.wfRepairAppS);

        gvAppS.DataBind();
    }

    protected void btnSign_Click(object sender, EventArgs e)
    {
        if (gvAppS.Rows.Count == 0)
        {
            lblMsg.Text = "您並未申請任何資料，請先申請至少一筆資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (txtReason.Text.Length == 0 || System.Text.Encoding.Default.GetBytes(txtReason.Text.Trim().ToString()).Length >= 200)
        {
            lblMsg.Text = "入廠搶修原因為必填欄位或字數不可過超過100個字";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (txtAddress.Text.Length == 0 || System.Text.Encoding.Default.GetBytes(txtAddress.Text.Trim().ToString()).Length >= 200)
        {
            lblMsg.Text = "入廠搶修地點為必填欄位或字數不可過超過100個字";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (txtContent.Text.Length == 0 || System.Text.Encoding.Default.GetBytes(txtContent.Text.Trim().ToString()).Length >= 200)
        {
            lblMsg.Text = "工作內容為必填欄位或字數不可過超過100個字";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (txtAmend.Text.Length == 0 || System.Text.Encoding.Default.GetBytes(txtAmend.Text.Trim().ToString()).Length >= 200)
        {
            lblMsg.Text = "改善對策為必填欄位或字數不可過超過100個字";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        string HrMail = ConfigurationSettings.AppSettings["HrMail"];

        string body = "";
        //預設一個暫存的陣列
        ArrayList alAppS = new ArrayList();
        wfRepairAppMTA.Fill(oRepairDS.wfRepairAppM);
        wfRepairAppSTA.FillByProcessID(oRepairDS.wfRepairAppS, lblProcessID.Text);
        wfUpFileTA.FillByProcessID(oFlowDS.wfUpFile, lblProcessID.Text);

        if (oFlowDS.wfUpFile.Rows.Count == 0)
        {
            lblMsg.Text = "您至少上傳一個附件";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseDataM, oHrBaseDataS;

        localhost.Service oService = new localhost.Service();

        //以部門+職稱+天數=關鍵來決定流程走向 , 角色 , 工號
        string Key, RoleID;
        bool isPassAll = false; //是否有通過
        int iError = 0; //失敗筆數
        int iOK = 0;    //成功筆數
        foreach (RepairDS.wfRepairAppSRow rs in oRepairDS.wfRepairAppS.Rows)
        {
            Key = rs.sDept + rs.sJob;
            RoleID = rs.sDept + rs.sJob;
            if (!alAppS.Contains(Key))
            {
                //流程從這裡開始
                lblProcessID.Text = oService.GetProcessID().ToString();

                //找出相同的關鍵來傳送流程
                rows = oRepairDS.wfRepairAppS.Select("sDept = '" + rs.sDept + "' AND sJob = '" + rs.sJob + "'");
                foreach (RepairDS.wfRepairAppSRow r in rows)
                {
                    r.sProcessID = lblProcessID.Text;
                    r.idProcess = int.Parse(lblProcessID.Text);
                    r.sState = "1";   //啟動流程為簽核狀態
                    //rs1.dKeyDate = DateTime.Now;    //重新更改簽核正確時間

                    //當角色不同時，就將資料寫入ProcessFlowShare
                    //if (Request["idRole_Start"] != RoleID)
                    //    oService.FlowShare(int.Parse(lblProcessID.Text), RoleID, r.sNobr);

                    //附加檔案
                    rows = oFlowDS.wfUpFile.Select("sNobr = '" + r.sNobr + "'");
                    int a = 1;
                    foreach (FlowDS.wfUpFileRow rf in rows)
                    {
                        rf.sProcessID = lblProcessID.Text;
                        rf.idProcess = int.Parse(lblProcessID.Text);

                        rs["sReserve" + a.ToString()] = rf.sServerName;    //附加檔案檔名

                        a++;
                    }
                }

                oHrBaseDataM = new HrBaseData(FlowCS.GetDecode(Request.QueryString["idEmp_Start"]));
                oHrBaseDataS = new HrBaseData(rs.sNobr);

                RepairDS.wfRepairAppMRow rm = oRepairDS.wfRepairAppM.NewwfRepairAppMRow();
                rm.sProcessID = lblProcessID.Text;
                rm.idProcess = int.Parse(lblProcessID.Text);
                rm.sNobr = oHrBaseDataM.sNobr;
                rm.sName = oHrBaseDataM.sName;
                rm.sDept = oHrBaseDataM.sDept;
                rm.sDeptName = oHrBaseDataM.sDeptName;
                rm.sJob = oHrBaseDataM.sJob;
                rm.sJobName = oHrBaseDataM.sJobName;
                rm.sJobl = oHrBaseDataM.sJobl;
                rm.sJoblName = oHrBaseDataM.sJoblName;
                rm.iCateOrder = oHrBaseDataS.iCateOrder;    //被申請者的部門層級
                rm.bDelay = false;  //是否有延遲需要補單
                rm.dDateA = DateTime.Now;
                rm.sReason = txtReason.Text;
                rm.sAddress = txtAddress.Text;
                rm.sContent = txtContent.Text;
                rm.sAmend = txtAmend.Text;
                rm.iTraffic = Convert.ToInt32(lblTraffic.Text);
                rm.iSpirit = Convert.ToInt32(lblSpirit.Text);
                rm.iTotal = rm.iTraffic + rm.iSpirit;
                rm.bAuth = oHrBaseDataS.bMang; //是否是主管
                rm.bSign = true;
                rm.sState = "1";
                rm.sReserve1 = rs.sReserve1;    //附加檔案檔名
                rm.sReserve2 = rs.IssReserve2Null() ? "" : rs.sReserve2;
                rm.sReserve3 = rs.IssReserve3Null() ? "" : rs.sReserve3;
                rm.sConditions1 = rm.iCateOrder.ToString(); //目前所簽核到的部門
                oRepairDS.wfRepairAppM.AddwfRepairAppMRow(rm);

                try
                {
                    //流程序 流程樹 角色代碼 工號 申請者角色代碼 申請者工號
                    //(oService.FlowStart(iProcessID, Request["idFlowTree"], "請假人角色代碼", "請假人工號", Request["idRole_Agent"], Request["idEmp_Agent"]))
                    //isPassAll = oService.FlowStart(int.Parse(lblProcessID.Text), Request["idFlowTree"], RoleID, rs.sNobr, Request["idRole_Start"], Request["idEmp_Start"]);

                    body = "[AppM];";
                    foreach (DataColumn dc in oRepairDS.wfRepairAppM.Columns)
                    {
                        if (rm[dc] != null)
                            body += dc.ToString() + "=" + rm[dc].ToString() + ";";
                    }

                    body += "[AppS];";
                    foreach (DataColumn dc in oRepairDS.wfRepairAppS.Columns)
                    {
                        if (oRepairDS.wfRepairAppS.Rows[0][dc] != null)
                            body += dc.ToString() + "=" + oRepairDS.wfRepairAppS.Rows[0][dc].ToString() + ";";
                    }

                    iOK++;

                    isPassAll = true;
                }
                catch
                {
                    isPassAll = false;
                }

                if (isPassAll)
                {
                    wfRepairAppMTA.Update(oRepairDS.wfRepairAppM);
                    wfRepairAppSTA.Update(oRepairDS.wfRepairAppS);
                    wfUpFileTA.Update(oFlowDS.wfUpFile);

                    FlowCS.SendMail(HrMail, "01;Repair;" + lblProcessID.Text + ";", body);
                }
                else
                {
                    iError++;
                    oRepairDS.wfRepairAppM.AcceptChanges();
                    oRepairDS.wfRepairAppS.AcceptChanges();
                }

                alAppS.Add(Key);    //暫存關鍵
            }
        }

        if (iOK > 0)
        {
            //ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "';", true);

            lblMsg.Text = "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }
        else
        {
            lblMsg.Text = iError > 0 ? "有部份流程傳送失敗" : "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }

        lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? FlowCS.GetDecode(Request.QueryString["idEmp_Start"]) : lblNobr.Text;
        lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序
    }

    public bool isHrTimeCheck(string nobr, DateTime datetimeB, DateTime datetimeE)
    {
        bool isRepair = false;
        DateTime DateTimeB, DateTimeE;
        REPAIRTA.Fill(oRepairDS.REPAIR);
        rows = oRepairDS.REPAIR.Select("NOBR = '" + nobr + "' AND BDATE >= '" + datetimeB.ToShortDateString() + "' AND BDATE <= '" + datetimeE.ToShortDateString() + "' AND BTIME <> '' AND ETIME <> ''");
        if (rows.Length > 0)
        {
            RepairDS.REPAIRRow rr = (RepairDS.REPAIRRow)rows[0];
            DateTimeB = rr.BDATE.Date.AddMinutes(FlowCS.GetMinutes(rr.BTIME.Trim()));
            DateTimeE = rr.BDATE.Date.AddMinutes(FlowCS.GetMinutes(rr.ETIME.Trim()));

            //不在此請假區間方可寫入請假資料表
            isRepair = ((DateTimeB < datetimeE) && (DateTimeE > datetimeB));
        }

        return isRepair;
    }

    public static double calAbsUint(double absUnit, double absHour)
    {
        double i = 0;
        //間隔單位一定要大於零而且請假時間也要大於零
        while ((absUnit > 0) && (absHour > 0) && (i <= (absHour - absUnit)))
            i += absUnit;

        return i;
    }

    protected void ddlOtcat_DataBound(object sender, EventArgs e)
    {
        HrBaseData oHrBaseDataS = new HrBaseData(lblNobr.Text);

        ddlOtcat.Items.Clear();

        string jobl = oHrBaseDataS.sJobl.Trim().Length == 0 ? "0" : oHrBaseDataS.sJobl;
        string Dept = ",411100,511200,511400,512300,415100,415200,415300,415400,";
        //if (Convert.ToInt32(jobl) <= 5 || oHrBaseDataS.sDI == "D" || (Dept.IndexOf("," + oHrBaseDataS.sDept.Trim() + ",") != -1))
        ddlOtcat.Items.Add(new ListItem("加班費", "1"));

        ddlOtcat.Items.Add(new ListItem("補休假", "2"));
    }

    protected void ddlName_DataBound(object sender, EventArgs e)
    {
        HrBaseData oHrBaseData = new HrBaseData(lblEmpID.Text);
        if (!oHrBaseData.bMang)
        {
            DropDownList ddl = new DropDownList();

            foreach (ListItem li in ddlName.Items)
            {
                oHrBaseData = new HrBaseData(li.Value);
                if (oHrBaseData.bMang)
                    ddl.Items.Add(li);
            }

            foreach (ListItem li in ddl.Items)
                ddlName.Items.Remove(li);
        }
    }
    protected void gvAppS_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        lblTraffic.Text = "0";
        lblSpirit.Text = "0";
    }
    protected void btnNum_Click(object sender, EventArgs e)
    {
        lblNum1.Text = Convert.ToString(System.Text.Encoding.Default.GetBytes(txtReason.Text.Trim().ToString()).Length / 2);
        lblNum2.Text = Convert.ToString(System.Text.Encoding.Default.GetBytes(txtAddress.Text.Trim().ToString()).Length / 2);
        lblNum3.Text = Convert.ToString(System.Text.Encoding.Default.GetBytes(txtContent.Text.Trim().ToString()).Length / 2);
        lblNum4.Text = Convert.ToString(System.Text.Encoding.Default.GetBytes(txtAmend.Text.Trim().ToString()).Length / 2);
    }

    //判斷是否不到最小間隔時數
    public static bool isAbsUint(double absUnit, double absHour)
    {
        //間隔單位一定要大於零而且請假時間也要大於零
        while ((absUnit > 0) && (absHour > 0) && (absHour >= absUnit))
            absHour -= absUnit;


        return (absHour == 0) || (absUnit == 0);
    }
}