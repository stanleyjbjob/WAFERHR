<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Rep007.aspx.cs" Inherits="Reports_Rep007" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>查詢條件</legend>
        <asp:DropDownList ID="dll_attend" runat="server" DataSourceID="SqlDataSource1" DataTextField="Desc"
            DataValueField="keyValue">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT CONVERT (char(4), yy) + ',' + CONVERT (char(2), seq) AS keyValue, [Desc] FROM EFFS_ATTEND ORDER BY yy desc, seq desc">
        </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT CONVERT (char(4), yy) + ',' + CONVERT (char(2), seq) AS keyValue, [Desc] FROM EFFS_ATTEND ORDER BY yy desc, seq desc">
        </asp:SqlDataSource>
       <asp:Label id="Label1" runat="server" Text="年度：" Visible="False"></asp:Label><asp:TextBox id="tb_year" runat="server" Width="53px" Visible="False"></asp:TextBox><asp:Label id="Label2" runat="server" Text="期數：" Visible="False"></asp:Label><asp:TextBox id="tb_seq" runat="server" Width="42px" Visible="False"></asp:TextBox> <asp:Label ID="Label3" runat="server" Text="部門："></asp:Label><asp:DropDownList ID="DropDownList1"
            runat="server" DataSourceID="DeptMDataSource1" DataTextField="D_NAME" DataValueField="D_NO" OnDataBound="DropDownList1_DataBound">
        </asp:DropDownList><asp:ObjectDataSource ID="DeptMDataSource1" runat="server" DeleteMethod="Delete"
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
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="匯出Excel" />&nbsp;<br />
        &nbsp;
    </fieldset>
    &nbsp;
    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataKeyNames="nobr"
       OnRowDataBound="GridView7_RowDataBound" ShowFooter="True">
        <Columns>
            <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="jobl" />
            <asp:BoundField DataField="nobr" HeaderText="工號" SortExpression="nobr" />
            <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
            <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
            <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
            <asp:BoundField DataField="b_year" HeaderText="年齡" SortExpression="JOBNAME" />
            <asp:BoundField DataField="o_year" HeaderText="年資" SortExpression="JOBNAME" />
               <asp:BoundField DataField="effu1" HeaderText="職稱"  />
               <asp:BoundField DataField="effu2" HeaderText="職稱" />
               <asp:BoundField DataField="effu3" HeaderText="職稱"  />
               <asp:BoundField DataField="effu4" HeaderText="職稱"  />
               <asp:BoundField DataField="effu5" HeaderText="職稱" />
               <asp:BoundField DataField="effu6" HeaderText="職稱" />
               <asp:BoundField DataField="up_date1" HeaderText="日期" Visible="False"  />
               <asp:BoundField DataField="up_jobl1" HeaderText="職等" Visible="False"  />
               <asp:BoundField DataField="up_date2" HeaderText="日期" Visible="False"  />
               <asp:BoundField DataField="up_jobl2" HeaderText="職等" Visible="False"  />
               <asp:BoundField DataField="up_date3" HeaderText="日期" Visible="False"  />
               <asp:BoundField DataField="up_jobl3" Visible="False"  />
        </Columns>
    </asp:GridView>
</asp:Content>

