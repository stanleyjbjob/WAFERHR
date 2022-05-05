using System;
using System.Collections.Generic;
using System.Text;


public class AbsEntitleForOldHRMRepo
{
    //JBModule.Data.Linq.HrDBDataContext db = null;
    //List<Linq.HCODE> HcodeList = new List<Linq.HCODE>();
    AbsDS.ABS_ENTITLEDataTable dtAbsEntitle = null;
    AbsDS.ABS_ENTITLEDataTable dtAbsEntitleTemp = null;
    public AbsEntitleForOldHRMRepo()
    {
        //db = new Linq.HrDBDataContext();
        //HcodeList = db.HCODE.ToList();
    }
    public AbsDS.ABS_ENTITLEDataTable GetEntitleByYearRest(string EmployeeID, string YearRest, DateTime BeginDate, DateTime EndDate)
    {
        //List<AbsEntitleForOldHRMDto> results = new List<AbsEntitleForOldHRMDto>();
        //var rHcode = HcodeList.Single(p => p.H_CODE.Trim() == Hcode.Trim());
        string yrrest = YearRest;
        int iRest = Convert.ToInt32(yrrest);
        int iValue = iRest % 2;
        int iGet = 0;
        int iUse = 0;
        if (iRest != 0)
        {
            if (iValue == 0)
            {
                iUse = iRest;
                iGet = iUse - 1;
            }
            else
            {
                iGet = iRest;
                iUse = iGet + 1;
            }
            AbsDSTableAdapters.ABS_ENTITLETableAdapter adEntitle = new AbsDSTableAdapters.ABS_ENTITLETableAdapter();
            dtAbsEntitle = adEntitle.GetDataByApplyInfo(EmployeeID, EndDate.Date, BeginDate.Date, iGet.ToString());

            //將資料暫存
            dtAbsEntitleTemp = dtAbsEntitle.Clone() as AbsDS.ABS_ENTITLEDataTable;
            foreach (AbsDS.ABS_ENTITLERow rAbs in dtAbsEntitle.Rows)
            {
                AbsDS.ABS_ENTITLERow r = dtAbsEntitleTemp.NewABS_ENTITLERow();
                r.ItemArray = rAbs.ItemArray;
                dtAbsEntitleTemp.AddABS_ENTITLERow(r);
            }
            //var sql = (from a in db.ABS

            //           join b in db.HCODE on a.H_CODE equals b.H_CODE
            //           where b.YEAR_REST == iGet.ToString()
            //           && EmployeeList.Contains(a.NOBR.Trim()) && a.BDATE <= EndDate && a.EDATE >= BeginDate
            //           group new AbsEntitleForOldHRMDto
            //           {
            //               //Balance = 0,
            //               BeginDate = a.BDATE,
            //               EmployeeID = a.NOBR,
            //               EndDate = a.EDATE,
            //               Entitle = a.TOL_HOURS,
            //               Hcode = a.H_CODE,
            //               Sort = b.SORT,
            //               Taken = 0,
            //               CheckCode = a.BTIME,
            //           } by a.NOBR).ToList();

            //foreach (var gp in dtAbsEntitle)
            {
                if (dtAbsEntitle.Count == 0)
                    return null;

                DateTime startDate = Convert.ToDateTime(dtAbsEntitle.Compute("Min(BeginDate)", ""));
                //DateTime endDate = Convert.ToDateTime(dtAbsEntitle.Compute("Max(EndDate)", ""));
                AbsDS.ABS_ENTITLEDataTable overlap = GetOverlapEntitle(EmployeeID, iGet.ToString(), startDate, startDate);
                //sql.AddRange(overlap);
                //foreach (AbsDS.ABS_ENTITLERow rr in overlap.Rows)
                //    dtAbsEntitle.;
                dtAbsEntitle.Merge(overlap);
            }
        }

        //results = results.Distinct<AbsEntitleForOldHRMDto>().ToList();
        DateTime beginDate = Convert.ToDateTime(dtAbsEntitle.Compute("Min(BeginDate)", ""));
        DateTime endDate = Convert.ToDateTime(dtAbsEntitle.Compute("Max(EndDate)", ""));
        AbsDSTableAdapters.ABS_TAKENTableAdapter adTaken = new AbsDSTableAdapters.ABS_TAKENTableAdapter();
        AbsDS.ABS_TAKENDataTable dtAbsTaken = adTaken.GetDataByRange(EmployeeID, beginDate.Date, endDate.Date, iUse.ToString());
        //var query = from a in db.ABS
        //            join b in db.HCODE on a.H_CODE equals b.H_CODE
        //            where b.YEAR_REST == iUse.ToString()
        //            && EmployeeList.Contains(a.NOBR.Trim()) && a.BDATE >= beginDate && a.BDATE <= endDate
        //            select new { a.NOBR, a.BDATE, a.TOL_HOURS, a.BTIME, a.ETIME, a.H_CODE };
        decimal total = 0;
        if (dtAbsTaken.Count > 0)
            total = dtAbsTaken.Count;
        decimal leftHrs = 0;
        foreach (AbsDS.ABS_TAKENRow qq in dtAbsTaken.Rows)
        {
            decimal Hrs = qq.Taken;
            //var checkData = from a in results
            //                where a.EmployeeID == qq.NOBR
            //                    && a.Balance > 0 && a.BeginDate <= qq.BDATE
            //                    && a.EndDate >= qq.BDATE
            //                orderby a.EndDate, a.Sort
            //                select a;
            foreach (AbsDS.ABS_ENTITLERow cc in dtAbsEntitle.Select(string.Format("BeginDate<='{0}' and EndDate>='{0}'", qq.AbsDate.ToShortDateString()), "EndDate,BeginDate"))
            {
                if (Hrs <= 0) break;
                if (cc.Balance >= Hrs)
                {
                    cc.Taken += Hrs;
                    cc.Balance = cc.Entitle - cc.Taken;
                    Hrs = 0;
                    break;
                }
                else
                {
                    Hrs -= cc.Balance;
                    cc.Taken += cc.Balance;
                    cc.Balance = cc.Entitle - cc.Taken;
                }
            }
            leftHrs += Hrs;
        }
        AbsDS.ABS_ENTITLEDataTable result = new AbsDS.ABS_ENTITLEDataTable();
        AbsDS.ABS_ENTITLERow[] rows = dtAbsEntitle.Select(string.Format("BeginDate<='{0}' and EndDate>='{1}'", EndDate.ToShortDateString(), BeginDate.ToShortDateString()), "EndDate,BeginDate") as AbsDS.ABS_ENTITLERow[];
        foreach (AbsDS.ABS_ENTITLERow r in rows)
            result.ImportRow(r);
        return result;
    }
    AbsDS.ABS_ENTITLEDataTable GetOverlapEntitle(string EmployeeID, string YearRest, DateTime BeginDate, DateTime EndDate)
    {
        AbsDSTableAdapters.ABS_ENTITLETableAdapter adEntitle = new AbsDSTableAdapters.ABS_ENTITLETableAdapter();
        AbsDS.ABS_ENTITLEDataTable dtEntitle = new AbsDS.ABS_ENTITLEDataTable();
        AbsDS.ABS_ENTITLEDataTable dt = adEntitle.GetDataByOverlap(EmployeeID, BeginDate.Date, YearRest);

        foreach (AbsDS.ABS_ENTITLERow rAbs in dt.Rows)
        {
            AbsDS.ABS_ENTITLERow[] rows = dtAbsEntitleTemp.Select("EmployeeID = '" + rAbs.EmployeeID.Trim() + "' and BeginDate = '" + rAbs.BeginDate.ToShortDateString() + "' and EndDate = '" + rAbs.EndDate.ToShortDateString() + "' and H_CODE = '" + rAbs.H_CODE + "'") as AbsDS.ABS_ENTITLERow[];
            if (rows.Length == 0)
            {
                AbsDS.ABS_ENTITLERow r = dtEntitle.NewABS_ENTITLERow();
                r.ItemArray = rAbs.ItemArray;
                dtEntitle.AddABS_ENTITLERow(r);

                r = dtAbsEntitleTemp.NewABS_ENTITLERow();
                r.ItemArray = rAbs.ItemArray;
                dtAbsEntitleTemp.AddABS_ENTITLERow(r);
            }
        }

        if (dtEntitle.Rows.Count > 0)
        {
            DateTime startDate = Convert.ToDateTime(dtEntitle.Compute("Min(BeginDate)", ""));
            AbsDS.ABS_ENTITLEDataTable overlap = GetOverlapEntitle(EmployeeID, YearRest, startDate, startDate);
            dtEntitle.Merge(overlap);
        }
        return dtEntitle;
    }
}