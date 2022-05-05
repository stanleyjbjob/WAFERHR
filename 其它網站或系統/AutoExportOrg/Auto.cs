using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.IO;

namespace AutoExportOrg
{
    //此介面供其它表單使用
    public interface ItreeSelector
    {
        string SelectedRoleID { get;}
        string SelectedID { get; }
        string SelectedName { get; }
    }

    public partial class Auto : Form
    {
        public FlowDSTableAdapters.FlowTreeTableAdapter FlowTreeTA = new AutoExportOrg.FlowDSTableAdapters.FlowTreeTableAdapter();
        public FlowDSTableAdapters.ProcessNodeTableAdapter ProcessNodeTA = new AutoExportOrg.FlowDSTableAdapters.ProcessNodeTableAdapter();
        public FlowDSTableAdapters.ProcessFlowTableAdapter ProcessFlowTA = new AutoExportOrg.FlowDSTableAdapters.ProcessFlowTableAdapter();
        public FlowDSTableAdapters.ProcessExceptionTableAdapter ProcessExceptionTA = new AutoExportOrg.FlowDSTableAdapters.ProcessExceptionTableAdapter();
        public FlowDSTableAdapters.QueriesTableAdapter QueriesTA = new AutoExportOrg.FlowDSTableAdapters.QueriesTableAdapter();
        public FlowDSTableAdapters.RoleTableAdapter RoleTA = new AutoExportOrg.FlowDSTableAdapters.RoleTableAdapter();
        public FlowDSTableAdapters.ProcessCheckTableAdapter ProcessCheckTA = new AutoExportOrg.FlowDSTableAdapters.ProcessCheckTableAdapter();
        public FlowDSTableAdapters.DeptTableAdapter DeptTA = new AutoExportOrg.FlowDSTableAdapters.DeptTableAdapter();
        public FlowDSTableAdapters.EmpTableAdapter EmpTA = new AutoExportOrg.FlowDSTableAdapters.EmpTableAdapter();
        public FlowDSTableAdapters.PosTableAdapter PosTA = new AutoExportOrg.FlowDSTableAdapters.PosTableAdapter();

        //匯入專用暫存
        public FlowDSTableAdapters.tempBaseTableAdapter tempBaseTA = new AutoExportOrg.FlowDSTableAdapters.tempBaseTableAdapter();
        public FlowDSTableAdapters.tempDeptTableAdapter tempDeptTA = new AutoExportOrg.FlowDSTableAdapters.tempDeptTableAdapter();
        public FlowDSTableAdapters.tempPosTableAdapter tempPosTA = new AutoExportOrg.FlowDSTableAdapters.tempPosTableAdapter();

        //原DTS
        public FlowDSTableAdapters.BASETTSTableAdapter BASETTSTA = new AutoExportOrg.FlowDSTableAdapters.BASETTSTableAdapter();
        public FlowDSTableAdapters.DeptATableAdapter DeptATA = new AutoExportOrg.FlowDSTableAdapters.DeptATableAdapter();
        public FlowDSTableAdapters.JOBTableAdapter JOBTA = new AutoExportOrg.FlowDSTableAdapters.JOBTableAdapter();

        //檢視部門
        public FlowDSTableAdapters.EmpDataTableAdapter EmpDataTA = new AutoExportOrg.FlowDSTableAdapters.EmpDataTableAdapter();

        public FlowDSTableAdapters.SubWorkTableAdapter SubWorkTA = new AutoExportOrg.FlowDSTableAdapters.SubWorkTableAdapter();
        public FlowDSTableAdapters.SubWorkDataTableAdapter SubWorkDataTA = new AutoExportOrg.FlowDSTableAdapters.SubWorkDataTableAdapter();

        //改變流程簽核者
        public ProcessDSTableAdapters.ProcessApParmTableAdapter taProcessApParm = new AutoExportOrg.ProcessDSTableAdapters.ProcessApParmTableAdapter();
        public ProcessDSTableAdapters.ProcessApViewTableAdapter taProcessApView = new AutoExportOrg.ProcessDSTableAdapters.ProcessApViewTableAdapter();
        public ProcessDSTableAdapters.ProcessCheckTableAdapter taProcessCheck = new AutoExportOrg.ProcessDSTableAdapters.ProcessCheckTableAdapter();
        public ProcessDSTableAdapters.ProcessFlowShareTableAdapter taProcessFlowShare = new AutoExportOrg.ProcessDSTableAdapters.ProcessFlowShareTableAdapter();
        public ProcessDSTableAdapters.ProcessFlowTableAdapter taProcessFlow = new AutoExportOrg.ProcessDSTableAdapters.ProcessFlowTableAdapter();
        public ProcessDSTableAdapters.ProcessNodeTableAdapter taProcessNode = new AutoExportOrg.ProcessDSTableAdapters.ProcessNodeTableAdapter();


        public FlowDS oFlowDS = new FlowDS();
        public ProcessDS oProcessDS = new ProcessDS();
        public DataRow[] rows, rowsDept;

        public Auto()
        {
            InitializeComponent();
        }

        private void Auto_Load(object sender, EventArgs e)
        {
            try
            {
                btnDTS_Click();
                ImportA();
                ImportB();
            }
            catch(Exception ex)
            {
                CreateTextFile("C:\\FlowError\\AutoExportOrg" + DateTime.Now.ToFileTime().ToString() + ".txt", ex.ToString());
                throw ex;
            }
            Close();
        }

        public static void CreateTextFile(string sFileName, string sError)
        {
            StreamWriter sw = File.CreateText(@sFileName);
            sw.Write(sError);
            sw.Close();
        }

        #region ImportFlow
        public void ImportA()
        {
            FlowDS.EmpDataTable dtEmp = new FlowDS.EmpDataTable();
            EmpTA.Fill(dtEmp);

            tempBaseTA.Fill(oFlowDS.tempBase);
            EmpTA.Fill(oFlowDS.Emp);
            tempDeptTA.Fill(oFlowDS.tempDept);
            DeptTA.Fill(oFlowDS.Dept);
            tempPosTA.Fill(oFlowDS.tempPos);
            PosTA.Fill(oFlowDS.Pos);

            //如果是完整匯入，先行刪除Emp、Dept、Pos所有資料


            //刪除Emp
            foreach (FlowDS.EmpRow r in oFlowDS.Emp.Rows)
                r.Delete();


            //刪除Dept
            foreach (FlowDS.DeptRow r in oFlowDS.Dept.Rows)
                r.Delete();



            //刪除Pos
            foreach (FlowDS.PosRow r in oFlowDS.Pos.Rows)
                r.Delete();

            EmpTA.Update(oFlowDS.Emp);
            DeptTA.Update(oFlowDS.Dept);
            PosTA.Update(oFlowDS.Pos);

            DataRow[] rowsA;

            //匯入Emp
            foreach (FlowDS.tempBaseRow r in oFlowDS.tempBase.Rows)
            {
                rows = oFlowDS.Emp.Select("id = '" + r.id + "'");
                rowsA = dtEmp.Select("id = '" + r.id + "'");

                //無相同資料才進行轉入(由於之前可能已先刪除資料，因此無需再判斷是否完整匯入)
                if (rows.Length == 0)
                {
                    FlowDS.EmpRow re = oFlowDS.Emp.NewEmpRow();
                    re.id = r.id;
                    //re.pw = ((cbPW.Checked) || (htPW[r.id] == null)) ? r.pw : htPW[r.id].ToString();    //20080226 by ming 用珍
                    re.pw = r.pw;   //20080226 by ming 用珍
                    re.name = r.name;
                    re.isNeedAgent = true;
                    re.dateB = (rowsA.Length == 0) ? new DateTime(1900, 1, 1).Date : Convert.ToDateTime(rowsA[0]["dateB"]);
                    re.dateE = (rowsA.Length == 0) ? new DateTime(1900, 1, 1).Date : Convert.ToDateTime(rowsA[0]["dateE"]);
                    re.email = r.IsemailNull() ? "" : r.email;
                    re.login = r.id;
                    re.sex = (r.sex == "M") ? "男" : "女";
                    oFlowDS.Emp.AddEmpRow(re);
                }
            }

            //匯入Dept
            foreach (FlowDS.tempDeptRow r in oFlowDS.tempDept.Rows)
            {
                rows = oFlowDS.Dept.Select("id = '" + r.id + "'");

                if (rows.Length == 0)
                {
                    FlowDS.DeptRow rd = oFlowDS.Dept.NewDeptRow();
                    rd.id = r.id;
                    rd.idParent = r.idParent;
                    rd.name = r.name;
                    rd.DeptLevel_id = "0";
                    rd.path = "";

                    if (r.id != r.idParent)
                        oFlowDS.Dept.AddDeptRow(rd);
                }
            }

            //匯入Pos
            foreach (FlowDS.tempPosRow r in oFlowDS.tempPos.Rows)
            {
                rows = oFlowDS.Pos.Select("id = '" + r.id + "'");

                if (rows.Length == 0)
                {
                    FlowDS.PosRow rp = oFlowDS.Pos.NewPosRow();
                    rp.id = r.id;
                    rp.name = r.name;
                    rp.PosLevel_id = "0";
                    oFlowDS.Pos.AddPosRow(rp);
                }
            }

            //建立部門從屬關係與產生部門路徑
            rows = oFlowDS.Dept.Select("idParent = ''", "id");
            foreach (FlowDS.DeptRow r in rows)
            {
                r.idParent = "";    //起始Root一定要變成空白Flow強制指定
                r.path = "/" + r.name;
                rowsDept = oFlowDS.Dept.Select("idParent = '" + r.id + "'", "id");
                if (rowsDept.Length > 0)
                    CreateSubOrgPath(rowsDept, r.path);
            }

            //找不到上層部門時
            foreach (FlowDS.DeptRow r in oFlowDS.Dept.Rows)
                r.idParent = (r.path.Length == 0) ? "" : r.idParent;

            EmpTA.Update(oFlowDS.Emp);
            DeptTA.Update(oFlowDS.Dept);
            PosTA.Update(oFlowDS.Pos);
        }

        //遞回部門路徑
        public void CreateSubOrgPath(DataRow[] rowsDept, string parentPath)
        {
            foreach (FlowDS.DeptRow r in rowsDept)
            {
                r.path = parentPath + "/" + r.name;
                rowsDept = oFlowDS.Dept.Select("idParent = '" + r.id + "'", "id");
                if (rowsDept.Length > 0) CreateSubOrgPath(rowsDept, r.path);
            }
        }

        public void ImportB()
        {
            tempBaseTA.Fill(oFlowDS.tempBase);
            RoleTA.Fill(oFlowDS.Role);
            SubWorkTA.Fill(oFlowDS.SubWork);

            //如果是完整匯入，先行失效Role所有資料


            foreach (FlowDS.RoleRow r in oFlowDS.Role.Rows)
            {
                //先讓失效日大於等於今天的失效，其餘的保持不動(這樣才知道其它的是何時失效的)
                r.dateE = (r.dateE >= DateTime.Now.Date) ? DateTime.Now.Date.AddDays(-1) : r.dateE;
            }


            RoleTA.Update(oFlowDS.Role);





            foreach (FlowDS.RoleRow r in oFlowDS.Role.Rows)
            {
                r.Delete();


            }


            RoleTA.Update(oFlowDS.Role);



            //匯入Role
            string id;
            FlowDS.RoleRow rr;
            foreach (FlowDS.tempBaseRow r in oFlowDS.tempBase.Rows)
            {
                id = r.dept + r.job;
                rows = oFlowDS.Role.Select("id = '" + id + "' AND Emp_id = '" + r.id + "'");

                if (rows.Length == 0)
                {
                    rr = oFlowDS.Role.NewRoleRow();
                    rr.id = id;
                    rr.idParent = "";
                    rr.Dept_id = r.dept;
                    rr.Pos_id = r.job;
                    rr.dateB = DateTime.Now.Date;
                    rr.dateE = new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date;
                    rr.Emp_id = r.id;
                    rr.mgDefault = r.mang;
                    rr.deptMg = r.mang;
                    oFlowDS.Role.AddRoleRow(rr);
                }
                else
                {
                    rr = (FlowDS.RoleRow)rows[0];
                    rr.dateE = new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date;
                    rr.mgDefault = r.mang;
                    rr.deptMg = r.mang;
                }
            }

            //副職
            foreach (FlowDS.SubWorkRow r in oFlowDS.SubWork.Rows)
            {
                id = r.sSubDept + r.sSubJob;
                rows = oFlowDS.Role.Select("id = '" + id + "'");

                if (rows.Length == 0)
                {
                    rr = oFlowDS.Role.NewRoleRow();
                    rr.id = id;
                    rr.idParent = "";
                    rr.Dept_id = r.sSubDept;
                    rr.Pos_id = r.sSubJob;
                    rr.dateB = DateTime.Now.Date;
                    rr.dateE = new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date;
                    rr.Emp_id = r.sNobr;
                    rr.mgDefault = r.bSubMang;
                    rr.deptMg = r.bSubMang;
                    oFlowDS.Role.AddRoleRow(rr);
                }
                else
                {
                    foreach (FlowDS.RoleRow rrr in rows)
                    {
                        //取代 2008/1/23 by ming 穎台淑芬
                        if (r.bReplace)
                        {
                            //工號不同才需要取代
                            if (r.sNobr != rrr.id)
                            {
                                rrr.Emp_id = r.sNobr;
                                rrr.Dept_id = r.sSubDept;
                                rrr.Pos_id = r.sSubJob;
                            }

                            rrr.dateE = new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date;
                            rrr.mgDefault = r.bSubMang;
                            rrr.deptMg = r.bSubMang;
                        }
                        else
                        {
                            //因為為用取代，所以工號不同時才要新增一筆 
                            if (r.sNobr != rrr.id)
                            {
                                rr = oFlowDS.Role.NewRoleRow();
                                rr.id = id;
                                rr.idParent = "";
                                rr.Dept_id = r.sSubDept;
                                rr.Pos_id = r.sSubJob;
                                rr.dateB = DateTime.Now.Date;
                                rr.dateE = new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date;
                                rr.Emp_id = r.sNobr;
                                rr.mgDefault = r.bSubMang;
                                rr.deptMg = r.bSubMang;
                                oFlowDS.Role.AddRoleRow(rr);
                            }
                        }
                    }
                }
            }

            //建立從屬關係
            DataRow[] rowsBase = oFlowDS.tempBase.Select("mang = 1");
            foreach (FlowDS.tempBaseRow r in rowsBase)
            {
                id = r.dept + r.job;

                rows = oFlowDS.Role.Select("Emp_id <> '" + r.id + "' AND Dept_id = '" + r.dept + "'");
                foreach (FlowDS.RoleRow r1 in rows)
                {
                    if (r1.id == id)
                    {
                        r1.idParent = "";
                    }
                    else
                    {
                        r1.idParent = (r1.dateE >= DateTime.Now.Date) ? id : r1.idParent;
                    }
                }
            }

            //建立副職從屬關係 2008/1/23 by ming 穎台淑芬
            DataRow[] rowsSub = oFlowDS.SubWork.Select("bSubMang = 1");
            foreach (FlowDS.SubWorkRow r in rowsSub)
            {
                id = r.sSubDept + r.sSubJob;

                rows = oFlowDS.Role.Select("Emp_id <> '" + r.sNobr + "' AND Dept_id = '" + r.sSubDept + "'");
                foreach (FlowDS.RoleRow r1 in rows)
                {
                    if (r1.id == id)
                    {
                        r1.idParent = "";
                    }
                    else
                    {
                        r1.idParent = (r1.dateE >= DateTime.Now.Date) ? id : r1.idParent;
                    }
                }
            }
            RoleTA.Update(oFlowDS.Role);
        }

        private void btnDTS_Click()
        {
            //if (MessageBox.Show("您確定要從HR匯資料到暫存的資料表嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
            //執行DTS的功能在這裡做
            tempBaseTA.Fill(oFlowDS.tempBase);
            tempDeptTA.Fill(oFlowDS.tempDept);
            tempPosTA.Fill(oFlowDS.tempPos);
            BASETTSTA.Fill(oFlowDS.BASETTS);
            DeptATA.Fill(oFlowDS.DeptA);
            JOBTA.Fill(oFlowDS.JOB);

            foreach (FlowDS.tempBaseRow r in oFlowDS.tempBase.Rows)
                r.Delete();

            foreach (FlowDS.tempDeptRow r in oFlowDS.tempDept.Rows)
                r.Delete();

            foreach (FlowDS.tempPosRow r in oFlowDS.tempPos.Rows)
                r.Delete();

            foreach (FlowDS.BASETTSRow r in oFlowDS.BASETTS.Rows)
                //oFlowDS.tempBase.ImportRow(r);
                if (oFlowDS.tempBase.Select("id = '" + r.id.Trim() + "'").Length == 0)
                    oFlowDS.tempBase.AddtempBaseRow(r.id, r.pw, r.name, r.email, r.login, r.sex, r.dept, r.depts, r.job, r.jobl, r.jobs, r.MANG);
            

            foreach (FlowDS.DeptARow r in oFlowDS.DeptA.Rows)
                //oFlowDS.tempDept.ImportRow(r);
                oFlowDS.tempDept.AddtempDeptRow(r.id, r.idParent, r.name, r.DeptLevel_id);


            foreach (FlowDS.JOBRow r in oFlowDS.JOB.Rows)
                //oFlowDS.tempPos.ImportRow(r);
                oFlowDS.tempPos.AddtempPosRow(r.id, r.name, r.PosLevel_id);

            tempBaseTA.Update(oFlowDS.tempBase);
            tempDeptTA.Update(oFlowDS.tempDept);
            tempPosTA.Update(oFlowDS.tempPos);

            //MessageBox.Show("匯入完成");
            //}
        }

        #endregion
    }
}