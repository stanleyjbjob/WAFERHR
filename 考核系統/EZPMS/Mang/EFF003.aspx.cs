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

public partial class Mang_EFF003 : System.Web.UI.Page
{
    public new void RegisterOnSubmitStatement(string key, string script)
    {
        ScriptManager.RegisterOnSubmitStatement(this, typeof(Page), key, script);
    }

    [Obsolete]
    public override void RegisterStartupScript(string key, string script)
    {
        string newScript = script.Replace("FTB_AddEvent(window,'load',function () {", "").Replace("});", "");
        ScriptManager.RegisterStartupScript(this, typeof(Page), key, newScript, false);
    }
    public void getDeptTreeData()
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            HRDSTableAdapters.DEPTATableAdapter deptad = new HRDSTableAdapters.DEPTATableAdapter();
            HRDS.DEPTADataTable dept_mang = deptad.GetDataByDept(row.DEPTM);
            if (dept_mang.Rows.Count == 0)
                return;


            TreeNode treeroot = new TreeNode();
            treeroot.Text = dept_mang[0].D_NAME;
            treeroot.Value = dept_mang[0].D_NO;


            HRDS.DEPTADataTable deptdt = deptad.GetDataByGroupDept(row.DEPTM);
            HRDS.DEPTADataTable deptAllDt = deptad.GetData();
            for (int i = 0; i < deptdt.Rows.Count; i++)
            {
                TreeNode nodes = new TreeNode();
                nodes.Text = deptdt[i].D_NAME;
                nodes.Value = deptdt[i].D_NO;

                setTreeNodes(nodes, deptAllDt);
                treeroot.ChildNodes.Add(nodes);
            }

            TreeView1.Nodes.Add(treeroot);


            //FlowDSTableAdapters.SubWorkTableAdapter subad = new FlowDSTableAdapters.SubWorkTableAdapter();
            //FlowDS.SubWorkDataTable subdt = subad.GetData(row.NOBR);
            //for (int i = 0; i < subdt.Rows.Count; i++) {
            //    HRDS.DEPTARow[] depts = (HRDS.DEPTARow[])deptAllDt.Select("D_NO='" + subdt[i].sSubDept+ "'");
            //    if(depts.Length==0)
            //        continue;

            //    TreeNode nodes = new TreeNode();

            //    nodes.Text = depts[i].D_NAME+"(兼職)";
            //    nodes.Value = subdt[i].sSubDept;

            //    setTreeNodes(nodes, deptAllDt);
            //    TreeView1.Nodes.Add(nodes);
            //}



        }
    }

    public void setTreeNodes(TreeNode p_node, HRDS.DEPTADataTable deptAllDt)
    {
        HRDS.DEPTARow[] depts = (HRDS.DEPTARow[])deptAllDt.Select("DEPT_GROUP='" + p_node.Value + "'");
        for (int i = 0; i < depts.Length; i++)
        {
            TreeNode nodes = new TreeNode();
            nodes.Text = depts[i].D_NAME;
            nodes.Value = depts[i].D_NO;

            setTreeNodes(nodes, deptAllDt);
            p_node.ChildNodes.Add(nodes);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        
        Page.ClientScript.RegisterClientScriptInclude("FTB-FreeTextBox", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-FreeTextBox.js"));
        Page.ClientScript.RegisterClientScriptInclude("FTB-Utility", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Utility.js"));
        Page.ClientScript.RegisterClientScriptInclude("FTB-Toolbars", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ToolbarItems.js"));
        Page.ClientScript.RegisterClientScriptInclude("FTB-ImageGallery", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ImageGallery.js"));
        Page.ClientScript.RegisterClientScriptInclude("FTB-Pro", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Pro.js"));

        if (!IsPostBack)
        {
    
            if (Session["empInfo"] != null) {
                ViewState["isOver"] = false;
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

                mangnobr.Text = row.NOBR;
                if(row.MANGE ){
                    mangNote.Visible = true;
                }
                
                getDeptTreeData();
                lb_select_dept.Text = row.DEPTM;
            }
            note.Text = DataClass.getNote("Mang.EFF003.aspx");
            
        }
     
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        lb_yy.Text = GridView1.SelectedRow.Cells[1].Text;
        lb_seq.Text = GridView1.SelectedRow.Cells[2].Text;

     EFFDS.EFFS_ATTENDRow   attrow =  DataClass.getEffsAttend(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text));
     if (DateTime.Now >= attrow.StdDate && DateTime.Now <= attrow.EndDate)
     {
         ViewState["isOver"] = false;
     }
     else
     {
         ViewState["isOver"] = true;
     }


        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            PlanText1.Text = DataClass.getMangFinishNote(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), row.NOBR);
            EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter notead = new EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter();
            EFFMANGDS.EFFS_MANGFINISHNOTEDataTable notedt = notead.GetData(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), row.NOBR);

            if (notedt.Rows.Count >0)
            {

                ViewState["isOver"] = true;
                Button4.Text = "您已於”" + notedt[0].keydate.ToString() + "”,傳送,不可修改本期考核資料！！";
                Button4.Enabled = false;
                PlanText1.ReadOnly = true;
            }
            else
            {
                ViewState["isOver"] = false;
                Button4.Enabled = true ;
            }

            GridView7DataBind();
            GridView3BataBind();
      
            MultiView1.ActiveViewIndex = 1;
            Menu1.Items[1].Selected = true;

            EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = DataClass.getAssignMang(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), mangnobr.Text);
            EFFDS.EFFS_BASEDataTable basedt = new EFFDS.EFFS_BASEDataTable();
            basedt.Columns.Add("mangname");
            basedt.Columns.Add("mangdname");
            basedt.Columns.Add("mangjobname");
            for (int i = 0; i < assdt.Rows.Count; i++)
            {
                try
                {
                    EFFMANGDS.EFFS_ASSIGNAPPENDRow assrow = (EFFMANGDS.EFFS_ASSIGNAPPENDRow)assdt.Rows[i];
                    EFFDS.EFFS_BASEDataTable baseddt = DataClass.getEffsBaseDT(assrow.yy.ToString(), assrow.seq.ToString(), assrow.nobr);
                    baseddt.Columns.Add("mangname");
                    baseddt.Columns.Add("mangdname");
                    baseddt.Columns.Add("mangjobname");
                    baseddt.Rows[0]["mangname"] = assrow["mangname"];
                    baseddt.Rows[0]["mangdname"] = assrow["mangdname"];
                    baseddt.Rows[0]["mangjobname"] = assrow["mangjobname"];
                    basedt.Merge(baseddt);
                }
                catch { }
                
            }

         //   GridView8.DataBind();
            GridView5.DataSource =basedt;
            GridView5.DataBind();
           
        }

    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        MultiView1.ActiveViewIndex = int.Parse(e.Item.Value);
    }
    protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
    {
       
    }
    protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
    {
      
    }
    protected void Button3_Click(object sender, EventArgs e)
    {

        EFFDS.EMPINFODataTableRow approw = DataClass.getEmpInfoForNobrOrName(txt_nobr.Text, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
        if (approw != null)
        {
            if (Session["empInfo"] != null)
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter assad = new EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter();
                EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = new EFFMANGDS.EFFS_ASSIGNAPPENDDataTable();
                assdt.AddEFFS_ASSIGNAPPENDRow(int.Parse(app_yy.Text), int.Parse(app_seq.Text), app_nobr.Text,
                   row.NOBR, row.DEPT, row.JOB, approw.NOBR, DateTime.Now, 10);

                assad.Update(assdt);

                GridView4.DataSource = DataClass.getAssign(int.Parse(app_yy.Text), int.Parse(app_seq.Text), mangnobr.Text);
                GridView4.DataBind();
            }
            else 
            {

                CS.showScriptAlert(this, "等待時間過久，請重新登入！！");
            
            }
        }
        else 
        {
            CS.showScriptAlert(this, "沒有員工資料");
        }

    }
    protected void GridView4_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Trim().Equals("DeleteE")) 
        {
            EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter assad = new EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter();
            assad.Delete(int.Parse(e.CommandArgument.ToString()));
            GridView4.DataSource = DataClass.getAssign(int.Parse(app_yy.Text), int.Parse(app_seq.Text), mangnobr.Text);
            GridView4.DataBind();
        
        }
    }
    int u_t , u_a , u_b , u_c, u_d = 0;
    protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
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
                    effs1.Text = "未評"; 
                }
                else {
                    effs1.Text = row.effs;
                }
               
                EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, true, lb.Text, baserow.templetID, "A001", "B001", "A001", mangnobr.Text);
                mangeffs.Text = Convert.ToString(Math.Round(mangrow.totnum, 1)) ;
                if ((int)mangrow.totnum == 0)
                {
                    mangeffs1.Text = "未評";
                }
                else
                {
                    mangeffs1.Text = mangrow.effs;
                }
           
            }

        }
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        string nobr = e.Values["nobr"].ToString();
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(nobr, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
        if (emprow != null)
        {
            decimal tot = decimal.Parse(e.Values["arrprate"].ToString()) + decimal.Parse(e.Values["caterate"].ToString());
            if (tot != 100)
            {
                CS.showScriptAlert(this, "比重合計應１００％");
                e.Cancel = true;
            }
            e.Values["nobr"] = emprow.NOBR;
            e.Values["yy"] = int.Parse(lb_yy.Text);
            e.Values["seq"] = int.Parse(lb_seq.Text);
            e.Values["mangnobr"] = mangnobr.Text;
        }
        else {
            CS.showScriptAlert(this, "沒有"+nobr+"資料");
            e.Cancel = true;
    
            }
        

    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView6.DataBind();
    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView6.DataBind();
    }
    protected void FormView1_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        GridView6.DataBind();
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        decimal tot = decimal.Parse(e.NewValues["arrprate"].ToString() )+ decimal.Parse(e.NewValues["caterate"].ToString());
        if (tot != 100) {
            CS.showScriptAlert(this,"比重合計應１００％");
            e.Cancel = true;
        }
    }
    protected void GridView3_Sorting(object sender, GridViewSortEventArgs e)
    {

       
    }
    protected void GridView3_Sorted(object sender, EventArgs e)
    {

    }
    decimal t_effs_a1_ = 0, t_effs_b1_ = 0, t_effs_c1_ = 0;
    decimal t_effs_a_ = 0, t_effs_b_ = 0, t_effs_c_ = 0;
    decimal t_count = 0, t_count_a = 0;
    EFFMANGDS.EFFS_NUMORDERDataTable numorder = new EFFMANGDS.EFFS_NUMORDERDataTable();
   
    
    
    
    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Label lb_temlet = e.Row.FindControl("lb_tmplet") as Label;
            Label lb = (Label)e.Row.FindControl("_nobr");
            HyperLink hll = e.Row.FindControl("HyperLink1") as HyperLink;
            string ss_nobr =  DataClass.getMangFromNobr(lb.Text, DateTime.Now.ToShortDateString());
            if (ss_nobr.Trim().Equals(mangnobr.Text.Trim()))
            {
                hll.Visible = true;
            }
            else {
                hll.Visible = false;
            }

            t_count++;
            
            Label effs_a1_ = (Label)e.Row.FindControl("effs_a1");
            Label effs_b1_ = (Label)e.Row.FindControl("effs_b1");
            Label effs_c1_ = (Label)e.Row.FindControl("effs_c1");
            Label effs_d1_ = (Label)e.Row.FindControl("effs_d1");
            Label effs_a_ = (Label)e.Row.FindControl("effs_a");
            Label effs_b_ = (Label)e.Row.FindControl("effs_b");
            Label effs_c_ = (Label)e.Row.FindControl("effs_c");
            Label effs_d_ = (Label)e.Row.FindControl("effs_d");
            Label effs_e_ = (Label)e.Row.FindControl("effs_e");
            TextBox effs_f_ = (TextBox)e.Row.FindControl("effs_f");
            Label effs_g_ = (Label)e.Row.FindControl("effs_g");

            if (lb_temlet.Text.Trim().Equals("FY9B"))
            {
                effs_b1_.Text = Convert.ToString(Math.Round(decimal.Parse(effs_b1_.Text) / 30, 3, MidpointRounding.AwayFromZero));
            }
            else
            {
                effs_b1_.Text = Convert.ToString(Math.Round(decimal.Parse(effs_b1_.Text) / 20, 3, MidpointRounding.AwayFromZero));
            }
            
            
            if (effs_a1_.Text.Trim().Equals("0"))
            {
                effs_c1_.Text = Convert.ToString(Math.Round((decimal.Parse(effs_a1_.Text) + decimal.Parse(effs_b1_.Text)) , 3, MidpointRounding.AwayFromZero));
            }
            else
            {
                effs_c1_.Text = Convert.ToString(Math.Round((decimal.Parse(effs_a1_.Text) + decimal.Parse(effs_b1_.Text)) / 2, 3, MidpointRounding.AwayFromZero));
            }


            if (lb_temlet.Text.Trim().Equals("FY9B"))
            {
                effs_b_.Text = Convert.ToString(Math.Round(decimal.Parse(effs_b_.Text) / 30, 3, MidpointRounding.AwayFromZero));
            }
            else
            {

                effs_b_.Text = Convert.ToString(Math.Round(decimal.Parse(effs_b_.Text) / 20, 3, MidpointRounding.AwayFromZero));
            }

            if (effs_a1_.Text.Trim().Equals("0"))
            {
                effs_c_.Text = Convert.ToString(Math.Round((decimal.Parse(effs_a_.Text) + decimal.Parse(effs_b_.Text)) , 3, MidpointRounding.AwayFromZero));
            }
            else {
                effs_c_.Text = Convert.ToString(Math.Round((decimal.Parse(effs_a_.Text) + decimal.Parse(effs_b_.Text)) / 2, 3, MidpointRounding.AwayFromZero));
            
            }

            if (bool.Parse(ViewState["isOver"].ToString()))
            {
                effs_f_.ReadOnly = true;
            }

            try
            {

                t_effs_a_ += decimal.Parse(effs_a_.Text);
                t_effs_b_ += decimal.Parse(effs_b_.Text);
                t_effs_c_ += decimal.Parse(effs_c_.Text);
                t_effs_a1_ += decimal.Parse(effs_a1_.Text);
                t_effs_b1_ += decimal.Parse(effs_b1_.Text);
                t_effs_c1_ += decimal.Parse(effs_c1_.Text);
                t_count_a += decimal.Parse(effs_f_.Text);

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
            effs_f_f.Text = Convert.ToString(Math.Round((decimal)(t_count_a / t_count), 3, MidpointRounding.AwayFromZero));
            to_effs_f.Text = effs_f_f.Text;
            effs_g_f.Text= DataClass.getEffsTitle(Math.Round(decimal.Parse( effs_f_f.Text),3, MidpointRounding.AwayFromZero), "A001");

            effs_a1_f.Text = Convert.ToString(Math.Round(t_effs_a1_ / t_count,3, MidpointRounding.AwayFromZero));
            effs_b1_f.Text = Convert.ToString(Math.Round(t_effs_b1_ / t_count, 3, MidpointRounding.AwayFromZero));
            effs_c1_f.Text = Convert.ToString(Math.Round(t_effs_c1_ / t_count, 3, MidpointRounding.AwayFromZero));
            if ((int)t_effs_c1_ == 0)
            {
                effs_d1_f.Text = "未評";
            }
            else
            {
                effs_d1_f.Text = DataClass.getEffsTitle(Math.Round( (decimal)(t_effs_c1_ / t_count) ,3, MidpointRounding.AwayFromZero), "A001");
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
    protected void GridView7_DataBound(object sender, EventArgs e)
    {

    }
    protected void effs_f_TextChanged(object sender, EventArgs e)
    {
        
        TextBox tb = (TextBox)sender;
        for (int i = 0; i < GridView7.Rows.Count; i++) {
            if (GridView7.Rows[i].Cells[5].Text.Trim().Equals(tb.ValidationGroup.Trim())) 
            {
                
                 Label lb_nobr = (Label)GridView7.Rows[i].FindControl("_nobr");
                Label lb = (Label)GridView7.Rows[i].FindControl("effs_g");
                Label lbc = (Label)GridView7.Rows[i].FindControl("effs_c");
                try
                {
                    EFFDSTableAdapters.EFFS_BASETableAdapter basead = new EFFDSTableAdapters.EFFS_BASETableAdapter();

                    EFFDS.EFFS_BASEDataTable basedt = basead.GetDataBySelectNobr(lb_yy.Text, lb_seq.Text, lb_nobr.Text);
                    if (basedt.Rows.Count > 0) 
                    {
                        basedt[0].effsfinally = tb.Text;
                        basead.Update(basedt);
                        GridView7DataBind();
                        GridView3BataBind();
                    }


                    lb.Text = DataClass.getEffsTitle(decimal.Parse(tb.Text), "A001");
                }
                catch {
                  tb.Text=  lbc.Text;
                }
            
            }
        }
    }

    void GridView7DataBind() 
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            if (!row.MANGE)
            {
                GridView7.Columns[GridView7.Columns.Count - 1 - 3].Visible = false;
                GridView7.Columns[GridView7.Columns.Count - 1 - 2].Visible = false;
               // GridView7.Columns[GridView7.Columns.Count - 1 - 1].Visible = false;
            }
            
            DataClass dc = new DataClass();
            // EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(lb_yy.Text, lb_seq.Text, dc.getChilDeptM(row.DEPTM), row.NOBR);
            ArrayList al = new ArrayList();
            al.Add(lb_select_dept.Text);
            EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(lb_yy.Text, lb_seq.Text, al, row.NOBR);

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
            int yy = int.Parse(lb_yy.Text);
            int seq = int.Parse(lb_seq.Text);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, true, dt[i].nobr, dt[i].templetID, "A001", "B001", "A001", mangnobr.Text);
                EFFMANGDS.EFFS_NUMRow selfrow = DataClass.getEFFSELENUM(yy, seq, true, dt[i].nobr, dt[i].templetID, "A001", "B001", "A001");

                dt[i]["effs_a"] = Convert.ToString(Math.Round(mangrow.apprnum, 3));
                dt[i]["effs_b"] = Convert.ToString(Math.Round(mangrow.catenum, 3));
                dt[i]["effs_c"] = Convert.ToString(Math.Round(mangrow.totnum, 3));


                if ((int)mangrow.totnum == 0)
                {
                    dt[i]["effs_d"] = "未評";
                }
                else
                {
                    dt[i]["effs_d"] = mangrow.effs;
                }
                dt[i]["effs_e"] = 0;

                if(dt[i].IseffsfinallyNull())
                {
                    dt[i]["effs_f"] = Convert.ToString(Math.Round(mangrow.totnum, 1));
                    dt[i]["effs_g"] = mangrow.effs;
                }else
                {
                    try
                    {
                        dt[i]["effs_f"] = decimal.Parse(dt[i].effsfinally);
                        dt[i]["effs_g"] = DataClass.getEffsTitle(decimal.Parse(dt[i].effsfinally), "A001");
                    }
                    catch { }
                }
                
                
                dt[i]["effs_a1"] = Convert.ToString(Math.Round(selfrow.apprnum, 3));
                dt[i]["effs_b1"] = Convert.ToString(Math.Round(selfrow.catenum, 3));
                dt[i]["effs_c1"] = Convert.ToString(Math.Round(selfrow.totnum, 3));

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



            if (RadioButtonList1.SelectedIndex == 0)
            {
                dv.Sort = "jobl";
            }
            else
            {
                dv.Sort = "effs_f desc";
            }

            GridView7.DataSource = dv;
            GridView7.DataBind();
            GridView8.DataSource = dv;
            GridView8.DataBind();
        }
    }
    protected void RadioButtonList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView7DataBind();
        GridView3BataBind();
    }
    protected void PlanText1_TextChanged(object sender, EventArgs e)
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];



            if (decimal.Parse(to_effs_f.Text) < 82 || decimal.Parse(to_effs_f.Text) > 83)
            {
       //         CS.showScriptAlert(UpdatePanel2, "部門評等平均分數應該在82-83分之間，請重新調整！！");
            }
            else
            {
                EFFDS.EMPINFODataTableRow row1 = DataClass.getEmpInfo("931104", DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
                //EFFDS.EMPINFODataTableRow row2 = DataClass.getEmpInfo("100412", DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());

                sendMail(row1.EMAIL, row1.NAME_C, row.NAME_C);
                //sendMail(row2.EMAIL, row2.NAME_C, row.NAME_C);
             //   CS.showScriptAlert(UpdatePanel1, "最後主管評核完成！！");

            }

      
           EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter notead = new EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter();
            EFFMANGDS.EFFS_MANGFINISHNOTEDataTable notedt = notead.GetData(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), row.NOBR);
         
            if (notedt.Rows.Count > 0)
            {
                notedt[0].note = PlanText1.Text;
            }
            else
            {
                notedt.AddEFFS_MANGFINISHNOTERow(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), row.NOBR, row.DEPTM, row.JOB, DateTime.Now, PlanText1.Text);
            }
            notead.Update(notedt);
        }
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

            EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter notead = new EFFMANGDSTableAdapters.EFFS_MANGFINISHNOTETableAdapter();
            EFFMANGDS.EFFS_MANGFINISHNOTEDataTable notedt = notead.GetData(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), row.NOBR);

           
                //EFFDS.EMPINFODataTableRow row2 = DataClass.getEmpInfo("100412", DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());

              //  sendMail(row2.EMAIL, row2.NAME_C, row.NAME_C);
             //   CS.showScriptAlert(UpdatePanel1, "最後主管評核完成！！");
                //  notedt[0].note += "<br>評核完成時為：" + DateTime.Now.ToString();

            string mangnobr_ = DataClass.getMangFromNobr(row.NOBR, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
            EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(mangnobr_, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
            EFFDS.EMPINFODataTableRow row1 = DataClass.getEmpInfo("931104", DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
                if (emprow.cate_order < 75)
                {
                    sendMail1(emprow.EMAIL, row.NAME_C, emprow.NAME_C);
                }
               
                 sendMail(row1.EMAIL, row1.NAME_C, row.NAME_C);



            if (notedt.Rows.Count > 0)
            {
              //  CS.showScriptAlert(UpdatePanel1, "您已於”"+notedt[0].keydate.ToString()+"”,傳送,不可修改本期考核資料！！");
                return;
               // notedt[0].note = PlanText1.Text;
            }
            else
            {
                notedt.AddEFFS_MANGFINISHNOTERow(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), row.NOBR, row.DEPTM, row.JOB, DateTime.Now, PlanText1.Text);
                Button4.Text = "您已於”" + notedt[0].keydate.ToString() + "”,傳送,不可修改本期考核資料！！";
                Button4.Enabled = false;
            }

           
            
            
            
           
            notead.Update(notedt);
        }
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
    int itemIndex = 0;
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            if (itemIndex == 0)
            {
                HtmlTable ht = (HtmlTable)e.Item.FindControl("TABLE2");
                ht.Visible = true;
            }
            itemIndex++;

        }
     
    }
    protected void GridView8_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {
                DataList dl = (DataList)e.Row.FindControl("DataList1");
                Label lb = (Label)e.Row.FindControl("_nobr");
                EFFDS.EMPINFODataTableRow row = DataClass.getEmpInfo(lb.Text, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
                HRDS.DeptAMangDataTableDataTable deptadt = DataClass.getempMang(row.DEPTM, row.MANG, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
                EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = DataClass.getAssignEmpNobr(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), lb.Text);

                DataTable dt = new DataTable();
                dt.Columns.Add("nobr");
                dt.Columns.Add("name");
                dt.Columns.Add("type");
                dt.Columns.Add("adate");

                DataRow selfrow = dt.NewRow();
                selfrow["nobr"] = row.NOBR;
                selfrow["name"] = row.NAME_C;
                selfrow["type"] = "自評";
                selfrow["adate"] = DataClass.getSendEffsTime(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), lb.Text, lb.Text);
                dt.Rows.Add(selfrow);

                for (int i = 0; i < assdt.Rows.Count; i++)
                {
                    DataRow mangrow = dt.NewRow();
                    EFFDS.EMPINFODataTableRow assrow = DataClass.getEmpInfo(assdt[i].assignnobr, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
                    if (assrow != null)
                    {
                        mangrow["nobr"] = assrow.NOBR;
                        mangrow["name"] = assrow.NAME_C;
                        mangrow["type"] = "非直線主管";
                        mangrow["adate"] = DataClass.getSendEffsTime(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), lb.Text, assrow.NOBR);
                        dt.Rows.Add(mangrow);
                    }
                }
                for (int i = 0; i < deptadt.Rows.Count; i++)
                {
                    DataRow mangrow = dt.NewRow();
                    mangrow["nobr"] = deptadt[i].NOBR;
                    mangrow["name"] = deptadt[i].NAME_C;
                    mangrow["type"] = "直線主管";
                    mangrow["adate"] = DataClass.getSendEffsTime(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), lb.Text, deptadt[i].NOBR);
                    dt.Rows.Add(mangrow);
                }
                itemIndex = 0;
                dl.DataSource = dt;
                dl.DataBind();
            }
            catch { }
        }
    }
    protected void CheckBox1_CheckedChanged(object sender, EventArgs e)
    {
        GridView8.Visible = CheckBox1.Checked;
    }
    void sendMail1(string mail, string empname,  string mangname2)
    {
        string sub = "";
        string body = "";
        sub = lb_yy.Text + "年第" + lb_seq.Text + "績效考核資料," + empname + "己經評核完成,請您開始評核及確認！！";



        body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
               "<html xmlns='http://www.w3.org/1999/xhtml'>" +
               "<head>" +
               "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
               "<title></title>" +
               "" +
               "</head>" +
               "" +
               "<body >" +
               mangname2 + " 先生/小姐:<br>" +
                lb_yy.Text + "年第" + lb_seq.Text + "績效考核資料," + empname + "已經評核完成,請您開始評核及確認！！<br>" +
               " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\" <br>" +
               "<br>" +
               "<br>" +
               "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
               "<br>" +
               "</body>" +
               "</html>";
        CS.SendMail(mail, body, sub);


    }
 

    void sendMail(string mail, string empname, string mangname1)
    {
        string sub = "";
        string body = "";
        sub = mangname1 + "," + lb_yy.Text + "年第" + lb_seq.Text + "次績效考核資料," + mangname1 + "己經評核完成！！";



        body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
               "<html xmlns='http://www.w3.org/1999/xhtml'>" +
               "<head>" +
               "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
               "<title></title>" +
               "" +
               "</head>" +
               "" +
               "<body >" +
               empname + " 先生/小姐:<br>" +
                mangname1 + "," + lb_yy.Text + "年第" + lb_seq.Text + "次績效考核資料," + mangname1 + "已經評核完成！<br>" +
               "主管總結意見：<br>" +PlanText1.Text+
               "<br>" +
               "<br>" +
               "<font color='red'>【如執行績效考核有問題，請連絡人事單位】</font><br>" +
               "<br>" +
               "</body>" +
               "</html>";
        CS.SendMail(mail, body, sub);


    }
    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {
        lb_select_dept.Text = TreeView1.SelectedNode.Value;

        GridView7DataBind();
        GridView3BataBind();
      
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
            ArrayList al = new ArrayList();
            al.Add(lb_select_dept.Text);
            EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(lb_yy.Text, lb_seq.Text, al, row.NOBR);
            dt.Columns.Add("f_mang_num", typeof(System.Decimal));
            dt.Columns.Add("f_mang_ef", typeof(System.Int32));




            //effsgroupID

            DataView dv = dt.DefaultView;
            dv.RowFilter = "effsgroupID ='" + groupid + "'";


            //for (int i = 0; i < dv.Count; i++)
            //{
            //    dv[i].Row["f_mang_num"] = DataClass.getMang_F_Num(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), dv[i].Row["nobr"].ToString(), row.NOBR);
            //}

            //dv.Sort = "f_mang_num desc ";

            //int ef = 0;
            //decimal f_mang_num = 0;
            //for (int i = 0; i < dv.Count; i++)
            //{
            //    if (f_mang_num == decimal.Parse(dv[i].Row["f_mang_num"].ToString()))
            //    {

            //    }
            //    else
            //    {
            //        ef += 1;
            //        f_mang_num = decimal.Parse(dv[i].Row["f_mang_num"].ToString());
            //    }
            //    dv[i].Row["f_mang_ef"] = ef;

            //}

            //dv.Sort = "f_mang_num desc ";

            gv.DataSource = dv;
            gv.DataBind();
        }
    }
    protected void GridView3_RowDataBound1(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType != DataControlRowType.DataRow)
            return;

        GridView gv = e.Row.FindControl("gv_mang") as GridView;
        Label effsgroupname = e.Row.FindControl("effsgroupname") as Label;
        Label templetID = e.Row.FindControl("templetID") as Label;
        TextBox m_num = e.Row.FindControl("m_num") as TextBox;
        string _nobr = e.Row.Cells[1].Text;
        HyperLink hll = e.Row.FindControl("HyperLink1") as HyperLink;
        ArrayList  ss_nobr = DataClass.getMangsFromNobr(_nobr, DateTime.Now.ToShortDateString());
        if (ss_nobr.Contains(mangnobr.Text.Trim()))
        {
            hll.Visible = true;
        }
        else
        {
            hll.Visible = false;
        }

        if (gv != null)
        {
            if (Session["empInfo"] == null)
                Response.Redirect("./login.aspx");

            EFFDS.EMPINFODataTableRow UserRow = (EFFDS.EMPINFODataTableRow)Session["empInfo"];


            int mangorder = UserRow.cate_order;
            EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr);
            EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assing = DataClass.getAssignEmpNobr(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr);
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

            for (int i = 0; i < arrpmang.Rows.Count; i++)
            {

                EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];






                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text)).ToShortDateString());
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
                                ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim() + "[指派]");


                            }

                        }

                    }
                }


            }




            int index = 1;
            int add = al_nobr.Count;
            Decimal t_t_num = 0;
            DataTable dtCate = DataClass.getTempletCateType(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr, templetID.Text, true);

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
                        DataTable s_dt = DataClass.getSelfType(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr, templetID.Text, true, dtCate.Rows[k]["type"].ToString());
                        for (int j = 0; j < s_dt.Rows.Count; j++)
                        {
                            nrow[i + 1] = s_dt.Rows[j]["加權分數"].ToString();
                        }
                    }
                    else
                    {

                        DataTable m_dt = DataClass.getMangType(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr, templetID.Text, true, al_nobr[i].ToString(), dtCate.Rows[k]["type"].ToString());

                        for (int j = 0; j < m_dt.Rows.Count; j++)
                        {
                            nrow[i + 1] = m_dt.Rows[j]["加權分數"].ToString();
                        }
                    }

                }
                dt.Rows.Add(nrow);
            }


            DataRow trow = dt.NewRow();
            trow[0] = "總分數：";
            DataRow frow = dt.NewRow();
            frow[0] = "評分調整";
            int d_count = dt.Rows.Count;

            for (int k = 0; k < dt.Rows.Count; k++)
            {
                for (int i = 1; i < dt.Columns.Count; i++)
                {
                    decimal dd = 0;
                    try
                    {
                        dd = decimal.Parse(dt.Rows[k][i].ToString())  ;
                    }
                    catch { }
                    decimal num = 0;
                    try
                    {
                        num = decimal.Parse(trow[i].ToString()) ;


                    }
                    catch { }
                    if (k == 0)
                    {
                        trow[i] = Convert.ToString((num + dd));
                    }
                    else {
                        trow[i] = Convert.ToString((num + dd)/ d_count);
                    
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
                    mm_num = 0; //DataClass.getMang_F_Num(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr, al_nobr[i - 1].ToString());
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
                    frow[i] = trow[i];
                    mm_num = decimal.Parse(frow[i].ToString());
                    try
                    {
                     //   DataClass.SaveMang_F_Num(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text), _nobr, al_nobr[i - 1].ToString(), lb_select_dept.Text, mm_num);
                    }
                    catch { }

                }
                else
                {
                    frow[i] = mm_num;
                }
                try
                {
                    if (mangnobr.Text.Trim().Equals(al_nobr[i - 1].ToString().Trim()))
                    {
                        m_num.Text = mm_num.ToString();
                    }




                }
                catch { }

            }

            if (decimal.Parse(m_num.Text) == 0)
            {

                m_num.Text = t_t_num.ToString();
            }
            dt.Rows.Add(frow);


            if (bool.Parse(ViewState["isOver"].ToString()))
            {
                m_num.ReadOnly = true;
            }
         //   if (!bool.Parse(ViewState["topMang"].ToString()))
         //   {
         //       m_num.ReadOnly = true;
        //    }


            gv.DataSource = dt;
            gv.DataBind();

        }
    }
    protected void m_num_TextChanged(object sender, EventArgs e)
    {

    }
    void GridView3BataBind()
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

            DataClass dc = new DataClass();
            ArrayList all = new ArrayList();
            all.Add(lb_select_dept.Text);
            EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(lb_yy.Text, lb_seq.Text, all, row.NOBR);


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
