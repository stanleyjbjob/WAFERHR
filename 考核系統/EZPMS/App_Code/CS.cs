using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;

/// <summary>
/// CS 的摘要描述
/// </summary>
public class CS
{
	public CS()
	{
		//
		// TODO: 在此加入建構函式的程式碼
		//
	}

    static public void showScriptAlert(Page p,string txt) {
        p.ClientScript.RegisterClientScriptBlock(typeof(string), "key", "alert('" + txt + "');", true);

    }

    static public void showScriptAlert(System.Web.UI.UpdatePanel up, string txt)
    {
         ScriptManager.RegisterStartupScript(up, typeof(UpdatePanel), "key", "alert('"+txt+"');", true);


    }

    static public void Scrip(System.Web.UI.UpdatePanel up,string app) 
    {
        string txt = "";
        txt += "var szUrl;";
        txt += "var szFeatures;";
        txt += "var szName;";
        txt += "var temp;";
        txt += "szUrl = 'dialog.aspx?app="+app+"';";
        txt += "szFeatures = 'dialogWidth:65; dialogHeight:60; status:0; help:0';";

        txt += "szName = window.showModalDialog(szUrl, \"工作資訊說明\", szFeatures);";
     
        

        ScriptManager.RegisterStartupScript(up, typeof(UpdatePanel), "key",  txt , true);
    }
    static public void ScripWindowOpen(System.Web.UI.UpdatePanel up, string app) {
        string txt = "";
        //txt += "var szUrl;";
        //txt += "var szFeatures;";
        //txt += "var szName;";
        //txt += "var temp;";
        //txt += "szUrl = 'dialog.aspx?app=" + app + "';";
        //txt += "szFeatures = 'dialogWidth:65; dialogHeight:60; status:0; help:0';";

        txt += " window.open('" + app + "');";

        ScriptManager.RegisterStartupScript(up, typeof(UpdatePanel), "key", txt, true);
      //  up.ClientScript.RegisterClientScriptBlock(typeof(string), "key_open", txt, true);

        //   ScriptManager.RegisterStartupScript(up, typeof(UpdatePanel), "key", txt, true);
    }
    

    static public void ScripWindowOpen(Page up, string app)
    {
        string txt = "";
        //txt += "var szUrl;";
        //txt += "var szFeatures;";
        //txt += "var szName;";
        //txt += "var temp;";
        //txt += "szUrl = 'dialog.aspx?app=" + app + "';";
        //txt += "szFeatures = 'dialogWidth:65; dialogHeight:60; status:0; help:0';";

        txt += " window.open('"+app+"');";


        up.ClientScript.RegisterClientScriptBlock(typeof(string), "key_open", txt, true);

     //   ScriptManager.RegisterStartupScript(up, typeof(UpdatePanel), "key", txt, true);
    }
    

    static public void ErrorLog(string nobr, string Program, string strMsg)
    {
        try
        {
            log4net.ILog logger = log4net.LogManager.GetLogger("MyProject");
            //set user to log4net context, so we can use %X{user} in the appenders 
            log4net.MDC.Set("user", nobr);

            log4net.MDC.Set("Program", Program);
            if (logger.IsErrorEnabled)
                logger.Error(strMsg); //now log error
        }
        catch { }

    }



    static public void SendMail(string to, string body, string sub, System.Web.UI.UpdatePanel up)
    {
        string mailServerName = "ms.waferworks.com";	//傑報
        mailServerName = "ms.waferworks.com";	//昇陽
        string from = "hrcard@waferworks.com";	//傑報
        from = "hrcard@waferworks.com";	//昇陽
        string subject = "績效考核系統通知" + "<" + sub + ">";
        bool isUseDefaultCredentials = true;	//傑報
        isUseDefaultCredentials = false;	//昇陽需要做認證
        string strFrom = "hr";
        string strFromPass = "hr";

        try
        {
            using (MailMessage message =
                new MailMessage(from, to, subject, body))
            {
                message.IsBodyHtml = true;
                message.Priority = MailPriority.High;
                message.BodyEncoding = System.Text.Encoding.Default;
                message.SubjectEncoding = System.Text.Encoding.Default;

                //1.1的寫法
                //mailMsg.Fields.Add("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1"); //basic authentication 
                //mailMsg.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendusername", "hr"); //set your username here 
                //mailMsg.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendpassword", "hr"); //set your password here 

                SmtpClient mailClient = new SmtpClient(mailServerName);
                mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                mailClient.UseDefaultCredentials = isUseDefaultCredentials;
                mailClient.Credentials = new System.Net.NetworkCredential(strFrom, strFromPass);

                mailClient.Send(message);
                showScriptAlert(up, "寄件成功！");

             
            }
        }
        catch (Exception ex)
        {
            showScriptAlert(up, "無法發送郵件。(原因：" + ex.Message + ")");
            return;
        }
    }

    static public void SendMail(string to, string body, string sub)
    {
        string mailServerName = "ms.waferworks.com";	//傑報
        mailServerName = "ms.waferworks.com";	//昇陽
        string from = "hrcard@waferworks.com";	//傑報
        from = "hrcard@waferworks.com";	//昇陽
        string subject = "績效考核系統通知" + "<" + sub + ">";
        bool isUseDefaultCredentials = true;	//傑報
        isUseDefaultCredentials = false;	//昇陽需要做認證
        string strFrom = "hr";
        string strFromPass = "hr";

        try
        {
            using (MailMessage message =
                new MailMessage(from, to, subject, body))
            {
                message.IsBodyHtml = true;
                message.Priority = MailPriority.High;
                message.BodyEncoding = System.Text.Encoding.Default;
                message.SubjectEncoding = System.Text.Encoding.Default;

                //1.1的寫法
                //mailMsg.Fields.Add("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate", "1"); //basic authentication 
                //mailMsg.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendusername", "hr"); //set your username here 
                //mailMsg.Fields.Add("http://schemas.microsoft.com/cdo/configuration/sendpassword", "hr"); //set your password here 

                SmtpClient mailClient = new SmtpClient(mailServerName);
                mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;
                mailClient.UseDefaultCredentials = isUseDefaultCredentials;
                mailClient.Credentials = new System.Net.NetworkCredential(strFrom, strFromPass);

                mailClient.Send(message);
             //   showScriptAlert(up,"寄件成功！");


            }
        }
        catch (Exception ex)
        {
        //    showScriptAlert(up, "無法發送郵件。(原因：" + ex.Message + ")");
            return;
        }
    }
}
