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

public partial class Ot_Std : System.Web.UI.Page
{
    //HR
    public HrDSTableAdapters.BaseDataTableAdapter BaseDataTA = new HrDSTableAdapters.BaseDataTableAdapter();
    public HrDSTableAdapters.ROTETableAdapter ROTETA = new HrDSTableAdapters.ROTETableAdapter();
    public HrDSTableAdapters.ATTENDTableAdapter ATTENDTA = new HrDSTableAdapters.ATTENDTableAdapter();
    public HrDSTableAdapters.ATTCARDTableAdapter ATTCARDTA = new HrDSTableAdapters.ATTCARDTableAdapter();
    public HrDSTableAdapters.HOLITableAdapter HOLITA = new HrDSTableAdapters.HOLITableAdapter();

    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.wfHcodeTableAdapter wfHcodeTA = new FlowDSTableAdapters.wfHcodeTableAdapter();
    public FlowDSTableAdapters.wfRoteTableAdapter wfRoteTA = new FlowDSTableAdapters.wfRoteTableAdapter();
    public FlowDSTableAdapters.ProcessFlowShareTableAdapter ProcessFlowShareTA = new FlowDSTableAdapters.ProcessFlowShareTableAdapter();
    public FlowDSTableAdapters.ProcessApViewTableAdapter ProcessApViewTA = new FlowDSTableAdapters.ProcessApViewTableAdapter();
    public FlowDSTableAdapters.ProcessApParmTableAdapter ProcessApParmTA = new FlowDSTableAdapters.ProcessApParmTableAdapter();
    public FlowDSTableAdapters.wfSignTableAdapter wfSignTA = new FlowDSTableAdapters.wfSignTableAdapter();
    public FlowDSTableAdapters.wfUpFileTableAdapter wfUpFileTA = new FlowDSTableAdapters.wfUpFileTableAdapter();

    //Form
    public OtDSTableAdapters.wfOtAppMTableAdapter wfOtAppMTA = new OtDSTableAdapters.wfOtAppMTableAdapter();
    public OtDSTableAdapters.wfOtAppSTableAdapter wfOtAppSTA = new OtDSTableAdapters.wfOtAppSTableAdapter();
    public OtDSTableAdapters.wfOtSetTableAdapter wfOtSetTA = new OtDSTableAdapters.wfOtSetTableAdapter();
    public OtDSTableAdapters.OtCheckTableAdapter OtCheckTA = new OtDSTableAdapters.OtCheckTableAdapter();
    public OtDSTableAdapters.OTTableAdapter OTTA = new OtDSTableAdapters.OTTableAdapter();
    public OtDSTableAdapters.OT1TableAdapter OT1TA = new OtDSTableAdapters.OT1TableAdapter();

    public RepairDSTableAdapters.wfRepairAppSTableAdapter wfRepairAppSTA = new RepairDSTableAdapters.wfRepairAppSTableAdapter();

    //DataSet
    public HrDS oHrDS;
    public FlowDS oFlowDS;
    public OtDS oOtDS;

    //Row
    OtDS.wfOtSetRow rDef;

    public DataRow[] rows;

    public ArrayList arrHoliDay = new ArrayList();
   

    //?idFlowTree=19&idRole_Start=T20000A7&idEmp_Start=96015&idRole_Agent=&idEmp_Agent=

    protected void Page_Load(object sender, EventArgs e)
    {
        arrHoliDay.Add("00");
        arrHoliDay.Add("0X");
        arrHoliDay.Add("0Y");
        arrHoliDay.Add("0Z");

        oHrDS = new HrDS();
        oFlowDS = new FlowDS();
        oOtDS = new OtDS();
      
        lblMsg.Text = "";

        //帶入系統預設值
        wfOtSetTA.Fill(oOtDS.wfOtSet);
        if (oOtDS.wfOtSet.Rows.Count == 0)
        {
            lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員(Default)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        rDef = (OtDS.wfOtSetRow)oOtDS.wfOtSet.Rows[0];
        lblNote.Text = rDef.sStdNote;

        if (!this.IsPostBack)
        {
            SetDefault();

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? FlowCS.GetDecode(Request.QueryString["idEmp_Start"]) : lblNobr.Text;
            lblEmpID.Text = lblNobr.Text;
            lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序

            ddlName.DataBind();
            txtName_TextChanged(null, null);
            ddlOtcat.DataBind();

            lblOtMonth.Text = "0";
            lblOtMonthB.Text = "0";

            //ScriptManager.RegisterClientScriptBlock(upl, typeof(string), "DateFormatScript", jbmodule.Web.ui.DateFormatScript(), true);
            //txtDateB.Attributes.Add("onkeyup", "date_format('" + txtDateB.ID + "')");
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

        txtDateB.Text = SetDate(lblNobr.Text).ToShortDateString();

        SetTime(lblRote.Text);
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
        }

        txtDateB.Text = SetDate(lblNobr.Text).ToShortDateString();

        SetTime(lblRote.Text);
        ddlOtcat.DataBind();

        SetOtMonth();
    }

    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        DateTime dateB;

        try
        {
            dateB = DateTime.Parse(txtDateB.Text);

            rows = ATTENDTA.GetDataByNOBR(lblNobr.Text).Select("ADATE = '" + dateB.ToShortDateString() + "'", "ADATE");
            if ((rDef.bAttend) && (rows.Length == 0))
            {
                lblMsg.Text = "此天沒有您的排班資料，請通知人事單位幫您產生(ATTEND)";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            if (rows.Length > 0)
            {
                HrDS.ATTENDRow r = (HrDS.ATTENDRow)rows[0];
                lblRote.Text = r.ROTE.Trim();
            }

            SetTime(lblRote.Text);

            ddlRote.DataBind();

            SetOtMonth();
        }
        catch
        {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
    }

    public void SetOtMonth()
    {
        lblOtMonth.Text = "0";
        lblOtMonthB.Text = "0";
        try
        {
            DateTime dateB = DateTime.Parse(txtDateB.Text);

            string nobr = lblNobr.Text;
            string yymm = HrCS.SetYYMM(dateB);

            //OtDS.OTDataTable dtOT = OTTA.GetDataByOtHour(nobr, yymm);

            DateTime dDateB, dDateE;
            dDateE = dateB.Day > 25 ? new DateTime(dateB.AddMonths(1).Year, dateB.AddMonths(1).Month, 25) : new DateTime(dateB.Year, dateB.Month, 25);
            dDateB = new DateTime(dDateE.AddMonths(-1).Year, dDateE.AddMonths(-1).Month, 26);
            OtDS.OTDataTable dtOT = OTTA.GetDataByHour(nobr, dDateB, dDateE);

            decimal iHrOt = 0;
            if (dtOT.Rows.Count > 0)
            {
                decimal iOt = Convert.ToDecimal(dtOT.Compute("SUM(OT_HRS)", "").ToString());
                decimal iRes = Convert.ToDecimal(dtOT.Compute("SUM(REST_HRS)", "").ToString());

                iHrOt = iOt + iRes;
            }

            lblOtMonth.Text = iHrOt.ToString();
            lblOtMonthB.Text = Convert.ToString(46 - iHrOt);
        }
        catch
        {
        }
    }

    //protected void ibtnDate_Command(object sender, CommandEventArgs e) {
    //    string date = txtDateB.Text;
    //    string dateScript = form1.ID + "." + e.CommandName + ".value = txtDate;";

    //    string link = "MyFrame.aspx?url=Calendar.aspx?nobr=" + lblNobr.Text + "&date=" + date;
    //    string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:550px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
    //        "var obj = form1;" +
    //        "var txtDate = window.showModalDialog('" + link + "', obj, sFeatures);" + dateScript;
    //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Calendar", script, true);
    //}

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

        if (CommandName == "Del")
        {
            OtDS.wfOtAppSRow rs = (OtDS.wfOtAppSRow)wfOtAppSTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];

            rs.Delete();
            wfOtAppSTA.Update(rs);
            gvAppS.DataBind();
        }
    }

    protected void gvAppS_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        Label lbl = (Label)e.Row.FindControl("lblCal");
        if (lbl != null)
            lbl.Text = lbl.Text == "1" ? "是" : "否";
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string nobr = lblNobr.Text.Trim();

        HrBaseData oHrBaseDataM, oHrBaseDataS;
        oHrBaseDataM = new HrBaseData(FlowCS.GetDecode(Request.QueryString["idEmp_Start"]));
        oHrBaseDataS = new HrBaseData(nobr);

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

        //檢查事由是否需要輸入且空白
        if (txtNote.Text.Length == 0 && rDef.bNote)
        {
            lblMsg.Text = "事由一定要輸入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查日期
        DateTime dateB;
        try
        {
            dateB = DateTime.Parse(txtDateB.Text).Date;
        }
        catch
        {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //瓊瑩20120106
        //if (new DateTime(2012, 1, 22).Date >= dateB || new DateTime(2012, 1, 25).Date <= dateB)
        //{
        //    lblMsg.Text = "只可以申請1/22-1/25";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        //if (new DateTime(2012, 5, 10) > dateB)
        //{
        //    lblMsg.Text = "5/10之前的加班不允許申請";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        //申請日期只能於上月申請26-25
        DateTime dDateA;
        dDateA = DateTime.Now.Date.Day <= 25 ? new DateTime(DateTime.Now.AddMonths(-2).Year, DateTime.Now.AddMonths(-2).Month, 26)
            : new DateTime(DateTime.Now.AddMonths(-1).Year, DateTime.Now.AddMonths(-1).Month, 26);

        if (dateB < dDateA)
        {
            lblMsg.Text = "超過補單時間";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查時間
        int timeB, timeE;
        try
        {
            timeB = int.Parse(txtTimeB.Text);
            timeE = int.Parse(txtTimeE.Text);
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

        //檢查排班資料
        rows = ATTENDTA.GetDataByNOBR(nobr).Select("ADATE = '" + dateB.ToShortDateString() + "'", "ADATE");
        if ((rDef.bAttend) && (rows.Length == 0))
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

        //設備的要改成6職等(含)以上不能申請加班費 20110418 by 瓊瑩
        string Dept = ",411100,415200,415300,415400,415600,520101,";
        string Job = ",06A01,06C02,06C04,";
        //if (Convert.ToInt32(oHrBaseDataS.sJobl) >= 6 && (Dept.IndexOf("," + oHrBaseDataS.sDept.Trim() + ",") >= 0) && (ddlOtcat.SelectedItem.Value == "1"))
        //{
        //    lblMsg.Text = "您不可申請加班費，僅能換補休。";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        //行事曆J不卡職等20100210 by 瑤姐 & 亞妮
        rows = HOLITA.GetDataByKey(dateBfull.Date, "J").Select("HOLI_CODE = '" + oHrBaseDataS.sHolicd + "'");
        string jobl = oHrBaseDataS.sJobl.Trim().Length == 0 ? "0" : oHrBaseDataS.sJobl;

        if (rows.Length == 0 && false)
        {
            //台風假可以申請加班 20090716 by 瑤姐 & 亞妮 OTHCODE = 'E'
            rows = HOLITA.GetDataByKey(dateBfull.Date, "E").Select("HOLI_CODE = '" + oHrBaseDataS.sHolicd + "'");

            //某些特定的部門，6職等假日可申請加班​費或補休
            Dept = ",415000,415200,415300,415400,415500,415600,416000,411200,411210,411400,412300,410100,411100,420100,520101,511200,511400,512300,590000,591100,511000,520100,520102,";
            if (Convert.ToInt32(jobl) == 6)
            {
                if (ddlOtcat.SelectedItem.Value == "1" && (!arrHoliDay.Contains(rat.ROTE.Trim())) && (Dept.IndexOf("," + oHrBaseDataS.sDept.Trim() + ",") == -1))
                {
                    lblMsg.Text = "您平日不可申請加班費。";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                    return;
                }
            }
            else
            {
                //職等7(含)以上平日不可申請加班。
                Dept = ",411100,415200,415300,415400,415500,209200,421100,425200,425300,425400,415600,520101,411200,411210,411400,412300,410100,420100,";
                if (Convert.ToInt32(jobl) >= 7 && !arrHoliDay.Contains(rat.ROTE.Trim()) && (Dept.IndexOf("," + oHrBaseDataS.sDept.Trim() + ",") == -1) && (Job.IndexOf("," + oHrBaseDataS.sJob.Trim() + ",") == -1) && (rows.Length == 0))
                {
                    lblMsg.Text = "您平日不可申請加班。";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                    return;
                }

                if (!(Convert.ToInt32(jobl) <= 5 || oHrBaseDataS.sDI == "D" || (Dept.IndexOf("," + oHrBaseDataS.sDept.Trim() + ",") != -1) || (Job.IndexOf("," + oHrBaseDataS.sJob.Trim() + ",") != -1) || rows.Length > 0) && (ddlOtcat.SelectedItem.Value == "1"))
                {
                    lblMsg.Text = "您不可申請加班費";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                    return;
                }
            }
        }

        //2012/7/2才需要開始實施 職等6以上 間接人員
        if (Convert.ToInt32(jobl) >= 6 && new DateTime(2012, 7, 2) <= dateB && oHrBaseDataS.sDI == "I")
        {
            if (OT1TA.GetDataByKey(nobr, dateB).Rows.Count == 0)
            {
                lblMsg.Text = "請先填預估加班單，才可以申請加班";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }

        //檢查延遲送單是否不允許送單
        if (Convert.ToInt32(ATTENDTA.QueryByWorkDay(nobr, "", dateB, DateTime.Now.Date)) > rDef.iDelay)
        {
            lblMsg.Text = "加班時間不可超過" + rDef.iDelay.ToString() + "天以後";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
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
            }
            catch
            {
                lblMsg.Text = "手動輸入加班時數不正確，請重新輸入";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }
        else
        {
            //檢查申請時間是否在當日區間裡
            if (isWorkTime(nobr, dateBfull))
            {
                lblMsg.Text = "您的加班開始日期在當日的上班時間裡";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }

            //檢查結束時間是否在當日區間裡
            if (isWorkTime(nobr, dateEfull))
            {
                lblMsg.Text = "您的加班結束日期在當日的上班時間裡";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
            //}
        }

        string rotet = ddlRote.SelectedItem.Value == "0" ? oHrBaseDataS.sRotet : ddlRote.SelectedItem.Value;
        OtCS.OtCalculation oOtCalculation = OtCS.CalculationOt(nobr, rotet, dateB, dateBfull, dateEfull);

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

        //檢查hr是否有相同資料
        if (isHrTimeCheck(nobr, dateBfull, dateEfull))
        {
            lblMsg.Text = "您的加班日期已在人事單位裡";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查flow是否有相同資料
        if (wfOtAppSTA.GetDataByFlowCheck(dateEfull, dateBfull, nobr).Rows.Count > 0)
        {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (wfOtAppSTA.GetDataByNowFlowCheck(dateEfull, dateBfull, nobr, lblProcessID.Text).Rows.Count > 0)
        {
            lblMsg.Text = "您已申請一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查flow是否有相同資料
        if (wfRepairAppSTA.GetDataByFlowCheck(dateEfull, dateBfull, nobr).Rows.Count > 0)
        {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        TimeSpan ts = dateEfull - dateBfull;
        if (Convert.ToDecimal(ts.TotalHours) < otHour)
        {
            lblMsg.Text = "您所申請的時數超過最大可申請時數";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if ((Convert.ToDouble(otHour) % 0.5) != 0)
        {
            lblMsg.Text = "例外時數必需整除";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        decimal iOt, iRes, iHrOt = 0, iFlowOt = 0, iFlowRepair = 0;
        DateTime dDateB, dDateE;
        dDateE = dateB.Day > 25 ? new DateTime(dateB.AddMonths(1).Year, dateB.AddMonths(1).Month, 25) : new DateTime(dateB.Year, dateB.Month, 25);
        dDateB = new DateTime(dDateE.AddMonths(-1).Year, dDateE.AddMonths(-1).Month, 26);
        OtDS.OTDataTable dtOT = OTTA.GetDataByHour(nobr, dDateB, dDateE);// OTTA.GetDataByOtHour(nobr, HrCS.SetYYMM(dateB));

        if (dtOT.Rows.Count > 0)
        {
            iOt = Convert.ToDecimal(dtOT.Compute("SUM(OT_HRS)", "").ToString());
            iRes = Convert.ToDecimal(dtOT.Compute("SUM(REST_HRS)", "").ToString());

            iHrOt = iOt + iRes;
        }

        OtDS.wfOtAppSDataTable dtOtAppS = wfOtAppSTA.GetDataByOtHour(nobr, HrCS.SetYYMM(dateB));
        if (dtOtAppS.Rows.Count > 0)
        {
            iOt = Convert.ToDecimal(dtOtAppS.Compute("SUM(iTotalHour)", "").ToString());

            iFlowOt = iOt;
        }

        RepairDS.wfRepairAppSDataTable dtRepairAppS = wfRepairAppSTA.GetDataByOtHour(nobr, HrCS.SetYYMM(dateB));
        if (dtRepairAppS.Rows.Count > 0)
        {
            iOt = Convert.ToDecimal(dtRepairAppS.Compute("SUM(iTotalHours)", "").ToString());

            iFlowRepair = iOt;
        }

        //從這裡開始新增資料
        wfOtAppSTA.Fill(oOtDS.wfOtAppS);
        OtDS.wfOtAppSRow rs = oOtDS.wfOtAppS.NewwfOtAppSRow();
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
        rs.dStrDateTime = dateBfull;
        rs.dEndDateTime = dateEfull;
        rs.dStrDate = dateB;
        rs.dEndDate = dateB;
        rs.sStrTime = txtTimeB.Text;
        rs.sEndTime = txtTimeE.Text;
        rs.sOtcatCode = ddlOtrcd.SelectedItem.Value == "13" ? "2" : ddlOtcat.SelectedItem.Value;
        rs.sOtcatName = ddlOtrcd.SelectedItem.Value == "13" ? "補休假" : ddlOtcat.SelectedItem.Text;
        rs.sOtrcdCode = ddlOtrcd.SelectedItem.Value;
        rs.sOtrcdName = ddlOtrcd.SelectedItem.Text;
        rs.sRoteCode = ddlRote.SelectedItem.Value;
        rs.sRoteName = ddlRote.SelectedItem.Text;
        rs.iTotalHour = cbCal ? otHour : Convert.ToDecimal(oOtCalculation.iHour);
        rs.iTotalDiff = cbCal ? otHour - Convert.ToDecimal(oOtCalculation.iHour) : 0;    //差異數

        //整月加班時數不可以超過46小時的上限：目前HR的加班時數 + 進行中表單的加班時數 + 進行中表單的搶修加班時教 + 目前加班時數
        iOt = iHrOt + iFlowOt + iFlowRepair + rs.iTotalHour;
        if (iOt > 46)
        {
            lblMsg.Text = "(警告)您所申請的加班時數超過46小時上限，目前已加班時數" + iOt.ToString();
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            //return;
        }

        if (cbEat2.Checked || cbEat3.Checked || cbEat4.Checked)
        {
            if (cbEat.Checked)
            {
                lblMsg.Text = "您有勾選未用餐，所以請勿勾選實際用餐申請";
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
                return;
            }
        }

        rs.bCal = cbCal;
        rs.bEat = cbEat.Checked;
        rs.bRes = cbRes.Checked;
        rs.bEat1 = false;
        rs.bEat2 = cbEat2.Checked;
        rs.bEat3 = cbEat3.Checked;
        rs.bEat4 = cbEat4.Checked;
        //rs.iTotalHour = Convert.ToDecimal(oOtCalculation.iHour);
        rs.sSalYYMM = HrCS.SetYYMM(rs.dStrDate.Date);
        //rs.sReserve1 = cbCal ? "1" : "0";   //計算休息時間
        //rs.sReserve2 = cbCal ? Convert.ToString(otHour - Convert.ToDecimal(oOtCalculation.iHour)) : "0";    //差異數
        rs.sReserve1 = lblOtMonth.Text;
        rs.sReserve2 = lblOtMonthB.Text;
        rs.sReserve3 = lblRote.Text;
        var Eat = cbEat2.Checked ? "午餐" : "";
        Eat += (Eat.Length > 0 && cbEat3.Checked) ? "," : "";
        Eat += cbEat3.Checked ? "晚餐" : "";
        Eat += (Eat.Length > 0 && cbEat4.Checked) ? "," : "";
        Eat += cbEat4.Checked ? "宵一" : "";
        rs.sEmpcdName = Eat;
        rs.bSign = true;
        rs.sState = "0";
        rs.bAuth = true;
        rs.sNote = txtNote.Text.Trim();
        rs.dKeyDate = DateTime.Now;
        oOtDS.wfOtAppS.AddwfOtAppSRow(rs);
        wfOtAppSTA.Update(oOtDS.wfOtAppS);

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

        string HrMail = ConfigurationSettings.AppSettings["HrMail"];

        string body = "";
        //預設一個暫存的陣列
        ArrayList alAppS = new ArrayList();
        wfOtAppMTA.Fill(oOtDS.wfOtAppM);
        wfOtAppSTA.FillByProcessID(oOtDS.wfOtAppS, lblProcessID.Text);

        HrBaseData oHrBaseDataM, oHrBaseDataS;

        localhost.Service oService = new localhost.Service();

        //以部門+職稱+天數=關鍵來決定流程走向 , 角色 , 工號
        string Key, RoleID;
        bool isPassAll = false; //是否有通過
        int iError = 0; //失敗筆數
        int iOK = 0;    //成功筆數
        foreach (OtDS.wfOtAppSRow rs in oOtDS.wfOtAppS.Rows)
        {
            Key = rs.sDept + rs.sJob;
            RoleID = rs.sDept + rs.sJob;
            //if (!alAppS.Contains(Key))
            //{
            //流程從這裡開始
            lblProcessID.Text = oService.GetProcessID().ToString();

            //找出相同的關鍵來傳送流程
            //rows = oOtDS.wfOtAppS.Select("sDept = '" + rs.sDept + "' AND sJob = '" + rs.sJob + "'");
            //foreach (OtDS.wfOtAppSRow r in rows)
            //{
            rs.sProcessID = lblProcessID.Text;
            rs.idProcess = int.Parse(lblProcessID.Text);
            rs.sState = "1";   //啟動流程為簽核狀態
            //rs1.dKeyDate = DateTime.Now;    //重新更改簽核正確時間

            //當角色不同時，就將資料寫入ProcessFlowShare
            //if (Request["idRole_Start"] != RoleID)
            //    oService.FlowShare(int.Parse(lblProcessID.Text), RoleID, r.sNobr);
            //}

            oHrBaseDataM = new HrBaseData(FlowCS.GetDecode(Request.QueryString["idEmp_Start"]));
            oHrBaseDataS = new HrBaseData(rs.sNobr);

            OtDS.wfOtAppMRow rm = oOtDS.wfOtAppM.NewwfOtAppMRow();
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
            rm.bAuth = true;
            rm.bSign = true;
            rm.iTotalHour = rs.iTotalHour;
            rm.sState = "1";
            rm.sConditions1 = rm.iCateOrder.ToString(); //目前所簽核到的部門
            oOtDS.wfOtAppM.AddwfOtAppMRow(rm);

            try
            {
                //流程序 流程樹 角色代碼 工號 申請者角色代碼 申請者工號
                //(oService.FlowStart(iProcessID, Request["idFlowTree"], "請假人角色代碼", "請假人工號", Request["idRole_Agent"], Request["idEmp_Agent"]))
                //isPassAll = oService.FlowStart(int.Parse(lblProcessID.Text), Request["idFlowTree"], RoleID, rs.sNobr, Request["idRole_Start"], Request["idEmp_Start"]);

                body = "[AppM];";
                foreach (DataColumn dc in oOtDS.wfOtAppM.Columns)
                {
                    if (rm[dc] != null)
                        body += dc.ToString() + "=" + rm[dc].ToString() + ";";
                }

                body += "[AppS];";
                foreach (DataColumn dc in oOtDS.wfOtAppS.Columns)
                {
                    if (oOtDS.wfOtAppS.Rows[0][dc] != null)
                        body += dc.ToString() + "=" + oOtDS.wfOtAppS.Rows[0][dc].ToString() + ";";
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
                wfOtAppMTA.Update(oOtDS.wfOtAppM);
                wfOtAppSTA.Update(oOtDS.wfOtAppS);

                FlowCS.SendMail(HrMail, "01;Ot;" + lblProcessID.Text + ";", body);
            }
            else
            {
                iError++;
                oOtDS.wfOtAppM.AcceptChanges();
                oOtDS.wfOtAppS.AcceptChanges();
            }

            alAppS.Add(Key);    //暫存關鍵
            //}
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

    //設定日期
    public DateTime SetDate(string nobr)
    {
        DateTime date = DateTime.Now.Date;
        string Holiday = wfRoteTA.QueryByKey("Holiday");
        string Rote = Holiday != null ? Holiday : "00";

        rows = ATTENDTA.GetDataByNOBR(nobr).Select("ADATE >= '" + date.ToShortDateString() + "'", "ADATE");
        foreach (HrDS.ATTENDRow r in rows)
        {
            if (r.ROTE.Trim() != Rote)
            {
                lblRote.Text = r.ROTE;  //指定班別
                return r.ADATE;
            }
        }

        return date;
    }

    //設定時間
    public void SetTime(string rote)
    {
        rows = ROTETA.GetDataByRote(rote).Select();
        ddlRote.Enabled = arrHoliDay.Contains(rote);

        if (rows.Length > 0)
        {
            HrDS.ROTERow r = (HrDS.ROTERow)rows[0];
            txtTimeB.Text = r.OT_BEGIN.Trim().Length > 0 ? r.OT_BEGIN.Trim() : "0000";
            txtTimeE.Text = txtTimeB.Text;
        }
    }

    //請假時間是否落在上班時間裡false = 沒有落在上班時間裡
    public bool isWorkTime(string nobr, DateTime date)
    {
        rows = ATTENDTA.GetDataByNOBR(nobr).Select("ADATE = '" + date.ToShortDateString() + "'");
        if (rows.Length > 0)
        {
            HrDS.ATTENDRow ra = (HrDS.ATTENDRow)rows[0];

            rows = ROTETA.GetDataByRote(ra.ROTE.Trim()).Select();
            if (rows.Length > 0)
            {
                HrDS.ROTERow rr = (HrDS.ROTERow)rows[0];

                DateTime dateBfull, dateEfull;
                dateBfull = ra.ADATE.Date.AddMinutes(FlowCS.GetMinutes(rr.ON_TIME.Trim()));
                dateEfull = ra.ADATE.Date.AddMinutes(FlowCS.GetMinutes(rr.OFF_TIME.Trim()));

                //開始時間小於等於申請時間而且結束時間大於等於申請時間
                return ((dateBfull < date) && (dateEfull > date));
            }
        }

        return false;
    }

    //hr是否有相同資料false = 沒有相同資料
    public bool isHrTimeCheck(string nobr, DateTime dateB, DateTime dateE)
    {
        bool bPass = false;
        rows = OtCheckTA.GetDataByNobr(nobr, dateB.Date, dateE.Date).Select();

        DateTime dateBfull, dateEfull;
        foreach (OtDS.OtCheckRow r in rows)
        {
            dateBfull = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.BTIME));
            dateEfull = r.BDATE.Date.AddMinutes(FlowCS.GetMinutes(r.ETIME));

            bPass = (bPass) ? bPass : ((dateBfull < dateE) && (dateEfull > dateB));
        }

        return bPass;
    }

    //判斷是否不到最小間隔時數
    public static bool isAbsUint(double absUnit, double absHour)
    {
        //間隔單位一定要大於零而且請假時間也要大於零
        while ((absUnit > 0) && (absHour > 0) && (absHour >= absUnit))
            absHour -= absUnit;


        return (absHour == 0) || (absUnit == 0);
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

    //取得預設班別
    public string GetRote(string sNobr, DateTime dDate)
    {
        string sRote = "";
        sRote = (ATTENDTA.GetDataByDate(sNobr, dDate).Rows.Count > 0) ? ((HrDS.ATTENDRow)ATTENDTA.GetDataByDate(sNobr, dDate).Rows[0]).ROTE.Trim() : sRote;

        //取得basetts的資料
        HrBaseData oHrBaseData = new HrBaseData(sNobr);
        sRote = (sRote.Length == 0 || arrHoliDay.Contains(sRote)) ? oHrBaseData.sRotet : sRote;
        return sRote;
    }

    protected void ddlRote_DataBinding(object sender, EventArgs e)
    {
        ddlRote.Items.Clear();
    }

    protected void ddlRote_DataBound(object sender, EventArgs e)
    {
        ddlRote.ClearSelection();
        if (ddlRote.Items.FindByValue(GetRote(lblNobr.Text, Convert.ToDateTime(txtDateB.Text))) != null)
            ddlRote.Items.FindByValue(GetRote(lblNobr.Text, Convert.ToDateTime(txtDateB.Text))).Selected = true;
    }
    protected void lbtnOt_Click(object sender, EventArgs e)
    {
        string link = "MyFrame.aspx?url=OtInfo.aspx?nobr=" + lblNobr.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:550px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = form1;" +
            "var txtDate = window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "OtInfo", script, true);
    }
}