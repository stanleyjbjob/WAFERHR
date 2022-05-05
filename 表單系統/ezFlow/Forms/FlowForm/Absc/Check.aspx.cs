using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Transactions;
using Telerik.Web.UI;
using System.IO;

public partial class Absc_Check : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "Absc";

    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.Url.Query.Length == 0)
        {
            RadWindowManager1.RadAlert("表單參數不正確", 300, 100, "警告訊息", "", "");
            Response.Redirect(System.Web.Configuration.WebConfigurationManager.AppSettings["localhost"]);
            return;
        }

        if (!IsPostBack)
        {
            btnSubmit.Visible = false;

            lblDeptTree.Text = "00";

            if (Request.Cookies["ezFlow"] != null && Request.Cookies["ezFlow"]["Emp_id"] != null)
            {
                lblNobrSign.Text = Request.Cookies["ezFlow"]["Emp_id"];
                lblUserInfo.Text += "@Cookies:" + Request.Cookies["ezFlow"]["Emp_id"];
            }

            if (User.Identity.IsAuthenticated && User.Identity.Name.Trim().Length > 0)
            {
                lblNobrSign.Text = User.Identity.Name;
                lblUserInfo.Text += "@Identity:" + User.Identity.Name;
            }

            string RequestName = Request.QueryString.AllKeys[0];
            string RequestValue = Request[RequestName];

            int ApKey = 0;
            int pid = 0;
            if (int.TryParse(RequestValue, out pid))
            {
                ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

                lblApKey.Text = pid.ToString();

                if (RequestName == "ApParm")
                {
                    ApKey = pid;
                    var rGetAp = oService.GetApParm(pid);
                    if (rGetAp.ProcessFlow_id != 0)
                    {
                        pid = rGetAp.ProcessFlow_id;

                        //反推是否已經簽核結束
                        var rProcessNode = (from c in dcFlow.ProcessNode
                                            where c.auto == rGetAp.ProcessNode_auto
                                            select c).FirstOrDefault();

                        if (rProcessNode != null && !rProcessNode.isFinish.GetValueOrDefault(true))
                        {
                            btnSubmit.Visible = true;
                            lblManage.Text = "1";
                        }
                    }
                }
                else if (RequestName == "ApView")
                {
                    var rGetAp = oService.GetApView(pid);
                    if (rGetAp.ProcessFlow_id != 0)
                        pid = rGetAp.ProcessFlow_id;
                }
            }

            lblProcessID.Text = pid.ToString();

            SetDefault();

            //用ProcessID找出應該要簽核的人 並比對是否與登入的人一致
            var rProcessCheck = (from pn in dcFlow.ProcessNode
                                 join pc in dcFlow.ProcessCheck on pn.auto equals pc.ProcessNode_auto
                                 where pn.ProcessFlow_id == pid
                                 && !pn.isFinish.GetValueOrDefault(true)
                                 orderby pn.adate descending
                                 select pc).FirstOrDefault();

            if (rProcessCheck != null)
            {
                //如果需要判斷是否為真正的主管簽核 此行要拿掉
                lblNobrSign.Text = lblNobrSign.Text.Trim().Length > 0 ? lblNobrSign.Text : rProcessCheck.Emp_idDefault;
                lblUserInfo.Text += "@Sign:" + lblNobrSign.Text;

                if (lblNobrSign.Text == rProcessCheck.Emp_idDefault || lblNobrSign.Text == rProcessCheck.Emp_idAgent)
                {
                    var rRole = (from r in dcFlow.Role
                                 join d in dcFlow.Dept on r.Dept_id equals d.id
                                 where r.id == rProcessCheck.Role_idDefault
                                 && r.Emp_id == rProcessCheck.Emp_idDefault
                                 select new
                                 {
                                     RoleId = r.id,
                                     EmpNobr = r.Emp_id,
                                     DeptTree = d.DeptLevel_id,
                                 }).FirstOrDefault();

                    if (rRole != null)
                    {
                        if (ApKey != 0)
                        {
                            //寫回ApParm
                            var rProcessApParm = (from c in dcFlow.ProcessApParm
                                                  where c.auto == ApKey
                                                  && c.ProcessFlow_id == pid
                                                  && c.ProcessCheck_auto == rProcessCheck.auto
                                                  && c.ProcessNode_auto == rProcessCheck.ProcessNode_auto
                                                  select c).FirstOrDefault();

                            if (rProcessApParm != null)
                            {
                                rProcessApParm.Role_id = rProcessCheck.Role_idDefault;
                                rProcessApParm.Emp_id = rProcessCheck.Emp_idDefault;

                                dcFlow.SubmitChanges();
                            }
                        }

                        lblDeptTree.Text = Convert.ToInt32(rRole.DeptTree).ToString();
                    }
                }
            }
        }
    }

    private void SetDefault()
    {
        (Page.Master as mpCheck20140115).sFormCode = _FormCode;
        (Page.Master as mpCheck20140115).sAppNobr = lblNobrAppM.Text;

        var rForm = (from c in dcFlow.wfForm
                     where c.sFormCode == _FormCode
                     select c).FirstOrDefault();

        if (rForm != null)
            lblNote.Text = rForm.sCheckNote;

        var rFormApp = (from c in dcFlow.wfFormApp
                        where c.sProcessID == lblProcessID.Text
                        select c).FirstOrDefault();

        if (rFormApp != null)
        {
            lblNameAppM.Text = rFormApp.sName;
            lblNobrAppM.Text = rFormApp.sNobr;
            lblRoleAppM.Text = rFormApp.sRole;
            lblDeptCodeAppM.Text = rFormApp.sDept;
            lblDeptNameAppM.Text = rFormApp.sDeptName;
            lblJobNameAppM.Text = rFormApp.sJobName;
        }
    }

    protected void gvAppS_NeedDataSource(object sender, GridNeedDataSourceEventArgs e)
    {
        var rs = (from c in dcForm.wfAppAbsc
                  where c.sProcessID == lblProcessID.Text
                  select c).ToList();

        gvAppS.DataSource = rs;
    }

    protected void gvAppS_ItemDataBound(object sender, GridItemEventArgs e)
    {
        RadButton btnDelete = e.Item.FindControl("btnDelete") as RadButton;
        if (btnDelete != null)
        {
            e.Item.ForeColor = btnDelete.ToolTip == "1" || btnDelete.ToolTip == "3" ? e.Item.ForeColor : System.Drawing.Color.Red;
            btnDelete.Text = btnDelete.ToolTip == "1" ? "駁回" : "核准";
            btnDelete.Visible = lblManage.Text == "1";
        }
    }

    protected void gvAppS_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Del" || cn == "Upload")
        {
            var r = (from c in dcForm.wfAppAbsc
                     where c.iAutoKey == Convert.ToInt32(ca)
                     select c).FirstOrDefault();

            if (r != null)
            {
                if (cn == "Del")
                {
                    var rInfo = (from c in dcFlow.wfFormAppInfo
                                 where c.idProcess == r.idProcess
                                 select c).FirstOrDefault();

                    if (rInfo != null)
                        rInfo.sState = r.sState == "1" ? "2" : "1";

                    r.sState = r.sState == "1" ? "2" : "1";
                    r.bSign = r.sState == "1";

                    dcForm.SubmitChanges();
                    gvAppS.Rebind();
                }
                else if (cn == "Upload")
                {
                    Dialog(cn, lblNobrAppM.Text, "", lblProcessID.Text, r.sGuid);
                }
            }
        }
    }

    private void Dialog(string Case, string NobrM = "", string NobrS = "", string ProcessID = "", string Key1 = "", string Key2 = "")
    {
        string DialogPage = "";

        string ValidateKey = Guid.NewGuid().ToString();

        //string DialogParm = "Nobr=" + Nobr + "&ValidateKey=" + ValidateKey + "&Key=" + Key + "&FormCode=" + _FormCode;
        //string DialogParmDetail = "";

        string DialogParm = "NobrM=" + NobrM + "&NobrS=" + NobrS + "&ValidateKey=" + ValidateKey + "&ProcessID=" + ProcessID + "&Key1=" + Key1 + "&Key2=" + Key2 + "&FormCode=" + _FormCode + "&Std=0";
        string DialogParmDetail = "";

        switch (Case)
        {
            case "Flow":
                DialogPage = "../MT/Flow.aspx";

                break;
            case "Calendar":
                DialogPage = "../MT/Calendar.aspx";

                break;
            case "Upload":
                DialogPage = "../MT/Upload.aspx";

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

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        var rSysVar = (from c in dcFlow.SysVar
                       select c).FirstOrDefault();
        if (rSysVar == null || rSysVar.sysClose == null || rSysVar.sysClose.Value)
        {
            RadWindowManager1.RadAlert("系統維護中，請稍後再送出表單", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
            return;
        }

        var rAppM = (from c in dcFlow.wfFormApp
                     where c.sProcessID == lblProcessID.Text
                     select c).FirstOrDefault();

        var rsAppS = (from c in dcForm.wfAppAbsc
                      where c.sProcessID == lblProcessID.Text
                      select c).ToList();

        rAppM.sNote = txtNote.Text;
        rAppM.bSign = rsAppS.Where(p => p.bSign).Any();
        rAppM.sConditions1 = lblDeptTree.Text;
        rAppM.sState = !rAppM.bSign ? "2" : rAppM.sState;
        rAppM.dDateTimeD = DateTime.Now;

        var rEmpM = (from role in dcFlow.Role
                     join emp in dcFlow.Emp on role.Emp_id equals emp.id
                     join dept in dcFlow.Dept on role.Dept_id equals dept.id
                     join pos in dcFlow.Pos on role.Pos_id equals pos.id
                     where role.Emp_id == lblNobrSign.Text
                     select new
                     {
                         RoleId = role.id,
                         EmpNobr = emp.id,
                         EmpName = emp.name,
                         DeptCode = dept.id,
                         DeptName = dept.name,
                         JobCode = pos.id,
                         JobName = pos.name,
                         Auth = role.deptMg.Value,
                     }).FirstOrDefault();

        if (rEmpM != null)
        {
            var rSignM = (from c in dcFlow.wfFormSignM
                          where c.sProcessID == lblProcessID.Text
                          && c.sKey == lblApKey.Text
                          && c.sNobr == rEmpM.EmpNobr
                          select c).FirstOrDefault();

            if (rSignM == null)
            {
                rSignM = new wfFormSignM();
                dcFlow.wfFormSignM.InsertOnSubmit(rSignM);
            }

            rSignM.sFormCode = _FormCode;
            rSignM.sFormName = "";
            rSignM.sKey = lblApKey.Text;
            rSignM.sProcessID = lblProcessID.Text;
            rSignM.idProcess = Convert.ToInt32(rSignM.sProcessID);
            rSignM.sNobr = rEmpM.EmpNobr;
            rSignM.sName = rEmpM.EmpName;
            rSignM.sRole = rEmpM.RoleId;
            rSignM.sDept = rEmpM.DeptCode;
            rSignM.sDeptName = rEmpM.DeptName;
            rSignM.sJob = rEmpM.JobCode;
            rSignM.sJobName = rEmpM.JobName;
            rSignM.sNote = txtNote.Text;
            rSignM.bSign = rAppM.bSign;
            rSignM.dKeyDate = DateTime.Now;
        }

        if (lblApKey.Text.Trim().Length > 0 && lblApKey.Text != "0")
        {
            dcFlow.SubmitChanges();
            dcForm.SubmitChanges();

            ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);

            try
            {
                if (!oService.WorkFinish(Convert.ToInt32(lblApKey.Text)))
                    RadWindowManager1.RadAlert("流程發生問題，您核准的動作可能無法完成。(1)", 300, 100, "警告訊息", "", "");
                else
                {
                    string Url = FlowFrom.Tools.GetFlowImageUrl("Check", "", "", lblProcessID.Text);
                    Response.Redirect(Url);
                    //RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "self.location='" + Url + "';", true);
                    //RadScriptManager.RegisterStartupScript(this.Page, typeof(UpdatePanel), "key", "self.location='../../FlowImage/Output.aspx?idProcess=" + lblProcessID.Text + "';", true);
                }
            }
            catch (Exception ex)
            {
                RadWindowManager1.RadAlert("流程發生問題，您核准的動作可能無法完成。(2)", 300, 100, "警告訊息", "", "");
            }
        }
    }
}