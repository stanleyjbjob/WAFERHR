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

public partial class Reports_Rep004 : System.Web.UI.Page
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
    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {
    }
    protected void GridView7_DataBound(object sender, EventArgs e)
    {

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
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
       // DropDownList1.SelectedValue = ((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim();

    }
}
