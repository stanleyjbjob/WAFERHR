using System;
using System.Collections;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Web;
using System.Web.SessionState;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class error : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string strCode, strMsg, strSource;
       
        strSource = Request.QueryString["aspxerrorpath"];
        try
        {
            strCode = Utilities.LastError.InnerException.Source;
            strMsg = Utilities.LastError.InnerException.Message;
        }
        catch 
        {
            strCode = "";
            strMsg = "";
        
        }
        
        lb_strSource.Text = strSource;
        lb_strCode.Text = strCode;
        lb_strMsg.Text = strMsg;
 
        log4net.ILog logger = log4net.LogManager.GetLogger("MyProject");  
        //set user to log4net context, so we can use %X{user} in the appenders 
        if (HttpContext.Current.User != null && HttpContext.Current.User.Identity.IsAuthenticated)  
           log4net.MDC.Set("user", HttpContext.Current.User.Identity.Name);

       log4net.MDC.Set("Program", strSource);
       if (logger.IsErrorEnabled)
           logger.Error(strMsg); //now log error

       
    }
}
