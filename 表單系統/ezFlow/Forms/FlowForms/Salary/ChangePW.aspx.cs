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

public partial class Salary_ChangePW : System.Web.UI.Page
{
    public HrDSTableAdapters.BASETableAdapter BASETA = new HrDSTableAdapters.BASETableAdapter();

    public HrDS oHrDS;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";

        oHrDS = new HrDS();
    }

    protected void btnSubmit_Click(object sender, EventArgs e)
    {
        string Nobr, ID, Old, New, NewCheck;
        Nobr = txtNobr.Text.Trim();
        ID = txtID.Text.Trim();
        Old = txtOld.Text.Trim();
        New = txtNew.Text.Trim();
        NewCheck = txtNewCheck.Text.Trim();

        txtNobr.Text = "";
        txtID.Text = "";
        txtOld.Text = "";
        txtNew.Text = "";
        txtNewCheck.Text = "";

        if (New.Length < 4)
        {
            lblMsg.Text = "新密碼長度要4-10個字元！";
            return;
        }

        if (New != NewCheck)
        {
            lblMsg.Text = "新密碼與密碼確認不同，請重新輸入！";
            return;
        }

        BASETA.FillByPW(oHrDS.BASE, Nobr, ID, Old);
        if (oHrDS.BASE.Rows.Count == 0)
        {
            lblMsg.Text = "您所提供的資訊不正確，請重新輸入！";
            return;
        }

        HrDS.BASERow rb = (HrDS.BASERow)oHrDS.BASE.Rows[0];
        rb.PASSWORD = New;

        BASETA.Update(rb);
        lblMsg.Text = "更改完成";
    }
}
