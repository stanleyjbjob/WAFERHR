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

public partial class UC_AppentCheck : System.Web.UI.UserControl
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string _yy = "";
        string _seq = "";
        string _dept = "";
        string _nobr = "";
        EFFMANGDS.EFFS_ASSIGNAPPENDDataTable assdt = DataClass.getAssignEmpNobr(int.Parse(_yy), int.Parse(_seq), _nobr);
        EFFDS.EMPINFODataTableRow row = DataClass.getEmpInfo(_nobr, DataClass.getEffsAttendStdDate(int.Parse(_yy), int.Parse(_seq)).ToShortDateString());
        HRDS.DeptAMangDataTableDataTable deptadt = DataClass.getempMang(row.DEPTM, row.MANG, DateTime.Now.ToShortDateString());

        DataTable dt = new DataTable();
        dt.Columns.Add("nobr");
        dt.Columns.Add("name");
        dt.Columns.Add("type");
        dt.Columns.Add("adate");

        DataRow selfrow = dt.NewRow();
        selfrow["nobr"] = row.NOBR;
        selfrow["name"] = row.NAME_C;
        selfrow["type"] = "自評";
        selfrow["adate"] = DataClass.getSendEffsTime(int.Parse(_yy), int.Parse(_seq), _nobr, _nobr);
        dt.Rows.Add(selfrow);
        
        for (int i = 0; i < assdt.Rows.Count; i++)
        {
            DataRow mangrow = dt.NewRow();
            EFFDS.EMPINFODataTableRow assrow = DataClass.getEmpInfo(assdt[i].assignnobr, DataClass.getEffsAttendStdDate(int.Parse(_yy), int.Parse(_seq)).ToShortDateString());
            if (assrow != null)
            {
                mangrow["nobr"] = assrow.NOBR;
                mangrow["name"] = assrow.NAME_C;
                mangrow["type"] = "非直線主管";
                mangrow["adate"] = DataClass.getSendEffsTime(int.Parse(_yy), int.Parse(_seq), _nobr, assrow.NOBR);
                dt.Rows.Add(mangrow);
            }
        }
        for (int i = 0; i < deptadt.Rows.Count; i++) 
        {
            DataRow mangrow = dt.NewRow();
            mangrow["nobr"] = deptadt[i].NOBR;
            mangrow["name"] = deptadt[i].NAME_C;
            mangrow["type"] = "直線主管";
            mangrow["adate"] = DataClass.getSendEffsTime(int.Parse(_yy), int.Parse(_seq), _nobr, deptadt[i].NOBR);
            dt.Rows.Add(mangrow);
        }

       





      



    }
    int itemIndex = 0;
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            if (itemIndex == 0)
            {
                HtmlTable ht = (HtmlTable)e.Item.FindControl("TABLE2");
                ht.Visible = true;
            }
            itemIndex++;

        }
    }
}
