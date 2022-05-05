using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using System.Net.Mail;
using System.IO;
using System.Text;

public partial class Manage : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.qTypeTableAdapter qTypeTA = new QuestionaryDSTableAdapters.qTypeTableAdapter();
    public QuestionaryDSTableAdapters.qBaseMTableAdapter qBaseMTA = new QuestionaryDSTableAdapters.qBaseMTableAdapter();
    public QuestionaryDSTableAdapters.qBaseSTableAdapter qBaseSTA = new QuestionaryDSTableAdapters.qBaseSTableAdapter();
    public QuestionaryDSTableAdapters.TrattRelBaseTableAdapter TrattRelBaseTA = new QuestionaryDSTableAdapters.TrattRelBaseTableAdapter();
    public QuestionaryDSTableAdapters.BaseRelTypeTableAdapter BaseRelTypeTA = new QuestionaryDSTableAdapters.BaseRelTypeTableAdapter();

    public QuestionaryDS oQuestionaryDS;

    public DataRow[] rows, rowsA, rowsB;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oQuestionaryDS = new QuestionaryDS();
    }

    protected void gv_SelectedIndexChanged(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 1;
        gvBase.DataBind();
        lblCount.Text = "共" + gvBase.Rows.Count.ToString() + "筆";
    }

    protected void btnBack_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 0;
        gv.DataBind();
    }

    protected void gv_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //全部改為手動刪除
        e.Cancel = true;
        gv.SelectedIndex = -1;

        qTypeTA.FillByCode(oQuestionaryDS.qType, e.Keys["sCode"].ToString());
        qBaseMTA.FillByTypeCode(oQuestionaryDS.qBaseM, e.Keys["sCode"].ToString());
        qBaseSTA.Fill(oQuestionaryDS.qBaseS);

        rowsA = oQuestionaryDS.qBaseM.Select();
        foreach (QuestionaryDS.qBaseMRow rbm in rowsA)
        {
            rowsB = oQuestionaryDS.qBaseS.Select("sBaseCode = '" + rbm.sCode + "'");
            foreach (QuestionaryDS.qBaseSRow rbs in rowsB)
                rbs.Delete();

            rbm.Delete();
        }        

        oQuestionaryDS.qType.Rows[0].Delete();

        qBaseSTA.Update(oQuestionaryDS.qBaseS);
        qBaseMTA.Update(oQuestionaryDS.qBaseM);
        qTypeTA.Update(oQuestionaryDS.qType);

        gv.DataBind();
        lblMsg.Text = "刪除完成";
    }

    public class SystemVariable
    {
        public Hashtable ht = new Hashtable();
        public SystemVariable()
        {
            ht.Add("System.Url.Host", System.Web.HttpContext.Current.Request.Url.Host);
        }
    }

    protected void gv_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Sendmail" || e.CommandName == "Sendmail1")
        {
            FileStream fs = new FileStream(Server.MapPath("q.htm"), FileMode.Open, FileAccess.Read);
            StreamReader sr = new StreamReader(fs, Encoding.GetEncoding("big5"));
            string html = sr.ReadToEnd();
            sr.Close();
            fs.Close();

            //系統資訊
            SystemVariable sv = new SystemVariable();

            TrattRelBaseTA.Fill(oQuestionaryDS.TrattRelBase);
            string subject, to, body;
            rows = BaseRelTypeTA.GetDataByTypeCode(e.CommandArgument.ToString()).Select();
            int a = 0;
            foreach (QuestionaryDS.BaseRelTypeRow rbm in rows)
            {
                if (e.CommandName == "Sendmail" || (e.CommandName == "Sendmail1" && rbm.IsdWriteDateNull()))
                {
                    rowsA = oQuestionaryDS.TrattRelBase.Select("IDNO = '" + rbm.sNobr + "'");
                    if (rowsA.Length > 0)
                    {
                        body = html;

                        QuestionaryDS.TrattRelBaseRow rt = (QuestionaryDS.TrattRelBaseRow)rowsA[0];

                        string dcName;
                        foreach (DataColumn dc in oQuestionaryDS.BaseRelType.Columns)
                        {
                            dcName = "{" + dc.ColumnName + "}";
                            if (body.IndexOf(dcName) != -1)
                                body = body.Replace(dcName, rbm[dc.ToString()].ToString());
                        }

                        foreach (DictionaryEntry h in sv.ht)
                        {
                            dcName = "{" + h.Key.ToString() + "}";
                            if (body.IndexOf(dcName) != -1)
                                body = body.Replace(dcName, h.Value.ToString());
                        }

                        subject = rbm.sCourseName + "課後問卷";
                        to = rt.EMAIL.Trim();

                        if (txtMail.Text.Trim().Length > 0)
                        {
                            if (a == 0)
                                SendMail(txtMail.Text.Trim(), subject, body);

                            a++;
                        }
                        else
                        {
                            //正式使用要把註解拿掉
                            if (to.Length > 0)
                                SendMail(to, subject, body);
                        }
                    }
                }
            }

            lblMsg.Text = "寄件完成";
        }
    }

    protected void gvBase_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Select")
        {
            rows = qBaseMTA.GetDataByBaseCode(e.CommandArgument.ToString()).Select();
            if (rows.Length > 0)
            {
                QuestionaryDS.qBaseMRow rbm = (QuestionaryDS.qBaseMRow)rows[0];

                string link = "MyFrame.aspx?url=qWrite.aspx?Code=&TypeCode=" + rbm.sTypeCode + "&Nobr=" + rbm.sNobr + "&PW=" + rbm.sPW;
                string script = "var sFeatures = 'dialogWidth:880px;dialogHeight:800px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                    "var obj = aspnetForm;" +
                    "window.showModalDialog('" + link + "', obj, sFeatures);";
                //ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Select", script, true);
                Page.ClientScript.RegisterStartupScript(typeof(string), "Select", script, true);
            }
        }

        //重新單獨通知
        if (e.CommandName == "Sendmail")
        {
            FileStream fs = new FileStream(Server.MapPath("q.htm"), FileMode.Open, FileAccess.Read);
            StreamReader sr = new StreamReader(fs, Encoding.GetEncoding("big5"));
            string html = sr.ReadToEnd();
            sr.Close();
            fs.Close();

            //系統資訊
            SystemVariable sv = new SystemVariable();

            TrattRelBaseTA.Fill(oQuestionaryDS.TrattRelBase);
            string subject, to, body;
            rows = BaseRelTypeTA.GetData().Select("sCode = '" + e.CommandArgument.ToString() + "'");

            if (rows.Length > 0)
            {
                QuestionaryDS.BaseRelTypeRow rbm = (QuestionaryDS.BaseRelTypeRow)rows[0];

                rowsA = oQuestionaryDS.TrattRelBase.Select("IDNO = '" + rbm.sNobr + "'");
                if (rowsA.Length > 0)
                {
                    body = html;

                    QuestionaryDS.TrattRelBaseRow rt = (QuestionaryDS.TrattRelBaseRow)rowsA[0];

                    string dcName;
                    foreach (DataColumn dc in oQuestionaryDS.BaseRelType.Columns)
                    {
                        dcName = "{" + dc.ColumnName + "}";
                        if (body.IndexOf(dcName) != -1)
                            body = body.Replace(dcName, rbm[dc.ToString()].ToString());
                    }

                    foreach (DictionaryEntry h in sv.ht)
                    {
                        dcName = "{" + h.Key.ToString() + "}";
                        if (body.IndexOf(dcName) != -1)
                            body = body.Replace(dcName, h.Value.ToString());
                    }

                    subject = rbm.sCourseName + "課後問卷(補寄)";
                    to = rt.EMAIL.Trim();

                    SendMail(to, subject, body);

                    lblMsg.Text = "寄件完成";
                }
            }
        }
    }

    protected void gvBase_RowDeleting(object sender, GridViewDeleteEventArgs e)
    {
        //全部改為手動刪除
        e.Cancel = true;
        gvBase.SelectedIndex = -1;

        qBaseMTA.FillByBaseCode(oQuestionaryDS.qBaseM, e.Keys["sTypeCode"].ToString() + e.Keys["sNobr"].ToString());
        qBaseSTA.FillByBaseCode(oQuestionaryDS.qBaseS, e.Keys["sCode"].ToString());

        rowsB = oQuestionaryDS.qBaseS.Select();
        foreach (QuestionaryDS.qBaseSRow rbs in rowsB)
            rbs.Delete();

        oQuestionaryDS.qBaseM.Rows[0].Delete();

        qBaseSTA.Update(oQuestionaryDS.qBaseS);
        qBaseMTA.Update(oQuestionaryDS.qBaseM);

        gvBase.DataBind();
        lblMsg.Text = "刪除完成";
    }

    public static void SendMail(string to, string subject, string body)
    {
        string mailServerName = "";
        string from = "";
        bool isUseDefaultCredentials = true;
        string strFrom = "";
        string strFromPass = "";

        //傑報
        mailServerName = "nt1.jbjob.com.tw";
        from = "ming@jbjob.com.tw";
        isUseDefaultCredentials = false;
        strFrom = "ming";
        strFromPass = "4820";

        try
        {
            using (MailMessage message =
                new MailMessage(from, to, subject, body))
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

    protected void gv_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        sa.gv.RowDataBoundColorChange(e);
    }

    public override void VerifyRenderingInServerForm(Control control) { }
    protected void btnExportXLS_Click(object sender, EventArgs e)
    {
        //gvExcel.AllowPaging = false;
        //gvExcel.AllowSorting = false;
        //gvExcel.Columns[0].Visible = false;
        gvExcel.Visible = true;
        gvExcel.DataBind();
        sa.gv.ExportXls(gvExcel);
    }
}
