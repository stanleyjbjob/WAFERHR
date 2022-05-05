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

public partial class FlowForms_TrLearn_Std : System.Web.UI.Page
{
    TrLearnedDSTableAdapters.wfTrLearnedAppMTableAdapter TrLearnAppMTA = new TrLearnedDSTableAdapters.wfTrLearnedAppMTableAdapter();
    TrLearnedDS.wfTrLearnedAppMDataTable TrLearnAppMDT = new TrLearnedDS.wfTrLearnedAppMDataTable();
    TrLearnedDS.wfTrLearnedAppMRow TrLearnAppMRow;

    protected void Page_Load(object sender, EventArgs e)//讀取頁面
    {
        lblNote.Text = TrLearnCS.GetTrLearnedSet().sStdNote;
        lblMsg.Text = "";
    }
    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)//課程名稱變更選取
    {
        TrainDS.TRCOSFRow trRow = TrLearnCS.Get_dtTRCOSF_BY_IDNOandAPPLYNO(Request.QueryString["idEmp_Start"], ddlCourse.SelectedValue);//依idno及ApplyNO取出資料
        if (trRow == null)
        {
            txtDateB.Text = "";
            txtTimeB.Text = "";
            txtDateE.Text = "";
            txtTimeE.Text = "";
            return;
        }
        //帶入訓練資料
        txtDateB.Text = trRow.DATE_B.ToShortDateString();
        txtTimeB.Text = FlowCS.GetTimeSplit(trRow.DATE_B);
        txtDateE.Text = trRow.DATE_E.ToShortDateString();
        txtTimeE.Text = FlowCS.GetTimeSplit(trRow.DATE_E);
        txtAddress.Text = trRow.TR_COMP.Trim();
        lblTcr1.Text = trRow.SCHLL.Trim();
    }
    protected void btnSign_Click(object sender, EventArgs e)//送出傳簽
    {
        //資料檢查
        try
        {
            TrLearnCS.InputCheck(txtDateB.Text, TrLearnCS.InputType.DateTime, "課程的開始日期格式不正確");
            TrLearnCS.InputCheck(txtTimeB.Text, TrLearnCS.InputType.Time, "課程的開始時間格式不正確");
            TrLearnCS.InputCheck(txtDateE.Text, TrLearnCS.InputType.DateTime, "課程的結束日期格式不正確");
            TrLearnCS.InputCheck(txtTimeE.Text, TrLearnCS.InputType.Time, "課程的結束時間格式不正確");
            TrLearnCS.InputCheck(txtAddress.Text, TrLearnCS.InputType.NotNull, "上課地點不可為空白");
            TrLearnCS.InputCheck(txtContent.Text, TrLearnCS.GetTrLearnedSet().iCntMaxLnth, true, "1.課程內容不可超過" + TrLearnCS.GetTrLearnedSet().iCntMaxLnth.ToString() + "個字。目前的輸入資料的長度為" + txtContent.Text.Length.ToString());
            TrLearnCS.InputCheck(txtContent.Text, TrLearnCS.GetTrLearnedSet().iCntMinLnth, false, "1.課程內容不可少於" + TrLearnCS.GetTrLearnedSet().iCntMinLnth.ToString() + "個字。目前的輸入資料的長度為" + txtContent.Text.Length.ToString());
            TrLearnCS.InputCheck(txtLearned.Text, TrLearnCS.GetTrLearnedSet().iLndMaxLnth, true, "2.心得報告不可超過" + TrLearnCS.GetTrLearnedSet().iLndMaxLnth.ToString() + "個字。目前的輸入資料的長度為" + txtLearned.Text.Length.ToString());
            TrLearnCS.InputCheck(txtLearned.Text, TrLearnCS.GetTrLearnedSet().iLndMinLnth, false, "2.心得報告不可少於" + TrLearnCS.GetTrLearnedSet().iLndMinLnth.ToString() + "個字。目前的輸入資料的長度為" + txtLearned.Text.Length.ToString());
            TrLearnCS.InputCheck(txtReason.Text, TrLearnCS.GetTrLearnedSet().iRsnMaxLnth, true, "3.成果-評比的理由不可超過" + TrLearnCS.GetTrLearnedSet().iRsnMaxLnth.ToString() + "個字。目前的輸入資料的長度為" + txtReason.Text.Length.ToString());
            TrLearnCS.InputCheck(txtReason.Text, TrLearnCS.GetTrLearnedSet().iRsnMinLnth, false, "3.成果-評比的理由不可少於" + TrLearnCS.GetTrLearnedSet().iRsnMinLnth.ToString() + "個字。目前的輸入資料的長度為" + txtReason.Text.Length.ToString());
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        //寫入wfTrLearnedAppM
        TrLearnAppMRow = TrLearnAppMDT.NewwfTrLearnedAppMRow();
        HrBaseData Hrbase = new HrBaseData(Request.QueryString["idEmp_Start"]);
        //檢查是否有重複的資料（以nobr及applyno為主鍵）
        if (Convert.ToInt32(TrLearnAppMTA.GetTrLearnedCount(ddlCourse.SelectedValue, Hrbase.sNobr)) > 0)
        {
            lblMsg.Text = "此筆記錄已存在";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }
        //填表人資料
        TrLearnAppMRow.sNobr = Hrbase.sNobr;
        TrLearnAppMRow.sName = Hrbase.sName;
        TrLearnAppMRow.sJob = Hrbase.sJob;
        TrLearnAppMRow.sJobName = Hrbase.sJobName;
        TrLearnAppMRow.sJobl = Hrbase.sJobl;
        TrLearnAppMRow.sJoblName = Hrbase.sJoblName;
        TrLearnAppMRow.sDept = Hrbase.sDept;
        TrLearnAppMRow.sDeptName = Hrbase.sDeptName;
        //流程序
        localhost.Service oService = new localhost.Service();
        TrLearnAppMRow.idProcess = oService.GetProcessID();
        TrLearnAppMRow.sProcessID = TrLearnAppMRow.idProcess.ToString();
        lblProcessID.Text = TrLearnAppMRow.sProcessID;
        //心得報告內容
        TrLearnAppMRow.sApplyNo = ddlCourse.SelectedValue;
        TrLearnAppMRow.sCourseName = ddlCourse.SelectedItem.Text;
        TrLearnAppMRow.dDateB = Convert.ToDateTime(txtDateB.Text + " " + FlowCS.GetTimeSplit(txtTimeB.Text));
        TrLearnAppMRow.dDateE = Convert.ToDateTime(txtDateE.Text + " " + FlowCS.GetTimeSplit(txtTimeE.Text));
        TrLearnAppMRow.sTimeB = txtTimeB.Text;
        TrLearnAppMRow.sTimeE = txtTimeE.Text;
        TrLearnAppMRow.sAddress = txtAddress.Text;
        TrLearnAppMRow.sTcrName1 = lblTcr1.Text;
        TrLearnAppMRow.sTcrName2 = lblTcr2.Text;
        TrLearnAppMRow.sTcrName3 = lblTcr3.Text;
        TrLearnAppMRow.sTcrName4 = lblTcr4.Text;
        TrLearnAppMRow.sTcrName5 = lblTcr5.Text;
        TrLearnAppMRow.sContent = txtContent.Text;
        TrLearnAppMRow.sLearned = txtLearned.Text;
        TrLearnAppMRow.sEffor1 = rblEffor1.SelectedValue;
        TrLearnAppMRow.sEffor2 = rblEffor2.SelectedValue;
        TrLearnAppMRow.sComment = rblComment.SelectedValue;
        TrLearnAppMRow.sReason = txtReason.Text;
        TrLearnAppMRow.iTotalHour = TrLearnCS.GetTimeSpan(TrLearnAppMRow.dDateB, TrLearnAppMRow.dDateE);
        TrLearnAppMRow.sKeyMan = Request.QueryString["idEmp_Start"];
        TrLearnAppMRow.dKeyDate = DateTime.Now;
        //狀態值  
        TrLearnAppMRow.bAuth = false;
        TrLearnAppMRow.bSign = false;
        TrLearnAppMRow.sState = "1";
        string HrMail = ConfigurationSettings.AppSettings["HrMail"];
        //寫入資料庫並寄發通知信
        try
        {
            //回填到資料庫
            TrLearnAppMDT.AddwfTrLearnedAppMRow(TrLearnAppMRow);
            TrLearnAppMTA.Update(TrLearnAppMDT);
            //發信
            string body = "";
            body = "[AppM];";
            foreach (DataColumn dc in TrLearnAppMDT.Columns)
            {
                if (TrLearnAppMRow[dc] != null)
                    body += dc.ToString() + "=" + TrLearnAppMRow[dc].ToString() + ";";
            }
            FlowCS.SendMail(HrMail, "02;TrLearned;" + lblProcessID.Text + ";" , body);

            lblMsg.Text = "心得報告以成功送出";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }


    }

}
