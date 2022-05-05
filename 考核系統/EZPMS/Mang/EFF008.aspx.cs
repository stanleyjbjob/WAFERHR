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

public partial class Mang_EFF008 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string[] values = dll_attend.SelectedValue.Split(',');
            //tb_year.Text = values[0];
            //tb_seq.Text = values[1];

            if (Session["empInfo"] != null)
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

                DataClass dc = new DataClass();
             ArrayList al =    dc.getChilDeptM(row.DEPTM);


               EFFDS.EMPINFODataTableDataTable empdt = new EFFDS.EMPINFODataTableDataTable();
                for(int i =0 ;i<al.Count;i++){
                    empdt.Merge(DataClass.getDeptMEmpInfo(al[i].ToString(), DateTime.Now.ToShortDateString()));
                }
               if (empdt.Select("nobr ='" + row.NOBR + "'").Length > 0) 
               {
                   empdt.Select("nobr ='" + row.NOBR + "'")[0].Delete();
               }
               DataView dv = empdt.DefaultView;
               dv.Sort = "indt";

               GridView1.DataSource = dv;
               GridView1.DataBind();
            }


        }

    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        Button bt = (Button)sender;
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
        //"~/MANG/
       EFFDS.EFFS_BASERow baserow =  DataClass.getEffsBase(tb_year.Text, tb_seq.Text, bt.ToolTip);
       if (baserow != null)
       {

           CS.ScripWindowOpen(this,"EFF004.aspx?yy=" + tb_year.Text + "&seq=" + tb_seq.Text + "&nobr=" + bt.ToolTip + "&tempID=" + baserow.templetID);
       }
       else 
       {
           CS.showScriptAlert(this, "沒有產生本期的考核資料！！");
       
       }

    }
}
