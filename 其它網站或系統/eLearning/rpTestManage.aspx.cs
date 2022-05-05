using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using Microsoft.Reporting.WebForms;

public partial class rpTestManage : System.Web.UI.Page
{
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private TsDSTableAdapters.tsBaseMTableAdapter tsBaseMTA = new TsDSTableAdapters.tsBaseMTableAdapter();
    private SysDSTableAdapters.BaseTtsTableAdapter BaseTtsTA = new SysDSTableAdapters.BaseTtsTableAdapter();

    private TsDS oTsDS;
    private SysDS oSysDS;

    private DataRow[] rows, rows1;


    protected void Page_Load(object sender, EventArgs e)
    {
        oTsDS = new TsDS();
        oSysDS = new SysDS();
        ReportViewer1.Visible = false;
        if (!IsPostBack)
        {
            txtDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
            txtDateB.Text = "2009/01/01";// DateTime.Now.AddDays(-183).ToString("yyyy/MM/dd");
            txtDateE.Text = "9999/12/31";
        }
    }

    protected void Create_Report_Click(object sender, EventArgs e)
    {
        SysDS Nds = new SysDS();
        DateTime dDate, dDateB, dDateE;
        try
        {
            dDate = Convert.ToDateTime(txtDate.Text);
        }
        catch
        {
            dDate = DateTime.Now.Date;
        }

        try
        {
            dDateB = Convert.ToDateTime(txtDateB.Text);
        }
        catch
        {
            dDateB = DateTime.Now.AddDays(-183).Date;
        }

        try
        {
            dDateE = Convert.ToDateTime(txtDateE.Text);
        }
        catch
        {
            dDateE = Convert.ToDateTime("9999/12/31");
        }

        string sDeptCode = ddlDept.SelectedItem.Value;
        string sNobr = txtNobr.Text.Trim();

        DataTable dt = new DataTable();
        dt.Columns.Add("sNobr", typeof(string)).DefaultValue = "";
        dt.Columns.Add("sNamec", typeof(string)).DefaultValue = "";
        dt.Columns.Add("sJobCode", typeof(string)).DefaultValue = "";
        dt.Columns.Add("sJobName", typeof(string)).DefaultValue = "";
        dt.Columns.Add("sDeptCode", typeof(string)).DefaultValue = "";
        dt.Columns.Add("sDeptName", typeof(string)).DefaultValue = "";
        dt.Columns.Add("sDeptPath", typeof(string)).DefaultValue = "";

        //引入所有考卷代碼為欄位
        tsQuestionsMTA.Fill(oTsDS.tsQuestionsM);
        DataView dvQuestionsM = new DataView(oTsDS.tsQuestionsM);
        dvQuestionsM.Sort = "sCode";
        foreach (TsDS.tsQuestionsMRow rqm in dvQuestionsM.Table.Rows)
            dt.Columns.Add(rqm.sCode, typeof(string)).DefaultValue = "";

        //引入考試人員
        tsBaseMTA.Fill(oTsDS.tsBaseM);

        //引入hr名單
        //BaseTtsTA.Fill(oSysDS.BaseTts);

        //產生資料(一個人一筆)
        Hashtable ht = new Hashtable();
        TsDS.tsBaseMRow rbm1;
        DataRow dr;
        SysDS.BaseTtsRow rbt;
        string sNote;
        foreach (TsDS.tsBaseMRow rbm in oTsDS.tsBaseM.Rows)
        {
            if (!ht.Contains(rbm.sNobr) && (dDateB <= rbm.dAmountDate.Date && rbm.dAmountDate.Date <= dDateE))
            {
                dr = dt.NewRow();
                dr["sNobr"] = rbm.sNobr;

                //rows = oSysDS.BaseTts.Select("sNobr = '" + rbm.sNobr + "'");
                rows = BaseTtsTA.GetDataByNobr(rbm.sNobr).Select();
                if (rows.Length > 0)
                {
                    rbt = rows[0] as SysDS.BaseTtsRow;
                    dr["sNamec"] = rbt.sNamec;
                    dr["sJobName"] = rbt.sJobName;
                    dr["sDeptCode"] = rbt.sDeptCode;
                    dr["sDeptName"] = rbt.sDeptName;
                }
                else
                    continue;   //找不到就當做已離職

                foreach (TsDS.tsQuestionsMRow rqm in dvQuestionsM.Table.Rows)
                {
                    rows1 = oTsDS.tsBaseM.Select("sNobr = '" + rbm.sNobr + "' AND tsQuestionsM_sCode = '" + rqm.sCode + "'", "dAmountDate DESC");
                    if (rows1.Length > 0)
                    {
                        rbm1 = rows1[0] as TsDS.tsBaseMRow;
                        sNote = (!rbm1.IsdWriteDateNull() && dDate.AddDays(-rqm.iScope) <= rbm1.dWriteDate) || rqm.iScope == 0 ? "" : "★";
                        dr[rqm.sCode] = rbm1.tsTitle_sCode + sNote + (ckM.Checked ? "" : ("\r\n") + (rbm1.IsdWriteDateNull() ? "" : rbm1.dWriteDate.ToShortDateString()));
                    }
                }

                //依部門&工號查詢
                if (rows.Length > 0 && (sDeptCode == "0" || dr["sDeptCode"].ToString() == sDeptCode) && (sNobr.Length == 0 || sNobr == dr["sNobr"].ToString()))
                    dt.Rows.Add(dr);

                ht.Add(rbm.sNobr, rbm.sNobr);
            }
        }

        if (sDeptCode != "0")
        {
            rows = BaseTtsTA.GetDataByDeptCode(sDeptCode).Select();
            foreach (SysDS.BaseTtsRow rb in rows)
            {
                if (dt.Select("sNobr = '" + rb.sNobr.Trim() + "'").Length == 0)
                {
                    dr = dt.NewRow();
                    dr["sNobr"] = rb.sNobr.Trim();
                    dr["sNamec"] = rb.sNamec;
                    dr["sJobName"] = rb.sJobName;
                    dr["sDeptCode"] = rb.sDeptCode;
                    dr["sDeptName"] = rb.sDeptName;
                    dt.Rows.Add(dr);
                }
            }
        }

        DataView dv = new DataView(dt);
        dv.Sort = "sDeptCode , sNobr";

        //需要條件
        bool bHave = false;

        //刪除不顯示的欄位
        dt.Columns.Remove("sJobCode");
        //dt.Columns.Remove("sDeptCode");
        dt.Columns.Remove("sDeptPath");

        ////改變欄位名稱
        //dt.Columns["sNobr"].ColumnName = "工號";
        //dt.Columns["sNamec"].ColumnName = "姓名";
        //dt.Columns["sJobName"].ColumnName = "職稱";
        //dt.Columns["sDeptName"].ColumnName = "部門";

        int i = 1; int _len = 0;
        //改變動態欄位名稱，必須有考試資料
        foreach (TsDS.tsQuestionsMRow rqm in oTsDS.tsQuestionsM.Rows)
        {
            if (dt.Columns.Contains(rqm.sCode))
            {
                bHave = false;
                foreach (DataRow r in dt.Rows)
                {
                    if (r[rqm.sCode].ToString().Trim().Length > 0)
                    {
                        bHave = true;
                        break;
                    }
                }

                if (bHave)
                {
                    //遇到同樣的中文名稱
                    if (dt.Columns.Contains(rqm.sName))
                    {
                        dt.Columns[rqm.sCode].ColumnName = rqm.sName + i.ToString();
                        i++;
                    }
                    else
                        dt.Columns[rqm.sCode].ColumnName = rqm.sName;
                    if (rqm.sName.Trim().Length > _len)
                        _len = rqm.sName.Trim().Length;
                }
                else
                    dt.Columns.Remove(rqm.sCode);
            }
        }

        if (dt.Rows.Count > 0)
        {
            int _count = (dt.Columns.Count - 5 > Nds.Tables["rpt_t"].Columns.Count) ? Nds.Tables["rpt_t"].Columns.Count + 5 : dt.Columns.Count;
            DataRow aRow = Nds.Tables["rpt_t"].NewRow();

            for (int j = 5; j < _count; j++)
            {                
                    aRow["Fld" + (j + 1 - 5)] = dt.Columns[j].ToString().Trim();
            }
            Nds.Tables["rpt_t"].Rows.Add(aRow);
            DataRow[] _ORow = dt.Select("", "sDeptCode , sNobr asc");
            foreach (DataRow Row in _ORow)
            {
                DataRow aRow1 = Nds.Tables["rpt_testmange"].NewRow();
                aRow1["nobr"] = Row["snobr"].ToString();
                aRow1["name_c"] = Row["snamec"].ToString();
                aRow1["job_name"] = Row["sjobname"].ToString();
                for (int k = 5; k < _count; k++)
                {                   
                        aRow1["Fld" + (k + 1 - 5)] = Row[dt.Columns[k].ToString()].ToString().Trim();
                }
                Nds.Tables["rpt_testmange"].Rows.Add(aRow1);
            }
            dt = null;
            ReportViewer1.Visible = true;
            ReportViewer1.Reset();
            //Session.Add("PayData", ReportData);
            ReportViewer1.LocalReport.ReportPath = "TestManage1.rdlc";
            ReportViewer1.LocalReport.DataSources.Clear();
            ReportViewer1.LocalReport.SetParameters(new ReportParameter[] { new ReportParameter("Dept", ddlDept.SelectedItem.Text) });
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("SysDS_rpt_testmange", Nds.Tables["rpt_testmange"]));
            ReportViewer1.LocalReport.DataSources.Add(new ReportDataSource("SysDS_rpt_t", Nds.Tables["rpt_t"]));
            ReportViewer1.Width = 800;
            ReportViewer1.ZoomMode = ZoomMode.Percent;
            ReportViewer1.ZoomPercent = 100;
        }
    }
}
