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

public partial class test : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
{
if (!IsPostBack) {
LoadProductData();
}
} 

void LoadProductData()
{
DataTable dt = CreateSampleProductData();

GridView1.DataSource = dt;
GridView1.DataBind();
}

protected void GridView1_RowDataBound(object sender, GridViewRowEventArgs e)
{
if (e.Row.RowType == DataControlRowType.DataRow) {
// 插入行
GridViewRow insertedRow = new GridViewRow(-1, -1, DataControlRowType.DataRow, DataControlRowState.Normal);
// 
TableCell cell = new TableCell(); 
insertedRow.Cells.Add(cell);
// 基本属性
cell.ColumnSpan = GridView1.Columns.Count; // 横跨所有列
cell.Text = "&nbsp;";
cell.Width = new Unit(10, UnitType.Pixel);
// 添加自定义内容
Image img = new Image();
img.ImageUrl = "http://community.csdn.net/images/csdn.gif";
cell.Controls.Add(img);
TextBox txt = new TextBox();
txt.Text = ((DataRowView)e.Row.DataItem)["ProductName"].ToString();
cell.Controls.Add(txt);
// ...
// ...
// 默认隐藏此行
insertedRow.Attributes["style"] = "display:none";
// 
GridView1.Controls[0].Controls.Add(insertedRow);
}
}

    #region sample data

    static DataTable CreateSampleProductData()
    {
        DataTable tbl = new DataTable("Products");

        tbl.Columns.Add("ProductID", typeof(int));
        tbl.Columns.Add("ProductName", typeof(string));
        tbl.Columns.Add("UnitPrice", typeof(decimal));
        tbl.Columns.Add("CategoryID", typeof(int));

        tbl.Rows.Add(1, "Chai", 18, 1);
        tbl.Rows.Add(2, "Chang", 19, 1);
        tbl.Rows.Add(3, "Aniseed Syrup", 10, 2);
        tbl.Rows.Add(4, "Chef Anton's Cajun Seasoning", 22, 2);
        tbl.Rows.Add(5, "Chef Anton's Gumbo Mix", 21.35, 2);
        tbl.Rows.Add(47, "Zaanse koeken", 9.5, 3);
        tbl.Rows.Add(48, "Chocolade", 12.75, 3);
        tbl.Rows.Add(49, "Maxilaku", 20, 3);

        return tbl;
    }

    #endregion 

}
