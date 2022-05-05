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

public partial class Default4 : System.Web.UI.Page
{
    protected string deptm = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            if (Session["nobr"] != null) {
                ViewState["nobr"] = Session["nobr"].ToString();
            }
        }


        if (Session["nobr"] == null) {
            Session.Add("nobr", ViewState["nobr"].ToString());
            EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(ViewState["nobr"].ToString(), DateTime.Now.ToShortDateString());
            Session.Add("empInfo", emprow);
        }


        if (Session["empInfo"] == null) {
            Session.Add("nobr", ViewState["nobr"].ToString());
            EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(ViewState["nobr"].ToString(), DateTime.Now.ToShortDateString());
            Session.Add("empInfo", emprow);
        }


        EFFDS.EMPINFODataTableRow emprow1 = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
        deptm = emprow1.DEPTM;

        mang_menu.Visible = false;//emprow1.MANG;
        FIELDSET1.Visible = false;



        if (!IsPostBack)
        {


           // CS.showScriptAlert(this, "提醒您，若您在績效考核系統中閒置超過30分鐘，系統會自動將您登出！");
            app_note.Text = DataClass.getNote("Default.aspx");
        }
    }
    protected void ImageButton17_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/EMP/EFF003.aspx");
    }
    protected void ImageButton26_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/EMP/EFF001.aspx");
    }
    protected void ImageButton13_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/EMP/EFFS007.aspx");
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e) {
           Response.Redirect("~/EMP/EFF004.aspx");
    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/EMP/EFF006.aspx");
    }
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/EMP/EFF005.aspx");
    }
    protected void ImageButton4_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/MANG/EFF001.aspx");
    }
    protected void ImageButton5_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/MANG/EFF003.aspx");
    }
    protected void ImageButton6_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/MANG/EFF002.aspx");
    }
    protected void ImageButton7_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/MANG/EFF007.aspx");
    }
    protected void ImageButton8_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/MANG/EFF006.aspx");
    }
    protected void ImageButton9_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/MANG/EFF005.aspx");
    }
    protected void ImageButton10_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/MANG/EFF008.aspx");
    }
    protected void ImageButton11_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep002.aspx?deptm=deptm");
    }
    protected void ImageButton12_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep003.aspx?deptm=deptm");
    }
    protected void ImageButton14_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep004.aspx?deptm=deptm");
    }
    protected void ImageButton15_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep005.aspx?deptm=deptm");
    }
    protected void ImageButton16_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep007.aspx?deptm=deptm");
    }
}
