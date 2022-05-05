using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// LoginCS 的摘要描述
/// </summary>
public class LoginCS
{
	public LoginCS()
	{
		//
		// TODO: 在此加入建構函式的程式碼
		//
	}

    //取得每頁的標題
    public static string GetPageTitle(string sFileName)
    {
        SysDSTableAdapters.sysFileStructureTableAdapter sysFileStructureTA = new SysDSTableAdapters.sysFileStructureTableAdapter();
        DataRow[] rows = sysFileStructureTA.GetData().Select("sFileName = '" + sFileName + "'");
        return rows.Length > 0 ? "eLearning - " + rows[0]["sFileTitle"].ToString() : "eLearning";       
    }

    //判斷權限
    public static bool IsAuth(string sFileName, int iRoleKey)
    {
        SysDSTableAdapters.sysFileStructureTableAdapter sysFileStructureTA = new SysDSTableAdapters.sysFileStructureTableAdapter();
        DataRow[] rows = sysFileStructureTA.GetData().Select("sFileName = '" + sFileName + "'");
        return ((rows.Length > 0) && ((Convert.ToInt32(rows[0]["sysRole_iKey"]) & iRoleKey) == iRoleKey));
    }
}
