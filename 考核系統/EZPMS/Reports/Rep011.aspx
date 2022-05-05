<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="Rep011.aspx.cs" Inherits="Reports_Rep011" Title="Untitled Page" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>查詢條件</legend>
        <asp:DropDownList ID="dll_attend" runat="server" DataSourceID="SqlDataSource1" DataTextField="Desc"
            DataValueField="keyValue">
        </asp:DropDownList>
        <asp:Label ID="_nobr_" runat="server"></asp:Label>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT CONVERT (char(4), yy) + ',' + CONVERT (char(2), seq) AS keyValue, [Desc] FROM EFFS_ATTEND ORDER BY yy desc, seq desc">
        </asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Text="年度：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_year" runat="server" Visible="False" Width="53px"></asp:TextBox>
        <asp:Label ID="Label2" runat="server" Text="期數：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_seq" runat="server" Visible="False" Width="42px"></asp:TextBox>&nbsp;
        <asp:Label ID="Label3" runat="server" Text="部門："></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DeptMDataSource1"
            DataTextField="D_NAME" DataValueField="D_NO" OnDataBound="DropDownList1_DataBound" Visible="False">
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="匯出Excel" />
        <br />
        <asp:ObjectDataSource ID="DeptMDataSource1" runat="server" DeleteMethod="Delete"
            InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
            TypeName="EFFDSTableAdapters.DEPTATableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_D_NO" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="D_NO" Type="String" />
                <asp:Parameter Name="D_NAME" Type="String" />
                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                <asp:Parameter Name="KEY_MAN" Type="String" />
                <asp:Parameter Name="OLD_DEPT" Type="String" />
                <asp:Parameter Name="ADATE" Type="DateTime" />
                <asp:Parameter Name="DDATE" Type="DateTime" />
                <asp:Parameter Name="DEPT_GROUP" Type="String" />
                <asp:Parameter Name="DEPT_CATE" Type="String" />
                <asp:Parameter Name="Original_D_NO" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="D_NO" Type="String" />
                <asp:Parameter Name="D_NAME" Type="String" />
                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                <asp:Parameter Name="KEY_MAN" Type="String" />
                <asp:Parameter Name="OLD_DEPT" Type="String" />
                <asp:Parameter Name="ADATE" Type="DateTime" />
                <asp:Parameter Name="DDATE" Type="DateTime" />
                <asp:Parameter Name="DEPT_GROUP" Type="String" />
                <asp:Parameter Name="DEPT_CATE" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
        &nbsp;
    </fieldset>
    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2" AllowPaging="True">
        <Columns>
            <asp:BoundField DataField="年度" HeaderText="年度" SortExpression="年度" />
            <asp:BoundField DataField="期別" HeaderText="期別" SortExpression="期別" />
            <asp:BoundField DataField="項目" HeaderText="項目" SortExpression="項目" />
            <asp:BoundField DataField="內容" HeaderText="內容" SortExpression="內容" />
            <asp:BoundField DataField="員工" HeaderText="員工" SortExpression="員工" />
            <asp:BoundField DataField="姓名" HeaderText="姓名" SortExpression="姓名" />
            <asp:BoundField DataField="部門" HeaderText="部門" SortExpression="部門" />
            <asp:BoundField DataField="主管工號" HeaderText="主管工號" SortExpression="主管工號" />
            <asp:BoundField DataField="主管姓名" HeaderText="主管姓名" SortExpression="主管姓名" />
            <asp:BoundField DataField="主管部門" HeaderText="主管部門" SortExpression="主管部門" />
            <asp:BoundField DataField="內容代碼" HeaderText="內容代碼" SortExpression="內容代碼" />
            <asp:BoundField DataField="分數" HeaderText="分數" SortExpression="分數" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
        SelectCommand="SELECT EFFS_MANGAPPRCATE.yy AS 年度, EFFS_MANGAPPRCATE.seq AS 期別, EFFS_CATE.effcateName AS 項目, EFFS_CATEITEM.effsName AS 內容, EFFS_MANGAPPRCATE.nobr AS 員工, BASE.NAME_C AS 姓名, EFFS_BASE.dept AS 部門, EFFS_MANGAPPRCATE.mangnobr AS 主管工號, BASE_1.NAME_C AS 主管姓名, EFFS_MANGAPPRCATE.mangdept AS 主管部門, EFFS_MANGAPPRCATE.apprID AS 內容代碼, EFFS_MANGAPPRCATE.num AS 分數 FROM EFFS_MANGAPPRCATE INNER JOIN BASE ON EFFS_MANGAPPRCATE.nobr = BASE.NOBR INNER JOIN EFFS_CATEITEM ON EFFS_MANGAPPRCATE.apprID = EFFS_CATEITEM.effsID INNER JOIN EFFS_CATE ON EFFS_CATEITEM.effcateID = EFFS_CATE.effcateID INNER JOIN BASE AS BASE_1 ON EFFS_MANGAPPRCATE.mangnobr = BASE_1.NOBR INNER JOIN EFFS_BASE ON EFFS_MANGAPPRCATE.yy = EFFS_BASE.yy AND EFFS_MANGAPPRCATE.seq = EFFS_BASE.seq AND EFFS_MANGAPPRCATE.nobr = EFFS_BASE.nobr WHERE (EFFS_MANGAPPRCATE.yy = @yy) AND (EFFS_MANGAPPRCATE.seq = @seq) ORDER BY 員工, 主管工號">
        <SelectParameters>
            <asp:ControlParameter ControlID="tb_year" Name="yy" PropertyName="Text" />
            <asp:ControlParameter ControlID="tb_seq" Name="seq" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

