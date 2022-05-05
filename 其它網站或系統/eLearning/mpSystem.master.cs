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
using System.IO;

using CustomSecurity;

public partial class mpSystem : System.Web.UI.MasterPage
{
    private SysDSTableAdapters.sysLoginTimeTableAdapter sysLoginTimeTA = new SysDSTableAdapters.sysLoginTimeTableAdapter();
    private SysDSTableAdapters.sysFileStructureTableAdapter sysFileStructureTA = new SysDSTableAdapters.sysFileStructureTableAdapter();
    private SysDSTableAdapters.sysCustomerDataTableAdapter sysCustomerDataTA = new SysDSTableAdapters.sysCustomerDataTableAdapter();

    private SysDSTableAdapters.hrEmpBaseTableAdapter hrEmpBaseTA = new SysDSTableAdapters.hrEmpBaseTableAdapter();

    private SysDS oSysDS;

    private SysDS.sysFileStructureRow rfs;

    private DataRow[] rows;

    private TreeNode tn;
    private int RoleKey;
    private int RoleID;
    private FileInfo fi;

    public string Msg
    {
        get { return lblMsg.Text; }
        set { lblMsg.Text = value; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        ltModalProgress.Text = "<script type='text/javascript' language='javascript'>var ModalProgress = '" + ModalProgress.ClientID + "';</script>";

        lblUserName.Text = ((CustomIdentity)Context.User.Identity).UserFullName;
        SetMyData(((CustomIdentity)Context.User.Identity).Name);

        RoleID = Convert.ToInt32(((CustomIdentity)Context.User.Identity).UserRole);
        lbtnLearning.Visible = LoginCS.IsAuth(lbtnLearning.ToolTip, RoleID);
        lbtnManage.Visible = LoginCS.IsAuth(lbtnManage.ToolTip, RoleID);
        lbtnTest.Visible = LoginCS.IsAuth(lbtnTest.ToolTip, RoleID);

        this.Page.Title = LoginCS.GetPageTitle(Request.Path.Substring(Request.Path.LastIndexOf("/") + 1, (Request.Path.Length - (Request.Path.LastIndexOf("/") + 1))));

        oSysDS = new SysDS();
        sysFileStructureTA.Fill(oSysDS.sysFileStructure);

        if (!IsPostBack)
            SetRootValues("RootStart");

        object o = this.Page;
    }

    private void SetMyData(string sID)
    {
        rows = sysLoginTimeTA.GetData().Select("sysLoginUser_sUserID = '" + sID + "'", "dLoginTime DESC");
        if (rows.Length > 1)
        {
            SysDS.sysLoginTimeRow rl = rows[1] as SysDS.sysLoginTimeRow;
            lblIP.Text = rl.sLoginIP;
            lblDateTime.Text = rl.dLoginTime.ToString();
        }
    }

    //功能向下展開(起點)
    private void SetRootValues(string Root)
    {
        rows = oSysDS.sysFileStructure.Select("sParentKey = '" + Root + "'", "iOrder");

        if (rows.Length == 1)
        {
            rfs = (SysDS.sysFileStructureRow)rows[0];
            tn = new TreeNode();
            tn.Text = rfs.sFileTitle;
            tn.Value = rfs.sKey;
            tn.Target = rfs.IssFileNameNull() ? Page.Request.ApplicationPath + "/sysRoot.aspx" : (rfs.IssPathNull() ? Page.Request.ApplicationPath + "/" : rfs.sPath) + rfs.sFileName;
            tn.ToolTip = rfs.sDescription;
            tn.ImageToolTip = rfs.sysRole_iKey.ToString();
            tn.ExpandAll();

            tv.Nodes.Clear();
            tv.Nodes.Add(tn);

            SetNodeValues(tn);
            NodeSet(tv.Nodes[0]);

            if (Session["SelectedNode"] != null)
            {
                tn = (TreeNode)Session["SelectedNode"];
                tv.FindNode(tn.ValuePath).Selected = true;
            }
        }
    }

    //功能向下展開
    private void SetNodeValues(TreeNode NodeP)
    {
        rows = oSysDS.sysFileStructure.Select("sParentKey = '" + NodeP.Value + "'", "iOrder");
        foreach (SysDS.sysFileStructureRow r in rows)
        {
            tn = new TreeNode();
            tn.Text = r.sFileTitle;
            tn.Value = r.sKey;
            tn.Target = r.IssFileNameNull() ? "/sysRoot.aspx" : (r.IssPathNull() ? "/" : r.sPath) + r.sFileName;
            tn.ToolTip = r.sDescription;
            tn.ImageToolTip = r.sysRole_iKey.ToString();

            NodeP.ChildNodes.Add(tn);
            SetNodeValues(tn);
        }
    }

    //每個節點的設定
    private void NodeSet(TreeNode NodeP)
    {
        foreach (TreeNode P in NodeP.ChildNodes)
        {
            RoleKey = int.Parse(P.ImageToolTip);
            P.SelectAction = TreeNodeSelectAction.None;
            fi = new FileInfo(Request.PhysicalApplicationPath + P.Target);	//檢查檔案是否存在
            P.Target = Page.Request.ApplicationPath + P.Target;

            rows = oSysDS.sysFileStructure.Select("sParentKey = '" + P.Value + "'", "iOrder");

            if (rows.Length > 0)
            {	//將所有父節點加上有多少子節點
                P.Text = P.Text + "(" + rows.Length.ToString() + ")";
            }
            else if (!fi.Exists)
            {	//判斷網頁檔案不存在
                P.Text = "<font color='Gainsboro'>" + P.Text + "</font>";
            }
            else if (RoleKey == 0 || !((RoleKey & RoleID) == RoleID))
            {
                //權限不足
                P.Text = "<font color='Red'>" + P.Text + "</font>";
            }
            else
            {
                P.SelectAction = TreeNodeSelectAction.Select;
            }

            NodeSet(P);
        }
    }

    protected void tv_SelectedNodeChanged(object sender, EventArgs e)
    {
        TreeNode SelectedNode = tv.SelectedNode;
        Session["SelectedNode"] = tv.SelectedNode;

        Response.Redirect(SelectedNode.Target);
    }
}