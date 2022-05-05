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

public partial class Mang_EFF005 : System.Web.UI.Page
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
            note.Text = DataClass.getNote("Mang.EFF005.aspx");
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
    EFFDSTableAdapters.EFFS_SELFCATETableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFCATETableAdapter();

    protected void GridView7_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label _nobr = (Label)e.Row.FindControl("_effbaseID");
            GridView gv = (GridView)e.Row.FindControl("GridView5");
            for (int i = 0; i < gv.Rows.Count; i++)
            {
                try
                {
                    string apprID = "";
                    Label lb = (Label)gv.Rows[i].FindControl("lb_effsID");
                    TextBox tb = (TextBox)gv.Rows[i].FindControl("rate");

                    if (lb != null)
                        apprID = lb.Text;

                    EFFDS.EFFS_SELFCATEDataTable selfdt = selfad.GetDataByCateID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                        _nobr.Text, apprID);



                    if (selfdt.Rows.Count > 0)
                    {


                        if (tb != null)
                        {
                            EFFDS.EFFS_SELFCATERow selfrow = (EFFDS.EFFS_SELFCATERow)selfdt.Rows[0];
                            if (!selfrow.IsrateNull())
                            {
                                tb.Text = selfrow.rate.ToString();

                            }
                           
                        }
                    }
                   
                }
                catch
                {

                }



            }
        }

    }
    protected void GridView5_DataBound(object sender, EventArgs e)
    {

    }
    protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
    {

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        for (int j = 0; j < GridView7.Rows.Count; j++)
        {
            Label _nobr = (Label)GridView7.Rows[j].FindControl("_effbaseID");
            GridView gv = (GridView)GridView7.Rows[j].FindControl("GridView5");

            decimal ratesum = 0;
            for (int i = 0; i < gv.Rows.Count; i++)
            {
                try
                {

                    TextBox tb = (TextBox)gv.Rows[i].FindControl("rate");
                    ratesum += decimal.Parse(tb.Text);
                }
                catch
                {
                    CS.showScriptAlert(this, "員工：" + GridView7.Rows[j].Cells[12].Text + ",比重的值不是數值！！");
                    break;
                }
            }

            if ((int)ratesum != 100)
            {
                CS.showScriptAlert(this, "員工：" + GridView7.Rows[j].Cells[12].Text + ",調整後比重不為100%,請重新調整！！");
                break;
            }
            for (int i = 0; i < gv.Rows.Count; i++)
            {

                try
                {
                    string apprID = "";
                    Label lb = (Label)gv.Rows[i].FindControl("lb_effsID");
                    TextBox tb = (TextBox)gv.Rows[i].FindControl("rate");

                    if (lb != null)
                        apprID = lb.Text;

                    EFFDS.EFFS_SELFCATEDataTable selfdt = selfad.GetDataByCateID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                        _nobr.Text, apprID);



                    if (selfdt.Rows.Count > 0)
                    {


                        if (tb != null)
                        {
                            EFFDS.EFFS_SELFCATERow selfrow = (EFFDS.EFFS_SELFCATERow)selfdt.Rows[0];
                            if (!selfrow.IsrateNull())
                            {
                                selfrow.rate = decimal.Parse(tb.Text);
                            }
                        }
                        selfad.Update(selfdt);

                    }
                    else
                    {
                        selfdt.AddEFFS_SELFCATERow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, apprID, 0, DateTime.Now, false, decimal.Parse(tb.Text));
                        selfad.Update(selfdt);


                    }

                }
                catch
                {

                }



            }

        }
        CS.showScriptAlert(this, "比重調整完成！！");
                 
    }
}
