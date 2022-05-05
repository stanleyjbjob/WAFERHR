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

public partial class EMP_EFFS007 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) 
        {
            note.Text = DataClass.getNote("EMP.EFFS007.aspx");
        
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            

            int yy = 0;
            int seq = 0;
            EFFDS.EFFS_ATTENDRow attrow = DataClass.getEffsAttend((int)GridView1.SelectedValue);
            if (attrow != null)
            {
                yy = attrow.yy;
                seq = attrow.seq;
                lb_yy.Text = attrow.yy.ToString();
                lb_seq.Text = attrow.seq.ToString(); _nobr.Text = row.NOBR;
            }

            EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = DataClass.getAssignMang(yy, seq,  row.NOBR);
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
            GridView5.DataSource = basedt;
            GridView5.DataBind();
            f_panel.Visible = true;
        }
    }
    protected void GridView3_RowCommand(object sender, GridViewCommandEventArgs e)
    {

    }
    protected void GridView3_SelectedIndexChanged(object sender, EventArgs e)
    {

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
            try
            {
                EFFDS.EFFS_BASERow baserow = DataClass.getEffsBase(yy.ToString(), seq.ToString(), lb.Text);
                if (baserow != null)
                {

                    EFFMANGDS.EFFS_NUMRow row = DataClass.getEFFSELENUM(yy, seq, true, lb.Text, baserow.templetID, "A001", "B001", "A001");
                    effs.Text = Convert.ToString(Math.Round(row.totnum, 1));
                    if ((int)row.totnum == 0)
                    {
                        effs1.Text = "未評";
                    }
                    else
                    {
                        effs1.Text = row.effs;
                    }

                    EFFMANGDS.EFFS_NUMRow mangrow = DataClass.getEFFSELENUM(yy, seq, true, lb.Text, baserow.templetID, "A001", "B001", "A001", _nobr.Text);
                    mangeffs.Text = Convert.ToString(Math.Round(mangrow.totnum, 1));
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
            catch { }

        }
    }
}
