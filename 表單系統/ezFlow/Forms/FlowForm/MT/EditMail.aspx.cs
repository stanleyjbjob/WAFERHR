using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class MT_EditMail : System.Web.UI.Page
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
                            lblKey1.Text = dc["Key1"];  //修改主鍵
                            lblKey2.Text = dc["Key2"];  //表單代碼
                            lblProcessID.Text = dc["ProcessID"];
                            lblStd.Text = dc["Std"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();

                            plEditMail.Visible = lblStd.Text == "1";

                            Bind(Convert.ToInt32(lblKey1.Text));
                            DropdownColumn();
                        }
                    }
                }
            }
        }
    }

    private void DropdownColumn()
    {
        //add a new Toolbar dynamically
        EditorToolGroup dynamicToolbar = new EditorToolGroup();
        txtBody.Tools.Add(dynamicToolbar);
        txtSubject.Tools.Add(dynamicToolbar);
        //add a custom dropdown and set its items and dimension attributes
        EditorDropDown ddn = new EditorDropDown("Columns");
        ddn.Text = "插入欄位...";

        //Set the popup width and height
        //ddn.Attributes["width"] = "110px";
        //ddn.Attributes["popupwidth"] = "240px";
        //ddn.Attributes["popupheight"] = "100px";
        //Add items
        var rsFormColumns = (from c in dcFlow.wfFormColumns
                             where c.sFormCode == lblKey2.Text
                             && c.iOrder > 0
                             orderby c.iOrder
                             select c).ToList();

        foreach (var rFormColumns in rsFormColumns)
            ddn.Items.Add(rFormColumns.sName + "{" + rFormColumns.sCode + "}", rFormColumns.sCode);

        ddn.Items.Add("當下日期{GetDate()}", "GetDate()");
        ddn.Items.Add("當下日期時間{GetDateTime()}", "GetDateTime()");
        //Add tool to toolbar
        dynamicToolbar.Tools.Add(ddn);
    }

    public void Bind(int id)
    {
        var rFormMail = (from c in dcFlow.wfFormMail
                         where c.iAutoKey == id
                         select c).FirstOrDefault();

        if (rFormMail != null)
        {
            txtSubject.Content = rFormMail.sSubject;
            txtBody.Content = rFormMail.sBody;
            lblBody.Text = rFormMail.sBody;
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        var rFormMail = (from c in dcFlow.wfFormMail
                         where c.iAutoKey == Convert.ToInt32(lblKey1.Text)
                         select c).FirstOrDefault();

        if (rFormMail != null)
        {
            rFormMail.sSubject = txtSubject.Content;
            rFormMail.sBody = txtBody.Content;
            rFormMail.dKeyDate = DateTime.Now;
            dcFlow.SubmitChanges();

            //Bind(Convert.ToInt32(lblKey1.Text));
        }
    }
}