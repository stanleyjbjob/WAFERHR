using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace OrgImport {
	public partial class Form1 : Form {
		OrgImportDSTableAdapters.DEPTATableAdapter adDeptA = new OrgImport.OrgImportDSTableAdapters.DEPTATableAdapter();
		OrgImportDSTableAdapters.JOBTableAdapter adJob = new OrgImport.OrgImportDSTableAdapters.JOBTableAdapter();
		OrgImportDSTableAdapters.BASETableAdapter adBase = new OrgImport.OrgImportDSTableAdapters.BASETableAdapter();
		OrgImportDSTableAdapters.BASETTSTableAdapter adBaseTTS = new OrgImport.OrgImportDSTableAdapters.BASETTSTableAdapter();

		OrgImportDSTableAdapters.DeptTableAdapter adDept = new OrgImport.OrgImportDSTableAdapters.DeptTableAdapter();
		OrgImportDSTableAdapters.PosTableAdapter adPos = new OrgImport.OrgImportDSTableAdapters.PosTableAdapter();
		OrgImportDSTableAdapters.EmpTableAdapter adEmp = new OrgImport.OrgImportDSTableAdapters.EmpTableAdapter();
		OrgImportDSTableAdapters.RoleTableAdapter adRole = new OrgImport.OrgImportDSTableAdapters.RoleTableAdapter();

		public Form1() {
			InitializeComponent();
		}

		private void Form1_Load(object sender, EventArgs e) {
			lbEmpCount.Text = adBaseTTS.EmpCounter().ToString();
			lbDeptCount.Text = adDeptA.GetData().Count.ToString();
			lbJobCount.Text = adJob.GetData().Count.ToString();
		}

		private void bnA_Click(object sender, EventArgs e) {
			lbAA.Text = "";
			progressBarA.Value = 0;

			OrgImportDS.DeptDataTable dtDept = adDept.GetData();
			for(int i = 0; i < dtDept.Count; i++) dtDept[i].Delete();
			adDept.Update(dtDept);

			OrgImportDS.PosDataTable dtPos = adPos.GetData();
			for(int i = 0; i < dtPos.Count; i++) dtPos[i].Delete();
			adPos.Update(dtPos);

			OrgImportDS.EmpDataTable dtEmp = adEmp.GetData();
			for(int i = 0; i < dtEmp.Count; i++) dtEmp[i].Delete();
			adEmp.Update(dtEmp);

			OrgImportDS.DEPTADataTable dtDeptA = adDeptA.GetData();
			OrgImportDS.JOBDataTable dtJob = adJob.GetData();
			OrgImportDS.BASEDataTable dtBase = adBase.GetData();

			progressBarA.Maximum = dtDeptA.Count + dtJob.Count + dtBase.Count;

			foreach(OrgImportDS.DEPTARow rowDeptA in dtDeptA.Rows) {
				OrgImportDS.DeptRow rowDept = dtDept.NewDeptRow();
				rowDept.id = rowDeptA.d_no.Trim();
				rowDept.idParent = rowDeptA.DEPT_GROUP.Trim();
				if(rowDept.id == rowDept.idParent) rowDept.idParent = "";
				rowDept.name = rowDeptA.d_name.Trim();
				rowDept.path = "";
				rowDept.DeptLevel_id = "0";
				dtDept.AddDeptRow(rowDept);

				progressBarA.Value++;
			}
			adDept.Update(dtDept);

			foreach(OrgImportDS.JOBRow rowJob in dtJob.Rows) {
				OrgImportDS.PosRow rowPos = dtPos.NewPosRow();
				rowPos.id = rowJob.job.Trim();
				rowPos.name = rowJob.job_name.Trim();
				rowPos.PosLevel_id = "0";
				dtPos.AddPosRow(rowPos);

				progressBarA.Value++;
			}
			adPos.Update(dtPos);

			foreach(OrgImportDS.BASERow rowBase in dtBase.Rows) {
				OrgImportDS.EmpRow rowEmp = dtEmp.NewEmpRow();
				rowEmp.id = rowBase.Nobr.Trim();
				rowEmp.pw = rowBase.password.Trim();
				rowEmp.name = rowBase.name_c.Trim();
				rowEmp.isNeedAgent = false;
				rowEmp.dateB = Convert.ToDateTime("1900/1/1 00:00:00");
				rowEmp.dateE = Convert.ToDateTime("1900/1/1 00:00:00");
                if (!rowBase.IsNull("email") && rowBase.email.Trim().Length > 0) {
					rowEmp.email = rowBase.email.Trim();
				}
				else rowEmp.email = "";
				rowEmp.login = rowBase.Nobr.Trim();
				if(rowBase.sex.Trim() == "M") rowEmp.sex = "¨k";
				else rowEmp.sex = "¤k";
				dtEmp.AddEmpRow(rowEmp);

				progressBarA.Value++;
			}
			adEmp.Update(dtEmp);

			lbAA.Text = "Import OK!!";

			bnB_Click(sender, e);
			bnC_Click(sender, e);
			bnD_Click(sender, e);
		}

		private void bnB_Click(object sender, EventArgs e) {
			lbBB.Text = "";
			progressBarB.Value = 0;
			progressBarB.Maximum = adDept.GetData().Count;

			OrgImportDS.DeptDataTable dtDept = adDept.GetDataByParent("");
			foreach(OrgImportDS.DeptRow rowDept in dtDept.Rows) {
				rowDept.path = "/" + rowDept.name;
				OrgImportDS.DeptDataTable dtSubDept = adDept.GetDataByParent(rowDept.id);
				if(dtSubDept.Count > 0) CreateSubOrgPath(dtSubDept, rowDept.path);

				progressBarB.Value++;
			}
			adDept.Update(dtDept);

			lbBB.Text = "Import OK!!";
		}

		void CreateSubOrgPath(OrgImportDS.DeptDataTable dtDept, string parentPath) {
			foreach(OrgImportDS.DeptRow rowDept in dtDept.Rows) {
				rowDept.path = parentPath + "/" + rowDept.name;
				OrgImportDS.DeptDataTable dtSubDept = adDept.GetDataByParent(rowDept.id);
				if(dtSubDept.Count > 0) CreateSubOrgPath(dtSubDept, rowDept.path);

				progressBarB.Value++;
			}
			adDept.Update(dtDept);
		}

		private void bnC_Click(object sender, EventArgs e) {
			OrgImportDS.BASETTSDataTable dtBaseTTS = adBaseTTS.GetData();

			OrgImportDS.RoleDataTable dtRole = adRole.GetData();
			for(int i = 0; i < dtRole.Count; i++) dtRole[i].Delete();
			adRole.Update(dtRole);

			lbCC.Text = "";
			progressBarC.Value = 0;
			progressBarC.Maximum = dtBaseTTS.Count;

			foreach(OrgImportDS.BASETTSRow rowBaseTTS in dtBaseTTS.Rows) {
				OrgImportDS.RoleRow rowRole = dtRole.NewRoleRow();
				rowRole.id = rowBaseTTS.dept.Trim() + rowBaseTTS.job.Trim();
				rowRole.idParent = "";
				rowRole.Dept_id = rowBaseTTS.dept.Trim();
				rowRole.Pos_id = rowBaseTTS.job.Trim();
				rowRole.dateB = rowBaseTTS.adate;
				rowRole.dateE = rowBaseTTS.ddate;
				rowRole.Emp_id = rowBaseTTS.Nobr.Trim();
				rowRole.mgDefault = false;
				rowRole.deptMg = false;
				dtRole.AddRoleRow(rowRole);

				progressBarC.Value++;
			}
			adRole.Update(dtRole);

			adRole.FixUpdate();

			lbCC.Text = "Import OK!!";

			bnD_Click(sender, e);
		}

		private void bnD_Click(object sender, EventArgs e) {
			OrgImportDS.BASETTSDataTable dtBaseTTS = adBaseTTS.GetDataByMang();

			lbDD.Text = "";
			progressBarD.Value = 0;
			progressBarD.Maximum = dtBaseTTS.Count;

			foreach(OrgImportDS.BASETTSRow rowBaseTTS in dtBaseTTS.Rows) {
				OrgImportDS.RoleDataTable dtRole = adRole.GetDataByNoDeptMaster(rowBaseTTS.dept.Trim(),rowBaseTTS.Nobr.Trim());
				foreach(OrgImportDS.RoleRow rowRole in dtRole.Rows) {
					rowRole.idParent = rowBaseTTS.dept.Trim() + rowBaseTTS.job.Trim();
				}
				adRole.Update(dtRole);

				progressBarD.Value++;
			}

			lbDD.Text = "Import OK!!";
		}
	}
}