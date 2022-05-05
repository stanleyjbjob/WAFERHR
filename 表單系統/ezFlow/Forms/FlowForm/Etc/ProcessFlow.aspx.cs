using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing.Drawing2D;
using System.Drawing;

public partial class Etc_ProcessFlow : System.Web.UI.Page
{
    private dcFlowDataContext dcFlow = new dcFlowDataContext();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            img.Visible = false;
            lblProcessID.Visible = false;

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
                            lblProcessID.Text = dc["ProcessID"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();

                            img.Visible = true;
                        }
                    }
                }
            }
        }

        if (lblProcessID.Text.Length > 0 && img.Visible)
        {
            ezEngineServices.Service oService = new ezEngineServices.Service(dcFlow.Connection);
            //oService.FlowImage(Convert.ToInt32(lblProcessID.Text)).Save(Response.OutputStream, System.Drawing.Imaging.ImageFormat.Jpeg);
            byte[] imageBytes = oService.FlowImage(Convert.ToInt32(lblProcessID.Text));
            img.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String(imageBytes);
            img.ToolTip = lblProcessID.Text;
            img.Visible = false;

            int x = 0, y = 0;
            imageBytes = oService.FlowImage(Convert.ToInt32(lblProcessID.Text), 0, 0);
            imgez.ImageUrl = "data:image/jpg;base64," + Convert.ToBase64String(imageBytes);
            imgez.ToolTip = lblProcessID.Text;
        }
    }


}