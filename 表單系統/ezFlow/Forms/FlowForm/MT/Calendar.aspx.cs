using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MT_Calendar : System.Web.UI.Page
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
                            lblNobr.Text = dc["Nobr"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();
                        }
                    }
                }
            }
        }
    }
    protected void cldAttend_DayRender(object sender, Telerik.Web.UI.Calendar.DayRenderEventArgs e)
    {


        Label lbl = new Label();
        lbl.Text = e.Day.Date.ToShortDateString() +"<BR>"+e.Day.Date.Day.ToString();
        e.Cell.Controls.Add(lbl);
    }
}