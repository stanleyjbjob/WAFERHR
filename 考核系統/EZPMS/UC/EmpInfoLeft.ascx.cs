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

public partial class UC_EmpInfoLeft : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            string nobr = "";
            if (Session["nobr"] != null)
            {
                nobr = Session["nobr"].ToString().Trim();
                setValue(nobr);
            }
            else if (Session["EFFSInfo"] != null)
            {
                setValue((Hashtable)Session["EFFSInfo"]);
            }

            ViewState.Add("nobr", nobr);
            if (nobr.Trim().Length == 0)
            {
                Response.Redirect("~/Login.aspx");
            }
        }
        if (Session["nobr"] == null) {
            Session.Add("nobr", ViewState["nobr"].ToString());
            EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(ViewState["nobr"].ToString(), DateTime.Now.ToShortDateString());
            Session.Add("empInfo", emprow);
        }
       
      

    }
    void setValue(string nobr)
    {
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(nobr, DateTime.Now.ToShortDateString());
        if (emprow != null)
        {
            _name_c.Text = emprow.NAME_C;
            _nobr.Text = emprow.NOBR;
            _dept.Text = emprow.DEPTNAME;
            _job.Text = emprow.JOBNAME;

        }
    }
    void setValue(Hashtable ht)
    {
        EFFDS.EMPINFODataTableRow emprow = (EFFDS.EMPINFODataTableRow)ht["empInfo"];
        _name_c.Text = emprow.NAME_C;
        _nobr.Text = emprow.NOBR;
        _dept.Text = emprow.DEPTNAME;
        _job.Text = emprow.JOBNAME;

    }
}
