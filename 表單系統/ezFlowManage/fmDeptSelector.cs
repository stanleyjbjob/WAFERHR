using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace ezFlowManage {
    public partial class fmDeptSelector : Form , ezFlowManage.ItreeSelector {
        public string SelectedID;
        public string SelectedName;

        private FlowDSTableAdapters.DeptTableAdapter DeptTA = new ezFlowManage.FlowDSTableAdapters.DeptTableAdapter();
        private FlowDS oFlowDS = new FlowDS();
        private DataRow[] rows;
        private TreeNode tn;

        public fmDeptSelector() {
            InitializeComponent();
        }

        private void fmDeptSelector_Load(object sender, EventArgs e) {
            DeptTA.Fill(oFlowDS.Dept);

            rows = oFlowDS.Dept.Select("idParent = ''");
            foreach (FlowDS.DeptRow r in rows) {
                tn = new TreeNode();
                tn.Text = r.name;
                tn.Tag = r.id;
                tn.ImageIndex = 0;
                tn.SelectedImageIndex = 0;
                tvDept.Nodes.Add(tn);
                CreateDept(r.id, tn);
                tn.Expand();
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
                nodeParent.Nodes.Add(tn);
                CreateDept(r.id, tn);
            }
        }

        private void btnYorN_Click(object sender, EventArgs e) {
            Button btn = ((Button)sender);

            if (tvDept.SelectedNode == null && btn.Tag.ToString() == "Yes") {
                MessageBox.Show("請選取一個部門", "訊息提示", MessageBoxButtons.OK, MessageBoxIcon.Warning);
                return;
            }

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
            get { return ""; }
        }

        #endregion
    }
}