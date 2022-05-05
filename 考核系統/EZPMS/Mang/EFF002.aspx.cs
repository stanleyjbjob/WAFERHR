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

public partial class Mang_EFF002 : System.Web.UI.Page
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
    public void getDeptTreeData() {
        if (Session["empInfo"] != null) {
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
            for (int i = 0; i < deptdt.Rows.Count; i++) {
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

    public void setTreeNodes(TreeNode p_node, HRDS.DEPTADataTable deptAllDt) {
        HRDS.DEPTARow[] depts = (HRDS.DEPTARow[])deptAllDt.Select("DEPT_GROUP='" + p_node.Value + "'");
        for (int i = 0; i < depts.Length; i++) {
            TreeNode nodes = new TreeNode();
            nodes.Text = depts[i].D_NAME;
            nodes.Value = depts[i].D_NO;

            setTreeNodes(nodes, deptAllDt);
            p_node.ChildNodes.Add(nodes);
        }
    }
    protected void Page_Load(object sender, EventArgs e)
    {

        if (!IsPostBack) {
            Page.ClientScript.RegisterClientScriptInclude("FTB-FreeTextBox", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-FreeTextBox.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Utility", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Utility.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Toolbars", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ToolbarItems.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-ImageGallery", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ImageGallery.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Pro", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Pro.js"));


            _ratenum.Text = "0.0";
            _ratenum1.Text = "0.0";
            int _month = 1;


            DropDownList3.SelectedValue = DateTime.Now.Year.ToString() + "," + _month;
            _yy.Text = "0";// DateTime.Now.Year.ToString();
            _seq.Text = "0";// _month.ToString();
            note.Text = DataClass.getNote("Mang.EFF002.aspx");

            Session.Add("EFF004Attend", DataClass.getEffsAttendDataTable());
            if (Session["empInfo"] != null) {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                DataClass dc = new DataClass();
                EFFDS.EMPINFODataTableDataTable empdt = dc.getDeptMChildEmpInfo(row.DEPTM, row.NOBR, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                GridView2.DataSource = empdt;
                GridView2.DataBind();
            }
            getDeptTreeData();
        }
        else {

            
        }
    }
    void setValue(string nobr)
    {
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(nobr, DateTime.Now.ToShortDateString());// DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
        if (emprow != null) {
            name_c.Text = emprow.NAME_C;
            lb_nobr.Text = emprow.NOBR;
            indt.Text = emprow.INDT.ToShortDateString();
            dept.Text = emprow.DEPTNAME;
            deps.Text = emprow.DEPTSNAME;
            job.Text = emprow.JOBNAME;
            jobl.Text = emprow.JOBLNAME;

        }
    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        MultiView1.ActiveViewIndex = 0;
    }
    protected void GridView2_SelectedIndexChanged(object sender, EventArgs e)
    {
        GridView gv = (GridView)sender;
        setValue(gv.SelectedValue.ToString());
        MultiView1.ActiveViewIndex = 1;
    }
    double _rotecount = 0;
   
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer) 
        {
             
            e.Row.Cells[3].Text = "年度比重總分：";
            e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[3].ForeColor = System.Drawing.Color.White;
            e.Row.Cells[3].Font.Bold = true;
            e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
            e.Row.Cells[4].Text = _ratenum.Text;
        }
   
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            //LinkButton1


            //GridViewRow insertedRow = new GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal);
            //// 
            //TableCell cell = new TableCell();
            //insertedRow.Cells.Add(cell);
            //// 基本属性
            //cell.ColumnSpan = GridView1.Columns.Count; // 横跨所有列
            //cell.Text = "&nbsp;";
            //cell.Width = new Unit(10, UnitType.Pixel);
            //// 添加自定义内容

            //TextBox txt = new TextBox();
            //txt.Text = ((DataRowView)e.Row.DataItem)["rate"].ToString();
            //cell.Controls.Add(txt);
            //// ...
            //// ...
            //// 默认隐藏此行
            //// insertedRow.Attributes["style"] = "display:none";
            //// 
            //GridView1.Controls[0].Controls.Add(insertedRow);

            Label autoKey = (Label)e.Row.FindControl("autoKey");

            if (DataClass.checkApprTts(int.Parse(autoKey.Text)))
            {
                e.Row.Cells[3].Font.Italic = true;
                e.Row.Cells[4].Font.Italic = true;
                e.Row.Cells[3].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Red;
                
            }
            EFFDS.EFFS_APPRRow approw = DataClass.getEFFS_APPRRow(int.Parse(autoKey.Text));
            if (!approw.IsrealityNull() && approw.reality.Trim().Equals("True")) 
            {
                e.Row.Cells[3].Font.Italic = true;
                e.Row.Cells[4].Font.Italic = true;
                e.Row.Cells[3].ForeColor = System.Drawing.Color.Blue;
                e.Row.Cells[4].ForeColor = System.Drawing.Color.Blue;
                
            }

             
            CheckBox cb = (CheckBox)e.Row.FindControl("cb_included");
            //cb_mangCheck
            CheckBox cb_mangCheck = (CheckBox)e.Row.FindControl("cb_mangCheck");
          //  Label tb_rate = (Label)e.Row.FindControl("tb_rate");
           // if (tb_rate != null) {
            if (cb_mangCheck.Checked)
            {
                try
                {
                    _rotecount += double.Parse(e.Row.Cells[5].Text);
                }
                catch { }
            }
         //   }
            _ratenum.Text = _rotecount.ToString("0.0");
            _ratenum1.Text = _rotecount.ToString("0.0");
            if (cb.Checked)
            {
                try
                {
                    Label lb_yy = (Label)e.Row.FindControl("lb_yy");
                    Label lb_seq = (Label)e.Row.FindControl("lb_seq");
                  
                }
                catch (Exception ex)
                {
                    CS.ErrorLog(Session["nobr"].ToString(), "Mang/EFF002.aspx", ex.Message);
                }

            }
         

        }
    }
  
    
    protected void cb_mangCheck_CheckedChanged(object sender, EventArgs e)
    {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
        CheckBox cb = (CheckBox)sender;
        EFFDSTableAdapters.EFFS_APPRTableAdapter appad = new EFFDSTableAdapters.EFFS_APPRTableAdapter();
        EFFDS.EFFS_APPRDataTable appdt = appad.GetDataByID(int.Parse(cb.ValidationGroup));
        if (appdt.Rows.Count > 0)
        {
            EFFDS.EFFS_APPRRow approw = (EFFDS.EFFS_APPRRow)appdt.Rows[0];

            approw.mangCheck = cb.Checked;
            if (cb.Checked)
            {
               
                approw.mangname = row.NAME_C;
            }
            else {
                approw.mangname = "";
            }
            approw.mangcheckDate = DateTime.Now;
            appad.Update(appdt);
            GridView1.DataBind();

        }
    }
    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        string[] value = DropDownList3.SelectedValue.ToString().Split(',');
        _yy.Text = value[0];
        _seq.Text = value[1];
    }
    protected void Button1_Click(object sender, EventArgs e)
    {

        EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
        EFFDSTableAdapters.EFFS_APPRTableAdapter appad = new EFFDSTableAdapters.EFFS_APPRTableAdapter();

        for (int i = 0; i < GridView1.Rows.Count; i++)
        {
            GridViewRow gv = GridView1.Rows[i];
            CheckBox mangCheck = (CheckBox)gv.FindControl("cb_mangCheck");
            CheckBox included = (CheckBox)gv.FindControl("cb_included");
            Label tb_rate = (Label)gv.FindControl("tb_rate");
            EFFDS.EFFS_APPRDataTable appdt = appad.GetDataByID(int.Parse(mangCheck.ValidationGroup));
            if (appdt.Rows.Count > 0)
            {
                EFFDS.EFFS_APPRRow approw = (EFFDS.EFFS_APPRRow)appdt.Rows[0];
                if (!approw.mangCheck.ToString().Trim().Equals(mangCheck.Checked.ToString().Trim()))
                {
                    if (mangCheck.Checked)
                    {
                        approw.mangname = row.NAME_C;
                    }
                    else
                    {
                        approw.mangname = "";
                    }
                    approw.mangCheck = mangCheck.Checked;
                    approw.mangcheckDate = DateTime.Now;

                }
                approw.included = included.Checked;
                approw.rate = tb_rate.Text;
                appad.Update(appdt);

            }


        }
        _rotecount = 0;
        GridView1.DataBind();

    }
    protected void GridView1_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
       
    }
    protected void GridView1_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
    {
     
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        try {
            if (decimal.Parse(_ratenum1.Text) != 100) {
              //  CS.showScriptAlert(UpdatePanel2, "注意！員工工作目標\"比重\"未達或超過100%！");
            }
        }
        catch { }
    }
    protected void GridView1_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        try
        {
            GridViewRow row = (GridViewRow)((Control)e.CommandSource).Parent.Parent;
            if (e.CommandName.Trim().Equals("Select1"))
            {
                _autokey.Text = e.CommandArgument.ToString();
                GridView3.DataBind();

                EFFDS.EFFS_APPRRow approw= DataClass.getEFFS_APPRRow(int.Parse(_autokey.Text));
            //    e_works.Text = approw.works;
            //    e_rate.Text = approw.rate;
            }


        }
        catch 
        
        { }
    }
   
    EFFMANGDSTableAdapters.EFFS_APPRTTSTableAdapter ttsad = new EFFMANGDSTableAdapters.EFFS_APPRTTSTableAdapter();
    
    protected void Button1_Click1(object sender, EventArgs e)
    {

        //if (Session["empInfo"] != null)
        //{
        //    EFFDSTableAdapters.EFFS_APPRTableAdapter apprad = new EFFDSTableAdapters.EFFS_APPRTableAdapter();
        //    EFFDS.EFFS_APPRDataTable apprdt = apprad.GetDataByID(int.Parse(_autokey.Text));
        //    EFFDS.EFFS_APPRRow approw = null;
        //    if (apprdt.Rows.Count > 0)
        //    {
        //        approw = (EFFDS.EFFS_APPRRow)apprdt.Rows[0];
        //        if (approw.rate.Trim().Equals(e_rate.Text.Trim()) && approw.works.Trim().Equals(e_works.Text.Trim()))
        //            return;

        //        EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

        //        EFFMANGDS.EFFS_APPRTTSDataTable ttsdt = ttsad.GetDataByID(int.Parse(_autokey.Text), "0");
        //        if (ttsdt.Rows.Count > 0)
        //        {
        //            ttsdt.AddEFFS_APPRTTSRow(int.Parse(_autokey.Text), e_works.Text, "", e_rate.Text, "", "", "", DateTime.Now, row.NAME_C, "1", DateTime.Now.AddDays(-1), DateTime.Parse("9999/12/31"));
        //        }
        //        else
        //        {
        //            ttsdt.AddEFFS_APPRTTSRow(int.Parse(_autokey.Text), approw.works, "", approw.rate, "", "", "", DateTime.Now, name_c.Text, "0", DateTime.Now.AddDays(-1), DateTime.Parse("9999/12/31"));
        //            ttsdt.AddEFFS_APPRTTSRow(int.Parse(_autokey.Text), e_works.Text, "", e_rate.Text, "", "", "", DateTime.Now, row.NAME_C, "1", DateTime.Now.AddDays(-1), DateTime.Parse("9999/12/31"));
        //        }
        //        approw.works = e_works.Text;
        //        approw.rate = e_rate.Text;

        //        ttsad.Update(ttsdt);
        //        apprad.Update(apprdt);
        //        GridView3.DataBind();
        //        GridView1.DataBind();
        //    }
        //}
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        //if (Session["empInfo"] != null)
        //{
        //    EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
        //    EFFDSTableAdapters.EFFS_APPRTableAdapter apprad = new EFFDSTableAdapters.EFFS_APPRTableAdapter();
        //    EFFDS.EFFS_APPRDataTable apprdt = new EFFDS.EFFS_APPRDataTable();
        //    apprdt.AddEFFS_APPRRow(lb_nobr.Text, e_works.Text, "", e_rate.Text,, "", "", "True", true, DateTime.Now, row.NOBR, DateTime.Now, true, int.Parse(_yy.Text), int.Parse(_seq.Text));
        //    apprad.Update(apprdt);
        //    GridView3.DataBind();
        //    GridView1.DataBind();
        //}
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        string[] value = DropDownList3.SelectedValue.ToString().Split(',');
        _yy.Text = value[0];
        _seq.Text = value[1];
        EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
        //reality
        e.Values["reality"] = true;
        e.Values["key_date"] = DateTime.Now;
        //mangCheck
        e.Values["mangname"] = row.NAME_C;
        e.Values["mangCheck"] = true;
        e.Values["mangCheckDate"] = DateTime.Now;
        e.Values["included"] = true;
        e.Values["nobr"] = lb_nobr.Text;
        e.Values["yy"] = _yy.Text;
        e.Values["seq"] = _seq.Text;
        
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView3.DataBind();
        GridView1.DataBind();
        CS.showScriptAlert(UpdatePanel2, "新增完成！");
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["yy"] = _yy.Text;
        e.NewValues["seq"] = _seq.Text;
        e.NewValues["included"] = true;
        if (Session["empInfo"] != null)
        {
            if (e.OldValues["rate"].ToString().Trim().Equals(e.NewValues["rate"].ToString()) && 
                e.OldValues["works"].ToString().Trim().Equals(e.NewValues["works"].ToString()) &&
                e.OldValues["standard"].ToString().Trim().Equals(e.NewValues["standard"].ToString()) &&
              e.OldValues["appr"].ToString().Trim().Equals(e.NewValues["appr"].ToString()))
                    return;

                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

                EFFMANGDS.EFFS_APPRTTSDataTable ttsdt = ttsad.GetDataByID(int.Parse(GridView1.SelectedValue.ToString()), "0");
                if (ttsdt.Rows.Count > 0)
                {
                    ttsdt.AddEFFS_APPRTTSRow(int.Parse(GridView1.SelectedValue.ToString()), e.NewValues["works"].ToString(), e.NewValues["standard"].ToString(), e.NewValues["rate"].ToString(), e.NewValues["appr"].ToString(), "", "", DateTime.Now, row.NAME_C, "1", DateTime.Now.AddDays(-1), DateTime.Parse("9999/12/31"));
                }
                else
                {
                    ttsdt.AddEFFS_APPRTTSRow(int.Parse(GridView1.SelectedValue.ToString()), e.OldValues["works"].ToString(), e.OldValues["standard"].ToString(), e.OldValues["rate"].ToString(), e.OldValues["appr"].ToString(), "", "", DateTime.Now, name_c.Text, "0", DateTime.Now.AddDays(-1), DateTime.Parse("9999/12/31"));
                    ttsdt.AddEFFS_APPRTTSRow(int.Parse(GridView1.SelectedValue.ToString()), e.NewValues["works"].ToString(), e.NewValues["standard"].ToString(), e.NewValues["rate"].ToString(), e.NewValues["appr"].ToString(), "", "", DateTime.Now, row.NAME_C, "1", DateTime.Now.AddDays(-1), DateTime.Parse("9999/12/31"));
                }
           
                ttsad.Update(ttsdt);

              
            
        }

    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {

        GridView3.DataBind();
        GridView1.DataBind();
        CS.showScriptAlert(UpdatePanel2, "修改完成！");

    }
    protected void Button8_Click(object sender, EventArgs e) {
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(lb_nobr.Text, DateTime.Now.ToShortDateString());// DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
        string mail = "";
        string sub = "";
        string body = "";
        if (Session["empInfo"] != null) {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            sub = row.NAME_C + ",已經確認" + _yy.Text + "年工作目標！！";


            if (emprow != null) {

                body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
                       "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                       "<head>" +
                       "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
                       "<title></title>" +
                       "" +
                       "</head>" +
                       "" +
                       "<body >" +
                       emprow.NAME_C + " 先生/小姐:<br>" +
                       "您的主管" + row.NAME_C + ",已經確認" + _yy.Text + "年工作目標！！<br>" +
                       " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\"  ,查看確認後之目標及比重以利後續工作目標之執行！<br>" +
                       "<br>" +
                       "<br>" +
                       "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
                       "<br>" +
                       "</body>" +
                       "</html>";
                mail = emprow.EMAIL;
                CS.SendMail(mail, body, sub, UpdatePanel1);

            }
        }
    }

    protected void Button9_Click(object sender, EventArgs e) {
        string[] value = DropDownList3.SelectedValue.ToString().Split(',');
        _yy.Text = value[0];
        _seq.Text = value[1];
        GridView1.DataBind();
    }
    protected void GridView4_DataBinding(object sender, EventArgs e) {

    }
    protected void GridView4_RowCreated(object sender, GridViewRowEventArgs e) {
        if (e.Row.Cells[e.Row.Cells.Count - 1].Text.Trim().ToUpper().Equals("D")) {

            e.Row.Visible = false;
        }
        
    }
    protected void GridView4_DataBound(object sender, EventArgs e) {

     
    }
    protected void Button10_Click(object sender, EventArgs e) {
        MultiView2.ActiveViewIndex = 1;
        Qryframe.Attributes.Add("SRC", "../empInfo.aspx?nobr=" + GridView4.SelectedValue.ToString());

    }
    protected void Button11_Click(object sender, EventArgs e) {
        MultiView2.ActiveViewIndex = 0;
    }
    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e) {
        lb_select_dept.Text = TreeView1.SelectedNode.Value;

        GridView4.DataBind();
    }
    protected void GridView4_RowDataBound(object sender, GridViewRowEventArgs e) {
        if (Session["empInfo"] != null) {
            if (e.Row.RowType == DataControlRowType.DataRow) {

                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                if (e.Row.Cells[1].Text.Trim().Equals(row.NOBR.Trim())) {
                    e.Row.Visible = false;
                }
            }
        }
    }
    protected void DropDownList3_DataBound(object sender, EventArgs e)
    {
        DropDownList3.Items.Insert(0, new ListItem("＊請選擇目標年度＊", "0,0"));
    }
}
