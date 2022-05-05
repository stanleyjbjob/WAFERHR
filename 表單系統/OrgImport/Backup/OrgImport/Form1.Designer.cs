namespace OrgImport {
	partial class Form1 {
		/// <summary>
		/// 設計工具所需的變數。
		/// </summary>
		private System.ComponentModel.IContainer components = null;

		/// <summary>
		/// 清除任何使用中的資源。
		/// </summary>
		/// <param name="disposing">如果應該公開 Managed 資源則為 true，否則為 false。</param>
		protected override void Dispose(bool disposing) {
			if(disposing && (components != null)) {
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
			this.label1 = new System.Windows.Forms.Label();
			this.lbEmpCount = new System.Windows.Forms.Label();
			this.lbDeptCount = new System.Windows.Forms.Label();
			this.label3 = new System.Windows.Forms.Label();
			this.lbJobCount = new System.Windows.Forms.Label();
			this.label5 = new System.Windows.Forms.Label();
			this.bnA = new System.Windows.Forms.Button();
			this.lbA = new System.Windows.Forms.Label();
			this.lbC = new System.Windows.Forms.Label();
			this.bnC = new System.Windows.Forms.Button();
			this.lbD = new System.Windows.Forms.Label();
			this.bnD = new System.Windows.Forms.Button();
			this.lbB = new System.Windows.Forms.Label();
			this.bnB = new System.Windows.Forms.Button();
			this.label8 = new System.Windows.Forms.Label();
			this.label9 = new System.Windows.Forms.Label();
			this.label10 = new System.Windows.Forms.Label();
			this.label11 = new System.Windows.Forms.Label();
			this.progressBarA = new System.Windows.Forms.ProgressBar();
			this.progressBarB = new System.Windows.Forms.ProgressBar();
			this.progressBarC = new System.Windows.Forms.ProgressBar();
			this.progressBarD = new System.Windows.Forms.ProgressBar();
			this.lbAA = new System.Windows.Forms.Label();
			this.lbBB = new System.Windows.Forms.Label();
			this.lbCC = new System.Windows.Forms.Label();
			this.lbDD = new System.Windows.Forms.Label();
			this.SuspendLayout();
			// 
			// label1
			// 
			this.label1.AutoSize = true;
			this.label1.Location = new System.Drawing.Point(43, 10);
			this.label1.Name = "label1";
			this.label1.Size = new System.Drawing.Size(105, 13);
			this.label1.TabIndex = 0;
			this.label1.Text = "應轉人員數量：";
			// 
			// lbEmpCount
			// 
			this.lbEmpCount.AutoSize = true;
			this.lbEmpCount.Location = new System.Drawing.Point(145, 10);
			this.lbEmpCount.Name = "lbEmpCount";
			this.lbEmpCount.Size = new System.Drawing.Size(0, 13);
			this.lbEmpCount.TabIndex = 1;
			// 
			// lbDeptCount
			// 
			this.lbDeptCount.AutoSize = true;
			this.lbDeptCount.Location = new System.Drawing.Point(145, 28);
			this.lbDeptCount.Name = "lbDeptCount";
			this.lbDeptCount.Size = new System.Drawing.Size(0, 13);
			this.lbDeptCount.TabIndex = 3;
			// 
			// label3
			// 
			this.label3.AutoSize = true;
			this.label3.Location = new System.Drawing.Point(43, 28);
			this.label3.Name = "label3";
			this.label3.Size = new System.Drawing.Size(105, 13);
			this.label3.TabIndex = 2;
			this.label3.Text = "應轉部門數量：";
			// 
			// lbJobCount
			// 
			this.lbJobCount.AutoSize = true;
			this.lbJobCount.Location = new System.Drawing.Point(145, 46);
			this.lbJobCount.Name = "lbJobCount";
			this.lbJobCount.Size = new System.Drawing.Size(0, 13);
			this.lbJobCount.TabIndex = 5;
			// 
			// label5
			// 
			this.label5.AutoSize = true;
			this.label5.Location = new System.Drawing.Point(43, 46);
			this.label5.Name = "label5";
			this.label5.Size = new System.Drawing.Size(105, 13);
			this.label5.TabIndex = 4;
			this.label5.Text = "應轉職稱數量：";
			// 
			// bnA
			// 
			this.bnA.Location = new System.Drawing.Point(46, 66);
			this.bnA.Name = "bnA";
			this.bnA.Size = new System.Drawing.Size(250, 23);
			this.bnA.TabIndex = 6;
			this.bnA.Text = "匯入部門、職稱及員工代碼";
			this.bnA.UseVisualStyleBackColor = true;
			this.bnA.Click += new System.EventHandler(this.bnA_Click);
			// 
			// lbA
			// 
			this.lbA.AutoSize = true;
			this.lbA.Location = new System.Drawing.Point(302, 71);
			this.lbA.Name = "lbA";
			this.lbA.Size = new System.Drawing.Size(77, 13);
			this.lbA.TabIndex = 7;
			this.lbA.Text = "Ready GO!!";
			// 
			// lbC
			// 
			this.lbC.AutoSize = true;
			this.lbC.Location = new System.Drawing.Point(303, 173);
			this.lbC.Name = "lbC";
			this.lbC.Size = new System.Drawing.Size(77, 13);
			this.lbC.TabIndex = 9;
			this.lbC.Text = "Ready GO!!";
			// 
			// bnC
			// 
			this.bnC.Location = new System.Drawing.Point(46, 168);
			this.bnC.Name = "bnC";
			this.bnC.Size = new System.Drawing.Size(250, 23);
			this.bnC.TabIndex = 8;
			this.bnC.Text = "產生角色代碼檔";
			this.bnC.UseVisualStyleBackColor = true;
			this.bnC.Click += new System.EventHandler(this.bnC_Click);
			// 
			// lbD
			// 
			this.lbD.AutoSize = true;
			this.lbD.Location = new System.Drawing.Point(302, 224);
			this.lbD.Name = "lbD";
			this.lbD.Size = new System.Drawing.Size(77, 13);
			this.lbD.TabIndex = 11;
			this.lbD.Text = "Ready GO!!";
			// 
			// bnD
			// 
			this.bnD.Location = new System.Drawing.Point(46, 219);
			this.bnD.Name = "bnD";
			this.bnD.Size = new System.Drawing.Size(250, 23);
			this.bnD.TabIndex = 10;
			this.bnD.Text = "為角色代碼建立從屬關係";
			this.bnD.UseVisualStyleBackColor = true;
			this.bnD.Click += new System.EventHandler(this.bnD_Click);
			// 
			// lbB
			// 
			this.lbB.AutoSize = true;
			this.lbB.Location = new System.Drawing.Point(302, 122);
			this.lbB.Name = "lbB";
			this.lbB.Size = new System.Drawing.Size(77, 13);
			this.lbB.TabIndex = 13;
			this.lbB.Text = "Ready GO!!";
			// 
			// bnB
			// 
			this.bnB.Location = new System.Drawing.Point(46, 117);
			this.bnB.Name = "bnB";
			this.bnB.Size = new System.Drawing.Size(250, 23);
			this.bnB.TabIndex = 12;
			this.bnB.Text = "建立部門從屬關係與產生部門路徑";
			this.bnB.UseVisualStyleBackColor = true;
			this.bnB.Click += new System.EventHandler(this.bnB_Click);
			// 
			// label8
			// 
			this.label8.AutoSize = true;
			this.label8.Location = new System.Drawing.Point(18, 71);
			this.label8.Name = "label8";
			this.label8.Size = new System.Drawing.Size(28, 13);
			this.label8.TabIndex = 14;
			this.label8.Text = "(1)";
			// 
			// label9
			// 
			this.label9.AutoSize = true;
			this.label9.Location = new System.Drawing.Point(18, 127);
			this.label9.Name = "label9";
			this.label9.Size = new System.Drawing.Size(28, 13);
			this.label9.TabIndex = 15;
			this.label9.Text = "(2)";
			// 
			// label10
			// 
			this.label10.AutoSize = true;
			this.label10.Location = new System.Drawing.Point(19, 173);
			this.label10.Name = "label10";
			this.label10.Size = new System.Drawing.Size(28, 13);
			this.label10.TabIndex = 16;
			this.label10.Text = "(3)";
			// 
			// label11
			// 
			this.label11.AutoSize = true;
			this.label11.Location = new System.Drawing.Point(18, 224);
			this.label11.Name = "label11";
			this.label11.Size = new System.Drawing.Size(28, 13);
			this.label11.TabIndex = 17;
			this.label11.Text = "(4)";
			// 
			// progressBarA
			// 
			this.progressBarA.Location = new System.Drawing.Point(46, 88);
			this.progressBarA.Name = "progressBarA";
			this.progressBarA.Size = new System.Drawing.Size(250, 23);
			this.progressBarA.TabIndex = 18;
			// 
			// progressBarB
			// 
			this.progressBarB.Location = new System.Drawing.Point(46, 139);
			this.progressBarB.Name = "progressBarB";
			this.progressBarB.Size = new System.Drawing.Size(250, 23);
			this.progressBarB.TabIndex = 19;
			// 
			// progressBarC
			// 
			this.progressBarC.Location = new System.Drawing.Point(46, 190);
			this.progressBarC.Name = "progressBarC";
			this.progressBarC.Size = new System.Drawing.Size(250, 23);
			this.progressBarC.TabIndex = 20;
			// 
			// progressBarD
			// 
			this.progressBarD.Location = new System.Drawing.Point(46, 241);
			this.progressBarD.Name = "progressBarD";
			this.progressBarD.Size = new System.Drawing.Size(250, 23);
			this.progressBarD.TabIndex = 21;
			// 
			// lbAA
			// 
			this.lbAA.AutoSize = true;
			this.lbAA.Location = new System.Drawing.Point(302, 93);
			this.lbAA.Name = "lbAA";
			this.lbAA.Size = new System.Drawing.Size(0, 13);
			this.lbAA.TabIndex = 22;
			// 
			// lbBB
			// 
			this.lbBB.AutoSize = true;
			this.lbBB.Location = new System.Drawing.Point(302, 144);
			this.lbBB.Name = "lbBB";
			this.lbBB.Size = new System.Drawing.Size(0, 13);
			this.lbBB.TabIndex = 23;
			// 
			// lbCC
			// 
			this.lbCC.AutoSize = true;
			this.lbCC.Location = new System.Drawing.Point(302, 195);
			this.lbCC.Name = "lbCC";
			this.lbCC.Size = new System.Drawing.Size(0, 13);
			this.lbCC.TabIndex = 24;
			// 
			// lbDD
			// 
			this.lbDD.AutoSize = true;
			this.lbDD.Location = new System.Drawing.Point(302, 246);
			this.lbDD.Name = "lbDD";
			this.lbDD.Size = new System.Drawing.Size(0, 13);
			this.lbDD.TabIndex = 25;
			// 
			// Form1
			// 
			this.AutoScaleDimensions = new System.Drawing.SizeF(7F, 13F);
			this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
			this.ClientSize = new System.Drawing.Size(394, 276);
			this.Controls.Add(this.lbDD);
			this.Controls.Add(this.lbCC);
			this.Controls.Add(this.lbBB);
			this.Controls.Add(this.lbAA);
			this.Controls.Add(this.progressBarD);
			this.Controls.Add(this.progressBarC);
			this.Controls.Add(this.progressBarB);
			this.Controls.Add(this.progressBarA);
			this.Controls.Add(this.label11);
			this.Controls.Add(this.label10);
			this.Controls.Add(this.label9);
			this.Controls.Add(this.label8);
			this.Controls.Add(this.lbB);
			this.Controls.Add(this.bnB);
			this.Controls.Add(this.lbD);
			this.Controls.Add(this.bnD);
			this.Controls.Add(this.lbC);
			this.Controls.Add(this.bnC);
			this.Controls.Add(this.lbA);
			this.Controls.Add(this.bnA);
			this.Controls.Add(this.lbJobCount);
			this.Controls.Add(this.label5);
			this.Controls.Add(this.lbDeptCount);
			this.Controls.Add(this.label3);
			this.Controls.Add(this.lbEmpCount);
			this.Controls.Add(this.label1);
			this.Font = new System.Drawing.Font("細明體", 9.75F, System.Drawing.FontStyle.Regular, System.Drawing.GraphicsUnit.Point, ((byte)(136)));
			this.FormBorderStyle = System.Windows.Forms.FormBorderStyle.FixedSingle;
			this.MaximizeBox = false;
			this.Name = "Form1";
			this.Text = "JBHR組織轉ezFlow組織";
			this.Load += new System.EventHandler(this.Form1_Load);
			this.ResumeLayout(false);
			this.PerformLayout();

		}

		#endregion

		private System.Windows.Forms.Label label1;
		private System.Windows.Forms.Label lbEmpCount;
		private System.Windows.Forms.Label lbDeptCount;
		private System.Windows.Forms.Label label3;
		private System.Windows.Forms.Label lbJobCount;
		private System.Windows.Forms.Label label5;
		private System.Windows.Forms.Button bnA;
		private System.Windows.Forms.Label lbA;
		private System.Windows.Forms.Label lbC;
		private System.Windows.Forms.Button bnC;
		private System.Windows.Forms.Label lbD;
		private System.Windows.Forms.Button bnD;
		private System.Windows.Forms.Label lbB;
		private System.Windows.Forms.Button bnB;
		private System.Windows.Forms.Label label8;
		private System.Windows.Forms.Label label9;
		private System.Windows.Forms.Label label10;
		private System.Windows.Forms.Label label11;
		private System.Windows.Forms.ProgressBar progressBarA;
		private System.Windows.Forms.ProgressBar progressBarB;
		private System.Windows.Forms.ProgressBar progressBarC;
		private System.Windows.Forms.ProgressBar progressBarD;
		private System.Windows.Forms.Label lbAA;
		private System.Windows.Forms.Label lbBB;
		private System.Windows.Forms.Label lbCC;
		private System.Windows.Forms.Label lbDD;
	}
}

