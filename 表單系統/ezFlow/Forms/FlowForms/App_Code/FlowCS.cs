using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.Text;
using System.IO;
using System.Runtime.InteropServices;

/// <summary>
/// FlowCS 的摘要描述
/// </summary>
public class FlowCS
{
    public FlowCS() { }

    //取得解碼
    public static string GetDecode(string Encode)
    {
        FlowDSTableAdapters.wfEncodeTableAdapter wfEncodeTA = new FlowDSTableAdapters.wfEncodeTableAdapter();
        FlowDS oFlowDS = new FlowDS();
        wfEncodeTA.Fill(oFlowDS.wfEncode);

        string Decode = Encode;

        foreach (FlowDS.wfEncodeRow r in oFlowDS.wfEncode.Rows)
            Encode = Encode.Replace(r.sEncode, r.sDecode);

        return (Encode == Decode) ? "000000" : Encode;
    }

    //取得編碼
    public static string GetEncode(string Decode)
    {
        FlowDSTableAdapters.wfEncodeTableAdapter wfEncodeTA = new FlowDSTableAdapters.wfEncodeTableAdapter();
        FlowDS oFlowDS = new FlowDS();
        wfEncodeTA.Fill(oFlowDS.wfEncode);

        string Encode = "";

        char[] arrDecode = Decode.ToCharArray();

        foreach (char s in arrDecode)
            //懶得寫判斷，直接跑回圈
            foreach (FlowDS.wfEncodeRow r in oFlowDS.wfEncode.Rows)
                if (s.ToString() == r.sDecode)
                    Encode += r.sEncode;

        //foreach (FlowDS.wfEncodeRow r in oFlowDS.wfEncode.Rows)
        //    Decode = Decode.Replace(r.sDecode, r.sEncode);

        //return (Decode == Encode) ? "ZaZaZaZaZaZa" : Decode;
        return Encode;
    }

    //利用ApView及ApParm取得ProcessID
    public static string GetProcessID(string RequestName, int RequestValue)
    {
        FlowDSTableAdapters.ProcessApParmTableAdapter ProcessApParmTA = new FlowDSTableAdapters.ProcessApParmTableAdapter();
        FlowDSTableAdapters.ProcessApViewTableAdapter ProcessApViewTA = new FlowDSTableAdapters.ProcessApViewTableAdapter();

        object ProcessID = (RequestName == "ApParm") ? ProcessApParmTA.QueryKey(RequestValue) : ProcessApViewTA.QueryKey(RequestValue);
        return (ProcessID != null) ? ProcessID.ToString() : "0";
    }

    //利用ProcessID取得ApView或ApParm
    public static int GetViewID(int ProcessID, string cat)
    {
        FlowDSTableAdapters.ProcessApParmTableAdapter ProcessApParmTA = new FlowDSTableAdapters.ProcessApParmTableAdapter();
        FlowDSTableAdapters.ProcessApViewTableAdapter ProcessApViewTA = new FlowDSTableAdapters.ProcessApViewTableAdapter();

        object Auto = (cat == "ApParm") ? ProcessApParmTA.QueryAuto(ProcessID) : ProcessApViewTA.QueryAuto(ProcessID);
        return (Auto != null) ? Convert.ToInt32(Auto) : 0;
    }

    //轉換表單時間為分鐘數
    public static int GetMinutes(string s)
    {
        s = (s.Trim().Length < 4) ? "0000" : s;
        return int.Parse(s.Substring(0, 2)) * 60 + int.Parse(s.Substring(2, 2));
    }

    //轉換表單時間為分鐘數
    public static int GetMinutes(string s, bool cat)
    {
        s = (s.Trim().Length < 4) ? cat ? "0000" : "2400" : s;
        return int.Parse(s.Substring(0, 2)) * 60 + int.Parse(s.Substring(2, 2));
    }

    //分割時間字串為小時或分鐘
    public static string GetTimeSplit(string s, string hm)
    {
        s = (s.Trim().Length < 4) ? s.PadLeft(4, char.Parse("0")) : s;
        return (hm == "h") ? s.Substring(0, 2) : s.Substring(2, 2);
    }

    //分割時間字串為標準時間ex: 12 : 30 : 00
    public static string GetTimeSplit(string s)
    {
        s = (s.Trim().Length < 4) ? s.PadLeft(4, char.Parse("0")) : s;
        return s.Substring(0, 2) + ":" + s.Substring(2, 2) + ":00";
    }

    //將時間轉成MMDD
    public static string GetTimeSplit(DateTime d)
    {
        return d.Hour.ToString().PadLeft(2, char.Parse("0")) + d.Minute.ToString().PadLeft(2, char.Parse("0"));
    }

    public static void SendMail(string to, string subject, string body)
    {
        string mailServerName = "ms.waferworks.com";
        string from = "hrcard@waferworks.com";
        bool isUseDefaultCredentials = true;
        string strFrom = "";
        string strFromPass = "";

        //mailServerName = "mail.mailasp.com.tw";
        //from = "email@jbjob.com.tw";
        //isUseDefaultCredentials = false;
        //strFrom = "email@jbjob.com.tw";
        //strFromPass = "84211021";
        //to = "hrcard@waferworks.com";

        //subject = Encoding.Convert

        try
        {
            using (MailMessage message =
                new MailMessage(from, to, ConvertBSTRToString(subject), ConvertBSTRToString(body)))
            {
                message.IsBodyHtml = true;
                message.Priority = MailPriority.High;
                message.BodyEncoding = System.Text.Encoding.Default;
                message.SubjectEncoding = System.Text.Encoding.Default;

                SmtpClient mailClient = new SmtpClient(mailServerName);
                mailClient.DeliveryMethod = SmtpDeliveryMethod.Network;

                if (isUseDefaultCredentials) mailClient.UseDefaultCredentials = true;
                else
                {
                    mailClient.UseDefaultCredentials = false;
                    mailClient.Credentials = new System.Net.NetworkCredential(strFrom, strFromPass);
                }

                mailClient.Send(message);
            }
        }
        catch (Exception ex)
        {
        }
    }

    public static string ConvertBSTRToString(string strData)
    {
        //string strData = Marshal.PtrToStringAnsi(ptrData);
        byte[] byteData = Encoding.Default.GetBytes(strData);
        string strResult = Encoding.GetEncoding("Big5").GetString(byteData, 0, byteData.Length);

        return strResult;
    }

    /// <summary>
    /// 填入所有預設資料
    /// </summary>
    /// <param name="r">Row</param>
    public static void SetRowDefaultValue(DataRow r)
    {
        Type t;
        foreach (DataColumn dc in r.Table.Columns)
        {
            t = dc.DataType;
            r[dc] = (t == typeof(string)) ? "" : r[dc];
            r[dc] = (t == typeof(bool)) ? false : r[dc];
            r[dc] = (t == typeof(decimal)) ? 0 : r[dc];
            r[dc] = (t == typeof(double)) ? 0 : r[dc];
            r[dc] = (t == typeof(DateTime)) ? DateTime.Now : r[dc];
            r[dc] = (t == typeof(int)) ? 0 : r[dc];
        }
    }

    //取回編號
    public static string GetSerno(string serno, DateTime date)
    {
        HrDSTableAdapters.AbsSerNoTableAdapter taAbsSerNo = new HrDSTableAdapters.AbsSerNoTableAdapter();
        HrDSTableAdapters.Abs1SerNoTableAdapter taAbs1SerNo = new HrDSTableAdapters.Abs1SerNoTableAdapter();
        HrDSTableAdapters.OtSerNoTableAdapter taOtSerNo = new HrDSTableAdapters.OtSerNoTableAdapter();
        HrDSTableAdapters.CardSerNoTableAdapter taCardSerNo = new HrDSTableAdapters.CardSerNoTableAdapter();
        HrDSTableAdapters.RepairSerNoTableAdapter taRepairSerNo = new HrDSTableAdapters.RepairSerNoTableAdapter();


        DateTime adate, ddate;
        adate = new DateTime(date.Year, date.Month, 1).Date;
        ddate = new DateTime(date.Year, date.Month, DateTime.DaysInMonth(date.Year, date.Month)).Date;

        DataRow[] rows = null;

        string no = "0000";
        switch (serno)
        {
            case "S":	//請假
                rows = taAbsSerNo.GetData(adate, ddate).Select();
                break;
            case "T":	//公出
                rows = taAbs1SerNo.GetData(adate, ddate).Select();
                break;
            case "O":	//加班
                rows = taOtSerNo.GetData(adate, ddate).Select();
                break;
            case "F":	//忘刷
                rows = taCardSerNo.GetData(adate, ddate).Select();
                break;
            case "R":	//搶修
                rows = taRepairSerNo.GetData(adate, ddate).Select();
                break;
        }

        if (rows != null && rows.Length > 0)
            no = rows[0]["SERNO"].ToString().Trim().Length > 0 ? rows[0]["SERNO"].ToString().Trim().Substring(7) : no;

        //no = no.Length == 0 ? "0" : no;

        no = Convert.ToString(Convert.ToInt32(no) + 1);
        return serno + date.Year.ToString().PadLeft(4, char.Parse("0")) + date.Month.ToString().PadLeft(2, char.Parse("0")) + no.PadLeft(4, char.Parse("0"));
    }
    public static void CreateTextFile(string sFileName, string sError)
    {
        StreamWriter sw = File.CreateText(@sFileName);
        sw.Write(sError);
        sw.Close();
    }
}