﻿using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class Reports_Rep009 : System.Web.UI.Page
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
    protected void GridViewInterView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        //_nobr_.Text = "";
        //if (e.Row.RowType == DataControlRowType.DataRow)
        //{
 
        //    EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter();
        //    EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter interad = new EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter();
        //    try
        //    {
        //        string apprID = "";
        //        Label lb = (Label)e.Row.FindControl("lb_ID");
        //        Label tb = (Label)e.Row.FindControl("FreeTextBox1");
        //        Label ll = (Label)e.Row.FindControl("Label4");
                

        //      //  FreeTextBoxControls.FreeTextBox mtb = (FreeTextBoxControls.FreeTextBox)e.Row.FindControl("FreeTextBox2");
               

        //        if (lb != null)
        //            apprID = lb.Text;

        //        EFFDS.EFFS_SELFINTERVIEWDataTable selfdt = selfad.GetDataByInterID(int.Parse(tb_year.Text), int.Parse(tb_seq.Text),
        //            ll.Text, apprID);
        //        _nobr_.Text = ll.Text;
        //    //    EFFMANGDS.EFFS_MANGINTERVIEWDataTable interdt = interad.GetDataByInterID(int.Parse(_yy.Text), int.Parse(_seq.Text),
        //     //       _nobr.Text, _mangnobr.Text, apprID);
               
        //        if (selfdt.Rows.Count > 0)
        //        {


        //            if (tb != null)
        //            {
        //                EFFDS.EFFS_SELFINTERVIEWRow selfrow = (EFFDS.EFFS_SELFINTERVIEWRow)selfdt.Rows[0];
        //                if (!selfrow.IsnoteNull())
        //                {
        //                    tb.Text = selfrow.note.ToString();

        //                }
        //                else
        //                {
        //                    tb.Text = "";
        //                }
        //            }
        //        }
        //        else
        //        {
        //            tb.Text = "";
        //        }
        //    }
        //    catch
        //    {

        //    }
        //}
    }
    protected void GridViewInterView_DataBound(object sender, EventArgs e)
    {
        //ArrayList al_nobr = new ArrayList();
        //Hashtable ht_name = new Hashtable();

        //int mangorder = 99;
        //EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), _nobr_.Text);
        //for (int i = 0; i < arrpmang.Rows.Count; i++)
        //{
        //    EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];


          
        //        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DateTime.Now.ToShortDateString());
        //        if (emprow != null)
        //        {
        //            if (emprow.cate_order <= mangorder)
        //            {
        //                al_nobr.Add(row.mangnobr.Trim());
        //                ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
        //            }
        //        }
        

        //}
  //      if(isOK)
           // setCheckEffInterViewMang(sender, al_nobr, ht_name);
   //     isOK = false;
        
    }
  
    void setCheckEffInterViewMang(object sender, ArrayList al, Hashtable ht,string nobr)
    {
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
        GridView gv = (GridView)sender;
        int index = 3;
        int add = al.Count;
        EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter interad = new EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter();



        for (int i = 0; i < al.Count; i++)
        {
            gv.Columns[index + i].Visible = true;
            gv.Columns[index + i].HeaderText = ht[al[i].ToString()].ToString();



            for (int j = 0; j < gv.Rows.Count; j++)
            {
                gv.Rows[j].Cells[index + i].Text = "xxx";
              //  nummang1
               // Label mtb = (Label)gv.Rows[j].FindControl("nummang" + Convert.ToString(i + 1));

                //string apprID = "";
                //Label lb = (Label)gv.Rows[j].FindControl("lb_ID");

                //if (lb != null)
                //    apprID = lb.Text;
                //EFFMANGDS.EFFS_MANGINTERVIEWDataTable interdt = interad.GetDataByInterID(int.Parse(tb_year.Text), int.Parse(tb_seq.Text),
                //   nobr, al[i].ToString(), apprID);
                //if (interdt.Rows.Count > 0)
                //{
                //    if (mtb != null)
                //    {
                //        EFFMANGDS.EFFS_MANGINTERVIEWRow interrow = (EFFMANGDS.EFFS_MANGINTERVIEWRow)interdt[0];
                //        if (!interrow.IsnoteNull())
                //        {
                //            mtb.Text = interrow.note;
                //        }
                //        else
                //        {
                //            mtb.Text = "沒資料";
                //        }
                //    }

                //}
                //else
                //{
                //    mtb.Text = "沒資料";

                //}
            //   mtb.Text += "TY";
            }
           
        }



    }

    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow) {
            string[] values = dll_attend.SelectedValue.Split(',');
            tb_year.Text = values[0];
            tb_seq.Text = values[1];

             GridView gv = (GridView)e.Row.FindControl("GridViewInterView");
            //Label1
            Label _lb = (Label)e.Row.FindControl("Label1");
            Label lb_nobr = (Label)e.Row.FindControl("_nobr");
            Label lb_temp = (Label)e.Row.FindControl("_temp");
         // _nobr_.Text = e.Row.Cells[4].Text;
            //  _temp.Text = _lb.Text;
            EFFMANGDSTableAdapters.MangInterViewTableAdapter minterad = new EFFMANGDSTableAdapters.MangInterViewTableAdapter();
            EFFMANGDS.MangInterViewDataTable minterdt = minterad.GetData(lb_temp.Text, lb_nobr.Text, int.Parse(tb_year.Text), int.Parse(tb_seq.Text));
            minterdt.Columns.Add("mang1");
            minterdt.Columns.Add("mang2");
            minterdt.Columns.Add("mang3");
            minterdt.Columns.Add("mang4");
            minterdt.Columns.Add("mang5");
            minterdt.Columns.Add("mang6");
            minterdt.Columns.Add("mang7");
            minterdt.Columns.Add("mang8");
            minterdt.Columns.Add("mang9");
            minterdt.Columns.Add("mang10");
          
     //      Response.Flush();
            ArrayList al_nobr = new ArrayList();
            Hashtable ht_name = new Hashtable();

            int mangorder = 99;
            EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), e.Row.Cells[4].Text);
            for (int i = 0; i < arrpmang.Rows.Count; i++)
            {
                EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];



                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
                if (emprow != null)
                {
                    if (emprow.cate_order <= mangorder)
                    {
                        al_nobr.Add(row.mangnobr.Trim());
                        ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                    }
                }


            }

           
            int index = 3;
            int add = al_nobr.Count;
            EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter interad = new EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter();



            for (int i = 0; i < al_nobr.Count; i++)
            {
                gv.Columns[index + i].Visible = true;
                gv.Columns[index + i].HeaderText = ht_name[al_nobr[i].ToString()].ToString();



                for (int j = 0; j < minterdt.Rows.Count; j++)
                {
                 //   minterdt.Rows[j]["mang" + i] = "xxx";


                   string  apprID = minterdt[j].ID;
                    EFFMANGDS.EFFS_MANGINTERVIEWDataTable interdt = interad.GetDataByInterID(int.Parse(tb_year.Text), int.Parse(tb_seq.Text),
                       lb_nobr.Text, al_nobr[i].ToString(), apprID);
                    if (interdt.Rows.Count > 0)
                    {
                        
                            EFFMANGDS.EFFS_MANGINTERVIEWRow interrow = (EFFMANGDS.EFFS_MANGINTERVIEWRow)interdt[0];
                            if (!interrow.IsnoteNull())
                            {
                                minterdt.Rows[j]["mang" + Convert.ToString(i + 1)] = interrow.note;
                            }
                            else
                            {
                                minterdt.Rows[j]["mang" + Convert.ToString(i + 1)] = "";
                            }
                   
                    }
                    else
                    {
                        minterdt.Rows[j]["mang" + Convert.ToString(i + 1)] = "";

                    }
                   
                }

            }













            //      if(isOK)
         //   setCheckEffInterViewMang(gv, al_nobr, ht_name, lb_nobr.Text);
            gv.DataSource = minterdt;
            gv.DataBind();
        }
    }
    protected void GridView7_DataBound(object sender, EventArgs e)
    {

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
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
      //  DropDownList1.SelectedValue = ((EFFDS.EMPINFODataTableRow)Session["empInfo"]).DEPTM.Trim();

    }
}
