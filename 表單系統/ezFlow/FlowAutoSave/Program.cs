using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace FlowAutoSave
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime dDateA = DateTime.Now;

            JBModule.Message.TextLog.WriteLog("開始執行服務20170926v1.2");

            dcHrDataContext dcHr = new dcHrDataContext();
            dcFlowDataContext dcFlow = new dcFlowDataContext();

            string[] arrForm = { "ShiftShort" };
            string[] arrState = { "ReSend", "Save", "Reject" };
            bool Save;

            DateTime dDate, dDateB, dDateE;
            dDate = DateTime.Now.Date;
            dDateB = dDate.AddMonths(-1);
            dDateE = dDate.AddMonths(1);

            //把所有狀態3的資料找出來 寫成6，沒成功寫成5

            //短調
            var rsFormApp = (from c in dcFlow.wfFormApp
                             where c.sState == "3"
                             && c.sFormCode == "ShiftShort"
                             select c).ToList();

            Dal.Dao.Att.RotechgDao oRotechgDao = new Dal.Dao.Att.RotechgDao(dcHr.Connection);

            foreach (var rm in rsFormApp)
            {
                var rs = (from c in dcFlow.wfAppShiftShort
                          where c.idProcess == rm.idProcess
                          select c).ToList();

                rm.sState = "5";

                foreach (var r in rs)
                {
                    Save = oRotechgDao.Save(r.sNobrB, r.dDateB, r.sRoteB, "", r.sNameA, r.idProcess.ToString());
                    if (Save)
                    {
                        r.sReserve4 = "AutoSave";
                        r.sState = "3";
                        JBModule.Message.TextLog.WriteLog("短調-自動存入" + " " + r.sNobr + " " + r.dDateB.ToShortDateString() + " " + r.idProcess.ToString());
                    }
                }

                rm.sState = "6";
            }

            dcFlow.SubmitChanges();

            JBModule.Message.TextLog.WriteLog("結束執行服務");
            DateTime dDateD = DateTime.Now;

            TimeSpan ts = dDateD - dDateA;

            JBModule.Message.TextLog.WriteLog("共執行" + ts.TotalSeconds.ToString() + "秒");
        }
    }
}