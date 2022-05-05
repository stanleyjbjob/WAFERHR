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

public partial class EMP_EFF006 : System.Web.UI.Page
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
            note.Text = DataClass.getNote("EMP.EFF006.aspx");
        }
    }
    EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter ratead = new EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter();
    EFFDSTableAdapters.EFFS_TEMPLETTYPETableAdapter temprate = new EFFDSTableAdapters.EFFS_TEMPLETTYPETableAdapter();

    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        Panel1.Visible = true;
        _yy.Text = GridView1.SelectedRow.Cells[1].Text;
        _seq.Text = GridView1.SelectedRow.Cells[2].Text;
      EFFDS.EFFS_BASERow baserow =   DataClass.getEffsBase(_yy.Text, _seq.Text, _nobr.Text);
      if (baserow == null) 
      {
          CS.showScriptAlert(UpdatePanel1, "沒有您的考核資料");
          return;
      
      }
        _templetID.Text = baserow.templetID;

        EFFMANGDS.EFFS_MANGRATEDataTable ratedt = ratead.GetDataByNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
        if (ratedt.Rows.Count > 0)
        {
            EFFMANGDS.EFFS_MANGRATERow raterow = (EFFMANGDS.EFFS_MANGRATERow)ratedt.Rows[0];
            _catea.Text = raterow.arrprate.ToString("0")+"%";
            _cateb.Text = raterow.caterate.ToString("0") + "%";
        }
        else
        {
            EFFDS.EFFS_TEMPLETTYPEDataTable tmpdt = temprate.GetDataByTempID(_templetID.Text);
            if (tmpdt.Rows.Count > 0)
            {
                EFFDS.EFFS_TEMPLETTYPERow[] apprrow = (EFFDS.EFFS_TEMPLETTYPERow[])tmpdt.Select(" type = 'A001'");//<=要在修改
                if (apprrow.Length > 0)
                {
                    _catea.Text = apprrow[0].rate.ToString("0") + "%";
                }
                EFFDS.EFFS_TEMPLETTYPERow[] caterow = (EFFDS.EFFS_TEMPLETTYPERow[])tmpdt.Select(" type = 'B001'");//<=要在修改
                if (caterow.Length > 0)
                {
                    _cateb.Text = caterow[0].rate.ToString("0") + "%";
                }
            }
        }
        GridView5.DataBind();

    }

    EFFDSTableAdapters.EFFS_SELFCATETableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFCATETableAdapter();

    protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        try
        {
            string apprID = "";
            Label lb = (Label)e.Row.FindControl("lb_effsID");
            TextBox tb = (TextBox)e.Row.FindControl("rate");
            tb.ReadOnly = true;
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
                        tb.Text = selfrow.rate.ToString("0") + "%";

                    }
                }
            }
        }
        catch
        {
        }
    }
    protected void GridView5_DataBound(object sender, EventArgs e)
    {

    }
}
