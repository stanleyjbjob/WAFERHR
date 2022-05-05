<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="sysActionRecord.aspx.cs" Inherits="sysActionRecord" Title="Untitled Page" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <table cellpadding="0" cellspacing="0" width="100%">
        <tr>
            <td nowrap="nowrap">
            </td>
        </tr>
        <tr>
            <td>
                <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="iAutoKey" DataSourceID="sdsGV" OnRowDataBound="gv_RowDataBound" Width="100%">
                    <RowStyle HorizontalAlign="Center" Wrap="True" />
                    <Columns>
                        <asp:BoundField DataField="sIP" HeaderText="IP位置" SortExpression="sIP" />
                        <asp:BoundField DataField="sysLoginUser_sUserID" HeaderText="登錄帳號" SortExpression="sysLoginUser_sUserID" />
                        <asp:BoundField DataField="sType" HeaderText="動作類型" SortExpression="sType" />
                        <asp:TemplateField HeaderText="記錄" SortExpression="sRecord">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sRecord") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblRecord" runat="server" Text='<%# Bind("sRecord") %>'></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="dKeyDate" HeaderText="記錄日期時間" SortExpression="dKeyDate" />
                    </Columns>
                    <EmptyDataTemplate>
                        目前沒有資料。
                    </EmptyDataTemplate>
                    <HeaderStyle HorizontalAlign="Center"
                        Wrap="False" />
                </asp:GridView>
                <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                    SelectCommand="SELECT * FROM [sysActionRecord]"></asp:SqlDataSource>
            </td>
        </tr>
        <tr>
            <td nowrap="nowrap">
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
        </tr>
    </table>
</asp:Content>
