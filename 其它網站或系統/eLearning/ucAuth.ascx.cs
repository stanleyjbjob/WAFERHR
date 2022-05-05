using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Collections.Generic;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

public partial class ucAuth : System.Web.UI.UserControl  
{
    public event CommandEventHandler mpeCommandEvent;

    public void SetListBox(List<ListItem> llU, List<ListItem> llD)
    {
        lbU.Items.Clear();
        lbD.Items.Clear();

        lbU.Items.AddRange(llU.ToArray());
        lbD.Items.AddRange(llD.ToArray());
    }

    public ListBox GetListBox()
    {
        return lbD;
    }

    protected void Page_Load(object sender, EventArgs e) { }

    protected void btnDU_Command(object sender, CommandEventArgs e)
    {
        string cn = e.CommandName;
        string ca = e.CommandArgument.ToString();
        bool isAll = ca == "1";

        if (cn == "D")
            lbTOlb(lbU, lbD, isAll, "+");
        else if (cn == "U")
            lbTOlb(lbD, lbU, isAll, "-");

        if (mpeCommandEvent != null)
            this.mpeCommandEvent(this, e);
    }

    /// <summary>
    /// ListBox從A到B
    /// </summary>
    /// <param name="lbF">原本</param>
    /// <param name="lbT">目的</param>
    /// <param name="isAll">是否全部</param>
    /// <param name="cal">加減項</param>
    public void lbTOlb(ListBox lbF, ListBox lbT, bool isAll, string cal)
    {
        foreach (ListItem li in lbF.Items)
        {
            li.Selected = isAll ? isAll : li.Selected;
            if (li.Selected && (!lbT.Items.Contains(li)))
                lbT.Items.Add(li);
        }

        foreach (ListItem li in lbT.Items)
            if (lbF.Items.Contains(li))
                lbF.Items.Remove(li);
    }
}
