using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace ezFlowManage {
    public partial class fmEmpSelector : Form , ezFlowManage.ItreeSelector {
        public string SelectedID;
        public string SelectedRoleID;
        public string SelectedName;

        private FlowDSTableAdapters.DeptTableAdapter DeptTA = new ezFlowManage.FlowDSTableAdapters.DeptTableAdapter();
        private FlowDSTableAdapters.RoleTableAdapter RoleTA = new ezFlowManage.FlowDSTableAdapters.RoleTableAdapter();
        private FlowDSTableAdapters.EmpTableAdapter EmpTA = new ezFlowManage.FlowDSTableAdapters.EmpTableAdapter();
        private FlowDSTableAdapters.PosTableAdapter PosTA = new ezFlowManage.FlowDSTableAdapters.PosTableAdapter();
        
        private FlowDS oFlowDS = new FlowDS();
        private DataRow[] rows;
        private TreeNode tnDept, tnRole, tnEmp;

        public fmEmpSelector() {
            InitializeComponent();

            DeptTA.Fill(oFlowDS.Dept);
            RoleTA.FillByDate(oFlowDS.Role);    //20071112 by ming v1.1
            EmpTA.Fill(oFlowDS.Emp);
            PosTA.Fill(oFlowDS.Pos);
        }

        private void fmDeptSelector_Load(object sender, EventArgs e) {
            rows = oFlowDS.Dept.Select("idParent = ''");

            foreach (FlowDS.DeptRow r in rows) {
                tnDept = new TreeNode();
                tnDept.Text = r.name;
                tnDept.Tag = r.id;
                tnDept.ImageIndex = 0;
                tnDept.SelectedImageIndex = 0;
                tvDept.Nodes.Add(tnDept);
                CreateRole(r.id, tnDept);
                CreateDept(r.id, tnDept);
                tnDept.Expand();
            }
        }

        //新增子部門
        private void CreateDept(string idParent, TreeNode nodeParent) {
            rows = oFlowDS.Dept.Select("idParent = '" + idParent + "'");

            foreach (FlowDS.DeptRow r in rows) {
                tnDept = new TreeNode();
                tnDept.Text = r.name;
                tnDept.Tag = r.id;
                tnDept.ImageIndex = 0;
                tnDept.SelectedImageIndex = 0;
                nodeParent.Nodes.Add(tnDept);
                CreateRole(r.id, tnDept);
                CreateDept(r.id, tnDept);
            }
        }

        //新增角色
        private void CreateRole(string idParent, TreeNode nodeParent) {
            FlowDS.RoleDataTable RoleDT = RoleTA.DeptMang_GetDataByDeptID(idParent);
            string oldRole = "";

            foreach (FlowDS.RoleRow r in RoleDT.Rows) {
                if (oldRole == r.id) continue;
                else oldRole = r.id;
                tnRole = new TreeNode();
                tnRole.Text = oFlowDS.Pos.FindByid(r.Pos_id).name;
                tnRole.Tag = r.id;
                tnRole.ImageIndex = 1;
                tnRole.SelectedImageIndex = 1;
                nodeParent.Nodes.Add(tnRole);
                CreateEmp(r.id, tnRole);
                CreateSubRole(r.id, r.Dept_id, tnRole);
            }
        }

        //新增副角色
        private void CreateSubRole(string idParent, string Dept_id, TreeNode nodeParent) {
            FlowDS.RoleDataTable RoleDT = RoleTA.GetDataByParent(idParent, Dept_id);
            string oldRole = "";

            foreach (FlowDS.RoleRow r in RoleDT.Rows) {
                if (oldRole == r.id) continue;
                else oldRole = r.id;
                tnRole = new TreeNode();
                tnRole.Text = oFlowDS.Pos.FindByid(r.Pos_id).name;
                tnRole.Tag = r.id;
                tnRole.ImageIndex = 1;
                tnRole.SelectedImageIndex = 1;
                nodeParent.Nodes.Add(tnRole);
                CreateEmp(r.id, tnRole);
                CreateSubRole(r.id, r.Dept_id, tnRole);
            }
        }

        //新增人員
        void CreateEmp(string id, TreeNode nodeParent) {
            rows = oFlowDS.Role.Select("id = '" + id + "'");

            foreach (FlowDS.RoleRow r in rows) {
                if (r.Emp_id.Trim().Length > 0) {
                    tnEmp = new TreeNode();
                    tnEmp.Text = oFlowDS.Emp.FindByid(r.Emp_id).name;
                    //在這裡偷存一些使用者資訊存入物件
                    EmpData oEmpData = new EmpData();
                    oEmpData.idRole = r.id;
                    oEmpData.idEmp = r.Emp_id;
                    //tnEmp.Tag = oEmpData;

                    tnEmp.ToolTipText = r.id;
                    tnEmp.Tag = r.Emp_id;
                    tnEmp.ImageIndex = 2;
                    tnEmp.SelectedImageIndex = 2;
                    nodeParent.Nodes.Add(tnEmp);
                }
            }
        }

        public class EmpData {
            public string idRole;
            public string idEmp;
        }

        private void btnYorN_Click(object sender, EventArgs e) {
            Button btn = ((Button)sender);

            if (tvDept.SelectedNode == null && btn.Tag.ToString() == "Yes") {
                MessageBox.Show("請選取一個角色", "訊息提示", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            if (tvDept.SelectedNode.ImageIndex != 2 && btn.Tag.ToString() == "Yes") {
                MessageBox.Show("您選取的並非成員", "訊息提示", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

            SelectedRoleID = tvDept.SelectedNode.ToolTipText;
            SelectedID = tvDept.SelectedNode.Tag.ToString();
            SelectedName = tvDept.SelectedNode.Text;
            DialogResult = (btn.Tag.ToString() == "Yes") ? DialogResult.OK : DialogResult.Cancel;
            Close();
        }

        #region ItreeSelector 成員

        string ItreeSelector.SelectedID {
            get { return SelectedID; }
        }

        string ItreeSelector.SelectedName {
            get { return SelectedName; }
        }

        string ItreeSelector.SelectedRoleID {
            get { return SelectedRoleID; }
        }

        #endregion
    }
}