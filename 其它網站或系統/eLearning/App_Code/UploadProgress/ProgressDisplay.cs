using System;
using System.Web;
using System.Threading;

namespace XuanMax.UploadProgress
{
    /// <summary>
    /// Sends the upload progress to the client periodically.
    /// </summary>
    internal class ProgressDisplay : IDisposable
    {
        private CounterLoader counter;
        private AsyncResult ar;
        private HttpContext context;
        private bool disposed;
        private Timer sender;

        public static void Display(CounterLoader counter, AsyncResult ar, HttpContext context)
        {
            context.Items["UploadProgressDisplay"] =  // keep-alive
                new ProgressDisplay(counter, ar, context);
        }

        private ProgressDisplay(CounterLoader counter, AsyncResult ar, HttpContext context)
        {
            this.counter = counter; this.ar = ar; this.context = context;
            sender = new Timer(Send, null, 200, Timeout.Infinite);
        }

        private void Send(object state)
        {
            try
            {
                if (context.Response.IsClientConnected)
                {
                    context.Response.Write(String.Format(@"
<script type='text/javascript' language='javascript'>
displayProgress({0}, {1}, {2});
</script>", counter.BytesRead, counter.TotalBytes, counter.BytesPerSecond));
                    if (counter.Finished)
                    {
                        context.Response.Write(@"
<script type='text/javascript' language='javascript'>
window.onload = function() {
    setTimeout('location.reload()', 3000);
}
</script>");
                        ar.IsCompleted = true;
                        Dispose();
                    }
                    else
                        sender.Change(2000, Timeout.Infinite);
                }
                else
                {
                    ar.IsCompleted = true;
                    Dispose();
                }
            }
            catch
            {
                ar.IsCompleted = true;
                Dispose();
            }
        }

        public void Dispose()
        {
            if (!disposed) lock (this) if (!disposed)
            {
                disposed = true;
                if (sender != null)
                {
                    sender.Dispose();
                    sender = null;
                }
            }
        }
    }
}