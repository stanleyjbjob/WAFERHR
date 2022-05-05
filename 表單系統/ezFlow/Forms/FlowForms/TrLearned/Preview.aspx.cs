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

public partial class TrLearned_Preview : System.Web.UI.Page
{
    HrDSTableAdapters.TRLEARNEDTableAdapter Hr_TrlearnedTA = new HrDSTableAdapters.TRLEARNEDTableAdapter();
    HrDS.TRLEARNEDDataTable Hr_TrlearnedDT = new HrDS.TRLEARNEDDataTable();
    HrDS.TRLEARNEDRow Hr_TrlearnedRow;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.QueryString["idProcess"] != null)
                Hr_TrlearnedTA.FillByProcess(Hr_TrlearnedDT, Request.QueryString["idProcess"]);
            if (!(Hr_TrlearnedDT == null))
            {
                if (Hr_TrlearnedDT.Rows.Count > 0)
                {
                    TrLearnedDS.wfTrLearnedSetRow TrLnSetRow = TrLearnCS.GetTrLearnedSet();
                    Hr_TrlearnedRow = Hr_TrlearnedDT.Rows[0] as HrDS.TRLEARNEDRow;
                    lblAddress.Text = Hr_TrlearnedRow.sAddress;
                    lblContent.Text = Hr_TrlearnedRow.sContent;
                    lblCourseName.Text = Hr_TrlearnedRow.sCourseName;
                    lblDateB.Text = Hr_TrlearnedRow.dDateB.ToShortDateString();
                    lblDateE.Text = Hr_TrlearnedRow.dDateE.ToShortDateString();
                    lblTimeB.Text = Hr_TrlearnedRow.sTimeB;
                    lblTimeE.Text = Hr_TrlearnedRow.sTimeE;
                    lblFormName.Text = TrLnSetRow.sPvwFormName;
                    lblLearned.Text = Hr_TrlearnedRow.sLearned;
                    lblMangAppraise.Text = Hr_TrlearnedRow.IssMangAppraiseNull() ? "" : Hr_TrlearnedRow.sMangAppraise;                   
                    lblReason.Text = Hr_TrlearnedRow.sReason;
                    lblTcr1.Text = Hr_TrlearnedRow.sTcrName1;
                    lblTcr2.Text = Hr_TrlearnedRow.sTcrName2;
                    lblTcr3.Text = Hr_TrlearnedRow.sTcrName3;
                    lblTcr4.Text = Hr_TrlearnedRow.sTcrName4;
                    lblTcr5.Text = Hr_TrlearnedRow.sTcrName5;
                    rblEffor1.SelectedValue = Hr_TrlearnedRow.sEffor1;
                    rblEffor2.SelectedValue = Hr_TrlearnedRow.sEffor2;
                    lblEffor1.Text = rblEffor1.SelectedItem.Text;
                    lblEffor2.Text = rblEffor2.SelectedItem.Text;
                    rblComment.SelectedValue = Hr_TrlearnedRow.sComment;
                    lblComment.Text = rblComment.SelectedItem.Text;
                    lblTitle.Text=TrLnSetRow.sPvwTitle;
                    lblTitleE.Text = TrLnSetRow.sPvwTitleE;
                    lblFormNo.Text = TrLnSetRow.sPvwFormNo;
                    lblFlow.Text = TrLnSetRow.sPvwFlow;
                    lblEdition.Text = TrLnSetRow.sPvwEdition;
                    lblSaveUnit.Text = TrLnSetRow.sPvwSaveUnit;
                    imgLogo.ImageUrl = TrLnSetRow.sPvwLogoPath;
                    lblTitle.Font.Size = new FontUnit(TrLnSetRow.sPvwTitleSize);
                }
            }
        }
    }
    protected void btnPrint_Click(object sender, EventArgs e)
    {
        
    }
}
