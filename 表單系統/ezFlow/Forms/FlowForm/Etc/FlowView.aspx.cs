using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Transactions;
using ezEngineServices;
using System.Drawing;

public partial class Etc_FlowView : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();

    private string _FormCode = "FlowView";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            DateTime dDate = DateTime.Now.Date;
            DateTime dDateB = dDate.AddMonths(-2).Date;
            DateTime dDateE = DateTime.Now.Date;

            txtDateAppB.SelectedDate = dDateB;
            txtDateAppE.SelectedDate = dDateE.AddDays(5);

            txtDateSignB.SelectedDate = dDateB;
            txtDateSignE.SelectedDate = dDateE.AddDays(5);

            if (Request.QueryString["Parm"] != null)
            {
                string RequestQueryString = Bll.Tools.Decryption.Decrypt(Request.QueryString["Parm"]);
                var dc = Bll.Tools.DataTrans.QueryStringToDictionary(RequestQueryString);

                if (dc.ContainsKey("ValidateKey"))
                {
                    string sValidateKey = dc["ValidateKey"];

                    DateTime Date = DateTime.Now;

                    var r = (from c in dcFlow.wfWebValidate
                             where c.sValidateKey == sValidateKey
                             select c).FirstOrDefault();

                    if (r != null)
                    {
                        if (r.dDateWriter >= DateTime.Now.AddMinutes(-1))
                        {
                            lblFormCode.Text = dc["FormCode"];
                            lblNobr.Text = dc["NobrM"];
                            lblViewUrl.Text = dc["ViewUrl"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();
                        }
                    }
                }
            }

            ckbManage.Visible = false;
            plManage.Visible = false;

            lblNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"].ToUpper() : lblNobr.Text;

            if (Request.Cookies["ezFlow"] != null && Request.Cookies["ezFlow"]["Emp_id"] != null)
                lblNobr.Text = Request.Cookies["ezFlow"]["Emp_id"];

            if (User.Identity.IsAuthenticated && User.Identity.Name.Trim().Length > 0)
                lblNobr.Text = User.Identity.Name;

            lblNobrAppS.Text = lblNobr.Text;

            //lblNobr.Text = "110406";

            //判斷是否為管理者
            var rSysAdmin = (from c in dcFlow.SysAdmin
                             where c.Emp_id == lblNobr.Text
                             select c).FirstOrDefault();

            if (rSysAdmin != null)
            {
                ckbManage.Visible = true;
                plManage.Visible = true;

                if (lblFormCode.Text.Length == 0)
                {
                    ckbManage.Checked = true;
                    lblNobrAppS.Text = "";
                }
            }

            SetFlowFromData();

            var rSysVar = (from c in dcFlow.SysVar
                           select c).FirstOrDefault();

            if (rSysVar != null && lblViewUrl.Text.Length == 0)
                lblViewUrl.Text = rSysVar.urlRoot + "/Forms/";

            if (txtFlowForm.Items.FindItemByValue(lblFormCode.Text) != null)
                txtFlowForm.Items.FindItemByValue(lblFormCode.Text).Selected = true;

            txtSignName.Visible = false;
            txtSignName_DataBind();
            gvAppM.Rebind();
            //BindData();
        }
    }

    //顯示目前現有的流程表單
    private void SetFlowFromData()
    {
        var rsForm = (from c in dcFlow.wfForm
                      where c.s5 != "0"
                      orderby c.s5
                      select new
                      {
                          Code = c.sFormCode,
                          Name = c.sFormName,
                      }).ToList();

        txtFlowForm.DataSource = rsForm;
        txtFlowForm.DataTextField = "Name";
        txtFlowForm.DataValueField = "Code";
        txtFlowForm.DataBind();
    }

    private void txtSignName_DataBind()
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        List<Bll.Bas.Vdb.BaseTable> rsBas = oBasDao.GetBaseByDept();

        txtSignName.DataSource = rsBas;
        txtSignName.DataTextField = "Name";
        txtSignName.DataValueField = "Nobr";
        txtSignName.DataBind();

        txtNameAppS.DataSource = rsBas;
        txtNameAppS.DataTextField = "Name";
        txtNameAppS.DataValueField = "Nobr";
        txtNameAppS.DataBind();
    }

    #region 申請人工號及姓名
    protected void txtNameAppS_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        SetName(e.Text);
    }
    protected void txtNameAppS_DataBound(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //    SetName(lblNobrAppM.Text);
    }
    protected void txtNameAppS_TextChanged(object sender, EventArgs e)
    {
        RadComboBox txt = sender as RadComboBox;
        RadComboBoxItem li = txt.SelectedItem;

        if (li != null)
            SetName(li);
        else if (txtNameAppS.Text.Trim().Length > 0)
            SetName(txtNameAppS.Text);
    }
    private void SetName(RadComboBoxItem li)
    {
        if (li != null)
        {
            txtNameAppS.ClearSelection();
            li.Selected = true;
            SetName(li.Value);
        }
    }
    private void SetName(string sNobr)
    {
        if (sNobr.Length > 0)
        {
            Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
            var rBas = oBasDao.GetBase(sNobr).FirstOrDefault();

            if (rBas != null)
            {
                lblNobrAppS.Text = rBas.Nobr;
                txtNameAppS.Text = rBas.Name;
                txtNameAppS.ToolTip = rBas.Name;
            }
            else
                txtNameAppS.Text = txtNameAppS.ToolTip;
        }
        else
        {
            txtNameAppS.Text = "";
            lblNobrAppS.Text = "";
        }
    }
    #endregion

    #region 指定人
    protected void txtSignName_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        SetName(e.Text);
    }
    protected void txtSignName_DataBound(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //    SetName1(lblNobrAppM.Text);
    }
    protected void txtSignName_TextChanged(object sender, EventArgs e)
    {
        RadComboBox txt = sender as RadComboBox;
        RadComboBoxItem li = txt.SelectedItem;

        if (li != null)
            SetName1(li);
        else if (txtSignName.Text.Trim().Length > 0)
            SetName1(txtSignName.Text);
    }
    private void SetName1(RadComboBoxItem li)
    {
        if (li != null)
        {
            txtSignName.ClearSelection();
            li.Selected = true;
            SetName1(li.Value);
        }
    }
    private void SetName1(string sNobr)
    {
        if (sNobr.Length > 0)
        {
            Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
            var rBas = oBasDao.GetBase(sNobr).FirstOrDefault();

            if (rBas != null)
            {
                lblSignName.Text = rBas.Nobr;
                txtSignName.Text = rBas.Name;
                txtSignName.ToolTip = rBas.Name;
            }
            else
                txtSignName.Text = txtSignName.ToolTip;
        }
        else
        {
            txtSignName.Text = "";
            lblSignName.Text = "";
        }
    }
    #endregion

    public class FlowData
    {
        public int ProcessID { get; set; }
        public string FormName { get; set; }
        public string Info { get; set; }
        public string Nobr { get; set; }
        public string DeptName { get; set; }
        public int PendingDay { get; set; }
        public string ManageName { get; set; }
        public string AgentManageName { get; set; }
    }

    private void BindData()
    {
        DateTime dDate = DateTime.Now.Date;
        DateTime dDateB = dDate.AddMonths(-2).Date;
        DateTime dDateE = DateTime.Now.Date;

        bool bManage = ckbManage.Checked;
        string sFormCode = txtFlowForm.SelectedValue;
        string sLoginNobr = lblNobr.Text;
        string sNobr = lblNobrAppS.Text;
        int iProcessID = Convert.ToInt32(txtProcessID.Value.GetValueOrDefault(0));

        DateTime dDateAppB = txtDateAppB.SelectedDate.GetValueOrDefault(dDateB);
        DateTime dDateAppE = txtDateAppE.SelectedDate.GetValueOrDefault(dDateE);

        DateTime dDateSignB = txtDateSignB.SelectedDate.GetValueOrDefault(dDateB);
        DateTime dDateSignE = txtDateSignE.SelectedDate.GetValueOrDefault(dDateE);

        string sApp = muApp.SelectedItem.Value;
        string sState = muState.SelectedItem.Value;

        List<FlowData> lsFlowData = new List<FlowData>();

        List<string> lsFlowFormAll = new List<string>();
        foreach (RadComboBoxItem li in txtFlowForm.Items)
            lsFlowFormAll.Add(li.Value);

        //管理者可以看全部
        if (bManage)
        {
            //審核者
            var rsFormSignM = from w in dcFlow.wfFormSignM
                              where (sNobr == "" || w.sNobr == sNobr)
                              && dDateSignB <= w.dKeyDate.GetValueOrDefault(dDate)
                              && w.dKeyDate.GetValueOrDefault(dDate) <= dDateSignE
                              select w;

            var rsProcessNode = (from pn in dcFlow.ProcessNode
                                 join pc in dcFlow.ProcessCheck on pn.auto equals pc.ProcessNode_auto
                                 where (sNobr == "" || pc.Emp_idDefault == sNobr || pc.Emp_idAgent == sNobr || pc.Emp_idReal == sNobr)
                                 && dDateSignB <= pc.adate.GetValueOrDefault(dDate)
                                 && pc.adate.GetValueOrDefault(dDate) <= dDateSignE
                                 orderby pc.adate.Value descending
                                 select pn.ProcessFlow_id).Take(200).ToList();

            //被申請人
            var rsFormAppInfo = from s in dcFlow.wfFormAppInfo
                                where (sNobr == "" || s.sNobr == sNobr)
                                && dDateAppB <= s.dKeyDate.GetValueOrDefault(dDate)
                                && s.dKeyDate.GetValueOrDefault(dDate) <= dDateAppE
                                && s.sState == sState
                                select s;

            //申請人
            var rsFlowData = from m in dcFlow.wfFormApp
                             join pf in dcFlow.ProcessFlow on m.idProcess equals pf.id
                             join f in dcFlow.wfForm on pf.FlowTree_id equals f.sFlowTree
                             //let p = (from pn in dcFlow.ProcessNode
                             //         join pc in dcFlow.ProcessCheck on pn.auto equals pc.ProcessNode_auto
                             //         join e1 in dcFlow.Emp on pc.Emp_idDefault equals e1.id
                             //         join e2 in dcFlow.Emp on pc.Emp_idAgent equals e2.id into e2g
                             //         from e2gs in e2g.DefaultIfEmpty()
                             //         where m.idProcess == pn.ProcessFlow_id
                             //         orderby pn.auto descending
                             //         select new
                             //         {
                             //             PendingDay = (DateTime.Now - pn.adate.Value).Days,
                             //             ManageName = e1.name,
                             //             AgentManageName = e2gs.name,
                             //         }).FirstOrDefault()
                             where ((sFormCode == "0" && lsFlowFormAll.Contains(m.sFormCode)) || m.sFormCode == sFormCode)
                             && (iProcessID == 0 || m.idProcess == iProcessID)
                             && (sApp == "1"
                             ? ((sNobr == "" || m.sNobr == sNobr)
                             && dDateAppB <= m.dDateTimeA.GetValueOrDefault(dDate)
                             && m.dDateTimeA.GetValueOrDefault(dDate) <= dDateAppE
                             && m.sState == sState)
                             : (sApp == "2"
                             ? (from s in rsFormAppInfo where m.idProcess == s.idProcess select 1).Any()
                             //: (from w in rsFormSignM where m.idProcess == w.idProcess select 1).Any()))
                             //: (from pn in rsProcessNode where m.idProcess == pn.ProcessFlow_id select 1).Any()))
                             : (rsProcessNode.Contains(m.idProcess))))
                             orderby m.idProcess descending
                             select new FlowData
                             {
                                 ProcessID = m.idProcess,
                                 FormName = f.sFormName,
                                 Info = m.sInfo,
                                 Nobr = m.sNobr,
                                 DeptName = m.sDeptName,
                                 PendingDay = 0,// (p.PendingDay > 0 ? p.PendingDay : 0),
                                 ManageName = "",//p.ManageName,
                                 AgentManageName = "",// p.AgentManageName,
                             };

            lsFlowData = rsFlowData.ToList();
        }
        else
        {
            //審核者
            var rsFormSignM = from w in dcFlow.wfFormSignM
                              where (w.sNobr == sLoginNobr)
                              && dDateSignB <= w.dKeyDate.GetValueOrDefault(dDate)
                              && w.dKeyDate.GetValueOrDefault(dDate) <= dDateSignE
                              select w;

            var rsProcessNode = (from pn in dcFlow.ProcessNode
                                join pc in dcFlow.ProcessCheck on pn.auto equals pc.ProcessNode_auto
                                where (pc.Emp_idDefault == sLoginNobr || pc.Emp_idAgent == sLoginNobr || pc.Emp_idReal == sLoginNobr)
                                && dDateSignB <= pc.adate.GetValueOrDefault(dDate)
                                && pc.adate.GetValueOrDefault(dDate) <= dDateSignE
                                orderby pc.adate.Value descending
                                select pn.ProcessFlow_id).Take(200).ToList();

            //被申請人
            var rsFormAppInfo = from s in dcFlow.wfFormAppInfo
                                where (s.sNobr == sLoginNobr)
                                && dDateAppB <= s.dKeyDate.GetValueOrDefault(dDate)
                                && s.dKeyDate.GetValueOrDefault(dDate) <= dDateAppE
                                && s.sState == sState
                                select s;

            //申請人
            var rsFlowData = from m in dcFlow.wfFormApp
                             join pf in dcFlow.ProcessFlow on m.idProcess equals pf.id
                             join f in dcFlow.wfForm on pf.FlowTree_id equals f.sFlowTree
                             //let p = (from pn in dcFlow.ProcessNode
                             //         join pc in dcFlow.ProcessCheck on pn.auto equals pc.ProcessNode_auto
                             //         join e1 in dcFlow.Emp on pc.Emp_idDefault equals e1.id
                             //         join e2 in dcFlow.Emp on pc.Emp_idAgent equals e2.id into e2g
                             //         from e2gs in e2g.DefaultIfEmpty()
                             //         where m.idProcess == pn.ProcessFlow_id
                             //         orderby pn.auto descending
                             //         select new
                             //         {
                             //             PendingDay = (DateTime.Now - pn.adate.Value).Days,
                             //             ManageName = e1.name,
                             //             AgentManageName = e2gs.name,
                             //         }).FirstOrDefault()
                             where ((sFormCode == "0" && lsFlowFormAll.Contains(m.sFormCode)) || m.sFormCode == sFormCode)
                             && (iProcessID == 0 || m.idProcess == iProcessID)
                             && (sApp == "1"
                             ? ((m.sNobr == sLoginNobr)
                             && dDateAppB <= m.dDateTimeA.GetValueOrDefault(dDate)
                             && m.dDateTimeA.GetValueOrDefault(dDate) <= dDateAppE
                             && m.sState == sState)
                             : (sApp == "2"
                             ? (from s in rsFormAppInfo where m.idProcess == s.idProcess select 1).Any()
                             //: (from w in rsFormSignM where m.idProcess == w.idProcess select 1).Any()))
                             //: (from pn in rsProcessNode where m.idProcess == pn.ProcessFlow_id select 1).Any()))
                             : (rsProcessNode.Contains(m.idProcess))))
                             orderby m.idProcess descending
                             select new FlowData
                             {
                                 ProcessID = m.idProcess,
                                 FormName = f.sFormName,
                                 Info = m.sInfo,
                                 Nobr = m.sNobr,
                                 DeptName = m.sDeptName,
                                 PendingDay = 0,// (p.PendingDay > 0 ? p.PendingDay : 0),
                                 ManageName = "",//p.ManageName,
                                 AgentManageName ="",// p.AgentManageName,
                             };

            lsFlowData = rsFlowData.ToList();
        }

        gvAppM.DataSource = lsFlowData;
        //gvAppM.DataBind();
    }

    protected void gvAppM_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "View")
        {
            int id = Convert.ToInt32(ca);

            var rNodeStart = (from pf in dcFlow.ProcessFlow
                              join fn in dcFlow.FlowNode on pf.FlowTree_id equals fn.FlowTree_id
                              join ns in dcFlow.NodeStart on fn.id equals ns.FlowNode_id
                              where pf.id == id
                              && fn.nodeType == "1"
                              select new
                              {
                                  ViewUrl = ns.virtualPath + "/" + ns.viewAp,
                              }).FirstOrDefault();

            if (rNodeStart != null)
            {
                var rProcessApView = (from c in dcFlow.ProcessApView
                                      where c.ProcessFlow_id == id
                                      select c).FirstOrDefault();

                if (rProcessApView != null)
                {
                    string sViewUrl = lblViewUrl.Text + rNodeStart.ViewUrl + "?ApView=" + rProcessApView.auto;
                    //this.Page.Controls.Add(new LiteralControl("<script>var w = window.open('" + sViewUrl + "','_blank','menubar=no,status=no,scrollbars=no,top=0,left=0,toolbar=no,width=800,height=600'); w.focus();</script>"));  
                    RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "window.radopen('" + sViewUrl + "', 'rwMT');", true);
                }
            }
        }
        else if (cn == "Take")
        {
            int id = Convert.ToInt32(ca);

            var rsProcessNode = (from c in dcFlow.ProcessNode
                                 where c.ProcessFlow_id == id
                                 select c).ToList();

            if (rsProcessNode.Count > 1)
            {
                RadWindowManager1.RadAlert("第一關主管已經審核 不允許抽單", 300, 100, "警告訊息", "", "");
                return;
            }

            ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);
            List<int> lsProcessID = new List<int>();
            lsProcessID.Add(id);

            try
            {
                var rsProcessID = oService.FlowStateSet(lsProcessID, FlowState.Take, lblNobr.Text);
                if (rsProcessID.Count > 0)
                {
                    RadWindowManager1.RadAlert("抽單成功", 300, 100, "警告訊息", "", "");
                }
            }
            catch
            {
                RadWindowManager1.RadAlert("抽單不成功 請稍後再試", 300, 100, "警告訊息", "", "");
            }
        }
        else if (cn == "ProcessFlow")
        {
            Dialog(cn, lblNobr.Text, lblNobrAppS.Text, ca);
        }

        gvAppM.Rebind();
    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        gvAppM.Rebind();
    }
    protected void gvAppM_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadButton btnTake = e.Item.FindControl("btnTake") as RadButton;
        if (btnTake != null)
            btnTake.Visible = false;

        HyperLink hlView = e.Item.FindControl("hlView") as HyperLink;
        if (hlView != null)
        {
            int id = Convert.ToInt32(hlView.ToolTip);

            var rNodeStart = (from pf in dcFlow.ProcessFlow
                              join fn in dcFlow.FlowNode on pf.FlowTree_id equals fn.FlowTree_id
                              join ns in dcFlow.NodeStart on fn.id equals ns.FlowNode_id
                              where pf.id == id
                              && fn.nodeType == "1"
                              select new
                              {
                                  ViewUrl = ns.virtualPath + "/" + ns.viewAp,
                                  FlowTreeId = pf.FlowTree_id,
                              }).FirstOrDefault();

            if (rNodeStart != null)
            {
                if (rNodeStart.FlowTreeId == "83" &&( lblNobr.Text == "120802" || lblNobr.Text == "150301" || lblNobr.Text == "151207"))
                   hlView.Visible = false;

                var rProcessApView = (from c in dcFlow.ProcessApView
                                      where c.ProcessFlow_id == id
                                      select c).FirstOrDefault();

                if (rProcessApView != null)
                {
                    string sViewUrl = lblViewUrl.Text + rNodeStart.ViewUrl + "?ApView=" + rProcessApView.auto + "&idEmp_Start=" + lblNobr.Text;
                    hlView.NavigateUrl = sViewUrl;
                }
            }
        }

        if (e.Item is GridDataItem)
        {
            GridDataItem item = (GridDataItem)e.Item;
            int ProcessID = Convert.ToInt32(item["ProcessID"].Text);

            var r = (from pn in dcFlow.ProcessNode
                     join pc in dcFlow.ProcessCheck on pn.auto equals pc.ProcessNode_auto
                     join e1 in dcFlow.Emp on pc.Emp_idDefault equals e1.id
                     join e2 in dcFlow.Emp on pc.Emp_idAgent equals e2.id into e2g
                     from e2gs in e2g.DefaultIfEmpty()
                     where pn.ProcessFlow_id == ProcessID
                     orderby pn.auto descending
                     select new
                     {
                         PendingDay = (DateTime.Now - pn.adate.Value).Days,
                         ManageName = e1.name,
                         AgentManageName = e2gs.name,
                     }).FirstOrDefault();

            if (r != null)
            {
                item["PendingDay"].Text = r.PendingDay.ToString();
                item["ManageName"].Text = r.ManageName.ToString();
                item["AgentManageName"].Text = r.AgentManageName != null ? r.AgentManageName.ToString() : "";
            }
        }

        //btnTake.Visible = muState.SelectedItem.Value == "1" && (ckbManage.Visible || lblNobr.Text == btnTake.ToolTip);
    }
    protected void btnActive_Click(object sender, EventArgs e)
    {
        Session["lsProcessID_Error"] = null;

        int SelectValue = Convert.ToInt32(txtActive.SelectedItem.Value);

        List<int> lsProcessID = new List<int>();
        foreach (GridDataItem row in gvAppM.SelectedItems)
            lsProcessID.Add(Convert.ToInt32(row["ProcessID"].Text));

        ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

        List<int> rsProcessID = new List<int>();
        switch (SelectValue)
        {
            case 1: //重送流程
                rsProcessID = oService.FlowResubmit(lsProcessID, false, lblNobr.Text);
                break;
            case 2: //上點重送
                rsProcessID = oService.FlowResubmit(lsProcessID, true, lblNobr.Text);
                break;
            case 3: //核准
                rsProcessID = oService.FlowStateSet(lsProcessID, FlowState.Approve, lblNobr.Text);
                break;
            case 4: //駁回
                rsProcessID = oService.FlowStateSet(lsProcessID, FlowState.Reject, lblNobr.Text);
                break;
            case 5: //作廢
                rsProcessID = oService.FlowStateSet(lsProcessID,FlowState.Cancel, lblNobr.Text);
                break;
            case 6: //刪除實體資料
                rsProcessID = oService.FlowStateSet(lsProcessID,FlowState.Delete, lblNobr.Text);
                break;
            case 7: //指向正職簽核
                if (lblSignName.Text.Length > 0)
                {
                    CMan oCMan = new CMan();
                    oCMan.idEmp = lblSignName.Text;
                    rsProcessID = oService.FlowSignSet(lsProcessID, oCMan);
                }
                break;
            case 8: //指向代理簽核
                if (lblSignName.Text.Length > 0)
                {
                    CMan oCMan = new CMan();
                    oCMan.idEmp = lblSignName.Text;
                    rsProcessID = oService.FlowSignSet(lsProcessID, null, oCMan);
                }
                break;
            case 9: //下點傳送
                rsProcessID = oService.FlowSignWorkFinish(lsProcessID, lblNobr.Text);
                break;
            case 10: //通知
                break;
            default:
                break;
        }

        gvAppM.Rebind();
        //BindData();

        RadWindowManager1.RadAlert("已完成：" + rsProcessID.Count.ToString() + "表單" + txtActive.SelectedItem.Text, 300, 100, "警告訊息", "", "");
    }

    protected void btnExportExcel_Click(object sender, EventArgs e)
    {
        // "Html" ,"ExcelML","Biff"
        gvAppM.ExportSettings.Excel.Format = (GridExcelExportFormat)Enum.Parse(typeof(GridExcelExportFormat), "Biff");
        gvAppM.ExportSettings.ExportOnlyData = true;
        //gvAppM.ExportSettings.HideStructureColumns = true;
        //gvAppM.ExportSettings.IgnorePaging = true;    //分頁
        gvAppM.ExportSettings.OpenInNewWindow = true;
        gvAppM.ExportSettings.FileName = Guid.NewGuid().ToString();
        gvAppM.MasterTableView.ExportToExcel();
    }
    protected void gvAppM_ExportCellFormatting(object sender, ExportCellFormattingEventArgs e)
    {
        e.Cell.Style["mso-number-format"] = @"\@";
    }
    protected void gvAppM_BiffExporting(object sender, GridBiffExportingEventArgs e)
    {
        //e.ExportStructure.Tables[0].Columns[1].Style.BackColor = System.Drawing.Color.LightGray;
    }

    protected void txtActive_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        txtSignName.Visible = false;
        if (e.Value == "7" || e.Value == "8")
            txtSignName.Visible = true;
    }
    protected void gvAppM_DataBound(object sender, EventArgs e)
    {
        //ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

        //List<int> lsProcessID_Error = new List<int>();
        //if (Session["lsProcessID_Error"] == null)
        //{
        //    lsProcessID_Error = oService.FlowError();

        //    Session["lsProcessID_Error"] = lsProcessID_Error;
        //}
        //else
        //    lsProcessID_Error = Session["lsProcessID_Error"] as List<int>;

        //List<int> lsProcessID = new List<int>();
        //foreach (GridDataItem row in gvAppM.Items)
        //    lsProcessID.Add(Convert.ToInt32(row["ProcessID"].Text));

        //var rsProcessData = oService.GetProcessData(lsProcessID);

        //foreach (GridDataItem row in gvAppM.Items)
        //{
        //    int idProcess = Convert.ToInt32(row["ProcessID"].Text);

        //    var rProcessData = rsProcessData.Where(p => p.idProcess == idProcess).FirstOrDefault();
        //    if (rProcessData != null)
        //    {
        //        row["ManageName"].Text = rProcessData.Emp_NameDefault;
        //        row["AgentManageName"].Text = rProcessData.Emp_NameAgent;
        //        row["FormName"].Text = rProcessData.FlowTreeName;
        //        row["PendingDay"].Text = rProcessData.PendingDay.ToString();
        //        //row["DateTimeA"].Text = rProcessData.DateTimeA.ToString();
        //        //row["DateTimeD"].Text = rProcessData.DateTimeD.ToString();
        //        row.ToolTip = "申請到審核結束時間：" + rProcessData.DateTimeA.ToString() + "-" + rProcessData.DateTimeD.ToString();
        //    }

        //    if (lsProcessID_Error.Contains(idProcess))
        //        row.ForeColor = Color.Red;
        //}
    }

    protected void gvAppM_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        BindData();
    }

    private void Dialog(string Case, string NobrM = "", string NobrS = "", string ProcessID = "", string Key1 = "", string Key2 = "")
    {
        string DialogPage = "";

        string ValidateKey = Guid.NewGuid().ToString();

        //string DialogParm = "Nobr=" + Nobr + "&ValidateKey=" + ValidateKey + "&Key=" + Key + "&FormCode=" + _FormCode;
        //string DialogParmDetail = "";

        string DialogParm = "NobrM=" + NobrM + "&NobrS=" + NobrS + "&ValidateKey=" + ValidateKey + "&ProcessID=" + ProcessID + "&Key1=" + Key1 + "&Key2=" + Key2 + "&FormCode=" + _FormCode + "&Std=1";
        string DialogParmDetail = "";

        switch (Case)
        {
            case "ProcessFlow":
                DialogPage = "ProcessFlow.aspx";

                break;
            default:
                break;
        }

        DialogParm = Bll.Tools.Decryption.Encrypt(DialogParm + DialogParmDetail);

        var r = new wfWebValidate();
        r.sValidateKey = ValidateKey;
        r.dDateWriter = DateTime.Now;
        r.sParm = DialogParm;
        dcFlow.wfWebValidate.InsertOnSubmit(r);
        dcFlow.SubmitChanges();

        RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "window.radopen('" + DialogPage + "?Parm=" + DialogParm + "', 'rwMT');", true);
    }
}