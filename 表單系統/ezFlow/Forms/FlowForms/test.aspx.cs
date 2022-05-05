using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class test : System.Web.UI.Page
{
    public RepairDSTableAdapters.wfRepairAppSTableAdapter wfRepairAppSTA = new RepairDSTableAdapters.wfRepairAppSTableAdapter();

    protected void Page_Load(object sender, EventArgs e)
    {

        AbsEntitleForOldHRMRepo REPO = new AbsEntitleForOldHRMRepo();

        //AbsDS.ABS_ENTITLEDataTable dtEntitleByYearRest = REPO.GetEntitleByYearRest("1003350", "2", new DateTime(2017,3,2).Date, new DateTime(2017, 3, 2).Date);
        //bool b =    AbsCS.IsBalance("993037", "A", new DateTime(2011, 5, 6), 0, 4, "");

        //string a =     FlowCS.GetSerno("O", new DateTime(2011, 1, 1));
        //AbsDS.AbsInfoDataDataTable dt = new AbsCS().GetAbsInfo("1044985",DateTime.Now.Date);
        //AbsCS.AbsCalculation AAA = AbsCS.CalculationAbs("1003317", "A", new DateTime(2017, 3, 23), new DateTime(2017, 3, 23), "1900", "2000", "", 0);
        OtCS.OtCalculation oOtCalculation = OtCS.CalculationOt("1003317", "0", new DateTime(2017, 10, 24), new DateTime(2017, 10, 24, 13, 0, 0), new DateTime(2017, 10, 24, 15, 0, 0));
        //AbsCS.IsBalance("941609", "F", new DateTime(2012, 7, 23), 1, 0, "戴秀英", 0);

        //RepairDS.wfRepairAppSDataTable dtRepairAppS = wfRepairAppSTA.GetDataByOtHour("993240", "10207");
        //if (dtRepairAppS.Rows.Count > 0)
        //{

        //    object o = dtRepairAppS.Compute("SUM(iTotalHours)", "sOtcatCode = '1'");
        //   decimal iOt = Convert.ToDecimal(dtRepairAppS.Compute("SUM(iTotalHours)", "sOtcatCode = '1'").ToString());
        //}
    }
}
