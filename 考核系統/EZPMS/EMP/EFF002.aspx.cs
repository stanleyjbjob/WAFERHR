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

public partial class EMP_EFF002 : System.Web.UI.Page
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
                Session["n_yy"] = attrow.n_yy.ToString();
                Session["n_seq"] = attrow.n_seq.ToString();
                ViewState["n_yy"] = attrow.n_yy.ToString();
                ViewState["n_seq"] = attrow.n_seq.ToString();

                EFFDS.EFFS_BASERow baserow = (EFFDS.EFFS_BASERow)ht["base"];
                _yy.Text = attrow.yy.ToString();
                _seq.Text = attrow.seq.ToString();
                _nobr.Text = baserow.nobr;
                _temp.Text = baserow.templetID;
                setDefault();
                Qryframe.Attributes.Add("SRC", "../empInfo.aspx?yy=" + _yy.Text + "&seq=" + _seq.Text + "&nobr=" + _nobr.Text);
                if (attrow.StdDate <= DateTime.Now && attrow.EndDate >= DateTime.Now) {
                    ViewState["isOver"] = false;
                    Session["isOver"] = false;
                }
                else {
                    FormView5.Enabled = false;
                    UPFILEDATELIST.Enabled = false;
                    ViewState["isOver"] = true;
                    Session["isOver"] = true;
                    CS.showScriptAlert(this, "考核時間過期！不可再次修改考核資料！！");
                }
                if (DataClass.getIsSendEffs(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _nobr.Text)) {

                    FormView5.Enabled = false;
                    UPFILEDATELIST.Enabled = false;
                    ViewState["isOver"] = true;
                    Session["isOver"] = true;
                    CS.showScriptAlert(this, "考核資料已經,傳送過！不可再次修改考核資料！！");

                }
            }


            note1.Text = DataClass.getNote("EMP.EFF002.aspx.1");
            note2.Text = DataClass.getNote("EMP.EFF002.aspx.2");
            note3.Text = DataClass.getNote("EMP.EFF002.aspx.3");
           // note4.Text = DataClass.getNote("EMP.EFF002.aspx.4");
            note5.Text = DataClass.getNote("EMP.EFF002.aspx.5");
            note6.Text = DataClass.getNote("EMP.EFF002.aspx.6");
            note7.Text = DataClass.getNote("EMP.EFF002.aspx.7");


            GridView1.DataBind();
            DataList2.DataBind();
        }
        if (Session["n_yy"] == null || Session["n_seq"] == null) {
            Session["n_yy"] = ViewState["n_yy"].ToString();
            Session["n_seq"] = ViewState["n_seq"].ToString();
        }
    }

    void setDefault() {
        bool isOK = true;

        EFF_EXDS.EFFS_FunRow fun = DataClass.getEffs_FunRow(_temp.Text);


        if (fun.fun1)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 0;
                isOK = false;
            }
            Wizard1.WizardSteps[0].Title = fun.fun1_name;

        }
        else
            Wizard1.WizardSteps[0].Title = "";
        if (fun.fun2)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 1;
                isOK = false;
            }
            Wizard1.WizardSteps[1].Title = fun.fun2_name;
        }
        else
            Wizard1.WizardSteps[1].Title = "";
        if (fun.fun3)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 2;
                isOK = false;
            }
            Wizard1.WizardSteps[2].Title = fun.fun3_name;
        }
        else
            Wizard1.WizardSteps[2].Title = "";
        if (fun.fun4)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 3;
                isOK = false;
            }
            Wizard1.WizardSteps[3].Title = fun.fun4_name;
        }
        else
            Wizard1.WizardSteps[3].Title = "";
        if (fun.fun5)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 4;
                isOK = false;
            }
            Wizard1.WizardSteps[4].Title = fun.fun5_name;
        }
        else
            Wizard1.WizardSteps[4].Title = "";
        if (fun.fun6)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 5;
                isOK = false;
            }
            Wizard1.WizardSteps[5].Title = fun.fun6_name;
        }
        else
            Wizard1.WizardSteps[5].Title = "";
        if (fun.fun7)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 6;
                isOK = false;
            }
            Wizard1.WizardSteps[6].Title = fun.fun7_name;
        }
        else
            Wizard1.WizardSteps[6].Title = "";

        if (fun.fun8)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 7;
                isOK = false;
            }
            Wizard1.WizardSteps[7].Title = fun.fun8_name;
        }
        else
            Wizard1.WizardSteps[7].Title = "";


        if (fun.fun9)
        {
            if (isOK)
            {
                Wizard1.ActiveStepIndex = 8;
                isOK = false;
            }
            Wizard1.WizardSteps[8].Title = fun.fun9_name;
        }
        else
            Wizard1.WizardSteps[8].Title = "";

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
                DropDownList ddl_num = (DropDownList)e.Row.FindControl("ddl_num");
                TextBox tb = (TextBox)e.Row.FindControl("num");
                _rate = double.Parse(_rate_.Text);

//                if (ddl_num != null)
  //                  tb.Text = ddl_num.SelectedValue;

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
                            if (!selfrow.IsnumNull()) {
                                switch(selfrow.num.ToString().Substring(0,1)){
                                    case "4":
                                        ddl_num.SelectedIndex = 1;
                                        break;
                                    case "3":
                                        ddl_num.SelectedIndex = 2;
                                        break;
                                    case "2":
                                        ddl_num.SelectedIndex = 3;
                                        break;
                                    case "1":
                                        ddl_num.SelectedIndex = 4;
                                        break;
                                    case "0":
                                        ddl_num.SelectedIndex = 5;
                                        break;
                                }
                                
                            }

                            tb.Text = selfrow.num.ToString("0.00");
                            gv_num = (double)selfrow.num;
                            _rate_.Text = selfrow.rate.ToString("0.00")+"%";
                            _rate = (double)selfrow.rate;
                            if (selfrow.mangCheck)
                                tb.ReadOnly = true;
                        }
                        else
                        {
                            ddl_num.SelectedIndex = 0;
                            tb.Text = "0.00";
                        }
                    }
                }
                else
                {
                    ddl_num.SelectedIndex = 0;
                    tb.Text = "0.00";
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
        Label effcateIDLabel = (Label)e.Item.FindControl("effcateIDLabel");
        TextBox o1 = (TextBox)e.Item.FindControl("o1");
        TextBox o2 = (TextBox)e.Item.FindControl("o2");
        TextBox o3 = (TextBox)e.Item.FindControl("o3");
        if (gv != null && indexList > 0)
        {
            gv.ShowHeader = false;
        }

        if (effcateIDLabel == null)
            return;

        EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter otad = new EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter();
        EFF_EXDS.EFFS_SELFCATEOTHERDataTable otdt = otad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, effcateIDLabel.Text,_nobr.Text);
        if (otdt.Rows.Count > 0) {
            o1.Text = otdt[0].o1;
            o2.Text = otdt[0].o2;
            o3.Text = otdt[0].o3;
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
                DropDownList ddl_num = (DropDownList)e.Row.FindControl("ddl_num");

                

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
                            if (!selfrow.IsnumNull()) {
                                switch (selfrow.num.ToString().Substring(0, 1)) {
                                    case "4":
                                        ddl_num.SelectedIndex = 1;
                                        break;
                                    case "3":
                                        ddl_num.SelectedIndex = 2;
                                        break;
                                    case "2":
                                        ddl_num.SelectedIndex = 3;
                                        break;
                                    case "1":
                                        ddl_num.SelectedIndex = 4;
                                        break;
                                    case "0":
                                        ddl_num.SelectedIndex = 5;
                                        break;
                                }

                            }
                            tb.Text = selfrow.num.ToString("0.00");
                            _num += (double)selfrow.num;
                            n_num = (double)selfrow.num;

                            if (selfrow.mangCheck)
                                tb.ReadOnly = true;
                        }
                        else
                        {
                            tb.Text = "0.00";
                        }
                    }
                }
                else {
                    tb.Text = "0.00";
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

            e.Row.Cells[4].Text =  Convert.ToString( Math.Round( _rate,2)) + "%";
            e.Row.Cells[GridView1.Columns.Count - 1].Text = _ratenum.ToString("0.00")+ "分";
            e.Row.Cells[GridView1.Columns.Count - 1].Font.Bold = true;

        }
    }
    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (e.NextStepIndex == 1) {
            Wizard1.ActiveStepIndex = 2;
          //  e.Cancel = true;
            
        }
        if (!bool.Parse(ViewState["isOver"].ToString()))
        {

            saveValue(e.CurrentStepIndex);
        }
        if (e.NextStepIndex == 8)
        {
            DataList1.DataSource = DataClass.getEFFMANGSHOWNUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001");
            DataList1.DataBind();

            GridView2.DataSource = DataClass.getSelfType(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _temp.Text, true);
            GridView2.DataBind();
        }

    }

    void saveValue(int CurrentStepIndex)
    {
       // GridViewInterView.DataBind();
        switch (CurrentStepIndex)
        {
            case 0:
                try
                {
                    EFFDSTableAdapters.EFFS_SELFWORKTableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFWORKTableAdapter();
                    EFFDSTableAdapters.EFFS_APPRTableAdapter apprad = new EFFDSTableAdapters.EFFS_APPRTableAdapter();
                    EFFDS.EFFS_APPRDataTable apprdt = null;
                    EFFDS.EFFS_SELFWORKDataTable selfdt = null;
                    for (int i = 0; i < GridView1.Rows.Count; i++)
                    {
                        try
                        {
                            DropDownList ddl_num = (DropDownList)GridView1.Rows[i].FindControl("ddl_num");
                            int apprID = 0;
                            TextBox tb = (TextBox)GridView1.Rows[i].FindControl("num");
                            if (ddl_num != null)
                                tb.Text = ddl_num.SelectedValue;
                            if (bool.Parse(ViewState["isOver"].ToString()))
                            {

                                tb.ReadOnly = true;
                            }
                            //LB_Apprid
                            Label lb = (Label)GridView1.Rows[i].FindControl("LB_Apprid");
                            Label lbautokey = (Label)GridView1.Rows[i].FindControl("_AutoKey");
                            FreeTextBoxControls.FreeTextBox _appr = (FreeTextBoxControls.FreeTextBox)GridView1.Rows[i].FindControl("ftb_appr");
                            if (lbautokey != null && _appr != null)
                            {
                                try
                                {
                                    apprdt = apprad.GetDataByID(int.Parse(lbautokey.Text));
                                    if (apprdt.Rows.Count > 0)
                                    {
                                        EFFDS.EFFS_APPRRow approw = (EFFDS.EFFS_APPRRow)apprdt.Rows[0];

                                        approw.bespeak = _appr.Text;
                                        apprad.Update(apprdt);
                                    }
                                }
                                catch { }
                            }

                            if (lb != null)
                                apprID = int.Parse(lb.Text);

                            if (tb != null && tb.Text.Trim().Length > 0)
                            {
                                selfdt = selfad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, apprID);
                                if (selfdt.Rows.Count > 0)
                                {
                                    EFFDS.EFFS_SELFWORKRow selfrow = (EFFDS.EFFS_SELFWORKRow)selfdt[0];
                                    selfrow.num = decimal.Parse(tb.Text);
                                    selfrow.keydate = DateTime.Now;
                                }
                                else
                                {
                                    selfdt.AddEFFS_SELFWORKRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, decimal.Parse(tb.Text), DateTime.Now, false,
                                        apprID);
                                }
                            }

                            selfad.Update(selfdt);
                        }
                        catch (Exception ex)
                        {
                            CS.ErrorLog("JB", "EMP/EFF001.aspx", ex.Message);
                        }
                    }
                    GridView1.DataBind();
                }
                catch (Exception ex)
                {
                    CS.ErrorLog("JB", "EMP/EFF001.aspx", ex.Message);
                }
                break;
            case 2:
                EFFDSTableAdapters.EFFS_SELFCATETableAdapter catead = new EFFDSTableAdapters.EFFS_SELFCATETableAdapter();
                EFFDS.EFFS_SELFCATEDataTable catedt = null;
                for (int i = 0; i < DataList2.Items.Count; i++)
                {

                    Label effcateIDLabel = (Label)DataList2.Items[i].FindControl("effcateIDLabel");
                    TextBox o1 = (TextBox)DataList2.Items[i].FindControl("o1");
                    TextBox o2 = (TextBox)DataList2.Items[i].FindControl("o2");
                    TextBox o3 = (TextBox)DataList2.Items[i].FindControl("o3");

                    EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter otad = new EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter();
                    EFF_EXDS.EFFS_SELFCATEOTHERDataTable otdt = otad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, effcateIDLabel.Text,_nobr.Text);
                    if (otdt.Rows.Count > 0) {
                        otdt[0].o1 = o1.Text;
                        otdt[0].o2 = o2.Text;
                        otdt[0].o3 = o3.Text;
                        otdt[0].keydate = DateTime.Now.ToShortDateString();
                        otad.Update(otdt);

                    }
                    else {
                        EFF_EXDS.EFFS_SELFCATEOTHERRow row = otdt.NewEFFS_SELFCATEOTHERRow();
                        row.yy = int.Parse(_yy.Text);
                        row.seq = int.Parse(_seq.Text);
                        row.cateID = effcateIDLabel.Text;
                        row.nobr = _nobr.Text;
                        row.o1 = o1.Text;
                        row.o2 = o2.Text;
                        row.o3 = o3.Text;
                        row.mangNobr = _nobr.Text;
                        row.keydate = DateTime.Now.ToShortDateString();
                        otdt.AddEFFS_SELFCATEOTHERRow(row);
                        otad.Update(otdt);
                    
                    }
                    
                    
                    
                    
                    GridView gv = (GridView)DataList2.Items[i].FindControl("GridView5");

                    for (int j = 0; j < gv.Rows.Count; j++)
                    {
                        string apprID = "";
                        Label lb = (Label)gv.Rows[j].FindControl("lb_effsID");
                        TextBox tb = (TextBox)gv.Rows[j].FindControl("num");
                        DropDownList ddl_num = (DropDownList)gv.Rows[j].FindControl("ddl_num");
                        Label _rate_ = (Label)gv.Rows[j].FindControl("_rate");

                        if (lb != null)
                            apprID = lb.Text;

                        if (ddl_num != null)
                            tb.Text = ddl_num.SelectedValue;

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
                        if (catedt != null) {
                            catead.Update(catedt);
                        }
                    }




                }
              //  DataList2.DataBind();
                break;
            case 3:
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
            case 4:

            case 5:
                EFFDSTableAdapters.EFFS_SELFLEARNPLANTableAdapter learnplanad = new EFFDSTableAdapters.EFFS_SELFLEARNPLANTableAdapter();
                for (int i = 0; i < leanplanGridView.Rows.Count; i++)
                {
                    Label lb = (Label)leanplanGridView.Rows[i].FindControl("planID");
                    FreeTextBoxControls.FreeTextBox ftb = (FreeTextBoxControls.FreeTextBox)leanplanGridView.Rows[i].FindControl("PlanText");
                    EFFDS.EFFS_SELFLEARNPLANDataTable learnplandt = learnplanad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, lb.Text);
                    EFFDS.EFFS_SELFLEARNPLANRow learnplanrow = null;
                    if (learnplandt.Rows.Count > 0)
                    {
                        learnplanrow = (EFFDS.EFFS_SELFLEARNPLANRow)learnplandt.Rows[0];
                        learnplanrow.note = ftb.Text;
                    }
                    else 
                    {
                        learnplanrow = learnplandt.NewEFFS_SELFLEARNPLANRow();
                        learnplanrow.note = ftb.Text;
                        learnplanrow.nobr = _nobr.Text;
                        learnplanrow.learnplanID = lb.Text;
                        learnplanrow.yy = int.Parse(_yy.Text);
                        learnplanrow.seq = int.Parse(_seq.Text);
                        learnplandt.AddEFFS_SELFLEARNPLANRow(learnplanrow);
                    }
                    learnplanad.Update(learnplandt);
                }
                break;
            case 6:
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
        sub = empname + ",已經填寫完成," + _yy.Text + "年第" + _seq.Text + "績效考核資料,請您開始評核！！";


      
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
                    empname + ",已經填寫完成," + _yy.Text + "年第" + _seq.Text + "績效考核資料,請您開始評核！！<br>" +
                   " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\"  ,請您開始評核" + empname + "的績效考核資料,謝謝！<br>" +
                   "<br>" +
                   "<br>" +
                   "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
                   "<br>" +
                   "</body>" +
                   "</html>";
            CS.SendMail(mail, body, sub);

       
    }



    protected void FormView5_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        FileUpload file1 = (FileUpload)FormView5.Row.FindControl("FileUpload1");
        TextBox _fileDesc = (TextBox)FormView5.Row.FindControl("filedesc");
      
        if (file1 != null)
        {
            if (!file1.HasFile)
            {
                showUpFileMSG.Text = "未指定要上傳的檔案";
             //   Literal1.Text = Cs.MessageShowAlert("未指定要上傳的檔案");
                return;
            }

            if (file1.PostedFile.ContentLength > 1000000)
            {
                // showMessage.Text = ;
                CS.showScriptAlert(this,"上傳附件檔案超過1MB！！");
             //   Literal1.Text = Cs.MessageShowAlert("上傳附件檔案超過3MB！！");
                return;
            }

            string fileName = _yy.Text.Trim()+_seq.Text.Trim()+_nobr.Text.Trim() + DateTime.Now.ToFileTime().ToString();
            file1.PostedFile.SaveAs(Server.MapPath("..") + "\\File\\" + fileName);
            // showUpFileMSG.Text = file1.FileName + "上傳成功" + file1.PostedFile.ContentType + "  " + fileName;
         //   showMsg.Text = "檔案上傳成功";
          //  Literal1.Text = Cs.MessageShowAlert("檔案上傳成功");

            e.Values["autoKey"] = 0;
            e.Values["yy"] = _yy.Text;
            e.Values["seq"] = _seq.Text;
            e.Values["nobr"] = _nobr.Text;
            e.Values["upfilename"] = file1.FileName;
            e.Values["serverfilename"] = fileName;
            e.Values["filetype"] = file1.PostedFile.ContentType;
            e.Values["upfiledate"] = DateTime.Now;
            e.Values["filesize"] = Math.Round(double.Parse(file1.PostedFile.ContentLength.ToString()) / 1024, 2) + "KB";
            e.Values["filedesc"] = _fileDesc.Text;
        }
    }
    protected void DataList1_SelectedIndexChanged(object sender, EventArgs e)
    {
        
    }
    protected void DataList1_DeleteCommand(object source, DataListCommandEventArgs e)
    {
       
    }
    protected void UPFILEDATELIST_SelectedIndexChanged(object sender, EventArgs e)
    {
        Label _fileServerName = (Label)UPFILEDATELIST.Items[UPFILEDATELIST.SelectedIndex].FindControl("fileServerName");
        Label _upfilenameLabel = (Label)UPFILEDATELIST.Items[UPFILEDATELIST.SelectedIndex].FindControl("upfilenameLabel");
        FileStream MyFileStream;
        string FileName = "";
        long FileHandle = 0, FileSize = 0;
        FileName = Server.MapPath("../File/" + _fileServerName.Text);
        FileInfo fileInfo = new FileInfo(FileName);

        if (fileInfo.Exists)
        {
            Response.ClearHeaders();
            Response.Clear();
            Response.AddHeader("Accept-Language", "zh-tw");
            Response.AddHeader("Content-Disposition", "attachment; filename=" + HttpUtility.UrlEncode(_upfilenameLabel.Text, System.Text.Encoding.UTF8));

            Response.AddHeader("Content-Length", fileInfo.Length.ToString());
            Response.ContentType = "application/octet-stream";
            Response.WriteFile(fileInfo.FullName);
            Response.Flush();
        }
        else
        {
            //找不到檔案：
        }
        Response.End(); 
    }
    protected void UPFILEDATELIST_DeleteCommand(object source, DataListCommandEventArgs e)
    {
        Label _fileServerName = (Label)e.Item.FindControl("fileServerName");
        SqlDataSource_UPFILE.DeleteCommand = "DELETE FROM [effs_UpFile] WHERE [serverfilename] = '" + _fileServerName.Text + "'";
        SqlDataSource_UPFILE.Delete();
       // DataList1.DataBind();


        FileInfo TheFile = new FileInfo(Server.MapPath("../File/" + _fileServerName.Text));
        if (TheFile.Exists)
        {
            Server.MapPath("../File/" + _fileServerName.Text);
        }
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
         if (e.NextStepIndex == 8)
         {
             DataList1.DataSource = DataClass.getEFFMANGSHOWNUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001");
             DataList1.DataBind();
             GridView2.DataSource = DataClass.getSelfType(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _temp.Text, true);
             GridView2.DataBind();
         }
        
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        if (_rate != 100)
        {
      //      CS.showScriptAlert(this, "您的工作目標權重分數不為100%！請至工作目標重新設定！！");
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


    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e) {

    }
    protected void GridView2_RowCreated(object sender, GridViewRowEventArgs e)
    {
       e.Row.Cells[0].Visible = false;
    }
    protected void GridView2_DataBound(object sender, EventArgs e)
    {
        GridView gv = (GridView)sender;
        double tot_num = 0;
        for (int i = 0; i < gv.Rows.Count; i++) 
        {

           tot_num+=  double.Parse( gv.Rows[i].Cells[2].Text.ToString());

        }
       
        gv.FooterRow.Cells[1].Text = "總評分：";
        if (gv.Rows.Count == 2)
        {
            gv.FooterRow.Cells[2].Text = Convert.ToString(Math.Round(tot_num / 2, 3, MidpointRounding.AwayFromZero));
        }
        else {
            gv.FooterRow.Cells[2].Text = Convert.ToString(tot_num);
        }
    }
    protected void FinishButton_Click(object sender, EventArgs e)
    {

    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Button bu = sender as Button;
        saveValue(int.Parse(bu.CommandArgument));
        CS.showScriptAlert(this, "存檔完成");
    }
}
