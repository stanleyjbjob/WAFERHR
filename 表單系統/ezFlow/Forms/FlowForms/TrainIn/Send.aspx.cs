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
using System.IO;
using System.Text;

public partial class TrainIn_Send : System.Web.UI.Page
{
    public TrainDSTableAdapters.TRCOSTableAdapter TRCOSTA = new TrainDSTableAdapters.TRCOSTableAdapter();
    public TrainDSTableAdapters.TRATTTableAdapter TRATTTA = new TrainDSTableAdapters.TRATTTableAdapter();
    public TrainDSTableAdapters.TRTCRDTTableAdapter TRTCRDTTA = new TrainDSTableAdapters.TRTCRDTTableAdapter();
    public TrainDSTableAdapters.TRTCRTableAdapter TRTCRTA = new TrainDSTableAdapters.TRTCRTableAdapter();
    public TrainDSTableAdapters.TrattTableAdapter TrattTA = new TrainDSTableAdapters.TrattTableAdapter();
    public TrainDSTableAdapters.BaseRelBasettsTableAdapter BaseRelBasettsTA = new TrainDSTableAdapters.BaseRelBasettsTableAdapter();
    public FlowDSTableAdapters.BaseDataFlowTableAdapter BaseDataFlowTA = new FlowDSTableAdapters.BaseDataFlowTableAdapter();

    public TrainDS oTrainDS;
    public FlowDS oFlowDS;

    public DataRow[] rows;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oTrainDS = new TrainDS();
        oFlowDS = new FlowDS();

        Session["oTrainDS"] = oTrainDS;

        ScriptManager.GetCurrent(this).RegisterPostBackControl(btnView);
    }

    protected void ddlCourse_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlYYMM.Items.Clear();
        ddlYYMM.Items.Add(new ListItem("請選擇年月", "a"));

        ddlSer.Items.Clear();
        ddlSer.Items.Add(new ListItem("請選擇期別", "a"));
    }

    protected void ddlYYMM_SelectedIndexChanged(object sender, EventArgs e)
    {
        ddlSer.Items.Clear();
        ddlSer.Items.Add(new ListItem("請選擇期別", "a"));
    }

    /// <summary>
    /// ListBox從A到B
    /// </summary>
    /// <param name="lbF">原本</param>
    /// <param name="lbT">目的</param>
    /// <param name="isAll">是否全部</param>
    /// <param name="cal">加減項</param>
    public void lbTOlb(ListBox lbF, ListBox lbT, bool isAll, string cal)
    {
        ListBox lb = new ListBox();

        foreach (ListItem li in lbF.Items)
        {
            li.Selected = isAll ? isAll : li.Selected;
            if (li.Selected && (!lbT.Items.Contains(li)))
            {
                lb.Items.Add(li);
                lbT.Items.Add(li);
            }
        }

        //把從左邊移到右邊的刪除(左邊)
        foreach (ListItem li in lb.Items)
            if (lbF.Items.Contains(li))
                lbF.Items.Remove(li);
    }

    protected void ibtn_Click(object sender, ImageClickEventArgs e)
    {
        ImageButton ibtn = (ImageButton)sender;
        string CommandName = ibtn.CommandName;

        if (CommandName == "DeptAllR")
            lbTOlb(lbDeptL, lbDeptR, true, "+");
        if (CommandName == "DeptR")
            lbTOlb(lbDeptL, lbDeptR, false, "+");
        if (CommandName == "DeptL")
            lbTOlb(lbDeptR, lbDeptL, false, "-");
        if (CommandName == "DeptAllL")
            lbTOlb(lbDeptR, lbDeptL, true, "-");

        if (CommandName == "JobAllR")
            lbTOlb(lbJobL, lbJobR, true, "+");
        if (CommandName == "JobR")
            lbTOlb(lbJobL, lbJobR, false, "+");
        if (CommandName == "JobL")
            lbTOlb(lbJobR, lbJobL, false, "-");
        if (CommandName == "JobAllL")
            lbTOlb(lbJobR, lbJobL, true, "-");
    }

    protected void btnView_Click(object sender, EventArgs e)
    {
        string Course, YYMM, Ser, Logic, Where = "", DeptWhere = "", JobWhere = "";
        bool SelectTrain = cbSelectTrain.Checked;

        Course = ddlCourse.SelectedItem.Value;
        YYMM = ddlYYMM.SelectedItem.Value;
        Ser = ddlSer.SelectedItem.Value;
        Logic = rblLogic.SelectedItem.Value;

        if (lbDeptR.Items.Count == 0 && lbJobR.Items.Count == 0)
        {
            lblMsg.Text = "沒有部門和職稱為條件";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        if (Ser == "a")
        {
            lblMsg.Text = "請先選擇正確的期別";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        foreach (ListItem li in lbDeptR.Items) DeptWhere += "DEPT = '" + li.Value + "' OR ";
        DeptWhere = (DeptWhere.Length > 0) ? " (" + DeptWhere.Substring(0, DeptWhere.Length - 4) + ") " : "(DEPT = '0')";

        foreach (ListItem li in lbJobR.Items) JobWhere += "JOB = '" + li.Value + "' OR ";
        JobWhere = (JobWhere.Length > 0) ? " (" + JobWhere.Substring(0, JobWhere.Length - 4) + ") " : "(JOB = '0')";

        Where = (DeptWhere.Length > 0 && JobWhere.Length > 0) ? DeptWhere + Logic + JobWhere : DeptWhere + JobWhere;
        lblWhere.Text = Where;

        rows = BaseRelBasettsTA.GetData().Select(Where, "NOBR");

        if (rows.Length == 0)
        {
            lblMsg.Text = "您無人員需要上課";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
            return;
        }

        foreach (TrainDS.BaseRelBasettsRow r in rows)
        {
            r.bSelect = SelectTrain;
            r.bSend = true;
            r.bAdd = true;
        }

        gvTrain.DataSource = rows;
        gvTrain.DataBind();

        mv.ActiveViewIndex = 1;

        lbtnUpload.CommandArgument = Course + YYMM + Ser;
        lbtnCosDataEdit.CommandArgument = Course + YYMM + Ser;
    }

    protected void lbtnUpload_Click(object sender, EventArgs e)
    {
        LinkButton lbtn = (LinkButton)sender;

        int w = 750, h = 300;

        if (lbtn.CommandName == "CosDataEdit")
            h = 600;

        string link = "MyFrame.aspx?url=" + lbtn.CommandName + ".aspx?id=" + lbtn.CommandArgument;
        string script = "var sFeatures = 'dialogWidth:" + w + "px;dialogHeight:" + h + "px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
            "var obj = " + Form.ClientID + ";" +
            "window.showModalDialog('" + link + "', obj, sFeatures);";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
    }

    public class SystemVariable
    {
        public Hashtable ht = new Hashtable();
        public SystemVariable()
        {
            ht.Add("System.Url.Host", System.Web.HttpContext.Current.Request.Url.Host);
            ht.Add("System.Url.Segments", GetPath());
            ht.Add("ImagePath", "images");
        }

        //取得路徑
        public string GetPath()
        {
            string path = "";
            foreach (string p in System.Web.HttpContext.Current.Request.Url.Segments)
                if (p.IndexOf(".aspx") == -1)
                    path += p;

            return path;
        }
    }

    protected void btnSend_Click(object sender, EventArgs e)
    {
        FileStream fs = new FileStream(Server.MapPath("q.htm"), FileMode.Open, FileAccess.Read);
        StreamReader sr = new StreamReader(fs, Encoding.GetEncoding("big5"));
        string html = sr.ReadToEnd();
        string dcName;
        string body;
        sr.Close();
        fs.Close();

        //系統資訊
        SystemVariable sv = new SystemVariable();

        foreach (DictionaryEntry h in sv.ht)
        {
            dcName = "{" + h.Key.ToString() + "}";
            if (html.IndexOf(dcName) != -1)
                html = html.Replace(dcName, h.Value.ToString());
        }

        string Nobr, Name, Dept;
        bool Select, Send , Add;
        string Course, CourseName, cn, YYMM, Ser;
        string Mail;
        Course = ddlCourse.SelectedItem.Value;
        CourseName = ddlCourse.SelectedItem.Text;
        YYMM = ddlYYMM.SelectedItem.Value;
        Ser = ddlSer.SelectedItem.Value;
        string Key = Course + YYMM + Ser;

        BaseDataFlowTA.Fill(oFlowDS.BaseDataFlow);
        TRCOSTA.FillByKey(oTrainDS.TRCOS, Key);
        TRATTTA.Fill(oTrainDS.TRATT);
        TRTCRDTTA.FillByKey(oTrainDS.TRTCRDT, Key);
        TRTCRTA.Fill(oTrainDS.TRTCR);

        //處理資料
        foreach (TrainDS.TRCOSRow rtt in oTrainDS.TRCOS.Rows)
        {
            rtt.sTcrName = "";
            foreach (TrainDS.TRTCRDTRow rtc in oTrainDS.TRTCRDT.Rows)
            {
                rows = oTrainDS.TRTCR.Select("TCR_NO = '" + rtc.TCR_NO.Trim() + "'");
                rtt.sTcrName += (rows.Length > 0) ? ((TrainDS.TRTCRRow)rows[0]).TCR_NAME.Trim() + "," : "";
            }

            rtt.sDateTimeB = rtt.COSDATEB.ToShortDateString() + " " + rtt.COSTIMEB.Trim();
            rtt.sDateTimeE = rtt.COSDATEE.ToShortDateString() + " " + rtt.COSTIMEE.Trim();
        }

        TrainDS.TRATTRow ra;
        foreach (GridViewRow gvr in gvTrain.Rows)
        {
            Nobr = ((Label)gvr.FindControl("lblNobr")).Text.Trim();
            Name = ((Label)gvr.FindControl("lblName")).Text.Trim();
            Dept = ((Label)gvr.FindControl("lblDept")).Text.Trim();
            Send = ((CheckBox)gvr.FindControl("cbSend")).Checked;
            Select = ((CheckBox)gvr.FindControl("cbSelect")).Checked;
            Add = ((CheckBox)gvr.FindControl("cbAdd")).Checked;
            Mail = "ming@jbjob.com.tw";

            if (!Add)
                continue;

            rows = oFlowDS.BaseDataFlow.Select("Emp_id = '" + Nobr + "' AND email <> ''");
            if (rows.Length > 0)
            {
                FlowDS.BaseDataFlowRow rb = (FlowDS.BaseDataFlowRow)rows[0];
                Mail = (txtMail.Text.Length > 0) ? txtMail.Text : rb.email;
            }

            body = html;
            //填入課程資訊
            body = body.Replace("{Name}", Name);
            body = body.Replace("{Dept}", Dept);
            if (oTrainDS.TRCOS.Rows.Count > 0)
            {
                foreach (DataColumn dc in oTrainDS.TRCOS.Columns)
                {
                    dcName = "{" + dc.ColumnName + "}";
                    if (body.IndexOf(dcName) != -1)
                        body = body.Replace(dcName, oTrainDS.TRCOS.Rows[0][dc.ToString()].ToString());
                }
            }

            if (cbWrite.Checked)
            {
                rows = oTrainDS.TRATT.Select("COSCODE = '" + Course + "' AND YYMM = '" + YYMM + "' AND SER = '" + Ser + "' AND IDNO = '" + Nobr + "'");

                if (rows.Length > 0)
                    rows[0].Delete();

                if (Send)
                {
                    ra = oTrainDS.TRATT.NewTRATTRow();
                    ra.COSCODE = Course;
                    ra.YYMM = YYMM;
                    ra.SER = Ser;
                    ra.IDNO = Nobr;
                    ra.KEY_MAN = "System";
                    ra.SELCODE = (Select) ? "1" : "2";
                    ra.ATTHRS = 0;
                    ra.ABSHRS = 0;
                    ra.SCORE = 0;
                    ra.COSCLOSE = false;
                    ra.SHAREFEE = false;
                    ra.ABS = false;
                    ra.NOTE = "";
                    ra.HOMEWORK = false;
                    ra.KEY_DATE = DateTime.Now.Date;
                    ra.FEE = 0;
                    ra.ONLINESIGN = false;
                    ra.EXPECT = ""; //期望
                    ra.TR_ASDATE = DateTime.Now.Date;	//這行要由參加寫入
                    ra.LAT_NO = 0;
                    ra.EAR_NO = 0;
                    oTrainDS.TRATT.AddTRATTRow(ra);
                }
            }

            rows = oTrainDS.TRATT.Select("COSCODE = '" + Course + "' AND YYMM = '" + YYMM + "' AND SER = '" + Ser + "' AND IDNO = '" + Nobr + "'");
            cn = "[" + CourseName + "]" + ((rows.Length > 0) ? "課程通知，您已列入上課名單，請確認" : "課程通知，歡迎上系統報名");

            if (Send)
                FlowCS.SendMail(Mail, cn, body);
        }

        if (cbWrite.Checked)
            TRATTTA.Update(oTrainDS.TRATT);

        lblMsg.Text = "完成";
        ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');", true);
    }

    protected void btnCancel_Click(object sender, EventArgs e)
    {
        mv.ActiveViewIndex = 0;
    }

    public string GetMailBody()
    {
        return "";
    }

    protected void gvTrain_RowDataBound(object sender, GridViewRowEventArgs e)
    {
        string Course, YYMM, Ser, key;

        Course = ddlCourse.SelectedItem.Value;
        YYMM = ddlYYMM.SelectedItem.Value;
        Ser = ddlSer.SelectedItem.Value;
        key = Course.Trim() + YYMM.Trim() + Ser.Trim();

        Label lblNobr = (Label)e.Row.FindControl("lblNobr");
        CheckBox cbAdd = ((CheckBox)e.Row.FindControl("cbAdd"));

        if (lblNobr != null)
        {
            rows = TRATTTA.GetDataByCOSCODE(Course).Select("IDNO = '" + lblNobr.Text + "'");
            if (rows.Length > 0)
            {
                TrainDS.TRATTRow rt = (TrainDS.TRATTRow)rows[0];
                if (rt.HOMEWORK)    //完成評核
                {
                    cbAdd.Checked = cbOK.Checked;
                    e.Row.Visible = cbOK.Checked;
                }
            }

            rows = TRATTTA.GetDataByKey(key).Select("IDNO = '" + lblNobr.Text + "'");
            if (rows.Length > 0)
            {
                cbAdd.Checked = cbTratt.Checked;
                e.Row.Visible = cbTratt.Checked;
            }
        }
    }
}