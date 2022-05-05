using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Transactions;

public partial class Etc_CheckAgentFlowTree : System.Web.UI.Page
{
    private dcFlowDataContext dcFlow = new dcFlowDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
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
                            lblFormCode.Text = dc["FormCode"];
                            lblNobrM.Text = dc["NobrM"];
                            lblNobrS.Text = dc["NobrS"];
                            lblKey1.Text = dc["Key1"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();
                        }
                    }
                }
            }

            txtFlowTree_DataBind();
        }

        lblMsg.Text = "";
    }

    private void txtFlowTree_DataBind()
    {
        var rsForm = (from c in dcFlow.wfForm
                      where c.iSort > 0
                      orderby c.iSort
                      select c).ToList();

        txtFlowTree.DataSource = rsForm;
        txtFlowTree.DataTextField = "sFormName";
        txtFlowTree.DataValueField = "sFlowTree";
        txtFlowTree.DataBind();
    }

    protected void btnAdd_Click(object sender, EventArgs e)
    {
        string Guid = lblKey1.Text;
        string FlowTreeId = txtFlowTree.SelectedItem.Value;

        if (Guid.Length == 0 || FlowTreeId.Length == 0)
        {
            RadWindowManager1.RadAlert("資訊不正確", 300, 100, "警告訊息", "", "");
            return;
        }

        var rCheckAgentFlowTree = (from c in dcFlow.CheckAgentFlowTree
                                   where c.CheckAgent_Guid == Guid
                                   && c.FlowTree_id == FlowTreeId
                                   select c).FirstOrDefault();

        if (rCheckAgentFlowTree == null)
        {
            rCheckAgentFlowTree = new CheckAgentFlowTree();
            dcFlow.CheckAgentFlowTree.InsertOnSubmit(rCheckAgentFlowTree);
        }
        else
            lblMsg.Text = "您已經新增過了";

        rCheckAgentFlowTree.CheckAgent_Guid = Guid;
        rCheckAgentFlowTree.FlowTree_id = FlowTreeId;
        rCheckAgentFlowTree.KeyMan = lblNobrM.Text;
        rCheckAgentFlowTree.KeyDate = DateTime.Now;
      
        dcFlow.SubmitChanges();
        gvCheckAgentFlowTree.Rebind();
    }

    protected void gvCheckAgentFlowTree_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "Del")
        {
            var r = (from c in dcFlow.CheckAgentFlowTree
                     where c.auto == Convert.ToInt32(ca)
                     select c).FirstOrDefault();

            if (r != null)
            {
                using (TransactionScope scope = new TransactionScope())
                {
                    try
                    {
                        dcFlow.CheckAgentFlowTree.DeleteOnSubmit(r);
                        dcFlow.SubmitChanges();

                        scope.Complete();
                    }
                    catch (Exception ex)
                    {
                        RadWindowManager1.RadAlert("刪除失敗", 300, 100, "警告訊息", "", ""); //刪除失敗 警告訊息
                        scope.Dispose();
                    }
                }

                gvCheckAgentFlowTree.Rebind();
            }
        }
    }
}