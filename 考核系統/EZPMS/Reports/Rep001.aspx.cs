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

public partial class Reports_Rep001 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            //string[] values = dll_attend.SelectedValue.Split(',');
            //tb_year.Text = values[0];
            //tb_seq.Text = values[1];

           


        }

    }

    void loadData() 
    {
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
        DataClass dc = new DataClass();
        EFFDS.EFFS_BASEDataTable dt = null;
        if (tb_nobr.Text.Trim().Length > 0)
        {
            dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBaseDT(tb_year.Text, tb_seq.Text, tb_nobr.Text.Trim()+"%");
        }
        else
        {
            dt = (EFFDS.EFFS_BASEDataTable)DataClass.getEffsBases(tb_year.Text, tb_seq.Text, dc.getChilDeptM(DropDownList1.SelectedValue), "");
        }
        GridView8.DataSource = dt;
        GridView8.DataBind();
    }
    int itemIndex = 0;
    protected void GridView8_RowDataBound(object sender, GridViewRowEventArgs e) {
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            DataList dl = (DataList)e.Row.FindControl("DataList1");
            Label lb = (Label)e.Row.FindControl("_nobr");
            CheckBox cb_mail = e.Row.FindControl("cb_mail") as CheckBox;
            //   EFFDS.EMPINFODataTableRow row = DataClass.getEmpInfo(lb.Text, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
              EFFDS.EMPINFODataTableRow row = DataClass.getEmpInfo(lb.Text,DateTime.Now.ToShortDateString());
            if (row == null)
                return;
            //    HRDS.DeptAMangDataTableDataTable deptadt = DataClass.getempMang(row.DEPTM, row.MANG, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
            HRDS.DeptAMangDataTableDataTable deptadt = DataClass.getempMang(row.DEPTM, row.MANG, DateTime.Now.ToShortDateString());
            EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = DataClass.getAssignEmpNobr(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), lb.Text);

            DataTable dt = new DataTable();
            dt.Columns.Add("nobr");
            dt.Columns.Add("name");
            dt.Columns.Add("type");
            dt.Columns.Add("adate");
            dt.Columns.Add("_nobr");

            DataRow selfrow = dt.NewRow();
            selfrow["_nobr"] = row.NOBR;
            selfrow["nobr"] = row.NOBR;
            selfrow["name"] = row.NAME_C;
            selfrow["type"] = "自評";
            selfrow["adate"] = DataClass.getSendEffsTime(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), lb.Text, lb.Text);
            dt.Rows.Add(selfrow);

            if (isSendMail && cb_mail.Checked)
            {
                if (CheckBox1.Checked)
                {
                    if (selfrow["adate"].ToString().Equals("未傳送！！"))
                    {
                        if (row.MANG)
                        {
                            sendMailTo(selfrow["_nobr"].ToString(), selfrow["name"].ToString() + "[自評未評核]", selfrow["_nobr"].ToString(), selfrow["name"].ToString());
                        }
                    }
                }
            }

            for (int i = 0; i < assdt.Rows.Count; i++)
            {
                DataRow mangrow = dt.NewRow();
                EFFDS.EMPINFODataTableRow assrow = DataClass.getEmpInfo(assdt[i].assignnobr, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
                if (assrow != null)
                {
                    mangrow["_nobr"] = row.NOBR;
                    mangrow["nobr"] = assrow.NOBR;
                    mangrow["name"] = assrow.NAME_C;
                    mangrow["type"] = "非直線主管";
                    mangrow["adate"] = DataClass.getSendEffsTime(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), lb.Text, assrow.NOBR);
                    dt.Rows.Add(mangrow);
                }
            }
           
            for (int i = 0; i < deptadt.Rows.Count; i++)
            {
                
                DataRow mangrow = dt.NewRow();
                mangrow["_nobr"] = row.NOBR;
                mangrow["nobr"] = deptadt[i].NOBR;
                mangrow["name"] = deptadt[i].NAME_C;
                mangrow["type"] = "直線主管";
                mangrow["adate"] = DataClass.getSendEffsTime(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), lb.Text, deptadt[i].NOBR);
                dt.Rows.Add(mangrow);

                if (isSendMail)
                {
                    if (cb_mail.Checked && i == 0 && CheckBox1.Checked&&selfrow["adate"].ToString().Equals("未傳送！！"))
                    {
                        sendMailTo1(selfrow["_nobr"].ToString(), selfrow["name"].ToString(), mangrow["nobr"].ToString(), mangrow["name"].ToString());

                    }



                    if (cb_mail.Checked &&  CheckBox2.Checked && i == 0 && mangrow["adate"].ToString().Equals("未傳送！！"))
                    {
                        sendMailTo(selfrow["_nobr"].ToString(), selfrow["name"].ToString(), mangrow["nobr"].ToString(), mangrow["name"].ToString());
                    }

                    if (cb_mail.Checked &&  CheckBox3.Checked && i == 1 && mangrow["adate"].ToString().Equals("未傳送！！"))
                    {
                        sendMailTo(selfrow["_nobr"].ToString(), selfrow["name"].ToString(), mangrow["nobr"].ToString(), mangrow["name"].ToString());
                    }

                    if (cb_mail.Checked &&  CheckBox4.Checked && i == 2 && mangrow["adate"].ToString().Equals("未傳送！！"))
                    {
                        sendMailTo(selfrow["_nobr"].ToString(), selfrow["name"].ToString(), mangrow["nobr"].ToString(), mangrow["name"].ToString());
                    }
                  
                }
            }
            itemIndex = 0;
            dl.DataSource = dt;
            dl.DataBind();

        }
    }

    //主管自評通知
    void sendMailTo1(string _nobr, string name_c, string mangnobr, string mangname)
    {

        EFFDS.EFFS_ATTENDRow arow = DataClass.getEffsAttend(int.Parse(tb_year.Text), int.Parse(tb_seq.Text));
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(mangnobr, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
        string mail = emprow.EMAIL;

        string sub = "";
        string body = "";
        sub = "績效考核提醒,請您的員工" + name_c + "自評還未送出！請確認！！[" + arow.Desc + "]";



        body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
              "<html xmlns='http://www.w3.org/1999/xhtml'>" +
              "<head>" +
              "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
              "<title></title>" +
              "" +
              "</head>" +
              "" +
              "<body >" +
              mangname + " 先生/小姐:<br>" +
               name_c + "," + tb_year.Text + "年第" + tb_seq.Text + "績效考核資料,自評還未送出請您確認！！<br>" +
              " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\" ,謝謝！<br>" +
              "<br>" +
              "<br>" +
              "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
              "<br>" +
              "</body>" +
              "</html>";

        CS.SendMail(mail, body, sub);
    }

    ArrayList al_mang = new ArrayList();
    void sendMailTo(string _nobr,string name_c,string mangnobr,string mangname) {

        if (al_mang.Contains(mangnobr.Trim()))
            return;

        al_mang.Add(mangnobr.Trim());
        

        EFFDS.EFFS_ATTENDRow arow = DataClass.getEffsAttend(int.Parse(tb_year.Text), int.Parse(tb_seq.Text));
        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(mangnobr, DataClass.getEffsAttendStdDate(int.Parse(tb_year.Text), int.Parse(tb_seq.Text)).ToShortDateString());
        string mail = emprow.EMAIL;

        string sub = "";
        string body = "";
        sub = TextBox1.Text;


        body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
                      "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                      "<head>" +
                      "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
                      "<title></title>" +
                      "" +
                      "</head>" +
                      "" +
                      "<body >" +
                      mangname + " 先生/小姐:<br>" +
                  //    "  [" + arow.Desc + "]距結束時間尚有" + tb_days.Text + ",提醒各位主管，尚未評核完成者，請於99年1月31日前完成送出至第二階主管。" +
                     TextBox2.Text+ "<br>"+
                      " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\"<br>" +
                      "<br>" +
                      "<br>" +
                      "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
                      "<br>" +
                      "</body>" +
                      "</html>";
      CS.SendMail(mail, body, sub);
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            if (itemIndex == 0)
            {
                HtmlTable ht = (HtmlTable)e.Item.FindControl("TABLE2");
                ht.Visible = true;
            }
            itemIndex++;

        }
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        loadData();
    }
    public override void VerifyRenderingInServerForm(Control control)
    {
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        for (int i = 0; i < GridView8.Rows.Count; i++) 
        {
            DataList dl = (DataList)GridView8.Rows[i].FindControl("DataList1");
            for (int j = 0; j < dl.Items.Count; j++) 
            {
                Button bt = (Button)dl.Items[j].FindControl("Button3");
                bt.Visible = false;
            
            }

        }

        Response.Clear();
        Response.AddHeader("content-disposition", "attachment;filename=" + DateTime.Now.ToString("yyyy-MM-dd") + ".xls");
        Response.ContentEncoding = System.Text.Encoding.GetEncoding("big5");//設定輸出為中文
        Response.Charset = "";
        //Response.ContentType = "application/ms-excel";
        Response.ContentType = "application/vnd.xls";

        System.IO.StringWriter stringWrite = new System.IO.StringWriter();
        System.Web.UI.HtmlTextWriter htmlWrite = new HtmlTextWriter(stringWrite);
        GridView8.RenderControl(htmlWrite);
        Response.Write("<meta http-equiv=Content-Type content=\"text/html; charset=big5\">");
        string strStyle = "<style>.xlString { mso-number-format:\\@; } </style>";
        Response.Write(strStyle);
        Response.Write(stringWrite.ToString());
        Response.End();
    }
    protected void Button3_Click(object sender, EventArgs e) {
        string[] values = dll_attend.SelectedValue.Split(',');
        tb_year.Text = values[0];
        tb_seq.Text = values[1];
       Button bt = (Button)sender;
        string [] nobrs = bt.CommandArgument.Split(',');

        EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter ad = new EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter();

//        (new EFFMANGDSTableAdapters.QueriesTableAdapter()).DeleteEffsMangFinish(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), nobrs[1]);

        if (ad.DeleteAppend(int.Parse(tb_year.Text), int.Parse(tb_seq.Text), nobrs[0], nobrs[1]) > 0) 
        {
            CS.showScriptAlert(this, "解除成功　！！");
            loadData();
        
        }else
        {
            CS.showScriptAlert(this, "沒有資料解除　！！");
        }
       
    }

    bool isSendMail = false;
    protected void Button4_Click(object sender, EventArgs e)
    {
        isSendMail = true;
        loadData();
        CS.showScriptAlert(this, "傳送完成！");
    }
    protected void Button5_Click(object sender, EventArgs e)
    {
        sendMailTo("test", "test", tb_mail.Text, tb_mail.Text);
    }
}
