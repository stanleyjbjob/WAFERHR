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

public partial class Shift_View : System.Web.UI.Page
{
    FlowDSTableAdapters.SysAdminTableAdapter SysAdminTA = new FlowDSTableAdapters.SysAdminTableAdapter();
    ShiftDSTableAdapters.wfShiftAppSTableAdapter wfShiftAppSTA = new ShiftDSTableAdapters.wfShiftAppSTableAdapter();
    ShiftDSTableAdapters.wfShiftAppMTableAdapter wfShiftAppMTA = new ShiftDSTableAdapters.wfShiftAppMTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack) {
            string LoginID = (Request.Cookies["ezFlow"] == null) ? Request["idEmp_Start"] : Request.Cookies["ezFlow"]["Emp_id"];

            if (SysAdminTA.GetDataByKey(LoginID).Rows.Count == 0) {
                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('您沒有權限可進入此頁面，請洽管理人員');", true);
                upl.Visible = false;
                return;
            }
        }
    }

    protected void gvS_RowCommand(object sender, GridViewCommandEventArgs e)
    {
        if (e.CommandName == "Del")
        {
            DataRowCollection rows = wfShiftAppSTA.GetDataByAutoKey(Convert.ToInt32(e.CommandArgument)).Rows;

            if (rows.Count > 0)
            {
                ShiftDS.wfShiftAppSRow r = (ShiftDS.wfShiftAppSRow)rows[0];
                r.sState = "4";

                wfShiftAppSTA.Update(r);

                ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('刪除完成');", true);
                return;
            }
        }

        if (e.CommandName == "Services")
        {
            string msg = "呼叫失敗";

            ShiftWS oWS = new ShiftWS();
            RoteWS oR = new RoteWS();
            if (oWS.Run(FlowCS.GetViewID(Convert.ToInt32(e.CommandArgument), "")))
                if (oR.Run(FlowCS.GetViewID(Convert.ToInt32(e.CommandArgument), "")))
                    msg = "呼叫成功";

            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + msg + "');", true);
        }

        if (e.CommandName == "Restart")
        {
            string msg = "重送失敗";
            ShiftDS oShiftDS = new ShiftDS();
            wfShiftAppMTA.FillByProcessID(oShiftDS.wfShiftAppM, e.CommandArgument.ToString());
            wfShiftAppSTA.FillByProcessID(oShiftDS.wfShiftAppS, e.CommandArgument.ToString());

            localhost.Service oService = new localhost.Service();
            int ProcessID = oService.GetProcessID();

            if (oShiftDS.wfShiftAppM.Rows.Count > 0)
            {
                ShiftDS.wfShiftAppMRow rm = (ShiftDS.wfShiftAppMRow)oShiftDS.wfShiftAppM.Rows[0];
                rm.idProcess = ProcessID;
                rm.sProcessID = ProcessID.ToString();
                rm.sState = "1";

                if (oShiftDS.wfShiftAppS.Rows.Count > 0)
                {
                    string RoleID = "";
                    string Nobr = "";
                    string RoteCate = "";
                    foreach (ShiftDS.wfShiftAppSRow rs in oShiftDS.wfShiftAppS.Rows)
                    {
                        rs.idProcess = ProcessID;
                        rs.sProcessID = ProcessID.ToString();
                        rs.sState = "1";

                        HrBaseData oHrBaseDataS = new HrBaseData(rs.sNobr);
                        RoleID = oHrBaseDataS.sDept + oHrBaseDataS.sJob;
                        Nobr = rs.sNobr;
                        RoteCate = rs.sRoteCate;
                    }

                    if (oService.FlowStart(ProcessID, (RoteCate == "1" ? "26" : "25"), RoleID, Nobr, Request["idRole_Start"], Request["idEmp_Start"]))
                    {
                        wfShiftAppMTA.Update(oShiftDS.wfShiftAppM);
                        wfShiftAppSTA.Update(oShiftDS.wfShiftAppS);
                        msg = "重送成功";
                    }
                }
            }

            ScriptManager.RegisterStartupScript(upl, typeof(UpdatePanel), "key", "alert('" + msg + "');", true);
        }

        gvS.DataBind();

    }

    protected void btnSearch_Click(object sender, EventArgs e)
    {
        lblNobr.Text = txtNobr.Text.Trim().Length > 0 ? txtNobr.Text.Trim() : "a";
        gvS.DataBind();
    }
}
