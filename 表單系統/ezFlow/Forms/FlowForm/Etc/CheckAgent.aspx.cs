using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Transactions;

public partial class Etc_CheckAgent : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "CheckAgent";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
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
                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();
                        }
                    }
                }
            }

            txtNobr.Enabled = false;

            lblAppNobr.Text = Request.QueryString["idEmp_Start"] != null ? Request.QueryString["idEmp_Start"].ToUpper() : lblNobr.Text;

            if (Request.Cookies["ezFlow"] != null && Request.Cookies["ezFlow"]["Emp_id"] != null)
                lblAppNobr.Text = Request.Cookies["ezFlow"]["Emp_id"];

            if (User.Identity.IsAuthenticated && User.Identity.Name.Trim().Length > 0)
                lblAppNobr.Text = User.Identity.Name;

            //lblAppNobr.Text = "110406";

            //判斷是否為管理者
            var rSysAdmin = (from c in dcFlow.SysAdmin
                             where c.Emp_id == lblAppNobr.Text
                             select c).FirstOrDefault();

            if (rSysAdmin != null)
                txtNobr.Enabled = true;

            txtNobr_DataBind();
            txtSort_DataBind();
            SetDefault();
        }
    }

    private void txtNobr_DataBind()
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rsBas = oBasDao.GetBaseByDept();

        txtNobr.DataSource = rsBas;
        txtNobr.DataTextField = "Name";
        txtNobr.DataValueField = "Nobr";
        txtNobr.DataBind();

        txtNameAgent.DataSource = rsBas;
        txtNameAgent.DataTextField = "Name";
        txtNameAgent.DataValueField = "Nobr";
        txtNameAgent.DataBind();
    }

    private void txtSort_DataBind()
    {
        RadComboBoxItem item;
        for (int i = 1; i <= 10; i++)
        {
            item = new RadComboBoxItem(i.ToString(), i.ToString());
            txtSort.Items.Add(item);
        }
    }

    private void SetDefault()
    {
        if (txtNobr.Items.FindItemByValue(lblNobr.Text) != null)
            txtNobr.Items.FindItemByValue(lblNobr.Text).Selected = true;
    }

    #region 申請人工號及姓名
    protected void txtName_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        SetName(e.Value);
    }
    protected void txtName_DataBound(object sender, EventArgs e)
    {
        if (!IsPostBack)
            SetName(lblAppNobr.Text);
    }
    protected void txtName_TextChanged(object sender, EventArgs e)
    {
        RadComboBox txt = sender as RadComboBox;
        RadComboBoxItem li = txt.SelectedItem;

        if (li != null)
            SetName(li);
        else if (txtNobr.Text.Trim().Length > 0)
            SetName(txtNobr.Text);
    }
    private void SetName(RadComboBoxItem li)
    {
        if (li != null)
        {
            txtNobr.ClearSelection();
            li.Selected = true;
            SetName(li.Value);
        }
    }
    private void SetName(string sNobr)
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBas = oBasDao.GetBase(sNobr).FirstOrDefault();

        if (rBas != null)
        {
            lblNobr.Text = rBas.Nobr;
            txtNobr.Text = rBas.Name;
            txtNobr.ToolTip = rBas.Name;
        }
        else
            txtNobr.Text = txtNobr.ToolTip;

        SetRole(lblNobr.Text);
    }
    #endregion

    private void SetRole(string sNobr)
    {
        txtRole.ClearSelection();

        if (sNobr.Length > 0)
        {
            ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);
            var rsRoleData = oService.GetRoleData(sNobr);

            txtRole.DataSource = rsRoleData;
            txtRole.DataTextField = "RoleName";
            txtRole.DataValueField = "RoleId";
            txtRole.DataBind();
        }
    }

    #region 代理人工號及姓名
    protected void txtNameAgent_SelectedIndexChanged(object sender, RadComboBoxSelectedIndexChangedEventArgs e)
    {
        SetName1(e.Value);
    }
    protected void txtNameAgent_DataBound(object sender, EventArgs e)
    {
        //if (!IsPostBack)
        //    SetName1(lblNobrAppM.Text);
    }
    protected void txtNameAgent_TextChanged(object sender, EventArgs e)
    {
        RadComboBox txt = sender as RadComboBox;
        RadComboBoxItem li = txt.SelectedItem;

        if (li != null)
            SetName1(li);
        else if (txtNameAgent.Text.Trim().Length > 0)
            SetName1(txtNameAgent.Text);
    }
    private void SetName1(RadComboBoxItem li)
    {
        if (li != null)
        {
            txtNameAgent.ClearSelection();
            li.Selected = true;
            SetName1(li.Value);
        }
    }
    private void SetName1(string sNobr)
    {
        Dal.Dao.Bas.BasDao oBasDao = new Dal.Dao.Bas.BasDao(dcHR.Connection);
        var rBas = oBasDao.GetBase(sNobr).FirstOrDefault();

        if (rBas != null)
        {
            lblNobrAgent.Text = rBas.Nobr;
            txtNameAgent.Text = rBas.Name;
            txtNameAgent.ToolTip = rBas.Name;
        }
        else
            txtNameAgent.Text = txtNameAgent.ToolTip;
    }
    #endregion

    protected void btnAgentAdd_Click(object sender, EventArgs e)
    {
        string Role_idSource = txtRole.SelectedItem.Value;
        string Emp_idSource = lblNobr.Text;
        string Role_idTarget = "";
        string Emp_idTarget = lblNobrAgent.Text;
        int Sort = Convert.ToInt32(txtSort.SelectedItem.Value);

        if (Emp_idTarget.Length == 0)
        {
            RadWindowManager1.RadAlert("您沒有選擇代理人員", 300, 100, "警告訊息", "", "");
            return;
        }

        ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);
        var rRoleData = oService.GetRoleData(Emp_idTarget).FirstOrDefault();
        if (rRoleData == null)
        {
            RadWindowManager1.RadAlert("代理人資訊不正確", 300, 100, "警告訊息", "", "");
            return;
        }

        Role_idTarget = rRoleData.RoleId;

        var rCheckAgent = (from c in dcFlow.CheckAgent
                           where c.Role_idSource == Role_idSource
                           && c.Emp_idSource == Emp_idSource
                           && c.Emp_idTarget == Emp_idTarget
                           select c).FirstOrDefault();

        if (rCheckAgent == null)
        {
            rCheckAgent = new CheckAgent();
            dcFlow.CheckAgent.InsertOnSubmit(rCheckAgent);
        }

        rCheckAgent.Role_idSource = Role_idSource;
        rCheckAgent.Emp_idSource = Emp_idSource;
        rCheckAgent.Role_idTarget = Role_idTarget;
        rCheckAgent.Emp_idTarget = Emp_idTarget;
        rCheckAgent.Sort = Sort;
        rCheckAgent.Guid = Guid.NewGuid().ToString();
        rCheckAgent.KeyMan = lblAppNobr.Text;
        rCheckAgent.KeyDate = DateTime.Now;

        dcFlow.SubmitChanges();
        gvAgent.DataBind();
    }

    protected void gvAgent_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Del" || cn == "Form")
        {
            var r = (from c in dcFlow.CheckAgent
                     where c.Guid == ca
                     select c).FirstOrDefault();

            if (r != null)
            {
                if (cn == "Del")
                {
                    var rs = (from c in dcFlow.CheckAgentFlowTree
                              where c.CheckAgent_Guid == ca
                              select c).ToList();

                    using (TransactionScope scope = new TransactionScope())
                    {
                        try
                        {
                            dcFlow.CheckAgentFlowTree.DeleteAllOnSubmit(rs);
                            dcFlow.CheckAgent.DeleteOnSubmit(r);

                            dcFlow.SubmitChanges();

                            scope.Complete();
                        }
                        catch (Exception ex)
                        {
                            RadWindowManager1.RadAlert("刪除失敗", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
                            scope.Dispose();
                        }
                    }

                    gvAgent.DataBind();
                }
                else if (cn == "Form")
                {
                    Dialog(cn, lblAppNobr.Text, "", "", ca);
                }
            }
        }
    }

    private void Dialog(string Case, string NobrM = "", string NobrS = "", string ProcessID = "", string Key1 = "", string Key2 = "")
    {
        string DialogPage = "";

        string ValidateKey = Guid.NewGuid().ToString();

        string sViewUrl = Request.Url.AbsoluteUri.Substring(0, Request.Url.AbsoluteUri.LastIndexOf("/")) + "/Check.aspx";
        sViewUrl = "";

        string DialogParm = "NobrM=" + NobrM + "&NobrS=" + NobrS + "&ValidateKey=" + ValidateKey + "&ProcessID=" + ProcessID + "&Key1=" + Key1 + "&Key2=" + Key2 + "&FormCode=" + _FormCode + "&ViewUrl=" + sViewUrl + "&Std=1";
        string DialogParmDetail = "";

        switch (Case)
        {
            case "Form":
                DialogPage = "CheckAgentFlowTree.aspx";
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
        gvAgent.DataBind();
    }

    protected void btnDateAdd_Click(object sender, EventArgs e)
    {
        DateTime dDateTimeA = DateTime.Now.Date;
        DateTime dDateTimeD = DateTime.Now.Date;

        if (txtDateA.SelectedDate == null || txtDateD.SelectedDate == null)
        {
            RadWindowManager1.RadAlert("日期不允許空白或格式不正確", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
            return;
        }

        dDateTimeA = txtDateA.SelectedDate.Value;
        dDateTimeD = txtDateD.SelectedDate.Value;

        var rEmpAgentDate = (from c in dcFlow.EmpAgentDate
                             where c.dateB == dDateTimeA
                             && c.dateE == dDateTimeD
                             && c.IsValid
                             select c).FirstOrDefault();

        if (rEmpAgentDate == null)
        {
            rEmpAgentDate = new EmpAgentDate();
            dcFlow.EmpAgentDate.InsertOnSubmit(rEmpAgentDate);
        }

        rEmpAgentDate.Emp_id = lblNobr.Text;
        rEmpAgentDate.dateB = dDateTimeA;
        rEmpAgentDate.dateE = dDateTimeD;
        rEmpAgentDate.KeyMan = lblAppNobr.Text;
        rEmpAgentDate.KeyDate = DateTime.Now;
        rEmpAgentDate.IsValid = true;

        dcFlow.SubmitChanges();
        gvDate.DataBind();
    }

    protected void gvDate_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Del")
        {
            var r = (from c in dcFlow.EmpAgentDate
                     where c.auto == Convert.ToInt32(ca)
                     select c).FirstOrDefault();

            if (r != null)
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    try
                    {
                        r.IsValid = false;
                        dcFlow.SubmitChanges();

                        scope.Complete();
                    }
                    catch (Exception ex)
                    {
                        RadWindowManager1.RadAlert("刪除失敗", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
                        scope.Dispose();
                    }
                }

                gvDate.DataBind();
            }
        }
    }

    protected void gvAgent_DataBound(object sender, EventArgs e)
    {
        foreach (GridDataItem r in gvAgent.Items)
        {
            string Guid = r["Form"].Text;

            var rsCheckAgentFlowTree = (from c in dcFlow.CheckAgentFlowTree
                                        join d in dcFlow.wfForm on c.FlowTree_id equals d.sFlowTree
                                        where c.CheckAgent_Guid == Guid
                                        orderby d.iSort
                                        select d).ToList();

            string Form = "";

            foreach (var rCheckAgentFlowTree in rsCheckAgentFlowTree)
                Form += rCheckAgentFlowTree.sFormName + "<BR>";

            r["Form"].Text = Form.Length == 0 ? "全部" : Form;
        }
    }
}