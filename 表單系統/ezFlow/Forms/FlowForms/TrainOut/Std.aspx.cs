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

public partial class TrainOut_Std : System.Web.UI.Page
{
    //Flow
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();
    public FlowDSTableAdapters.wfUpFileTableAdapter wfUpFileTA = new FlowDSTableAdapters.wfUpFileTableAdapter();
    public FlowDSTableAdapters.wfJobSignTableAdapter wfJobSignTA = new FlowDSTableAdapters.wfJobSignTableAdapter();

    //Form
    public TrainDSTableAdapters.wfTrainAppMTableAdapter wfTrainAppMTA = new TrainDSTableAdapters.wfTrainAppMTableAdapter();
    public TrainDSTableAdapters.wfTrainAppSTableAdapter wfTrainAppSTA = new TrainDSTableAdapters.wfTrainAppSTableAdapter();
    public TrainDSTableAdapters.wfTrainSetTableAdapter wfTrainSetTA = new TrainDSTableAdapters.wfTrainSetTableAdapter();
    public TrainDSTableAdapters.TRCOSFTableAdapter TRCOSFTA = new TrainDSTableAdapters.TRCOSFTableAdapter();

    //DataSet
    public FlowDS oFlowDS;
    public TrainDS oTrainDS;

    //Row
    TrainDS.wfTrainSetRow rDef;

    public DataRow[] rows;

    //?idFlowTree=19&idRole_Start=T20000A7&idEmp_Start=96015&idRole_Agent=&idEmp_Agent=

    protected void Page_Load(object sender, EventArgs e)
    {
        oFlowDS = new FlowDS();
        oTrainDS = new TrainDS();

        lblMsg.Text = "";

        //帶入系統預設值
        wfTrainSetTA.Fill(oTrainDS.wfTrainSet);
        if (oTrainDS.wfTrainSet.Rows.Count == 0)
        {
            lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員(Default)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        rDef = (TrainDS.wfTrainSetRow)oTrainDS.wfTrainSet.Rows[0];
        lblNote.Text = rDef.sStdNote;

        if (!this.IsPostBack)
        {
            SetDefault();

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
            lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序

            ddlName.DataBind();
            txtName_TextChanged(null, null);

            //ScriptManager.RegisterClientScriptBlock(upl, typeof(string), "DateFormatScript", jbmodule.Web.ui.DateFormatScript(), true);
            //txtDate.Attributes.Add("onkeyup", "date_format('" + txtDate.ID + "')");
            //txtDateB.Attributes.Add("onkeyup", "date_format('" + txtDateB.ID + "')");
            //txtDateE.Attributes.Add("onkeyup", "date_format('" + txtDateE.ID + "')");

            txtDate.Text = DateTime.Now.ToShortDateString();
            txtDateB.Text = DateTime.Now.ToShortDateString();
            txtDateE.Text = DateTime.Now.ToShortDateString();
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

        setNumSum(lblNobr.Text);
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

            setNumSum(lblNobr.Text);
        }
    }

    public void setNumSum(string nobr)
    {
        rows = TRCOSFTA.GetDataByIDNO(nobr).Select();

        int num = 0, sum = 0;
        foreach (TrainDS.TRCOSFRow rt in rows)
        {
            if (DateTime.Now.Date.Year == rt.DATE_B.Year)
            {
                sum += Convert.ToInt32(rt.COS_FEE);
                num++;
            }
        }

        lblNum.Text = num.ToString();
        lblSum.Text = sum.ToString();
    }

    protected void lbtn_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;
        string link = "MyFrame.aspx?url=" + lbtn.CommandName + ".aspx?nobr=" + lblNobr.Text + "&id=" + lblProcessID.Text;
        string script = "var sFeatures = 'dialogWidth:750px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = " + Form.ClientID + ";" +
            "window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
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

        HrBaseData oHrBaseDataM, oHrBaseDataS;
        oHrBaseDataM = new HrBaseData(Request.QueryString["idEmp_Start"]);
        oHrBaseDataS = new HrBaseData(nobr);

        //檢查hr是否有相同資料

        //檢查flow是否有相同資料
        if (wfTrainAppSTA.GetDataByFlowCheck(nobr).Rows.Count > 0)
        {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (wfTrainAppSTA.GetDataByNowFlowCheck(lblProcessID.Text, nobr).Rows.Count > 0)
        {
            lblMsg.Text = "您已申請一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //從這裡開始新增資料
        wfTrainAppSTA.Fill(oTrainDS.wfTrainAppS);
        TrainDS.wfTrainAppSRow rs = oTrainDS.wfTrainAppS.NewwfTrainAppSRow();
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
        rs.iNum = int.Parse(lblNum.Text);
        rs.iSum = int.Parse(lblSum.Text);
        rs.iBudget = 0;// int.Parse(lblBudget.Text);
        rs.iCosfee = 0;
        rs.sState = "0";
        rs.bAuth = true;
        rs.bSign = true;
        rs.dKeyDate = DateTime.Now;
        oTrainDS.wfTrainAppS.AddwfTrainAppSRow(rs);
        wfTrainAppSTA.Update(oTrainDS.wfTrainAppS);

        gvAppS.DataBind();
    }

    protected void btnSign_Click(object sender, EventArgs e)
    {
        if (gvAppS.Rows.Count == 0 || gvAppS.Rows.Count > rDef.iAppCount)
        {
            lblMsg.Text = "至少需申請1筆資料或不可大於" + rDef.iAppCount.ToString() + "筆資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (txtCourseName.Text.Trim().Length == 0)
        {
            lblMsg.Text = "課程名稱為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        if (txtAim.Text.Trim().Length == 0)
        {
            lblMsg.Text = "課程效益為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        if (txtCompany.Text.Trim().Length == 0)
        {
            lblMsg.Text = "主辦單位為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (txtAddress.Text.Trim().Length == 0)
        {
            lblMsg.Text = "上課地點為必填欄位";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        int Charge = 0;
        try
        {
            Charge = Convert.ToInt32(txtCharge.Text);
        }
        catch
        {
            lblMsg.Text = "全部費用格式不正確";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        string CheckTitle = txtCheckTitle.Text;
        if (CheckTitle.Trim().Length == 0)
            CheckTitle = txtCompany.Text;

        //if (rblBounty.SelectedItem.Value == "0" && txtBounty.Text.Trim().Length == 0)
        //{
        //    lblMsg.Text = "選擇補助學雜費項目時，必需填入補助金額的百分比";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        decimal Bounty = 0;
        //try
        //{
        //    Bounty = Convert.ToDecimal(txtBounty.Text);
        //}
        //catch
        //{
        //    lblMsg.Text = "補助金額百分比格式不正確";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        //檢查日期
        DateTime date, dateB, dateE;
        try
        {
            date = DateTime.Parse(txtDate.Text).Date;
            dateB = DateTime.Parse(txtDateB.Text).Date;
            dateE = DateTime.Parse(txtDateE.Text).Date;
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
        }
        catch
        {
            lblMsg.Text = "時間格式不正確，請重新輸入。例：0930(兩個時間會同時判斷)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查結束時間是否比開始時間小
        DateTime datetimeB, datetimeE;
        datetimeB = dateB.AddMinutes(FlowCS.GetMinutes(txtTimeB.Text));
        datetimeE = dateE.AddMinutes(FlowCS.GetMinutes(txtTimeE.Text));
        if (datetimeB >= datetimeE)
        {
            lblMsg.Text = "結束日期時間不可小於等於申請日期時間";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (gvAppS.Rows.Count == 0)
        {
            lblMsg.Text = "您並未申請任何資料，請先申請至少一筆資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        decimal TotalHours = 0;
        try
        {
            TotalHours = Convert.ToDecimal(txtTotalHours.Text);
        }
        catch
        {
            lblMsg.Text = "總時數格式錯誤";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        string HrMail = ConfigurationSettings.AppSettings["HrMail"];

        string body = "";

        //預設一個暫存的陣列
        ArrayList alAppS = new ArrayList();
        wfTrainAppMTA.Fill(oTrainDS.wfTrainAppM);
        wfTrainAppSTA.FillByProcessID(oTrainDS.wfTrainAppS, lblProcessID.Text);
        wfUpFileTA.FillByProcessID(oFlowDS.wfUpFile, lblProcessID.Text);

        if (oFlowDS.wfUpFile.Rows.Count == 0)
        {
            lblMsg.Text = "您至少需要上傳一份附件";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseDataM, oHrBaseDataS;

        localhost.Service oService = new localhost.Service();

        string Key, RoleID;
        bool isPassAll = false; //是否有通過
        int iError = 0; //失敗筆數
        int iOK = 1;    //成功筆數
        string nobr = "";
        int i = 0;

        int trScount = oTrainDS.wfTrainAppS.Rows.Count;
        int sum = 0, diff = 0, diff1 = 0;
        diff = Charge / trScount;
        sum = diff * trScount;
        diff1 = (Charge - sum) + diff;

        //流程從這裡開始
        lblProcessID.Text = oService.GetProcessID().ToString();

        //找出相同的關鍵來傳送流程
        rows = oTrainDS.wfTrainAppS.Select("");
        foreach (TrainDS.wfTrainAppSRow r in rows)
        {
            RoleID = r.sDept + r.sJob;
            r.sProcessID = lblProcessID.Text;
            r.idProcess = int.Parse(lblProcessID.Text);
            r.sState = "1";   //啟動流程為簽核狀態
            //rs1.dKeyDate = DateTime.Now;    //重新更改簽核正確時間

            //當角色不同時，就將資料寫入ProcessFlowShare
            oService.FlowShare(int.Parse(lblProcessID.Text), RoleID, r.sNobr);

            //附加檔案
            rows = oFlowDS.wfUpFile.Select();
            foreach (FlowDS.wfUpFileRow rf in rows)
            {
                rf.sProcessID = lblProcessID.Text;
                rf.idProcess = int.Parse(lblProcessID.Text);
            }

            nobr = r.sNobr;

            r.iCosfee = (i == 0) ? diff1 : diff;
            i++;
        }

        oHrBaseDataM = new HrBaseData(Request["idEmp_Start"]);
        oHrBaseDataS = new HrBaseData(nobr);
        RoleID = oHrBaseDataS.sDept + oHrBaseDataS.sJob;

        TrainDS.wfTrainAppMRow rm = oTrainDS.wfTrainAppM.NewwfTrainAppMRow();
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
        rm.bAuth = oHrBaseDataS.bMang; //是否是主管
        rm.bSign = true;
        rm.sState = "1";
        rm.dDate = date;
        rm.sCourseName = txtCourseName.Text;
        rm.sCourseType = "2";//rblCourseType.SelectedItem.Value;  //內外訓
        rm.dDateTimeB = datetimeB;
        rm.dDateTimeE = datetimeE;
        rm.sTimeB = txtTimeB.Text;
        rm.sTimeE = txtTimeE.Text;
        rm.iTotalHours = TotalHours;
        rm.sCompany = txtCompany.Text.Trim();
        rm.sCheckTitle = CheckTitle;
        rm.sAddress = txtAddress.Text.Trim();
        rm.sTcrName1 = lblTcr1.Text;
        rm.sTcrName2 = lblTcr2.Text;
        rm.sTcrName3 = lblTcr3.Text;
        rm.sTcrName4 = lblTcr4.Text;
        rm.sTcrName5 = lblTcr5.Text;
        rm.iCharge = Charge;
        rm.iBounty = Bounty / 100;
        rm.sPayment = rblPayment.SelectedItem.Text;
        rm.sBank = txtBank.Text.Trim();
        rm.sBranch = txtBranch.Text.Trim();
        rm.sAccount = txtAccount.Text.Trim();
        //rm.sAllot = txtAllot.Text.Trim();
        //rm.sCertificate = rblCertificate.SelectedItem.Text;
        rm.sCertificate = "";
        rm.sSignup = rblSignup.SelectedItem.Text;
        rm.sSignupMe = rblSignupMe.SelectedItem.Value;
        rm.sAim = txtAim.Text;
        rm.sBakerday = "0";
        rm.sReserve1 = convertNum(rm.iCharge);
        rm.sConditions1 = rm.iCateOrder.ToString(); //目前所簽核到的部門
        rm.sConditions5 = "";
        oTrainDS.wfTrainAppM.AddwfTrainAppMRow(rm);

        try
        {
            body = "[AppM];";
            foreach (DataColumn dc in oTrainDS.wfTrainAppM.Columns)
            {
                if (rm[dc] != null)
                    body += dc.ToString() + "=" + rm[dc].ToString() + ";";
            }

            body += "[AppS];";
            foreach (DataColumn dc in oTrainDS.wfTrainAppS.Columns)
            {
                if (oTrainDS.wfTrainAppS.Rows[0][dc] != null)
                    body += dc.ToString() + "=" + oTrainDS.wfTrainAppS.Rows[0][dc].ToString() + ";";
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
            wfTrainAppMTA.Update(oTrainDS.wfTrainAppM);
            wfTrainAppSTA.Update(oTrainDS.wfTrainAppS);
            wfUpFileTA.Update(oFlowDS.wfUpFile);

            FlowCS.SendMail(HrMail, "02;TrainOut;" + lblProcessID.Text + ";" + rm.sConditions5 + ";", body);
            lblMsg.Text = "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');close();", true);
        }
        else
        {
            lblMsg.Text = iError > 0 ? "有部份流程傳送失敗" : "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }

        //if (oService.FlowStart(int.Parse(lblProcessID.Text), Request["idFlowTree"], RoleID, oHrBaseDataS.sNobr, Request["idRole_Start"], Request["idEmp_Start"]))
        //{
        //    wfTrainAppMTA.Update(oTrainDS.wfTrainAppM);
        //    wfTrainAppSTA.Update(oTrainDS.wfTrainAppS);
        //    wfUpFileTA.Update(oFlowDS.wfUpFile);
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "';", true);
        //}
        //else
        //{
        //    lblMsg.Text = "流程傳送失敗";
        //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        //    return;
        //}

        lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
        lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序
    }

    //protected void rblBounty_SelectedIndexChanged(object sender, EventArgs e)
    //{
    //    if (rblBounty.SelectedItem.Value == "1")
    //    {
    //        txtBounty.Text = "100";
    //    }
    //    else
    //    {
    //        txtBounty.Text = "0";
    //    }

    //    txtBounty_TextChanged(sender, e);
    //}

    //protected void txtBounty_TextChanged(object sender, EventArgs e)
    //{
    //    if (txtBounty.Text != "100")
    //    {
    //        if (txtCharge.Text.Trim().Length > 0 && txtBounty.Text.Trim().Length > 0)
    //        {
    //            try
    //            {
    //                double a = double.Parse(txtCharge.Text);
    //                double b = double.Parse(txtBounty.Text);
    //                double c = 100;
    //                double d = (a * b) / c;
    //                string f = Convert.ToString(Math.Round(a - d, 0));
    //                f = (f.Length >= 3) ? f.Substring(0, f.Length - 2) + "00" : f;

    //                lblPartP.Text = f;

    //                double g = a - int.Parse(f);

    //                lblPartCom.Text = g.ToString();
    //            }
    //            catch
    //            {

    //                lblMsg.Text = "輸入格式不正確請重新輸入";
    //                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    //                return;
    //            }
    //        }

    //        rblBounty.ClearSelection();
    //        rblBounty.Items.FindByValue("0").Selected = true;
    //    }
    //    else
    //    {
    //        lblPartP.Text = "0";
    //        lblPartCom.Text = txtCharge.Text;
    //    }
    //}

    //零壹貳參肆伍陸柒捌玖拾
    public string convertNum(int num)
    {
        string[] chFont = { "零", "壹", "貳", "參", "肆", "伍", "陸", "柒", "捌", "玖", "拾" };
        string[] chLv = { "", "拾", "佰", "仟", "萬" };
        string numS, numS1;
        string ch = "";
        int numCount = num.ToString().Length - 1;
        int j = 0;

        for (int i = 0; i <= numCount; i++)
        {
            numS1 = "0";
            j = i + 1;
            numS = num.ToString().Substring(i, 1);
            if (j <= numCount) numS1 = num.ToString().Substring(j, 1);


            if ((numCount - i) > 4)
            {
                ch += chFont[int.Parse(numS)] + chLv[numCount - 4 - i];
            }
            else
            {
                ch += chFont[int.Parse(numS)] + chLv[numCount - i];
            }
        }

        return ch + "元整";
    }
    
}