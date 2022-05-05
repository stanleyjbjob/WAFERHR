using System;
using System.IO;
using System.Web;
using System.Threading;
using System.Reflection;

namespace XuanMax.UploadProgress
{
    /// <summary>
    /// Counts the bytes while loading the contents.
    /// </summary>
    internal class CounterLoader
    {
        private int total;
        private volatile int read;
        private long started;
        private HttpWorkerRequest wr;
        private AsyncResult ar;
        private MemoryStream ms;
        private HttpResponse resp;

        public CounterLoader(HttpWorkerRequest workerRequest,
            AsyncResult asyncResult, HttpResponse response)
        {
            started = DateTime.Now.Ticks;
            wr = workerRequest; ar = asyncResult;
            resp = response;
            total = wr.GetTotalEntityBodyLength();
            ms = new MemoryStream(total);
            byte[] buffer = wr.GetPreloadedEntityBody();
            ms.Write(buffer, 0, read = buffer.Length);
            if (read == total)
                ThreadPool.QueueUserWorkItem(DontLoad);
            else
                ThreadPool.QueueUserWorkItem(Load);
        }

        public int TotalBytes { get { return total; } }
        public int BytesRead { get { return read; } }
        public int BytesPerSecond
        {
            get
            {
                long elapsedTicks = DateTime.Now.Ticks - started;
                if (elapsedTicks < 10000000L) return 0;
                return read / (int)(elapsedTicks / 10000000L);
            }
        }
        public bool Finished { get { return read == total || ar.IsCompleted; } }

        private void DontLoad(object state)
        {
            ar.IsCompleted = true;
        }

        private void Load(object state)
        {
            if (read < total) lock (this) if (read < total)
            {
                try
                {
                    if (wr.IsClientConnected())
                    {
                        int remaining = total - read;
                        if (remaining > 1024) remaining = 1024;
                        byte[] buffer = new byte[remaining];
                        remaining = wr.ReadEntityBody(buffer, remaining);
                        ms.Write(buffer, 0, remaining);
                        read += remaining;
                        if (read == total)
                        {
                            BindingFlags bindingFlags =
                                BindingFlags.Instance | BindingFlags.NonPublic;
                            Type type = wr.GetType();
                            while ((type != null) && (type.FullName !=
                                 "System.Web.Hosting.ISAPIWorkerRequest"))
                                type = type.BaseType;
                            if (type != null)
                            {
                                type.GetField("_contentAvailLength",
                                    bindingFlags).SetValue(wr, total);
                                type.GetField("_preloadedContent",
                                    bindingFlags).SetValue(wr, ms.ToArray());
                                type.GetField("_preloadedContentRead",
                                    bindingFlags).SetValue(wr, true);
                            }
                            ar.IsCompleted = true;
                        }
                        else
                            ThreadPool.QueueUserWorkItem(Load);
                    }
                    else
                    {
                        resp.End();
                        ar.IsCompleted = true;
                    }
                }
                catch
                {
                    resp.End();
                    ar.IsCompleted = true;
                }
            }
        }
    }
}