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

public partial class EMP_EFF004 : System.Web.UI.Page
{
    public new void RegisterOnSubmitStatement(string key, string script)
    {
        ScriptManager.RegisterOnSubmitStatement(this, typeof(Page), key, script);
    }

    [Obsolete]
    public override void RegisterStartupScript(string key, string script)
    {
        string newScript = script.Replace("FTB_AddEvent(window,'load',function () {", "").Replace("});", "");
        ScriptManager.RegisterStartupScript(this, typeof(Page), key, newScript, false);
    }




    protected void Page_Load(object sender, EventArgs e)
    {
     
       

        if (!IsPostBack) {

            Page.ClientScript.RegisterClientScriptInclude("FTB-FreeTextBox", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-FreeTextBox.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Utility", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Utility.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Toolbars", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ToolbarItems.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-ImageGallery", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ImageGallery.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Pro", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Pro.js"));

            _ratenum.Text = "0.0";
            Session.Add("EFF004Attend", DataClass.getEffsAttendDataTable());
           
                note1.Text = DataClass.getNote("EMP.EFF004.aspx");

                int _month = 1;
               
                //if (DateTime.Now.Month >= 7) 
                //{
                //    _month = 2;
                //}



                _yy.Text = "";// DateTime.Now.Year.ToString();
                _seq.Text = "";// _month.ToString();

               // GridView1.DataBind();


        }

        if (Request.QueryString["nobr"] != null)
        {
            lb_nobr.Text = Request.QueryString["nobr"].ToString();
        }
        else if (Session["nobr"] != null)
        {

            lb_nobr.Text = Session["nobr"].ToString();
        }
        else {
            Response.Redirect("http://172.20.1.151/ez-portal/default.aspx");
        }



    }
    double _rotecount = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.Footer) 
        {
            e.Row.Cells[5].Text = "年度比重總分：";
            e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Right;
            e.Row.Cells[5].ForeColor = System.Drawing.Color.White;
            e.Row.Cells[5].Font.Bold = true;
            e.Row.Cells[7].Text = _rotecount.ToString("0.0")+"%";
            e.Row.Cells[7].ForeColor = System.Drawing.Color.Red;
            e.Row.Cells[7].Font.Bold = true;
        
        }
        
        if (e.Row.RowType == DataControlRowType.Header)
        {
            e.Row.Cells[3].ColumnSpan += 2;
            e.Row.Cells[4].Visible = false;
        }
        
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label autoKey = (Label)e.Row.FindControl("autoKey");

            if (DataClass.checkApprTts(int.Parse(autoKey.Text)))
            {
                e.Row.Cells[5].Font.Italic = true;
                e.Row.Cells[7].Font.Italic = true;
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Red;
                e.Row.Cells[7].ForeColor = System.Drawing.Color.Red;

            }
            EFFDS.EFFS_APPRRow approw = DataClass.getEFFS_APPRRow(int.Parse(autoKey.Text));
            if (!approw.IsrealityNull() && approw.reality.Trim().Equals("True"))
            {
                e.Row.Cells[5].Font.Italic = true;
                e.Row.Cells[7].Font.Italic = true;
                e.Row.Cells[5].ForeColor = System.Drawing.Color.Blue;
                e.Row.Cells[7].ForeColor = System.Drawing.Color.Blue;

            }
            
            
            
            
            
            Label tb_rate = (Label)e.Row.FindControl("Label1");
          
            if (tb_rate != null)
            {
                try
                {
                    _rotecount += double.Parse(tb_rate.Text);
                }
                catch { }
            }
            _ratenum.Text = _rotecount.ToString("0.0");
            CheckBox cb_mangCheck = (CheckBox)e.Row.FindControl("cb_mangCheck");
            //if (cb.Checked)
            //{
            //    try
            //    {
            //        Label lb_yy = (Label)e.Row.FindControl("lb_yy");
            //        Label lb_seq = (Label)e.Row.FindControl("lb_seq");
            //        //LB_show
            //        Label LB_show = (Label)e.Row.FindControl("LB_show");
            //        EFFDS.EFFS_ATTENDDataTable attdt = (EFFDS.EFFS_ATTENDDataTable)Session["EFF004Attend"];
            //        EFFDS.EFFS_ATTENDRow[] rows = (EFFDS.EFFS_ATTENDRow[])attdt.Select("yy=" + lb_yy.Text + " and seq=" + lb_seq.Text);
            //        if (rows.Length > 0) {
            //            LB_show.Text = rows[0].Desc; ;
            //            //e.Row.Cells[10].Text = rows[0].Desc;
            //        }
            //    }
            //    catch (Exception ex)
            //    {
            //        CS.ErrorLog(Session["nobr"].ToString(), "Emp/EFF004.aspx", ex.Message);
            //    }

            //}
            if (cb_mangCheck.Checked) {
                Button delBtn = (Button)e.Row.FindControl("delBtn");
                if (delBtn != null)
                    delBtn.Enabled = false;
            }

        }
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
       
        e.Values["key_date"] =DateTime.Now;
        //mangCheck
        e.Values["mangCheck"] = false;
        e.Values["included"] = true;
        e.Values["nobr"] = lb_nobr.Text;
        e.Values["yy"] = _yy.Text;
        e.Values["seq"] = _seq.Text;
        e.Values["standard"] = "";
        
        

    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["yy"] = _yy.Text;
        e.NewValues["seq"] = _seq.Text;
        e.NewValues["included"] = true;
        e.NewValues["standard"] = "";
    }
    protected void FormView1_DataBinding(object sender, EventArgs e)
    {
    }
    protected void FormView1_DataBound(object sender, EventArgs e)
    {

        FormView fv = (FormView)sender;
      
        try
        {
            //CheckBox cb = (CheckBox)fv.Row.FindControl("includedCheckBox");
            //if (cb.Checked)
            //{

            //    DropDownList ddlattend = (DropDownList)fv.Row.FindControl("DDLAttend");
            //    Label lb_yy = (Label)fv.Row.FindControl("yyLabel");
            //    Label lb_seq = (Label)fv.Row.FindControl("seqLabel");
            //    EFFDS.EFFS_ATTENDRow row = DataClass.getEffsAttend(int.Parse(lb_yy.Text), int.Parse(lb_seq.Text));
            //    ddlattend.SelectedValue = row.autoKey.ToString();
            //}

            if (fv.CurrentMode == FormViewMode.Edit) {
                //cb_mangCheck
                CheckBox cb_mangCheck = (CheckBox)fv.Row.FindControl("cb_mangCheck");
             //   CheckBox cb = (CheckBox)fv.Row.FindControl("includedCheckBox");
               
                if (cb_mangCheck.Checked)
                {
               //     cb.Enabled = false;
                    //TextBox1
                    //DropDownList tb = (DropDownList)fv.Row.FindControl("DropDownList2");
                    //tb.Enabled = false;

                    ////DropDownList1
                    //DropDownList ddl = (DropDownList)fv.Row.FindControl("DropDownList1");
                    //ddl.Enabled = false;

                    //rateTextBox
                    TextBox rateTextBox = (TextBox)fv.Row.FindControl("rateTextBox");
                    rateTextBox.ReadOnly = true;
                    //worksTextBox

                    TextBox bb = (TextBox)fv.Row.FindControl("TextBox2");
                    bb.ReadOnly = true;
                    
                    FreeTextBoxControls.FreeTextBox worksTextBox = (FreeTextBoxControls.FreeTextBox)fv.Row.FindControl("FreeTextBox1");
                 
                    worksTextBox.ReadOnly = true;
                    //standardTextBox
                    FreeTextBoxControls.FreeTextBox standardTextBox = (FreeTextBoxControls.FreeTextBox)fv.Row.FindControl("FreeTextBox2");
                    standardTextBox.ReadOnly = true;
                    //rateTextBox
                   // TextBox rateTextBox = (TextBox)fv.Row.FindControl("rateTextBox");
                    //rateTextBox.ReadOnly = true;
                }
                
            }
        }
        catch (Exception ex)
        {
            CS.ErrorLog(Session["nobr"].ToString(), "Emp/EFF004.aspx", ex.Message);
        }

    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        GridView1.DataBind();
        CS.showScriptAlert(UpdatePanel3, "新增完成！");

    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        GridView1.DataBind();
        CS.showScriptAlert(UpdatePanel3, "修改完成！");

    }
    protected void DropDownList3_SelectedIndexChanged(object sender, EventArgs e)
    {
        string []value = DropDownList3.SelectedValue.ToString().Split(',');
        _yy.Text = value[0];
        _seq.Text = value[1];
    }
    protected void GridView1_RowDeleted(object sender, GridViewDeletedEventArgs e)
    {
        CS.showScriptAlert(UpdatePanel2, "刪除完成！");

    }
    protected void Button8_Click(object sender, EventArgs e)
    {
      
        string mail = "";
        string sub = "";
        string body = "";
        if (Session["empInfo"] != null)
        {


            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            string mangnobr = DataClass.getMangFromNobr(lb_nobr.Text, DateTime.Now.ToShortDateString()); //DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
            EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(mangnobr, DateTime.Now.ToShortDateString());//DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());



            sub = row.NAME_C + ",已經填寫完成," + _yy.Text + "年工作目標,請您確認！！";


            if (emprow != null)
            {

                body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
                       "<html xmlns='http://www.w3.org/1999/xhtml'>" +
                       "<head>" +
                       "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
                       "<title></title>" +
                       "" +
                       "</head>" +
                       "" +
                       "<body >" +
                       emprow.NAME_C + " 先生/小姐:<br>" +
                        row.NAME_C + ",已經填寫完成," + _yy.Text + "年工作目標,請您確認！！<br>" +
                       " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\"  ,確認" + row.NAME_C + "的工作目標,謝謝！<br>" +
                       "<br>" +
                       "<br>" +
                       "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
                       "<br>" +
                       "</body>" +
                       "</html>";
                mail = emprow.EMAIL;
                CS.SendMail(mail, body, sub, UpdatePanel1);

            }
        }
    }
    protected void Button9_Click(object sender, EventArgs e) {
        string[] value = DropDownList3.SelectedValue.ToString().Split(',');
        _yy.Text = value[0];
        _seq.Text = value[1];
        GridView1.DataBind();
    }
    protected void DropDownList3_DataBound(object sender, EventArgs e)
    {
        DropDownList3.Items.Insert(0, new ListItem("＊請選擇目標年度＊", "0,0"));
    }
}
