using System;
using System.Threading;

namespace XuanMax.UploadProgress
{
    /// <summary>
    /// A generic class that implements IAsyncResult.
    /// </summary>
    public class AsyncResult : IAsyncResult
    {
        private object asyncState;
        private AsyncCallback callback;
        private ManualResetEvent mre;
        private bool completed, completedSynchronously;

        /// <summary>
        /// Creates a new AsyncResult object with the specified AsyncCallback,
        /// state object, and the status of completed synchronously.
        /// </summary>
        /// <param name="cb">An AsyncCallback delegate.</param>
        /// <param name="state">The state object.</param>
        /// <param name="completedSync">Whether the operation is completed synchronously.</param>
        public AsyncResult(AsyncCallback cb, object state, bool completedSync)
        {
            callback = cb;
            asyncState = state;
            mre = new ManualResetEvent(completed = completedSynchronously = completedSync);
        }

        /// <summary>
        /// Creates a new AsyncResult object with the specified AsyncCallback and state object.
        /// </summary>
        /// <param name="cb">An AsyncCallback delegate.</param>
        /// <param name="state">The state object.</param>
        public AsyncResult(AsyncCallback cb, object state) : this(cb, state, false) { }

        /// <summary>
        /// Creates a new AsyncResult object with the specified AsyncCallback and no state object.
        /// </summary>
        /// <param name="cb">An AsyncCallback delegate.</param>
        public AsyncResult(AsyncCallback cb) : this(cb, null, false) { }

        /// <summary>
        /// Creates a new AsyncResult object.
        /// </summary>
        public AsyncResult() : this(null, null, false) { }

        /// <summary>
        /// Gets the state object specified on creation of this AsyncResult object.
        /// </summary>
        public object AsyncState
        {
            get { return asyncState; }
        }

        /// <summary>
        /// Gets the WaitHandle.
        /// </summary>
        public WaitHandle AsyncWaitHandle
        {
            get { return mre; }
        }

        /// <summary>
        /// Gets a value indicating whether the operation was completed synchronously.
        /// </summary>
        public bool CompletedSynchronously
        {
            get { return completedSynchronously; }
        }

        /// <summary>
        /// Gets a value indicating whether the operation is completed.
        /// Setting this property to true will raise the WaitHandle signal
        /// and calls back the AsyncCallback delegate specified on creation
        /// of this AsyncResult object.
        /// </summary>
        public bool IsCompleted
        {
            get { return completed; }
            set
            {
                if (!completed && (completed = value))
                {
                    mre.Set();
                    if (callback != null) callback(this);
                }
            }
        }
    }
}