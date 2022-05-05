using System;
using System.Reflection;
using System.Collections;
using System.Text;
using System.Web;
using System.Security.Cryptography;
using System.Configuration;

namespace CustomSecurity
{
    /// <summary>
    /// Provides static methods that supply helper utilities for authenticating identites. 
    /// This class cannot be inherited.
    /// </summary>
    public sealed class CustomAuthentication
    {
        const string LOGINURL_KEY = "CustomAuthentication.LoginUrl";
        const string AUTHENTICATION_COOKIE_KEY = "CustomAuthentication.Cookie.Name";
        const string AUTHENTICATION_COOKIE_EXPIRATION_KEY = "CustomAuthentication.Cookie.Timeout";

        #region static methods
        /// <summary>
        /// Produces a string containing an encrypted string for an authenticated User Identity
        /// suitable for use in an HTTP cookie given a CustomIdentity
        /// </summary>
        /// <param name="identity">CustomIdentity class for the authenticated user</param>
        /// <returns>Encrypted string</returns>
        public static string Encrypt(CustomIdentity identity)
        {
            string encryptedString = String.Empty;
            try
            {
                StringBuilder en_str = new StringBuilder();
                Type t_Identity = identity.GetType();
                PropertyInfo[] propertyInfo = t_Identity.GetProperties();
                foreach (PropertyInfo property in propertyInfo)
                {
                    en_str.Append(property.GetValue(identity, null));
                    en_str.Append("|$|");
                }

                encryptedString = CustomEncryption.Encrypt(en_str.ToString());
            }
            catch (Exception e)
            {
                string str = e.Message;
                throw;
            }
            return encryptedString;
        }

        /// <summary>
        /// Returns an instance of a CustomIdentity class, 
        /// given an encrypted authentication string obtained from an HTTP cookie.
        /// </summary>
        /// <param name="encryptedInput">Encrypted string conataining User Identity</param>
        /// <returns>CustomIdentity object</returns>
        public static CustomIdentity Decrypt(string encryptedInput)
        {
            CustomIdentity identity = null;
            try
            {
                string decryptedString = CustomEncryption.Decrypt(encryptedInput);
                //string[] userProperties = decryptedString.Split(new char[] {'|'});
                ArrayList userProperties = new ArrayList();
                Split("|$|", decryptedString, userProperties);
                if (userProperties != null && userProperties.Count > 0)
                {
                    identity = new CustomIdentity();
                    Type t_identity = identity.GetType();
                    PropertyInfo[] propertyInfo = t_identity.GetProperties();
                    for (int i = 0; i < propertyInfo.Length; i++)
                    {
                        PropertyInfo property = propertyInfo[i];
                        if (property.CanWrite)
                        {
                            string propertyValue = userProperties[i].ToString();
                            object objValue = Convert.ChangeType(propertyValue, property.PropertyType);
                            property.SetValue(identity, objValue, null);
                        }
                    }
                }
            }
            catch (Exception e)
            {
                string str = e.Message;
                throw;
            }
            return identity;
        }

        /// <summary>
        /// Redirects an authenticated user back to the originally requested URL.
        /// </summary>
        /// <param name="identity">CustomIdentity of an authenticated user</param>
        public static void RedirectFromLoginPage(CustomIdentity identity)
        {
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

            HttpRequest req =HttpContext.Current.Request;
            HttpResponse res = HttpContext.Current.Response;

            //目前頁面
            int i = req.Path.LastIndexOf("/");
            string page = req.Path.Substring(i + 1, (req.Path.Length - (i + 1)));

            //登入頁面
            int j = loginUrl.LastIndexOf("/");
            string loginPage = loginUrl.Substring(j + 1, (loginUrl.Length - (j + 1)));

            string cookieExpr = ConfigurationSettings.AppSettings[AUTHENTICATION_COOKIE_EXPIRATION_KEY];

            string encryptedUserDetails = Encrypt(identity);

            HttpCookie userCookie = new HttpCookie(cookieName.ToUpper(), encryptedUserDetails);
            if (cookieExpr != null && cookieExpr.Trim() != String.Empty)
            {
                userCookie.Expires = DateTime.Now.AddMinutes(int.Parse(cookieExpr));
            }
            res.Cookies.Add(userCookie);

            string returnUrl = req["ReturnUrl"];
            if (returnUrl != null && returnUrl.Trim() != String.Empty)
            {
                res.Redirect(returnUrl, false);
            }
            else
            {
                //res.Redirect(req.ApplicationPath + "/default.aspx", false);
                res.Redirect(req.ApplicationPath + loginUrl + "?ReturnUrl=" + req.Path, false);
            }
        }

        #endregion

        #region private methods
        private object GetConvertedValue(string propertyValue, string propertyType)
        {
            Type argType = Type.GetType(propertyType);
            Object obj = new Object();
            if (argType == Type.GetType("System.String"))
            {
                obj = propertyValue.Trim();  // returning Primitive object
            }
            else
            {
                obj = Activator.CreateInstance(argType);  // creating an object of ArgumentType 
                obj = argType.InvokeMember("Parse", BindingFlags.Default | BindingFlags.InvokeMethod, null, obj, new object[] { propertyValue.Trim() });
            }

            return obj;
        }

        /// <summary>
        /// Used to split a string into an string array based on a separator
        /// </summary>
        /// <param name="seperator"></param>
        /// <param name="str"></param>
        /// <param name="strArray"></param>
        private static void Split(string seperator, string str, ArrayList strArray)
        {
            try
            {
                int start = 0, end = 0;
                end = str.IndexOf(seperator);
                if (end <= -1)
                {
                    end = str.Length;
                    strArray.Add(str.Substring(start, end - start));
                    return;
                }
                strArray.Add(str.Substring(start, end - start));

                start = end + seperator.Length;
                end = str.Length;

                Split(seperator, str.Substring(start, end - start), strArray);
            }
            catch (Exception ex)
            {
                throw (ex);
            }
        }

        #endregion

        #region Properties
        /// <summary>
        /// Returns the configured cookie name used for the current application
        /// </summary>
        public string CookieName
        {
            get
            {
                string cookieName = ConfigurationSettings.AppSettings[AUTHENTICATION_COOKIE_KEY];
                if (cookieName == null || cookieName.Trim() == String.Empty)
                {
                    throw new Exception(" CustomAuthentication.Cookie.Name entry not found in appSettings section section of Web.config");
                }
                return cookieName;
            }
        }
        #endregion
    }
}