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

public partial class Reports_Rep002 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tb_year.Text = DateTime.Now.Year.ToString();
            tb_seq.Text = "1";
            //adate.Text = DateTime.Now.ToShortDateString();


            if (Request.QueryString["deptm"] != null)
            {


                ViewState["topMang"] = false;
                DropDownList1.Enabled = false;
                DropDownList1.SelectedValue = ((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM;
                Button4.Visible = false;

            }
            else
            {
                ViewState["topMang"] = true;
            }


        }

    }
    protected void GridView7_DataBound(object sender, EventArgs e)
    {

    }
    void GridView7DataBind()
    {
        if (Session["empInfo"] != null)
        {
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
                string __Date = DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString();
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
                //  dt[i]["effs_g"] = emprow.DEPTM;
            }
            //mrow.NOBR

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
    decimal t_effs_a1_ = 0, t_effs_b1_ = 0, t_effs_c1_ = 0;
    decimal t_effs_a_ = 0, t_effs_b_ = 0, t_effs_c_ = 0;
    decimal t_count = 0, t_count_a = 0;
    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            t_count++;
            Label lb = (Label)e.Row.FindControl("_nobr");
            Label effs_a1_ = (Label)e.Row.FindControl("effs_a1");
            Label effs_b1_ = (Label)e.Row.FindControl("effs_b1");
            Label effs_c1_ = (Label)e.Row.FindControl("effs_c1");
            Label effs_d1_ = (Label)e.Row.FindControl("effs_d1");
            Label effs_a_ = (Label)e.Row.FindControl("effs_a");
            Label effs_b_ = (Label)e.Row.FindControl("effs_b");
            Label effs_c_ = (Label)e.Row.FindControl("effs_c");
            Label effs_d_ = (Label)e.Row.FindControl("effs_d");
            Label effs_e_ = (Label)e.Row.FindControl("effs_e");
            Label effs_f_ = (Label)e.Row.FindControl("effs_f");
            Label effs_g_ = (Label)e.Row.FindControl("effs_g");
            Label effs_x_ = (Label)e.Row.FindControl("effs_x");
            Label effs_y_ = (Label)e.Row.FindControl("effs_y");


            try
            {


                t_effs_a_ += decimal.Parse(effs_a_.Text);
                t_effs_b_ += decimal.Parse(effs_b_.Text);
                t_effs_c_ += decimal.Parse(effs_c_.Text);
                t_effs_a1_ += decimal.Parse(effs_a1_.Text);
                t_effs_b1_ += decimal.Parse(effs_b1_.Text);
                t_effs_c1_ += decimal.Parse(effs_c1_.Text);
                t_count_a += decimal.Parse(effs_f_.Text);
                effs_x_.Text = effs_f_.Text;

                effs_y_.Text = effs_g_.Text;

            }
            catch { }


            effs_a_.ForeColor = System.Drawing.Color.Blue;
            effs_b_.ForeColor = System.Drawing.Color.Blue;
            effs_c_.ForeColor = System.Drawing.Color.Blue;
            effs_d_.ForeColor = System.Drawing.Color.Blue;
            effs_e_.ForeColor = System.Drawing.Color.Red;
            effs_f_.ForeColor = System.Drawing.Color.Red;
            effs_g_.ForeColor = System.Drawing.Color.Red;






        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label effs_a1_f = (Label)e.Row.FindControl("effs_a1_f");
            Label effs_b1_f = (Label)e.Row.FindControl("effs_b1_f");
            Label effs_c1_f = (Label)e.Row.FindControl("effs_c1_f");
            Label effs_d1_f = (Label)e.Row.FindControl("effs_d1_f");

            Label effs_a_f = (Label)e.Row.FindControl("effs_a_f");
            Label effs_b_f = (Label)e.Row.FindControl("effs_b_f");
            Label effs_c_f = (Label)e.Row.FindControl("effs_c_f");
            Label effs_d_f = (Label)e.Row.FindControl("effs_d_f");
            Label effs_f_f = (Label)e.Row.FindControl("effs_f_f");
            Label effs_g_f = (Label)e.Row.FindControl("effs_g_f");

            Label effs_x_f = (Label)e.Row.FindControl("effs_x_f");
            Label effs_y_f = (Label)e.Row.FindControl("effs_y_f");


            effs_a_f.Text = Convert.ToString(Math.Round(t_effs_a_ / t_count, 1));
            effs_b_f.Text = Convert.ToString(Math.Round(t_effs_b_ / t_count, 1));
            effs_c_f.Text = Convert.ToString(Math.Round(t_effs_c_ / t_count, 1));
            if ((int)t_effs_c_ == 0)
            {
                effs_d_f.Text = "未評";
            }
            else
            {
                effs_d_f.Text = DataClass.getEffsTitle((decimal)(t_effs_c_ / t_count), "A001");
            }
            effs_f_f.Text = Convert.ToString(Math.Round((decimal)(t_count_a / t_count), 1));

            effs_g_f.Text = DataClass.getEffsTitle(Math.Round(decimal.Parse(effs_f_f.Text), 1), "A001");
            effs_x_f.Text = effs_f_f.Text;
            effs_y_f.Text = effs_g_f.Text;

            effs_a1_f.Text = Convert.ToString(Math.Round(t_effs_a1_ / t_count, 1));
            effs_b1_f.Text = Convert.ToString(Math.Round(t_effs_b1_ / t_count, 1));
            effs_c1_f.Text = Convert.ToString(Math.Round(t_effs_c1_ / t_count, 1));
            if ((int)t_effs_c1_ == 0)
            {
                effs_d1_f.Text = "未評";
            }
            else
            {
                effs_d1_f.Text = DataClass.getEffsTitle(Math.Round((decimal)(t_effs_c1_ / t_count), 1), "A001");
            }
            effs_a_f.ForeColor = System.Drawing.Color.Blue;
            effs_b_f.ForeColor = System.Drawing.Color.Blue;
            effs_c_f.ForeColor = System.Drawing.Color.Blue;
            effs_d_f.ForeColor = System.Drawing.Color.Blue;
            effs_f_f.ForeColor = System.Drawing.Color.Red;
            effs_g_f.ForeColor = System.Drawing.Color.Red;

            e.Row.Cells[0].Text = "平均：";
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        GridView3BataBind();
    }


    protected void Button2_Click(object sender, EventArgs e)
    {
        Response.Clear();
        Response.Buffer = true;
        Response.Charset = "BIG5"; //設定字集 
        Response.AppendHeader("Content-Disposition", "attachment;filename=filename .xls"); //filename 可自定 
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("BIG5"); Response.ContentType = "application/ms-excel "; //內容型態設為Excel 
        DataList2.EnableViewState = false; //把ViewState給關了 
        System.IO.StringWriter objStringWriter = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter objHtmlTextWriter = new System.Web.UI.HtmlTextWriter(objStringWriter);
        DataList2.RenderControl(objHtmlTextWriter); //只想匯DataGrid也行, 把This改 你的DataGrid ID 
        Response.Write(objStringWriter.ToString());
        Response.End();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void effs_f_TextChanged(object sender, EventArgs e)
    {

    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
        //    DropDownList1.SelectedValue = ((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim();

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        if (Session["empInfo"] != null)
        {
            string[] values = dll_attend.SelectedValue.Split(',');
            tb_year.Text = values[0];
            tb_seq.Text = values[1];
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

            HRDSTableAdapters.EFFEMPLOYTableAdapter effempad = new HRDSTableAdapters.EFFEMPLOYTableAdapter();
            DataClass dc = new DataClass();
            EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(DropDownList1.SelectedValue), "");
            if (Request.QueryString["deptm"] != null) { dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim()), ""); }

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
                HRDS.EFFEMPLOYDataTable effempdt = new HRDS.EFFEMPLOYDataTable();
                HRDS.EFFEMPLOYRow effemprow = effempdt.NewEFFEMPLOYRow();

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

                effemprow.NOBR = dt[i].nobr;
                effemprow.YYMM = "0" + Convert.ToString(yy - 1911);
                effemprow.EFFTYPE = seq.ToString();
                effemprow.EFFBA = (double)Math.Round(mangrow.apprratenum, 1);
                effemprow.EFFBB = (double)Math.Round(mangrow.cateratenum, 1);



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
                    effemprow.EFFVAR = (double)Math.Round(mangrow.totnum, 1);
                    effemprow.EFFLVL = mangrow.effs;
                }
                else
                {
                    try
                    {
                        dt[i]["effs_f"] = decimal.Parse(dt[i].effsfinally);
                        dt[i]["effs_g"] = DataClass.getEffsTitle(decimal.Parse(dt[i].effsfinally), "A001");
                        effemprow.EFFVAR = double.Parse(dt[i].effsfinally);
                        effemprow.EFFLVL = DataClass.getEffsTitle(decimal.Parse(dt[i].effsfinally), "A001");

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
                effemprow.IMPORT = true;
                effemprow.KEY_DATE = DateTime.Now;
                effemprow.KEY_MAN = "Tony";
                effempdt.AddEFFEMPLOYRow(effemprow);
                effempad.Update(effempdt);
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
        }

    }
    protected void DataList2_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        GridView gv = e.Item.FindControl("GridView3") as GridView;
        Label lb = e.Item.FindControl("groupid") as Label;
        GridView3BataBind(gv, lb.Text);
       

    }

    void GridView3BataBind(GridView gv, string groupid)
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

            DataClass dc = new DataClass();
            EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(DropDownList1.SelectedValue), "");
            dt.Columns.Add("f_mang_num", typeof(System.Decimal));
            dt.Columns.Add("f_mang_ef", typeof(System.Int32));




            //effsgroupID

            DataView dv = dt.DefaultView;
            dv.RowFilter = "effsgroupID ='" + groupid + "'";


            for (int i = 0; i < dv.Count; i++)
            {
            //    dv[i].Row["f_mang_num"] = DataClass.getMang_F_Num(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), dv[i].Row["nobr"].ToString(), row.NOBR);

            }

            dv.Sort = "f_mang_num desc ";

            int ef = 0;
            decimal f_mang_num = 0;
            for (int i = 0; i < dv.Count; i++)
            {
                //if (f_mang_num == decimal.Parse(dv[i].Row["f_mang_num"].ToString()))
                //{

                //}
                //else
                //{
                //    ef += 1;
                //    f_mang_num = decimal.Parse(dv[i].Row["f_mang_num"].ToString());
                //}
                dv[i].Row["f_mang_ef"] = ef;

            }

            dv.Sort = "f_mang_num desc ";

            gv.DataSource = dv;
            gv.DataBind();
        }
    }
    protected void GridView3_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        GridView gv = e.Row.FindControl("gv_mang") as GridView;
        Label effsgroupname = e.Row.FindControl("effsgroupname") as Label;
        Label templetID = e.Row.FindControl("templetID") as Label;
        TextBox m_num = e.Row.FindControl("m_num") as TextBox;
        TextBox tb_o1 = e.Row.FindControl("tb_o1") as TextBox;
        TextBox tb_o2 = e.Row.FindControl("tb_f") as TextBox;
        Label sf_app = e.Row.FindControl("sf_app") as Label;
        Label sf_cate = e.Row.FindControl("sf_cate") as Label;
        Label m_app = e.Row.FindControl("m_app") as Label;
        Label m_cate = e.Row.FindControl("m_cate") as Label;
        Label m_t = e.Row.FindControl("m_t") as Label;
        Label sf_t = e.Row.FindControl("sf_t") as Label;
        TextBox TextBox2 = e.Row.FindControl("TextBox2") as TextBox;

        string _nobr = e.Row.Cells[1].Text;
        if (gv != null)
        {
            if (Session["empInfo"] == null)
                Response.Redirect("./login.aspx");

            EFFDS.EMPINFODataTableRow UserRow = (EFFDS.EMPINFODataTableRow)Session["empInfo"];


            int mangorder = UserRow.cate_order;
            EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr);
            EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assing = DataClass.getAssignEmpNobr(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr);
            ArrayList al_nobr = new ArrayList();
            Hashtable ht_name = new Hashtable();
            DataTable dt = new DataTable();
            dt.Columns.Add("cate");
            dt.Columns.Add("self");
            dt.Columns.Add("mang1");
            dt.Columns.Add("mang2");
            dt.Columns.Add("mang3");
            dt.Columns.Add("mang4");
            dt.Columns.Add("mang5");
            dt.Columns.Add("mang6");
            dt.Columns.Add("mang7");
            dt.Columns.Add("mang8");
            dt.Columns.Add("mang9");
            dt.Columns.Add("mang10");


            al_nobr.Add(_nobr);
            ht_name.Add(_nobr, "自評");
            bool isok = true;

            for (int i = 0; i < arrpmang.Rows.Count; i++)
            {

                EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];






                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());

                if (emprow != null)
                {
                    if (emprow.cate_order <= mangorder)
                    {
                        if (UserRow.MANG)
                        {

                            al_nobr.Add(row.mangnobr.Trim());
                            ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());

                        }
                        else
                        {
                            if (assing.Select("assignnobr='" + row.mangnobr.Trim() + "'").Length == 0)
                            {

                                al_nobr.Add(row.mangnobr.Trim());
                                ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim() );


                            }

                        }

                    }
                    else if (emprow.MANG)
                    {
                        if (isok)
                        {
                            isok = false;

                            al_nobr.Add(row.mangnobr.Trim());
                            ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                        }
                    }
                }


            }




            int index = 1;
            int add = al_nobr.Count;
            Decimal t_t_num = 0;
            DataTable dtCate = DataClass.getTempletCateType(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, templetID.Text, true);

            for (int k = 0; k < dtCate.Rows.Count; k++)
            {
                DataRow nrow = dt.NewRow();

                nrow[0] = dtCate.Rows[k]["評估種類"].ToString();

                for (int i = 0; i < al_nobr.Count; i++)
                {
                    gv.Columns[index + i].Visible = true;
                    gv.Columns[index + i].HeaderText = ht_name[al_nobr[i].ToString()].ToString();
                    if (ht_name[al_nobr[i].ToString()].ToString().Equals("自評"))
                    {
                        DataTable s_dt = DataClass.getSelfType(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, templetID.Text, true, dtCate.Rows[k]["type"].ToString());
                        
                        for (int j = 0; j < s_dt.Rows.Count; j++)
                        {
                           
                           

                            nrow[i + 1] = s_dt.Rows[j]["加權分數"].ToString();

                            if (s_dt.Rows[j]["type"].ToString().Trim().ToUpper().Equals("A001"))
                            {
                                sf_app.Text = s_dt.Rows[j]["加權分數"].ToString(); 
                            }
                            else {
                                sf_cate.Text = s_dt.Rows[j]["加權分數"].ToString(); 
                            }
                        }
                        if (sf_cate.Text.Trim().Length == 0) {
                            sf_cate.Text = "0";
                        }
                        if (sf_app.Text.Trim().Length == 0)
                        {
                            sf_app.Text = "0";
                        }
                        sf_t.Text = Convert.ToString((decimal.Parse(sf_app.Text) + decimal.Parse(sf_cate.Text)) / dtCate.Rows.Count);
                       
                    }
                    else
                    {

                        DataTable m_dt = DataClass.getMangType(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, templetID.Text, true, al_nobr[i].ToString(), dtCate.Rows[k]["type"].ToString());

                       
                        for (int j = 0; j < m_dt.Rows.Count; j++)
                        {
                            nrow[i + 1] = m_dt.Rows[j]["加權分數"].ToString();

                            if (m_dt.Rows[j]["type"].ToString().Trim().ToUpper().Equals("A001"))
                            {
                                m_app.Text = m_dt.Rows[j]["加權分數"].ToString();
                            }
                            else
                            {
                                m_cate.Text = m_dt.Rows[j]["加權分數"].ToString();
                            }
                        }
                        if (m_app.Text.Trim().Length == 0)
                        {
                            m_app.Text = "0";
                        }
                        if (m_cate.Text.Trim().Length == 0)
                        {
                            m_cate.Text = "0";
                        }
                        m_t.Text = Convert.ToString((decimal.Parse(m_app.Text) + decimal.Parse(m_cate.Text)) / dtCate.Rows.Count);
                    }

                }
                dt.Rows.Add(nrow);
            }


            DataRow trow = dt.NewRow();
            trow[0] = "總分數：";
            DataRow frow = dt.NewRow();
            frow[0] = "評分調整";
            DataRow ffrow = dt.NewRow();
            ffrow[0] = "評等";
            int d_count = dt.Rows.Count;

            for (int k = 0; k < dt.Rows.Count; k++)
            {
                for (int i = 1; i < dt.Columns.Count; i++)
                {
                    decimal dd = 0;
                    try
                    {
                        dd = decimal.Parse(dt.Rows[k][i].ToString());
                    }
                    catch { }
                    decimal num = 0;
                    try
                    {
                        num = decimal.Parse(trow[i].ToString());


                    }
                    catch { }
                    trow[i] = Convert.ToString(num + dd);
                    if (k == 0)
                    {
                        trow[i] = Convert.ToString((num + dd));
                    }
                    else
                    {
                        trow[i] = Convert.ToString((num + dd) / d_count);

                    }
                    if (k == dt.Rows.Count - 1)
                    {


                    }
                }

            }


            dt.Rows.Add(trow);

            for (int i = 1; i < dt.Columns.Count; i++)
            {
                decimal mm_num = 0;
                try
                {
                   // mm_num = DataClass.getMang_F_Num(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, al_nobr[i - 1].ToString());
                   // tb_o1.Text = DataClass.getMang_F_o1(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, al_nobr[i - 1].ToString());
                  //  ffrow[i] = DataClass.getMang_F_o2(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, al_nobr[i - 1].ToString());
                    try
                    {
                        if (mm_num > 0)
                        {
                            t_t_num = mm_num;
                        }
                    }
                    catch { }
                }
                catch { }
                if (mm_num == 0)
                {
                    try
                    {
                        frow[i] = trow[i];
                        mm_num = decimal.Parse(frow[i].ToString());

                        //   DataClass.SaveMang_F_Num(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr, al_nobr[i - 1].ToString(), DropDownList1.SelectedValue, mm_num);
                    }
                    catch { }

                }
                else
                {
                    frow[i] = mm_num;
                }
                try
                {
                    //if (mangnobr.Text.Trim().Equals(al_nobr[i - 1].ToString().Trim()))
                    //{
                    //    m_num.Text = mm_num.ToString();
                    //}




                }
                catch { }

            }

            //if (decimal.Parse(m_num.Text) == 0)
            //{

            //    m_num.Text = DataClass.getMang_F_Num(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, mangnobr.Text).ToString();

            //    tb_o1.Text = DataClass.getMang_F_o1(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr, mangnobr.Text);

            //}
            dt.Rows.Add(frow);
            dt.Rows.Add(ffrow);


            //if (bool.Parse(ViewState["isOver"].ToString()))
            //{
            //    m_num.ReadOnly = true;
            //}
            //if (!bool.Parse(ViewState["topMang"].ToString()))
            //{
            //    m_num.ReadOnly = true;
            //}

            EFFDS.EFFS_BASERow brow = DataClass.getEff_Base_Num(m_num.ValidationGroup, tb_year.Text, tb_seq.Text);
            if (brow != null)
            {
                if(!brow.IsjobplanNull())
                TextBox2.Text = brow.jobplan;
                if(!brow.IseffsfinallyNull())
                tb_o2.Text = brow.effsfinally;
                if(!brow.IsdeptsNull())
                 m_num.Text = brow.depts;
            }



            gv.DataSource = dt;
            gv.DataBind();

        }
    }

    void GridView3BataBind()
    {
        if (Session["empInfo"] != null)
        {
            if (Session["empInfo"] != null)
            {
                string[] values = dll_attend.SelectedValue.Split(',');
                tb_year.Text = values[0];
                tb_seq.Text = values[1];
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

                DataClass dc = new DataClass();
                EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(DropDownList1.SelectedValue), "");


                DataTable groupdt = new DataTable();
                groupdt.Columns.Add("id");
                groupdt.Columns.Add("name");
                groupdt.Columns.Add("ord", typeof(System.Int32));
                ArrayList al = new ArrayList();
                for (int i = 0; i < dt.Rows.Count; i++)
                {

                    if (!al.Contains(dt[i].effsgroupID))
                    {
                        al.Add(dt[i].effsgroupID);
                        DataRow r = groupdt.NewRow();
                        r[0] = dt[i].effsgroupID;
                        r[1] = dt.Rows[i]["effsgroupname"].ToString();
                        try
                        {
                            r[2] = DataClass.getEffGroup(dt[i].effsgroupID).order;
                        }
                        catch { }
                        groupdt.Rows.Add(r);
                    }

                }
                DataView dv = groupdt.DefaultView;
                dv.Sort = "ord";

                DataList2.DataSource = dv;
                DataList2.DataBind();


                // GridView3.DataSource = dt;
                // GridView3.DataBind();
            }
        }
    }
    protected void m_num_TextChanged(object sender, EventArgs e)
    {


        TextBox bt = sender as TextBox;
        DataClass.setEff_Base_Num(bt.ValidationGroup, tb_year.Text, tb_seq.Text, decimal.Parse(bt.Text));

      //   DataClass.SaveMang_F_Num(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), bt.ValidationGroup, UserRow.NOBR, lb_select_dept.Text, decimal.Parse(bt.Text));
        GridView3BataBind();
    }
    protected void tb_f_TextChanged(object sender, EventArgs e)
    {
        TextBox bt = sender as TextBox;
       DataClass.setEff_Base_Num(bt.ValidationGroup, tb_year.Text, tb_seq.Text, bt.Text);

    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        EFFDSTableAdapters.EFFS_ATTENDTableAdapter efad = new EFFDSTableAdapters.EFFS_ATTENDTableAdapter();
        EFFDS.EFFS_ATTENDDataTable efdt = efad.GetDataByYear(int.Parse(tb_year.Text), int.Parse(tb_seq.Text));
        if (efdt.Rows.Count > 0)
        {
            if (DateTime.Now <= efdt[0].EndDate)
            {
                Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('考核時間還沒結束！不可匯入資料！！(" + efdt[0].EndDate.ToShortDateString() + ")');</script>");

                return;
            }






        }
    }
    protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Trim().Equals("eff_num_header")) 
        {
            GridView g = sender as GridView;
            for (int i = 0; i < g.Rows.Count; i++) {
                Label m_t = g.Rows[i].FindControl("m_t") as Label;
                Label sf_t = g.Rows[i].FindControl("sf_t") as Label;
                TextBox m_num = g.Rows[i].FindControl("m_num") as TextBox;
                if (m_t.Text.Trim().Length > 0) {
                    m_num.Text = m_t.Text;

                    DataClass.setEff_Base_Num(m_num.ValidationGroup, tb_year.Text, tb_seq.Text, decimal.Parse(m_num.Text));
                
                }
            

            
            }
        
        }
    }
    protected void Button6_Click1(object sender, EventArgs e)
    {

    }
    protected void TextBox2_TextChanged(object sender, EventArgs e)
    {
        TextBox bt = sender as TextBox;
        DataClass.setEff_Base_jobPlan(bt.ValidationGroup, tb_year.Text, tb_seq.Text, bt.Text);
    }
}

