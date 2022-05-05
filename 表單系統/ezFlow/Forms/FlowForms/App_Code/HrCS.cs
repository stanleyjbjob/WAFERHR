using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// HrCS 的摘要描述
/// </summary>
public class HrCS {
    public HrCS() { }

    //當月尚未結轉薪資，則以當月為計薪年月，若已結束，計算年月順延一個月
    public static string SetYYMM(DateTime bdate)
    {
        bdate = bdate.Day >= 26 ? bdate.AddMonths(1) : bdate;   //by 合晶
        HrDSTableAdapters.LOCK_WAGETableAdapter LOCK_WAGETA = new HrDSTableAdapters.LOCK_WAGETableAdapter();
        HrDSTableAdapters.DATA_PASSTableAdapter DATA_PASSTA = new HrDSTableAdapters.DATA_PASSTableAdapter();

        string yymm = "";
        int i = 0;
        while (DATA_PASSTA.GetDataByDate(bdate.AddMonths(i).Date, "A").Rows.Count > 0)
            i++;

        do
        {
            yymm = Convert.ToString(bdate.AddMonths(i).Year - 1911) + bdate.AddMonths(i).Month.ToString().PadLeft(2, char.Parse("0"));
            yymm = yymm.PadLeft(5, char.Parse("0"));
            i++;
        } while (LOCK_WAGETA.GetDataByYYMM(yymm).Select("SEQ = '2'").Length > 0);

        return yymm;
    }

    public static HrDS.AbsDataTable GetAbs0246ByNobrBdate(string nobr,DateTime Bdate)
    {
        HrDSTableAdapters.AbsTableAdapter AbsTA = new HrDSTableAdapters.AbsTableAdapter();
        HrDS.AbsDataTable AbsDT = new HrDS.AbsDataTable();
        AbsTA.FillByAbs0246(AbsDT, nobr, Bdate);
        return AbsDT;
    }
    public static HrDS.HCODERow GetHCodeByHcode(string hcode)
    {
        HrDSTableAdapters.HCODETableAdapter HcodeTA = new HrDSTableAdapters.HCODETableAdapter();
        HrDS.HCODEDataTable HcodeDT = new HrDS.HCODEDataTable();
        HcodeTA.FillByHCODE(HcodeDT, hcode);
        HrDS.HCODERow HcodeRW=null;
        if (HcodeDT.Rows.Count > 0)
            HcodeRW = HcodeDT.Rows[0] as HrDS.HCODERow;
        return HcodeRW;
    }
}