using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;
using System.Collections;

namespace ezFlowManage {
    //此介面供其它表單使用
    public interface ItreeSelector {
        string SelectedRoleID { get;}
        string SelectedID { get; }
        string SelectedName { get; }
    }

    public partial class fmMain : Form {
        public FlowDSTableAdapters.FlowTreeTableAdapter FlowTreeTA = new ezFlowManage.FlowDSTableAdapters.FlowTreeTableAdapter();
        public FlowDSTableAdapters.ProcessNodeTableAdapter ProcessNodeTA = new ezFlowManage.FlowDSTableAdapters.ProcessNodeTableAdapter();
        public FlowDSTableAdapters.ProcessFlowTableAdapter ProcessFlowTA = new ezFlowManage.FlowDSTableAdapters.ProcessFlowTableAdapter();
        public FlowDSTableAdapters.ProcessExceptionTableAdapter ProcessExceptionTA = new ezFlowManage.FlowDSTableAdapters.ProcessExceptionTableAdapter();
        public FlowDSTableAdapters.QueriesTableAdapter QueriesTA = new ezFlowManage.FlowDSTableAdapters.QueriesTableAdapter();
        public FlowDSTableAdapters.RoleTableAdapter RoleTA = new ezFlowManage.FlowDSTableAdapters.RoleTableAdapter();
        public FlowDSTableAdapters.ProcessCheckTableAdapter ProcessCheckTA = new ezFlowManage.FlowDSTableAdapters.ProcessCheckTableAdapter();
        public FlowDSTableAdapters.DeptTableAdapter DeptTA = new ezFlowManage.FlowDSTableAdapters.DeptTableAdapter();
        public FlowDSTableAdapters.EmpTableAdapter EmpTA = new ezFlowManage.FlowDSTableAdapters.EmpTableAdapter();
        public FlowDSTableAdapters.PosTableAdapter PosTA = new ezFlowManage.FlowDSTableAdapters.PosTableAdapter();

        //匯入專用暫存
        public FlowDSTableAdapters.tempBaseTableAdapter tempBaseTA = new ezFlowManage.FlowDSTableAdapters.tempBaseTableAdapter();
        public FlowDSTableAdapters.tempDeptTableAdapter tempDeptTA = new ezFlowManage.FlowDSTableAdapters.tempDeptTableAdapter();
        public FlowDSTableAdapters.tempPosTableAdapter tempPosTA = new ezFlowManage.FlowDSTableAdapters.tempPosTableAdapter();

        //原DTS
        public FlowDSTableAdapters.BASETTSTableAdapter BASETTSTA = new ezFlowManage.FlowDSTableAdapters.BASETTSTableAdapter();
        public FlowDSTableAdapters.DeptATableAdapter DeptATA = new ezFlowManage.FlowDSTableAdapters.DeptATableAdapter();
        public FlowDSTableAdapters.JOBTableAdapter JOBTA = new ezFlowManage.FlowDSTableAdapters.JOBTableAdapter();

        //檢視部門
        public FlowDSTableAdapters.EmpDataTableAdapter EmpDataTA = new ezFlowManage.FlowDSTableAdapters.EmpDataTableAdapter();

        public FlowDSTableAdapters.SubWorkTableAdapter SubWorkTA = new ezFlowManage.FlowDSTableAdapters.SubWorkTableAdapter();
        public FlowDSTableAdapters.SubWorkDataTableAdapter SubWorkDataTA = new ezFlowManage.FlowDSTableAdapters.SubWorkDataTableAdapter();

        //改變流程簽核者
        public ProcessDSTableAdapters.ProcessApParmTableAdapter taProcessApParm = new ezFlowManage.ProcessDSTableAdapters.ProcessApParmTableAdapter();
        public ProcessDSTableAdapters.ProcessApViewTableAdapter taProcessApView = new ezFlowManage.ProcessDSTableAdapters.ProcessApViewTableAdapter();
        public ProcessDSTableAdapters.ProcessCheckTableAdapter taProcessCheck = new ezFlowManage.ProcessDSTableAdapters.ProcessCheckTableAdapter();
        public ProcessDSTableAdapters.ProcessFlowShareTableAdapter taProcessFlowShare = new ezFlowManage.ProcessDSTableAdapters.ProcessFlowShareTableAdapter();
        public ProcessDSTableAdapters.ProcessFlowTableAdapter taProcessFlow = new ezFlowManage.ProcessDSTableAdapters.ProcessFlowTableAdapter();
        public ProcessDSTableAdapters.ProcessNodeTableAdapter taProcessNode = new ezFlowManage.ProcessDSTableAdapters.ProcessNodeTableAdapter();


        public FlowDS oFlowDS = new FlowDS();
        public ProcessDS oProcessDS = new ProcessDS();
        public DataRow[] rows, rowsDept;

        public fmMain() {
            InitializeComponent();
        }

        private void fmMain_Load(object sender, EventArgs e) {
            // TODO: 這行程式碼會將資料載入 'flowDS.SubWorkData' 資料表。您可以視需要進行移動或移除。
            this.subWorkDataTableAdapter.Fill(this.flowDS.SubWorkData);
            // TODO: 這行程式碼會將資料載入 'flowDS.tempPos' 資料表。您可以視需要進行移動或移除。
            this.tempPosTableAdapter.Fill(this.flowDS.tempPos);
            // TODO: 這行程式碼會將資料載入 'flowDS.tempDept' 資料表。您可以視需要進行移動或移除。
            this.tempDeptTableAdapter.Fill(this.flowDS.tempDept);
            // TODO: 這行程式碼會將資料載入 'flowDS.tempBase' 資料表。您可以視需要進行移動或移除。
            this.tempBaseTableAdapter.Fill(this.flowDS.tempBase);
            // TODO: 這行程式碼會將資料載入 'flowDS.ProcessException' 資料表。您可以視需要進行移動或移除。
            this.processExceptionTableAdapter.Fill(this.flowDS.ProcessException);
            // TODO: 這行程式碼會將資料載入 'flowDS.ProcessFlow' 資料表。您可以視需要進行移動或移除。
            this.processFlowTableAdapter.Fill(this.flowDS.ProcessFlow);

            ckFlow.Enabled = FlowTreeTA.GetData().Rows.Count > 0;
            ckDept.Enabled = DeptTA.GetData().Rows.Count > 0;
            ckStarter.Enabled = EmpTA.GetData().Rows.Count > 0;

            bindGrid();

            setDefault();
            lbTime.Text = "尚未執行過";

            fmDeptSelector_Load();

            SubWorkDefault();
        }

        #region Admin
        public void ShowSelectMsg() {
            lblSelectMsg.Text = "";

            lblSelectMsg.Text += ckCancel.Checked ? ckCancel.Text + "&&" : "";
            lblSelectMsg.Text += ckFlow.Checked ? ckFlow.Text + "(" + ckFlow.AccessibleName + ")&&" : "";
            lblSelectMsg.Text += ckDept.Checked ? ckDept.Text + "(" + ckDept.AccessibleName + ")&&" : "";
            lblSelectMsg.Text += ckStarter.Checked ? ckStarter.Text + "(" + ckStarter.AccessibleName + ")&&" : "";
            lblSelectMsg.Text += ckDate.Checked ? ckDate.Text + "(" + dtStart.Value.ToShortDateString() + "-" + dtEnd.Value.ToShortDateString() + ")" : "";

            lblSelectMsg.Text = lblSelectMsg.Text.Length == 0 ? "目前無任何篩選條件" : lblSelectMsg.Text;

            bindGrid();
        }

        private void CheckedChanged(object sender, EventArgs e) {
            ShowSelectMsg();
        }

        private ItreeSelector GetSelector(CheckBox ctrl) {
            ItreeSelector dlg = null;
            switch (ctrl.Name) {
                case "ckFlow":
                    dlg = new fmFlowTreeSelector();
                    break;
                case "ckDept":
                    dlg = new fmDeptSelector();
                    break;
                case "ckStarter":
                    dlg = new fmEmpSelector();
                    break;
            }

            return dlg;
        }

        private void ck_CheckedChanged(object sender, EventArgs e) {
            CheckBox ctrl = (CheckBox)sender;
            if (ctrl.Checked) {
                ItreeSelector selector = GetSelector(ctrl);
                if (((Form)selector).ShowDialog() == DialogResult.OK) {
                    ctrl.Tag = selector.SelectedID;
                    ctrl.AccessibleName = selector.SelectedName;
                    ctrl.AccessibleDescription = selector.SelectedRoleID;
                   
                }
                else {
                    ctrl.Checked = false;
                }
            }

            ShowSelectMsg();
        }

        private void bindGrid() {
            processFlowTableAdapter.Fill(flowDS.ProcessFlow);

            string Filter = "1 = 1";

            Filter += (ckCancel.Checked) ? " AND isCancel = 1" : " AND isCancel = 0";
            Filter += (ckFlow.Checked) ? " AND FlowTree_id = '" + ckFlow.Tag.ToString() + "'" : "";
            Filter += (ckDept.Checked) ? " AND Dept_path LIKE '" + ckDept.Tag.ToString() + "%'" : "";
            Filter += (ckStarter.Checked) ? " AND Emp_id = '" + ckStarter.Tag.ToString() + "'" : "";
            Filter += (ckDate.Checked) ? " AND adate >= #" + dtStart.Value.Date.ToString("yyyy/MM/dd 00:00:00") + "# AND adate <= #" + dtEnd.Value.Date.ToString("yyyy/MM/dd 23:59:59") + "#" : "";

            processFlowBindingSource.Filter = Filter;
        }

        //中止、恢復、完成(駁回)
        private void bnCancel_Click(object sender, EventArgs e) {
            Button btn = (Button)sender;
            if (MessageBox.Show("選取的流程將會" + btn.Text+ "，確定嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                foreach (DataGridViewRow grdRow in grdProcess.SelectedRows) {
                    FlowDS.ProcessFlowDataTable ProcessFlowDT = ProcessFlowTA.GetDataById(Convert.ToInt32(grdRow.Cells[0].Value));
                    ProcessFlowDT[0].isCancel = btn.Name == "bnCancel" || btn.Name == "bnFinish";
                    ProcessFlowDT[0].isFinish = btn.Name == "bnFinish";
                    ProcessFlowTA.Update(ProcessFlowDT);
                }

                bindGrid();
            }
        }

        private void bnDelete_Click(object sender, EventArgs e) {
            if (MessageBox.Show("選取的流程將會從資料庫徹底刪除，確定嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                foreach (DataGridViewRow grdRow in grdProcess.SelectedRows) {
                    FlowDS.ProcessFlowDataTable ProcessFlowDT = ProcessFlowTA.GetDataById(Convert.ToInt32(grdRow.Cells[0].Value));
                    FlowDS.ProcessNodeDataTable ProcessNodeDT = ProcessNodeTA.GetDataByProcessFlow(Convert.ToInt32(grdRow.Cells[0].Value));
                   
                    foreach (DataRow row in ProcessNodeDT.Rows) {
                        FlowDS.ProcessNodeRow rowProcessNode = (FlowDS.ProcessNodeRow)row;
                        DeleteSubFlow(rowProcessNode.auto);
                        QueriesTA.DeleteQueryForProcessCheck(rowProcessNode.auto);
                        row.Delete();
                    }

                    ProcessNodeTA.Update(ProcessNodeDT);

                    QueriesTA.DeleteQueryForProcessFlowShare(ProcessFlowDT[0].id);
                    QueriesTA.DeleteQueryForProcessApParm(ProcessFlowDT[0].id);
                    QueriesTA.DeleteQueryProcessApView(ProcessFlowDT[0].id);
                    QueriesTA.DeleteQueryForProcessException(ProcessFlowDT[0].id);

                    ProcessFlowDT[0].Delete();
                    ProcessFlowTA.Update(ProcessFlowDT);
                }
                bindGrid();
            }
        }

        void DeleteSubFlow(int ProcessNode_auto) {
            FlowDS.ProcessFlowDataTable ProcessFlowDT_sub = ProcessFlowTA.GetDataByProcessNode(ProcessNode_auto);
            foreach (DataRow row1 in ProcessFlowDT_sub.Rows) {
                FlowDS.ProcessFlowRow rowProcessFlow_Sub = (FlowDS.ProcessFlowRow)row1;
                FlowDS.ProcessNodeDataTable ProcessNodeDT_sub = ProcessNodeTA.GetDataByProcessFlow(rowProcessFlow_Sub.id);
                foreach (DataRow row2 in ProcessNodeDT_sub.Rows) {
                    FlowDS.ProcessNodeRow rowProcessNode_Sub = ( FlowDS.ProcessNodeRow)row2;
                    DeleteSubFlow(rowProcessNode_Sub.auto);
                    QueriesTA.DeleteQueryForProcessCheck(rowProcessNode_Sub.auto);
                    row2.Delete();
                }

                ProcessNodeTA.Update(ProcessNodeDT_sub);

                QueriesTA.DeleteQueryForProcessFlowShare(rowProcessFlow_Sub.id);
                QueriesTA.DeleteQueryForProcessApParm(rowProcessFlow_Sub.id);
                QueriesTA.DeleteQueryProcessApView(rowProcessFlow_Sub.id);
                QueriesTA.DeleteQueryForProcessException(rowProcessFlow_Sub.id);

                row1.Delete();
            }

            ProcessFlowTA.Update(ProcessFlowDT_sub);
        }

        private void btnAssign_Click(object sender, EventArgs e) {
            fmEmpSelector dlgEmpSelector = new fmEmpSelector();
            if (dlgEmpSelector.ShowDialog() == DialogResult.OK) {
                if (MessageBox.Show("選取的流程將會更改簽核者為" + dlgEmpSelector.SelectedName + "，確定嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                    foreach (DataGridViewRow grdRow in grdProcess.SelectedRows) {
                        ProcessCheckTA.FillByAuto(oFlowDS.ProcessCheck, Convert.ToInt32(grdRow.Cells[0].Value));

                        if (oFlowDS.ProcessCheck.Rows.Count > 0) {
                            FlowDS.ProcessCheckRow rp = (FlowDS.ProcessCheckRow)oFlowDS.ProcessCheck.Rows[0];
                            rp.Role_idDefault = dlgEmpSelector.SelectedRoleID;
                            rp.Emp_idDefault = dlgEmpSelector.SelectedID;
                            ProcessCheckTA.Update(oFlowDS.ProcessCheck);
                        }
                    }
                    bindGrid();
                }
            }
        }

        #endregion

        #region ImportFlow

        private void btnRest_Click(object sender, EventArgs e) {
            setDefault();
        }

        private void btnImportA_Click(object sender, EventArgs e) {
            if (MessageBox.Show("您確定要匯入組織嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                this.Enabled = false;
                ImportA();
                this.Enabled = true;
            }

            tvDept.Nodes.Clear();
            fmDeptSelector_Load();
        }

        private void btnImportB_Click(object sender, EventArgs e) {
            if (MessageBox.Show("您確定要重組角色嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                this.Enabled = false;
                ImportB();
                this.Enabled = true;
            }
        }

        private void tmImport_Tick(object sender, EventArgs e) {
            if (DateTime.Now.Hour == int.Parse(txtHour.Text) && cbAutoImport.Checked) {
                ImportA();
            }
        }

        private void cbAutoImport_CheckedChanged(object sender, EventArgs e) {
            lbState.Text = cbAutoImport.Checked ? "自動執行打開" : "自動執行關閉";
        }

        //private void Form1_Resize(object sender, EventArgs e) {
        //    nfcImport.Visible = (WindowState == FormWindowState.Minimized);
        //    ShowInTaskbar = (WindowState != FormWindowState.Minimized);
        //}

        //private void nfcImport_MouseDoubleClick(object sender, MouseEventArgs e) {
        //    WindowState = FormWindowState.Normal;

        //    nfcImport.Visible = false;
        //    ShowInTaskbar = true;
        //}

        public void setDefault() {
            btnDTS_Click();
            lbEmpCount.Text = tempBaseTA.GetData().Rows.Count.ToString() + "/" + EmpTA.GetData().Rows.Count.ToString();
            lbDeptCount.Text = tempDeptTA.GetData().Rows.Count.ToString() + "/" + DeptTA.GetData().Rows.Count.ToString();
            lbJobCount.Text = tempPosTA.GetData().Rows.Count.ToString() + "/" + PosTA.GetData().Rows.Count.ToString();

            lbImportA.Text = "";
            lbImportB.Text = "";
            progressBarA.Value = 0;
            progressBarB.Value = 0;
        }

        public void ImportA() {
            FlowDS.EmpDataTable dtEmp = new FlowDS.EmpDataTable();
            EmpTA.Fill(dtEmp);

            tempBaseTA.Fill(oFlowDS.tempBase);
            EmpTA.Fill(oFlowDS.Emp);
            tempDeptTA.Fill(oFlowDS.tempDept);
            DeptTA.Fill(oFlowDS.Dept);
            tempPosTA.Fill(oFlowDS.tempPos);
            PosTA.Fill(oFlowDS.Pos);

            //Hashtable htPW = new Hashtable();

            lbImportA.Text = "";
            progressBarA.Value = 0;
            progressBarA.Maximum = oFlowDS.tempBase.Rows.Count + oFlowDS.tempDept.Rows.Count + oFlowDS.tempPos.Rows.Count;

            //如果是完整匯入，先行刪除Emp、Dept、Pos所有資料
            if (cbFullImport.Checked) {
                progressBarA.Maximum += oFlowDS.Emp.Rows.Count + oFlowDS.Dept.Rows.Count + oFlowDS.Pos.Rows.Count;

                //刪除Emp
                foreach (FlowDS.EmpRow r in oFlowDS.Emp.Rows) {
                    //if (!cbPW.Checked) {
                    //    htPW.Add(r.id, r.pw);
                    //}
                    r.Delete();

                    progressBarA.Value++;
                    lbImportA.Text = "刪除資料中…" + progressBarA.Value * 100 / progressBarA.Maximum + "%";
                    Application.DoEvents();
                }

                //刪除Dept
                foreach (FlowDS.DeptRow r in oFlowDS.Dept.Rows) {
                    r.Delete();

                    progressBarA.Value++;
                    lbImportA.Text = "刪除資料中…" + progressBarA.Value * 100 / progressBarA.Maximum + "%";
                    Application.DoEvents();
                }

                //刪除Pos
                foreach (FlowDS.PosRow r in oFlowDS.Pos.Rows) {
                    r.Delete();

                    progressBarA.Value++;
                    lbImportA.Text = "刪除資料中…" + progressBarA.Value * 100 / progressBarA.Maximum + "%";
                    Application.DoEvents();
                }

                try {
                    EmpTA.Update(oFlowDS.Emp);
                    DeptTA.Update(oFlowDS.Dept);
                    PosTA.Update(oFlowDS.Pos);
                }
                catch {
                    lbImportA.Text = "刪除失敗";
                    return;
                }
            }

            DataRow[] rowsA;

            //匯入Emp
            foreach (FlowDS.tempBaseRow r in oFlowDS.tempBase.Rows) {
                rows = oFlowDS.Emp.Select("id = '" + r.id + "'");
                rowsA = dtEmp.Select("id = '" + r.id + "'");

                //無相同資料才進行轉入(由於之前可能已先刪除資料，因此無需再判斷是否完整匯入)
                if (rows.Length == 0) {
                    FlowDS.EmpRow re = oFlowDS.Emp.NewEmpRow();
                    re.id = r.id;
                    //re.pw = ((cbPW.Checked) || (htPW[r.id] == null)) ? r.pw : htPW[r.id].ToString();    //20080226 by ming 用珍
                    re.pw = ((cbPW.Checked) || (rowsA.Length == 0)) ? r.pw : rowsA[0]["pw"].ToString();   //20080226 by ming 用珍
                    re.name = r.name;
                    re.isNeedAgent = true;
                    re.dateB = (rowsA.Length == 0) ? new DateTime(1900, 1, 1).Date : Convert.ToDateTime(rowsA[0]["dateB"]);
                    re.dateE = (rowsA.Length == 0) ? new DateTime(1900, 1, 1).Date : Convert.ToDateTime(rowsA[0]["dateE"]);
                    re.email = r.IsemailNull() ? "" : r.email;
                    re.login = cbNobr.Checked ? r.id : r.login;
                    re.sex = (r.sex == "M") ? "男" : "女";
                    oFlowDS.Emp.AddEmpRow(re);
                }

                progressBarA.Value++;
                lbImportA.Text = "匯入資料中…" + progressBarA.Value * 100 / progressBarA.Maximum + "%";
                Application.DoEvents();
            }

            //匯入Dept
            foreach (FlowDS.tempDeptRow r in oFlowDS.tempDept.Rows) {
                rows = oFlowDS.Dept.Select("id = '" + r.id + "'");

                if (rows.Length == 0) {
                    FlowDS.DeptRow rd = oFlowDS.Dept.NewDeptRow();
                    rd.id = r.id;
                    rd.idParent = (cbDeptP.Checked && r.id == r.idParent) ? txtDeptP.Text : r.idParent;
                    rd.name = r.name;
                    rd.DeptLevel_id = "0";
                    rd.path = "";

                    if (cbDept.Checked || r.id != r.idParent) {
                        oFlowDS.Dept.AddDeptRow(rd);
                    }
                }

                progressBarA.Value++;
                lbImportA.Text = "匯入資料中…" + progressBarA.Value * 100 / progressBarA.Maximum + "%";
                Application.DoEvents();
            }

            //匯入Pos
            foreach (FlowDS.tempPosRow r in oFlowDS.tempPos.Rows) {
                rows = oFlowDS.Pos.Select("id = '" + r.id + "'");

                if (rows.Length == 0) {
                    FlowDS.PosRow rp = oFlowDS.Pos.NewPosRow();
                    rp.id = r.id;
                    rp.name = r.name;
                    rp.PosLevel_id = "0";
                    oFlowDS.Pos.AddPosRow(rp);
                }

                progressBarA.Value++;
                lbImportA.Text = "匯入資料中…" + progressBarA.Value * 100 / progressBarA.Maximum + "%";
                Application.DoEvents();
            }

            //建立部門從屬關係與產生部門路徑
            rows = oFlowDS.Dept.Select("idParent = '" + txtDept.Text + "'", "id");
            progressBarA.Maximum += rows.Length;
            foreach (FlowDS.DeptRow r in rows) {
                r.idParent = "";    //起始Root一定要變成空白Flow強制指定
                r.path = "/" + r.name;
                rowsDept = oFlowDS.Dept.Select("idParent = '" + r.id + "'", "id");
                if (rowsDept.Length > 0)
                    CreateSubOrgPath(rowsDept, r.path);

                progressBarA.Value++;
                lbImportA.Text = "建立從屬關係中…" + progressBarA.Value * 100 / progressBarA.Maximum + "%";
                Application.DoEvents();
            }

            //找不到上層部門時
            if (cbDeptPP.Checked) {
                foreach (FlowDS.DeptRow r in oFlowDS.Dept.Rows) {
                    r.idParent = (r.path.Length == 0) ? "" : r.idParent;
                }
            }

            try {
                EmpTA.Update(oFlowDS.Emp);
                DeptTA.Update(oFlowDS.Dept);
                PosTA.Update(oFlowDS.Pos);

                progressBarA.Value = progressBarA.Maximum;
                lbImportA.Text = "匯入完成100%";
                Application.DoEvents();

                if (cbB.Checked) {
                    ImportB();
                }

                lbTime.Text = DateTime.Now.ToString();
            }
            catch {
                lbImportA.Text = "匯入失敗";
                return;
            }
        }

        //遞回部門路徑
        public void CreateSubOrgPath(DataRow[] rowsDept, string parentPath) {
            foreach (FlowDS.DeptRow r in rowsDept) {
                r.path = parentPath + "/" + r.name;
                rowsDept = oFlowDS.Dept.Select("idParent = '" + r.id + "'", "id");
                if (rowsDept.Length > 0) CreateSubOrgPath(rowsDept, r.path);
            }
        }

        public void ImportB() {
            tempBaseTA.Fill(oFlowDS.tempBase);
            RoleTA.Fill(oFlowDS.Role);
            SubWorkTA.Fill(oFlowDS.SubWork);

            lbImportB.Text = "";
            progressBarB.Value = 0;
            progressBarB.Maximum = oFlowDS.tempBase.Rows.Count * 2 + oFlowDS.SubWork.Rows.Count;

            //如果是完整匯入，先行失效Role所有資料
            if (cbFullImport.Checked) {
                progressBarB.Maximum += oFlowDS.Role.Rows.Count;

                foreach (FlowDS.RoleRow r in oFlowDS.Role.Rows) {
                    //先讓失效日大於等於今天的失效，其餘的保持不動(這樣才知道其它的是何時失效的)
                    r.dateE = (r.dateE >= DateTime.Now.Date) ? DateTime.Now.Date.AddDays(-1) : r.dateE;

                    progressBarB.Value++;
                    lbImportB.Text = "異動資料中…" + progressBarB.Value * 100 / progressBarB.Maximum + "%";
                    Application.DoEvents();
                }

                try {
                    RoleTA.Update(oFlowDS.Role);
                }
                catch (Exception ex) {
                    lbImportB.Text = "異動失敗";
                    return;
                }
            }

            if (cbRoleDel.Checked) {
                progressBarB.Maximum += oFlowDS.Role.Rows.Count;

                foreach (FlowDS.RoleRow r in oFlowDS.Role.Rows) {
                    r.Delete();

                    progressBarB.Value++;
                    lbImportB.Text = "角色刪除中…" + progressBarB.Value * 100 / progressBarB.Maximum + "%";
                    Application.DoEvents();
                }

                try {
                    RoleTA.Update(oFlowDS.Role);
                }
                catch {
                    lbImportB.Text = "刪除失敗";
                    return;
                }
            }

            //匯入Role
            string id;
            FlowDS.RoleRow rr;
            foreach (FlowDS.tempBaseRow r in oFlowDS.tempBase.Rows) {
                id = r.dept + r.job;
                rows = oFlowDS.Role.Select("id = '" + id + "' AND Emp_id = '" + r.id + "'");

                if (rows.Length == 0) {
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
                else {
                    rr = (FlowDS.RoleRow)rows[0];
                    rr.dateE = new DateTime(9999, 12, DateTime.DaysInMonth(9999, 12)).Date;
                    rr.mgDefault = r.mang;
                    rr.deptMg = r.mang;
                }

                progressBarB.Value++;
                lbImportB.Text = "重建角色匯入中…" + progressBarB.Value * 100 / progressBarB.Maximum + "%";
                Application.DoEvents();
            }

            //副職
            foreach (FlowDS.SubWorkRow r in oFlowDS.SubWork.Rows) {
                id = r.sSubDept + r.sSubJob;
                rows = oFlowDS.Role.Select("id = '" + id + "'");

                if (rows.Length == 0) {
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
                else  {
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

                progressBarB.Value++;
                lbImportB.Text = "重建角色匯入中…" + progressBarB.Value * 100 / progressBarB.Maximum + "%";
                Application.DoEvents();
            }

            //建立從屬關係
            DataRow[] rowsBase = oFlowDS.tempBase.Select("mang = 1");
            foreach (FlowDS.tempBaseRow r in rowsBase) {
                id = r.dept + r.job;

                rows = oFlowDS.Role.Select("Emp_id <> '" + r.id + "' AND Dept_id = '" + r.dept + "'");
                foreach (FlowDS.RoleRow r1 in rows) {
                    if ((cbRoleP.Checked && r1.id == id) || (cbRolePnull.Checked)) {
                        r1.idParent = "";
                    }
                    else {
                        r1.idParent = (r1.dateE >= DateTime.Now.Date) ? id : r1.idParent;
                    }
                }

                progressBarB.Value++;
                lbImportB.Text = "建立從屬關係中…" + progressBarB.Value * 100 / progressBarB.Maximum + "%";
                Application.DoEvents();
            }

            //建立副職從屬關係 2008/1/23 by ming 穎台淑芬
            DataRow[] rowsSub = oFlowDS.SubWork.Select("bSubMang = 1");
            foreach (FlowDS.SubWorkRow r in rowsSub)
            {
                id = r.sSubDept + r.sSubJob;

                rows = oFlowDS.Role.Select("Emp_id <> '" + r.sNobr + "' AND Dept_id = '" + r.sSubDept + "'");
                foreach (FlowDS.RoleRow r1 in rows)
                {
                    if ((cbRoleP.Checked && r1.id == id) || (cbRolePnull.Checked))
                    {
                        r1.idParent = "";
                    }
                    else
                    {
                        r1.idParent = (r1.dateE >= DateTime.Now.Date) ? id : r1.idParent;
                    }
                }
            }

            try {
                RoleTA.Update(oFlowDS.Role);

                progressBarB.Value = progressBarB.Maximum;
                lbImportB.Text = "匯入完成100%";
                Application.DoEvents();

                lbTime.Text = DateTime.Now.ToString();
            }
            catch {
                lbImportB.Text = "匯入失敗";
                return;
            }
        }

        //重匯簽核的流程(處理卡單問題)
        public void ImportC()
        {

        }

        private void btnDTS_Click() {
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

        #region Dept

        private TreeNode tn;

        private void fmDeptSelector_Load() {
            DeptTA.Fill(oFlowDS.Dept);

            rows = oFlowDS.Dept.Select("idParent = ''");
            foreach (FlowDS.DeptRow r in rows) {
                tn = new TreeNode();
                tn.Text = r.name;
                tn.Tag = r.id;
                tn.ImageIndex = 0;
                tn.SelectedImageIndex = 0;
                tn.Expand();
                tvDept.Nodes.Add(tn);
                CreateDept(r.id, tn);
            }
        }

        //新增子節點
        private void CreateDept(string idParent, TreeNode nodeParent) {
            rows = oFlowDS.Dept.Select("idParent = '" + idParent + "'");
            foreach (FlowDS.DeptRow r in rows) {
                tn = new TreeNode();
                tn.Text = r.name;
                tn.Tag = r.id;
                tn.ImageIndex = 0;
                tn.SelectedImageIndex = 0;
                tn.Expand();
                nodeParent.Nodes.Add(tn);
                CreateDept(r.id, tn);
            }
        }

        private void tvDept_Click(object sender, EventArgs e) {
     
        }

        private void tvDept_DoubleClick(object sender, EventArgs e) {
            empDataTableAdapter.Fill(flowDS.EmpData);
            empDataBindingSource.Filter = "Dept_id = '" + tvDept.SelectedNode.Tag.ToString() + "'";

            foreach (DataGridViewRow grdRow in grdEmp.Rows) {
                bool Mang = Convert.ToBoolean(grdRow.Cells[4].Value);
                if (Mang) {
                    foreach (DataGridViewCell grdCell in grdRow.Cells) {
                        grdCell.Style.BackColor = Color.Red;
                    }
                }
            }
        }

        #endregion

        #region ErrorReturn

        private void bnOK_Click(object sender, EventArgs e) {
            if (MessageBox.Show("問題確實已解決了？(被標示為已解決的例外，將不再顯示。)", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                List<int> lstProcessFlow = new List<int>();
                List<string> lstErrorType = new List<string>();

                foreach (DataGridViewRow grdRow in grdException.SelectedRows) {
                    int auto = Convert.ToInt32(grdRow.Cells[0].Value);
                    ProcessExceptionTA.FillByAuto(oFlowDS.ProcessException, auto);
                    oFlowDS.ProcessException[0].isOK = true;
                    ProcessExceptionTA.Update(oFlowDS.ProcessException);

                    lstProcessFlow.Add(oFlowDS.ProcessException[0].ProcessFlow_id);
                    lstErrorType.Add(oFlowDS.ProcessException[0].errorType);
                }
                this.processExceptionTableAdapter.Fill(oFlowDS.ProcessException);

                for (int i = 0; i < lstProcessFlow.Count; i++) {
                    if (lstErrorType[i] == "1") {
                        bool isAllOK = true;
                        foreach (DataRow drProcessException in oFlowDS.ProcessException.Rows) {
                            FlowDS.ProcessExceptionRow rowProcessException = (FlowDS.ProcessExceptionRow)drProcessException;
                            if (lstProcessFlow[i] == rowProcessException.ProcessFlow_id) {
                                isAllOK = false;
                                break;
                            }
                        }
                        if (isAllOK) {
                            FlowDS.ProcessFlowDataTable ProcessFlowDT = ProcessFlowTA.GetDataById(lstProcessFlow[i]);
                            ProcessFlowDT[0].isError = false;
                            ProcessFlowTA.Update(ProcessFlowDT);
                        }
                    }
                }
                this.processExceptionTableAdapter.Fill(this.flowDS.ProcessException);
            }
        }

        #endregion

        private void fmMain_FormClosing(object sender, FormClosingEventArgs e) {
            if (MessageBox.Show("您確定要關閉嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.No) {
                e.Cancel = true;
            }
        }

        #region SubWork

        private void SubWorkDefault() {
            dtpDateA.Value = new DateTime(1900, 1, 1);
            dtpDateD.Value = new DateTime(9998, 12, 31);
        }

        private void cbSubNobr_TextChanged(object sender, EventArgs e) {
            tempBaseTA.FillByID(oFlowDS.tempBase, cbSubNobr.Text);

            if (oFlowDS.tempBase.Rows.Count > 0) {
                FlowDS.tempBaseRow r = (FlowDS.tempBaseRow)oFlowDS.tempBase.Rows[0];
                cbSubNobr.Tag = r.id;
                cbSubNobr.SelectedIndex = cbSubNobr.FindString(r.name);
            }
        }

        private void cbSubDept_TextChanged(object sender, EventArgs e) {
            tempDeptTA.FillByID(oFlowDS.tempDept, cbSubDept.Text);

            if (oFlowDS.tempDept.Rows.Count > 0) {
                FlowDS.tempDeptRow r = (FlowDS.tempDeptRow)oFlowDS.tempDept.Rows[0];
                cbSubDept.Tag = r.id;
                cbSubDept.SelectedIndex = cbSubDept.FindString(r.name);
            }
        }

        private void cbSubJob_TextChanged(object sender, EventArgs e) {
            tempPosTA.FillByID(oFlowDS.tempPos, cbSubJob.Text);

            if (oFlowDS.tempPos.Rows.Count > 0) {
                FlowDS.tempPosRow r = (FlowDS.tempPosRow)oFlowDS.tempPos.Rows[0];
                cbSubJob.Tag = r.id;
                cbSubJob.SelectedIndex = cbSubJob.FindString(r.name);
            }
        }

        private void btnSend_Click(object sender, EventArgs e) {
            if (MessageBox.Show("您確定要" + btnSend.Text + "？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                FlowDS.SubWorkRow r;
                if (btnSend.Tag.ToString() == "Add") {
                    SubWorkTA.Fill(oFlowDS.SubWork);
                    r = oFlowDS.SubWork.NewSubWorkRow();
                    r.sNobr = cbSubNobr.SelectedValue.ToString();
                    r.sSubDept = cbSubDept.SelectedValue.ToString();
                    r.sSubJob = cbSubJob.SelectedValue.ToString();
                }
                else {
                    SubWorkTA.FillByAutoKey(oFlowDS.SubWork, int.Parse(lblAutoKey.Text));
                    r = (FlowDS.SubWorkRow)oFlowDS.SubWork.Rows[0];
                    r.sNobr = cbSubNobr.Tag.ToString();
                    r.sSubDept = cbSubDept.Tag.ToString();
                    r.sSubJob = cbSubJob.Tag.ToString();
                }

                r.bSubMang = cbSubMang.Checked;
                r.bReplace = cbReplace.Checked;
                r.dAdate = dtpDateA.Value;
                r.dDdate = dtpDateD.Value;
                r.iFlowAuth = cbFlowAuth.Text.Length > 0 ? Convert.ToInt32(cbFlowAuth.Text) : 1;
                r.sKeyMan = "Jbjob";
                r.dKeyDate = DateTime.Now;

                if (btnSend.Tag.ToString() == "Add") {
                    oFlowDS.SubWork.AddSubWorkRow(r);
                }
                else {
                    btnSend.Text = "新增";
                    btnSend.Tag = "Add";
                    btnCancel.Visible = false;
                }

                SubWorkTA.Update(oFlowDS.SubWork);

                this.subWorkDataTableAdapter.Fill(this.flowDS.SubWorkData);
            }
        }

        private void btnCancel_Click(object sender, EventArgs e) {
            btnSend.Text = "新增";
            btnSend.Tag = "Add";
            btnCancel.Visible = false;
        }

        private void grdSubWork_CellClick(object sender, DataGridViewCellEventArgs e) {
            if (e.RowIndex != -1) {
                btnSend.Text = "修改";
                btnSend.Tag = "Update";
                btnCancel.Visible = true;

                lblAutoKey.Text = grdSubWork.Rows[e.RowIndex].Cells[0].Value.ToString();

                SubWorkDataTA.FillByAutoKey(oFlowDS.SubWorkData, int.Parse(lblAutoKey.Text));
                FlowDS.SubWorkDataRow r = (FlowDS.SubWorkDataRow)oFlowDS.SubWorkData.Rows[0];
                cbSubNobr.Tag = r.sNobr;
                cbSubDept.Tag = r.sSubDept;
                cbSubJob.Tag = r.sSubJob;
                cbSubNobr.SelectedIndex = cbSubNobr.FindString(r.empName);
                cbSubDept.SelectedIndex = cbSubDept.FindString(r.deptName);
                cbSubJob.SelectedIndex = cbSubJob.FindString(r.posName);
                cbSubMang.Checked = r.bSubMang;
                cbReplace.Checked = r.bReplace;
                dtpDateA.Value = r.dAdate;
                dtpDateD.Value = r.dDdate;
                cbFlowAuth.Text = r.iFlowAuth.ToString();
            }
        }

        private void grdSubWork_UserDeletingRow(object sender, DataGridViewRowCancelEventArgs e) {
            if (MessageBox.Show("您確定要刪除嗎？", "訊息提示", MessageBoxButtons.YesNo, MessageBoxIcon.Question) == DialogResult.Yes) {
                lblAutoKey.Text = grdSubWork.Rows[e.Row.Index].Cells[0].Value.ToString();
                SubWorkTA.FillByAutoKey(oFlowDS.SubWork, int.Parse(lblAutoKey.Text));
                FlowDS.SubWorkRow r = (FlowDS.SubWorkRow)oFlowDS.SubWork.Rows[0];
                r.Delete();
                SubWorkTA.Update(oFlowDS.SubWork);

                btnSend.Text = "新增";
                btnSend.Tag = "Add";
                btnCancel.Visible = false;
            }
            else {
                e.Cancel = true;
            }
        }

        private void grdSubWork_UserDeletedRow(object sender, DataGridViewRowEventArgs e) {
            this.subWorkDataTableAdapter.Fill(this.flowDS.SubWorkData);
        }

        #endregion
    }
}