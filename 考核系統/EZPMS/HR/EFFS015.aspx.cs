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
using System.Drawing;

public partial class HR_EFFS015 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

          showMsg.Text = "";
    }
    protected void RolloverButton2_Click(object sender, EventArgs e) {

        string filename = "";
        string _filename = "";
        string conn = "";
        filename = "temps" + ".xls";
  

        if (!txtUpload.HasFile) {
            showMsg.Text = "未指定要上傳的檔案";
            return;
        }
        try {
            txtUpload.PostedFile.SaveAs(Page.Server.MapPath(".") + filename);
            _filename = txtUpload.FileName;
            showMsg.ForeColor = Color.Blue;
            showMsg.Text = "上傳成功！資料匯入前，請先設定下列項目。";

        
            conn = "Provider=Microsoft.Jet.OLEDB.4.0;" +
               "Data Source=" + Page.Server.MapPath(".") + filename + ";" +
            "Extended Properties='Excel 8.0;HDR=NO;IMEX=1'";
            Session.Add("ExcelConn", conn);
        }
        catch (System.Exception ex) {
            showMsg.ForeColor = Color.Red;
            showMsg.Text = "上傳失敗！  原因：" + ex.ToString();
            return;
        }
        System.Data.OleDb.OleDbConnection ExcelConn = new System.Data.OleDb.OleDbConnection(conn);
        try {
            ArrayList al = new ArrayList();
            if (ExcelConn.State == ConnectionState.Closed)
                ExcelConn.Open();

            System.Data.DataTable schemaDt = ExcelConn.GetOleDbSchemaTable(System.Data.OleDb.OleDbSchemaGuid.Tables, new object[] { null, null, null, "TABLE" });
            Menu1.Items.Clear();
            for (int i = 0; i < schemaDt.Rows.Count; i++) {
                al.Add(schemaDt.Rows[i].ItemArray[2].ToString());
                Menu1.Items.Add(new System.Web.UI.WebControls.MenuItem(schemaDt.Rows[i].ItemArray[2].ToString(), schemaDt.Rows[i].ItemArray[2].ToString()));
            }
            setValue(ExcelConn, Menu1.Items[0].Value);

            Menu1.Items[0].Selected = true;

            if (ExcelConn.State == ConnectionState.Open)
                ExcelConn.Close();



        }
        catch (Exception ex) {
            showMsg.ForeColor = Color.Red;
            showMsg.Text = ExcelConn.ConnectionString + "     " + ex.ToString();
            return;
        }
        finally {
            ExcelConn.Close();
        }
    }

    void setValue(System.Data.OleDb.OleDbConnection ExcelConn, string sheet) {
        System.Data.OleDb.OleDbDataAdapter daExcel = new System.Data.OleDb.OleDbDataAdapter("Select * From [" + sheet + "]", ExcelConn);
        System.Data.DataTable tbExcel = new System.Data.DataTable();
        daExcel.Fill(tbExcel);

        System.Data.DataTable dt = new System.Data.DataTable();
        dt.Columns.Add("text", typeof(string));
        dt.Columns.Add("values", typeof(string));

        for (int i = 0; i < tbExcel.Columns.Count; i++) {
            DataRow row = dt.NewRow();
            row["values"] = tbExcel.Columns[i].ToString();
            row["text"] = tbExcel.Rows[0][i].ToString();
            dt.Rows.Add(row);
        }


        DDL1.DataSource = dt;
        DDL1.DataTextField = "text";
        DDL1.DataValueField = "values";
        DDL1.DataBind();
        DDL2.DataSource = dt;
        DDL2.DataTextField = "text";
        DDL2.DataValueField = "values";
        DDL2.DataBind();
        DDL3.DataSource = dt;
        DDL3.DataTextField = "text";
        DDL3.DataValueField = "values";
        DDL3.DataBind();
       
        DDL5.DataSource = dt;
        DDL5.DataTextField = "text";
        DDL5.DataValueField = "values";
        DDL5.DataBind();
        DDL6.DataSource = dt;
        DDL6.DataTextField = "text";
        DDL6.DataValueField = "values";
        DDL6.DataBind();
        DDL7.DataSource = dt;
        DDL7.DataTextField = "text";
        DDL7.DataValueField = "values";
        DDL7.DataBind();
        DDL8.DataSource = dt;
        DDL8.DataTextField = "text";
        DDL8.DataValueField = "values";
        DDL8.DataBind();
     

        //	btnSubmit.Enabled = true;
        Session.Add("ExcelDT", tbExcel);
        Session["dt"] = dt;
        GridView1.DataSource = tbExcel;
        GridView1.DataBind();

    }
    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e) {


    }



    protected void ExportButton_Click(object sender, EventArgs e) {
        TextBox1.Text = "";
        System.Data.DataTable ExcelDT = (System.Data.DataTable)Session["ExcelDT"];
            

        for (int i = 1; i < ExcelDT.Rows.Count; i++) {
            try {
                    SaveAbs(ExcelDT.Rows[i]);
            }
            catch (Exception ex) {
                TextBox1.Text += "資料錯誤，訊息為：" + ex.Message + "\n";
            }
        }

       
        TextBox1.Text += "匯入完成！\n";
    }

    EFFDSTableAdapters.EFFS_APPRTableAdapter apprad = new EFFDSTableAdapters.EFFS_APPRTableAdapter();

    void SaveAbs(DataRow row) {
        try {
            EFFDS.EFFS_APPRDataTable apprdt = new EFFDS.EFFS_APPRDataTable();
            EFFDS.EFFS_APPRRow newrow = apprdt.NewEFFS_APPRRow();
            newrow.yy = int.Parse(row[DDL1.SelectedValue].ToString());
            newrow.seq = int.Parse(row[DDL2.SelectedValue].ToString());
            newrow.nobr = row[DDL3.SelectedValue].ToString();
            newrow.standard = row[DDL5.SelectedValue].ToString();
            newrow.works = row[DDL6.SelectedValue].ToString();
            newrow.rate = row[DDL7.SelectedValue].ToString();
            newrow.appr = row[DDL8.SelectedValue].ToString();
            newrow.key_date = DateTime.Now;
            newrow.mangCheck = false;
            newrow.included = false;
            apprdt.AddEFFS_APPRRow(newrow);
            apprad.Update(apprdt);
        }
        catch (Exception ex) {
            TextBox1.Text += row[DDL3.SelectedValue].ToString() + ",匯入資料有問題：" + row[DDL6.SelectedValue].ToString()+",資料錯誤，訊息為：" + ex.Message + "\n";
          
        }
    }

    protected void Button1_Click(object sender, EventArgs e) {
        TextBox1.Text = "";
        System.Data.DataTable ExcelDT = (System.Data.DataTable)Session["ExcelDT"];


        for (int i = 1; i < ExcelDT.Rows.Count; i++) {
            try {
                Delete(ExcelDT.Rows[i]);
            }
            catch (Exception ex) {
                TextBox1.Text += "資料錯誤，訊息為：" + ex.Message + "\n";
            }
        }


        TextBox1.Text += "匯入完成！\n";
    }

    void Delete(DataRow row) 
    {
        try {
            EFFDS.EFFS_APPRDataTable apprdt = apprad.GetDataByNobrYearSeq(row[DDL3.SelectedValue].ToString(), int.Parse(row[DDL1.SelectedValue].ToString()), int.Parse(row[DDL2.SelectedValue].ToString()));
            int count = apprdt.Rows.Count-1;

            for (int i = count; i >= 0; i--) {
                apprdt[i].Delete();
                apprad.Update(apprdt);
            }
            
            
           
        }
        catch (Exception ex) {
            TextBox1.Text += row[DDL3.SelectedValue].ToString() + ",刪除資料有問題：" + row[DDL6.SelectedValue].ToString() + ",資料錯誤，訊息為：" + ex.Message + "\n";

        }
    
    }
    protected void Button2_Click(object sender, EventArgs e) {
        EFFDSTableAdapters.QueriesApprTableAdapter qtad = new EFFDSTableAdapters.QueriesApprTableAdapter();
        qtad.UpdateMangOkQuery();
        showMsg.Text = "OK";
        return;

    }
    protected void Button3_Click(object sender, EventArgs e) {
        EFFDSTableAdapters.QueriesApprTableAdapter qtad = new EFFDSTableAdapters.QueriesApprTableAdapter();
        qtad.UpdateMangNotOKQuery();
        showMsg.Text = "OK";
        return;
    }
}
