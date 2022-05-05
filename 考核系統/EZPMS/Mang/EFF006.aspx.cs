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

public partial class Mang_EFF006 : System.Web.UI.Page
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
            note.Text = DataClass.getNote("Mang.EFF006.aspx");
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        _yy.Text = GridView1.SelectedRow.Cells[1].Text;
        _seq.Text = GridView1.SelectedRow.Cells[2].Text;
        
        DataClass dc = new DataClass();
        DataTable dt = (DataTable)DataClass.getEffsBases(_yy.Text, _seq.Text, dc.getChilDeptM(_dept.Text), _nobr.Text);
        DataView dv = dt.DefaultView;
        dv.Sort = "jobl";
        GridView7.DataSource = dv;
        GridView7.DataBind();
    }
    EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter ratead = new EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter();
    EFFDSTableAdapters.EFFS_TEMPLETTYPETableAdapter temprate = new EFFDSTableAdapters.EFFS_TEMPLETTYPETableAdapter();
    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            Label _nobr = (Label)e.Row.FindControl("_effbaseID");
            Label _templetID = (Label)e.Row.FindControl("_templetID");
            TextBox _catea = (TextBox)e.Row.FindControl("catea");
            TextBox _cateb = (TextBox)e.Row.FindControl("cateb");

            EFFMANGDS.EFFS_MANGRATEDataTable ratedt = ratead.GetDataByNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
            if (ratedt.Rows.Count > 0)
            {
                EFFMANGDS.EFFS_MANGRATERow raterow = (EFFMANGDS.EFFS_MANGRATERow)ratedt.Rows[0];
                _catea.Text = raterow.arrprate.ToString();
                _cateb.Text = raterow.caterate.ToString();
            }
            else
            {
                EFFDS.EFFS_TEMPLETTYPEDataTable tmpdt = temprate.GetDataByTempID(_templetID.Text);
                if (tmpdt.Rows.Count > 0)
                {
                    EFFDS.EFFS_TEMPLETTYPERow[] apprrow = (EFFDS.EFFS_TEMPLETTYPERow[])tmpdt.Select(" type = 'A001'");//<=要在修改
                    if (apprrow.Length > 0)
                    {
                        _catea.Text = apprrow[0].rate.ToString();
                    }
                    EFFDS.EFFS_TEMPLETTYPERow[] caterow = (EFFDS.EFFS_TEMPLETTYPERow[])tmpdt.Select(" type = 'B001'");//<=要在修改
                    if (caterow.Length > 0)
                    {
                        _cateb.Text = caterow[0].rate.ToString();
                    }
                }
            }
        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
       
    }
    protected void GridView7_SelectedIndexChanged(object sender, EventArgs e)
    {
            
    }
    protected void GridView7_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
    {
        
    }
    protected void Button1_Click1(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView7.Rows.Count; i++)
        {
           

                Label _nobr_ = (Label)GridView7.Rows[i].FindControl("_effbaseID");
                Label _templetID = (Label)GridView7.Rows[i].FindControl("_templetID");
                TextBox _catea = (TextBox)GridView7.Rows[i].FindControl("catea");
                TextBox _cateb = (TextBox)GridView7.Rows[i].FindControl("cateb");
                decimal ratesum = 0;
                try
                {
                    ratesum = decimal.Parse(_catea.Text) + decimal.Parse(_cateb.Text);
                    if ((int)ratesum != 100)
                    {
                        CS.showScriptAlert(UpdatePanel2, "員工：" + GridView7.Rows[i].Cells[12].Text + ",調整後比重不為100%,請重新調整！！");
                        break;
                    }
                }
                catch
                {
                    CS.showScriptAlert(UpdatePanel2, "員工：" + GridView7.Rows[i].Cells[12].Text + ",比重的值不是數值！！");
                    break;
                }
                EFFMANGDS.EFFS_MANGRATEDataTable ratedt = ratead.GetDataByNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr_.Text);
                if (ratedt.Rows.Count > 0)
                {
                    EFFMANGDS.EFFS_MANGRATERow raterow = (EFFMANGDS.EFFS_MANGRATERow)ratedt.Rows[0];
                    raterow.arrprate = decimal.Parse(_catea.Text);
                    raterow.caterate = decimal.Parse(_cateb.Text);
                    ratead.Update(ratedt);
                }
                else
                {
                    ratedt.AddEFFS_MANGRATERow(0, int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr_.Text, decimal.Parse(_catea.Text),
                    decimal.Parse(_cateb.Text), _nobr.Text);
                    ratead.Update(ratedt);
                }
          
                
            
            
        }
        CS.showScriptAlert(UpdatePanel2, "比重調整完成！！");
            
    }
}
