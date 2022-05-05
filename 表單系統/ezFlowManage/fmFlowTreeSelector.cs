using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace ezFlowManage {
    public partial class fmFlowTreeSelector : Form, ezFlowManage.ItreeSelector {
        public string SelectedID;
        public string SelectedName;

        private FlowDSTableAdapters.FlowTreeTableAdapter FlowTreeTA = new ezFlowManage.FlowDSTableAdapters.FlowTreeTableAdapter();
        private FlowDS oFlowDS = new FlowDS();

        public fmFlowTreeSelector() {
            InitializeComponent();
        }

        private void fmFlowTreeSelector_Load(object sender, EventArgs e) {
            FlowTreeTA.Fill(oFlowDS.FlowTree);

            cbxFlowTree.DataSource = oFlowDS.FlowTree;
            cbxFlowTree.DisplayMember = "name";
            cbxFlowTree.ValueMember = "id";
        }

        private void btnYorN_Click(object sender, EventArgs e) {
            Button btn = ((Button)sender);

            SelectedID = cbxFlowTree.SelectedValue.ToString();
            SelectedName = cbxFlowTree.Text;
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