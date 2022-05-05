using System;
using System.Web;
using System.Threading;
using System.Collections;
using System.Configuration;

namespace CustomSecurity
{
    /// <summary>
    /// Enables ASP.NET applications to use Custom authentication based on forms authentication. 
    /// This class cannot be inherited.
    /// </summary>
    public sealed class CustomAuthenticationModule : IHttpModule
    {
        HttpApplication app = null;
        const string LOGINURL_KEY = "CustomAuthentication.LoginUrl";
        const string AUTHENTICATION_COOKIE_KEY = "CustomAuthentication.Cookie.Name";

        /// <summary>
        /// Initializes the module derived from IHttpModule when called by the HttpRuntime . 
        /// </summary>
        /// <param name="httpapp">The HttpApplication module</param>
        public void Init(HttpApplication httpapp)
        {
            this.app = httpapp;
            app.AuthenticateRequest += new EventHandler(this.OnAuthenticate);
        }

        void OnAuthenticate(object sender, EventArgs e)
        {
            app = (HttpApplication)sender;
            HttpRequest req = app.Request;
            HttpResponse res = app.Response;

            string loginUrl = ConfigurationSettings.AppSettings[LOGINURL_KEY];
            if (loginUrl == null || loginUrl.Trim() == String.Empty)
            {
                throw new Exception(" CustomAuthentication.LoginUrl entry not found in appSettings section of Web.config");
            }

            string cookieName = ConfigurationSettings.AppSettings[AUTHENTICATION_COOKIE_KEY];
            if (cookieName == null || cookieName.Trim() == String.Empty)
            {
                throw new Exception(" CustomAuthentication.Cookie.Name entry not found in appSettings section section of Web.config");
            }

            //目前頁面
            int i = req.Path.LastIndexOf("/");
            string page = req.Path.Substring(i + 1, (req.Path.Length - (i + 1)));

            //目前頁面的副檔名
            string pageAXD = page.Substring(page.IndexOf(".") + 1);

            //登入頁面
            int j = loginUrl.LastIndexOf("/");
            string loginPage = loginUrl.Substring(j + 1, (loginUrl.Length - (j + 1)));

            //目前頁面不可以是空值而且目前頁面不等於登入頁面
            if (page != null && !(page.Trim().ToUpper().Equals(loginPage.ToUpper())))
            {
                if (req.Cookies.Count > 0 && req.Cookies[cookieName.ToUpper()] != null)
                {
                    HttpCookie cookie = req.Cookies[cookieName.ToUpper()];
                    if (cookie != null)
                    {
                        string str = cookie.Value;
                        CustomIdentity userIdentity = CustomAuthentication.Decrypt(str);
                        string[] roles = userIdentity.UserRoles.Split(new char[] { '|' });
                        ArrayList arrRoles = new ArrayList();
                        arrRoles.InsertRange(0, roles);
                        CustomPrincipal principal = new CustomPrincipal(userIdentity, arrRoles);
                        app.Context.User = principal;
                        Thread.CurrentPrincipal = principal;
                    }
                }
                else
                {
                    if (!(pageAXD.Trim().ToUpper().Equals("AXD")))
                        res.Redirect(req.ApplicationPath + loginUrl + "?ReturnUrl=" + req.Path, true);
                }
            }
        }

        public void Dispose()
        {
        }
    }
}