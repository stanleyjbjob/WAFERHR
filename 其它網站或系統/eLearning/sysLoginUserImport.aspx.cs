using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.IO;

public partial class sysLoginUserImport : System.Web.UI.Page
{
    public SysDSTableAdapters.sysLoginUserTableAdapter sysLoginUserTA = new SysDSTableAdapters.sysLoginUserTableAdapter();
    public SysDSTableAdapters.sysCustomerDataTableAdapter sysCustomerDataTA = new SysDSTableAdapters.sysCustomerDataTableAdapter();

    public SysDS oSysDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        oSysDS = new SysDS();

        lblMsg.Text = "";
    }

    protected void mu_MenuItemClick(object sender, MenuEventArgs e)
    {
        //mv.ActiveViewIndex = int.Parse(e.Item.Value);
        mvMove(0);
        lblMsg.Text = "請一步一步操作";
    }

    protected void btnUpload_Click(object sender, EventArgs e)
    {
        string FileName = "User" + DateTime.Now.Ticks.ToString("X") + ".xls";

        FileUpload file = fu;
        lblMsg.Text += (!file.HasFile) ? "未指定要上傳的檔案," : "";
        lblMsg.Text += (file.PostedFile.ContentLength > (3000 * 1024)) ? "上傳附件檔案不可以超過3MB," : "";
        //lblMsg.Text += (file.PostedFile.ContentType != "application/vnd.ms-excel") ? "檔案格式不正確," : "";

        if (lblMsg.Text.Length == 0)
        {
            lblFileName.Text = file.FileName;
            file.PostedFile.SaveAs(Server.MapPath(".") + "\\Upload\\" + FileName);

            lblMsg.Text = "檔案上傳成功，請選擇工作表";

            Session["ExcelConn"] = "Provider=Microsoft.Jet.OLEDB.4.0;" +
                "Data Source=" + Request.PhysicalApplicationPath + @"Upload\" + FileName + ";" +
                "Extended Properties='Excel 8.0;HDR=No;IMEX=1;Persist Security Info=False'";

            System.Data.OleDb.OleDbConnection ExcelConn = new System.Data.OleDb.OleDbConnection(Session["ExcelConn"].ToString());
            if (ExcelConn.State == ConnectionState.Closed) ExcelConn.Open();
            System.Data.DataTable schemaDt = ExcelConn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            ExcelConn.Close();

            DataTable dt = new DataTable();
            dt.Columns.Add("t", typeof(string));
            dt.Columns.Add("v", typeof(string));

            //工作表選單
            foreach (DataRow dr in schemaDt.Rows)
            {
                DataRow r = dt.NewRow();
                r["t"] = dr.ItemArray[2].ToString().Replace("$", "");
                r["v"] = dr.ItemArray[2].ToString();
                dt.Rows.Add(r);
            }

            BindDDL(ddlSheet, dt);

            mvMove(1);
        }
    }

    protected void btnSheet_Click(object sender, EventArgs e)
    {
        if (Session["ExcelConn"] == null)
        {
            lblMsg.Text = "操作時間過久，請重新上傳檔案";
            mvMove(0);
            return;
        }

        lblMsg.Text = "請選擇相對應的欄位";
        BindLabel(ddlSheet, lblSheetText);

        System.Data.OleDb.OleDbConnection ExcelConn = new System.Data.OleDb.OleDbConnection(Session["ExcelConn"].ToString());
        if (ExcelConn.State == ConnectionState.Closed) ExcelConn.Open();
        System.Data.OleDb.OleDbDataAdapter daExcel = new System.Data.OleDb.OleDbDataAdapter("Select * From [" + lblSheetText.ToolTip + "]", ExcelConn);
        ExcelConn.Close();

        DataTable tbExcel = new DataTable();
        daExcel.Fill(tbExcel);

        DataTable dt = new DataTable();
        dt.Columns.Add("t", typeof(string));
        dt.Columns.Add("v", typeof(string));

        for (int i = 0; i < tbExcel.Columns.Count; i++)
        {
            DataRow row = dt.NewRow();
            row["v"] = tbExcel.Columns[i];
            row["t"] = tbExcel.Rows[0][i];
            dt.Rows.Add(row);
        }

        Session["tbExcel"] = tbExcel;

        BindDDL(ddlNobr, dt);
        BindDDL(ddlName, dt);
        BindDDL(ddlKey, dt);
        BindDDL(ddlBirthday, dt);
        BindDDL(ddlSex, dt);
        BindDDL(ddlTel, dt);
        BindDDL(ddlEmail, dt);

        mvMove(2);
    }

    protected void btnColumns_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "其它選項設定";
        BindLabel(ddlNobr, lblNobrText);
        BindLabel(ddlName, lblNameText);
        BindLabel(ddlKey, lblKeyText);
        BindLabel(ddlBirthday, lblBirthdayText);
        BindLabel(ddlSex, lblSexText);
        BindLabel(ddlTel, lblTelText);
        BindLabel(ddlEmail, lblEmailText);

        mvMove(3);
    }

    protected void btnOther_Click(object sender, EventArgs e)
    {
        lblMsg.Text = "確定以上資訊並核對無誤後開始匯入";
        lblFirstChange.Text = cbFirstChange.Checked ? "要" : "不要";
        lblFirstChange.ToolTip = cbFirstChange.Checked ? "1" : "0";
        lblDayChange.Text = txtDayChange.Text;

        mvMove(4);
    }

    protected void btnImport_Click(object sender, EventArgs e)
    {
        if (Session["tbExcel"] == null)
        {
            lblMsg.Text = "操作時間過久，請重新上傳檔案";
            mvMove(0);
            return;
        }

        sysLoginUserTA.Fill(oSysDS.sysLoginUser);
        sysCustomerDataTA.Fill(oSysDS.sysCustomerData);

        DataTable tbExcel = (DataTable)Session["tbExcel"];
        foreach (DataRow dr in tbExcel.Rows)
        {

            //drC++;
            //if (drC == 1)
            //{
            //    d_no = dr.ItemArray;
            //    continue;
            //}

            //dcC = 1;
            //foreach (DataColumn dc in tbExcel.Columns)
            //{
            //    if (dc.ToString() == "F1") continue;
            //    db.dsIT.itGradeRow r = itGradeDT.NewitGradeRow();
            //    r.sYYMM = lblYYMMv.Text;
            //    r.sDeptGroup = d_no[dcC].ToString();
            //    r.sJoblGroup = dr[lblJoblv.Text].ToString();
            //    r.iIncentive = int.Parse(dr[dc].ToString());
            //    r.sKeyMan = Session["authName"].ToString();
            //    r.dKeyDate = DateTime.Now.Date;
            //    itGradeDT.AdditGradeRow(r);

            //    dcC++;

            //    //加入職等群組
            //    if (itJoblGroupDT.Select("sKey = '" + r.sJoblGroup + "'").Length == 0)
            //    {
            //        db.dsIT.itJoblGroupRow rj = itJoblGroupDT.NewitJoblGroupRow();
            //        rj.sDI = "A";
            //        rj.sCM = "A";
            //        rj.sKey = r.sJoblGroup;
            //        rj.SetsJoblGroupNull();
            //        rj.sKeyMan = Session["authName"].ToString();
            //        rj.dKeyDate = DateTime.Now.Date;
            //        itJoblGroupDT.AdditJoblGroupRow(rj);
            //    }

            //    //加入部門群組
            //    if (itDeptGroupDT.Select("sKey = '" + r.sDeptGroup + "'").Length == 0)
            //    {
            //        db.dsIT.itDeptGroupRow rd = itDeptGroupDT.NewitDeptGroupRow();
            //        rd.sDI = "A";
            //        rd.sCM = "A";
            //        rd.sKey = r.sDeptGroup;
            //        rd.SetsDeptGroupNull();
            //        rd.sKeyMan = Session["authName"].ToString();
            //        rd.dKeyDate = DateTime.Now.Date;
            //        itDeptGroupDT.AdditDeptGroupRow(rd);
            //    }
            //}
        }

    }

    public void BindDDL(DropDownList ddl, DataTable dt)
    {
        ddl.DataSource = dt;
        ddl.DataTextField = "t";
        ddl.DataValueField = "v";
        ddl.DataBind();

        if (ddl.Items.FindByText(ddl.ToolTip) != null)
            ddl.Items.FindByText(ddl.ToolTip).Selected = true;
    }

    public void BindLabel(DropDownList ddl, Label lbl)
    {
        lbl.Text = ddl.SelectedItem.Text;
        lbl.ToolTip = ddl.SelectedItem.Value;        
    }

    public void mvMove(int view)
    {
        mv.ActiveViewIndex = view;
        mu.Items[view].Selected = true;
    }
}