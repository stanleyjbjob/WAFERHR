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

public partial class Absc_View : System.Web.UI.Page
{
    FlowDSTableAdapters.SysAdminTableAdapter SysAdminTA = new FlowDSTableAdapters.SysAdminTableAdapter();
    AbscDSTableAdapters.wfAbscAppSTableAdapter wfAbscAppSTA = new AbscDSTableAdapters.wfAbscAppSTableAdapter();
    AbscDSTableAdapters.wfAbscAppMTableAdapter wfAbscAppMTA = new AbscDSTableAdapters.wfAbscAppMTableAdapter();

    protected void Page_Load(object sender, EventArgs e) {
        if (!this.IsPostBack) {
            string LoginID = (Request.Cookies["ezFlow"] == null) ? Request["idEmp_Start"] : Request.Cookies["ezFlow"]["Emp_id"];

            if (SysAdminTA.GetDataByKey(LoginID).Rows.Count == 0) {
                //ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您沒有權限可進入此頁面，請洽管理人員');", true);
                //upl.Visible = false;
                //return;
            }
        }
    }

    protected void gvS_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        string CommandName = e.CommandName;
        string CommandArgument = e.CommandArgument.ToString();

        if (CommandName != "Sort" && CommandArgument.Length > 0)
        {
            DataRowCollection rows = wfAbscAppSTA.GetDataByAutoKey(Convert.ToInt32(CommandArgument)).Rows;

            if (rows.Count > 0)
            {
                AbscDS.wfAbscAppSRow r = (AbscDS.wfAbscAppSRow)rows[0];

                if (CommandName == "Del")
                {
                    r.sState = "4";
                    wfAbscAppSTA.Update(r);

                    gvS.DataBind();
                    ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('刪除完成');", true);
                }
            }

            if (CommandName == "Services")
            {
                string msg = "呼叫失敗";

                AbscWS oWS = new AbscWS();
                if (oWS.Run(FlowCS.GetViewID(int.Parse(CommandArgument), "")))
                    msg = "呼叫成功";

                gvS.DataBind();
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + msg + "');", true);
            }

            if (CommandName == "Restart")
            {
                string msg = "重送失敗";
                AbscDS oAbscDS = new AbscDS();
                wfAbscAppMTA.FillByProcessID(oAbscDS.wfAbscAppM, CommandArgument);
                wfAbscAppSTA.FillByProcessID(oAbscDS.wfAbscAppS, CommandArgument);

                localhost.Service oService = new localhost.Service();
                int ProcessID = oService.GetProcessID();

                if (oAbscDS.wfAbscAppM.Rows.Count > 0)
                {
                    AbscDS.wfAbscAppMRow rm = (AbscDS.wfAbscAppMRow)oAbscDS.wfAbscAppM.Rows[0];
                    rm.idProcess = ProcessID;
                    rm.sProcessID = ProcessID.ToString();
                    rm.sState = "1";

                    if (oAbscDS.wfAbscAppS.Rows.Count > 0)
                    {
                        string RoleID = "";
                        string Nobr = "";
                        foreach (AbscDS.wfAbscAppSRow rs in oAbscDS.wfAbscAppS.Rows)
                        {
                            rs.idProcess = ProcessID;
                            rs.sProcessID = ProcessID.ToString();
                            rs.sState = "1";

                            HrBaseData oHrBaseDataS = new HrBaseData(rs.sNobr);
                            RoleID = oHrBaseDataS.sDept + oHrBaseDataS.sJob;
                            Nobr = rs.sNobr;
                        }

                        if (oService.FlowStart(ProcessID, "29", RoleID, Nobr, Request["idRole_Start"], Request["idEmp_Start"]))
                        {
                            wfAbscAppMTA.Update(oAbscDS.wfAbscAppM);
                            wfAbscAppSTA.Update(oAbscDS.wfAbscAppS);
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
