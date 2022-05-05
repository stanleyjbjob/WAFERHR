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

public partial class EMP_EFF001 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string nobr = "";
            if (Request.QueryString["nobr"] != null)
            {
                nobr = Request.QueryString["nobr"].Trim();
            }
            if (Session["nobr"] != null)
            {
                nobr = Session["nobr"].ToString().Trim();
            }
            f_panel.Visible = false;

            ViewState.Add("nobr", nobr);
            note.Text = DataClass.getNote("EMP.EFF001.aspx");
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {


        if (Session["EFFSInfo"] != null)
        {
            Session.Remove("EFFSInfo");
        }
        int yy = 0;
        int seq = 0;
        EFFDS.EFFS_ATTENDRow attrow = DataClass.getEffsAttend((int)GridView1.SelectedValue);
        if (attrow != null)
        {
            yy = attrow.yy;
            seq = attrow.seq;
            lb_yy.Text = attrow.yy.ToString();
            lb_seq.Text = attrow.seq.ToString();
            EFFDS.EFFS_BASERow baserow = DataClass.getEffsBase(yy.ToString(), seq.ToString(), ViewState["nobr"].ToString());
            if (baserow != null)
            {

                HyperLink1.NavigateUrl = "~/EMP/EFF002.aspx";
                HyperLink1.Target = "_blank";

                Hashtable ht = new Hashtable();
                ht.Add("attend", attrow);
                ht.Add("base", baserow);
                ht.Add("empInfo", DataClass.getEmpInfo(baserow.nobr, DataClass.getEffsAttendStdDate(int.Parse(yy.ToString()), int.Parse(seq.ToString())).ToShortDateString()));
                Session.Add("EFFSInfo", ht);


            }
            else
            {
                HyperLink1.NavigateUrl = "";
                HyperLink1.Target = "";

                CS.showScriptAlert(UpdatePanel1, "這次考核沒有產生您的名單！！");
            }
            //  if (Session["empInfo"] != null)
            //  {
            //      EFFDS.EMPINFODataTableRow emprow = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            //      if (emprow.MANG)
            //      {
            //          f_panel.Visible = true ;
            //      }

            //  }

            //  EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = DataClass.getAssignMang(yy, seq, ViewState["nobr"].ToString());
            //  EFFDS.EFFS_BASEDataTable basedt = new EFFDS.EFFS_BASEDataTable();
            //  basedt.Columns.Add("mangname");
            //  basedt.Columns.Add("mangdname");
            //  basedt.Columns.Add("mangjobname");
            //  for (int i = 0; i < assdt.Rows.Count; i++)
            //  {
            //      EFFMANGDS.EFFS_ASSIGNAPPENDRow assrow = (EFFMANGDS.EFFS_ASSIGNAPPENDRow)assdt.Rows[i];
            //      EFFDS.EFFS_BASEDataTable baseddt = DataClass.getEffsBaseDT(assrow.yy.ToString(), assrow.seq.ToString(), assrow.nobr);
            //      baseddt.Columns.Add("mangname");
            //      baseddt.Columns.Add("mangdname");
            //      baseddt.Columns.Add("mangjobname");
            //      baseddt.Rows[0]["mangname"] = assrow["mangname"];
            //      baseddt.Rows[0]["mangdname"] = assrow["mangdname"];
            //      baseddt.Rows[0]["mangjobname"] = assrow["mangjobname"];
            //      basedt.Merge(baseddt);

            //  }
            //  GridView5.DataSource = basedt;
            //  GridView5.DataBind();

        }
    }
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb = (Label)e.Row.FindControl("_AutoKey");
            Label effsnum = (Label)e.Row.FindControl("effsnum");
            Label effs = (Label)e.Row.FindControl("effs");
            int yy = 0;
            int seq = 0;
            EFFDS.EFFS_ATTENDRow attrow = DataClass.getEffsAttend(int.Parse( lb.Text));
            if (attrow != null)
            {
                yy = attrow.yy;
                seq = attrow.seq;
            }
                  EFFDS.EFFS_BASERow baserow =  DataClass.getEffsBase(yy.ToString(),seq.ToString(),ViewState["nobr"].ToString());
                  if (baserow != null)
                  {
                      try
                      {
                          EFFMANGDS.EFFS_NUMRow row = DataClass.getEFFSELENUM(yy, seq, true, ViewState["nobr"].ToString(), baserow.templetID, "A001", "B001", "A001");
                          DataTable dt = DataClass.getSelfType(int.Parse(yy.ToString()), int.Parse(seq.ToString()), ViewState["nobr"].ToString(), baserow.templetID, true);

                          double tot_num = 0;
                          for (int i = 0; i < dt.Rows.Count; i++)
                          {

                              tot_num += double.Parse(dt.Rows[i][2].ToString());

                          }


                          if (dt.Rows.Count == 1)
                          {

                              effsnum.Text = tot_num.ToString(); // Convert.ToString(Math.Round(tot_num / 2, 3, MidpointRounding.AwayFromZero));
                          }
                          else
                          {
                              effsnum.Text = Convert.ToString(Math.Round(tot_num / 2, 3, MidpointRounding.AwayFromZero));
                          }

                          if ((int)row.totnum == 0)
                          {
                              effs.Text = "未評等";
                          }
                          else
                          {
                              effs.Text = row.effs;
                          }
                      }
                      catch
                      {
                          effsnum.Text = "0";
                      }

                  }

        }
    }
    protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb = (Label)e.Row.FindControl("_nobr");
            Label effs = (Label)e.Row.FindControl("effs");//mangeffs
            Label effs1 = (Label)e.Row.FindControl("effs1");//mangeffs
            Label mangeffs = (Label)e.Row.FindControl("mangeffs");//mangeffs
            Label mangeffs1 = (Label)e.Row.FindControl("mangeffs1");//mangeffs

            int yy = int.Parse(lb_yy.Text);
            int seq = int.Parse(lb_seq.Text);

            EFFDS.EFFS_BASERow baserow = DataClass.getEffsBase(yy.ToString(), seq.ToString(), lb.Text);
            if (baserow != null)
            {
              
                EFFMANGDS.EFFS_NUMRow row = DataClass.getEFFSELENUM(yy, seq, true, lb.Text, baserow.templetID, "A001", "B001", "A001");
                effs.Text = Convert.ToString(Math.Round(row.totnum, 1));
                if ((int)row.totnum == 0)
                {
                    effs1.Text = "未評等";
                }
                else
                {
                    effs1.Text = row.effs;
                }


            
                EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, true, lb.Text, baserow.templetID, "A001", "B001", "A001", ViewState["nobr"].ToString());
                mangeffs.Text = Convert.ToString(Math.Round(mangrow.totnum, 1));
                if ((int)mangrow.totnum == 0)
                {
                    mangeffs1.Text = "未評等";
                }
                else
                {
                    mangeffs1.Text = mangrow.effs;
                }
             
            }
           
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        if (Session["EFFSInfo"] != null)
        {
            Response.Redirect("EFF002.aspx");
            //"~/MANG/EFF004.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID")+"&Appoint=True"
        }
        else 
        {
            CS.showScriptAlert(UpdatePanel1, "您未選取考核年度！先請選取！！");
        
        }
    }
    protected void LinkButton1_Click(object sender, EventArgs e)
    {
        if (Session["EFFSInfo"] != null)
        {
            Response.Redirect("EFF002.aspx");
           
            
            //"~/MANG/EFF004.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID")+"&Appoint=True"
        }
        else
        {
            CS.showScriptAlert(UpdatePanel1, "您未選取考核年度！先請選取！！");

        }
    }
    protected void GridView5_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb = (Label)e.Row.FindControl("_nobr");
            Label effs = (Label)e.Row.FindControl("effs");//mangeffs
            Label effs1 = (Label)e.Row.FindControl("effs1");//mangeffs
            Label mangeffs = (Label)e.Row.FindControl("mangeffs");//mangeffs
            Label mangeffs1 = (Label)e.Row.FindControl("mangeffs1");//mangeffs

            int yy = int.Parse(lb_yy.Text);
            int seq = int.Parse(lb_seq.Text);

            EFFDS.EFFS_BASERow baserow = DataClass.getEffsBase(yy.ToString(), seq.ToString(), lb.Text);
            if (baserow != null)
            {

                EFFMANGDS.EFFS_NUMRow row = DataClass.getEFFSELENUM(yy, seq, true, lb.Text, baserow.templetID, "A001", "B001", "A001");
                effs.Text = Convert.ToString(Math.Round(row.totnum, 1));
                if ((int)row.totnum == 0)
                {
                    effs1.Text = "未評等";
                }
                else
                {
                    effs1.Text = row.effs;
                }

                EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, true, lb.Text, baserow.templetID, "A001", "B001", "A001", ViewState["nobr"].ToString());
                mangeffs.Text = Convert.ToString(Math.Round(mangrow.totnum, 1));
                if ((int)mangrow.totnum == 0)
                {
                    mangeffs1.Text = "未評等";
                }
                else
                {
                    mangeffs1.Text = mangrow.effs;
                }
             
            }

        }
    }
    protected void LinkButton1_Click1(object sender, EventArgs e)
    {

    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)((Control)e.CommandSource).Parent.Parent;
            if (Session["EFFSInfo"] != null)
            {
                Session.Remove("EFFSInfo");
            }
            int yy = 0;
            int seq = 0;

            EFFDS.EFFS_ATTENDRow attrow = DataClass.getEffsAttend(int.Parse(row.Cells[1].Text), int.Parse(row.Cells[2].Text));
            if (attrow != null)
            {
                yy = attrow.yy;
                seq = attrow.seq;
                lb_yy.Text = attrow.yy.ToString();
                lb_seq.Text = attrow.seq.ToString();
                EFFDS.EFFS_BASERow baserow = DataClass.getEffsBase(yy.ToString(), seq.ToString(), ViewState["nobr"].ToString());
                if (baserow != null)
                {

                    HyperLink1.NavigateUrl = "~/EMP/EFF002.aspx";
                    HyperLink1.Target = "_blank";

                    Hashtable ht = new Hashtable();
                    ht.Add("attend", attrow);
                    ht.Add("base", baserow);
                    ht.Add("empInfo", DataClass.getEmpInfo(baserow.nobr, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString()));
                    Session.Add("EFFSInfo", ht);


                }
                else
                {
                    HyperLink1.NavigateUrl = "";
                    HyperLink1.Target = "";

                    CS.showScriptAlert(UpdatePanel1, "這次考核沒有產生您的名單！！");
                }
                if (e.CommandName.Trim().Equals("openEffs"))
                {



                    CS.ScripWindowOpen(UpdatePanel1, "EFF002.aspx");

                }
                else if (e.CommandName.Trim().Equals("openSelfEffs"))
                {
                    CS.ScripWindowOpen(UpdatePanel1, "../emp/PrintEffst.aspx?yy=" + yy.ToString() + "&seq=" + seq.ToString() + "&nobr=" + ViewState["nobr"].ToString() + "&tempID=" + baserow.templetID);
                }
                else if (e.CommandName.Trim().Equals("openSelfEffs1"))
                {
                    CS.ScripWindowOpen(UpdatePanel1, "../emp/PrintEffst.aspx?yy=" + yy.ToString() + "&seq=" + seq.ToString() + "&nobr=" + ViewState["nobr"].ToString() + "&tempID=" + baserow.templetID);
                }

























              
                //  ScriptManager.RegisterStartupScript(UpdatePanel1, typeof(UpdatePanel), "key", "openEffs();", true);
            }
        }
        catch { }
    }
    protected void RadioButtonList1_SelectedIndexChanged1(object sender, EventArgs e)
    {
        if (AttendRadioButtonList.SelectedIndex == 0)
        {
            GridView1.DataSourceID = "AttendDataSource1";
        }
        else
        {
            GridView1.DataSourceID = "AttendAllDataSource";
        }
        GridView1.DataBind();
    }
}
