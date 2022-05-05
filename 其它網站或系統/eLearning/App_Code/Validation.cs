using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;

/// <summary>
/// Validation 的摘要描述
/// </summary>
public class ValidationObject
{
    public ValidationObject()
    {
        //
        // TODO: 在此加入建構函式的程式碼
        //
    }

    #region < ValChkCode > 取得檢核碼
    public string ValChkCode
    {
        get
        {
            HttpContext context = HttpContext.Current;
            return context.Session["_ValCheckCode"] == null ? "" : context.Session["_ValCheckCode"] as string;
        }
    }
    #endregion

    #region [ Check ] 驗證檢核碼
    public bool Check(string sChkCode)
    {
        return sChkCode.Trim() == this.ValChkCode ? true : false;
    }
    #endregion
}