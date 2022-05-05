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

public partial class qQuestionaryView : System.Web.UI.Page
{
    public QuestionaryDSTableAdapters.TRQTableAdapter taTRQ = new QuestionaryDSTableAdapters.TRQTableAdapter();

    public QuestionaryDS oQuestionaryDS;

    public DataRow[] rows;

    public string Code, tmp1, tmp2;
    public int x = 0, y = 0;

    protected void Page_Load(object sender, EventArgs e)
    {
        lblMsg.Text = "";
        oQuestionaryDS = new QuestionaryDS();

        Code = Request.QueryString["Code"];
        taTRQ.FillByTRQCODE(oQuestionaryDS.TRQ, Code);

        if (Code == null || oQuestionaryDS.TRQ.Rows.Count == 0)
        {
            lblMsg.Text = "系統參數不正確，請重新進入";
            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + lblMsg.Text + "');close();", true);
            upl.Visible = false;
        }

        QuestionaryDS.TRQRow rqm = (QuestionaryDS.TRQRow)oQuestionaryDS.TRQ.Rows[0];
        lblTitle.Text = rqm.IsCONTENTNull() ? "" : rqm.CONTENT;
        lblHeader.Text = rqm.IsHEADERNull() ? "" : rqm.HEADER;
        lblFooter.Text = rqm.IsFOOTERNull() ? "" : rqm.FOOTER;
    }


    protected void dlQuestionary_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Label lblCastContent = (Label)e.Item.FindControl("lblCastContent");
        Label lblCastCate = (Label)e.Item.FindControl("lblCastCate");
        RadioButtonList rblCate = (RadioButtonList)e.Item.FindControl("rblCate");
        TextBox txtCate = (TextBox)e.Item.FindControl("txtCate");

        if (lblCastContent != null)
        {
            x++;
            lblCastContent.Text = x.ToString().PadLeft(2, char.Parse("0")) + "." + lblCastContent.Text;

            rblCate.Visible = (lblCastCate.Text == "2");
            txtCate.Visible = (lblCastCate.Text != "1");
        }
    }

    protected void dlCast_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        Label lblThemeContent = (Label)e.Item.FindControl("lblThemeContent");
        Label lblCastCode = (Label)e.Item.FindControl("lblCastCode");
        RadioButton r1, r2, r3, r4, r5;
        r1 = (RadioButton)e.Item.FindControl("rbFraction1");
        r2 = (RadioButton)e.Item.FindControl("rbFraction2");
        r3 = (RadioButton)e.Item.FindControl("rbFraction3");
        r4 = (RadioButton)e.Item.FindControl("rbFraction4");
        r5 = (RadioButton)e.Item.FindControl("rbFraction5");

        if (lblThemeContent != null)
        {
            tmp1 = lblCastCode.Text;
            if (tmp1 != tmp2)
            {
                y = 0;
                tmp2 = tmp1;
            }

            r1.Visible = r1.Text.Trim().Length > 0;
            r2.Visible = r2.Text.Trim().Length > 0;
            r3.Visible = r3.Text.Trim().Length > 0;
            r4.Visible = r4.Text.Trim().Length > 0;
            r5.Visible = r5.Text.Trim().Length > 0;

            y++;
            lblThemeContent.Text = "　" + y.ToString().PadLeft(2, char.Parse("0")) + "." + lblThemeContent.Text;
        }
    }
}
