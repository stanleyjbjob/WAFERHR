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

public partial class EmpInfo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {

            if (Request.QueryString["nobr"] != null)
            {
                _nobr.Text = Request.QueryString["nobr"].ToString();
            }
            else
            {
                return;
            }

            RadDatePicker1.SelectedDate = DateTime.Parse(DateTime.Now.Year.ToString() + "/1/1");
            RadDatePicker2.SelectedDate = DateTime.Parse(DateTime.Now.Year.ToString() + "/12/31");
            setAward();
            setAbs();
            setTRData();
            setTRData1();
            setTRData2(); 
            FIELDSET2.Visible = true ;
         
        }
    }

    void setTRData2() 
    {
        try {
            TRDataSet RptDs = new TRDataSet();
            DateTime dateb = RadDatePicker1.SelectedDate.Value;
            DateTime datee = RadDatePicker2.SelectedDate.Value;
            string idno = _nobr.Text;
           
            TRDataSetTableAdapters.RV_TRCOSFTableAdapter rv_trcosf = new TRDataSetTableAdapters.RV_TRCOSFTableAdapter();
            rv_trcosf.Fill_TRCOSF(RptDs.RV_TRCOSF, idno, dateb, datee);
            foreach (DataRow Row in RptDs.RV_TRCOSF.Rows) {
                if (bool.Parse(Row["tr_repo"].ToString()))
                    Row["COSCLNAME"] = "V";
            }
           
            GridView8.DataSource = RptDs.RV_TRCOSF;
            GridView8.DataBind();
           
        }
        catch {
          
        }
    
    }

    void setTRData1() {
        try {
            TRDataSet RptDs = new TRDataSet();
          
            DateTime dateb = RadDatePicker1.SelectedDate.Value;
            DateTime datee = RadDatePicker2.SelectedDate.Value;
            //string idno = "97036";
            string idno = _nobr.Text;
            
            TRDataSetTableAdapters.rv_trtcrdtTableAdapter rv_trtcrdt = new TRDataSetTableAdapters.rv_trtcrdtTableAdapter();
            rv_trtcrdt.Fill_trtcrdt(RptDs.rv_trtcrdt);

            TRDataSetTableAdapters.rv_trattTableAdapter rv_tratt = new TRDataSetTableAdapters.rv_trattTableAdapter();
            rv_tratt.Fill_TRATT(RptDs.rv_tratt, idno, dateb, datee);
            foreach (DataRow Row in RptDs.rv_tratt.Rows) {
                if (bool.Parse(Row["homework"].ToString()))
                    Row["COSCLNAME"] = "V";
                if (Row["selcode"].ToString().Trim() == "1")
                    Row["selcodename"] = "必修";
                else
                    Row["selcodename"] = "選修";

                string str_coscode = Row["coscode"].ToString();
                string str_yymm = Row["yymm"].ToString();
                string str_ser = Row["ser"].ToString();
                DataRow[] row = RptDs.rv_trtcrdt.Select("coscode='" + str_coscode + "' and yymm='" + str_yymm + "' and ser='" + str_ser + "'");
                foreach (DataRow Row1 in row) {
                    Row["tcr_name"] += Row1["tcr_name"].ToString() + ";";
                }
                if (Row["tcr_name"].ToString().Length > 0)
                    Row["tcr_name"] = Row["tcr_name"].ToString().Substring(0, Row["tcr_name"].ToString().Length - 1);

            }

            TRDataSetTableAdapters.RV_TRCOSFTableAdapter rv_trcosf = new TRDataSetTableAdapters.RV_TRCOSFTableAdapter();
            rv_trcosf.Fill_TRCOSF(RptDs.RV_TRCOSF, idno, datee, datee);
            foreach (DataRow Row in RptDs.RV_TRCOSF.Rows) {
                TRDataSet.rv_trattRow aRow = RptDs.rv_tratt.Newrv_trattRow();
                aRow.SUBCODE = Row["tr_type"].ToString();
                aRow.DESCR = Row["course"].ToString();
                aRow.COSDATEB = DateTime.Parse(Row["date_b"].ToString());
                aRow.COSDATEE = DateTime.Parse(Row["date_e"].ToString());
                aRow.HOURS = double.Parse(Row["tr_hrs"].ToString());
                aRow.ABSHRS = decimal.Parse(Row["at_hrs"].ToString());
                aRow.ADDRDESCR = Row["tr_comp"].ToString();
                if (bool.Parse(Row["tr_repo"].ToString()))
                    aRow.COSCLNAME = "V";
                aRow.TR_ASNAME = Row["tr_asname"].ToString();
                aRow.IDNO = Row["idno"].ToString();
                aRow.NAME_C = Row["name_c"].ToString();
                aRow.SELCODE = "";
                aRow.COSCLOSE = bool.Parse(Row["CLOSE_"].ToString());
                aRow.PREFEE = int.Parse(Row["cos_fee"].ToString());
                aRow.SCORE = 0;
                aRow.TCR_NAME = "";
                aRow.HOMEWORK = false;
                RptDs.rv_tratt.Addrv_trattRow(aRow);
            }
         
            GridView7.DataSource = RptDs.rv_tratt;
            GridView7.DataBind();
            
        }
        catch {
        
        }
    }

    void setTRData() {
        TRDataSet RptDs = new TRDataSet();
        string idno = _nobr.Text;
        string _year = Convert.ToString(DateTime.Now.Year - 1911).PadLeft(3, '0');
       

        TRDataSetTableAdapters.rv_trjbsetcTableAdapter rv_trjbsetc = new TRDataSetTableAdapters.rv_trjbsetcTableAdapter();
        rv_trjbsetc.Fill_rv_trjbsetc(RptDs.rv_trjbsetc, idno);

        TRDataSetTableAdapters.TRYEARPATableAdapter rv_tyearpa = new TRDataSetTableAdapters.TRYEARPATableAdapter();
        rv_tyearpa.Fill_tryearpa(RptDs.TRYEARPA, _year);

        foreach (DataRow Row in RptDs.rv_trjbsetc.Rows) {
            DataRow[] row = RptDs.TRYEARPA.Select("coscode='" + Row["coscode"].ToString() + "'");
            if (row.Length < 1)
                Row.Delete();
        }
        RptDs.rv_trjbsetc.AcceptChanges();
        
        GridView6.DataSource = RptDs.rv_trjbsetc;
        GridView6.DataBind();
    
    }

    void setAbs() 
    {
        DataTable ds = DataClass.getabs(_nobr.Text, RadDatePicker1.SelectedDate.Value.ToShortDateString(), RadDatePicker2.SelectedDate.Value.ToShortDateString());
        object o1 = ds.Compute("sum(tol_hours)", "h_code='A'");
        object o2 = ds.Compute("sum(tol_hours)", "h_code='C'");
        object o3 = ds.Compute("sum(tol_hours)", "h_code='B'");
        object o4 = ds.Compute("sum(tol_hours)", "h_code='K'");
        object o5 = ds.Compute("sum(tol_hours)", "h_code='M'");


        Label12.Text = o1.ToString();
        Label13.Text = o2.ToString();
        Label14.Text = o3.ToString();
        Label15.Text = o4.ToString();
        Label16.Text = o5.ToString();
        if (Label12.Text.Trim().Length == 0) Label12.Text = "0 天"; else Label12.Text += " 天";
        if (Label13.Text.Trim().Length == 0) Label13.Text = "0 小時"; else Label13.Text += " 小時";
        if (Label14.Text.Trim().Length == 0) Label14.Text = "0 小時"; else Label14.Text += " 小時";
        if (Label15.Text.Trim().Length == 0) Label15.Text = "0 小時"; else Label15.Text += " 小時";
        if (Label16.Text.Trim().Length == 0) Label16.Text = "0 小時"; else Label16.Text += " 小時";
    
    }

    void setAward() 
    {
        DataTable dt = DataClass.getaward(_nobr.Text, RadDatePicker1.SelectedDate.Value.ToShortDateString(), RadDatePicker2.SelectedDate.Value.ToShortDateString());
        GridView5.DataSource = dt;
        GridView5.DataBind();
        for (int i = 0; i < dt.Rows.Count; i++)
        {
            if (decimal.Parse(dt.Rows[i]["award1"].ToString()) != 0)
            {
                award1.Text = Convert.ToString(int.Parse(award1.Text) + int.Parse(dt.Rows[i]["award1"].ToString()));
            }
            else if (decimal.Parse(dt.Rows[i]["award2"].ToString()) != 0)
            {
                award2.Text = Convert.ToString(int.Parse(award2.Text) + int.Parse(dt.Rows[i]["award2"].ToString()));
            }
            else if (decimal.Parse(dt.Rows[i]["award3"].ToString()) != 0)
            {
                award3.Text = Convert.ToString(int.Parse(award3.Text) + int.Parse(dt.Rows[i]["award3"].ToString()));
            }
            else if (decimal.Parse(dt.Rows[i]["fault1"].ToString()) != 0)
            {
                fault1.Text = Convert.ToString(int.Parse(fault1.Text) + int.Parse(dt.Rows[i]["fault1"].ToString()));
            }
            else if (decimal.Parse(dt.Rows[i]["fault2"].ToString()) != 0)
            {
                fault2.Text = Convert.ToString(int.Parse(fault2.Text) + int.Parse(dt.Rows[i]["fault2"].ToString()));
            }
            else if (decimal.Parse(dt.Rows[i]["fault3"].ToString()) != 0)
            {
                fault3.Text = Convert.ToString(int.Parse(fault3.Text) + int.Parse(dt.Rows[i]["fault3"].ToString()));
            }
        }
    
    
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        setAward();
        setAbs();
        setTRData();
        setTRData1();
        setTRData2(); 
    }
    decimal educount1 = 0, educount2 = 0, educount3 = 0, educount4 = 0;

    protected void GridView2_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow) 
        {
            try { educount1 += decimal.Parse(e.Row.Cells[4].Text); }
            catch { }
            try { educount2 += decimal.Parse(e.Row.Cells[7].Text); }
            catch { }
            try { educount3 += decimal.Parse(e.Row.Cells[5].Text); }
            catch { }
            try { educount4 += decimal.Parse(e.Row.Cells[6].Text); }
            catch { }
        
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {

            e.Row.Cells[4].Text = educount1.ToString();
            e.Row.Cells[5].Text = educount3.ToString();
            e.Row.Cells[6].Text = educount4.ToString();
            e.Row.Cells[7].Text = educount2.ToString();
            e.Row.Cells[0].Text = "總計：";
        }

    }
    decimal deu1count = 0;
  
    protected void GridView1_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try { deu1count += decimal.Parse(e.Row.Cells[2].Text); }
            catch { }
           

        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[0].Text = "總計：";
            e.Row.Cells[2].Text = deu1count.ToString();
        }

    }
    protected void GridView2_DataBound(object sender, EventArgs e)
    {
        to_hours.Text = Convert.ToString(deu1count + educount1);
    }
    int itemIndex = 0;
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item) {
            if (itemIndex == 0)
            {
                HtmlTable ht = (HtmlTable)e.Item.FindControl("TABLE2");
                ht.Visible = true;
            }
            itemIndex++;
        
        }
    }
    protected void GridView6_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.DataRow) 
        {
            string code = e.Row.Cells[4].Text;
            TRDataSetTableAdapters.rv_trattTableAdapter trattad = new TRDataSetTableAdapters.rv_trattTableAdapter();
            TRDataSet.rv_trattDataTable trattdt = trattad.GetDataByCode(_nobr.Text, DateTime.Parse("1911/1/1"),
                RadDatePicker2.SelectedDate.Value, code);
            if (trattdt.Rows.Count > 0) {
                e.Row.Cells[e.Row.Cells.Count - 1].Text = "○";
            }
            else {
                e.Row.Cells[e.Row.Cells.Count - 1].Text = "╳";
            }
        
        
        }
    }
}
