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
using System.IO;

public partial class EFF002t : System.Web.UI.Page
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

        if (!IsPostBack)
        {
            Page.ClientScript.RegisterClientScriptInclude("FTB-FreeTextBox", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-FreeTextBox.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Utility", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Utility.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Toolbars", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ToolbarItems.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-ImageGallery", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-ImageGallery.js"));
            Page.ClientScript.RegisterClientScriptInclude("FTB-Pro", VirtualPathUtility.MakeRelative(Request.Path, "~/scripts/FTB-Pro.js"));

            if (Session["EFFSInfo"] != null) {
                Hashtable ht = (Hashtable)Session["EFFSInfo"];
                EFFDS.EFFS_ATTENDRow attrow = (EFFDS.EFFS_ATTENDRow)ht["attend"];
                EFFDS.EFFS_BASERow baserow = (EFFDS.EFFS_BASERow)ht["base"];
               _yy.Text= attrow.yy.ToString();
               _seq.Text= attrow.seq.ToString();
                _nobr.Text = baserow.nobr;
                _temp.Text = baserow.templetID;
                Qryframe.Attributes.Add("SRC", "../empInfo.aspx?yy=" + _yy.Text + "&seq=" + _seq.Text + "&nobr=" + _nobr.Text);
                if (attrow.StdDate <= DateTime.Now &&  attrow.EndDate  >= DateTime.Now )
                {
                    ViewState["isOver"] = false;
                }
                else {
               //     FormView5.Enabled = false;
              //      UPFILEDATELIST.Enabled = false;
                    ViewState["isOver"] = true;
                    CS.showScriptAlert(this, "考核時間過期！不可再次修改考核資料！！");
                }
                if (DataClass.getIsSendEffs(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _nobr.Text)) 
                {

                 //   FormView5.Enabled = false;
                  //  UPFILEDATELIST.Enabled = false;
                    ViewState["isOver"] = true;

                    CS.showScriptAlert(this, "考核資料已經,傳送過！不可再次修改考核資料！！");

                }
            }

        //    note1.Text = DataClass.getNote("EMP.EFF002.aspx.1");
            note2.Text = DataClass.getNote("EMP.EFF002t.aspx.1");
            note3.Text = DataClass.getNote("EMP.EFF002t.aspx.2");
           // note4.Text = DataClass.getNote("EMP.EFF002.aspx.4");
         //   note5.Text = DataClass.getNote("EMP.EFF002.aspx.5");
          //  note6.Text = DataClass.getNote("EMP.EFF002.aspx.6");
            note7.Text = DataClass.getNote("EMP.EFF002t.aspx.3");


           // GridView1.DataBind();
            DataList2.DataBind();
        }
    }



    double gv5_sumnum = 0;


    protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        double _rate =0;
        double gv_num = 0;
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            EFFDSTableAdapters.EFFS_SELFCATETableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFCATETableAdapter();
            try
            {
                string  apprID = "";
                Label lb = (Label)e.Row.FindControl("lb_effsID");
                Label _rate_ = (Label)e.Row.FindControl("_rate");
                TextBox tb = (TextBox)e.Row.FindControl("num");
                _rate = double.Parse(_rate_.Text);

                if (bool.Parse(ViewState["isOver"].ToString())) 
                {
                    tb.ReadOnly = true;
                }


                if (lb != null)
                    apprID = lb.Text;

                EFFDS.EFFS_SELFCATEDataTable selfdt = selfad.GetDataByCateID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, apprID);
                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFCATERow selfrow = (EFFDS.EFFS_SELFCATERow)selfdt.Rows[0];
                        if (!selfrow.IsnumNull())
                        {
                            tb.Text = selfrow.num.ToString("0.0");
                            gv_num = (double)selfrow.num;
                            _rate_.Text = selfrow.rate.ToString("0")+"%";
                            _rate = (double)selfrow.rate;
                            if (selfrow.mangCheck)
                                tb.ReadOnly = true;
                        }
                        else
                        {
                            tb.Text = "0.0";
                        }
                    }
                }
                else
                {
                    tb.Text = "0.0";
                }
            }
            catch
            {

            }
            double t_num = (gv_num * _rate) / 100;
            t_num = Math.Round(t_num, 1, MidpointRounding.AwayFromZero);
            gv5_sumnum += t_num;
        }
    }
    int indexList = 0;
    protected void DataList2_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        GridView gv = (GridView)e.Item.FindControl("GridView5");
        if (gv != null && indexList > 0)
        {
            gv.ShowHeader = false;
        }
        indexList++;
        
    }

    double _ratenum = 0;
    double _rate = 0;
    double _num = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        double n_num = 0;
        double n_rate = 0;
      

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            FreeTextBoxControls.FreeTextBox ftb_appr = (FreeTextBoxControls.FreeTextBox)e.Row.FindControl("ftb_appr");
            if (bool.Parse(ViewState["isOver"].ToString()))
            {
                ftb_appr.ReadOnly = true;
            }


             try{
                 _rate += double.Parse(e.Row.Cells[4].Text);
                 n_rate = double.Parse(e.Row.Cells[4].Text);
                 e.Row.Cells[4].Text = e.Row.Cells[4].Text+"%";
                
             }
            catch{ e.Row.Cells[4].Text ="0%";}
            EFFDSTableAdapters.EFFS_SELFWORKTableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFWORKTableAdapter();
            try
            {
                int apprID = 0;
                Label lb = (Label)e.Row.FindControl("LB_Apprid");
                TextBox tb = (TextBox)e.Row.FindControl("num");

                if (bool.Parse(ViewState["isOver"].ToString()))
                {
                    tb.ReadOnly = true;
                }
                else {
                    tb.ReadOnly = false;
                }  
                if (lb != null)
                    apprID = int.Parse(lb.Text);

                EFFDS.EFFS_SELFWORKDataTable selfdt = selfad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, apprID);
                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFWORKRow selfrow = (EFFDS.EFFS_SELFWORKRow)selfdt.Rows[0];
                        if (!selfrow.IsnumNull())
                        {
                            tb.Text = selfrow.num.ToString("0.0");
                            _num += (double)selfrow.num;
                            n_num = (double)selfrow.num;

                            if (selfrow.mangCheck)
                                tb.ReadOnly = true;
                        }
                        else
                        {
                            tb.Text = "0.0";
                        }
                    }
                }
                else {
                    tb.Text = "0.0";
                }
            }
            catch
            {

            }
            double t_num =  (n_num * n_rate) / 100;
            t_num = Math.Round(t_num, 1, MidpointRounding.AwayFromZero);
            _ratenum += t_num;
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {

            e.Row.Cells[4].Text = _rate.ToString() + "%";
       //     e.Row.Cells[GridView1.Columns.Count - 1].Text = _ratenum.ToString("0.0")+ "分";
        //    e.Row.Cells[GridView1.Columns.Count - 1].Font.Bold = true;

        }
    }
    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (!bool.Parse(ViewState["isOver"].ToString()))
        {

            saveValue(e.CurrentStepIndex);
        }
        if (e.NextStepIndex == 7)
        {
            DataList1.DataSource = DataClass.getEFFMANGSHOWNUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001");
            DataList1.DataBind();
        }

    }

    void saveValue(int CurrentStepIndex)
    {
        switch (CurrentStepIndex)
        {
            case 0:
            case 1:
                EFFDSTableAdapters.EFFS_SELFCATETableAdapter catead = new EFFDSTableAdapters.EFFS_SELFCATETableAdapter();
                EFFDS.EFFS_SELFCATEDataTable catedt = null;
                for (int i = 0; i < DataList2.Items.Count; i++)
                {
                    GridView gv = (GridView)DataList2.Items[i].FindControl("GridView5");

                    for (int j = 0; j < gv.Rows.Count; j++)
                    {
                        string apprID = "";
                        Label lb = (Label)gv.Rows[j].FindControl("lb_effsID");
                        TextBox tb = (TextBox)gv.Rows[j].FindControl("num");
                        Label _rate_ = (Label)gv.Rows[j].FindControl("_rate");

                        if (lb != null)
                            apprID = lb.Text;

                        if (tb != null && tb.Text.Trim().Length > 0)
                        {
                            catedt = catead.GetDataByCateID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, apprID);
                            if (catedt.Rows.Count > 0)
                            {
                                EFFDS.EFFS_SELFCATERow selfrow = (EFFDS.EFFS_SELFCATERow)catedt[0];
                                selfrow.num = decimal.Parse(tb.Text);
                                selfrow.rate = decimal.Parse(_rate_.Text.Replace('%', ' ').Trim());
                                selfrow.keyDate = DateTime.Now;
                            }
                            else
                            {
                                catedt.AddEFFS_SELFCATERow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, apprID, decimal.Parse(tb.Text), DateTime.Now, false,
                                    decimal.Parse(_rate_.Text));
                            }
                        }
                        catead.Update(catedt);
                    }




                }
              //  DataList2.DataBind();
                break;
            case 2:
                EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter viewad = new EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter();
                try
                {
                    for (int i = 0; i < GridViewInterView.Rows.Count; i++)
                    {
                        string apprID = "";
                        Label lb = (Label)GridViewInterView.Rows[i].FindControl("lb_ID");
                        FreeTextBoxControls.FreeTextBox tb = (FreeTextBoxControls.FreeTextBox)GridViewInterView.Rows[i].FindControl("FreeTextBox1");

                        if (lb != null)
                            apprID = lb.Text;

                        EFFDS.EFFS_SELFINTERVIEWDataTable viewdt = viewad.GetDataByInterID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                            _nobr.Text, apprID);
                        if (viewdt.Rows.Count > 0)
                        {
                            EFFDS.EFFS_SELFINTERVIEWRow viewfrow = (EFFDS.EFFS_SELFINTERVIEWRow)viewdt.Rows[0];
                            viewfrow.note = tb.Text;
                            viewfrow.keyDate = DateTime.Now;
                        }
                        else
                        {
                            viewdt.AddEFFS_SELFINTERVIEWRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, apprID
                            , tb.Text, DateTime.Now, false);

                        }
                        viewad.Update(viewdt);
                    }
                }
                catch { }



                break;
            case 3:

            case 4:
         
            case 5:
                break;

        }
    }
    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter appad = new EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter();
        EFFMANGDS.EFFS_MANGAPPENDDataTable appdt = appad.GetDataByMangNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,
            _nobr.Text);
        if (appdt.Rows.Count > 0)
        {


            CS.showScriptAlert(this, "考核資料已經於"+appdt[0].appstddate.ToString()+",傳送過！請勿再次傳送資料！！");

        }
        else 
        {

            if (Session["EFFSInfo"] != null)
            {
                Hashtable ht = (Hashtable)Session["EFFSInfo"];
                EFFDS.EFFS_ATTENDRow attrow = (EFFDS.EFFS_ATTENDRow)ht["attend"];
                EFFDS.EFFS_BASERow baserow = (EFFDS.EFFS_BASERow)ht["base"];
                appdt.AddEFFS_MANGAPPENDRow(int.Parse(_yy.Text), int.Parse(_seq.Text), baserow.nobr, baserow.nobr, baserow.depta,
                    baserow.JOB, "1", DateTime.Now, DateTime.Now, true);
                appad.Update(appdt);


                ViewState["isOver"] = true;



            
               
                if (Session["empInfo"] != null)
                {


                    EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                    string mangnobr = DataClass.getMangFromNobr(row.NOBR, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                    EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());

                    sendMail(emprow.EMAIL, row.NAME_C, emprow.NAME_C);
                    EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = DataClass.getAssignMang(int.Parse(_yy.Text), int.Parse(_seq.Text), row.NOBR);
                    for (int i = 0; i < assdt.Rows.Count; i++) 
                    {
                        EFFDS.EMPINFODataTableRow mangrow = DataClass.getEmpInfo(assdt[i].assignnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                        sendMail(mangrow.EMAIL, row.NAME_C, mangrow.NAME_C);
                    
                    }
                }

                CS.showScriptAlert(this, "傳送完成");
            }
        }


       
        
   
    }


    void sendMail(string mail,string empname,string mangname ) 
    {
        string sub = "";
        string body = "";
        sub = empname + ",已經填寫完成," + _yy.Text + "年" + _seq.Text + "月試用考核資料,請您開始評核！！";


      
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
                    empname + ",已經填寫完成," + _yy.Text + "年" + _seq.Text + "月試用考核資料,請您開始評核！！<br>" +
                   " 請至 <a href='http://eip.syang.com.tw/ezpms'>=== 績效考核系統 ===</a> ,請您開始評核" + empname + "的考核資料,謝謝！<br>" +
                   "<br>" +
                   "<br>" +
                   "<font color='red'>【如執行績效考核有問題，請連絡管理部翁家瑾分機1516】</font><br>" +
                   "<br>" +
                   "</body>" +
                   "</html>";
            CS.SendMail(mail, body, sub);

       
    }



    protected void FormView5_ItemInserting(object sender, FormViewInsertEventArgs e)
    {

    }
    
    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void DataList1_DeleteCommand(object source, DataListCommandEventArgs e)
    {
       
    }
    protected void UPFILEDATELIST_SelectedIndexChanged(object sender, EventArgs e)
    {
       
    }
    protected void UPFILEDATELIST_DeleteCommand(object source, DataListCommandEventArgs e)
    {
     
    }
    protected void FormView5_PageIndexChanging(object sender, FormViewPageEventArgs e)
    {

    }
   
    protected void GridViewInterView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter();
            try
            {
                string apprID = "";
                Label lb = (Label)e.Row.FindControl("lb_ID");
                FreeTextBoxControls.FreeTextBox tb = (FreeTextBoxControls.FreeTextBox)e.Row.FindControl("FreeTextBox1");
                if (bool.Parse(ViewState["isOver"].ToString()))
                {
                    tb.ReadOnly = true;
                }
                if (lb != null)
                    apprID = lb.Text;

                EFFDS.EFFS_SELFINTERVIEWDataTable selfdt = selfad.GetDataByInterID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, apprID);
                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFINTERVIEWRow selfrow = (EFFDS.EFFS_SELFINTERVIEWRow)selfdt.Rows[0];
                        if (!selfrow.IsnoteNull())
                        {
                            tb.Text = selfrow.note.ToString();
                            if (selfrow.mangCheck)
                                tb.ReadOnly = true;
                        }
                        else
                        {
                            tb.Text = "";
                        }
                    }
                }
                else
                {
                    tb.Text = "";
                }
            }
            catch
            {

            }
        }
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["yy"] =int.Parse( _yy.Text);
        e.Values["seq"] = int.Parse( _seq.Text);
        e.Values["nobr"] = _nobr.Text;
        e.Values["keydate"] = DateTime.Now;
    }
   
    protected void DropDownList1_SelectedIndexChanged(object sender, EventArgs e)
    {
       // DataList2.DataBind();
      //  DropDownList2.DataBind();
    }
    protected void Button2_Click(object sender, EventArgs e)
    {
        //EFFDSTableAdapters.EFFS_SELFEDUTableAdapter eduad = new EFFDSTableAdapters.EFFS_SELFEDUTableAdapter();
        //EFFDS.EFFS_SELFEDUDataTable edudt = new EFFDS.EFFS_SELFEDUDataTable();
        //EFFDS.EFFS_SELFEDURow edurow = edudt.NewEFFS_SELFEDURow();
        //edurow.yy = int.Parse( _yy.Text);
        //edurow.seq = int.Parse(_seq.Text);
        //edurow.nobr = _nobr.Text;
        //edurow.keydate = DateTime.Now;
        
        //edurow.eduCateID =DropDownList1.SelectedValue;
        //edurow.eduCateItemID = DropDownList2.SelectedValue;
        //edurow.other = otherTextBox.Text;

        //edudt.AddEFFS_SELFEDURow(edurow);
        //eduad.Update(edudt);
        //GridView2.DataBind();
    }
    protected void Wizard1_ActiveStepChanged(object sender, EventArgs e)
    {//CurrentStepIndex
      
       
    }
    protected void Wizard1_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (!bool.Parse(ViewState["isOver"].ToString()))
        {

            saveValue(e.CurrentStepIndex);
        }
         if (e.NextStepIndex == 7)
         {
             DataList1.DataSource = DataClass.getEFFMANGSHOWNUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001");
             DataList1.DataBind();
         }
        
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        if (_rate != 100)
        {
            CS.showScriptAlert(this, "您的工作目標比重分數不為100%！請至工作目標重新設定！！");
        }
    }
    protected void leanplanGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb = (Label)e.Row.FindControl("planID");
            FreeTextBoxControls.FreeTextBox ftb = (FreeTextBoxControls.FreeTextBox)e.Row.FindControl("PlanText");
            if (bool.Parse(ViewState["isOver"].ToString()))
            {

                ftb.ReadOnly = true;
            }
            EFFDS.EFFS_SELFLEARNPLANRow row = DataClass.getSELFLEARNPLANRow(_yy.Text, _seq.Text, _nobr.Text, lb.Text);
            if (row != null)
            {
                ftb.Text = row.note;
            }
        }
    }
   

}
