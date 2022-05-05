using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using System.Transactions;

public partial class MT_Flow : System.Web.UI.Page
{
    dcFlowDataContext dcFlow = new dcFlowDataContext();
    dcFormDataContext dcForm = new dcFormDataContext();

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
                            lblNobr.Text = dc["NobrM"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();
                        }
                    }
                }
            }
        }
    }

    protected void gvAppM_ItemCommand(object sender, GridCommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();

        if (cn == "View")
        {
            int id = Convert.ToInt32(ca);

        }
        else if (cn == "Take")
        {
            int id = Convert.ToInt32(ca);

            var rFormApp = (from c in dcFlow.wfFormApp
                            where c.idProcess == id
                            select c).FirstOrDefault();

            if (rFormApp != null)
                rFormApp.sState = "7";

            var rProcessFlow = (from c in dcFlow.ProcessFlow
                                where c.id == id
                                select c).FirstOrDefault();

            var rsProcessNode = (from c in dcFlow.ProcessNode
                                 where c.ProcessFlow_id == id
                                 select c).ToList();

            if (rsProcessNode.Count > 1)
            {
                RadWindowManager1.RadAlert("第一關主管已經審核 不允許抽單", 300, 100, "警告訊息", "", "");
                return;
            }

            if (rProcessFlow != null)
                rProcessFlow.isCancel = true;

            var rForm = (from c in dcFlow.wfForm
                         where c.sFormCode == lblFormCode.Text
                         select c).FirstOrDefault();

            using (TransactionScope scope = new TransactionScope())
            {
                try
                {
                    if (rForm != null)
                        dcFlow.ExecuteCommand("Update " + rForm.sTableName + " Set sState = '7' Where idProcess = {0}", id);

                    dcFlow.SubmitChanges();

                    scope.Complete();
                }
                catch
                {
                    RadWindowManager1.RadAlert("抽單不成功 請稍後再試", 300, 100, "警告訊息", "", "");
                }
            }


            gvAppM.DataBind();
        }
    }

}