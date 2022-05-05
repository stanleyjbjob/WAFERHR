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

public partial class EMP_EFF005 : System.Web.UI.Page
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

            note.Text = DataClass.getNote("EMP.EFF005.aspx");
        }
    }
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        _yy.Text = GridView1.SelectedRow.Cells[1].Text;
        _seq.Text = GridView1.SelectedRow.Cells[2].Text;
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            FIELDSET1.Visible = true;
            FIELDSET2.Visible = true;
            GridView2.DataSource = DataClass.getempMang(_dept.Text, row.MANG, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
            GridView2.DataBind();
            GridView4.DataSource = DataClass.getAssignEmpNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
            GridView4.DataBind();
        }

    }
}
