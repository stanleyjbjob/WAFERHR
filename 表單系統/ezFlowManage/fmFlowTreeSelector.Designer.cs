namespace ezFlowManage {
    partial class fmFlowTreeSelector {
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
            this.btnN = new System.Windows.Forms.Button();
            this.btnY = new System.Windows.Forms.Button();
            this.cbxFlowTree = new System.Windows.Forms.ComboBox();
            this.SuspendLayout();
            // 
            // btnN
            // 
            this.btnN.Location = new System.Drawing.Point(182, 12);
            this.btnN.Name = "btnN";
            this.btnN.Size = new System.Drawing.Size(37, 23);
            this.btnN.TabIndex = 5;
            this.btnN.Tag = "No";
            this.btnN.Text = "取消";
            this.btnN.UseVisualStyleBackColor = true;
            this.btnN.Click += new System.EventHandler(this.btnYorN_Click);
            // 
            // btnY
            // 
            this.btnY.Location = new System.Drawing.Point(139, 12);
            this.btnY.Name = "btnY";
            this.btnY.Size = new System.Drawing.Size(37, 23);
            this.btnY.TabIndex = 4;
            this.btnY.Tag = "Yes";
            this.btnY.Text = "確定";
            this.btnY.UseVisualStyleBackColor = true;
            this.btnY.Click += new System.EventHandler(this.btnYorN_Click);
            // 
            // cbxFlowTree
            // 
            this.cbxFlowTree.Cursor = System.Windows.Forms.Cursors.Arrow;
            this.cbxFlowTree.DropDownStyle = System.Windows.Forms.ComboBoxStyle.DropDownList;
            this.cbxFlowTree.DropDownWidth = 200;
            this.cbxFlowTree.FormattingEnabled = true;
            this.cbxFlowTree.Location = new System.Drawing.Point(12, 14);
            this.cbxFlowTree.Name = "cbxFlowTree";
            this.cbxFlowTree.Size = new System.Drawing.Size(121, 20);
            this.cbxFlowTree.TabIndex = 3;
            // 
            // fmFlowTreeSelector
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(231, 47);
            this.ControlBox = false;
            this.Controls.Add(this.btnN);
            this.Controls.Add(this.btnY);
            this.Controls.Add(this.cbxFlowTree);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "fmFlowTreeSelector";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "選取表單流程";
            this.Load += new System.EventHandler(this.fmFlowTreeSelector_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnN;
        private System.Windows.Forms.Button btnY;
        private System.Windows.Forms.ComboBox cbxFlowTree;
    }
}