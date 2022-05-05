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

public partial class Reports_Rep006 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            tb_year.Text = DateTime.Now.Year.ToString();
            tb_seq.Text = "1";


            if (Request.QueryString["deptm"] != null)
            {
               // DropDownList1.Visible = false;
              //  DropDownList1.SelectedValue = Request.QueryString["deptm"].Trim();

            }

        }

    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }
    protected void Button2_Click(object sender, EventArgs e)
    {

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("yyyy-MM-dd") + ".xls");
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("big5");//設定輸出為中文
        Response.Charset = "";
        //Response.ContentType = "application/ms-excel";
        Response.ContentType = "application/vnd.xls";

        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        GridView1.RenderControl(htmlWrite);
        Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=big5\">");
        string strStyle = "<style>.xlString { mso-number-format:\\@; } </style>";
        Response.Write(strStyle);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void Button1_Click(object sender, EventArgs e) {
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
        GridView1.DataBind();
    }
}
