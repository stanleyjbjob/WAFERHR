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

public partial class SelfEffs : System.Web.UI.Page
    
{
   
    protected void Page_Load(object sender, EventArgs e)
    {
        FIELDSET1.Visible = false;
        FIELDSET2.Visible = false;
        FIELDSET3.Visible = false;
        FIELDSET4.Visible = false;
        FIELDSET5.Visible = false;

        
        if (!IsPostBack) 
        {
  
            if (Session["EFFSInfo"] != null)
            {
                Hashtable ht = (Hashtable)Session["EFFSInfo"];
                EFFDS.EFFS_ATTENDRow attrow = (EFFDS.EFFS_ATTENDRow)ht["attend"];
                EFFDS.EFFS_BASERow baserow = (EFFDS.EFFS_BASERow)ht["base"];
                _yy.Text = attrow.yy.ToString();
                _seq.Text = attrow.seq.ToString();
                _nobr.Text = baserow.nobr;
                _temp.Text = baserow.templetID;
            }
            
          

            if (Session["empInfo"] != null)
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                _mangnobr.Text = row.NOBR;
                _deptm.Text = row.DEPTM;


                    _mange.Text = "True";

                    _deptorder.Text = "1000";
              
            }

           
               
           


            Qryframe.Attributes.Add("SRC", "../empInfo.aspx?yy=" + _yy.Text + "&seq=" + _seq.Text + "&nobr=" + _nobr.Text + "&mang=" + _mange.Text);
            
            if (!IsPostBack) {
                EFFMANGDSTableAdapters.EFFS_MANGLEARNPLANTableAdapter planad = new EFFMANGDSTableAdapters.EFFS_MANGLEARNPLANTableAdapter();
                EFFMANGDS.EFFS_MANGLEARNPLANDataTable plandt = planad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text);
                if (plandt.Rows.Count > 0)
                {
                    EFFMANGDS.EFFS_MANGLEARNPLANRow planrow = (EFFMANGDS.EFFS_MANGLEARNPLANRow)plandt.Rows[0];

                    if (!planrow.Isnote1Null())
                    {
                        PlanText.Text = planrow.note1;

                    }
                    if (!planrow.Isnote2Null())
                        PlanText1.Text = planrow.note2;

                }

                if (_Appoint.Text.Trim().Equals("True") || !bool.Parse( _mange.Text))
                {
                   // GridView3.Visible = false;
                   // GridView31.Visible = false;
                }
   
            }


            note1.Text = DataClass.getNote("Mang.EFF004.aspx.1");
            note2.Text = DataClass.getNote("Mang.EFF004.aspx.2");
            note3.Text = DataClass.getNote("Mang.EFF004.aspx.3");
            note4.Text = DataClass.getNote("Mang.EFF004.aspx.4");
            note5.Text = DataClass.getNote("Mang.EFF004.aspx.5");
            note6.Text = DataClass.getNote("Mang.EFF004.aspx.6");
            note7.Text = DataClass.getNote("Mang.EFF004.aspx.7");
           
        }
        setFinish();
    }


    void setFinish() {

        ArrayList al_nobr = new ArrayList();
        Hashtable ht_name = new Hashtable();

        if (bool.Parse(_Appoint.Text))
        {
            if (Session["empInfo"] != null)
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                al_nobr.Add(row.NOBR.Trim());
                ht_name.Add(row.NOBR.Trim(), row.NAME_C);
            }

        }
        else
        {
            int mangorder = int.Parse(_deptorder.Text);
            EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
            EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assing = DataClass.getAssignEmpNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
            for (int i = 0; i < arrpmang.Rows.Count; i++)
            {

                EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];


                //    if (!row.mangnobr.Trim().Equals(_mangnobr.Text.Trim()))
                //    {
                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                if (emprow != null)
                {
                    if (emprow.cate_order <= mangorder)
                    {
                        if (bool.Parse(_mange.Text))
                        {

                            al_nobr.Add(row.mangnobr.Trim());
                            ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                        }
                        else
                        {
                            if (assing.Select("assignnobr='" + row.mangnobr.Trim() + "'").Length == 0)
                            {

                                al_nobr.Add(row.mangnobr.Trim());
                                ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());

                            }

                        }

                    }
                }
                //   }

            }
        }
        DataList1.DataSource = DataClass.getEFFMANGSHOWNUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001", al_nobr);
        DataList1.DataBind();
    }


    void saveValue(int CurrentStepIndex)
    {
        if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow mangrow = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
            EFFMANGDSTableAdapters.EFFS_MANGLEARNPLANTableAdapter planad = new EFFMANGDSTableAdapters.EFFS_MANGLEARNPLANTableAdapter();
            EFFMANGDS.EFFS_MANGLEARNPLANDataTable plandt = planad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text);

            switch (CurrentStepIndex)
            {
                case 0:
                    EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter workad = new EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter();
                    EFFMANGDS.EFFS_MANGAPPRWORKDataTable workdt = null;
                    for (int i = 0; i < GridView1.Rows.Count; i++)
                    {
                        int apprID = 0;
                        TextBox tb = (TextBox)GridView1.Rows[i].FindControl("mangnum");
                        //LB_Apprid
                        Label lb = (Label)GridView1.Rows[i].FindControl("LB_Apprid");
                        if (lb != null)
                            apprID = int.Parse(lb.Text);

                        if (tb != null && tb.Text.Trim().Length > 0)
                        {
                            workdt = workad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text, apprID);
                            if (workdt.Rows.Count > 0)
                            {
                                EFFMANGDS.EFFS_MANGAPPRWORKRow workrow = (EFFMANGDS.EFFS_MANGAPPRWORKRow)workdt[0];
                                workrow.num = decimal.Parse(tb.Text);
                                workrow.keydate = DateTime.Now;
                            }
                            else
                            {
                                workdt.AddEFFS_MANGAPPRWORKRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,_mangnobr.Text,mangrow.DEPT,mangrow.JOB,apprID, decimal.Parse(tb.Text), DateTime.Now);
                            }
                        }
                        workad.Update(workdt);
                    }
                   
                    break;
                case 1:

                    EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter catead = new EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter();
                    EFFMANGDS.EFFS_MANGAPPRCATEDataTable catedt = null;


                    for (int j = 0; j < GridView5.Rows.Count; j++)
                    {
                        string apprID = "";
                        Label lb = (Label)GridView5.Rows[j].FindControl("lb_effsID");
                        TextBox tb = (TextBox)GridView5.Rows[j].FindControl("mangnum");

                        if (lb != null)
                            apprID = lb.Text;

                        if (tb != null && tb.Text.Trim().Length > 0)
                        {
                            catedt = catead.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text, apprID);
                            if (catedt.Rows.Count > 0)
                            {
                                EFFMANGDS.EFFS_MANGAPPRCATERow selfrow = (EFFMANGDS.EFFS_MANGAPPRCATERow)catedt[0];
                                selfrow.num = decimal.Parse(tb.Text);
                                selfrow.keydate = DateTime.Now;
                            }
                            else
                            {
                                catedt.AddEFFS_MANGAPPRCATERow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,
                                   _mangnobr.Text, mangrow.DEPT, mangrow.JOB, apprID, decimal.Parse(tb.Text), DateTime.Now
                                    );
                            }
                        }
                        catead.Update(catedt);
                    }
                    
                    break;
                case 2:
                    EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter viewad = new EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter();
                    try
                    {
                        for (int i = 0; i < GridViewInterView.Rows.Count; i++)
                        {
                            string apprID = "";
                            Label lb = (Label)GridViewInterView.Rows[i].FindControl("lb_ID");
                            FreeTextBoxControls.FreeTextBox tb = (FreeTextBoxControls.FreeTextBox)GridViewInterView.Rows[i].FindControl("FreeTextBox2");

                            if (lb != null)
                                apprID = lb.Text;

                            EFFMANGDS.EFFS_MANGINTERVIEWDataTable viewdt = viewad.GetDataByInterID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                                _nobr.Text,_mangnobr.Text, apprID);
                            if (viewdt.Rows.Count > 0)
                            {
                                EFFMANGDS.EFFS_MANGINTERVIEWRow viewfrow = (EFFMANGDS.EFFS_MANGINTERVIEWRow)viewdt.Rows[0];
                                viewfrow.note = tb.Text;
                                viewfrow.keyDate = DateTime.Now;
                            }
                            else
                            {
                                viewdt.AddEFFS_MANGINTERVIEWRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,_mangnobr.Text, apprID
                                , tb.Text, DateTime.Now);

                            }
                            viewad.Update(viewdt);
                        }
                    }
                    catch { }

                    break;
                case 3:
                    if (plandt.Rows.Count > 0)
                    {
                        EFFMANGDS.EFFS_MANGLEARNPLANRow planrow = (EFFMANGDS.EFFS_MANGLEARNPLANRow)plandt.Rows[0];
                        planrow.note2 = PlanText1.Text;
                    }
                    else
                    {
                        plandt.AddEFFS_MANGLEARNPLANRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text, mangrow.DEPTM, mangrow.JOB, "",PlanText1.Text
                        , "", "", "");

                    }
                    GridView31.DataBind();
                    break;
                case 4:
                    if (plandt.Rows.Count > 0)
                    {
                        EFFMANGDS.EFFS_MANGLEARNPLANRow planrow = (EFFMANGDS.EFFS_MANGLEARNPLANRow)plandt.Rows[0];
                        planrow.note1 = PlanText.Text;
                    }
                    else
                    {
                        plandt.AddEFFS_MANGLEARNPLANRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text, mangrow.DEPTM, mangrow.JOB, PlanText.Text
                        ,"","","","");
                 
                    }

                        planad.Update(plandt);
                        GridView3.DataBind();
                    break;
                case 5:
                    break;
            }
        }
        else {
            CS.showScriptAlert(this,"等待時間過久，請重新登入！！");
        }
    }
    protected void FormView5_ItemInserting(object sender, FormViewInsertEventArgs e)
    {

    }
    protected void FormView5_PageIndexChanging(object sender, FormViewPageEventArgs e)
    {

    }
    protected void UPFILEDATELIST_SelectedIndexChanged(object sender, EventArgs e)
    {
        Label _fileServerName = (Label)UPFILEDATELIST.Items[UPFILEDATELIST.SelectedIndex].FindControl("fileServerName");
        Label _upfilenameLabel = (Label)UPFILEDATELIST.Items[UPFILEDATELIST.SelectedIndex].FindControl("upfilenameLabel");
        string FileName = "";
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

    }
    void setCheckEffMang(object sender, ArrayList al, Hashtable ht)
    {
        GridView gv = (GridView)sender;
        int index = 16;
        int add = al.Count;
        EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter workad = new EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter();


        for (int i = 0; i < al.Count; i++)
        {
            gv.Columns[index + i].Visible = true;
            gv.Columns[index + i].HeaderText = ht[al[i].ToString()].ToString();

            EFFMANGDS.EFFS_NUMRow numrow = DataClass.getEFFSELENUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001", al[i].ToString());
            if (numrow != null)
                gv.FooterRow.Cells[index + i].Text = numrow.apprnum.ToString("0.0") ;

            for (int j = 0; j < gv.Rows.Count; j++)
            {
                Label mtb = (Label)gv.Rows[j].FindControl("nummang" + Convert.ToString(i + 1));

                int apprID = 0;
                Label lb = (Label)gv.Rows[j].FindControl("LB_Apprid");

                if (lb != null)
                    apprID = int.Parse( lb.Text);

                EFFMANGDS.EFFS_MANGAPPRWORKDataTable catedt = workad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, al[i].ToString(), apprID);
                if (catedt.Rows.Count > 0)
                {
                    if (mtb != null)
                    {
                        EFFMANGDS.EFFS_MANGAPPRWORKRow caterow = (EFFMANGDS.EFFS_MANGAPPRWORKRow)catedt[0];
                        if (!caterow.IsnumNull())
                        {
                            mtb.Text = caterow.num.ToString("0.0");
                        }
                        else
                        {
                            mtb.Text = "0.0";
                        }
                    }

                }
                else
                {
                    mtb.Text = "0.0";

                }

            }

        }



    }

    void setCheckEffCateMang(object sender, ArrayList al, Hashtable ht)
    {
        GridView gv = (GridView)sender;
        int index = 5;
        int add = al.Count;
          EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter catead = new EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter();

  

        for (int i = 0; i < al.Count; i++)
        {
            gv.Columns[index + i].Visible = true;
            gv.Columns[index + i].HeaderText = ht[al[i].ToString()].ToString();

            EFFMANGDS.EFFS_NUMRow numrow = DataClass.getEFFSELENUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001", al[i].ToString());
            if (numrow != null)
                gv.FooterRow.Cells[index + i].Text = numrow.catenum.ToString("0.0") ;

 
            for (int j = 0; j < gv.Rows.Count; j++)
            {
               
                Label mtb = (Label)gv.Rows[j].FindControl("nummang" + Convert.ToString(i + 1));

                string apprID = "";
                Label lb =  (Label)gv.Rows[j].FindControl("lb_effsID");
  
                if (lb != null)
                    apprID = lb.Text;

                EFFMANGDS.EFFS_MANGAPPRCATEDataTable catedt = catead.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, al[i].ToString(), apprID);
                if (catedt.Rows.Count > 0)
                {
                    if (mtb != null)
                    {
                        EFFMANGDS.EFFS_MANGAPPRCATERow caterow = (EFFMANGDS.EFFS_MANGAPPRCATERow)catedt[0];
                        if (!caterow.IsnumNull())
                        {
                          mtb.Text = caterow.num.ToString("0.0");
                        //   gv.Rows[j].Cells[index + i].Text = caterow.num.ToString();
                        }
                        else
                        {
                           mtb.Text = "0.0";
                           // gv.Rows[j].Cells[index + i].Text = "0";
                        }
                    }

                }
                else
                {
                    mtb.Text = "0.0";
                  //  gv.Rows[j].Cells[index + i].Text = "0";

                }

            }

        }



    }

    void setCheckEffInterViewMang(object sender, ArrayList al, Hashtable ht)
    {
        GridView gv = (GridView)sender;
        int index = 3;
        int add = al.Count;
        EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter interad = new EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter();



        for (int i = 0; i < al.Count; i++)
        {
            gv.Columns[index + i].Visible = true;
            gv.Columns[index + i].HeaderText = ht[al[i].ToString()].ToString();



            for (int j = 0; j < gv.Rows.Count; j++)
            {

                Label mtb = (Label)gv.Rows[j].FindControl("nummang" + Convert.ToString(i + 1));

                string apprID = "";
                Label lb = (Label)gv.Rows[j].FindControl("lb_ID");

                if (lb != null)
                    apprID = lb.Text;
                EFFMANGDS.EFFS_MANGINTERVIEWDataTable interdt = interad.GetDataByInterID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, al[i].ToString(), apprID);
                if (interdt.Rows.Count > 0)
                {
                    if (mtb != null)
                    {
                        EFFMANGDS.EFFS_MANGINTERVIEWRow interrow = (EFFMANGDS.EFFS_MANGINTERVIEWRow)interdt[0];
                        if (!interrow.IsnoteNull())
                        {
                            mtb.Text = interrow.note;
                        }
                        else
                        {
                            mtb.Text = "";
                        }
                    }

                }
                else
                {
                    mtb.Text = "";

                }

            }

        }



    }


    decimal f_rate = 0;
    protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            try
            {

                f_rate += decimal.Parse(e.Row.Cells[4].Text.Replace('%', ' ').Trim());
            }
            catch { }
            EFFDSTableAdapters.EFFS_SELFWORKTableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFWORKTableAdapter();
            EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter workad = new EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter();

            try
            {
                int apprID = 0;
                Label lb = (Label)e.Row.FindControl("LB_Apprid");
                Label tb = (Label)e.Row.FindControl("num");
                TextBox mtb = (TextBox)e.Row.FindControl("mangnum");

                if (lb != null)
                    apprID = int.Parse(lb.Text);

                EFFDS.EFFS_SELFWORKDataTable selfdt = selfad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, apprID);
                EFFMANGDS.EFFS_MANGAPPRWORKDataTable workdt = workad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text,apprID);
                if (workdt.Rows.Count > 0) 
                {
                    if (mtb != null)
                    {
                        EFFMANGDS.EFFS_MANGAPPRWORKRow workrow = (EFFMANGDS.EFFS_MANGAPPRWORKRow)workdt.Rows[0];
                        if (!workrow.IsnumNull())
                        {
                            mtb.Text = workrow.num.ToString("0.0");
                        }
                        else
                        {

                            mtb.Text = "0.0";
                        }
                    }
                    
                
                }
                else
                {
                    mtb.Text = "0.0";
                }
                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFWORKRow selfrow = (EFFDS.EFFS_SELFWORKRow)selfdt.Rows[0];
                        if (!selfrow.IsnumNull())
                        {
                            tb.Text = selfrow.num.ToString("0.0");
                          //  e.Row.Cells[GridView1.Columns.Count - 1].Text = selfrow.num.ToString("0");
                          //  e.Row.Cells[GridView1.Columns.Count - 1].HorizontalAlign = HorizontalAlign.Center;
                            
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
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            e.Row.Cells[4].Text = f_rate.ToString("0") + "%";
            f_rate = 0;
            EFFMANGDS.EFFS_NUMRow numrow = DataClass.getEFFSELENUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001", _mangnobr.Text);
            EFFMANGDS.EFFS_NUMRow numselfrow = DataClass.getEFFSELENUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001");


            if (numselfrow != null)
            {

                e.Row.Cells[15].Text = numselfrow.apprnum.ToString("0.0") ;
            }
            if (numrow !=null)
            {


              //  e.Row.Cells[4].Text = numrow.apprrate.ToString("0.0") + "%";

                e.Row.Cells[GridView1.Columns.Count - 1].Text = numrow.apprnum.ToString("0.0") ;
            }

        }

    }
    int indexList = 0;
    protected void DataList2_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        GridView gv = (GridView)e.Item.FindControl("GridView5");
        if (gv != null && indexList>0)
        {
            gv.ShowHeader = false;
        }
        indexList++;




        
    }
    decimal g5_f_rate = 0;
    protected void GridView5_RowDataBound(object sender, GridViewRowEventArgs e)
    {

        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            EFFDSTableAdapters.EFFS_SELFCATETableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFCATETableAdapter();
            EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter catead = new EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter();

           
            try
            {
                string apprID = "";
                Label lb = (Label)e.Row.FindControl("lb_effsID");
                Label tb = (Label)e.Row.FindControl("num");
                TextBox mtb = (TextBox)e.Row.FindControl("mangnum");
                Label _rate = (Label)e.Row.FindControl("_rate");
                g5_f_rate += decimal.Parse(_rate.Text);
                if (lb != null)
                    apprID = lb.Text;

                EFFDS.EFFS_SELFCATEDataTable selfdt = selfad.GetDataByCateID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, apprID);
                EFFMANGDS.EFFS_MANGAPPRCATEDataTable catedt = catead.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, _mangnobr.Text, apprID);
                if (catedt.Rows.Count > 0)
                {
                    if (mtb != null)
                    {
                        EFFMANGDS.EFFS_MANGAPPRCATERow caterow = (EFFMANGDS.EFFS_MANGAPPRCATERow)catedt[0];
                        if (!caterow.IsnumNull())
                        {
                            mtb.Text = caterow.num.ToString("0.0");
                        }
                        else {
                            mtb.Text = "0.0";
                        }
                    }

                }
                else {
                    mtb.Text = "0.0";
                
                }

                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFCATERow selfrow = (EFFDS.EFFS_SELFCATERow)selfdt.Rows[0];
                        if (!selfrow.IsnumNull())
                        {
                            tb.Text = selfrow.num.ToString("0.0");
                            _rate.Text = selfrow.rate.ToString("0.0");
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
        }
        if (e.Row.RowType == DataControlRowType.Footer)
        {
            Label g5_f_rate_ = (Label)e.Row.FindControl("g5_f_rate");
            g5_f_rate_.Text = g5_f_rate.ToString("0");
            g5_f_rate = 0;
            EFFMANGDS.EFFS_NUMRow numrow = DataClass.getEFFSELENUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001", _mangnobr.Text);
            EFFMANGDS.EFFS_NUMRow numselfrow = DataClass.getEFFSELENUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001");


            if (numselfrow != null)
            {

                e.Row.Cells[4].Text = numselfrow.catenum.ToString("0.0") ;
            }
            if (numrow != null)
            {
                e.Row.Cells[GridView5.Columns.Count - 1].Text = numrow.catenum.ToString("0.0") ;
            }

        }

    }
    protected void GridViewInterView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFINTERVIEWTableAdapter();
            EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter interad = new EFFMANGDSTableAdapters.EFFS_MANGINTERVIEWTableAdapter();
            try
            {
                string apprID = "";
                Label lb = (Label)e.Row.FindControl("lb_ID");
                Label tb = (Label)e.Row.FindControl("FreeTextBox1");
                FreeTextBoxControls.FreeTextBox mtb = (FreeTextBoxControls.FreeTextBox)e.Row.FindControl("FreeTextBox2");


                if (lb != null)
                    apprID = lb.Text;

                EFFDS.EFFS_SELFINTERVIEWDataTable selfdt = selfad.GetDataByInterID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, apprID);
                EFFMANGDS.EFFS_MANGINTERVIEWDataTable interdt = interad.GetDataByInterID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text,_mangnobr.Text, apprID);
                if (interdt.Rows.Count > 0)
                {
                    if (mtb != null)
                    {
                        EFFMANGDS.EFFS_MANGINTERVIEWRow interrow = (EFFMANGDS.EFFS_MANGINTERVIEWRow)interdt[0];
                        if (!interrow.IsnoteNull())
                        {
                            mtb.Text = interrow.note;
                        }
                    }
                    else
                    {
                        mtb.Text = "";
                    }

                }
                else {
                  //  mtb.Text = "";
                }
                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFINTERVIEWRow selfrow = (EFFDS.EFFS_SELFINTERVIEWRow)selfdt.Rows[0];
                        if (!selfrow.IsnoteNull())
                        {
                            tb.Text = selfrow.note.ToString();
                            
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
    protected void Wizard1_SideBarButtonClick(object sender, WizardNavigationEventArgs e)
    {
        saveValue(e.CurrentStepIndex);
        if (e.NextStepIndex == 7)
        {
           
        }
    }
    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        saveValue(e.CurrentStepIndex);
        if (e.NextStepIndex == 7) {
            ArrayList al_nobr = new ArrayList();
            Hashtable ht_name = new Hashtable();

            if (bool.Parse(_Appoint.Text))
            {
                if (Session["empInfo"] != null)
                {
                    EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                    al_nobr.Add(row.NOBR.Trim());
                    ht_name.Add(row.NOBR.Trim(), row.NAME_C);
                }

            }
            else
            {
                int mangorder = int.Parse(_deptorder.Text);
                EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
                for (int i = 0; i < arrpmang.Rows.Count; i++)
                {
                    EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];


                    //    if (!row.mangnobr.Trim().Equals(_mangnobr.Text.Trim()))
                    //   {
                    EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                    if (emprow != null)
                    {
                        if (emprow.cate_order <= mangorder)
                        {
                            al_nobr.Add(row.mangnobr.Trim());
                            ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                        }
                    }
                    //  }

                }
            }
            DataList1.DataSource = DataClass.getEFFMANGSHOWNUM(int.Parse(_yy.Text), int.Parse(_seq.Text), true, _nobr.Text, _temp.Text, "A001", "B001", "A001", al_nobr);
            DataList1.DataBind();
        }
    }
    protected void GridView1_DataBound(object sender, EventArgs e)
    {
        ArrayList al_nobr = new ArrayList();
        Hashtable ht_name = new Hashtable();

        int mangorder = int.Parse(_deptorder.Text);
        EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
        for (int i = 0; i < arrpmang.Rows.Count; i++)
        {
            EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];


            if (!row.mangnobr.Trim().Equals(_mangnobr.Text.Trim()))
            {
                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                if (emprow != null)
                {
                    if (emprow.cate_order <= mangorder)
                    {
                        al_nobr.Add(row.mangnobr.Trim());
                        ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                    }
                }
            }
        }
        if (!bool.Parse(_Appoint.Text) && bool.Parse(_mange.Text))
        {
            setCheckEffMang(sender, al_nobr, ht_name);
        }
    }
    protected void GridView3_DataBound(object sender, EventArgs e)
    {

    }
    protected void GridView3_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {

            EFFDSTableAdapters.EFFS_SELFWORKTableAdapter selfad = new EFFDSTableAdapters.EFFS_SELFWORKTableAdapter();
            EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter workad = new EFFMANGDSTableAdapters.EFFS_MANGAPPRWORKTableAdapter();

            try
            {
                int apprID = 0;
                Label lb = (Label)e.Row.FindControl("LB_Apprid");
                Label tb = (Label)e.Row.FindControl("num");
                Label mtb = (Label)e.Row.FindControl("mangnum");

                if (lb != null)
                    apprID = int.Parse(lb.Text);

                EFFDS.EFFS_SELFWORKDataTable selfdt = selfad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text),
                    _nobr.Text, apprID);
                EFFMANGDS.EFFS_MANGAPPRWORKDataTable workdt = workad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,_mangnobrother.Text, apprID);
                if (workdt.Rows.Count > 0)
                {
                    if (mtb != null)
                    {
                        EFFMANGDS.EFFS_MANGAPPRWORKRow workrow = (EFFMANGDS.EFFS_MANGAPPRWORKRow)workdt.Rows[0];
                        if (!workrow.IsnumNull())
                        {
                            mtb.Text = workrow.num.ToString();
                        }
                        else
                        {

                            mtb.Text = "0";
                        }
                    }


                }
                else
                {
                    mtb.Text = "0";
                }
                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFWORKRow selfrow = (EFFDS.EFFS_SELFWORKRow)selfdt.Rows[0];
                        if (!selfrow.IsnumNull())
                        {
                            tb.Text = selfrow.num.ToString();
                            //  e.Row.Cells[GridView1.Columns.Count - 1].Text = selfrow.num.ToString("0");
                            //  e.Row.Cells[GridView1.Columns.Count - 1].HorizontalAlign = HorizontalAlign.Center;

                        }
                        else
                        {
                            tb.Text = "0";
                        }
                    }
                }
                else
                {
                    tb.Text = "0";
                }
            }
            catch
            {

            }
        }
    }


    protected void GridView5_DataBound(object sender, EventArgs e)
    {
        ArrayList al_nobr = new ArrayList();
        Hashtable ht_name = new Hashtable();

        int mangorder = int.Parse(_deptorder.Text);
        EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
        for (int i = 0; i < arrpmang.Rows.Count; i++)
        {
            EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];


            if (!row.mangnobr.Trim().Equals(_mangnobr.Text.Trim()))
            {
                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                if (emprow != null)
                {
                    if (emprow.cate_order <= mangorder)
                    {
                        al_nobr.Add(row.mangnobr.Trim());
                        ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                    }
                }
            }

        }
        if (!bool.Parse(_Appoint.Text) && bool.Parse(_mange.Text))
        {
            setCheckEffCateMang(sender, al_nobr, ht_name);
        }
    }
    protected void GridViewInterView_DataBound(object sender, EventArgs e)
    {
        ArrayList al_nobr = new ArrayList();
        Hashtable ht_name = new Hashtable();

        int mangorder = int.Parse(_deptorder.Text);
        EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text);
        for (int i = 0; i < arrpmang.Rows.Count; i++)
        {
            EFFMANGDS.EFFS_APPRENDMANGGROUPRow row = (EFFMANGDS.EFFS_APPRENDMANGGROUPRow)arrpmang.Rows[i];


            if (!row.mangnobr.Trim().Equals(_mangnobr.Text.Trim()))
            {
                EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(row.mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                if (emprow != null)
                {
                    if (emprow.cate_order <= mangorder)
                    {
                        al_nobr.Add(row.mangnobr.Trim());
                        ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                    }
                }
            }

        }
        if (!bool.Parse(_Appoint.Text) && bool.Parse(_mange.Text))
        {
            setCheckEffInterViewMang(sender, al_nobr, ht_name);
        }
    }
    protected void leanplanGridView_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        if (e.Row.RowType == DataControlRowType.DataRow)
        {
            Label lb = (Label)e.Row.FindControl("planID");
           Label ftb = (Label)e.Row.FindControl("PlanText");
            EFFDS.EFFS_SELFLEARNPLANRow row = DataClass.getSELFLEARNPLANRow(_yy.Text, _seq.Text, _nobr.Text, lb.Text);
            if (row != null)
            {
                ftb.Text = row.note;
            }
        }
    }
}
