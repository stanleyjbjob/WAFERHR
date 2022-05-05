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

public partial class Mang_EFF004 : System.Web.UI.Page
    
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

            if (Request.QueryString["nobr"] != null && Request.QueryString["yy"] != null && Request.QueryString["seq"] != null)
            {

                _yy.Text = Request.QueryString["yy"];
                _seq.Text = Request.QueryString["seq"];
                _nobr.Text = Request.QueryString["nobr"];
                _temp.Text = Request.QueryString["tempID"];

            }

            EFFDS.EFFS_ATTENDRow attrow = DataClass.getEffsAttend(int.Parse(_yy.Text), int.Parse(_seq.Text));
            Session["n_yy"] = attrow.n_yy.ToString();
            Session["n_seq"] = attrow.n_seq.ToString();
            Session["n_nobr"] = _nobr.Text;
            

            if (attrow.StdDate <= DateTime.Now && attrow.EndDate >= DateTime.Now)
            {
                ViewState["isOver"] = false;
                Session["isOver"] = false;

            }
            else
            {
                ViewState["isOver"] = true;
                PlanText.ReadOnly = false;
                PlanText1.ReadOnly = false;
                Session["isOver"] = true;
           //     UPFILEDATELIST.Enabled = false;

            }



            if (Session["empInfo"] != null)
            {
                EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];
                _mangnobr.Text = row.NOBR;
                _deptm.Text = row.DEPTM;

                if (row.MANG && row.MANGE) {
                    _mange.Text = "True";
                }
                try
                {
                    _deptorder.Text = row.cate_order.ToString().Length == 0 ? "0" : row.cate_order.ToString();
                }
                catch { _deptorder.Text = "0"; }

                if (DataClass.getIsSendEffs(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,row.NOBR))
                {
                    ViewState["isOver"] = true;
                    Session["isOver"] = true;
                    PlanText.ReadOnly = false;
                    PlanText1.ReadOnly = false;
                }
            
            }



            if (Request.QueryString["Appoint"]!=null)
            {
                _Appoint.Text = "True";

            }

            Iframe2.Attributes.Add("SRC", "EFF002t.aspx?yy=" + _yy.Text + "&seq=" + _seq.Text + "&nobr=" + _nobr.Text + "&mang=" + _mange.Text + "&appoint=" + _Appoint.Text);
            Qryframe.Attributes.Add("SRC", "../empInfo.aspx?yy=" + _yy.Text + "&seq=" + _seq.Text + "&nobr=" + _nobr.Text + "&mang=" + _mange.Text + "&appoint=" + _Appoint.Text);
            
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
                    GridView3.Visible = false;
                    GridView31.Visible = false;
                }
   
            }


            note1.Text = DataClass.getNote("Mang.EFF004.aspx.1");
            note2.Text = DataClass.getNote("Mang.EFF004.aspx.2");
            note3.Text = DataClass.getNote("Mang.EFF004.aspx.3");
            note4.Text = DataClass.getNote("Mang.EFF004.aspx.4");
            note5.Text = DataClass.getNote("Mang.EFF004.aspx.5");
            note6.Text = DataClass.getNote("Mang.EFF004.aspx.6");
            note7.Text = DataClass.getNote("Mang.EFF004.aspx.7");
            setDefault();
        }
    }
    void setDefault()
    {
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
                        DropDownList ddl = GridView1.Rows[i].FindControl("ddl_mangnum") as DropDownList;

                        if (ddl != null)
                        {
                            if (ddl.SelectedIndex == 0)
                                continue;

                            tb.Text = ddl.SelectedValue;
                        }

                        if (lb != null)
                            apprID = int.Parse(lb.Text);

                        if (tb != null && tb.Text.Trim().Length > 0)
                        {
                            workdt = workad.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text, apprID);
                            if (workdt.Rows.Count > 0)
                            {
                                EFFMANGDS.EFFS_MANGAPPRWORKRow workrow = (EFFMANGDS.EFFS_MANGAPPRWORKRow)workdt[0];
                                workrow.num = Math.Round(decimal.Parse(tb.Text), 2);
                                workrow.keydate = DateTime.Now;
                                
                            }
                            else
                            {
                                workdt.AddEFFS_MANGAPPRWORKRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,_mangnobr.Text,mangrow.DEPT,mangrow.JOB,apprID,Math.Round( decimal.Parse(tb.Text)), DateTime.Now);
                            }
                        }
                        workad.Update(workdt);
                    }
                    GridView1.DataBind();
                    break;
                case 2:

                    EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter catead = new EFFMANGDSTableAdapters.EFFS_MANGAPPRCATETableAdapter();
                    EFFMANGDS.EFFS_MANGAPPRCATEDataTable catedt = null;

                    for (int i = 0; i < DataList2.Items.Count; i++)
                    {

                        Label effcateIDLabel = (Label)DataList2.Items[i].FindControl("effcateIDLabel");
                        TextBox o1 = (TextBox)DataList2.Items[i].FindControl("o1");
                        TextBox o2 = (TextBox)DataList2.Items[i].FindControl("o2");
                        TextBox o3 = (TextBox)DataList2.Items[i].FindControl("o3");

                        EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter otad = new EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter();
                        EFF_EXDS.EFFS_SELFCATEOTHERDataTable otdt = otad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, effcateIDLabel.Text,_mangnobr.Text);
                        if (otdt.Rows.Count > 0)
                        {
                            otdt[0].o1 = o1.Text;
                            otdt[0].o2 = o2.Text;
                            otdt[0].o3 = o3.Text;
                            otdt[0].keydate = DateTime.Now.ToShortDateString();
                            otad.Update(otdt);

                        }
                        else
                        {
                            EFF_EXDS.EFFS_SELFCATEOTHERRow row = otdt.NewEFFS_SELFCATEOTHERRow();
                            row.yy = int.Parse(_yy.Text);
                            row.seq = int.Parse(_seq.Text);
                            row.cateID = effcateIDLabel.Text;
                            row.nobr = _nobr.Text;
                            row.o1 = o1.Text;
                            row.o2 = o2.Text;
                            row.o3 = o3.Text;
                            row.mangNobr = _mangnobr.Text;
                            row.keydate = DateTime.Now.ToShortDateString();
                            otdt.AddEFFS_SELFCATEOTHERRow(row);
                            otad.Update(otdt);

                        }


                        GridView gv = DataList2.Items[i].FindControl("GridView5") as GridView;

                        for (int j = 0; j < gv.Rows.Count; j++)
                        {
                            string apprID = "";
                            Label lb = (Label)gv.Rows[j].FindControl("lb_effsID");
                            TextBox tb = (TextBox)gv.Rows[j].FindControl("mangnum");
                            DropDownList ddl = gv.Rows[j].FindControl("ddl_mangnum") as DropDownList;

                            if (ddl != null) {
                                if (ddl.SelectedIndex == 0)
                                    continue;

                                tb.Text = ddl.SelectedValue;
                            }


                            if (lb != null)
                                apprID = lb.Text;



                            if (tb != null && tb.Text.Trim().Length > 0)
                            {
                                catedt = catead.GetDataByApprID(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _mangnobr.Text, apprID);
                                if (catedt.Rows.Count > 0)
                                {
                                    EFFMANGDS.EFFS_MANGAPPRCATERow selfrow = (EFFMANGDS.EFFS_MANGAPPRCATERow)catedt[0];
                                    selfrow.num = Math.Round(decimal.Parse(tb.Text));
                                    selfrow.keydate = DateTime.Now;
                                }
                                else
                                {
                                    catedt.AddEFFS_MANGAPPRCATERow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,
                                       _mangnobr.Text, mangrow.DEPT, mangrow.JOB, apprID, Math.Round(decimal.Parse(tb.Text), 2), DateTime.Now
                                        );
                                }
                            }
                            catead.Update(catedt);
                        }

                        gv.DataBind();
                    }
                        break;
                case 3:
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
                case 4:
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
                    planad.Update(plandt);
                    GridView31.DataBind();
                    break;
                case 5:
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
                case 6:
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
            try
            {
                if (numrow != null)
                    gv.FooterRow.Cells[index + i].Text = numrow.apprnum.ToString("0.00");
            }
            catch { }
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
                            mtb.Text = caterow.num.ToString("0.00");
                            switch (mtb.Text.ToString().Substring(0, 1))
                            {
                                case "4":
                                    mtb.Text = "超過標準";
                                    break;
                                case "3":
                                    mtb.Text = "符合標準";
                                    break;
                                case "2":
                                    mtb.Text = "需改進";
                                    break;
                                case "1":
                                    mtb.Text = "極需改進";
                                    break;
                                case "0":
                                    mtb.Text = "低於標準";
                                    break;
                                default:
                                    mtb.Text = "未評核！";
                                    break;
                            }
                        }
                        else
                        {
                            mtb.Text = "0.00";
                            mtb.Text = "未評核！";
                        }
                    }

                }
                else
                {
                    mtb.Text = "0.00";
                    mtb.Text = "未評核！";
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
                gv.FooterRow.Cells[index + i].Text = numrow.catenum.ToString("0.00") ;

 
            for (int j = 0; j < gv.Rows.Count; j++)
            {
               
                Label mtb = (Label)gv.Rows[j].FindControl("nummang" + Convert.ToString(i + 1));
                mtb.Visible = true;
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
                          mtb.Text = caterow.num.ToString("0.00");
                          switch (mtb.Text.ToString().Substring(0, 1))
                          {
                              case "4":
                                  mtb.Text = "超過標準";
                                  break;
                              case "3":
                                  mtb.Text = "符合標準";
                                  break;
                              case "2":
                                  mtb.Text = "需改進";
                                  break;
                              case "1":
                                  mtb.Text = "極需改進";
                                  break;
                              case "0":
                                  mtb.Text = "低於標準";
                                  break;
                              default:
                                  mtb.Text = "未評核！";
                                  break;
                          }

                        //   gv.Rows[j].Cells[index + i].Text = caterow.num.ToString();
                        }
                        else
                        {
                           mtb.Text = "0.00";
                           mtb.Text = "未評核！";
                           // gv.Rows[j].Cells[index + i].Text = "0";
                        }

                    
                    }

                }
                else
                {
                    mtb.Text = "0.00";
                    mtb.Text = "未評核！";
                  //  gv.Rows[j].Cells[index + i].Text = "0";

                }
                gv.Rows[j].Cells[index + i].Text = mtb.Text;
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
                  DropDownList ddl_num = (DropDownList)e.Row.FindControl("ddl_num");
                  DropDownList ddl_mangnum = (DropDownList)e.Row.FindControl("ddl_mangnum");
                  mtb.Visible = false;

                 
                if (bool.Parse(ViewState["isOver"].ToString()))
                {
                    mtb.ReadOnly = true;
                }

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
                            mtb.Text = workrow.num.ToString("0.00");
                            switch (mtb.Text.ToString().Substring(0, 1))
                            {
                                case "4":
                                    ddl_mangnum.SelectedIndex = 1;
                                    break;
                                case "3":
                                    ddl_mangnum.SelectedIndex = 2;
                                    break;
                                case "2":
                                    ddl_mangnum.SelectedIndex = 3;
                                    break;
                                case "1":
                                    ddl_mangnum.SelectedIndex = 4;
                                    break;
                                case "0":
                                    ddl_mangnum.SelectedIndex = 5;
                                    break;
                            }
                        }
                        else
                        {

                            mtb.Text = "0.00";
                        }
                    }
                    
                
                }
                else
                {
                    mtb.Text = "0.00";
                }
                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFWORKRow selfrow = (EFFDS.EFFS_SELFWORKRow)selfdt.Rows[0];
                        if (!selfrow.IsnumNull())
                        {
                            tb.Text = selfrow.num.ToString("0.00");
                          //  e.Row.Cells[GridView1.Columns.Count - 1].Text = selfrow.num.ToString("0");
                          //  e.Row.Cells[GridView1.Columns.Count - 1].HorizontalAlign = HorizontalAlign.Center;
                            tb.Visible = false;
                            if (!selfrow.IsnumNull())
                            {
                                switch (tb.Text.ToString().Substring(0, 1))
                                {
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
                            
                        }
                        else
                        {
                            tb.Text = "0.00";
                        }
                    }
                }
                else
                {
                    tb.Text = "0.00";
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

                e.Row.Cells[15].Text = numselfrow.apprnum.ToString("0.00") ;
            }
            if (numrow !=null)
            {


              //  e.Row.Cells[4].Text = numrow.apprrate.ToString("0.0") + "%";

                e.Row.Cells[GridView1.Columns.Count - 1].Text = numrow.apprnum.ToString("0.00") ;
            }

        }

    }
    int indexList = 0;
    protected void DataList2_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        GridView gv = (GridView)e.Item.FindControl("GridView5");
        if (gv != null && indexList>0)
        {
 //           gv.ShowHeader = false;
        }

        try
        {
            indexList++;
            Label effcateIDLabel = (Label)e.Item.FindControl("effcateIDLabel");
            TextBox o1 = (TextBox)e.Item.FindControl("o1");
            TextBox o2 = (TextBox)e.Item.FindControl("o2");
            TextBox o3 = (TextBox)e.Item.FindControl("o3");

            EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter otad = new EFF_EXDSTableAdapters.EFFS_SELFCATEOTHERTableAdapter();
            EFF_EXDS.EFFS_SELFCATEOTHERDataTable otdt = otad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, effcateIDLabel.Text, _mangnobr.Text);
            if (otdt.Rows.Count > 0)
            {
                o1.Text = otdt[0].o1;
                o2.Text = otdt[0].o2;
                o3.Text = otdt[0].o3;
            }
            else {
                EFF_EXDS.EFFS_SELFCATEOTHERDataTable otdt1 = otad.GetData(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, effcateIDLabel.Text, _nobr.Text);
                if (otdt1.Rows.Count > 0)
                {
                    o1.Text = otdt1[0].o1;
                    o2.Text = otdt1[0].o2;
                    o3.Text = otdt1[0].o3;
                }
            
            }
        }
        catch { }

        
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
                
                mtb.Visible = false;
                DropDownList ddl_num = (DropDownList)e.Row.FindControl("ddl_num");
                DropDownList ddl_mangnum = (DropDownList)e.Row.FindControl("ddl_mangnum");
                tb.Visible = false;

                if (bool.Parse(ViewState["isOver"].ToString()))
                {
                    mtb.ReadOnly = true;
                }


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
                            mtb.Text = caterow.num.ToString("0.00");

                            switch (mtb.Text.ToString().Substring(0, 1))
                            {
                                case "4":
                                    ddl_mangnum.SelectedIndex = 1;
                                    break;
                                case "3":
                                    ddl_mangnum.SelectedIndex = 2;
                                    break;
                                case "2":
                                    ddl_mangnum.SelectedIndex = 3;
                                    break;
                                case "1":
                                    ddl_mangnum.SelectedIndex = 4;
                                    break;
                                case "0":
                                    ddl_mangnum.SelectedIndex = 5;
                                    break;
                            }
                        }
                        else {
                            mtb.Text = "0.00";
                        }
                    }

                }
                else {
                    mtb.Text = "0.00";
                
                }

                if (selfdt.Rows.Count > 0)
                {


                    if (tb != null)
                    {
                        EFFDS.EFFS_SELFCATERow selfrow = (EFFDS.EFFS_SELFCATERow)selfdt.Rows[0];
                        if (!selfrow.IsnumNull())
                        {
                            tb.Text = selfrow.num.ToString("0.00");
                            _rate.Text = selfrow.rate.ToString("0.00");
                            switch (tb.Text.ToString().Substring(0, 1))
                            {
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
                            ddl_num.Enabled = false;
                            tb.Visible = false;
                            

                            tb.Text = selfrow.num.ToString("0.00");
                            _rate.Text = selfrow.rate.ToString("0.00");
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

            try
            {
                if (numselfrow != null)
                {

                    e.Row.Cells[4].Text = numselfrow.catenum.ToString("0.00");
                }
                if (numrow != null)
                {

                    e.Row.Cells[GridView5.Columns.Count - 1].Text = numrow.catenum.ToString("0.00");
                }
            }
            catch { }

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
                if (bool.Parse(ViewState["isOver"].ToString()))
                {
                    mtb.ReadOnly = true;
                }


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
                    mtb.Text = "";
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
        if (!bool.Parse(ViewState["isOver"].ToString()))
        {
            saveValue(e.CurrentStepIndex);
        }
        if (e.NextStepIndex == 8)
        {
            ArrayList al_nobr = new ArrayList();
            Hashtable ht_name = new Hashtable();
            DataTable dt = new DataTable();
            dt.Columns.Add("mangnobr");
            dt.Columns.Add("mangname");

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
                EFFMANGDS.EFFS_APPRENDMANGGROUPDataTable arrpmang = DataClass.getAPPRMANGGROUP(int.Parse(_yy.Text), int.Parse(_seq.Text),_nobr.Text);
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
                                DataRow arow =  dt.NewRow();
                                arow[0] = row.mangnobr.Trim();
                                arow[1] = row.NAME_C.Trim();
                                dt.Rows.Add(arow);
                                al_nobr.Add(row.mangnobr.Trim());
                                ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                            }
                            else
                            {
                                if (assing.Select("assignnobr='" + row.mangnobr.Trim() + "'").Length == 0)
                                {
                                    DataRow arow = dt.NewRow();
                                    arow[0] = row.mangnobr.Trim();
                                    arow[1] = row.NAME_C.Trim();

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

            DataRow selfarow = dt.NewRow();
            selfarow[0] = _nobr.Text;
            selfarow[1] = "員工自評";
            dt.Rows.Add(selfarow);
            

            DataList3.DataSource = dt;
            DataList3.DataBind();
        }
    }
    protected void Wizard1_NextButtonClick(object sender, WizardNavigationEventArgs e)
    {
        if (e.NextStepIndex == 1) {
            Wizard1.ActiveStepIndex = 2;
            //  e.Cancel = true;

        }
        DataTable dt = new DataTable();
        dt.Columns.Add("mangnobr");
        dt.Columns.Add("mangname");
        if (!bool.Parse(ViewState["isOver"].ToString()))
        {
            saveValue(e.CurrentStepIndex);
        }
        if (e.NextStepIndex == 8) {
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
                                DataRow arow = dt.NewRow();
                                arow[0] = row.mangnobr.Trim();
                                arow[1] = row.NAME_C.Trim();
                                dt.Rows.Add(arow);
                                al_nobr.Add(row.mangnobr.Trim());
                                ht_name.Add(row.mangnobr.Trim(), row.NAME_C.Trim());
                            }
                            else
                            {
                                if (assing.Select("assignnobr='" + row.mangnobr.Trim() + "'").Length == 0)
                                {
                                    DataRow arow = dt.NewRow();
                                    arow[0] = row.mangnobr.Trim();
                                    arow[1] = row.NAME_C.Trim();
                                    dt.Rows.Add(arow);
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



            DataRow selfarow = dt.NewRow();
            selfarow[0] = _nobr.Text;
            selfarow[1] = "員工自評";
            dt.Rows.Add(selfarow);
            
            
            DataList3.DataSource = dt;
            DataList3.DataBind();
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
    protected void Wizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
         if (Session["empInfo"] != null)
        {
            EFFDS.EMPINFODataTableRow row = (EFFDS.EMPINFODataTableRow)Session["empInfo"];

            EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter appad = new EFFMANGDSTableAdapters.EFFS_MANGAPPENDTableAdapter();
            EFFMANGDS.EFFS_MANGAPPENDDataTable appdt = appad.GetDataByMangNobr(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text,
               row.NOBR);
            if (appdt.Rows.Count > 0)
            {


                CS.showScriptAlert(this, "考核資料已經於" + appdt[0].appstddate.ToString() + ",傳送過！請勿再次傳送資料！！");

            }
            else
            {


                string type = "";
                type = bool.Parse(_Appoint.Text) ? "3" : "2";

                appdt.AddEFFS_MANGAPPENDRow(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, row.NOBR, row.DEPTM,
                    row.JOB, type, DateTime.Now, DateTime.Now, true);
                appad.Update(appdt);
                ViewState["isOver"] = true;

                if (Session["empInfo"] != null)
                {
                    EFFDS.EMPINFODataTableRow defrow = DataClass.getEmpInfo(_nobr.Text, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                     string mangnobr ="";
                    if (bool.Parse(_Appoint.Text))
                    {
                        //bool isok =true;
                        //string __nobr = _nobr.Text;
                        //EFFDS.EMPINFODataTableRow emprow = null;
                        //int index = 0;
                        //do
                        //{
                        //    mangnobr = DataClass.getMangFromNobr(__nobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());

                        //    emprow = DataClass.getEmpInfo(mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());

                        //     if (emprow != null)
                        //     {
                        //         if (emprow.MANGE)
                        //             isok = false;

                        //         index++;
                        //         if (index == 10)
                        //             isok = false;
                        //     }else
                        //         isok = false;

                        //} while (isok);
                        //if (emprow != null)
                        //    sendMail(emprow.EMAIL, defrow.NAME_C, row.NAME_C, emprow.NAME_C);
                    }
                    else
                    {

                        mangnobr = DataClass.getMangFromNobr(row.NOBR, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                        EFFDS.EMPINFODataTableRow emprow = DataClass.getEmpInfo(mangnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());
                        if (defrow.cate_order < 70)
                        {
                            sendMail(emprow.EMAIL, defrow.NAME_C, row.NAME_C, emprow.NAME_C);
                        }
                        else {
                            EFFDS.EMPINFODataTableRow emprow1 = DataClass.getEmpInfo(_nobr.Text, DataClass.getEffsAttendStdDate(int.Parse(_yy.Text), int.Parse(_seq.Text)).ToShortDateString());

                            sendMail1(emprow1.EMAIL, emprow1.NAME_C);
                        }
                    }
                }



                CS.showScriptAlert(this, "傳送完成");
            }
        }

    }

    void sendMail1(string mail, string empname)
    {
        string sub = "";
        string body = "";
        sub = empname + "," + _yy.Text + "年第" + _seq.Text + "績效考核資料,主管己經評核完成！！";



        body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
               "<html xmlns='http://www.w3.org/1999/xhtml'>" +
               "<head>" +
               "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
               "<title></title>" +
               "" +
               "</head>" +
               "" +
               "<body >" +
               empname + " 先生/小姐:<br>" +
               _yy.Text + "年第" + _seq.Text + "績效考核資料,已經評核完成！！請確認本期考核內容<br>" +
               " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\" -----> 自評績效考核------>績效考核員工確認<br>" +
               "<br>" +
               "<br>" +
               "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
               "<br>" +
               "</body>" +
               "</html>";
        CS.SendMail(mail, body, sub);


    }



    void sendMail(string mail, string empname,string mangname1, string mangname2)
    {
        string sub = "";
        string body = "";
        sub = empname + "," + _yy.Text + "年第" + _seq.Text + "績效考核資料,"+mangname1+"己經評核完成,請您開始評核及確認！！";



        body = "<!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN' 'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>" +
               "<html xmlns='http://www.w3.org/1999/xhtml'>" +
               "<head>" +
               "<meta http-equiv='Content-Type' content='text/html; charset=big5' />" +
               "<title></title>" +
               "" +
               "</head>" +
               "" +
               "<body >" +
               mangname2 + " 先生/小姐:<br>" +
                empname + "," + _yy.Text + "年第" + _seq.Text + "績效考核資料," + mangname1 + "已經評核完成,請您開始評核及確認！！<br>" +
               " 在NOTES 工作區頁面下，點選\"台灣合晶企業資訊入口\" ---> \"人資資訊入口\" ---->再點選 \"績效考核系統\" ,請您開始評核" + empname + "的績效考核資料,謝謝！<br>" +
               "<br>" +
               "<br>" +
               "<font color='red'>【如執行績效考核有問題，請連絡人資單位】</font><br>" +
               "<br>" +
               "</body>" +
               "</html>";
        CS.SendMail(mail, body, sub);


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

            tot_num += double.Parse(gv.Rows[i].Cells[2].Text.ToString());

        }
        if (tot_num > 0)
        {
            gv.FooterRow.Cells[1].Text = "總評分：";
            if (gv.Rows.Count == 2)
            {
                gv.FooterRow.Cells[2].Text = Convert.ToString(Math.Round(tot_num / 2, 3, MidpointRounding.AwayFromZero));
            }
            else {
                gv.FooterRow.Cells[2].Text = Convert.ToString(Math.Round(tot_num , 3, MidpointRounding.AwayFromZero));
            
            }
        }

    }
    protected void DataList3_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem) {
            GridView gv = e.Item.FindControl("GridView2") as GridView;
            Label lb_mang_nobr = e.Item.FindControl("lb_nobr") as Label;
            if (lb_mang_nobr.Text.Trim().Equals(_nobr.Text.Trim()))
            {
                gv.DataSource = DataClass.getSelfType(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _temp.Text, true);
                gv.DataBind();

            }
            else
            {


                gv.DataSource = DataClass.getMangType(int.Parse(_yy.Text), int.Parse(_seq.Text), _nobr.Text, _temp.Text, true, lb_mang_nobr.Text);
                gv.DataBind();
            }
        }
    }
    protected void Button3_Click(object sender, EventArgs e)
    {
        Button bu = sender as Button;
        saveValue( int.Parse(bu.CommandArgument));
        CS.showScriptAlert(this, "存檔完成");
    }
    protected void FinishButton_Click(object sender, EventArgs e)
    {

    }
    protected void FinishButton_Click1(object sender, EventArgs e)
    {

    }
}
