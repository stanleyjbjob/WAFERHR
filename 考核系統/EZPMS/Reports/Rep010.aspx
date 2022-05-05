<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="Rep010.aspx.cs" Inherits="Reports_Rep010" Title="Untitled Page" %>
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
            DataTextField="D_NAME" DataValueField="D_NO" OnDataBound="DropDownList1_DataBound">
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
    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource2">
        <Columns>
            <asp:BoundField DataField="工號" HeaderText="工號" SortExpression="工號" />
            <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
            <asp:BoundField DataField="確認時間" HeaderText="確認時間" SortExpression="確認時間" />
            <asp:CheckBoxField DataField="同意" HeaderText="同意" SortExpression="同意" />
            <asp:CheckBoxField DataField="不同意" HeaderText="不同意" SortExpression="不同意" />
            <asp:BoundField DataField="不同意原因" HeaderText="不同意原因" SortExpression="不同意原因" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
        SelectCommand="SELECT EFFS_conf.nobr AS 工號, BASE.NAME_C, EFFS_conf.keydate AS 確認時間, EFFS_conf.acc AS 同意, EFFS_conf.notacc AS 不同意, EFFS_conf.note AS 不同意原因 FROM EFFS_conf INNER JOIN BASE ON EFFS_conf.nobr = BASE.NOBR">
    </asp:SqlDataSource>
</asp:Content>

