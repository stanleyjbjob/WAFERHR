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

public partial class Booking_Std : System.Web.UI.Page
{
    //Form
    BookingDSTableAdapters.wfBookingClassTableAdapter wfBookingClassTA = new BookingDSTableAdapters.wfBookingClassTableAdapter();
    BookingDSTableAdapters.wfBookingTypeTableAdapter wfBookingTypeTA = new BookingDSTableAdapters.wfBookingTypeTableAdapter();
    BookingDSTableAdapters.wfBookingSetTableAdapter wfBookingSetTA = new BookingDSTableAdapters.wfBookingSetTableAdapter();
    BookingDSTableAdapters.wfBookingAppMTableAdapter wfBookingAppMTA = new BookingDSTableAdapters.wfBookingAppMTableAdapter();
    BookingDSTableAdapters.wfBookingAppSTableAdapter wfBookingAppSTA = new BookingDSTableAdapters.wfBookingAppSTableAdapter();
    BookingDSTableAdapters.wfBookingTableAdapter wfBookingTA = new BookingDSTableAdapters.wfBookingTableAdapter();

    //DataSet
    public BookingDS oBookingDS;

    //Row
    public BookingDS.wfBookingSetRow rDef;

    public DataRow[] rows;

    //?idFlowTree=19&idRole_Start=T20000A7&idEmp_Start=96015&idRole_Agent=&idEmp_Agent=

    protected void Page_Load(object sender, EventArgs e)
    {
        oBookingDS = new BookingDS();

        lblMsg.Text = "";

        //帶入系統預設值
        wfBookingSetTA.Fill(oBookingDS.wfBookingSet);
        if (oBookingDS.wfBookingSet.Rows.Count == 0)
        {
            lblMsg.Text = "系統發生嚴重的錯誤，請通知管理人員(Default)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        rDef = (BookingDS.wfBookingSetRow)oBookingDS.wfBookingSet.Rows[0];
        lblNote.Text = rDef.sStdNote;

        if (!this.IsPostBack)
        {
            SetDefault();

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
            lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序

            ddlName.DataBind();
            txtName_TextChanged(null, null);

            txtDateB.Text = DateTime.Now.ToShortDateString();
            txtDateE.Text = txtDateB.Text;
            txtTimeB.Text = "0830";
            txtTimeE.Text = "1730";
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
    }


    protected void txtDate_TextChanged(object sender, EventArgs e)
    {
        DateTime dateB, dateE;

        try
        {
            dateB = DateTime.Parse(txtDateB.Text);

            if (((TextBox)sender).ID == "txtDateB")
            {
                txtDateE.Text = txtDateB.Text;
            }
            else
            {
                dateE = DateTime.Parse(txtDateE.Text);
            }
        }
        catch
        {
            lblMsg.Text = "日期格式不正確，請重新輸入。例：1979/12/3(兩個日期會同時判斷)";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
    }

    protected void ddlClass_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblLv.Text = "0";
        rows = wfBookingClassTA.GetDataByClassCode(ddlClass.SelectedItem.Value).Select();
        if (rows.Length > 0)
        {
            BookingDS.wfBookingClassRow rc = (BookingDS.wfBookingClassRow)rows[0];
            lblLv.Text = rc.iLv.ToString();
        }
    }
    protected void ddlType_SelectedIndexChanged(object sender, EventArgs e)
    {
        lblDesc.Text = "";
        rows = wfBookingTypeTA.GetDataByTypeCode(ddlClass.SelectedItem.Value, ddlType.SelectedItem.Value).Select();
        if (rows.Length > 0)
        {
            BookingDS.wfBookingTypeRow rt = (BookingDS.wfBookingTypeRow)rows[0];
            lblDesc.Text = rt.sNote;
        }
    }

    protected void lbtnS_Click(object sender, EventArgs e)
    {
        string link = "MyFrame.aspx?url=Calendar.aspx";
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
            BookingDS.wfBookingAppSRow rs = (BookingDS.wfBookingAppSRow)wfBookingAppSTA.GetData().Select("iAutoKey = " + int.Parse(CommandArgument))[0];
            wfBookingAppSTA.Update(rs);
            gvAppS.DataBind();
        }
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string nobr = lblNobr.Text.Trim();
        string ClassCode = ddlClass.SelectedItem.Value;
        string TypeCode = ddlType.SelectedItem.Value;

        //選擇型號
        if (ddlType.SelectedItem.Value == "000000")
        {
            lblMsg.Text = "請先選擇正確的設施或設備再選擇正確的(型/車/編/料)號";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

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

        //檢查事由是否需要輸入且空白
        if (txtNote.Text.Length == 0 && rDef.bNote)
        {
            lblMsg.Text = "事由一定要輸入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        HrBaseData oHrBaseDataM, oHrBaseDataS;
        oHrBaseDataM = new HrBaseData(Request.QueryString["idEmp_Start"]);
        oHrBaseDataS = new HrBaseData(nobr);

        //檢查hr是否有相同資料
        if (wfBookingTA.GetDataByKey(datetimeE, datetimeB, ClassCode, TypeCode).Rows.Count > 0)
        {
            lblMsg.Text = "人事單位中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //檢查flow是否有相同資料
        if (wfBookingAppSTA.GetDataByFlowCheck(datetimeE, datetimeB, ClassCode, TypeCode).Rows.Count > 0)
        {
            lblMsg.Text = "流程中已有一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (wfBookingAppSTA.GetDataByNowFlowCheck(datetimeE, datetimeB, lblProcessID.Text, ClassCode, TypeCode).Rows.Count > 0)
        {
            lblMsg.Text = "您已申請一筆相同的資料";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //從這裡開始新增資料
        wfBookingAppSTA.Fill(oBookingDS.wfBookingAppS);
        BookingDS.wfBookingAppSRow rs = oBookingDS.wfBookingAppS.NewwfBookingAppSRow();
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
        rs.dEndDate = dateE.Date;
        rs.sStrTime = txtTimeB.Text;
        rs.sEndTime = txtTimeE.Text;
        rs.sClassCode = ClassCode;
        rs.sClassName = ddlClass.SelectedItem.Text;
        rs.sTypeCode = TypeCode;
        rs.sTypeName = ddlType.SelectedItem.Text;
        rs.sCatCode = ddlCat.SelectedItem.Value;
        rs.sCatName = ddlCat.SelectedItem.Text;
        rs.bSign = true;
        rs.sState = "0";
        rs.bAuth = true;
        rs.sNote = txtNote.Text.Trim();
        rs.dKeyDate = DateTime.Now;
        oBookingDS.wfBookingAppS.AddwfBookingAppSRow(rs);
        wfBookingAppSTA.Update(oBookingDS.wfBookingAppS);

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

        //預設一個暫存的陣列
        ArrayList alAppS = new ArrayList();
        wfBookingAppMTA.Fill(oBookingDS.wfBookingAppM);
        wfBookingAppSTA.FillByProcessID(oBookingDS.wfBookingAppS, lblProcessID.Text);

        HrBaseData oHrBaseDataM, oHrBaseDataS;

        localhost.Service oService = new localhost.Service();

        //以部門+職稱+天數=關鍵來決定流程走向 , 角色 , 工號
        string Key, RoleID;
        bool isPassAll = false; //是否有通過
        int iError = 0; //失敗筆數
        int iOK = 0;    //成功筆數
        foreach (BookingDS.wfBookingAppSRow rs in oBookingDS.wfBookingAppS.Rows)
        {
            Key = rs.sDept + rs.sJob;
            RoleID = rs.sDept + rs.sJob;
            if (!alAppS.Contains(Key))
            {
                //流程從這裡開始
                lblProcessID.Text = oService.GetProcessID().ToString();

                //找出相同的關鍵來傳送流程
                rows = oBookingDS.wfBookingAppS.Select("sDept = '" + rs.sDept + "' AND sJob = '" + rs.sJob + "'");
                foreach (BookingDS.wfBookingAppSRow r in rows)
                {
                    r.sProcessID = lblProcessID.Text;
                    r.idProcess = int.Parse(lblProcessID.Text);
                    r.sState = "1";   //啟動流程為簽核狀態
                    //rs1.dKeyDate = DateTime.Now;    //重新更改簽核正確時間

                    //當角色不同時，就將資料寫入ProcessFlowShare
                    if (Request["idRole_Start"] != RoleID)
                        oService.FlowShare(int.Parse(lblProcessID.Text), RoleID, r.sNobr);
                }

                oHrBaseDataM = new HrBaseData(Request["idEmp_Start"]);
                oHrBaseDataS = new HrBaseData(rs.sNobr);

                BookingDS.wfBookingAppMRow rm = oBookingDS.wfBookingAppM.NewwfBookingAppMRow();
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
                rm.dDateA = DateTime.Now;
                rm.bAuth = oHrBaseDataS.bMang; //是否是主管
                rm.bSign = true;
                rm.iItemLv = int.Parse(lblLv.Text); //物品等級
                rm.bBooking = true;
                rm.sState = "1";
                rm.sReserve1 = lblDesc.Text;    //型號備註
                rm.sConditions1 = rm.iCateOrder.ToString(); //目前所簽核到的部門
                rm.sConditions2 = rs.sClassCode;    //物品類別
                rm.sConditions3 = rs.sTypeCode; //物品型號
                oBookingDS.wfBookingAppM.AddwfBookingAppMRow(rm);

                try
                {
                    //流程序 流程樹 角色代碼 工號 申請者角色代碼 申請者工號
                    //(oService.FlowStart(iProcessID, Request["idFlowTree"], "請假人角色代碼", "請假人工號", Request["idRole_Agent"], Request["idEmp_Agent"]))
                    isPassAll = oService.FlowStart(int.Parse(lblProcessID.Text), Request["idFlowTree"], RoleID, rs.sNobr, Request["idRole_Start"], Request["idEmp_Start"]);
                    iOK++;
                }
                catch
                {
                    isPassAll = false;
                }

                if (isPassAll)
                {
                    wfBookingAppMTA.Update(oBookingDS.wfBookingAppM);
                    wfBookingAppSTA.Update(oBookingDS.wfBookingAppS);
                }
                else
                {
                    iError++;
                    oBookingDS.wfBookingAppM.AcceptChanges();
                    oBookingDS.wfBookingAppS.AcceptChanges();
                }

                alAppS.Add(Key);    //暫存關鍵
            }
        }

        if (iOK == 1)
        {
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您的申請單已成功送出了');self.location = '../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "';", true);
        }
        else
        {
            lblMsg.Text = iError > 0 ? "有部份流程傳送失敗" : "流程傳送成功";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }

        lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"] : lblNobr.Text;
        lblProcessID.Text = DateTime.Now.Ticks.ToString() + "-" + lblNobr.Text;  //以時間唯一值決定一個暫定的流程序
    }
}
