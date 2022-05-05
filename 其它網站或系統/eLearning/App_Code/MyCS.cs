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
using System.Collections;
using System.Text;
using System.IO;

namespace JBLib.Module
{
    /// <summary>
    /// MyCS 的摘要描述
    /// </summary>
    public class MyCS : System.Web.UI.Page
    {
        public MyCS() { }

        //編碼
        public static string encode(String strData)
        {
            try { return System.Convert.ToBase64String(System.Text.UTF8Encoding.UTF8.GetBytes(strData)); }
            catch { return ""; }
        }

        //解碼
        public static string decode(String strData)
        {
            try { return System.Text.UTF8Encoding.UTF8.GetString(System.Convert.FromBase64String(strData)); }
            catch { return ""; }
        }

        //解碼後編成Hashtable
        public static Hashtable QueryValue(string _do)
        {
            string[] s = _do.Split('&');
            Hashtable ht = new Hashtable();
            for (int i = 0; i < s.Length; i++)
            {
                if (s[i].IndexOf("=") > 0)
                {
                    string key = "";
                    string values = "";
                    key = s[i].Substring(0, s[i].IndexOf("="));
                    values = s[i].Substring(s[i].IndexOf("=") + 1);
                    ht.Add(key, values);
                }
            }
            return ht;
        }

        public static Hashtable GetDefault(string sCat)
        {
            Hashtable ht = new Hashtable();

            SysDSTableAdapters.sysDefaultTableAdapter sysDefaultTA = new SysDSTableAdapters.sysDefaultTableAdapter();
            DataRow[] rows = sysDefaultTA.GetDataByCategory(sCat).Select();

            foreach (SysDS.sysDefaultRow r in rows)
                ht.Add(r.sKey, r.sValue);

            return ht;
        }

        public void showModalDialog(string cn, string ca)
        {
            Page page = HttpContext.Current.CurrentHandler as Page;
            string _do = "?_do=" + JBLib.Module.MyCS.encode(ca);
            string link = "MyFrame.aspx?url=" + cn + ".aspx" + _do;
            string script = "var sFeatures = 'dialogWidth:700px;dialogHeight:500px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                "var obj = " + page.Form.ClientID + ";" +
                "window.showModalDialog('" + link + "', obj, sFeatures);" +
                "self.location = '" + page.Request.Url.Segments[page.Request.Url.Segments.Length - 1] + "?_do=" + page.Request.QueryString["_do"] + "';";
            page.ClientScript.RegisterStartupScript(typeof(string), "key", script, true);
        }

        //計算字串最長的
        public static int GetCountStringLength(DataTable dt, string ColumnsName, string where, string sort)
        {
            int i = 0;
            DataRow[] rows = dt.Select(where, sort);
            foreach (DataRow r in rows)
                i = (!DBNull.Value.Equals(r[ColumnsName]) && Encoding.Default.GetBytes(r[ColumnsName].ToString()).Length > i) ? Encoding.Default.GetBytes(r[ColumnsName].ToString()).Length : i;

            return i;
        }

        //填滿符號
        public static string GetFillString(string sign, int len)
        {
            sign = sign.Trim().Length == 0 ? "&nbsp;" : sign;
            string s = "";
            for (int i = 0; i < len; i++)
                s += sign;

            return HttpUtility.HtmlDecode(s);
        }

        //權限判斷
        public static bool GetAuth(object a, object b)
        {
            return ((Convert.ToUInt32(a) & Convert.ToUInt32(b)) == Convert.ToUInt32(b));
        }

        //傳送信件
        public static void SendMail(string mailServerName, string from, bool isUseDefaultCredentials, string strFrom, string strFromPass, string to, string subject, string body)
        {
            try
            {
                using (MailMessage message =
                    new MailMessage(from, to, subject, body))
                {
                    message.IsBodyHtml = true;
                    message.Priority = MailPriority.High;
                    message.BodyEncoding = System.Text.Encoding.Default;
                    message.SubjectEncoding = System.Text.Encoding.Default;

                    SmtpClient mailClient = new SmtpClient(mailServerName);
                    mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;

                    if (isUseDefaultCredentials) mailClient.UseDefaultCredentials = true;
                    else
                    {
                        mailClient.UseDefaultCredentials = false;
                        mailClient.Credentials = new System.Net.NetworkCredential(strFrom, strFromPass);
                    }

                    mailClient.Send(message);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        public static void SendMail(string to, string subject, string body)
        {
            string mailServerName = "smtp.jbjob.com.tw";
            string from = "ming@jbjob.com.tw";
            bool isUseDefaultCredentials = true;
            string strFrom = "ming@jbjob.com.tw";
            string strFromPass = "m964820";

            try
            {
                using (MailMessage message =
                    new MailMessage(from, to, subject, body))
                {
                    message.IsBodyHtml = true;
                    message.Priority = MailPriority.High;
                    message.BodyEncoding = System.Text.Encoding.Default;
                    message.SubjectEncoding = System.Text.Encoding.Default;

                    SmtpClient mailClient = new SmtpClient(mailServerName);
                    mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;

                    if (isUseDefaultCredentials) mailClient.UseDefaultCredentials = true;
                    else
                    {
                        mailClient.UseDefaultCredentials = false;
                        mailClient.Credentials = new System.Net.NetworkCredential(strFrom, strFromPass);
                    }

                    mailClient.Send(message);
                }
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
    }
}