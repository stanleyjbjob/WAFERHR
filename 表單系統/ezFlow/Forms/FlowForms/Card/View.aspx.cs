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

public partial class Card_View : System.Web.UI.Page
{
    FlowDSTableAdapters.SysAdminTableAdapter SysAdminTA = new FlowDSTableAdapters.SysAdminTableAdapter();
    CardDSTableAdapters.wfCardAppSTableAdapter wfCardAppSTA = new CardDSTableAdapters.wfCardAppSTableAdapter();
    CardDSTableAdapters.wfCardAppMTableAdapter wfCardAppMTA = new CardDSTableAdapters.wfCardAppMTableAdapter();

    protected void Page_Load(object sender, EventArgs e) {
        if (!this.IsPostBack) {
            string LoginID = (Request.Cookies["ezFlow"] == null) ? Request["idEmp_Start"] : Request.Cookies["ezFlow"]["Emp_id"];

            //if (SysAdminTA.GetDataByKey(LoginID).Rows.Count == 0) {
            //    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您沒有權限可進入此頁面，請洽管理人員');", true);
            //    upl.Visible = false;
            //    return;
            //}
        }
    }

    protected void gvS_RowCommand(object sender, GridViewCommandEventArgs e) {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName != "Sort" && CommandArgument.Length > 0)
        {
            DataRowCollection rows = wfCardAppSTA.GetDataByAutoKey(Convert.ToInt32(CommandArgument)).Rows;

            if (rows.Count > 0) {
                CardDS.wfCardAppSRow r = (CardDS.wfCardAppSRow)rows[0];

                if (CommandName == "Upload")
                {
                    string link = "MyFrame.aspx?url=Upload.aspx?nobr=" + r.sNobr + "&id=" + r.sProcessID;
                    string script = "var sFeatures = 'dialogWidth:600px;dialogHeight:300px;center:yes;help:no;resizable:no;scroll:no;status:no;';" +
                        "var obj = form1;" +
                        "window.showModalDialog('" + link + "', obj, sFeatures);";
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "Upload", script, true);
                }

                if (CommandName == "Del") {
                    r.sState = "4";
                    wfCardAppSTA.Update(r);

                    gvS.DataBind();
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('刪除完成');", true);
                }
            }

            if (CommandName == "Services")
            {
                string msg = "呼叫失敗";

                CardWS oWS = new CardWS();
                if (oWS.Run(int.Parse(CommandArgument)))
                    msg = "呼叫成功";

                gvS.DataBind();
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + msg + "');", true);
            }

            if (CommandName == "Restart")
            {
                string msg = "重送失敗";
                CardDS oCardDS = new CardDS();
                wfCardAppMTA.FillByProcessID(oCardDS.wfCardAppM, CommandArgument);
                wfCardAppSTA.FillByProcessID(oCardDS.wfCardAppS, CommandArgument);

                localhost.Service oService = new localhost.Service();
                int ProcessID = oService.GetProcessID();

                if (oCardDS.wfCardAppM.Rows.Count > 0)
                {
                    CardDS.wfCardAppMRow rm = (CardDS.wfCardAppMRow)oCardDS.wfCardAppM.Rows[0];
                    rm.idProcess = ProcessID;
                    rm.sProcessID = ProcessID.ToString();
                    rm.sState = "1";

                    if (oCardDS.wfCardAppS.Rows.Count > 0)
                    {
                        string RoleID = "";
                        string Nobr = "";
                        foreach (CardDS.wfCardAppSRow rs in oCardDS.wfCardAppS.Rows)
                        {
                            rs.idProcess = ProcessID;
                            rs.sProcessID = ProcessID.ToString();
                            rs.sState = "1";

                            HrBaseData oHrBaseDataS = new HrBaseData(rs.sNobr);
                            RoleID = oHrBaseDataS.sDept + oHrBaseDataS.sJob;
                            Nobr = rs.sNobr;
                        }

                        if (oService.FlowStart(ProcessID, "40", RoleID, Nobr, Request["idRole_Start"], Request["idEmp_Start"]))
                        {
                            wfCardAppMTA.Update(oCardDS.wfCardAppM);
                            wfCardAppSTA.Update(oCardDS.wfCardAppS);
                            msg = "重送成功";
                        }
                    }
                }

                gvS.DataBind();
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + msg + "');", true);
            }
        }
    }
    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblNobr.Text = txtNobr.Text.Trim().Length > 0 ? txtNobr.Text.Trim() : "a";
        gvS.DataBind();
    }
}
