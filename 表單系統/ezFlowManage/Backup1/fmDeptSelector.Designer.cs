namespace ezFlowManage {
    partial class fmDeptSelector {
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
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(fmDeptSelector));
            this.btnY = new System.Windows.Forms.Button();
            this.tvDept = new System.Windows.Forms.TreeView();
            this.btnN = new System.Windows.Forms.Button();
            this.imageList = new System.Windows.Forms.ImageList(this.components);
            this.SuspendLayout();
            // 
            // btnY
            // 
            this.btnY.Location = new System.Drawing.Point(200, 345);
            this.btnY.Name = "btnY";
            this.btnY.Size = new System.Drawing.Size(37, 23);
            this.btnY.TabIndex = 4;
            this.btnY.Tag = "Yes";
            this.btnY.Text = "確定";
            this.btnY.UseVisualStyleBackColor = true;
            this.btnY.Click += new System.EventHandler(this.btnYorN_Click);
            // 
            // tvDept
            // 
            this.tvDept.ImageIndex = 0;
            this.tvDept.ImageList = this.imageList;
            this.tvDept.Location = new System.Drawing.Point(12, 12);
            this.tvDept.Name = "tvDept";
            this.tvDept.SelectedImageIndex = 0;
            this.tvDept.Size = new System.Drawing.Size(268, 327);
            this.tvDept.TabIndex = 3;
            // 
            // btnN
            // 
            this.btnN.Location = new System.Drawing.Point(243, 345);
            this.btnN.Name = "btnN";
            this.btnN.Size = new System.Drawing.Size(37, 23);
            this.btnN.TabIndex = 5;
            this.btnN.Tag = "No";
            this.btnN.Text = "取消";
            this.btnN.UseVisualStyleBackColor = true;
            this.btnN.Click += new System.EventHandler(this.btnYorN_Click);
            // 
            // imageList
            // 
            this.imageList.ImageStream = ((System.Windows.Forms.ImageListStreamer)(resources.GetObject("imageList.ImageStream")));
            this.imageList.TransparentColor = System.Drawing.SystemColors.Control;
            this.imageList.Images.SetKeyName(0, "untitled.bmp");
            // 
            // fmDeptSelector
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.AutoSizeMode = System.Windows.Forms.AutoSizeMode.GrowAndShrink;
            this.ClientSize = new System.Drawing.Size(292, 380);
            this.ControlBox = false;
            this.Controls.Add(this.btnN);
            this.Controls.Add(this.btnY);
            this.Controls.Add(this.tvDept);
            this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedDialog;
            this.Name = "fmDeptSelector";
            this.ShowInTaskbar = false;
            this.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen;
            this.Text = "fmDeptSelector";
            this.Load += new System.EventHandler(this.fmDeptSelector_Load);
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Button btnY;
        private System.Windows.Forms.TreeView tvDept;
        private System.Windows.Forms.Button btnN;
        private System.Windows.Forms.ImageList imageList;

    }
}