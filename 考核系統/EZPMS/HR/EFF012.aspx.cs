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

public partial class HR_EFF012 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
     //       Label1.Text = "Default.aspx";
        
        }
    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {

    }
    protected void Menu1_MenuItemClick1(object sender, MenuEventArgs e)
    {
        EFFMANGDSTableAdapters.EFFS_NOTETableAdapter notead = new EFFMANGDSTableAdapters.EFFS_NOTETableAdapter();
        EFFMANGDS.EFFS_NOTEDataTable notedt = notead.GetDataByApp(e.Item.Value);
        if (notedt.Rows.Count == 0) {
            notedt.AddEFFS_NOTERow(e.Item.Value, "");
            notead.Update(notedt);
        }
        Label1.Text = e.Item.Value;
        title.Text = e.Item.Text;
    }
}
