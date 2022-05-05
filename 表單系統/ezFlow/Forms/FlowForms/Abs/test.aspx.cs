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

public partial class Abs_test : System.Web.UI.Page
{
    OtDSTableAdapters.OTTableAdapter OTTA = new OtDSTableAdapters.OTTableAdapter();
    OtDS oOtDS;
    int index = 0;
    int xx = 0;
    protected void Page_Load(object sender, EventArgs e)
    {
        //oOtDS = new OtDS();
        //string d = new DateTime(2008, 5, 13).DayOfWeek.ToString("d");

        //int a = sum(15);

        //OTTA.Fill(oOtDS.OT);

        //OtDS.OTRow r = oOtDS.OT.NewOTRow();
        //SetRowDefaultValue(r);
        DataTable dt = new DataTable();
        dt.Columns.Add("name").DefaultValue = "";
        dt.Columns.Add("desc").DefaultValue = "";
        dt.Columns.Add("type").DefaultValue = "";
        dt.Columns.Add("len").DefaultValue = 0;
        //foreach (DataColumn dc in new JbHrCL.JbHrCL().GetAbs("1043").Columns)
        //{
        //    DataRow r = dt.NewRow();
        //    r["name"] = dc.ColumnName;
        //    r["desc"] = "";
        //    r["type"] = dc.DataType.ToString();
        //    r["len"] = dc.MaxLength;
        //    dt.Rows.Add(r);
        //}

       
        GridView1.DataSource = dt;
        //GridView1.DataSource = new JbHrCL.AbsCS().GetAbsPersonal("1043", DateTime.Now.Date, new DateTime(2008, 1, 1), new DateTime(2008, 12, 31), "3", "4");
        GridView1.DataBind();

        //Label1.Text = new Huaku.MyTest().GetMyName();
        //Label1.Text = setXX(1).ToString();

      AbsCS.AbsCalculation AAA =   AbsCS.CalculationAbs("1024396", "P1", new DateTime(2013, 12, 26).Date, new DateTime(2013, 12, 26).Date, "0830", "1730", "", 8);
    }

    int setXX(int x)
    {
        if (x <= 100)
        {

            return ((x % 3) == 0) ? setXX(x + 1) + x : setXX(x + 1);
        }
        else
            return 0;
    }


    //void setXX(int index   ) 
    //{
    //    index++;
    //    if (index <= 100)
    //    {
    //        if ((index % 3) == 0)
    //        {
    //            xx += index;
    //        }
    //        setXX(index);
    //    }
    //}





    public int sum(int x)
    {
        if (x > 1)
            return x + sum(x / 2);
        else
            return 0;


        
    }

    public void SetRowDefaultValue(DataRow r)
    {
        Type t;
        foreach (DataColumn dc in r.Table.Columns)
        {
            t = dc.DataType;
            r[dc] = (t == typeof(string)) ? "" : r[dc];
            r[dc] = (t == typeof(bool)) ? false : r[dc];
            r[dc] = (t == typeof(decimal)) ? 0 : r[dc];
            r[dc] = (t == typeof(double)) ? 0 : r[dc];
            r[dc] = (t == typeof(DateTime)) ?DateTime.Now.Date : r[dc];
            r[dc] = (t == typeof(int)) ? 0 : r[dc];           
        }
    }


    protected void Button1_Click(object sender, EventArgs e)
    {

        Button1.Text =System.Text.Encoding.Default.GetBytes(TextBox1.Text.Trim().ToString()).Length.ToString();
    }

}
