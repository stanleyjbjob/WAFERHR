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

public partial class UC_EmpInfo : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            string nobr = "";
            if (Request.QueryString["nobr"] != null&&Request.QueryString["yy"] != null&&Request.QueryString["seq"] != null) {
                nobr = Request.QueryString["nobr"];
                setEffsValue(Request.QueryString["yy"], Request.QueryString["seq"], Request.QueryString["nobr"]);
            }else
             if((Request.QueryString["nobr"] != null)){
                 nobr = Request.QueryString["nobr"];
                 setValue(nobr);
             }else
            if (Session["nobr"] != null && Session["EFFSInfo"]==null)
            {

                nobr = Session["nobr"].ToString().Trim();
                setValue(nobr);
            }
            else if (Session["EFFSInfo"] != null) {
                Hashtable ht = (Hashtable)Session["EFFSInfo"];
                setValue(ht);
                EFFDS.EMPINFODataTableRow emprow = (EFFDS.EMPINFODataTableRow)ht["empInfo"];
                nobr = emprow.NOBR;
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
    void setEffsValue(string yy,string seq,string nobr) {
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(nobr, DataClass.getEffsAttendStdDate(int.Parse(yy), int.Parse(seq)).ToShortDateString());
        EFFDS.EFFS_BASERow baserow = DataClass.getEffsBase(yy, seq, nobr);
        EFFDS.EFFS_ATTENDRow attendrow = DataClass.getEffsAttend(int.Parse(yy), int.Parse(seq));
        name_c.Text = emprow.NAME_C;
        lb_nobr.Text = emprow.NOBR;
        indt.Text = emprow.INDT.ToShortDateString();
        dept.Text = emprow.DEPTNAME;
        deps.Text = emprow.DEPTSNAME;
        job.Text = emprow.JOBNAME;
        jobl.Text = emprow.JOBLNAME;
        year.Text = baserow.yy + "年第" + seq.ToString() + "次";
        this.seq.Text = baserow.seq;
       // desc.Text = attendrow.Desc;

    }
    void setValue(string nobr) 
    {
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(nobr,DateTime.Now.ToShortDateString());
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
    void setValue(Hashtable ht)
    {
        EFFDS.EMPINFODataTableRow emprow = (EFFDS.EMPINFODataTableRow)ht["empInfo"];
        EFFDS.EFFS_BASERow baserow = (EFFDS.EFFS_BASERow)ht["base"];
        EFFDS.EFFS_ATTENDRow attendrow = (EFFDS.EFFS_ATTENDRow)ht["attend"];
        name_c.Text = emprow.NAME_C;
        lb_nobr.Text = emprow.NOBR;
        indt.Text = emprow.INDT.ToShortDateString();
        dept.Text = emprow.DEPTNAME;
        deps.Text = emprow.DEPTSNAME;
        job.Text = emprow.JOBNAME;
        jobl.Text = emprow.JOBLNAME;
        year.Text = baserow.yy + "年第" + baserow.seq.ToString() + "次";
      //  seq.Text = baserow.seq;
      //  desc.Text = attendrow.Desc;
    
    }
}
