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

public partial class HR_EFF007 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            checkDate.Text = DateTime.Now.ToShortDateString();

        }

    }
    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        checkData(e);
    }
    protected void Wizard1_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
    {
        checkData(e);
    }

    void checkData(WizardNavigationEventArgs e) {
        if (e.CurrentStepIndex == 0)
        {
            if (GridView1.SelectedIndex < 0)
            {
                e.Cancel = true;
                Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先選擇考核時間！');</script>");
            }

        }
        else if (e.CurrentStepIndex == 2)
        {
            EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
            EFFDS.EMPINFODataTableDataTable empdt = new EFFDS.EMPINFODataTableDataTable();
             EFFDS.EMPINFODataTableRow [] rows=null;


            if (Menu2.SelectedValue.Trim().Equals("1"))
            {
                if (lbnobr.Items.Count == 0)
                {
                    e.Cancel = true;
                }
                for (int i = 0; i < lbnobr.Items.Count; i++)
                {
                    empdt.Merge(empad.GetDataByNobr(lbnobr.Items[i].Value,DateTime.Parse( DateTime.Now.ToShortDateString())));
                    rows = (EFFDS.EMPINFODataTableRow[])empdt.Select();
                }

            }
            else
            {
                
                string parmeter ="";
                int month =0 ;
                if (!cb_indate.Checked && !cb_jobl.Checked && !cb_jobs.Checked && !CheckBox1.Checked && !cb_job.Checked && !cb_mang.Checked && !cb_di.Checked)
                {
                    e.Cancel = true;
                    Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('要先選擇條件項目！');</script>");

                }
                if (CheckBox1.Checked) 
                {
                    if (t_yy.Text.Trim().Length <= 0)
                    {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先輸入到到職年份！');</script>");

                    }
                    if (t_mm.Text.Trim().Length <= 0)
                    {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先輸入到到職月份！');</script>");

                    }

                    parmeter = "  indt >= '" + t_yy.Text + "/" + t_mm.Text + "/1'" + " and indt <=  '" + t_yy.Text + "/" + t_mm.Text + "/" + DateTime.DaysInMonth(int.Parse(t_yy.Text),int.Parse( t_mm.Text)).ToString() + "' ";
                }
                if (cb_indate.Checked)
                {
                    if (TextBox1.Text.Trim().Length <= 0)
                    {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先輸入到職月數！');</script>");

                    }
                    else
                    {
                        try
                        {
                            month = int.Parse(TextBox1.Text);
                        }
                        catch
                        {
                            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('職月數只能輸入數值！');</script>");

                        }

                        DateTime dt = DateTime.Parse(checkDate.Text);
                        dt = dt.AddMonths(-3);
                        parmeter = "  indt <= '" + dt .ToShortDateString()+ "' ";
                     
                        
                    }
                }
                if (cb_mang.Checked) 
                {
                    bool ismang = false;
                    if (RBL_Mang.SelectedIndex == null || RBL_Mang.SelectedIndex < 0) {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先選擇！');</script>");
                    }

                    if (parmeter.Trim().Length > 0)
                        parmeter += " and ";
                    if (RBL_Mang.SelectedIndex == 0) {
                       
                        parmeter += "mang = 1 ";
                    }
                    else {
                  
                        parmeter += " mang = 0 ";
                    }

   
                }

                if (cb_di.Checked) {
                    if (RBL_DI.SelectedIndex == null || RBL_DI.SelectedIndex < 0) {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先選擇！');</script>");
                    }

                    if (parmeter.Trim().Length > 0)
                        parmeter += " and ";
                    if (RBL_DI.SelectedIndex == 0) {

                        parmeter += " DI = 'I' ";
                    }
                    else {

                        parmeter += " DI = 'D' ";
                    }

                }

                if (cb_job.Checked) {
                    int index = 0;
                    string value = "";
                    ArrayList al = new ArrayList();
                    for (int i = 0; i < cbl_job.Items.Count; i++) {
                        if (cbl_job.Items[i].Selected) {
                            al.Add(cbl_job.Items[i].Value);
                            index++;
                        }
                    }
                    if (index == 0) {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先選擇職稱！');</script>");
                    }
                    if (al.Count > 0) {
                        for (int i = 0; i < al.Count; i++) {
                            value += "'" + al[i].ToString().Trim() + "'";
                            if (i < al.Count - 1) {
                                value += ',';
                            }
                        }
                        if (parmeter.Trim().Length > 0)
                            parmeter += " and ";
                        parmeter += "job in(" + value + ")";
                    }

                }



                if (cb_jobl.Checked)
                {
                    int index = 0;
                    string value="";
                    ArrayList al = new ArrayList();
                    for (int i = 0; i < cbl_jobl.Items.Count; i++)
                    {
                        if (cbl_jobl.Items[i].Selected)
                        {
                            al.Add(cbl_jobl.Items[i].Value);
                            index++;
                        }
                    }
                    if (index == 0)
                    {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先選擇職等！');</script>");
                    }
                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {
                            value += "'" + al[i].ToString().Trim() + "'";
                            if (i < al.Count - 1)
                            {
                                value += ',';
                            }
                        }
                        if (parmeter.Trim().Length > 0)
                            parmeter += " and ";
                        parmeter += "jobl in(" + value + ")";
                    }

                }
                if (cb_jobs.Checked)
                {
                    int index = 0;
                    string value = "";
                    ArrayList al = new ArrayList();
                    for (int i = 0; i < CheckBoxList2.Items.Count; i++)
                    {
                        if (CheckBoxList2.Items[i].Selected)
                        {
                            al.Add(cbl_jobl.Items[i].Value);
                            index++;
                        }
                    }
                    if (index == 0)
                    {
                        e.Cancel = true;
                        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請先選擇職系！');</script>");
                    }
                    if (al.Count > 0)
                    {
                        for (int i = 0; i < al.Count; i++)
                        {
                            value += "'" + al[i].ToString().Trim() + "'";
                            if (i < al.Count - 1)
                            {
                                value += ',';
                            }
                        }
                        if (parmeter.Trim().Length > 0)
                            parmeter += " and ";
                        parmeter += "jobs in(" + value + ")";
                    }
                }

                empdt.Merge(empad.GetData(DateTime.Now.ToShortDateString()));
                rows = (EFFDS.EMPINFODataTableRow[])empdt.Select(parmeter);
               
            }
           
            lbCount.Text = rows.Length.ToString();
            GridView2.DataSource = rows;
            GridView2.DataBind();
            if (Session["empinfo_007"] != null)
                Session.Remove("empinfo_007");

            Session.Add("empinfo_007", rows);
        }
    
    }
    protected void Menu2_MenuItemClick(object sender, MenuEventArgs e)
    {
        MultiView2.ActiveViewIndex = int.Parse(e.Item.Value);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        EFFDSTableAdapters.EMPINFOTableAdapter empad = new EFFDSTableAdapters.EMPINFOTableAdapter();
        EFFDS.EMPINFODataTableDataTable empdt = empad.GetDataByNobr(tbnobr.Text,DateTime.Parse( DateTime.Now.ToShortDateString()));
        if (empdt.Rows.Count > 0)
        {
            EFFDS.EMPINFODataTableRow emprow = (EFFDS.EMPINFODataTableRow)empdt.Rows[0];
            ListItem li = new ListItem(emprow.NOBR.Trim() + "-" + emprow.NAME_C.Trim(), emprow.NOBR);
            if (!lbnobr.Items.Contains(li))
            {
                lbnobr.Items.Add(li);
            }
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        lbnobr.Items.RemoveAt(lbnobr.SelectedIndex);
    }
    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (Session["empinfo_007"] == null){
            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('還沒有產生名單！');</script>");
            e.Cancel = true;
            return;
        }
        
        EFFDS.EMPINFODataTableRow[] rows = (EFFDS.EMPINFODataTableRow[])Session["empinfo_007"];
        if (rows.Length == 0) {
            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('還沒有產生名單！');</script>");
            e.Cancel = true;
            return;
        }
        EFFDSTableAdapters.EFFS_ATTENDTableAdapter attendad = new EFFDSTableAdapters.EFFS_ATTENDTableAdapter();
        EFFDS.EFFS_ATTENDDataTable attenddt = attendad.GetDataByID((int)GridView1.SelectedValue);
        
        if (attenddt.Rows.Count == 0) 
        {
            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('請重新點選考核時間！');</script>");
            e.Cancel = true;
            return;
        }
        EFFDS.EFFS_ATTENDRow attrow = (EFFDS.EFFS_ATTENDRow)attenddt.Rows[0];
        DataTable errordt = new DataTable();
        errordt.Columns.Add("nobr");
        errordt.Columns.Add("name");
        errordt.Columns.Add("msg");

        EFFDSTableAdapters.EFFS_GROUPITEMTableAdapter groupsAD = new EFFDSTableAdapters.EFFS_GROUPITEMTableAdapter();
        EFFDS.EFFS_GROUPITEMDataTable groupsDT = groupsAD.GetData();
        EFFDSTableAdapters.EFFS_BASETableAdapter basead = new EFFDSTableAdapters.EFFS_BASETableAdapter();
     

        for (int i = 0; i < rows.Length; i++)
        {
            EFFDS.EFFS_BASEDataTable basedt = new EFFDS.EFFS_BASEDataTable();
            EFFDS.EMPINFODataTableRow row = rows[i];
            EFFDS.EFFS_BASERow newrow = basedt.NewEFFS_BASERow();


            newrow.effbaseID = attrow.yy.ToString() + attrow.seq.ToString() + row.NOBR.Trim() + row.DEPT.Trim();
            newrow.yy = attrow.yy.ToString();
            newrow.seq = attrow.seq.ToString();
            newrow.templetID = ddlTmp.SelectedValue;
            newrow.nobr = row.NOBR;
            newrow.dept = row.DEPT;
            newrow.depts = row.DEPTS;
            newrow.JOB = row.JOB;
            newrow.jobl = row.JOBL;
            newrow.depta = row.DEPTM;
            newrow.stddate = attrow.StdDate;
            newrow.enddate = attrow.EndDate;
            newrow.firstdate = DateTime.Now;
            newrow.deptorder = "";
            newrow.jobplan = "";
            newrow.mangfinish = false;
            newrow.isdeff = false;
            DataRow[] _grRows = groupsDT.Select("jobl='" + row.JOBL + "'");
            //if (_grRows.Length > 0)
            //{
            //    newrow.effsgroupID = _grRows[0]["effsgroupID"].ToString();

            //}
            //else
            //{
            //    newrow.effsgroupID = "";
            //}
            newrow.effsgroupID = GridView4.SelectedValue.ToString();
            basedt.AddEFFS_BASERow(newrow);
            try
            {
                basead.Update(basedt);
            }
            catch (Exception ex)
            {
                DataRow r = errordt.NewRow();
                r[0] = row.NOBR;
                r[1] = row.NAME_C;
                r[2] = ex.Message;
                errordt.Rows.Add(r);
            }

        }

        gb_error.DataSource = errordt;
        gb_error.DataBind();
        Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('產生完成！');</script>");
        Wizard1.ActiveStepIndex = 0;


    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        MultiView1.ActiveViewIndex = int.Parse(Menu1.SelectedValue);
    }
    protected void Button4_Click(object sender, EventArgs e)
    {
        EFFDSTableAdapters.EFFS_ATTENDTableAdapter attendad = new EFFDSTableAdapters.EFFS_ATTENDTableAdapter();
        EFFDS.EFFS_ATTENDDataTable attenddt = attendad.GetDataByID(int.Parse(DropDownList1.SelectedValue));
        if (attenddt.Rows.Count == 0)
        {
            Page.ClientScript.RegisterClientScriptBlock(typeof(string), "alert", "<script>alert('資料有問題！');</script>");
            return;
        }
        EFFDS.EFFS_ATTENDRow attrow = (EFFDS.EFFS_ATTENDRow)attenddt.Rows[0];
        lb_seq.Text = attrow.seq.ToString();
        lb_yy.Text = attrow.yy.ToString();

        if (tb_nobr.Text.Trim().Length > 0)
        {
            GridView3.DataSourceID = "ObjectDataSource2";
            GridView3.DataBind();

        }
        else {
            GridView3.DataSourceID = "ObjectDataSource1";
            GridView3.DataBind();
        }


    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView3.DataBind();
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        
    }
}
