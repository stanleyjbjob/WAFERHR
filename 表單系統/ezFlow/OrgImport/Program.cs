using System;
using System.Collections.Generic;
using System.Linq;
using JBModule.Message;

namespace OrgImport
{
    class Program
    {
        static void Main(string[] args)
        {
            DateTime dDateX = DateTime.Now;

            TextLog.WriteLog("服務開始執行...");
            TextLog.WriteLog("匯入版本：20171020v6");

            dcHrDataContext dcHr = new dcHrDataContext();
            dcFlowDataContext dcFlow = new dcFlowDataContext();
            dcFlowDataContext dcFlowSet = new dcFlowDataContext();

            TextLog.WriteLog("人事資料庫：" + dcHr.Connection.Database);
            TextLog.WriteLog("表單資料庫：" + dcFlow.Connection.Database);

            bool bTestImport = false;   //測試匯入
            string sTestMail = "ming@jbjob.com.tw"; //測試信箱
            bool bFullImport = true;    //完整匯入
            bool bSyncLoginPW = false;   //覆蓋密碼與HR密碼同步
            string sFrontLoginID = "";  //帳號前置名稱
            string sTopDeptCode = "";   //起始匯入代碼
            bool bRoleTopEmpty = false; //上層角色全部空白 代表使用部門簽核
            DateTime dDate = DateTime.Now.Date; //匯入參考生效日
            int iOutDay = -10;  //離職幾天的員工匯入
            bool bDeptLevelDirection = false;    //部門階層方向 正向或反向
            bool bFixBug = true;    //修正錯誤

            var rSysVar = (from c in dcFlowSet.SysVar
                           select c).FirstOrDefault();

            var rOrgImport = (from c in dcFlow.OrgImport
                              select c).FirstOrDefault();

            if (rSysVar == null || rOrgImport == null)
            {
                TextLog.WriteLog("系統資料不正確SysVar Or OrgImport");
                return;
            }

            bTestImport = rOrgImport.bTest.Value;
            sTestMail = rOrgImport.sTestMail;
            bFullImport = rOrgImport.bFullImport.Value;
            bSyncLoginPW = rOrgImport.bSyncLoginPW.Value;
            sFrontLoginID = rOrgImport.sFrontLoginID;
            sTopDeptCode = rOrgImport.sDeptTopCode;
            bRoleTopEmpty = rOrgImport.bRoleTopEmpty.Value;
            dDate = DateTime.Now.Date;
            bDeptLevelDirection = rOrgImport.bLevel.Value;
            bFixBug = rOrgImport.bFixBug.Value;

            TextLog.WriteLog("測試匯入：" + bTestImport.ToString());
            TextLog.WriteLog("測試信箱：" + sTestMail);
            TextLog.WriteLog("完整匯入：" + bFullImport.ToString());
            TextLog.WriteLog("密碼同步：" + bSyncLoginPW.ToString());
            TextLog.WriteLog("帳號前置名稱：" + sFrontLoginID);
            TextLog.WriteLog("部門起始匯入代碼：" + sTopDeptCode);
            TextLog.WriteLog("角色上層空白：" + bRoleTopEmpty.ToString());
            TextLog.WriteLog("匯入生效日：" + dDate.ToShortDateString());
            TextLog.WriteLog("部門階層正向：" + bDeptLevelDirection.ToString());
            TextLog.WriteLog("修正錯誤：" + bFixBug.ToString());

            TextLog.WriteLog("載入所需資料...");

            var rsFlowEmp = (from c in dcFlow.Emp
                             select c).ToList();

            var rsFlowEmpBak = (from c in dcFlow.EmpBak
                                select c).ToList();

            var rsFlowDept = (from c in dcFlow.Dept
                              select c).ToList();

            var rsFlowDeptLevel = (from c in dcFlow.DeptLevel
                                   select c).ToList();

            var rsFlowPos = (from c in dcFlow.Pos
                             select c).ToList();

            var rsFlowPosLevel = (from c in dcFlow.PosLevel
                                  select c).ToList();

            var rsFlowRole = (from c in dcFlow.Role
                              select c).ToList();

            string[] arrTtscode = { "1", "4", "6" };
            var rsHrBase = (from b in dcHr.BASE
                            join bt in dcHr.BASETTS
                            on b.NOBR equals bt.NOBR
                            join d in dcHr.DEPT
                            on bt.DEPT equals d.D_NO
                            join dm in dcHr.DEPTA
                            on bt.DEPTM equals dm.D_NO
                            join p in dcHr.JOB
                            on bt.JOB equals p.JOB1
                            where bt.ADATE.Value.Date <= dDate
                            && dDate <= bt.DDATE.Value.Date
                            && (arrTtscode.Contains(bt.TTSCODE.ToString().Trim())
                            || bt.OUDT.Value.Date >= dDate.AddDays(iOutDay).Date)
                            select new
                            {
                                Nobr = b.NOBR.Trim(),
                                PassWord = b.PASSWORD.Trim().Length > 0 ? b.PASSWORD.Trim() : b.NOBR.Trim(),
                                NameC = b.NAME_C.Trim(),
                                //Email = b.EMAIL.Trim().Length > 0 ? b.EMAIL.Trim() : sTestMail,
                                Email = b.EMAIL.Trim().Length > 0 ? b.EMAIL.Trim() : "",
                                Sex = b.SEX.ToString(),
                                TtsCode = bt.TTSCODE.ToString().Trim(),
                                DateA = bt.ADATE.Value.Date,
                                OutDate = bt.OUDT != null ? bt.OUDT.Value.Date : DateTime.Now,
                                DeptCode = bt.DEPT.Trim(),
                                DeptmCode = bt.DEPTM.Trim(),
                                JobCode = bt.JOB.Trim(),
                                Manage = bt.MANG.Value,
                                //Manage1 = bt.MANGE.Value,
                            }).ToList();

            var rsHrDept = (from c in dcHr.DEPT
                            where c.ADATE.Value.Date <= dDate
                            && dDate <= c.DDATE.Value.Date
                            select new
                            {
                                Code = c.D_NO.Trim(),
                                Name = c.D_NAME.Trim(),
                                Group = c.DEPT_GROUP.Trim(),
                                Tree = c.DEPT_TREE.Trim(),
                                ManageNobr = "",// c.NOBR,
                            }).ToList();

        var rsHrDeptm = (from c in dcHr.DEPTA
                         where c.ADATE.Value.Date <= dDate
                         && dDate <= c.DDATE.Value.Date
                         select new
                         {
                             Code = c.D_NO.Trim(),
                             Name = c.D_NAME.Trim(),
                             Group = c.DEPT_GROUP.Trim(),
                             Tree = c.DEPT_TREE.Trim(),
                             ManageNobr = "",// c.NOBR.Trim(),
                             }).ToList();

            var rsHrJob = (from c in dcHr.JOB
                           //where c.ADATE.Date <= dDate
                           //&& dDate <= c.DDATE.Date
                           select new
                           {
                               Code = c.JOB1.Trim(),
                               Name = c.JOB_NAME.Trim(),
                               Tree = c.JOB_TREE != null ? c.JOB_TREE.ToString() : "",
                           }).ToList();

            TextLog.WriteLog("目前資料情況");
            TextLog.WriteLog("===================");
            TextLog.WriteLog("表單員工總數：" + rsFlowEmp.Count.ToString());
            TextLog.WriteLog("表單部門總數：" + rsFlowDept.Count.ToString());
            TextLog.WriteLog("表單職稱總數：" + rsFlowPos.Count.ToString());
            TextLog.WriteLog("===================");
            TextLog.WriteLog("應轉員工總數：" + rsHrBase.Count.ToString());
            TextLog.WriteLog("應轉部門總數：" + rsHrDeptm.Count.ToString());
            TextLog.WriteLog("應轉職稱總數：" + rsHrJob.Count.ToString());
            TextLog.WriteLog("===================");

            TextLog.WriteLog("開始匯入...");

            TextLog.WriteLog("備份表單員工資料...");
            foreach (var rFlowEmp in rsFlowEmp)
            {
                var rsFlowEmpBakWhere = rsFlowEmpBak.Where(p => p.id == rFlowEmp.id).FirstOrDefault();
                if (rsFlowEmpBakWhere == null)
                {
                    rsFlowEmpBakWhere = new EmpBak();
                    dcFlow.EmpBak.InsertOnSubmit(rsFlowEmpBakWhere);
                    rsFlowEmpBakWhere.id = rFlowEmp.id;
                }

                rsFlowEmpBakWhere.pw = rFlowEmp.pw;
                rsFlowEmpBakWhere.name = rFlowEmp.name;
                rsFlowEmpBakWhere.isNeedAgent = rFlowEmp.isNeedAgent;
                rsFlowEmpBakWhere.dateB = rFlowEmp.dateB;
                rsFlowEmpBakWhere.dateE = rFlowEmp.dateE;
                rsFlowEmpBakWhere.email = rFlowEmp.email;
                rsFlowEmpBakWhere.login = rFlowEmp.login;
                rsFlowEmpBakWhere.sex = rFlowEmp.sex;
            }

            TextLog.WriteLog("系統關閉中...");
            //rSysVar.sysClose = true;

            dcFlowSet.SubmitChanges();

            dcFlow.SubmitChanges();

            TextLog.WriteLog("刪除表單基本資料...");
            object[] obj = new object[] { "" };
            dcFlow.ExecuteCommand("DELETE FROM Emp", obj);
            dcFlow.ExecuteCommand("DELETE FROM Dept", obj);
            dcFlow.ExecuteCommand("DELETE FROM Pos", obj);
            dcFlow.ExecuteCommand("DELETE FROM DeptLevel", obj);
            dcFlow.ExecuteCommand("DELETE FROM PosLevel", obj);
            dcFlow.ExecuteCommand("DELETE FROM Role", obj);

            TextLog.WriteLog("匯入員工及角色基本資料...");
            List<Emp> lsEmp = new List<Emp>();
            List<Role> lsRole = new List<Role>();
            string sPW;
            string sID;
            DateTime dDateB = dDate.AddDays(iOutDay).Date;
            foreach (var rHrBase in rsHrBase)
            {
                var rsFlowEmpBakWhere = rsFlowEmpBak.Where(p => p.id == rHrBase.Nobr).FirstOrDefault();

                sPW = (bSyncLoginPW || (rsFlowEmpBakWhere == null)) ? (rHrBase.PassWord.Length > 0 ? rHrBase.PassWord : rHrBase.Nobr) : rsFlowEmpBakWhere.pw.Trim().Length > 0 ? rsFlowEmpBakWhere.pw : rsFlowEmpBakWhere.id;

                var rEmp = new Emp();
                rEmp.id = rHrBase.Nobr;
                rEmp.pw = sPW;
                rEmp.name = rsFlowEmpBakWhere == null ? rHrBase.NameC : rsFlowEmpBakWhere.name;
                rEmp.isNeedAgent = true;
                rEmp.dateB = rsFlowEmpBakWhere != null ? rsFlowEmpBakWhere.dateB : DateTime.Now.Date.AddDays(-1);
                rEmp.dateE = rsFlowEmpBakWhere != null ? rsFlowEmpBakWhere.dateE : DateTime.Now.Date.AddDays(-1);
                //rEmp.email = rHrBase.Email.Trim().Length > 0 ? rHrBase.Email : sTestMail;
                rEmp.email = rHrBase.Email.Trim().Length > 0 ? rHrBase.Email : "";
                rEmp.email = bTestImport ? sTestMail : rEmp.email;  //測試
                rEmp.login = rsFlowEmpBakWhere != null ? rsFlowEmpBakWhere.login : sFrontLoginID + rHrBase.Nobr;
                rEmp.sex = rHrBase.Sex;
                lsEmp.Add(rEmp);

                sID = rHrBase.DeptmCode + rHrBase.JobCode;
                sID += Convert.ToBoolean(rHrBase.Manage) ? "1" : "0";   //如果是主管，就改變角色代碼
                if (rHrBase.Nobr == "100373")
                    sID += "";
                //sID += "0";  

                var rRole = new Role();
                rRole.id = sID;
                rRole.idParent = "";
                rRole.Dept_id = rHrBase.DeptmCode;
                rRole.Pos_id = rHrBase.JobCode;
                rRole.dateB = arrTtscode.Contains(Convert.ToString(rHrBase.TtsCode)) || dDateB <= rHrBase.OutDate ? DateTime.Now.Date : rHrBase.DateA;
                rRole.dateE = arrTtscode.Contains(Convert.ToString(rHrBase.TtsCode)) || dDateB <= rHrBase.OutDate ? new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date : new DateTime(1900, 1, 1).Date;
                rRole.Emp_id = rHrBase.Nobr;
                rRole.mgDefault = rHrBase.Manage;
                rRole.deptMg = rRole.mgDefault;
                lsRole.Add(rRole);
            }

            TextLog.WriteLog("匯入部門組織及部門階層...");
            List<Dept> lsDept = new List<Dept>();
            List<DeptLevel> lsDeptLevel = new List<DeptLevel>();
            DeptLevel rDeptLevel;
            foreach (var rHrDeptm in rsHrDeptm)
            {
                if (rHrDeptm.Code.Length > 0)
                {
                    var rDept = new Dept();
                    rDept.id = rHrDeptm.Code;
                    rDept.idParent = rHrDeptm.Code == rHrDeptm.Group || rDept.id == sTopDeptCode ? "" : rHrDeptm.Group;    //與部門代碼相同或是最上層部門就空白
                    rDept.name = rHrDeptm.Name;
                    rDept.DeptLevel_id = rHrDeptm.Tree.Length > 0 ? rHrDeptm.Tree : "0";
                    rDept.path = "";
                    lsDept.Add(rDept);

                    //建立部門所需階層資料
                    if (!lsDeptLevel.Where(p => p.id == rDept.DeptLevel_id).Any())
                    {
                        rDeptLevel = new DeptLevel();
                        rDeptLevel.id = rDept.DeptLevel_id;
                        rDeptLevel.name = "部門" + rDeptLevel.id;
                        rDeptLevel.sorting = bDeptLevelDirection ? Convert.ToInt32(rDeptLevel.id) : Convert.ToInt32(rDeptLevel.id) - 1000;
                        lsDeptLevel.Add(rDeptLevel);
                    }
                }
            }

            //建立部門所需階層資料-預設值
            if (!lsDeptLevel.Where(p => p.id == "0").Any())
            {
                rDeptLevel = new DeptLevel();
                rDeptLevel.id = "0";
                rDeptLevel.name = "部門" + rDeptLevel.id;
                rDeptLevel.sorting = 0;
                lsDeptLevel.Add(rDeptLevel);
            }

            TextLog.WriteLog("匯入職稱...");
            List<Pos> lsPos = new List<Pos>();
            List<PosLevel> lsPosLevel = new List<PosLevel>();
            PosLevel rPosLevel;
            foreach (var rHrJob in rsHrJob)
            {
                if (rHrJob.Code.Length > 0)
                {
                    var rPos = new Pos();
                    rPos.id = rHrJob.Code;
                    rPos.name = rHrJob.Name;
                    rPos.PosLevel_id = rHrJob.Tree.Trim().Length > 0 ? rHrJob.Tree.Trim() : "0";
                    lsPos.Add(rPos);

                    //建立職稱所需階層資料
                    if (!lsPosLevel.Where(p => p.id == rPos.PosLevel_id).Any())
                    {
                        rPosLevel = new PosLevel();
                        rPosLevel.id = rPos.PosLevel_id.Trim();
                        rPosLevel.name = "職員" + rPosLevel.id.Trim();
                        rPosLevel.sorting = bDeptLevelDirection ? Convert.ToInt32(rPosLevel.id) : Convert.ToInt32(rPosLevel.id) - 1000;
                        lsPosLevel.Add(rPosLevel);
                    }
                }
            }

            //建立職稱所需階層資料-預設值
            if (!lsPosLevel.Where(p => p.id == "0").Any())
            {
                rPosLevel = new PosLevel();
                rPosLevel.id = "0";
                rPosLevel.name = "職員" + rPosLevel.id;
                rPosLevel.sorting = 0;
                lsPosLevel.Add(rPosLevel);
            }

            TextLog.WriteLog("建立部門從屬關係與產生部門路徑...");
            var rsFlowDeptWhere = lsDept.Where(p => p.idParent == "");
            foreach (var rFlowDeptWhere in rsFlowDeptWhere)
            {
                rFlowDeptWhere.path = "/" + rFlowDeptWhere.name;
                var rowsDept = lsDept.Where(p => p.idParent == rFlowDeptWhere.id);
                if (rowsDept.Count() > 0)
                    CreateSubOrgPath(lsDept, rowsDept, rFlowDeptWhere.path);
            }

            TextLog.WriteLog("匯入部門所設定的主管...");
            var rsHrBaseWhere = rsHrBase.Where(p => arrTtscode.Contains(Convert.ToString(p.TtsCode)));
            var rsHrDeptmWhere = rsHrDeptm.Where(p =>p.ManageNobr != null && p.ManageNobr.Length > 0);

            foreach (var rHrDeptmWhere in rsHrDeptmWhere)
            {
                var rHrBaseWhereWhere = rsHrBaseWhere.Where(p => p.Nobr == rHrDeptmWhere.ManageNobr).FirstOrDefault();
                if (rHrBaseWhereWhere != null)
                {
                    var rRole = lsRole.Where(p => p.Dept_id.Trim() == rHrDeptmWhere.Code && p.deptMg.Value).FirstOrDefault();
                    if (rRole == null)    //找不到就把自己換成主管
                        rRole = lsRole.Where(p => p.Dept_id.Trim() == rHrDeptmWhere.Code && p.Emp_id.Trim() == rHrDeptmWhere.ManageNobr).FirstOrDefault();

                    sID = rHrDeptmWhere.Code + rHrBaseWhereWhere.JobCode + "1";

                    //找不到才需要新增
                    if (rRole == null)
                    {
                        rRole = new Role();
                        lsRole.Add(rRole);

                        rRole.idParent = "";
                        rRole.Dept_id = rHrDeptmWhere.Code;
                        rRole.Pos_id = rHrBaseWhereWhere.JobCode;
                        rRole.dateB = arrTtscode.Contains(Convert.ToString(rHrBaseWhereWhere.TtsCode)) || dDateB <= rHrBaseWhereWhere.OutDate ? DateTime.Now.Date : rHrBaseWhereWhere.DateA;
                        rRole.dateE = arrTtscode.Contains(Convert.ToString(rHrBaseWhereWhere.TtsCode)) || dDateB <= rHrBaseWhereWhere.OutDate ? new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date : new DateTime(1900, 1, 1).Date;
                    }

                    rRole.id = sID;
                    rRole.Emp_id = rHrDeptmWhere.ManageNobr;
                    rRole.mgDefault = true;
                    rRole.deptMg = true;
                }
            }

            TextLog.WriteLog("建立角色從屬關係...");
            foreach (var rHrDeptm in rsHrDeptm)
            {
                var rsRole = lsRole.Where(p => p.Dept_id.Trim() == rHrDeptm.Code);
                var rDeptmManage = lsRole.Where(p => p.mgDefault.Value && p.Dept_id.Trim() == rHrDeptm.Code).FirstOrDefault();

                string sManageRoleID = "";
                string sDeptParent = rHrDeptm.Group;

                //尋找部門主管
                do
                {
                    var rDeptmManageP = lsRole.Where(p => p.mgDefault.Value && p.Dept_id.Trim() == sDeptParent).FirstOrDefault();
                    if (rDeptmManageP != null)
                        sManageRoleID = rDeptmManageP.id.Trim();

                    var rDeptParent = rsHrDeptm.Where(p => p.Code.Trim() == sDeptParent && p.Code.Trim() != p.Group.Trim()).FirstOrDefault();
                    if (rDeptParent != null)
                        sDeptParent = rDeptParent.Group.Trim();
                    else
                        sDeptParent = "";

                } while (sManageRoleID == "" && sDeptParent.Length > 0);

                foreach (var rRole in rsRole)
                {
                    //主管
                    if (rRole.deptMg.Value)
                        rRole.idParent = sManageRoleID.Length > 0 ? sManageRoleID : rRole.idParent;
                    else
                    {
                        //如果員工的單位主管不存在，則直接用部門的主管當主管
                        if (rDeptmManage != null)
                            rRole.idParent = rDeptmManage.id.Trim();
                        else if (sManageRoleID.Length > 0)
                            rRole.idParent = sManageRoleID;
                    }
                }
            }

            dcFlowSet.Emp.InsertAllOnSubmit(lsEmp);
            dcFlowSet.Role.InsertAllOnSubmit(lsRole);

            dcFlowSet.Dept.InsertAllOnSubmit(lsDept);
            dcFlowSet.DeptLevel.InsertAllOnSubmit(lsDeptLevel);

            dcFlowSet.Pos.InsertAllOnSubmit(lsPos);
            dcFlowSet.PosLevel.InsertAllOnSubmit(lsPosLevel);

            TextLog.WriteLog("資料儲存中(需要比較久的時間)...");
            dcFlowSet.SubmitChanges();

            TextLog.WriteLog("修正錯誤(需要比較久的時間)...");
            //FixPorcess(dcFlowSet);

            TextLog.WriteLog("系統開啟中...");
            //rSysVar.sysClose = false;
            dcFlowSet.SubmitChanges();

            TextLog.WriteLog("結束匯入...");

            DateTime dDateY = DateTime.Now;

            TimeSpan ts = dDateY - dDateX;

            TextLog.WriteLog("服務結束執行...共花" + ts.TotalSeconds.ToString() + "秒");
            TextLog.WriteLog("");
        }

        /// <summary>
        /// 遞回部門路徑
        /// </summary>
        /// <param name="lsDept"></param>
        /// <param name="rows"></param>
        /// <param name="parentPath"></param>
        private static void CreateSubOrgPath(List<Dept> lsDept, IEnumerable<Dept> rows, string parentPath)
        {
            foreach (var r in rows)
            {
                r.path = parentPath + "/" + r.name;
                var rowsDept = lsDept.Where(p => p.idParent == r.id);
                if (rowsDept.Count() > 0)
                    CreateSubOrgPath(lsDept, rowsDept, r.path);
            }
        }

        /// <summary>
        /// 修正流程
        /// </summary>
        /// <param name="dcFlow"></param>
        private static void FixPorcess(dcFlowDataContext dcFlow)
        {
            object[] obj = new object[] { "" };

            //修正常態代理人的角色(指定者) 
            //dcFlow.ExecuteCommand("UPDATE CheckAgentAlways SET Role_idSource = (SELECT TOP 1 id FROM Role WHERE (Emp_id = CheckAgentAlways.Emp_idSource))", obj);
            //修正工作職務代理人的角色(指定者)  
            dcFlow.ExecuteCommand("UPDATE WorkAgent SET Role_idSource = (SELECT TOP 1 id FROM Role WHERE (Emp_id = WorkAgent.Emp_idSource))", obj);
            //修正工作職務代理人的角色(被指定者)  
            dcFlow.ExecuteCommand("UPDATE WorkAgent SET Role_idTarget = ISNULL ((SELECT TOP 1 id FROM Role WHERE (Emp_id = WorkAgent.Emp_idTarget)), '')", obj);
            //刪除已不存在的工作職務代理人工號(指定者)  
            dcFlow.ExecuteCommand("DELETE FROM WorkAgent WHERE (Role_idSource IS NULL)", obj);
            //修正工作職務代理人的工號，當角色為空白時，工號也為空白(被指定者)  
            dcFlow.ExecuteCommand("UPDATE WorkAgent SET Emp_idTarget = '' WHERE (Role_idTarget = '')", obj);
            //修正節點(自訂成員)  
            dcFlow.ExecuteCommand("UPDATE NodeCustom SET Role_id = (SELECT TOP 1 id FROM Role WHERE (Emp_id = NodeCustom.Emp_id)) WHERE ((SELECT TOP 1 id FROM Role WHERE (Emp_id = NodeCustom.Emp_id)) IS NOT NULL)", obj);
            //修正節點(動態成員)  
            dcFlow.ExecuteCommand("UPDATE NodeDynamic SET fdRole = (SELECT TOP 1 id FROM Role WHERE (Emp_id = NodeDynamic.fdEmp)) WHERE ((SELECT TOP 1 id FROM Role WHERE (Emp_id = NodeDynamic.fdEmp)) IS NOT NULL)", obj);
            //修正ProcessApParm  
            dcFlow.ExecuteCommand("UPDATE ProcessApParm SET Role_id = (SELECT TOP 1 id FROM Role WHERE (Emp_id = ProcessApParm.Emp_id))WHERE ((SELECT TOP 1 id FROM Role AS Role_1 WHERE (Emp_id = ProcessApParm.Emp_id)) IS NOT NULL) AND (ProcessFlow_id IN (SELECT id FROM ProcessFlow WHERE (isFinish = 0) AND (isError = 0) AND (isCancel = 0)))", obj);
            //修正ProcessApView  
            dcFlow.ExecuteCommand("UPDATE ProcessApView SET Role_id = (SELECT TOP 1 id FROM Role WHERE (Emp_id = ProcessApView.Emp_id))WHERE ((SELECT TOP 1 id FROM Role AS Role_1 WHERE (Emp_id = ProcessApView.Emp_id)) IS NOT NULL) AND (ProcessFlow_id IN (SELECT id FROM ProcessFlow WHERE (isFinish = 0) AND (isError = 0) AND (isCancel = 0)))", obj);
            //修正ProcessCheck(Default)  
            dcFlow.ExecuteCommand("UPDATE ProcessCheck SET Role_idDefault = (SELECT TOP 1 id FROM Role WHERE (Emp_id = ProcessCheck.Emp_idDefault))WHERE ((SELECT TOP 1 id FROM Role AS Role_1 WHERE (Emp_id = ProcessCheck.Emp_idDefault)) IS NOT NULL) AND (adate = '1900-1-1')", obj);
            //修正ProcessCheck(Agent)  
            dcFlow.ExecuteCommand("UPDATE ProcessCheck SET Role_idAgent = (SELECT TOP 1 id FROM Role WHERE (Emp_id = ProcessCheck.Emp_idAgent))WHERE (adate = '1900-1-1') AND ((SELECT TOP 1 id FROM Role AS Role_1 WHERE (Emp_id = ProcessCheck.Emp_idAgent)) IS NOT NULL)", obj);
            //修正ProcessCheck(Real)  
            dcFlow.ExecuteCommand("UPDATE ProcessCheck SET Role_idReal = (SELECT TOP 1 id FROM Role WHERE (Emp_id = ProcessCheck.Emp_idReal))WHERE (adate = '1900-1-1') AND ((SELECT TOP 1 id FROM Role AS Role_1 WHERE (Emp_id = ProcessCheck.Emp_idReal)) IS NOT NULL)", obj);
            //修正ProcessFlow  
            dcFlow.ExecuteCommand("UPDATE ProcessFlow SET Role_id = (SELECT TOP 1 id FROM Role WHERE (Emp_id = ProcessFlow.Emp_id))WHERE ((SELECT TOP 1 id FROM Role AS Role_1 WHERE (Emp_id = ProcessFlow.Emp_id)) IS NOT NULL) AND (isFinish = 0) AND (isError = 0) AND (isCancel = 0)", obj);
            //修正ProcessFlowShare  
            dcFlow.ExecuteCommand("UPDATE ProcessFlowShare SET Role_id = (SELECT TOP 1 id FROM Role WHERE (Emp_id = ProcessFlowShare.Emp_id))WHERE ((SELECT TOP 1 id FROM Role AS Role_1 WHERE (Emp_id = ProcessFlowShare.Emp_id)) IS NOT NULL) AND (ProcessFlow_id IN (SELECT id FROM ProcessFlow WHERE (isFinish = 0) AND (isError = 0) AND (isCancel = 0)))", obj);
            //刪除ProcessException  
            //dcFlow.ExecuteCommand("DELETE FROM ProcessException", obj);
            //刪除SubWork 
            //dcFlow.ExecuteCommand("DELETE FROM SubWork", obj);
        }
    }
}