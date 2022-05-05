<%@ Page Title="" Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true" CodeFile="rpLoginView.aspx.cs" Inherits="rpLoginView" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    <table style="width: 100%">
        <tr>
            <td>
                <asp:Button ID="btnExport" runat="server" onclick="btnExport_Click" Text="匯出" />
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" 
                    AutoGenerateColumns="False" DataKeyNames="iAutoKey" DataSourceID="sdsGV" 
                    onrowdatabound="gv_RowDataBound" PageSize="20" ondatabound="gv_DataBound">
                    <Columns>
                        <asp:TemplateField HeaderText="登入工號" SortExpression="sysLoginUser_sUserID">
                            <ItemTemplate>
                                <asp:Label ID="lblNobr" runat="server" 
                                    Text='<%# Bind("sysLoginUser_sUserID") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="姓名">
                            <ItemTemplate>
                                <asp:Label ID="lblName" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="sLoginIP" HeaderText="IP位置" 
                            SortExpression="sLoginIP" />
                        <asp:CheckBoxField DataField="bLoginSuccess" HeaderText="登入成功" 
                            SortExpression="bLoginSuccess" />
                        <asp:BoundField DataField="dLoginTime" HeaderText="登入時間" 
                            SortExpression="dLoginTime" />
                        <asp:BoundField DataField="dLogoutTime" HeaderText="登出時間" 
                            SortExpression="dLogoutTime" />
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGV" runat="server" 
                    ConnectionString="<%$ ConnectionStrings:eLearning %>" 
                    SelectCommand="SELECT * FROM [sysLoginTime]"></asp:SqlDataSource>
            </td>
        </tr>
    </table>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphR" Runat="Server">
</asp:Content>

