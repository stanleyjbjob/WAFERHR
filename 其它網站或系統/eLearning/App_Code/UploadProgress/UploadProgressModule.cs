using System;
using System.Web;
using System.Web.Caching;
using System.Web.Configuration;

namespace XuanMax.UploadProgress
{
    /// <summary>
    /// Checks Upload Progresses
    /// </summary>
    public class UploadProgressModule : IHttpModule
    {
        /// <summary>
        /// If the requested path ends with the value of this field, and
        /// it'll be treated as a request of the current upload progress.
        /// </summary>
        private string progressGetterPath;
        /// <summary>
        /// If the value of this field is set to true, UploadProgressModule
        /// will check all POST requests. Otherwise only those with a
        /// content type of "multipart/form-data" will be checked.
        /// </summary>
        private bool checkAllPostRequests;
        /// <summary>
        /// If a request's content length is too small, it's useless to
        /// check the upload progress. This field specifies the minimum
        /// (prospected) length to enable checking.
        /// </summary>
        private int minimumRequestLength;
        /// <summary>
        /// Will get the value from Web.config
        /// </summary>
        private string sessionCookieName;

        void IHttpModule.Dispose()
        {
            // does nothing
        }

        void IHttpModule.Init(HttpApplication context)
        {
            // loads configs
            progressGetterPath = WebConfigurationManager.AppSettings
                ["UploadProgressGetterPath"];
            if (String.IsNullOrEmpty(progressGetterPath))
                progressGetterPath = "UploadProgress.ashx";

            bool.TryParse(WebConfigurationManager.AppSettings
                ["UploadProgressChecksAllPostRequests"],
                out checkAllPostRequests);

            if (!int.TryParse(WebConfigurationManager.AppSettings
                ["UploadProgressMinRequestLength"], out minimumRequestLength))
                minimumRequestLength = 5120;

            try
            {
                sessionCookieName = ((SessionStateSection)WebConfigurationManager
                    .OpenWebConfiguration("~")
                    .GetSection("system.web/sessionState")).CookieName;
            }
            catch { sessionCookieName = "ASP.NET_SessionId"; }

            // assigns event handlers
            context.AddOnBeginRequestAsync(OnBeginBeginRequest, OnEndBeginRequest);
        }

        int GetMaxRequestLength(string path)
        {
            // loads maxRequestLength from current location
            try
            {
                return ((HttpRuntimeSection)
                    WebConfigurationManager.OpenWebConfiguration(path)
                    .GetSection("system.web/httpRuntime")).MaxRequestLength * 1024;
            }
            catch { return 4096 * 1024; }
        }

        IAsyncResult OnBeginBeginRequest(object sender, EventArgs e, AsyncCallback callback, object state)
        {
            HttpContext context = HttpContext.Current;
            HttpRequest request = context.Request;

            if (request.Path.EndsWith(progressGetterPath,
                    StringComparison.InvariantCultureIgnoreCase))
                return DisplayUploadProgress(context, callback, state);

            if (request.RequestType == "POST" && (checkAllPostRequests
                    || request.ContentType.StartsWith("multipart/form-data"))
                    && request.ContentLength >= minimumRequestLength
                    && request.ContentLength <= GetMaxRequestLength(request.Path))
                try
                {
                    string sessionId = request.Cookies[sessionCookieName].Value;
                    if (!String.IsNullOrEmpty(sessionId))
                    {
                        HttpWorkerRequest wr = (HttpWorkerRequest)
                            ((IServiceProvider)context).GetService(typeof(HttpWorkerRequest));
                        AsyncResult ar = new AsyncResult(callback, state);
                        context.Cache.Insert("CachedUploadProgressCounter_" + sessionId,
                            new CounterLoader(wr, ar, context.Response), null,
                            Cache.NoAbsoluteExpiration, TimeSpan.FromMinutes(1),
                            CacheItemPriority.NotRemovable, null);
                        return ar;
                    }
                }
                catch { }
            return new AsyncResult(callback, state, true);
        }

        void OnEndBeginRequest(IAsyncResult ar)
        {
            ar.AsyncWaitHandle.WaitOne();
            HttpResponse response = ar.AsyncState as HttpResponse;
            if (response != null) response.End();
        }

        //////////////////////////////////
        //                              //
        // Display Upload Progress Part //
        //                              //
        //////////////////////////////////

        AsyncResult DisplayUploadProgress(HttpContext context, AsyncCallback callback, object state)
        {
            HttpResponse response = context.Response;
            response.Cache.SetCacheability(HttpCacheability.NoCache);
            response.BufferOutput = false;
            response.Write(@"<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
<html xmlns='http://www.w3.org/1999/xhtml' >
<head><title>Upload Progress</title></head>
<body style='background-color: white; overflow: hidden; margin: 0px; height: 100%'>
<div id='ProgressBar' style='position: absolute; left: 0px; top: 0px; background-color: #00FF00; width: 0%; height: 100%'></div>
<div style='position: absolute; left: 0px; top: 0px; width: 100%; height: 100%'>
<table cellpadding='0' cellspacing='0' width='100%' style='height: 100%; border-collapse: collapse; border: 1px solid black'>
	<tr style='font: 12px Tahoma'>
		<td style='width: auto'>&nbsp;</td>
		<td style='width: 60px' align='right' id='Transferred'>0&nbsp;B</td>
		<td style='width: 10px'>&nbsp;/&nbsp;</td>
		<td style='width: 30px' id='Total'>0&nbsp;B</td>
		<td style='width: 10px'>&nbsp;(</td>
		<td style='width: 60px' align='right' id='Speed'>0&nbsp;B</td>
		<td style='width: 15px'>/s)</td>
		<td style='width: auto'>&nbsp;</td>
	</tr>
</table>
</div>
</body>
</html>
<script type='text/javascript' language='javascript'>
window.onload = function() {
    setTimeout('location.reload()', 30000);
}
function displayProgress(transferred, total, speed) {
	document.getElementById('ProgressBar').style.width = total == 0 ? '0%' :
		parseInt(transferred * 100 / total) + '%';
	var level = new Array('&nbsp;B', '&nbsp;KB', '&nbsp;MB');
	var transferredLevel = 0;
	for (; transferredLevel < 2, transferred > 1024; transferredLevel++, transferred /= 1024) ;
	document.getElementById('Transferred').innerHTML = Math.round(transferred * 100) / 100 + level[transferredLevel];
	var totalLevel = 0;
	for (; totalLevel < 2, total > 1024; totalLevel++, total /= 1024) ;
	document.getElementById('Total').innerHTML = Math.round(total * 100) / 100 + level[totalLevel];
	var speedLevel = 0;
	for (; speedLevel < 2, speed > 1024; speedLevel++, speed /= 1024) ;
	document.getElementById('Speed').innerHTML = Math.round(speed * 100) / 100 + level[speedLevel];
}
</script>");
            string sessionId = context.Request.Cookies[sessionCookieName].Value;
            if (String.IsNullOrEmpty(sessionId))
                return new AsyncResult(callback, response, true);
            CounterLoader counter = context.Cache["CachedUploadProgressCounter_"
                + sessionId] as CounterLoader;
            if (counter == null)
                return new AsyncResult(callback, response, true);
            else if (counter.Finished)
            {
                context.Cache.Remove("CachedUploadProgressCounter_" + sessionId);
                return new AsyncResult(callback, response, true);
            }
            AsyncResult ar = new AsyncResult(callback, response);
            ProgressDisplay.Display(counter, ar, context);
            return ar;
        }
    }
}