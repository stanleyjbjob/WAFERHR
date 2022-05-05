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

public partial class TrLearned_Set : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
    }

    protected void DV_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
    {
        try
        {
            //資料檢查
            if (e.NewValues["iCntMinLnth"] == null)
                throw new Exception("課程內容的最小長度設定不正確");
            TrLearnCS.InputCheck(e.NewValues["iCntMinLnth"].ToString(), TrLearnCS.InputType.Integer, "課程內容的最小長度設定不正確");
            if (e.NewValues["iCntMaxLnth"] == null)
                throw new Exception("課程內容的最大長度設定不正確");
            TrLearnCS.InputCheck(e.NewValues["iCntMaxLnth"].ToString(), TrLearnCS.InputType.Integer, "課程內容的最大長度設定不正確");
            if (e.NewValues["iLndMinLnth"] == null)
                throw new Exception("心得報告的最小長度設定不正確");
            TrLearnCS.InputCheck(e.NewValues["iLndMinLnth"].ToString(), TrLearnCS.InputType.Integer, "心得報告的最小長度設定不正確");
            if (e.NewValues["iLndMaxLnth"] == null)
                throw new Exception("心得報告的最大長度設定不正確");
            TrLearnCS.InputCheck(e.NewValues["iLndMaxLnth"].ToString(), TrLearnCS.InputType.Integer, "心得報告的最大長度設定不正確");
            if (e.NewValues["iRsnMinLnth"] == null)
                throw new Exception("評比理由的最小長度設定不正確");
            TrLearnCS.InputCheck(e.NewValues["iRsnMinLnth"].ToString(), TrLearnCS.InputType.Integer, "評比理由的最小長度設定不正確");
            if (e.NewValues["iRsnMaxLnth"] == null)
                throw new Exception("評比理由的最大長度設定不正確");
            TrLearnCS.InputCheck(e.NewValues["iRsnMaxLnth"].ToString(), TrLearnCS.InputType.Integer, "評比理由的最大長度設定不正確");

            e.NewValues["sStdNote"] = (e.NewValues["sStdNote"] == null) ? "" : e.NewValues["sStdNote"];
            e.NewValues["sKeyMan"] = Request.QueryString["idEmp_Start"];
            e.NewValues["dKeyDate"] = DateTime.Now;
        }
        catch (Exception ex)
        {
            lblMsg.Text = ex.Message;
            ScriptManager.RegisterStartupScript(up1, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            e.Cancel = true;
        }
    }
    protected void DV_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
    {
        lblMsg.Text = "更新完成";
        ScriptManager.RegisterStartupScript(up1, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }
}
