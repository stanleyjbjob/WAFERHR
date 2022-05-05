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

public partial class Mang_EFF007 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Session["empInfo"] != null)
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                _nobr.Text = row.NOBR;
                _dept.Text = row.DEPTM;
                
            }
            note.Text = DataClass.getNote("Mang.EFF007.aspx");
        }
    }
   
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        _yy.Text = GridView1.SelectedRow.Cells[1].Text;
        _seq.Text = GridView1.SelectedRow.Cells[2].Text;
       
        DataClass dc = new DataClass();
        EFFDS.EFFS_BASEDataTable dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(_yy.Text, _seq.Text, dc.getChilDeptM(_dept.Text), _nobr.Text);
       
        dt.Columns.Add("mangname");
        dt.Columns.Add("mangjob");

        for (int i = 0; i < dt.Rows.Count; i++) 
        {
            bool ismang = false;
            ismang = DataClass.ISMANG(dt[i].nobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());


            HRDS.DeptAMangDataTableDataTable manginfo = DataClass.getempMang(dt[i].depta, ismang, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
            if (manginfo != null) {
                if(manginfo.Rows.Count<=0)
                    continue;
                dt[i]["mangname"] = manginfo[0].NAME_C;
                dt[i]["mangjob"] = manginfo[0].JOB_NAME;
            }
            
        }
        
        DataView dv = dt.DefaultView;
        dv.Sort = "jobl";
        GridView7.DataSource = dv;
        GridView7.DataBind();




        GridView4.DataSource = DataClass.getAssignEmpNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), app_nobr.Text);
        GridView4.DataBind();

    }
    protected void GridView7_SelectedIndexChanged(object sender, EventArgs e)
    {
        app_nobr.Text = GridView7.SelectedDataKey.Values["nobr"].ToString();


       // GridView2.DataSource = DataClass.getEffsBaseDT(_yy.Text, _seq.Text, app_nobr.Text);
       // GridView2.DataBind();
        GridView4.DataSource = DataClass.getAssignEmpNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), app_nobr.Text);
        GridView4.DataBind();
        Panel1.Visible = true;
    }
    protected void GridView4_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName.Trim().Equals("DeleteE"))
        {
            GridView4.DataSource = DataClass.getAssign(int.Parse(_yy.Text), int.Parse(_seq.Text), app_nobr.Text);
            GridView4.DataBind();

        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        EFFDS.EMPINFODataTableRow approw = DataClass.getEmpInfoForNobrOrName(txt_nobr.Text, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
        if (approw != null)
        {
            if (Session["empInfo"] != null)
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter assad = new EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter();
                EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = new EFFMANGDS.EFFS_ASSIGNAPPENDDataTable();
                assdt.AddEFFS_ASSIGNAPPENDRow(int.Parse(_yy.Text), int.Parse(_seq.Text), app_nobr.Text,
                   row.NOBR, row.DEPT, row.JOB, approw.NOBR, DateTime.Now, 10);

                assad.Update(assdt);

                GridView4.DataSource = DataClass.getAssignEmpNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), app_nobr.Text);
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
    protected void GridView7_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {

    }
    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        
    }
    protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void GridView4_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
    
    }
    protected void GridView4_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Button bt = (Button)sender;
        EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter assad = new EFFMANGDSTableAdapters.EFFS_ASSIGNAPPENDTableAdapter();
        assad.Delete(int.Parse(bt.CommandArgument.ToString()));
        GridView4.DataSource = DataClass.getAssignEmpNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), app_nobr.Text);
        GridView4.DataBind();
    }
}
