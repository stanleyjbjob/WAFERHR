<%@ Page Title="" Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="rpCourseView.aspx.cs" Inherits="rpCourseView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:Button ID="btnExport" runat="server" OnClick="btnExport_Click" Text="匯出" />
    <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
        DataKeyNames="iAutoKey" DataSourceID="sdsView" OnRowDataBound="gv_RowDataBound"
        Width="100%" PageSize="20">
        <RowStyle HorizontalAlign="Center" Wrap="True" />
        <Columns>
            <asp:TemplateField HeaderText="登入帳號" SortExpression="sUserID">
                <ItemTemplate>
                    <asp:Label ID="lblNobr" runat="server" Text='<%# Bind("sUserID") %>'></asp:Label>
                </ItemTemplate>
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sUserID") %>'></asp:TextBox>
                </EditItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="姓名">
                <ItemTemplate>
                    <asp:Label ID="lblName" runat="server"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="sName" HeaderText="課程名稱" SortExpression="sName"></asp:BoundField>
            <asp:BoundField DataField="dDateTimeB" HeaderText="觀看開始時間" SortExpression="dDateTimeB" />
            <asp:BoundField DataField="dDateTimeE" HeaderText="觀看結束時間" SortExpression="dDateTimeE" />
            <asp:BoundField DataField="iTime" HeaderText="總登入時間(秒)" 
                SortExpression="iTime" />
            <asp:BoundField DataField="iView" HeaderText="閱讀次數" SortExpression="iView" />
        </Columns>
        <EmptyDataTemplate>
            目前沒有資料。
        </EmptyDataTemplate>
        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
    </asp:GridView>
    <asp:SqlDataSource ID="sdsView" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
        SelectCommand="SELECT lnView.iAutoKey, lnView.sUserID, lnView.lnCategoryS_sCode, lnView.dDateTimeB, lnView.dDateTimeE, lnView.iTime, lnCategoryS.sName, lnCategoryS.iView FROM lnView INNER JOIN lnCategoryS ON lnView.lnCategoryS_sCode = lnCategoryS.sCode ORDER BY lnView.dDateTimeB DESC">
    </asp:SqlDataSource>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphR" runat="Server">
</asp:Content>
