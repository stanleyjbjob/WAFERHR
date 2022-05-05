using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using Bll.Tools;

public partial class Ovt_View : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();
    private string _FormCode = "Ovt";

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
            lblDeptTree.Text = "0";

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
        var rs = (from c in dcForm.wfAppOt
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
}