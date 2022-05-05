using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;

public partial class Ovt_CheckEdit : System.Web.UI.Page
{
    private dcHRDataContext dcHR = new dcHRDataContext();

    private dcFlowDataContext dcFlow = new dcFlowDataContext();
    private dcFormDataContext dcForm = new dcFormDataContext();

    string _FormCode = "";

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
                            lblKey1.Text = dc["Key1"];

                            r.dDateOpen = DateTime.Now;
                            dcFlow.SubmitChanges();


                            SetDefault();
                        }
                    }
                }
            }
        }
    }

    private void SetDefault()
    {
        int AutoKey = Convert.ToInt32(lblKey1.Text);

        var r = (from c in dcForm.wfAppOt
                 where c.iAutoKey == AutoKey
                 select c).FirstOrDefault();

        if (r != null)
        {
            lblNobr.Text = r.sNobr;
            lblName.Text = r.sName;
            lblDate.Text = r.dDateB.ToShortDateString();
            txtTimeB.Text = r.sTimeB;
            txtTimeE.Text = r.sTimeE;

            SetCardTime(lblNobr.Text, r.dDateB);
        }
    }

    private void SetCardTime(string sNobr, DateTime dDate)
    {
        lblCardTime.Text = "";

        string Card = GetCardTime(sNobr, dDate.AddDays(-1));
        if (Card.Length > 0)
            lblCardTime.Text = Card;

        Card = GetCardTime(sNobr, dDate);
        if (Card.Length > 0)
        {
            if (lblCardTime.Text.Length > 0)
                lblCardTime.Text += "<BR>";
            lblCardTime.Text += Card;
        }

        Card = GetCardTime(sNobr, dDate.AddDays(1));
        if (Card.Length > 0)
        {
            if (lblCardTime.Text.Length > 0)
                lblCardTime.Text += "<BR>";
            lblCardTime.Text += Card;
        }
    }

    private string GetCardTime(string sNobr, DateTime dDate)
    {
        string Card = "";

        Dal.Dao.Att.CardDao oCardDao = new Dal.Dao.Att.CardDao(dcHR.Connection);
        var rsCard = oCardDao.GetData(sNobr, dDate.Date);
        if (rsCard.Count > 0)
        {
            Card = dDate.ToShortDateString() + "-";

            foreach (var rCard in rsCard)
                Card += rCard.OnTime + ",";
        }

        return Card;
    }

    protected void btnConfirm_Click(object sender, EventArgs e)
    {
        int AutoKey = Convert.ToInt32(lblKey1.Text);

        var r = (from c in dcForm.wfAppOt
                 where c.iAutoKey == AutoKey
                 select c).FirstOrDefault();

        if (r != null)
        {
            string Nobr = lblNobr.Text;
            string OtCat = r.sOtcatCode;
            string Otrcd = r.sOtrcdCode;
            string Rote = r.sRoteCode;
            DateTime DateB = r.dDateB1.Date;
            string TimeB = txtTimeB.Text;
            string TimeE = txtTimeE.Text;

            if (TimeB.Length != 4 || TimeE.Length != 4)
            {
                RadWindowManager1.RadAlert("此人所輸入的時間不正確", 300, 100, "警告訊息", "", "");
                return;
            }

            Dal.Dao.Att.AttendDao oAttendDao = new Dal.Dao.Att.AttendDao(dcHR.Connection);
            var rAttend = oAttendDao.GetAttend(Nobr, DateB).FirstOrDefault();

            if (rAttend.IsHoliDay)
            {
                int iTimeB = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB);
                int iTimeE = Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE);
                int iTemp;

                iTemp = (30 - (iTimeB % 30));
                iTimeB = iTemp == 30 ? iTimeB : iTimeB + iTemp;
                TimeB = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeB);

                //iTemp = iTimeE % 30;
                //iTimeE -= iTemp;
                //TimeE = Bll.Tools.TimeTrans.ConvertMinutesToHhMm(iTimeE);
            }

            DateTime DateTimeB = DateB.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeB));
            DateTime DateTimeE = DateB.Date.AddMinutes(Bll.Tools.TimeTrans.ConvertHhMmToMinutes(TimeE));
            if (DateTimeB >= DateTimeE)
            {
                RadWindowManager1.RadAlert("此人的開始日期時間不能大於或等於結束日期時間", 300, 100, "警告訊息", "", "");
                return;
            }

            Dal.Dao.Att.OtDao oOtDao = new Dal.Dao.Att.OtDao(dcHR.Connection);
            var Calculate = oOtDao.GetCalculate(Nobr, OtCat, DateB, DateB, TimeB, TimeE, Otrcd, 0, Rote);

            if (Calculate <= 0)
            {
                RadWindowManager1.RadAlert("計算時數不可以為零", 300, 100, "警告訊息", "", "");
                return;
            }

            //Dal.Dao.Att.AttcardDao oAttcardDao = new Dal.Dao.Att.AttcardDao(dcHR.Connection);
            //if (!oAttcardDao.IsCardTime(Nobr, DateB, TimeB, TimeE))
            //{
            //    RadWindowManager1.RadAlert("此人所申請的時間不在刷卡時間裡", 300, 100, "警告訊息", "", "");
            //    return;
            //}

            r.sTimeB = txtTimeB.Text;
            r.sTimeE = txtTimeE.Text;
            r.iTotalHour = Calculate;
            r.sReserve2 = "1";

            dcForm.SubmitChanges();

            RadScriptManager.RegisterClientScriptBlock(this, typeof(Page), this.GetType().ToString(), "GetRadWindow().close();", true);
        }
    }
}