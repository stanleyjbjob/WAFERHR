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

public partial class menu1 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void ImageButton9_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF001.aspx");
    }
    protected void ImageButton1_Click(object sender, ImageClickEventArgs e) {
        //"~/HR/EFF002.aspx"
        Response.Redirect("~/HR/EFF002.aspx");
    }
    protected void ImageButton2_Click(object sender, ImageClickEventArgs e) {
        //~/HR/EFF003.aspx
        Response.Redirect("~/HR/EFF003.aspx");
    }
    protected void ImageButton4_Click(object sender, ImageClickEventArgs e) {
        //~/HR/EFF008.aspx
        Response.Redirect("~/HR/EFF008.aspx");
    }
    protected void ImageButton3_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF011.aspx");
    }
    protected void ImageButton5_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF005.aspx");
    }
    protected void ImageButton6_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF004.aspx");
    }
    protected void ImageButton7_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF013.aspx");
    }
    protected void ImageButton8_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF010.aspx");
    }
    protected void ImageButton18_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF012.aspx");
    }
    protected void ImageButton10_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF006.aspx");
    }
    protected void ImageButton11_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF009.aspx");
    }
    protected void ImageButton12_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF007.aspx");
    }

//==========================report=================================================================
    protected void ImageButton17_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep001.aspx");
    }
    protected void ImageButton26_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep002.aspx");
    }
    protected void ImageButton13_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep003.aspx");
    }
    protected void ImageButton20_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep008.aspx");
    }
    protected void ImageButton19_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep004.aspx");
    }
    protected void ImageButton14_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep005.aspx");
    }
    protected void ImageButton15_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep006.aspx");
    }
    protected void ImageButton16_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/Reports/Rep007.aspx");
    }
    protected void ImageButton21_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFFS014.aspx");
    }
    protected void ImageButton22_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFFS015.aspx");
    }
    protected void ImageButton23_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF015.aspx");
    }
    protected void ImageButton24_Click(object sender, ImageClickEventArgs e) {
        Response.Redirect("~/HR/EFF016.aspx");
    }
    protected void ImageButton25_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/HR/EFF0111.aspx");
    }
    protected void ImageButton27_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Reports/Rep010.aspx");
    }
    protected void ImageButton28_Click(object sender, ImageClickEventArgs e)
    {
        Response.Redirect("~/Reports/Rep011.aspx");
    }
}
