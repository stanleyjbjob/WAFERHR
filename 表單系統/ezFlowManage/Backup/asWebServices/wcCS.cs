using System;
using System.Collections.Generic;
using System.Text;
using System.Net;
using System.IO;
using System.Collections.Specialized;

namespace asWebServices
{
    public class wcCS
    {
        public void PostHttp()
        {
            string uriString = "http://www.yahoo.com.tw";
            //string postString = "";
            //WebClient wc = new WebClient();
            //wc.Headers.Add("Content-Type", "application/x-www-form-urlencoded");
            //byte[] postData = Encoding.UTF8.GetBytes(postString);
            //byte[] responseData = wc.UploadData(uriString, "POST", postData);
            //string result = Encoding.UTF8.GetString(responseData);


            //WebClient wc = new WebClient();
            //wc.Headers.Add("Accept", "image/gif, image/x-xbitmap, image/jpeg, image/pjpeg, */*");
            //wc.Headers.Add("Accept-Language", "zh-TW");
            //wc.Headers.Add("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.2; SV1; .NET CLR 1.1.4322; .NET CLR 2.0.50727)");

            //Stream s = wc.OpenRead(uriString);
            //StreamReader sr = new StreamReader(s, Encoding.UTF8);
            //string result = sr.ReadToEnd();

            try
            {

                // Download the data to a buffer.
                WebClient client = new WebClient();

                Byte[] pageData = client.DownloadData("http://www.contoso.com");
                string pageHtml = Encoding.ASCII.GetString(pageData);
                Console.WriteLine(pageHtml);

                // Download the data to a file.
                client.DownloadFile("http://www.contoso.com", "page.htm");

                // Upload some form post values.
                NameValueCollection form = new NameValueCollection();
                form.Add("MyName", "MyValue");
                Byte[] responseData = client.UploadValues("http://www.contoso.com/form.aspx", form);

            }
            catch (WebException webEx)
            {
                Console.WriteLine(webEx.ToString());
                if (webEx.Status == WebExceptionStatus.ConnectFailure)
                {
                    Console.WriteLine("Are you behind a firewall?  If so, go through the proxy server.");
                }
            }

        }
    }
}