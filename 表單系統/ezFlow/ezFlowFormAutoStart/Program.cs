using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using JBModule.Message;
using JBModule.Data.Linq;
using Bll.Bas.Vdb;
using Newtonsoft.Json;

namespace ezFlowFormAutoStart
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime dDateX = DateTime.Now;
            DateTime dDateNow = DateTime.Now;

            TextLog.WriteLog("服務開始執行...");
            TextLog.WriteLog("版本：20171020V1.1");

            bool _Test = System.Configuration.ConfigurationManager.AppSettings["Test"] == "1";  //測試匯入
            string _HRConnectionString = System.Configuration.ConfigurationManager.AppSettings["HRConnectionString"];
            string _MailHeader = System.Configuration.ConfigurationManager.AppSettings["MailHeader"] + "<BR>";
            string _MailFooter = "<BR><BR>Best Regards,<BR><BR>" + System.Configuration.ConfigurationManager.AppSettings["MailFooter"];

            List<string> arrHoliDay = new List<string>() { "00", "0X", "0Y", "0Z" };

            TextLog.WriteLog("測試：" + (_Test ? "是" : "否"));

            HrDBDataContext dcHr = new HrDBDataContext(_HRConnectionString);
            dcFlowDataContext dcFlow = new dcFlowDataContext();

            ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection.ConnectionString);

            string[] arrTtscode = { "1", "4", "6" };

            //請假單自動送單
            string AbsFlowNode_id = System.Configuration.ConfigurationManager.AppSettings["AbsFlowNode_id"];

            var rsAppAbs = (from o in dcFlow.wfAppAbs
                            join pf in dcFlow.ProcessFlow on o.idProcess equals pf.id
                            join pn in dcFlow.ProcessNode on o.idProcess equals pn.ProcessFlow_id
                            where o.sFormCode == "Abs"
                            && o.sState == "1"
                            && pn.FlowNode_id == AbsFlowNode_id  //不同的系統可能要改
                            && !pn.isFinish.Value
                            && !pf.isCancel.Value && !pf.isError.Value && !pf.isFinish.Value
                            select o).ToList();

            List<int> lsProcessID = new List<int>();

            foreach (var rs in rsAppAbs)
            {
                if (!_Test)
                {
                    if (!lsProcessID.Contains(rs.idProcess))
                    {
                        lsProcessID.Add(rs.idProcess);

                        var rProcessNode = (from c in dcFlow.ProcessNode
                                            where c.ProcessFlow_id == rs.idProcess
                                            && c.FlowNode_id == AbsFlowNode_id
                                            && !c.isFinish.Value
                                            select c).FirstOrDefault();

                        if (rProcessNode != null)
                        {
                            var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                  where c.ProcessFlow_id == rs.idProcess
                                                  && c.ProcessNode_auto == rProcessNode.auto
                                                  orderby c.auto descending
                                                  select c).FirstOrDefault();

                            if (rProcessApParm != null)
                            {
                                oService.WorkFinish(rProcessApParm.auto);
                                TextLog.WriteLog("請假單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                            }
                        }
                    }
                }
                else
                    TextLog.WriteLog("請假單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
            }

            //公出單自動送單
            string Abs1FlowNode_id = System.Configuration.ConfigurationManager.AppSettings["Abs1FlowNode_id"];

            rsAppAbs = (from o in dcFlow.wfAppAbs
                        join pf in dcFlow.ProcessFlow on o.idProcess equals pf.id
                        join pn in dcFlow.ProcessNode on o.idProcess equals pn.ProcessFlow_id
                        where o.sFormCode == "Abs1"
                        && o.sState == "1"
                        && pn.FlowNode_id == Abs1FlowNode_id  //不同的系統可能要改
                        && !pn.isFinish.Value
                        && !pf.isCancel.Value && !pf.isError.Value && !pf.isFinish.Value
                        select o).ToList();

            foreach (var rs in rsAppAbs)
            {
                if (!_Test)
                {
                    if (!lsProcessID.Contains(rs.idProcess))
                    {
                        lsProcessID.Add(rs.idProcess);

                        var rProcessNode = (from c in dcFlow.ProcessNode
                                            where c.ProcessFlow_id == rs.idProcess
                                            && c.FlowNode_id == Abs1FlowNode_id
                                            && !c.isFinish.Value
                                            select c).FirstOrDefault();

                        if (rProcessNode != null)
                        {
                            var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                  where c.ProcessFlow_id == rs.idProcess
                                                  && c.ProcessNode_auto == rProcessNode.auto
                                                  orderby c.auto descending
                                                  select c).FirstOrDefault();

                            if (rProcessApParm != null)
                            {
                                oService.WorkFinish(rProcessApParm.auto);
                                TextLog.WriteLog("公出單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                            }
                        }
                    }
                }
                else
                    TextLog.WriteLog("公出單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
            }

            //銷假單自動送單
            string AbscFlowNode_id = System.Configuration.ConfigurationManager.AppSettings["AbscFlowNode_id"];

            var rsAppAbsc = (from o in dcFlow.wfAppAbsc
                             join pf in dcFlow.ProcessFlow on o.idProcess equals pf.id
                             join pn in dcFlow.ProcessNode on o.idProcess equals pn.ProcessFlow_id
                             where o.sFormCode == "Absc"
                             && o.sState == "1"
                             && pn.FlowNode_id == AbscFlowNode_id  //不同的系統可能要改
                             && !pn.isFinish.Value
                             && !pf.isCancel.Value && !pf.isError.Value && !pf.isFinish.Value
                             select o).ToList();

            foreach (var rs in rsAppAbsc)
            {
                if (!_Test)
                {
                    if (!lsProcessID.Contains(rs.idProcess))
                    {
                        lsProcessID.Add(rs.idProcess);

                        var rProcessNode = (from c in dcFlow.ProcessNode
                                            where c.ProcessFlow_id == rs.idProcess
                                            && c.FlowNode_id == AbscFlowNode_id
                                            && !c.isFinish.Value
                                            select c).FirstOrDefault();

                        if (rProcessNode != null)
                        {
                            var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                  where c.ProcessFlow_id == rs.idProcess
                                                  && c.ProcessNode_auto == rProcessNode.auto
                                                  orderby c.auto descending
                                                  select c).FirstOrDefault();

                            if (rProcessApParm != null)
                            {
                                oService.WorkFinish(rProcessApParm.auto);
                                TextLog.WriteLog("銷假單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                            }
                        }
                    }
                }
                else
                    TextLog.WriteLog("銷假單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
            }

            //忘刷單自動送單
            string CardFlowNode_id = System.Configuration.ConfigurationManager.AppSettings["CardFlowNode_id"];

            var rsAppCard = (from o in dcFlow.wfAppCard
                             join pf in dcFlow.ProcessFlow on o.idProcess equals pf.id
                             join pn in dcFlow.ProcessNode on o.idProcess equals pn.ProcessFlow_id
                             where o.sFormCode == "Card"
                             && o.sState == "1"
                             && pn.FlowNode_id == CardFlowNode_id  //不同的系統可能要改
                             && !pn.isFinish.Value
                             && !pf.isCancel.Value && !pf.isError.Value && !pf.isFinish.Value
                             select o).ToList();

            foreach (var rs in rsAppCard)
            {
                if (!_Test)
                {
                    if (!lsProcessID.Contains(rs.idProcess))
                    {
                        lsProcessID.Add(rs.idProcess);

                        var rProcessNode = (from c in dcFlow.ProcessNode
                                            where c.ProcessFlow_id == rs.idProcess
                                            && c.FlowNode_id == CardFlowNode_id
                                            && !c.isFinish.Value
                                            select c).FirstOrDefault();

                        if (rProcessNode != null)
                        {
                            var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                  where c.ProcessFlow_id == rs.idProcess
                                                  && c.ProcessNode_auto == rProcessNode.auto
                                                  orderby c.auto descending
                                                  select c).FirstOrDefault();

                            if (rProcessApParm != null)
                            {
                                oService.WorkFinish(rProcessApParm.auto);
                                TextLog.WriteLog("忘刷單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                            }
                        }
                    }
                }
                else
                    TextLog.WriteLog("忘刷單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
            }

            //加班單自動送單 預估加班者有兩者可能不送單 1.實際出勤時數計算小於1小時者 2.實際出勤時數大於預估加班者
            string OtFlowNode_id = System.Configuration.ConfigurationManager.AppSettings["OtFlowNode_id"];

            var rsAppOt = (from o in dcFlow.wfAppOt
                           join pn in dcFlow.ProcessNode on o.idProcess equals pn.ProcessFlow_id
                           where o.sFormCode == "Ot"
                           && o.sState == "1"
                           && o.dDateB.Date < DateTime.Now.Date   //小於今天的日期再抓出來
                           && pn.FlowNode_id == OtFlowNode_id  //不同的系統可能要改
                           && !pn.isFinish.Value
                           select o).ToList();

            var rsRote = (from c in dcHr.ROTE
                          select c).ToList();

            Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(_HRConnectionString);

            foreach (var rs in rsAppOt)
            {
                //非預估加班者直接送單
                if (rs.sReserve1 == "0")
                {
                    if (!_Test)
                    {
                        if (!lsProcessID.Contains(rs.idProcess))
                        {
                            lsProcessID.Add(rs.idProcess);

                            var rProcessNode = (from c in dcFlow.ProcessNode
                                                where c.ProcessFlow_id == rs.idProcess
                                                && c.FlowNode_id == OtFlowNode_id
                                                && !c.isFinish.Value
                                                select c).FirstOrDefault();

                            if (rProcessNode != null)
                            {
                                var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                      where c.ProcessFlow_id == rs.idProcess
                                                      && c.ProcessNode_auto == rProcessNode.auto
                                                      orderby c.auto descending
                                                      select c).FirstOrDefault();

                                if (rProcessApParm != null)
                                {
                                    oService.WorkFinish(rProcessApParm.auto);
                                    TextLog.WriteLog("加班單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                                }
                            }
                        }
                    }
                    else
                        TextLog.WriteLog("加班單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                }
                else
                {
                    TextLog.WriteLog("加班單-判斷工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + "是否有出勤資料");

                    var rAttend = (from c in dcHr.ATTEND
                                   where c.NOBR == rs.sNobr
                                   && c.ADATE.Date == rs.dDateB1.Date
                                   select c).FirstOrDefault();

                    if (rAttend != null)
                    {
                        TextLog.WriteLog("加班單-判斷工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + "是否有出勤刷卡資料");

                        var rRote = rsRote.Where(p => p.ROTE1 == rAttend.ROTE.Trim()).FirstOrDefault();

                        if (rRote != null)
                        {
                            var rFormApp = (from c in dcFlow.wfFormApp
                                            where c.idProcess == rs.idProcess
                                            select c).FirstOrDefault();

                            if (rFormApp != null)
                            {
                                var rAttcard = (from c in dcHr.ATTCARD
                                                where c.NOBR == rs.sNobr
                                                && c.ADATE.Date == rs.dDateB1.Date
                                                select c).FirstOrDefault();

                                string TimeB = "0000";
                                string TimeE = "0000";

                                if (rAttcard != null)
                                {
                                    TimeB = rAttcard.T1;
                                    TimeE = rAttcard.T2;

                                    if (!arrHoliDay.Contains(rAttend.ROTE))
                                        TimeB = rRote.OT_BEGIN;
                                }

                                //如果沒有刷卡資料或不全或是刷卡結束時日比開始時間小
                                if (rAttcard != null && rAttcard.T2.Trim().Length == 4 && (Convert.ToInt32(TimeB) < Convert.ToInt32(TimeE)))
                                {
                                    int iTimeB = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB);
                                    int iTimeE = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE);
                                    int iTemp;

                                    iTemp = (30 - (iTimeB % 30));
                                    iTimeB = iTemp == 30 ? iTimeB : iTimeB + iTemp;
                                    TimeB = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeB);

                                    iTemp = iTimeE % 30;
                                    iTimeE -= iTemp;
                                    TimeE = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeE);

                                    rs.sTimeB = TimeB;
                                    rs.sTimeE = TimeE;

                                    //1.實際出勤時數計算小於1小時者 2.實際出勤時數大於預估加班者 此二者不要送單
                                    DateTime DateTimeB = rs.dDateB1.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB));
                                    DateTime DateTimeE = rs.dDateB1.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE));

                                    //預估大於實際
                                    if (DateTimeE <= rs.dDateTimeE1)
                                    {
                                        rs.iTotalHour = oOtDao.GetCalculate(rs.sNobr, rs.sOtcatCode, rs.dDateB, rs.dDateB, TimeB, TimeE, rs.sOtrcdCode);

                                        //大於等於1小時
                                        if (rs.iTotalHour >= 1)
                                        {
                                            rFormApp.dDateTimeD = DateTime.Now;

                                            if (!_Test)
                                            {
                                                dcFlow.SubmitChanges();

                                                if (!lsProcessID.Contains(rFormApp.idProcess))
                                                {
                                                    lsProcessID.Add(rFormApp.idProcess);

                                                    var rProcessNode = (from c in dcFlow.ProcessNode
                                                                        where c.ProcessFlow_id == rs.idProcess
                                                                        && c.FlowNode_id == OtFlowNode_id
                                                                        && !c.isFinish.Value
                                                                        select c).FirstOrDefault();

                                                    if (rProcessNode != null)
                                                    {
                                                        var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                                              where c.ProcessFlow_id == rs.idProcess
                                                                              && c.ProcessNode_auto == rProcessNode.auto
                                                                              orderby c.auto descending
                                                                              select c).FirstOrDefault();

                                                        if (rProcessApParm != null)
                                                        {
                                                            oService.WorkFinish(rProcessApParm.auto);
                                                            TextLog.WriteLog("加班單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                                                        }
                                                    }
                                                }
                                            }
                                            else
                                                TextLog.WriteLog("加班單-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }

            //換班單(單天)自動送單
            string ShiftShortFlowNode_id = System.Configuration.ConfigurationManager.AppSettings["ShiftShortFlowNode_id"];

            var rsAppShiftShort = (from o in dcFlow.wfAppShiftShort
                                   join pf in dcFlow.ProcessFlow on o.idProcess equals pf.id
                                   join pn in dcFlow.ProcessNode on o.idProcess equals pn.ProcessFlow_id
                                   where o.sFormCode == "ShiftShort"
                                   && o.sState == "1"
                                   && pn.FlowNode_id == ShiftShortFlowNode_id  //不同的系統可能要改
                                   && !pn.isFinish.Value
                                   && !pf.isCancel.Value && !pf.isError.Value && !pf.isFinish.Value
                                   select o).ToList();

            foreach (var rs in rsAppShiftShort)
            {
                if (!_Test)
                {
                    if (!lsProcessID.Contains(rs.idProcess))
                    {
                        lsProcessID.Add(rs.idProcess);

                        var rProcessNode = (from c in dcFlow.ProcessNode
                                            where c.ProcessFlow_id == rs.idProcess
                                            && c.FlowNode_id == ShiftShortFlowNode_id
                                            && !c.isFinish.Value
                                            select c).FirstOrDefault();

                        if (rProcessNode != null)
                        {
                            var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                  where c.ProcessFlow_id == rs.idProcess
                                                  && c.ProcessNode_auto == rProcessNode.auto
                                                  orderby c.auto descending
                                                  select c).FirstOrDefault();

                            if (rProcessApParm != null)
                            {
                                oService.WorkFinish(rProcessApParm.auto);
                                TextLog.WriteLog("換班單(單天)-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                            }
                        }
                    }
                }
                else
                    TextLog.WriteLog("換班單(單天)-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
            }

            //換班單(時間)自動送單
            string ShiftDayFlowNode_id = System.Configuration.ConfigurationManager.AppSettings["ShiftDayFlowNode_id"];

            var rsAppShiftDay = (from o in dcFlow.wfAppShiftDay
                                   join pf in dcFlow.ProcessFlow on o.idProcess equals pf.id
                                   join pn in dcFlow.ProcessNode on o.idProcess equals pn.ProcessFlow_id
                                   where o.sFormCode == "ShiftDay"
                                   && o.sState == "1"
                                   && pn.FlowNode_id == ShiftDayFlowNode_id  //不同的系統可能要改
                                   && !pn.isFinish.Value
                                   && !pf.isCancel.Value && !pf.isError.Value && !pf.isFinish.Value
                                   select o).ToList();

            foreach (var rs in rsAppShiftDay)
            {
                if (!_Test)
                {
                    if (!lsProcessID.Contains(rs.idProcess))
                    {
                        lsProcessID.Add(rs.idProcess);

                        var rProcessNode = (from c in dcFlow.ProcessNode
                                            where c.ProcessFlow_id == rs.idProcess
                                            && c.FlowNode_id == ShiftDayFlowNode_id
                                            && !c.isFinish.Value
                                            select c).FirstOrDefault();

                        if (rProcessNode != null)
                        {
                            var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                  where c.ProcessFlow_id == rs.idProcess
                                                  && c.ProcessNode_auto == rProcessNode.auto
                                                  orderby c.auto descending
                                                  select c).FirstOrDefault();

                            if (rProcessApParm != null)
                            {
                                oService.WorkFinish(rProcessApParm.auto);
                                TextLog.WriteLog("換班單(時間)-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
                            }
                        }
                    }
                }
                else
                    TextLog.WriteLog("換班單(時間)-工號：" + rs.sNobr + ",流程序號：" + rs.idProcess.ToString() + " 傳送成功！");
            }

            DateTime dDateY = DateTime.Now;

            TimeSpan ts = dDateY - dDateX;
            TextLog.WriteLog("服務結束執行...共花" + ts.TotalSeconds.ToString() + "秒");
            TextLog.WriteLog("");

        }
    }
}