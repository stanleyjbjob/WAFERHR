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

public partial class Reports_Rep008 : System.Web.UI.Page
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
    void GridView7DataBind()
    {
        if (Session["empInfo"] != null) {
            string[] values = dll_attend.SelectedValue.Split(',');
            tb_year.Text = values[0];
            tb_seq.Text = values[1];
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];


            DataClass dc = new DataClass();
            EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(DropDownList1.SelectedValue), "");
            if (Request.QueryString["deptm"] != null)
            { dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim()), ""); }

            dt.Columns.Add("apprratenum");
            dt.Columns.Add("cateratenum");
            dt.Columns.Add("totnum");
            dt.Columns.Add("effs");
            dt.Columns.Add("sort");
            dt.Columns.Add("effs_a1", typeof(decimal));
            dt.Columns.Add("effs_b1", typeof(decimal));
            dt.Columns.Add("effs_c1", typeof(decimal));
            dt.Columns.Add("effs_d1");
            dt.Columns.Add("effs_a", typeof(decimal));
            dt.Columns.Add("effs_b", typeof(decimal));
            dt.Columns.Add("effs_c", typeof(decimal));
            dt.Columns.Add("effs_d");
            dt.Columns.Add("effs_e", typeof(int));
            dt.Columns.Add("effs_f", typeof(decimal));
            dt.Columns.Add("effs_g");
            int yy = int.Parse(tb_year.Text);
            int seq = int.Parse(tb_seq.Text);


            for (int i = 0; i < dt.Rows.Count; i++)
            {
                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(dt[i].nobr, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
                HRDS.DeptAMangDataTableDataTable mangdt = null;
                HRDS.DeptAMangDataTableRow mrow = null;

                if (emprow != null)
                {
                    mangdt = DataClass.getempMang(emprow.DEPTM, emprow.MANG, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
                    if (mangdt.Rows.Count == 1)
                    {
                        mrow = mangdt[0];
                    }
                    else
                    {
                        for (int j = 0; j < mangdt.Rows.Count; j++)
                        {
                            if (mangdt[j].cate_order >= 50)
                            {
                                mrow = mangdt[j];
                                break;
                            }
                        }

                    }

                    if (mrow == null)
                        continue;

                }
                else
                {
                    continue;
                }



                EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, true, dt[i].nobr, dt[i].templetID, "A001", "B001", "A001", mrow.NOBR);
                EFFMANGDS.EFFS_NUMRow selfrow = DataClass.getEFFSELENUM(yy, seq, true, dt[i].nobr, dt[i].templetID, "A001", "B001", "A001");

                dt[i]["effs_a"] = Convert.ToString(Math.Round(mangrow.apprratenum, 1));
                dt[i]["effs_b"] = Convert.ToString(Math.Round(mangrow.cateratenum, 1));
                dt[i]["effs_c"] = Convert.ToString(Math.Round(mangrow.totnum, 1));


                if ((int)mangrow.totnum == 0)
                {
                    dt[i]["effs_d"] = "未評";
                }
                else
                {
                    dt[i]["effs_d"] = mangrow.effs;
                }
                dt[i]["effs_e"] = 0;

                if (dt[i].IseffsfinallyNull())
                {
                    dt[i]["effs_f"] = Convert.ToString(Math.Round(mangrow.totnum, 1));
                    dt[i]["effs_g"] = mangrow.effs;
                }
                else
                {
                    try
                    {
                        dt[i]["effs_f"] = decimal.Parse(dt[i].effsfinally);
                        dt[i]["effs_g"] = DataClass.getEffsTitle(decimal.Parse(dt[i].effsfinally), "A001");
                    }
                    catch { }
                }


                dt[i]["effs_a1"] = Convert.ToString(Math.Round(selfrow.apprratenum, 1));
                dt[i]["effs_b1"] = Convert.ToString(Math.Round(selfrow.cateratenum, 1));
                dt[i]["effs_c1"] = Convert.ToString(Math.Round(selfrow.totnum, 1));

                if ((int)selfrow.totnum == 0)
                {
                    dt[i]["effs_d1"] = "未評";
                }
                else
                {
                    dt[i]["effs_d1"] = selfrow.effs;
                }
            }


            DataRow[] numrow = dt.Select("effs_f>0", "effs_f desc");

            int _placing = 0;
            decimal _num = 0;

            for (int i = 0; i < numrow.Length; i++)
            {
                if (decimal.Parse(numrow[i]["effs_f"].ToString()) != _num)
                {
                    try
                    {
                        _num = decimal.Parse(numrow[i]["effs_f"].ToString());
                        _placing = i + 1;
                        numrow[i]["effs_e"] = _placing;
                    }
                    catch { }
                }
                else
                {
                    try
                    {
                        numrow[i]["effs_e"] = _placing;
                    }
                    catch { }
                }

            }

            DataView dv = dt.DefaultView;





            GridView7.DataSource = dv;
            GridView7.DataBind();

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView7DataBind();
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
    protected void leanplanGridView_RowDataBound(object sender, GridViewRowEventArgs e) {
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb = (Label)e.Row.FindControl("planID");
            Label ftb = (Label)e.Row.FindControl("PlanText");
            //Label4
            Label ll = (Label)e.Row.FindControl("Label4");
            EFFDS.EFFS_SELFLEARNPLANRow row = DataClass.getSELFLEARNPLANRow(tb_year.Text, tb_seq.Text, ll.Text, lb.Text);
            if (row != null)
            {
                ftb.Text = row.note;
            }
        }
    }
    protected void GridView7_DataBound(object sender, EventArgs e)
    {

    }
    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
       // DropDownList1.SelectedValue = ((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim();

    }
    double _rotecount = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (e.Row.RowType == DataControlRowType.Footer) {
            e.Row.Cells[5].Text = "年度比重總分：";
            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[5].ForeColor = System.Drawing.Color.White;
            e.Row.Cells[5].Font.Bold = true;
            e.Row.Cells[7].Text = _rotecount.ToString("0") + "%";
            e.Row.Cells[7].ForeColor = System.Drawing.Color.Red;
            e.Row.Cells[7].Font.Bold = true;
            _rotecount = 0;
        }

        if (e.Row.RowType == DataControlRowType.Header) {
            e.Row.Cells[3].ColumnSpan += 2;
            e.Row.Cells[4].Visible = false;
        }

        if (e.Row.RowType == DataControlRowType.DataRow) {
            Label autoKey = (Label)e.Row.FindControl("autoKey");

            if (DataClass.checkApprTts(int.Parse(autoKey.Text))) {
                e.Row.Cells[5].Font.Italic = true;
                e.Row.Cells[7].Font.Italic = true;
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[7].ForeColor = System.Drawing.Color.Red;

            }
            EFFDS.EFFS_APPRRow approw = DataClass.getEFFS_APPRRow(int.Parse(autoKey.Text));
            if (!approw.IsrealityNull() && approw.reality.Trim().Equals("True")) {
                e.Row.Cells[5].Font.Italic = true;
                e.Row.Cells[7].Font.Italic = true;
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Blue;
                e.Row.Cells[7].ForeColor = System.Drawing.Color.Blue;

            }





            Label tb_rate = (Label)e.Row.FindControl("Label1");

            if (tb_rate != null) {
                try {
                    _rotecount += double.Parse(tb_rate.Text);
                }
                catch { }
            }
         //   _ratenum.Text = _rotecount.ToString("0.0");
         //   CheckBox cb_mangCheck = (CheckBox)e.Row.FindControl("cb_mangCheck");

         //   if (cb_mangCheck.Checked) {
          //      Button delBtn = (Button)e.Row.FindControl("delBtn");
          //      if (delBtn != null)
           //         delBtn.Enabled = false;
          //  }
            //if (bool.Parse(Session["isOver"].ToString())) {
            //    Button delBtn = (Button)e.Row.FindControl("delBtn");
            //    if (delBtn != null)
            //        delBtn.Enabled = false;
            //}

        }
    }
}
