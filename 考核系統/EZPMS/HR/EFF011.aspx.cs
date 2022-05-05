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

public partial class HR_EFF011 : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack) {
            getDeptTreeData();

            lb_adate.Text = DateTime.Now.ToShortDateString();
            GridView3.DataSourceID = "ObjectDataSource4";
        }

    }
    protected void Menu1_MenuItemClick(object sender, MenuEventArgs e)
    {
        MultiView1.ActiveViewIndex = int.Parse(e.Item.Value);
    }
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        e.Values["KEY_DATE"] = DateTime.Parse( DateTime.Now.ToShortDateString());
        e.Values["KEY_MAN"] = " ";
        e.Values["OLD_DEPT"] = " ";
    }
    protected void FormView1_ItemUpdated(object sender, FormViewUpdatedEventArgs e)
    {
        getDeptTreeData();
    }
    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        e.NewValues["KEY_DATE"] = DateTime.Parse(DateTime.Now.ToShortDateString());

        e.NewValues["KEY_MAN"] = " ";
        e.NewValues["OLD_DEPT"] = " ";
    }
    protected void FormView1_ItemInserted(object sender, FormViewInsertedEventArgs e)
    {
        getDeptTreeData();
    }
    protected void DropDownList1_DataBound(object sender, EventArgs e)
    {
       
    }
    protected void DropDownList2_DataBound(object sender, EventArgs e)
    {
    }
    protected void View1_DataBinding(object sender, EventArgs e)
    {

    }
    protected void DropDownList1_DataBinding(object sender, EventArgs e)
    {
       
    }
    protected void DropDownList2_DataBinding(object sender, EventArgs e)
    {
      
    }
    public void getDeptTreeData() {
        TreeView1.Nodes.Clear();
        TreeNode treeroot = new TreeNode();
        treeroot.Text = "公司組織";
        treeroot.Value = "All";
        TreeView1.ExpandDepth = 3;

        if (RB_DEPT.Checked)
        {
            HRDSTableAdapters.DEPTTableAdapter deptad = new HRDSTableAdapters.DEPTTableAdapter();
            HRDS.DEPTDataTable deptdt = deptad.GetDataByGroupDept(String.Empty);
            HRDS.DEPTDataTable deptAllDt = deptad.GetData();
            for (int i = 0; i < deptdt.Rows.Count; i++)
            {
                TreeNode nodes = new TreeNode();
                nodes.Text = deptdt[i].D_NAME;
                nodes.Value = deptdt[i].D_NO;

                setDeptTreeNodes(nodes, deptAllDt);
                treeroot.ChildNodes.Add(nodes);

            }


        }
        else
        {
            HRDSTableAdapters.DEPTATableAdapter deptad = new HRDSTableAdapters.DEPTATableAdapter();
            HRDS.DEPTADataTable deptdt = deptad.GetDataByGroupDept(String.Empty);
            HRDS.DEPTADataTable deptAllDt = deptad.GetData();
            for (int i = 0; i < deptdt.Rows.Count; i++)
            {
                TreeNode nodes = new TreeNode();
                nodes.Text = deptdt[i].D_NAME;
                nodes.Value = deptdt[i].D_NO;

                setTreeNodes(nodes, deptAllDt);
                treeroot.ChildNodes.Add(nodes);

            }


        }
        TreeView1.Nodes.Add(treeroot);
       
    }

    public void setDeptTreeNodes(TreeNode p_node, HRDS.DEPTDataTable deptAllDt)
    {
        HRDS.DEPTRow[] depts = (HRDS.DEPTRow[])deptAllDt.Select("DEPT_GROUP='" + p_node.Value + "'");
        for (int i = 0; i < depts.Length; i++)
        {
            TreeNode nodes = new TreeNode();
            nodes.Text = depts[i].D_NAME;
            nodes.Value = depts[i].D_NO;

            setDeptTreeNodes(nodes, deptAllDt);
            p_node.ChildNodes.Add(nodes);
        }
    }

    public void setTreeNodes(TreeNode p_node, HRDS.DEPTADataTable deptAllDt) {
        HRDS.DEPTARow[] depts = (HRDS.DEPTARow[])deptAllDt.Select("DEPT_GROUP='" + p_node.Value + "'");
        for (int i = 0; i < depts.Length; i++) 
        {
            TreeNode nodes = new TreeNode();
            nodes.Text = depts[i].D_NAME;
            nodes.Value = depts[i].D_NO;
           
            setTreeNodes(nodes, deptAllDt);
            p_node.ChildNodes.Add(nodes);
        }
    }
    protected void Button3_Click(object sender, EventArgs e) {
        getDeptTreeData();
        GridView3.DataBind();
    }
    protected void RB_DEPT_CheckedChanged(object sender, EventArgs e)
    {
        if (RB_DEPT.Checked)
        {
            getDeptTreeData();
            GridView3.DataSourceID = "ObjectDataSource4";
            
        }
        else 
        {
            getDeptTreeData();
            GridView3.DataSourceID = "ObjectDataSource3";
        }
        GridView3.DataBind();
    }
}
