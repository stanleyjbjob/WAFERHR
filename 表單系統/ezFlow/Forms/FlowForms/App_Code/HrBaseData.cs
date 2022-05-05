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
/// HrBaseData 的摘要描述
/// </summary>
public class HrBaseData {
    public HrDSTableAdapters.BaseDataTableAdapter BaseDataTA = new HrDSTableAdapters.BaseDataTableAdapter();

    public string sNobr = "";
    public string sName = "";
    public string sSex = "";
    public string sDept = "";
    public string sDeptName = "";
    public string sDepts = "";
    public string sJob = "";
    public string sJobName = "";
    public string sJobl = "";
    public string sJoblName = "";
    public string sEmpcd = "";
    public string sEmpcdName = "";
    public string sDI = "";
    public bool bMang = false;
    public string sCalot = "";  //加班群組
    public int iCateOrder = 0;
    public int iOtMin = 0;
    public int iOtUnit = 0;
    public string sRotet = "";
    public string sHolicd = "";

    public HrBaseData(string nobr) {
        HrDS.BaseDataRow rb = (BaseDataTA.GetDataByNobr(nobr).Rows.Count > 0) ? (HrDS.BaseDataRow)BaseDataTA.GetDataByNobr(nobr).Rows[0] : null;

        if (rb != null) {
            sNobr = rb.NOBR.Trim();
            sName = rb.IsNAME_CNull() ? "" : rb.NAME_C.Trim();
            sSex = rb.IsSEXNull() ? "" : rb.SEX.Trim();
            sDept = rb.IsDEPTNull() ? "" : rb.DEPT.Trim();    //使用正式組織部門
            sDeptName = rb.IsD_NAMENull() ? "" : rb.D_NAME.Trim();
            //sDept = rb.IsDeptANull() ? "" : rb.DeptA.Trim();    //使用簽核部門
            //sDeptName = rb.IsDeptANameNull() ? "" : rb.DeptAName.Trim();
            sDepts = rb.IsDEPTSNull() ? "" : rb.DEPTS.Trim();
            sJob = rb.IsJOBNull() ? "" : rb.JOB.Trim();
            sJobName = rb.IsJOB_NAMENull() ? "" : rb.JOB_NAME.Trim();
            sJobl = rb.IsJOBLNull() ? "" : rb.JOBL.Trim();
            sJoblName = rb.Isjobl_nameNull() ? "" : rb.jobl_name.Trim();
            sEmpcd = rb.IsEMPCDNull() ? "" : rb.EMPCD.Trim();
            sEmpcdName = rb.IsEMPDESCRNull() ? "" : rb.EMPDESCR.Trim();
            sDI = rb.IsDINull() ? "D" : rb.DI.Trim();
            bMang = rb.IsMANGNull() ? false : rb.MANG;
            sCalot = rb.IsCALOTNull() ? "" : rb.CALOT.Trim();
            iCateOrder = rb.IsDeptATreeNull() || rb.DeptATree.Trim().Length == 0 ? 0 : Convert.ToInt32(rb.DeptATree.Trim());
            iOtMin = rb.IsMIN_HOURSNull() ? 0 : Convert.ToInt32(rb.MIN_HOURS);
            iOtUnit = rb.IsOTUNITNull() ? 0 : rb.OTUNIT;
            sRotet = rb.IsROTETNull() ? "" : rb.ROTET.Trim();
            sHolicd = rb.IsHOLI_CODENull() ? "" : rb.HOLI_CODE.Trim();
        }
    }
}
