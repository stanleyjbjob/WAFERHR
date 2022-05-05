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
using CrystalDecisions.CrystalReports.Engine;
using CrystalDecisions.Shared;


public partial class rpTestManage1 : System.Web.UI.Page
{
    private TsDSTableAdapters.tsQuestionsMTableAdapter tsQuestionsMTA = new TsDSTableAdapters.tsQuestionsMTableAdapter();
    private TsDSTableAdapters.tsBaseMTableAdapter tsBaseMTA = new TsDSTableAdapters.tsBaseMTableAdapter();
    private SysDSTableAdapters.BaseTtsTableAdapter BaseTtsTA = new SysDSTableAdapters.BaseTtsTableAdapter();

    private TsDS oTsDS;
    private SysDS oSysDS;

    private DataRow[] rows, rows1;
    ReportDocument Rptd = new ReportDocument();

    protected void Page_Load(object sender, EventArgs e)
    {
        oTsDS = new TsDS();
        oSysDS = new SysDS();
       
        if (!IsPostBack)
        {
            CrystalReportViewer1.Visible = false;           
            txtDate.Text = DateTime.Now.ToString("yyyy/MM/dd");
            txtDateB.Text = DateTime.Now.AddDays(-183).ToString("yyyy/MM/dd");
            txtDateE.Text = "9999/12/31";
           
        }
        else
        {
            if (Session["Rds"] != null)
            {
                Rptd.Load(Server.MapPath("TestManage.rpt"));
                Rptd.SetDataSource(Session["Rds"]);

                CrystalReportViewer1.ReportSource = Rptd;
                ParameterValues ObjectArray = new ParameterValues();
                ObjectArray = Rptd.DataDefinition.ParameterFields["ObjectName"].CurrentValues;
                ParameterDiscreteValue ObjectName = new ParameterDiscreteValue();
                ObjectName.Value = ddlDept.SelectedItem.Text;
                ObjectArray.Add(ObjectName);
                Rptd.DataDefinition.ParameterFields["ObjectName"].ApplyCurrentValues(ObjectArray);
            }           
        }
        
    }

    protected void CrystalReportViewer1_Unload(object sender, EventArgs e)
    {
        Rptd.Close();
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

                foreach (TsDS.tsQuestionsMRow rqm in dvQuestionsM.Table.Rows)
                {
                    rows1 = oTsDS.tsBaseM.Select("sNobr = '" + rbm.sNobr + "' AND tsQuestionsM_sCode = '" + rqm.sCode + "'", "dAmountDate DESC");
                    if (rows1.Length > 0)
                    {
                        rbm1 = rows1[0] as TsDS.tsBaseMRow;
                        dr[rqm.sCode] = rbm1.tsTitle_sCode;
                    }
                }

                //依部門&工號查詢
                if (rows.Length > 0 && (sDeptCode == "0" || dr["sDeptCode"].ToString() == sDeptCode) && (sNobr.Length == 0 || sNobr == dr["sNobr"].ToString()))
                    dt.Rows.Add(dr);

                ht.Add(rbm.sNobr, rbm.sNobr);
            }
        }

        DataView dv = new DataView(dt);
        dv.Sort = "sDeptCode , sNobr";

        //需要條件
        bool bHave = false;

        //刪除不顯示的欄位
        dt.Columns.Remove("sJobCode");
        dt.Columns.Remove("sDeptCode");
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
            int _count = (dt.Columns.Count - 4 > Nds.Tables["rpt_t"].Columns.Count) ? Nds.Tables["rpt_t"].Columns.Count + 4 : dt.Columns.Count;
            DataRow aRow = Nds.Tables["rpt_t"].NewRow();

            for (int j = 4; j < _count; j++)
            {
                aRow["Fld" + (j + 1 - 4)] = dt.Columns[j].ToString().Trim();
            }
            Nds.Tables["rpt_t"].Rows.Add(aRow);

            foreach (DataRow Row in dt.Rows)
            {
                DataRow aRow1 = Nds.Tables["rpt_testmange"].NewRow();
                aRow1["nobr"] = Row["snobr"].ToString();
                aRow1["name_c"] = Row["snamec"].ToString();
                aRow1["job_name"] = Row["sjobname"].ToString();
                for (int k = 4; k < _count; k++)
                {
                    aRow1["Fld" + (k + 1 - 4)] = Row[dt.Columns[k].ToString()].ToString().Trim();
                }
                Nds.Tables["rpt_testmange"].Rows.Add(aRow1);
            }
            dt = null;
            Session.Add("Rds", Nds);
            CrystalReportViewer1.Visible = true;
            Rptd.Load(Server.MapPath("TestManage.rpt"));
            Rptd.SetDataSource(Session["Rds"]);


            CrystalReportViewer1.ReportSource = Rptd;
            ParameterValues ObjectArray = new ParameterValues();
            ObjectArray = Rptd.DataDefinition.ParameterFields["ObjectName"].CurrentValues;
            ParameterDiscreteValue ObjectName = new ParameterDiscreteValue();
            ObjectName.Value = ddlDept.SelectedItem.Text;
            ObjectArray.Add(ObjectName);
            Rptd.DataDefinition.ParameterFields["ObjectName"].ApplyCurrentValues(ObjectArray);

        }
        else
            CrystalReportViewer1.Visible = false;
    }
}
