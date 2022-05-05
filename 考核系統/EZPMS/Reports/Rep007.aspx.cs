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

public partial class Reports_Rep007 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tb_year.Text = DateTime.Now.Year.ToString();
            tb_seq.Text = "1";
            if (Request.QueryString["deptm"] != null)
            {
                DropDownList1.Visible = false;
                DropDownList1.SelectedValue = ((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM;


            }
        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("yyyy-MM-dd") + ".xls");
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("big5");//設定輸出為中文
        Response.Charset = "";
        //Response.ContentType = "application/ms-excel";
        Response.ContentType = "application/vnd.xls";

        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        GridView7.RenderControl(htmlWrite);
        Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=big5\">");
        string strStyle = "<style>.xlString { mso-number-format:\\@; } </style>";
        Response.Write(strStyle);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void Button1_Click(object sender, EventArgs e) {
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
        GridView7DataBind();
    }


    void GridView7DataBind()
    {

        DataClass dc = new DataClass();
      ArrayList deptal =   dc.getChilDeptM(DropDownList1.SelectedValue);

      EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(DropDownList1.SelectedValue), "");
      if (Request.QueryString["deptm"] != null)
      { dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim()), ""); }

           dt.Columns.Add("b_year", typeof(System.Decimal));
           dt.Columns.Add("o_year", typeof(System.Decimal));
           dt.Columns.Add("effu1");
           dt.Columns.Add("effu2");
           dt.Columns.Add("effu3");
           dt.Columns.Add("effu4");
           dt.Columns.Add("effu5");
           dt.Columns.Add("effu6");
         
           dt.Columns.Add("up_date1");
           dt.Columns.Add("up_jobl1");
           dt.Columns.Add("up_date2");
           dt.Columns.Add("up_jobl2");
           dt.Columns.Add("up_date3");
           dt.Columns.Add("up_jobl3");
           int year = DateTime.Now.Year;
           ArrayList yearal = new ArrayList();
           yearal.Add(year - 5);
           yearal.Add(year - 4);
           yearal.Add(year - 3);
           yearal.Add(year - 2);
           yearal.Add(year - 1);
           yearal.Add(year );

           GridView7.Columns[7].HeaderText = yearal[0].ToString()  ;
           GridView7.Columns[8].HeaderText = yearal[1].ToString()  ;
           GridView7.Columns[9].HeaderText = yearal[2].ToString();
           GridView7.Columns[10].HeaderText = yearal[3].ToString();
           GridView7.Columns[11].HeaderText = yearal[4].ToString();
           GridView7.Columns[12].HeaderText = yearal[5].ToString();
          

           HRDSTableAdapters.EffsTableAdapter effad = new HRDSTableAdapters.EffsTableAdapter();
           HRDSTableAdapters.DataTable1TableAdapter ttsad = new HRDSTableAdapters.DataTable1TableAdapter();


           for (int i = 0; i < dt.Rows.Count; i++)
           {
               EFFDS.EMPINFODataTableRow _emprow = DataClass.getEmpInfo(dt[i].nobr, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
            if (_emprow != null)
            {
                TimeSpan b_year_sp = (TimeSpan)( DateTime.Now-_emprow.BIRDT );
                TimeSpan o_year_sp = (TimeSpan)(DateTime.Now-_emprow.INDT);

                decimal b_year = Math.Round((decimal)(b_year_sp.TotalDays / 365), 1, MidpointRounding.AwayFromZero);
                decimal o_year = Math.Round((decimal)(o_year_sp.TotalDays / 365), 1, MidpointRounding.AwayFromZero);
                dt[i]["b_year"] = b_year;
                dt[i]["o_year"] = o_year;

            }
               HRDS.EffsDataTableDataTable effsdt = effad.GetData(dt[i].nobr);

               for (int j = 1; j <= 6; j++)
               {
                   DataRow[] rows = effsdt.Select("yymm ='" + yearal[j - 1] + "' and EFFTYPE ='1'");
                   if (rows.Length > 0)
                   {
                       dt[i]["effu" + j.ToString()] = rows[0]["EFFLVL"].ToString();
                   }
                   rows = effsdt.Select("yymm ='" + yearal[j - 1] + "' and EFFTYPE ='2'");
                   if (rows.Length > 0)
                   {
                //       dt[i]["effd" + j.ToString()] = rows[0]["EFFLVL"].ToString();
                   }


               }


               HRDS.DataTable1DataTable ttsdt = ttsad.GetData(dt[i].nobr);

               if (ttsdt.Rows.Count > 0)
               {
                   int index = 3;
                   for (int j = 0; j < ttsdt.Rows.Count; j++)
                   {
                       dt[i]["up_date" + index.ToString()] = ttsdt[j].ADATE.ToShortDateString();
                       dt[i]["up_jobl" + index.ToString()] = ttsdt[j].Expr1;

                       if (index == 1)
                       {
                           break;
                       }
                       index--;
                   }
               }

           }

           GridView7.DataSource = dt;
           GridView7.DataBind();
    }
    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Header) 
        {
            
        
        }
    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
     //   DropDownList1.SelectedValue = ((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim();

    }
}
