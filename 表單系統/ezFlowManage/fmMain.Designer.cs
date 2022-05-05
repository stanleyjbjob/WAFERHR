namespace ezFlowManage {
    partial class fmMain {
        /// <summary>
        /// 設計工具所需的變數。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清除任何使用中的資源。
        /// </summary>
        /// <param name="disposing">如果應該公開 Managed 資源則為 true，否則為 false。</param>
        protected override void Dispose(bool disposing) {
            if (disposing && (components != null)) {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows Form 設計工具產生的程式碼

        /// <summary>
        /// 此為設計工具支援所需的方法 - 請勿使用程式碼編輯器修改這個方法的內容。
        ///
        /// </summary>
        private void InitializeComponent() {
            this.components = new System.ComponentModel.Container();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle3 = new System.Windows.Forms.DataGridViewCellStyle();
            System.Windows.Forms.DataGridViewCellStyle dataGridViewCellStyle4 = new System.Windows.Forms.DataGridViewCellStyle();
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(fmMain));
            this.tcMain = new System.Windows.Forms.TabControl();
            this.tpProcessView = new System.Windows.Forms.TabPage();
            this.groupBox2 = new System.Windows.Forms.GroupBox();
            this.btnAssign = new System.Windows.Forms.Button();
            this.bnDelete = new System.Windows.Forms.Button();
            this.bnContinue = new System.Windows.Forms.Button();
            this.bnCancel = new System.Windows.Forms.Button();
            this.bnFinish = new System.Windows.Forms.Button();
            this.grdProcess = new System.Windows.Forms.DataGridView();
            this.idDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.Emp_name = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.adateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.flowTreenameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.flowNodenameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.empnameCheckDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.isCancelDataGridViewCheckBoxColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.processFlowBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.flowDS = new ezFlowManage.FlowDS();
            this.gbSelectData = new System.Windows.Forms.GroupBox();
            this.lblSelectMsg = new System.Windows.Forms.Label();
            this.ckCancel = new System.Windows.Forms.CheckBox();
            this.label2 = new System.Windows.Forms.Label();
            this.dtEnd = new System.Windows.Forms.DateTimePicker();
            this.ckFlow = new System.Windows.Forms.CheckBox();
            this.ckDept = new System.Windows.Forms.CheckBox();
            this.label1 = new System.Windows.Forms.Label();
            this.ckStarter = new System.Windows.Forms.CheckBox();
            this.ckDate = new System.Windows.Forms.CheckBox();
            this.dtStart = new System.Windows.Forms.DateTimePicker();
            this.tpImportFlow = new System.Windows.Forms.TabPage();
            this.gbImportFlow2 = new System.Windows.Forms.GroupBox();
            this.gbImportFlow1 = new System.Windows.Forms.GroupBox();
            this.lbTime = new System.Windows.Forms.Label();
            this.lbState = new System.Windows.Forms.Label();
            this.label3 = new System.Windows.Forms.Label();
            this.txtDeptP = new System.Windows.Forms.TextBox();
            this.txtDept = new System.Windows.Forms.TextBox();
            this.lbEmpCount = new System.Windows.Forms.Label();
            this.label7 = new System.Windows.Forms.Label();
            this.txtHour = new System.Windows.Forms.TextBox();
            this.label4 = new System.Windows.Forms.Label();
            this.cbAutoImport = new System.Windows.Forms.CheckBox();
            this.btnRest = new System.Windows.Forms.Button();
            this.label10 = new System.Windows.Forms.Label();
            this.lbJobCount = new System.Windows.Forms.Label();
            this.lbDeptCount = new System.Windows.Forms.Label();
            this.label9 = new System.Windows.Forms.Label();
            this.cbRolePnull = new System.Windows.Forms.CheckBox();
            this.label8 = new System.Windows.Forms.Label();
            this.cbRoleP = new System.Windows.Forms.CheckBox();
            this.label5 = new System.Windows.Forms.Label();
            this.cbRoleDel = new System.Windows.Forms.CheckBox();
            this.cbPW = new System.Windows.Forms.CheckBox();
            this.cbDeptP = new System.Windows.Forms.CheckBox();
            this.btnImportA = new System.Windows.Forms.Button();
            this.progressBarA = new System.Windows.Forms.ProgressBar();
            this.cbNobr = new System.Windows.Forms.CheckBox();
            this.lbImportA = new System.Windows.Forms.Label();
            this.btnImportB = new System.Windows.Forms.Button();
            this.cbDeptPP = new System.Windows.Forms.CheckBox();
            this.progressBarB = new System.Windows.Forms.ProgressBar();
            this.lbImportB = new System.Windows.Forms.Label();
            this.cbFullImport = new System.Windows.Forms.CheckBox();
            this.cbDept = new System.Windows.Forms.CheckBox();
            this.cbB = new System.Windows.Forms.CheckBox();
            this.tpDeptView = new System.Windows.Forms.TabPage();
            this.tvDept = new System.Windows.Forms.TreeView();
            this.grdEmp = new System.Windows.Forms.DataGridView();
            this.idDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.pwDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.nameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.posNameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.deptMg = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.empDataBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.tpSubWork = new System.Windows.Forms.TabPage();
            this.gbSub = new System.Windows.Forms.GroupBox();
            this.lblAutoKey = new System.Windows.Forms.Label();
            this.cbFlowAuth = new System.Windows.Forms.ComboBox();
            this.btnCancel = new System.Windows.Forms.Button();
            this.cbSubJob = new System.Windows.Forms.ComboBox();
            this.tempPosBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.cbSubDept = new System.Windows.Forms.ComboBox();
            this.tempDeptBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.btnSend = new System.Windows.Forms.Button();
            this.label15 = new System.Windows.Forms.Label();
            this.cbReplace = new System.Windows.Forms.CheckBox();
            this.dtpDateD = new System.Windows.Forms.DateTimePicker();
            this.label14 = new System.Windows.Forms.Label();
            this.dtpDateA = new System.Windows.Forms.DateTimePicker();
            this.cbSubMang = new System.Windows.Forms.CheckBox();
            this.label13 = new System.Windows.Forms.Label();
            this.label12 = new System.Windows.Forms.Label();
            this.label11 = new System.Windows.Forms.Label();
            this.cbSubNobr = new System.Windows.Forms.ComboBox();
            this.tempBaseBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.label6 = new System.Windows.Forms.Label();
            this.grdSubWork = new System.Windows.Forms.DataGridView();
            this.iAutoKeyDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.sNobrDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.empName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.deptName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.posName = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.bSubMangDataGridViewCheckBoxColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.dAdateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dDdateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.iFlowAuthDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.bReplaceDataGridViewCheckBoxColumn = new System.Windows.Forms.DataGridViewCheckBoxColumn();
            this.sKeyManDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.dKeyDateDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.subWorkDataBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.tpReturnError = new System.Windows.Forms.TabPage();
            this.bnOK = new System.Windows.Forms.Button();
            this.grdException = new System.Windows.Forms.DataGridView();
            this.autoDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.flowTreenameDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.flowNodenameDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.empnameDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.errorTypeDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.errorMsgDataGridViewTextBoxColumn = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.adateDataGridViewTextBoxColumn1 = new System.Windows.Forms.DataGridViewTextBoxColumn();
            this.processExceptionBindingSource = new System.Windows.Forms.BindingSource(this.components);
            this.tpNote = new System.Windows.Forms.TabPage();
            this.txtNote = new System.Windows.Forms.TextBox();
            this.tmImport = new System.Windows.Forms.Timer(this.components);
            this.nfcImport = new System.Windows.Forms.NotifyIcon(this.components);
            this.processFlowTableAdapter = new ezFlowManage.FlowDSTableAdapters.ProcessFlowTableAdapter();
            this.empDataTableAdapter = new ezFlowManage.FlowDSTableAdapters.EmpDataTableAdapter();
            this.processExceptionTableAdapter = new ezFlowManage.FlowDSTableAdapters.ProcessExceptionTableAdapter();
            this.tempBaseTableAdapter = new ezFlowManage.FlowDSTableAdapters.tempBaseTableAdapter();
            this.tempDeptTableAdapter = new ezFlowManage.FlowDSTableAdapters.tempDeptTableAdapter();
            this.tempPosTableAdapter = new ezFlowManage.FlowDSTableAdapters.tempPosTableAdapter();
            this.subWorkDataTableAdapter = new ezFlowManage.FlowDSTableAdapters.SubWorkDataTableAdapter();
            this.tcMain.SuspendLayout();
            this.tpProcessView.SuspendLayout();
            this.groupBox2.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.grdProcess)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.processFlowBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.flowDS)).BeginInit();
            this.gbSelectData.SuspendLayout();
            this.tpImportFlow.SuspendLayout();
            this.gbImportFlow1.SuspendLayout();
            this.tpDeptView.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.grdEmp)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.empDataBindingSource)).BeginInit();
            this.tpSubWork.SuspendLayout();
            this.gbSub.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tempPosBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tempDeptBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.tempBaseBindingSource)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.grdSubWork)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.subWorkDataBindingSource)).BeginInit();
            this.tpReturnError.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.grdException)).BeginInit();
            ((System.ComponentModel.ISupportInitialize)(this.processExceptionBindingSource)).BeginInit();
            this.tpNote.SuspendLayout();
            this.SuspendLayout();
            // 
            // tcMain
            // 
            this.tcMain.Controls.Add(this.tpProcessView);
            this.tcMain.Controls.Add(this.tpImportFlow);
            this.tcMain.Controls.Add(this.tpDeptView);
            this.tcMain.Controls.Add(this.tpSubWork);
            this.tcMain.Controls.Add(this.tpReturnError);
            this.tcMain.Controls.Add(this.tpNote);
            this.tcMain.Location = new System.Drawing.Point(12, 12);
            this.tcMain.Name = "tcMain";
            this.tcMain.SelectedIndex = 0;
            this.tcMain.Size = new System.Drawing.Size(718, 499);
            this.tcMain.TabIndex = 0;
            // 
            // tpProcessView
            // 
            this.tpProcessView.Controls.Add(this.groupBox2);
            this.tpProcessView.Controls.Add(this.grdProcess);
            this.tpProcessView.Controls.Add(this.gbSelectData);
            this.tpProcessView.Location = new System.Drawing.Point(4, 21);
            this.tpProcessView.Name = "tpProcessView";
            this.tpProcessView.Padding = new System.Windows.Forms.Padding(3);
            this.tpProcessView.Size = new System.Drawing.Size(710, 474);
            this.tpProcessView.TabIndex = 0;
            this.tpProcessView.Text = "流程監控";
            this.tpProcessView.UseVisualStyleBackColor = true;
            // 
            // groupBox2
            // 
            this.groupBox2.Controls.Add(this.btnAssign);
            this.groupBox2.Controls.Add(this.bnDelete);
            this.groupBox2.Controls.Add(this.bnContinue);
            this.groupBox2.Controls.Add(this.bnCancel);
            this.groupBox2.Controls.Add(this.bnFinish);
            this.groupBox2.Location = new System.Drawing.Point(6, 408);
            this.groupBox2.Name = "groupBox2";
            this.groupBox2.Size = new System.Drawing.Size(698, 60);
            this.groupBox2.TabIndex = 17;
            this.groupBox2.TabStop = false;
            this.groupBox2.Text = "管理決策(選取流程的動作)";
            // 
            // btnAssign
            // 
            this.btnAssign.Font = new System.Drawing.Font("新細明體", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.btnAssign.ForeColor = System.Drawing.Color.Maroon;
            this.btnAssign.Location = new System.Drawing.Point(290, 21);
            this.btnAssign.Name = "btnAssign";
            this.btnAssign.Size = new System.Drawing.Size(65, 23);
            this.btnAssign.TabIndex = 6;
            this.btnAssign.Text = "指向某人";
            this.btnAssign.UseVisualStyleBackColor = true;
            this.btnAssign.Click += new System.EventHandler(this.btnAssign_Click);
            // 
            // bnDelete
            // 
            this.bnDelete.Enabled = false;
            this.bnDelete.Font = new System.Drawing.Font("新細明體", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.bnDelete.ForeColor = System.Drawing.Color.Red;
            this.bnDelete.Location = new System.Drawing.Point(219, 21);
            this.bnDelete.Name = "bnDelete";
            this.bnDelete.Size = new System.Drawing.Size(65, 23);
            this.bnDelete.TabIndex = 4;
            this.bnDelete.Text = "刪除";
            this.bnDelete.UseVisualStyleBackColor = true;
            this.bnDelete.Click += new System.EventHandler(this.bnDelete_Click);
            // 
            // bnContinue
            // 
            this.bnContinue.Font = new System.Drawing.Font("新細明體", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.bnContinue.ForeColor = System.Drawing.Color.Green;
            this.bnContinue.Location = new System.Drawing.Point(77, 21);
            this.bnContinue.Name = "bnContinue";
            this.bnContinue.Size = new System.Drawing.Size(65, 23);
            this.bnContinue.TabIndex = 3;
            this.bnContinue.Text = "恢復運作";
            this.bnContinue.UseVisualStyleBackColor = true;
            this.bnContinue.Click += new System.EventHandler(this.bnCancel_Click);
            // 
            // bnCancel
            // 
            this.bnCancel.Font = new System.Drawing.Font("新細明體", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.bnCancel.ForeColor = System.Drawing.Color.Black;
            this.bnCancel.Location = new System.Drawing.Point(6, 21);
            this.bnCancel.Name = "bnCancel";
            this.bnCancel.Size = new System.Drawing.Size(65, 23);
            this.bnCancel.TabIndex = 2;
            this.bnCancel.Tag = "";
            this.bnCancel.Text = "中止運作";
            this.bnCancel.UseVisualStyleBackColor = true;
            this.bnCancel.Click += new System.EventHandler(this.bnCancel_Click);
            // 
            // bnFinish
            // 
            this.bnFinish.Font = new System.Drawing.Font("新細明體", 9F, System.Drawing.FontStyle.Bold, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            this.bnFinish.ForeColor = System.Drawing.Color.Blue;
            this.bnFinish.Location = new System.Drawing.Point(148, 21);
            this.bnFinish.Name = "bnFinish";
            this.bnFinish.Size = new System.Drawing.Size(65, 23);
            this.bnFinish.TabIndex = 0;
            this.bnFinish.Text = "徹回";
            this.bnFinish.UseVisualStyleBackColor = true;
            this.bnFinish.Click += new System.EventHandler(this.bnCancel_Click);
            // 
            // grdProcess
            // 
            this.grdProcess.AllowUserToAddRows = false;
            this.grdProcess.AllowUserToDeleteRows = false;
            this.grdProcess.AutoGenerateColumns = false;
            this.grdProcess.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            dataGridViewCellStyle3.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle3.Font = new System.Drawing.Font("新細明體", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            dataGridViewCellStyle3.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle3.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle3.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle3.WrapMode = System.Windows.Forms.DataGridViewTriState.True;
            this.grdProcess.ColumnHeadersDefaultCellStyle = dataGridViewCellStyle3;
            this.grdProcess.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.grdProcess.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn,
            this.Emp_name,
            this.adateDataGridViewTextBoxColumn,
            this.flowTreenameDataGridViewTextBoxColumn,
            this.flowNodenameDataGridViewTextBoxColumn,
            this.empnameCheckDataGridViewTextBoxColumn,
            this.isCancelDataGridViewCheckBoxColumn});
            this.grdProcess.DataSource = this.processFlowBindingSource;
            this.grdProcess.Location = new System.Drawing.Point(6, 71);
            this.grdProcess.Name = "grdProcess";
            this.grdProcess.ReadOnly = true;
            dataGridViewCellStyle4.BackColor = System.Drawing.SystemColors.Control;
            dataGridViewCellStyle4.Font = new System.Drawing.Font("新細明體", 9F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
            dataGridViewCellStyle4.ForeColor = System.Drawing.SystemColors.WindowText;
            dataGridViewCellStyle4.SelectionBackColor = System.Drawing.SystemColors.Highlight;
            dataGridViewCellStyle4.SelectionForeColor = System.Drawing.SystemColors.HighlightText;
            dataGridViewCellStyle4.WrapMode = System.Windows.Forms.DataGridViewTriState.False;
            this.grdProcess.RowHeadersDefaultCellStyle = dataGridViewCellStyle4;
            this.grdProcess.RowTemplate.Height = 24;
            this.grdProcess.SelectionMode = System.Windows.Forms.DataGridViewSelectionMode.FullRowSelect;
            this.grdProcess.Size = new System.Drawing.Size(698, 331);
            this.grdProcess.TabIndex = 16;
            // 
            // idDataGridViewTextBoxColumn
            // 
            this.idDataGridViewTextBoxColumn.DataPropertyName = "id";
            this.idDataGridViewTextBoxColumn.HeaderText = "流程序號";
            this.idDataGridViewTextBoxColumn.Name = "idDataGridViewTextBoxColumn";
            this.idDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // Emp_name
            // 
            this.Emp_name.DataPropertyName = "Emp_name";
            this.Emp_name.HeaderText = "申請者";
            this.Emp_name.Name = "Emp_name";
            this.Emp_name.ReadOnly = true;
            // 
            // adateDataGridViewTextBoxColumn
            // 
            this.adateDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.adateDataGridViewTextBoxColumn.DataPropertyName = "adate";
            this.adateDataGridViewTextBoxColumn.HeaderText = "申請日期";
            this.adateDataGridViewTextBoxColumn.Name = "adateDataGridViewTextBoxColumn";
            this.adateDataGridViewTextBoxColumn.ReadOnly = true;
            this.adateDataGridViewTextBoxColumn.Width = 78;
            // 
            // flowTreenameDataGridViewTextBoxColumn
            // 
            this.flowTreenameDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.flowTreenameDataGridViewTextBoxColumn.DataPropertyName = "FlowTree_name";
            this.flowTreenameDataGridViewTextBoxColumn.HeaderText = "流程名稱";
            this.flowTreenameDataGridViewTextBoxColumn.Name = "flowTreenameDataGridViewTextBoxColumn";
            this.flowTreenameDataGridViewTextBoxColumn.ReadOnly = true;
            this.flowTreenameDataGridViewTextBoxColumn.Width = 78;
            // 
            // flowNodenameDataGridViewTextBoxColumn
            // 
            this.flowNodenameDataGridViewTextBoxColumn.DataPropertyName = "FlowNode_name";
            this.flowNodenameDataGridViewTextBoxColumn.HeaderText = "處理進度";
            this.flowNodenameDataGridViewTextBoxColumn.Name = "flowNodenameDataGridViewTextBoxColumn";
            this.flowNodenameDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // empnameCheckDataGridViewTextBoxColumn
            // 
            this.empnameCheckDataGridViewTextBoxColumn.DataPropertyName = "Emp_nameCheck";
            this.empnameCheckDataGridViewTextBoxColumn.HeaderText = "處理者";
            this.empnameCheckDataGridViewTextBoxColumn.Name = "empnameCheckDataGridViewTextBoxColumn";
            this.empnameCheckDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // isCancelDataGridViewCheckBoxColumn
            // 
            this.isCancelDataGridViewCheckBoxColumn.DataPropertyName = "isCancel";
            this.isCancelDataGridViewCheckBoxColumn.HeaderText = "中止";
            this.isCancelDataGridViewCheckBoxColumn.Name = "isCancelDataGridViewCheckBoxColumn";
            this.isCancelDataGridViewCheckBoxColumn.ReadOnly = true;
            // 
            // processFlowBindingSource
            // 
            this.processFlowBindingSource.DataMember = "ProcessFlow";
            this.processFlowBindingSource.DataSource = this.flowDS;
            // 
            // flowDS
            // 
            this.flowDS.DataSetName = "FlowDS";
            this.flowDS.SchemaSerializationMode = System.Data.SchemaSerializationMode.IncludeSchema;
            // 
            // gbSelectData
            // 
            this.gbSelectData.Controls.Add(this.lblSelectMsg);
            this.gbSelectData.Controls.Add(this.ckCancel);
            this.gbSelectData.Controls.Add(this.label2);
            this.gbSelectData.Controls.Add(this.dtEnd);
            this.gbSelectData.Controls.Add(this.ckFlow);
            this.gbSelectData.Controls.Add(this.ckDept);
            this.gbSelectData.Controls.Add(this.label1);
            this.gbSelectData.Controls.Add(this.ckStarter);
            this.gbSelectData.Controls.Add(this.ckDate);
            this.gbSelectData.Controls.Add(this.dtStart);
            this.gbSelectData.Location = new System.Drawing.Point(6, 6);
            this.gbSelectData.Name = "gbSelectData";
            this.gbSelectData.Size = new System.Drawing.Size(698, 59);
            this.gbSelectData.TabIndex = 1;
            this.gbSelectData.TabStop = false;
            this.gbSelectData.Text = "資料篩選";
            // 
            // lblSelectMsg
            // 
            this.lblSelectMsg.AutoSize = true;
            this.lblSelectMsg.ForeColor = System.Drawing.Color.Red;
            this.lblSelectMsg.Location = new System.Drawing.Point(75, 40);
            this.lblSelectMsg.Name = "lblSelectMsg";
            this.lblSelectMsg.Size = new System.Drawing.Size(113, 12);
            this.lblSelectMsg.TabIndex = 14;
            this.lblSelectMsg.Text = "目前無任何篩選條件";
            // 
            // ckCancel
            // 
            this.ckCancel.AutoSize = true;
            this.ckCancel.Location = new System.Drawing.Point(6, 21);
            this.ckCancel.Name = "ckCancel";
            this.ckCancel.Size = new System.Drawing.Size(120, 16);
            this.ckCancel.TabIndex = 13;
            this.ckCancel.Text = "只篩選中止的流程";
            this.ckCancel.UseVisualStyleBackColor = true;
            this.ckCancel.CheckedChanged += new System.EventHandler(this.CheckedChanged);
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(4, 40);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 12);
            this.label2.TabIndex = 15;
            this.label2.Text = "篩選條件：";
            // 
            // dtEnd
            // 
            this.dtEnd.CustomFormat = "yyyy/MM/dd";
            this.dtEnd.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtEnd.Location = new System.Drawing.Point(575, 18);
            this.dtEnd.Name = "dtEnd";
            this.dtEnd.Size = new System.Drawing.Size(79, 22);
            this.dtEnd.TabIndex = 11;
            this.dtEnd.ValueChanged += new System.EventHandler(this.CheckedChanged);
            // 
            // ckFlow
            // 
            this.ckFlow.AccessibleDescription = "";
            this.ckFlow.AccessibleName = "";
            this.ckFlow.AutoSize = true;
            this.ckFlow.Location = new System.Drawing.Point(132, 21);
            this.ckFlow.Name = "ckFlow";
            this.ckFlow.Size = new System.Drawing.Size(72, 16);
            this.ckFlow.TabIndex = 0;
            this.ckFlow.Text = "表單篩選";
            this.ckFlow.UseVisualStyleBackColor = true;
            this.ckFlow.CheckedChanged += new System.EventHandler(this.ck_CheckedChanged);
            // 
            // ckDept
            // 
            this.ckDept.AutoSize = true;
            this.ckDept.Location = new System.Drawing.Point(219, 21);
            this.ckDept.Name = "ckDept";
            this.ckDept.Size = new System.Drawing.Size(72, 16);
            this.ckDept.TabIndex = 2;
            this.ckDept.Text = "部門篩選";
            this.ckDept.UseVisualStyleBackColor = true;
            this.ckDept.Click += new System.EventHandler(this.ck_CheckedChanged);
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(547, 23);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(17, 12);
            this.label1.TabIndex = 10;
            this.label1.Text = "至";
            // 
            // ckStarter
            // 
            this.ckStarter.AutoSize = true;
            this.ckStarter.Location = new System.Drawing.Point(288, 21);
            this.ckStarter.Name = "ckStarter";
            this.ckStarter.Size = new System.Drawing.Size(84, 16);
            this.ckStarter.TabIndex = 5;
            this.ckStarter.Text = "申請者篩選";
            this.ckStarter.UseVisualStyleBackColor = true;
            this.ckStarter.Click += new System.EventHandler(this.ck_CheckedChanged);
            // 
            // ckDate
            // 
            this.ckDate.AutoSize = true;
            this.ckDate.Location = new System.Drawing.Point(378, 21);
            this.ckDate.Name = "ckDate";
            this.ckDate.Size = new System.Drawing.Size(72, 16);
            this.ckDate.TabIndex = 8;
            this.ckDate.Text = "日期篩選";
            this.ckDate.UseVisualStyleBackColor = true;
            this.ckDate.CheckedChanged += new System.EventHandler(this.CheckedChanged);
            // 
            // dtStart
            // 
            this.dtStart.CustomFormat = "yyyy/MM/dd";
            this.dtStart.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtStart.Location = new System.Drawing.Point(457, 18);
            this.dtStart.Name = "dtStart";
            this.dtStart.Size = new System.Drawing.Size(79, 22);
            this.dtStart.TabIndex = 9;
            this.dtStart.ValueChanged += new System.EventHandler(this.CheckedChanged);
            // 
            // tpImportFlow
            // 
            this.tpImportFlow.Controls.Add(this.gbImportFlow2);
            this.tpImportFlow.Controls.Add(this.gbImportFlow1);
            this.tpImportFlow.Location = new System.Drawing.Point(4, 21);
            this.tpImportFlow.Name = "tpImportFlow";
            this.tpImportFlow.Padding = new System.Windows.Forms.Padding(3);
            this.tpImportFlow.Size = new System.Drawing.Size(710, 474);
            this.tpImportFlow.TabIndex = 1;
            this.tpImportFlow.Text = "組織匯入";
            this.tpImportFlow.UseVisualStyleBackColor = true;
            // 
            // gbImportFlow2
            // 
            this.gbImportFlow2.Location = new System.Drawing.Point(358, 6);
            this.gbImportFlow2.Name = "gbImportFlow2";
            this.gbImportFlow2.Size = new System.Drawing.Size(346, 462);
            this.gbImportFlow2.TabIndex = 1;
            this.gbImportFlow2.TabStop = false;
            this.gbImportFlow2.Text = "HR>>>Flow";
            // 
            // gbImportFlow1
            // 
            this.gbImportFlow1.Controls.Add(this.lbTime);
            this.gbImportFlow1.Controls.Add(this.lbState);
            this.gbImportFlow1.Controls.Add(this.label3);
            this.gbImportFlow1.Controls.Add(this.txtDeptP);
            this.gbImportFlow1.Controls.Add(this.txtDept);
            this.gbImportFlow1.Controls.Add(this.lbEmpCount);
            this.gbImportFlow1.Controls.Add(this.label7);
            this.gbImportFlow1.Controls.Add(this.txtHour);
            this.gbImportFlow1.Controls.Add(this.label4);
            this.gbImportFlow1.Controls.Add(this.cbAutoImport);
            this.gbImportFlow1.Controls.Add(this.btnRest);
            this.gbImportFlow1.Controls.Add(this.label10);
            this.gbImportFlow1.Controls.Add(this.lbJobCount);
            this.gbImportFlow1.Controls.Add(this.lbDeptCount);
            this.gbImportFlow1.Controls.Add(this.label9);
            this.gbImportFlow1.Controls.Add(this.cbRolePnull);
            this.gbImportFlow1.Controls.Add(this.label8);
            this.gbImportFlow1.Controls.Add(this.cbRoleP);
            this.gbImportFlow1.Controls.Add(this.label5);
            this.gbImportFlow1.Controls.Add(this.cbRoleDel);
            this.gbImportFlow1.Controls.Add(this.cbPW);
            this.gbImportFlow1.Controls.Add(this.cbDeptP);
            this.gbImportFlow1.Controls.Add(this.btnImportA);
            this.gbImportFlow1.Controls.Add(this.progressBarA);
            this.gbImportFlow1.Controls.Add(this.cbNobr);
            this.gbImportFlow1.Controls.Add(this.lbImportA);
            this.gbImportFlow1.Controls.Add(this.btnImportB);
            this.gbImportFlow1.Controls.Add(this.cbDeptPP);
            this.gbImportFlow1.Controls.Add(this.progressBarB);
            this.gbImportFlow1.Controls.Add(this.lbImportB);
            this.gbImportFlow1.Controls.Add(this.cbFullImport);
            this.gbImportFlow1.Controls.Add(this.cbDept);
            this.gbImportFlow1.Controls.Add(this.cbB);
            this.gbImportFlow1.Location = new System.Drawing.Point(6, 6);
            this.gbImportFlow1.Name = "gbImportFlow1";
            this.gbImportFlow1.Size = new System.Drawing.Size(346, 462);
            this.gbImportFlow1.TabIndex = 0;
            this.gbImportFlow1.TabStop = false;
            this.gbImportFlow1.Text = "HR>>>Temp>>>Flow";
            // 
            // lbTime
            // 
            this.lbTime.AutoSize = true;
            this.lbTime.Location = new System.Drawing.Point(101, 433);
            this.lbTime.Name = "lbTime";
            this.lbTime.Size = new System.Drawing.Size(11, 12);
            this.lbTime.TabIndex = 62;
            this.lbTime.Text = "0";
            // 
            // lbState
            // 
            this.lbState.AutoSize = true;
            this.lbState.Location = new System.Drawing.Point(77, 421);
            this.lbState.Name = "lbState";
            this.lbState.Size = new System.Drawing.Size(77, 12);
            this.lbState.TabIndex = 75;
            this.lbState.Text = "自動執行打開";
            // 
            // label3
            // 
            this.label3.AutoSize = true;
            this.label3.Location = new System.Drawing.Point(6, 433);
            this.label3.Name = "label3";
            this.label3.Size = new System.Drawing.Size(89, 12);
            this.label3.TabIndex = 61;
            this.label3.Text = "最後執行時間：";
            // 
            // txtDeptP
            // 
            this.txtDeptP.Location = new System.Drawing.Point(241, 103);
            this.txtDeptP.Name = "txtDeptP";
            this.txtDeptP.Size = new System.Drawing.Size(99, 22);
            this.txtDeptP.TabIndex = 71;
            // 
            // txtDept
            // 
            this.txtDept.Location = new System.Drawing.Point(149, 81);
            this.txtDept.Name = "txtDept";
            this.txtDept.Size = new System.Drawing.Size(99, 22);
            this.txtDept.TabIndex = 67;
            // 
            // lbEmpCount
            // 
            this.lbEmpCount.AutoSize = true;
            this.lbEmpCount.Location = new System.Drawing.Point(77, 30);
            this.lbEmpCount.Name = "lbEmpCount";
            this.lbEmpCount.Size = new System.Drawing.Size(11, 12);
            this.lbEmpCount.TabIndex = 46;
            this.lbEmpCount.Text = "0";
            // 
            // label7
            // 
            this.label7.AutoSize = true;
            this.label7.Location = new System.Drawing.Point(6, 421);
            this.label7.Name = "label7";
            this.label7.Size = new System.Drawing.Size(65, 12);
            this.label7.TabIndex = 74;
            this.label7.Text = "目前狀態：";
            // 
            // txtHour
            // 
            this.txtHour.Location = new System.Drawing.Point(141, 393);
            this.txtHour.MaxLength = 2;
            this.txtHour.Name = "txtHour";
            this.txtHour.Size = new System.Drawing.Size(18, 22);
            this.txtHour.TabIndex = 60;
            this.txtHour.Text = "1";
            // 
            // label4
            // 
            this.label4.AutoSize = true;
            this.label4.Location = new System.Drawing.Point(6, 86);
            this.label4.Name = "label4";
            this.label4.Size = new System.Drawing.Size(145, 12);
            this.label4.TabIndex = 66;
            this.label4.Text = "起始根(最上層)部門代碼：";
            // 
            // cbAutoImport
            // 
            this.cbAutoImport.AutoSize = true;
            this.cbAutoImport.Checked = true;
            this.cbAutoImport.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbAutoImport.Location = new System.Drawing.Point(8, 402);
            this.cbAutoImport.Name = "cbAutoImport";
            this.cbAutoImport.Size = new System.Drawing.Size(168, 16);
            this.cbAutoImport.TabIndex = 53;
            this.cbAutoImport.Text = "自動執行匯入於每天　　點";
            this.cbAutoImport.UseVisualStyleBackColor = true;
            this.cbAutoImport.Click += new System.EventHandler(this.cbAutoImport_CheckedChanged);
            // 
            // btnRest
            // 
            this.btnRest.Location = new System.Drawing.Point(278, 13);
            this.btnRest.Name = "btnRest";
            this.btnRest.Size = new System.Drawing.Size(62, 23);
            this.btnRest.TabIndex = 64;
            this.btnRest.Text = "重新整理";
            this.btnRest.UseVisualStyleBackColor = true;
            this.btnRest.Click += new System.EventHandler(this.btnRest_Click);
            // 
            // label10
            // 
            this.label10.AutoSize = true;
            this.label10.Location = new System.Drawing.Point(6, 30);
            this.label10.Name = "label10";
            this.label10.Size = new System.Drawing.Size(65, 12);
            this.label10.TabIndex = 79;
            this.label10.Text = "應轉／目前";
            // 
            // lbJobCount
            // 
            this.lbJobCount.AutoSize = true;
            this.lbJobCount.Location = new System.Drawing.Point(219, 30);
            this.lbJobCount.Name = "lbJobCount";
            this.lbJobCount.Size = new System.Drawing.Size(11, 12);
            this.lbJobCount.TabIndex = 50;
            this.lbJobCount.Text = "0";
            // 
            // lbDeptCount
            // 
            this.lbDeptCount.AutoSize = true;
            this.lbDeptCount.Location = new System.Drawing.Point(148, 30);
            this.lbDeptCount.Name = "lbDeptCount";
            this.lbDeptCount.Size = new System.Drawing.Size(11, 12);
            this.lbDeptCount.TabIndex = 48;
            this.lbDeptCount.Text = "0";
            // 
            // label9
            // 
            this.label9.AutoSize = true;
            this.label9.Location = new System.Drawing.Point(77, 18);
            this.label9.Name = "label9";
            this.label9.Size = new System.Drawing.Size(65, 12);
            this.label9.TabIndex = 45;
            this.label9.Text = "人員數量｜";
            // 
            // cbRolePnull
            // 
            this.cbRolePnull.AutoSize = true;
            this.cbRolePnull.Location = new System.Drawing.Point(8, 311);
            this.cbRolePnull.Name = "cbRolePnull";
            this.cbRolePnull.Size = new System.Drawing.Size(224, 16);
            this.cbRolePnull.TabIndex = 78;
            this.cbRolePnull.Text = "上層角色全為空白(按照部門進行簽核)";
            this.cbRolePnull.UseVisualStyleBackColor = true;
            // 
            // label8
            // 
            this.label8.AutoSize = true;
            this.label8.Location = new System.Drawing.Point(148, 18);
            this.label8.Name = "label8";
            this.label8.Size = new System.Drawing.Size(65, 12);
            this.label8.TabIndex = 47;
            this.label8.Text = "部門數量｜";
            // 
            // cbRoleP
            // 
            this.cbRoleP.AutoSize = true;
            this.cbRoleP.Checked = true;
            this.cbRoleP.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbRoleP.Enabled = false;
            this.cbRoleP.Location = new System.Drawing.Point(8, 267);
            this.cbRoleP.Name = "cbRoleP";
            this.cbRoleP.Size = new System.Drawing.Size(228, 16);
            this.cbRoleP.TabIndex = 76;
            this.cbRoleP.Text = "角色與上層角色相同時上層角色為空白";
            this.cbRoleP.UseVisualStyleBackColor = true;
            // 
            // label5
            // 
            this.label5.AutoSize = true;
            this.label5.Location = new System.Drawing.Point(219, 18);
            this.label5.Name = "label5";
            this.label5.Size = new System.Drawing.Size(53, 12);
            this.label5.TabIndex = 49;
            this.label5.Text = "職稱數量";
            // 
            // cbRoleDel
            // 
            this.cbRoleDel.AutoSize = true;
            this.cbRoleDel.Checked = true;
            this.cbRoleDel.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbRoleDel.Location = new System.Drawing.Point(8, 289);
            this.cbRoleDel.Name = "cbRoleDel";
            this.cbRoleDel.Size = new System.Drawing.Size(144, 16);
            this.cbRoleDel.TabIndex = 73;
            this.cbRoleDel.Text = "直接刪除角色重新匯入";
            this.cbRoleDel.UseVisualStyleBackColor = true;
            // 
            // cbPW
            // 
            this.cbPW.AutoSize = true;
            this.cbPW.Location = new System.Drawing.Point(8, 45);
            this.cbPW.Name = "cbPW";
            this.cbPW.Size = new System.Drawing.Size(211, 16);
            this.cbPW.TabIndex = 51;
            this.cbPW.Text = "覆蓋Flow使用者登入密碼(密碼同步)";
            this.cbPW.UseVisualStyleBackColor = true;
            // 
            // cbDeptP
            // 
            this.cbDeptP.AutoSize = true;
            this.cbDeptP.Checked = true;
            this.cbDeptP.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbDeptP.Location = new System.Drawing.Point(8, 109);
            this.cbDeptP.Name = "cbDeptP";
            this.cbDeptP.Size = new System.Drawing.Size(240, 16);
            this.cbDeptP.TabIndex = 68;
            this.cbDeptP.Text = "當部門與上層部門相同時上層部門改為：";
            this.cbDeptP.UseVisualStyleBackColor = true;
            // 
            // btnImportA
            // 
            this.btnImportA.Location = new System.Drawing.Point(8, 175);
            this.btnImportA.Name = "btnImportA";
            this.btnImportA.Size = new System.Drawing.Size(332, 23);
            this.btnImportA.TabIndex = 52;
            this.btnImportA.Text = "匯入員工基本資料、部門、職稱";
            this.btnImportA.UseVisualStyleBackColor = true;
            this.btnImportA.Click += new System.EventHandler(this.btnImportA_Click);
            // 
            // progressBarA
            // 
            this.progressBarA.AccessibleName = "";
            this.progressBarA.Location = new System.Drawing.Point(8, 204);
            this.progressBarA.Name = "progressBarA";
            this.progressBarA.Size = new System.Drawing.Size(332, 23);
            this.progressBarA.TabIndex = 54;
            // 
            // cbNobr
            // 
            this.cbNobr.AutoSize = true;
            this.cbNobr.Checked = true;
            this.cbNobr.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbNobr.Location = new System.Drawing.Point(190, 67);
            this.cbNobr.Name = "cbNobr";
            this.cbNobr.Size = new System.Drawing.Size(120, 16);
            this.cbNobr.TabIndex = 65;
            this.cbNobr.Text = "匯入帳號等於工號";
            this.cbNobr.UseVisualStyleBackColor = true;
            // 
            // lbImportA
            // 
            this.lbImportA.AutoSize = true;
            this.lbImportA.Location = new System.Drawing.Point(6, 230);
            this.lbImportA.Name = "lbImportA";
            this.lbImportA.Size = new System.Drawing.Size(29, 12);
            this.lbImportA.TabIndex = 55;
            this.lbImportA.Text = "匯入";
            // 
            // btnImportB
            // 
            this.btnImportB.Location = new System.Drawing.Point(8, 333);
            this.btnImportB.Name = "btnImportB";
            this.btnImportB.Size = new System.Drawing.Size(332, 23);
            this.btnImportB.TabIndex = 56;
            this.btnImportB.Text = "建立角色代碼及從屬關係";
            this.btnImportB.UseVisualStyleBackColor = true;
            this.btnImportB.Click += new System.EventHandler(this.btnImportB_Click);
            // 
            // cbDeptPP
            // 
            this.cbDeptPP.AutoSize = true;
            this.cbDeptPP.Checked = true;
            this.cbDeptPP.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbDeptPP.Location = new System.Drawing.Point(8, 153);
            this.cbDeptPP.Name = "cbDeptPP";
            this.cbDeptPP.Size = new System.Drawing.Size(228, 16);
            this.cbDeptPP.TabIndex = 72;
            this.cbDeptPP.Text = "找不到上層部門時就當該部門為根部門";
            this.cbDeptPP.UseVisualStyleBackColor = true;
            // 
            // progressBarB
            // 
            this.progressBarB.AccessibleName = "";
            this.progressBarB.Location = new System.Drawing.Point(8, 362);
            this.progressBarB.Name = "progressBarB";
            this.progressBarB.Size = new System.Drawing.Size(332, 23);
            this.progressBarB.TabIndex = 57;
            // 
            // lbImportB
            // 
            this.lbImportB.AutoSize = true;
            this.lbImportB.Location = new System.Drawing.Point(6, 388);
            this.lbImportB.Name = "lbImportB";
            this.lbImportB.Size = new System.Drawing.Size(29, 12);
            this.lbImportB.TabIndex = 58;
            this.lbImportB.Text = "匯入";
            // 
            // cbFullImport
            // 
            this.cbFullImport.AutoSize = true;
            this.cbFullImport.Checked = true;
            this.cbFullImport.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbFullImport.Location = new System.Drawing.Point(8, 67);
            this.cbFullImport.Name = "cbFullImport";
            this.cbFullImport.Size = new System.Drawing.Size(176, 16);
            this.cbFullImport.TabIndex = 59;
            this.cbFullImport.Text = "完整匯入(會先刪除原始資料)";
            this.cbFullImport.UseVisualStyleBackColor = true;
            // 
            // cbDept
            // 
            this.cbDept.AutoSize = true;
            this.cbDept.Checked = true;
            this.cbDept.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbDept.Location = new System.Drawing.Point(8, 131);
            this.cbDept.Name = "cbDept";
            this.cbDept.Size = new System.Drawing.Size(228, 16);
            this.cbDept.TabIndex = 69;
            this.cbDept.Text = "當部門與上層部門相同時該筆允許匯入";
            this.cbDept.UseVisualStyleBackColor = true;
            // 
            // cbB
            // 
            this.cbB.AutoSize = true;
            this.cbB.Checked = true;
            this.cbB.CheckState = System.Windows.Forms.CheckState.Checked;
            this.cbB.Location = new System.Drawing.Point(8, 245);
            this.cbB.Name = "cbB";
            this.cbB.Size = new System.Drawing.Size(252, 16);
            this.cbB.TabIndex = 63;
            this.cbB.Text = "完成上步驟後連動建立角色代碼及從屬關係";
            this.cbB.UseVisualStyleBackColor = true;
            // 
            // tpDeptView
            // 
            this.tpDeptView.Controls.Add(this.tvDept);
            this.tpDeptView.Controls.Add(this.grdEmp);
            this.tpDeptView.Location = new System.Drawing.Point(4, 21);
            this.tpDeptView.Name = "tpDeptView";
            this.tpDeptView.Size = new System.Drawing.Size(710, 474);
            this.tpDeptView.TabIndex = 2;
            this.tpDeptView.Text = "部門檢視";
            this.tpDeptView.UseVisualStyleBackColor = true;
            // 
            // tvDept
            // 
            this.tvDept.Location = new System.Drawing.Point(3, 3);
            this.tvDept.Name = "tvDept";
            this.tvDept.Size = new System.Drawing.Size(268, 468);
            this.tvDept.TabIndex = 4;
            this.tvDept.DoubleClick += new System.EventHandler(this.tvDept_DoubleClick);
            this.tvDept.Click += new System.EventHandler(this.tvDept_Click);
            // 
            // grdEmp
            // 
            this.grdEmp.AllowUserToAddRows = false;
            this.grdEmp.AllowUserToDeleteRows = false;
            this.grdEmp.AutoGenerateColumns = false;
            this.grdEmp.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.grdEmp.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.grdEmp.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.idDataGridViewTextBoxColumn1,
            this.pwDataGridViewTextBoxColumn,
            this.nameDataGridViewTextBoxColumn,
            this.posNameDataGridViewTextBoxColumn,
            this.deptMg});
            this.grdEmp.DataSource = this.empDataBindingSource;
            this.grdEmp.Location = new System.Drawing.Point(277, 3);
            this.grdEmp.Name = "grdEmp";
            this.grdEmp.ReadOnly = true;
            this.grdEmp.RowTemplate.Height = 24;
            this.grdEmp.Size = new System.Drawing.Size(430, 468);
            this.grdEmp.TabIndex = 1;
            // 
            // idDataGridViewTextBoxColumn1
            // 
            this.idDataGridViewTextBoxColumn1.DataPropertyName = "id";
            this.idDataGridViewTextBoxColumn1.HeaderText = "工號";
            this.idDataGridViewTextBoxColumn1.Name = "idDataGridViewTextBoxColumn1";
            this.idDataGridViewTextBoxColumn1.ReadOnly = true;
            // 
            // pwDataGridViewTextBoxColumn
            // 
            this.pwDataGridViewTextBoxColumn.DataPropertyName = "pw";
            this.pwDataGridViewTextBoxColumn.HeaderText = "密碼";
            this.pwDataGridViewTextBoxColumn.Name = "pwDataGridViewTextBoxColumn";
            this.pwDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // nameDataGridViewTextBoxColumn
            // 
            this.nameDataGridViewTextBoxColumn.DataPropertyName = "name";
            this.nameDataGridViewTextBoxColumn.HeaderText = "姓名";
            this.nameDataGridViewTextBoxColumn.Name = "nameDataGridViewTextBoxColumn";
            this.nameDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // posNameDataGridViewTextBoxColumn
            // 
            this.posNameDataGridViewTextBoxColumn.DataPropertyName = "PosName";
            this.posNameDataGridViewTextBoxColumn.HeaderText = "職稱";
            this.posNameDataGridViewTextBoxColumn.Name = "posNameDataGridViewTextBoxColumn";
            this.posNameDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // deptMg
            // 
            this.deptMg.DataPropertyName = "deptMg";
            this.deptMg.HeaderText = "主管";
            this.deptMg.Name = "deptMg";
            this.deptMg.ReadOnly = true;
            // 
            // empDataBindingSource
            // 
            this.empDataBindingSource.DataMember = "EmpData";
            this.empDataBindingSource.DataSource = this.flowDS;
            // 
            // tpSubWork
            // 
            this.tpSubWork.Controls.Add(this.gbSub);
            this.tpSubWork.Controls.Add(this.grdSubWork);
            this.tpSubWork.Location = new System.Drawing.Point(4, 21);
            this.tpSubWork.Name = "tpSubWork";
            this.tpSubWork.Size = new System.Drawing.Size(710, 474);
            this.tpSubWork.TabIndex = 4;
            this.tpSubWork.Text = "兼職設定";
            this.tpSubWork.UseVisualStyleBackColor = true;
            // 
            // gbSub
            // 
            this.gbSub.Controls.Add(this.lblAutoKey);
            this.gbSub.Controls.Add(this.cbFlowAuth);
            this.gbSub.Controls.Add(this.btnCancel);
            this.gbSub.Controls.Add(this.cbSubJob);
            this.gbSub.Controls.Add(this.cbSubDept);
            this.gbSub.Controls.Add(this.btnSend);
            this.gbSub.Controls.Add(this.label15);
            this.gbSub.Controls.Add(this.cbReplace);
            this.gbSub.Controls.Add(this.dtpDateD);
            this.gbSub.Controls.Add(this.label14);
            this.gbSub.Controls.Add(this.dtpDateA);
            this.gbSub.Controls.Add(this.cbSubMang);
            this.gbSub.Controls.Add(this.label13);
            this.gbSub.Controls.Add(this.label12);
            this.gbSub.Controls.Add(this.label11);
            this.gbSub.Controls.Add(this.cbSubNobr);
            this.gbSub.Controls.Add(this.label6);
            this.gbSub.Location = new System.Drawing.Point(3, 321);
            this.gbSub.Name = "gbSub";
            this.gbSub.Size = new System.Drawing.Size(704, 150);
            this.gbSub.TabIndex = 1;
            this.gbSub.TabStop = false;
            // 
            // lblAutoKey
            // 
            this.lblAutoKey.AutoSize = true;
            this.lblAutoKey.Location = new System.Drawing.Point(396, 18);
            this.lblAutoKey.Name = "lblAutoKey";
            this.lblAutoKey.Size = new System.Drawing.Size(11, 12);
            this.lblAutoKey.TabIndex = 27;
            this.lblAutoKey.Text = "0";
            this.lblAutoKey.Visible = false;
            // 
            // cbFlowAuth
            // 
            this.cbFlowAuth.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbFlowAuth.FormattingEnabled = true;
            this.cbFlowAuth.Items.AddRange(new object[] {
            "0",
            "1",
            "2",
            "3",
            "4",
            "5"});
            this.cbFlowAuth.Location = new System.Drawing.Point(65, 121);
            this.cbFlowAuth.Name = "cbFlowAuth";
            this.cbFlowAuth.Size = new System.Drawing.Size(37, 20);
            this.cbFlowAuth.TabIndex = 26;
            // 
            // btnCancel
            // 
            this.btnCancel.Location = new System.Drawing.Point(623, 119);
            this.btnCancel.Name = "btnCancel";
            this.btnCancel.Size = new System.Drawing.Size(75, 23);
            this.btnCancel.TabIndex = 25;
            this.btnCancel.Text = "取消";
            this.btnCancel.UseVisualStyleBackColor = true;
            this.btnCancel.Visible = false;
            this.btnCancel.Click += new System.EventHandler(this.btnCancel_Click);
            // 
            // cbSubJob
            // 
            this.cbSubJob.DataSource = this.tempPosBindingSource;
            this.cbSubJob.DisplayMember = "name";
            this.cbSubJob.FormattingEnabled = true;
            this.cbSubJob.Location = new System.Drawing.Point(65, 67);
            this.cbSubJob.Name = "cbSubJob";
            this.cbSubJob.Size = new System.Drawing.Size(121, 20);
            this.cbSubJob.TabIndex = 24;
            this.cbSubJob.ValueMember = "id";
            this.cbSubJob.TextChanged += new System.EventHandler(this.cbSubJob_TextChanged);
            // 
            // tempPosBindingSource
            // 
            this.tempPosBindingSource.DataMember = "tempPos";
            this.tempPosBindingSource.DataSource = this.flowDS;
            // 
            // cbSubDept
            // 
            this.cbSubDept.DataSource = this.tempDeptBindingSource;
            this.cbSubDept.DisplayMember = "name";
            this.cbSubDept.FormattingEnabled = true;
            this.cbSubDept.Location = new System.Drawing.Point(65, 41);
            this.cbSubDept.Name = "cbSubDept";
            this.cbSubDept.Size = new System.Drawing.Size(121, 20);
            this.cbSubDept.TabIndex = 23;
            this.cbSubDept.ValueMember = "id";
            this.cbSubDept.TextChanged += new System.EventHandler(this.cbSubDept_TextChanged);
            // 
            // tempDeptBindingSource
            // 
            this.tempDeptBindingSource.DataMember = "tempDept";
            this.tempDeptBindingSource.DataSource = this.flowDS;
            // 
            // btnSend
            // 
            this.btnSend.AccessibleName = "Add";
            this.btnSend.Location = new System.Drawing.Point(542, 119);
            this.btnSend.Name = "btnSend";
            this.btnSend.Size = new System.Drawing.Size(75, 23);
            this.btnSend.TabIndex = 22;
            this.btnSend.Tag = "Add";
            this.btnSend.Text = "新增";
            this.btnSend.UseVisualStyleBackColor = true;
            this.btnSend.Click += new System.EventHandler(this.btnSend_Click);
            // 
            // label15
            // 
            this.label15.AutoSize = true;
            this.label15.Location = new System.Drawing.Point(6, 124);
            this.label15.Name = "label15";
            this.label15.Size = new System.Drawing.Size(53, 12);
            this.label15.TabIndex = 16;
            this.label15.Text = "簽核順位";
            // 
            // cbReplace
            // 
            this.cbReplace.AutoSize = true;
            this.cbReplace.Location = new System.Drawing.Point(306, 17);
            this.cbReplace.Name = "cbReplace";
            this.cbReplace.Size = new System.Drawing.Size(84, 16);
            this.cbReplace.TabIndex = 15;
            this.cbReplace.Text = "取代原職位";
            this.cbReplace.UseVisualStyleBackColor = true;
            // 
            // dtpDateD
            // 
            this.dtpDateD.CustomFormat = "yyyy/MM/dd";
            this.dtpDateD.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpDateD.Location = new System.Drawing.Point(183, 93);
            this.dtpDateD.Name = "dtpDateD";
            this.dtpDateD.Size = new System.Drawing.Size(79, 22);
            this.dtpDateD.TabIndex = 14;
            // 
            // label14
            // 
            this.label14.AutoSize = true;
            this.label14.Location = new System.Drawing.Point(155, 98);
            this.label14.Name = "label14";
            this.label14.Size = new System.Drawing.Size(17, 12);
            this.label14.TabIndex = 13;
            this.label14.Text = "至";
            // 
            // dtpDateA
            // 
            this.dtpDateA.CustomFormat = "yyyy/MM/dd";
            this.dtpDateA.Format = System.Windows.Forms.DateTimePickerFormat.Custom;
            this.dtpDateA.Location = new System.Drawing.Point(65, 93);
            this.dtpDateA.Name = "dtpDateA";
            this.dtpDateA.Size = new System.Drawing.Size(79, 22);
            this.dtpDateA.TabIndex = 12;
            // 
            // cbSubMang
            // 
            this.cbSubMang.AutoSize = true;
            this.cbSubMang.Location = new System.Drawing.Point(192, 17);
            this.cbSubMang.Name = "cbSubMang";
            this.cbSubMang.Size = new System.Drawing.Size(108, 16);
            this.cbSubMang.TabIndex = 7;
            this.cbSubMang.Text = "是否兼職為主管";
            this.cbSubMang.UseVisualStyleBackColor = true;
            // 
            // label13
            // 
            this.label13.AutoSize = true;
            this.label13.Location = new System.Drawing.Point(6, 98);
            this.label13.Name = "label13";
            this.label13.Size = new System.Drawing.Size(53, 12);
            this.label13.TabIndex = 6;
            this.label13.Text = "生失效日";
            // 
            // label12
            // 
            this.label12.AutoSize = true;
            this.label12.Location = new System.Drawing.Point(6, 70);
            this.label12.Name = "label12";
            this.label12.Size = new System.Drawing.Size(53, 12);
            this.label12.TabIndex = 4;
            this.label12.Text = "兼職職稱";
            // 
            // label11
            // 
            this.label11.AutoSize = true;
            this.label11.Location = new System.Drawing.Point(6, 44);
            this.label11.Name = "label11";
            this.label11.Size = new System.Drawing.Size(53, 12);
            this.label11.TabIndex = 3;
            this.label11.Text = "兼職部門";
            // 
            // cbSubNobr
            // 
            this.cbSubNobr.DataSource = this.tempBaseBindingSource;
            this.cbSubNobr.DisplayMember = "name";
            this.cbSubNobr.FormattingEnabled = true;
            this.cbSubNobr.Location = new System.Drawing.Point(65, 15);
            this.cbSubNobr.Name = "cbSubNobr";
            this.cbSubNobr.Size = new System.Drawing.Size(121, 20);
            this.cbSubNobr.TabIndex = 1;
            this.cbSubNobr.ValueMember = "id";
            this.cbSubNobr.TextChanged += new System.EventHandler(this.cbSubNobr_TextChanged);
            // 
            // tempBaseBindingSource
            // 
            this.tempBaseBindingSource.DataMember = "tempBase";
            this.tempBaseBindingSource.DataSource = this.flowDS;
            // 
            // label6
            // 
            this.label6.AutoSize = true;
            this.label6.Location = new System.Drawing.Point(30, 18);
            this.label6.Name = "label6";
            this.label6.Size = new System.Drawing.Size(29, 12);
            this.label6.TabIndex = 0;
            this.label6.Text = "工號";
            // 
            // grdSubWork
            // 
            this.grdSubWork.AllowUserToAddRows = false;
            this.grdSubWork.AutoGenerateColumns = false;
            this.grdSubWork.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.grdSubWork.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.iAutoKeyDataGridViewTextBoxColumn,
            this.sNobrDataGridViewTextBoxColumn,
            this.empName,
            this.deptName,
            this.posName,
            this.bSubMangDataGridViewCheckBoxColumn,
            this.dAdateDataGridViewTextBoxColumn,
            this.dDdateDataGridViewTextBoxColumn,
            this.iFlowAuthDataGridViewTextBoxColumn,
            this.bReplaceDataGridViewCheckBoxColumn,
            this.sKeyManDataGridViewTextBoxColumn,
            this.dKeyDateDataGridViewTextBoxColumn});
            this.grdSubWork.DataSource = this.subWorkDataBindingSource;
            this.grdSubWork.Location = new System.Drawing.Point(3, 3);
            this.grdSubWork.Name = "grdSubWork";
            this.grdSubWork.ReadOnly = true;
            this.grdSubWork.RowTemplate.Height = 24;
            this.grdSubWork.Size = new System.Drawing.Size(704, 312);
            this.grdSubWork.TabIndex = 0;
            this.grdSubWork.UserDeletingRow += new System.Windows.Forms.DataGridViewRowCancelEventHandler(this.grdSubWork_UserDeletingRow);
            this.grdSubWork.UserDeletedRow += new System.Windows.Forms.DataGridViewRowEventHandler(this.grdSubWork_UserDeletedRow);
            this.grdSubWork.CellClick += new System.Windows.Forms.DataGridViewCellEventHandler(this.grdSubWork_CellClick);
            // 
            // iAutoKeyDataGridViewTextBoxColumn
            // 
            this.iAutoKeyDataGridViewTextBoxColumn.DataPropertyName = "iAutoKey";
            this.iAutoKeyDataGridViewTextBoxColumn.HeaderText = "iAutoKey";
            this.iAutoKeyDataGridViewTextBoxColumn.Name = "iAutoKeyDataGridViewTextBoxColumn";
            this.iAutoKeyDataGridViewTextBoxColumn.ReadOnly = true;
            this.iAutoKeyDataGridViewTextBoxColumn.Visible = false;
            // 
            // sNobrDataGridViewTextBoxColumn
            // 
            this.sNobrDataGridViewTextBoxColumn.DataPropertyName = "sNobr";
            this.sNobrDataGridViewTextBoxColumn.HeaderText = "工號";
            this.sNobrDataGridViewTextBoxColumn.Name = "sNobrDataGridViewTextBoxColumn";
            this.sNobrDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // empName
            // 
            this.empName.DataPropertyName = "empName";
            this.empName.HeaderText = "姓名";
            this.empName.Name = "empName";
            this.empName.ReadOnly = true;
            // 
            // deptName
            // 
            this.deptName.DataPropertyName = "deptName";
            this.deptName.HeaderText = "兼職部門";
            this.deptName.Name = "deptName";
            this.deptName.ReadOnly = true;
            // 
            // posName
            // 
            this.posName.DataPropertyName = "posName";
            this.posName.HeaderText = "兼職職稱";
            this.posName.Name = "posName";
            this.posName.ReadOnly = true;
            // 
            // bSubMangDataGridViewCheckBoxColumn
            // 
            this.bSubMangDataGridViewCheckBoxColumn.DataPropertyName = "bSubMang";
            this.bSubMangDataGridViewCheckBoxColumn.HeaderText = "管理職";
            this.bSubMangDataGridViewCheckBoxColumn.Name = "bSubMangDataGridViewCheckBoxColumn";
            this.bSubMangDataGridViewCheckBoxColumn.ReadOnly = true;
            // 
            // dAdateDataGridViewTextBoxColumn
            // 
            this.dAdateDataGridViewTextBoxColumn.DataPropertyName = "dAdate";
            this.dAdateDataGridViewTextBoxColumn.HeaderText = "生效日";
            this.dAdateDataGridViewTextBoxColumn.Name = "dAdateDataGridViewTextBoxColumn";
            this.dAdateDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // dDdateDataGridViewTextBoxColumn
            // 
            this.dDdateDataGridViewTextBoxColumn.DataPropertyName = "dDdate";
            this.dDdateDataGridViewTextBoxColumn.HeaderText = "失效日";
            this.dDdateDataGridViewTextBoxColumn.Name = "dDdateDataGridViewTextBoxColumn";
            this.dDdateDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // iFlowAuthDataGridViewTextBoxColumn
            // 
            this.iFlowAuthDataGridViewTextBoxColumn.DataPropertyName = "iFlowAuth";
            this.iFlowAuthDataGridViewTextBoxColumn.HeaderText = "順位";
            this.iFlowAuthDataGridViewTextBoxColumn.Name = "iFlowAuthDataGridViewTextBoxColumn";
            this.iFlowAuthDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // bReplaceDataGridViewCheckBoxColumn
            // 
            this.bReplaceDataGridViewCheckBoxColumn.DataPropertyName = "bReplace";
            this.bReplaceDataGridViewCheckBoxColumn.HeaderText = "取代原職";
            this.bReplaceDataGridViewCheckBoxColumn.Name = "bReplaceDataGridViewCheckBoxColumn";
            this.bReplaceDataGridViewCheckBoxColumn.ReadOnly = true;
            // 
            // sKeyManDataGridViewTextBoxColumn
            // 
            this.sKeyManDataGridViewTextBoxColumn.DataPropertyName = "sKeyMan";
            this.sKeyManDataGridViewTextBoxColumn.HeaderText = "sKeyMan";
            this.sKeyManDataGridViewTextBoxColumn.Name = "sKeyManDataGridViewTextBoxColumn";
            this.sKeyManDataGridViewTextBoxColumn.ReadOnly = true;
            this.sKeyManDataGridViewTextBoxColumn.Visible = false;
            // 
            // dKeyDateDataGridViewTextBoxColumn
            // 
            this.dKeyDateDataGridViewTextBoxColumn.DataPropertyName = "dKeyDate";
            this.dKeyDateDataGridViewTextBoxColumn.HeaderText = "dKeyDate";
            this.dKeyDateDataGridViewTextBoxColumn.Name = "dKeyDateDataGridViewTextBoxColumn";
            this.dKeyDateDataGridViewTextBoxColumn.ReadOnly = true;
            this.dKeyDateDataGridViewTextBoxColumn.Visible = false;
            // 
            // subWorkDataBindingSource
            // 
            this.subWorkDataBindingSource.DataMember = "SubWorkData";
            this.subWorkDataBindingSource.DataSource = this.flowDS;
            // 
            // tpReturnError
            // 
            this.tpReturnError.Controls.Add(this.bnOK);
            this.tpReturnError.Controls.Add(this.grdException);
            this.tpReturnError.Location = new System.Drawing.Point(4, 21);
            this.tpReturnError.Name = "tpReturnError";
            this.tpReturnError.Size = new System.Drawing.Size(710, 474);
            this.tpReturnError.TabIndex = 3;
            this.tpReturnError.Text = "錯誤回報";
            this.tpReturnError.UseVisualStyleBackColor = true;
            // 
            // bnOK
            // 
            this.bnOK.Location = new System.Drawing.Point(3, 448);
            this.bnOK.Name = "bnOK";
            this.bnOK.Size = new System.Drawing.Size(704, 23);
            this.bnOK.TabIndex = 2;
            this.bnOK.Text = "選取的項目問題已解決";
            this.bnOK.UseVisualStyleBackColor = true;
            this.bnOK.Click += new System.EventHandler(this.bnOK_Click);
            // 
            // grdException
            // 
            this.grdException.AllowUserToAddRows = false;
            this.grdException.AllowUserToDeleteRows = false;
            this.grdException.AutoGenerateColumns = false;
            this.grdException.AutoSizeColumnsMode = System.Windows.Forms.DataGridViewAutoSizeColumnsMode.Fill;
            this.grdException.ColumnHeadersHeightSizeMode = System.Windows.Forms.DataGridViewColumnHeadersHeightSizeMode.AutoSize;
            this.grdException.Columns.AddRange(new System.Windows.Forms.DataGridViewColumn[] {
            this.autoDataGridViewTextBoxColumn,
            this.flowTreenameDataGridViewTextBoxColumn1,
            this.flowNodenameDataGridViewTextBoxColumn1,
            this.empnameDataGridViewTextBoxColumn,
            this.errorTypeDataGridViewTextBoxColumn,
            this.errorMsgDataGridViewTextBoxColumn,
            this.adateDataGridViewTextBoxColumn1});
            this.grdException.DataSource = this.processExceptionBindingSource;
            this.grdException.Location = new System.Drawing.Point(3, 3);
            this.grdException.Name = "grdException";
            this.grdException.ReadOnly = true;
            this.grdException.RowTemplate.Height = 24;
            this.grdException.Size = new System.Drawing.Size(704, 439);
            this.grdException.TabIndex = 0;
            // 
            // autoDataGridViewTextBoxColumn
            // 
            this.autoDataGridViewTextBoxColumn.DataPropertyName = "auto";
            this.autoDataGridViewTextBoxColumn.HeaderText = "流程序號";
            this.autoDataGridViewTextBoxColumn.Name = "autoDataGridViewTextBoxColumn";
            this.autoDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // flowTreenameDataGridViewTextBoxColumn1
            // 
            this.flowTreenameDataGridViewTextBoxColumn1.DataPropertyName = "FlowTree_name";
            this.flowTreenameDataGridViewTextBoxColumn1.HeaderText = "例外流程";
            this.flowTreenameDataGridViewTextBoxColumn1.Name = "flowTreenameDataGridViewTextBoxColumn1";
            this.flowTreenameDataGridViewTextBoxColumn1.ReadOnly = true;
            // 
            // flowNodenameDataGridViewTextBoxColumn1
            // 
            this.flowNodenameDataGridViewTextBoxColumn1.DataPropertyName = "FlowNode_name";
            this.flowNodenameDataGridViewTextBoxColumn1.HeaderText = "例外節點";
            this.flowNodenameDataGridViewTextBoxColumn1.Name = "flowNodenameDataGridViewTextBoxColumn1";
            this.flowNodenameDataGridViewTextBoxColumn1.ReadOnly = true;
            // 
            // empnameDataGridViewTextBoxColumn
            // 
            this.empnameDataGridViewTextBoxColumn.DataPropertyName = "Emp_name";
            this.empnameDataGridViewTextBoxColumn.HeaderText = "處理者";
            this.empnameDataGridViewTextBoxColumn.Name = "empnameDataGridViewTextBoxColumn";
            this.empnameDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // errorTypeDataGridViewTextBoxColumn
            // 
            this.errorTypeDataGridViewTextBoxColumn.DataPropertyName = "errorType";
            this.errorTypeDataGridViewTextBoxColumn.HeaderText = "例外類期";
            this.errorTypeDataGridViewTextBoxColumn.Name = "errorTypeDataGridViewTextBoxColumn";
            this.errorTypeDataGridViewTextBoxColumn.ReadOnly = true;
            // 
            // errorMsgDataGridViewTextBoxColumn
            // 
            this.errorMsgDataGridViewTextBoxColumn.AutoSizeMode = System.Windows.Forms.DataGridViewAutoSizeColumnMode.AllCells;
            this.errorMsgDataGridViewTextBoxColumn.DataPropertyName = "errorMsg";
            this.errorMsgDataGridViewTextBoxColumn.HeaderText = "例外訊息";
            this.errorMsgDataGridViewTextBoxColumn.Name = "errorMsgDataGridViewTextBoxColumn";
            this.errorMsgDataGridViewTextBoxColumn.ReadOnly = true;
            this.errorMsgDataGridViewTextBoxColumn.Width = 78;
            // 
            // adateDataGridViewTextBoxColumn1
            // 
            this.adateDataGridViewTextBoxColumn1.DataPropertyName = "adate";
            this.adateDataGridViewTextBoxColumn1.HeaderText = "發生時間";
            this.adateDataGridViewTextBoxColumn1.Name = "adateDataGridViewTextBoxColumn1";
            this.adateDataGridViewTextBoxColumn1.ReadOnly = true;
            // 
            // processExceptionBindingSource
            // 
            this.processExceptionBindingSource.DataMember = "ProcessException";
            this.processExceptionBindingSource.DataSource = this.flowDS;
            // 
            // tpNote
            // 
            this.tpNote.Controls.Add(this.txtNote);
            this.tpNote.Location = new System.Drawing.Point(4, 21);
            this.tpNote.Name = "tpNote";
            this.tpNote.Size = new System.Drawing.Size(710, 474);
            this.tpNote.TabIndex = 5;
            this.tpNote.Text = "更新備註";
            this.tpNote.UseVisualStyleBackColor = true;
            // 
            // txtNote
            // 
            this.txtNote.Location = new System.Drawing.Point(3, 3);
            this.txtNote.Multiline = true;
            this.txtNote.Name = "txtNote";
            this.txtNote.ReadOnly = true;
            this.txtNote.Size = new System.Drawing.Size(704, 468);
            this.txtNote.TabIndex = 0;
            this.txtNote.Text = resources.GetString("txtNote.Text");
            // 
            // tmImport
            // 
            this.tmImport.Enabled = true;
            this.tmImport.Interval = 3600000;
            // 
            // nfcImport
            // 
            this.nfcImport.Icon = ((System.Drawing.Icon)(resources.GetObject("nfcImport.Icon")));
            this.nfcImport.Text = "JBHR組織轉ezFlow組織";
            // 
            // processFlowTableAdapter
            // 
            this.processFlowTableAdapter.ClearBeforeFill = true;
            // 
            // empDataTableAdapter
            // 
            this.empDataTableAdapter.ClearBeforeFill = true;
            // 
            // processExceptionTableAdapter
            // 
            this.processExceptionTableAdapter.ClearBeforeFill = true;
            // 
            // tempBaseTableAdapter
            // 
            this.tempBaseTableAdapter.ClearBeforeFill = true;
            // 
            // tempDeptTableAdapter
            // 
            this.tempDeptTableAdapter.ClearBeforeFill = true;
            // 
            // tempPosTableAdapter
            // 
            this.tempPosTableAdapter.ClearBeforeFill = true;
            // 
            // subWorkDataTableAdapter
            // 
            this.subWorkDataTableAdapter.ClearBeforeFill = true;
            // 
            // fmMain
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(742, 523);
            this.Controls.Add(this.tcMain);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
            this.Icon = ((System.Drawing.Icon)(resources.GetObject("$this.Icon")));
            this.MaximizeBox = false;
            this.Name = "fmMain";
            this.Text = "ezFlow管理員-V1.7";
            this.Load += new System.EventHandler(this.fmMain_Load);
            this.FormClosing += new System.Windows.Forms.FormClosingEventHandler(this.fmMain_FormClosing);
            this.tcMain.ResumeLayout(false);
            this.tpProcessView.ResumeLayout(false);
            this.groupBox2.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.grdProcess)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.processFlowBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.flowDS)).EndInit();
            this.gbSelectData.ResumeLayout(false);
            this.gbSelectData.PerformLayout();
            this.tpImportFlow.ResumeLayout(false);
            this.gbImportFlow1.ResumeLayout(false);
            this.gbImportFlow1.PerformLayout();
            this.tpDeptView.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.grdEmp)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.empDataBindingSource)).EndInit();
            this.tpSubWork.ResumeLayout(false);
            this.gbSub.ResumeLayout(false);
            this.gbSub.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.tempPosBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tempDeptBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.tempBaseBindingSource)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.grdSubWork)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.subWorkDataBindingSource)).EndInit();
            this.tpReturnError.ResumeLayout(false);
            ((System.ComponentModel.ISupportInitialize)(this.grdException)).EndInit();
            ((System.ComponentModel.ISupportInitialize)(this.processExceptionBindingSource)).EndInit();
            this.tpNote.ResumeLayout(false);
            this.tpNote.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.TabControl tcMain;
        private System.Windows.Forms.TabPage tpProcessView;
        private System.Windows.Forms.TabPage tpImportFlow;
        private System.Windows.Forms.TabPage tpDeptView;
        private System.Windows.Forms.TabPage tpReturnError;
        private System.Windows.Forms.GroupBox gbSelectData;
        private System.Windows.Forms.CheckBox ckCancel;
        private System.Windows.Forms.DateTimePicker dtEnd;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.DateTimePicker dtStart;
        private System.Windows.Forms.CheckBox ckDate;
        private System.Windows.Forms.CheckBox ckStarter;
        private System.Windows.Forms.CheckBox ckDept;
        private System.Windows.Forms.CheckBox ckFlow;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label lblSelectMsg;
        private System.Windows.Forms.DataGridView grdProcess;
        private System.Windows.Forms.GroupBox groupBox2;
        private System.Windows.Forms.Button btnAssign;
        private System.Windows.Forms.Button bnDelete;
        private System.Windows.Forms.Button bnContinue;
        private System.Windows.Forms.Button bnCancel;
        private System.Windows.Forms.Button bnFinish;
        private FlowDS flowDS;
        private System.Windows.Forms.BindingSource processFlowBindingSource;
        private ezFlowManage.FlowDSTableAdapters.ProcessFlowTableAdapter processFlowTableAdapter;
        private System.Windows.Forms.GroupBox gbImportFlow1;
        private System.Windows.Forms.GroupBox gbImportFlow2;
        private System.Windows.Forms.Label label9;
        private System.Windows.Forms.CheckBox cbRolePnull;
        private System.Windows.Forms.Label lbEmpCount;
        private System.Windows.Forms.Label label8;
        private System.Windows.Forms.CheckBox cbRoleP;
        private System.Windows.Forms.Label lbDeptCount;
        private System.Windows.Forms.Label lbState;
        private System.Windows.Forms.Label label5;
        private System.Windows.Forms.Label label7;
        private System.Windows.Forms.Label lbJobCount;
        private System.Windows.Forms.CheckBox cbRoleDel;
        private System.Windows.Forms.CheckBox cbPW;
        private System.Windows.Forms.CheckBox cbDeptP;
        private System.Windows.Forms.Button btnImportA;
        private System.Windows.Forms.TextBox txtDept;
        private System.Windows.Forms.CheckBox cbAutoImport;
        private System.Windows.Forms.Label label4;
        private System.Windows.Forms.ProgressBar progressBarA;
        private System.Windows.Forms.CheckBox cbNobr;
        private System.Windows.Forms.Label lbImportA;
        private System.Windows.Forms.Button btnRest;
        private System.Windows.Forms.Button btnImportB;
        private System.Windows.Forms.CheckBox cbDeptPP;
        private System.Windows.Forms.ProgressBar progressBarB;
        private System.Windows.Forms.TextBox txtDeptP;
        private System.Windows.Forms.Label lbImportB;
        private System.Windows.Forms.CheckBox cbFullImport;
        private System.Windows.Forms.CheckBox cbDept;
        private System.Windows.Forms.TextBox txtHour;
        private System.Windows.Forms.CheckBox cbB;
        private System.Windows.Forms.Label label3;
        private System.Windows.Forms.Label lbTime;
        private System.Windows.Forms.Timer tmImport;
        private System.Windows.Forms.Label label10;
        private System.Windows.Forms.NotifyIcon nfcImport;
        private System.Windows.Forms.TreeView tvDept;
        private System.Windows.Forms.DataGridView grdEmp;
        private System.Windows.Forms.BindingSource empDataBindingSource;
        private ezFlowManage.FlowDSTableAdapters.EmpDataTableAdapter empDataTableAdapter;
        private System.Windows.Forms.Button bnOK;
        private System.Windows.Forms.DataGridView grdException;
        private System.Windows.Forms.BindingSource processExceptionBindingSource;
        private ezFlowManage.FlowDSTableAdapters.ProcessExceptionTableAdapter processExceptionTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn autoDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn flowTreenameDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn flowNodenameDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn empnameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn errorTypeDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn errorMsgDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn adateDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn Emp_name;
        private System.Windows.Forms.DataGridViewTextBoxColumn adateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn flowTreenameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn flowNodenameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn empnameCheckDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn isCancelDataGridViewCheckBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn idDataGridViewTextBoxColumn1;
        private System.Windows.Forms.DataGridViewTextBoxColumn pwDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn nameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn posNameDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn deptMg;
        private System.Windows.Forms.TabPage tpSubWork;
        private System.Windows.Forms.DataGridView grdSubWork;
        private System.Windows.Forms.GroupBox gbSub;
        private System.Windows.Forms.Label label11;
        private System.Windows.Forms.ComboBox cbSubNobr;
        private System.Windows.Forms.Label label6;
        private System.Windows.Forms.Label label12;
        private System.Windows.Forms.CheckBox cbSubMang;
        private System.Windows.Forms.Label label13;
        private System.Windows.Forms.DateTimePicker dtpDateD;
        private System.Windows.Forms.Label label14;
        private System.Windows.Forms.DateTimePicker dtpDateA;
        private System.Windows.Forms.Label label15;
        private System.Windows.Forms.CheckBox cbReplace;
        private System.Windows.Forms.Button btnSend;
        private System.Windows.Forms.Button btnCancel;
        private System.Windows.Forms.ComboBox cbSubJob;
        private System.Windows.Forms.ComboBox cbSubDept;
        private System.Windows.Forms.BindingSource tempBaseBindingSource;
        private ezFlowManage.FlowDSTableAdapters.tempBaseTableAdapter tempBaseTableAdapter;
        private System.Windows.Forms.BindingSource tempDeptBindingSource;
        private ezFlowManage.FlowDSTableAdapters.tempDeptTableAdapter tempDeptTableAdapter;
        private System.Windows.Forms.BindingSource tempPosBindingSource;
        private ezFlowManage.FlowDSTableAdapters.tempPosTableAdapter tempPosTableAdapter;
        private System.Windows.Forms.ComboBox cbFlowAuth;
        private System.Windows.Forms.Label lblAutoKey;
        private System.Windows.Forms.BindingSource subWorkDataBindingSource;
        private ezFlowManage.FlowDSTableAdapters.SubWorkDataTableAdapter subWorkDataTableAdapter;
        private System.Windows.Forms.DataGridViewTextBoxColumn iAutoKeyDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn sNobrDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn empName;
        private System.Windows.Forms.DataGridViewTextBoxColumn deptName;
        private System.Windows.Forms.DataGridViewTextBoxColumn posName;
        private System.Windows.Forms.DataGridViewCheckBoxColumn bSubMangDataGridViewCheckBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn dAdateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn dDdateDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn iFlowAuthDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewCheckBoxColumn bReplaceDataGridViewCheckBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn sKeyManDataGridViewTextBoxColumn;
        private System.Windows.Forms.DataGridViewTextBoxColumn dKeyDateDataGridViewTextBoxColumn;
        private System.Windows.Forms.TabPage tpNote;
        private System.Windows.Forms.TextBox txtNote;
    }
}