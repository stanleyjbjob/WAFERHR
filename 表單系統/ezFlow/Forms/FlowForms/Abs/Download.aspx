<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Download.aspx.cs" Inherits="Abs_Download" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>請假單---檔案下載</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td class="UltraWebGrid1-hc" nowrap="nowrap">
                    上傳請假相關證明文件</td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:GridView ID="gvUpload" runat="server" AllowSorting="True"
                        AutoGenerateColumns="False" CellPadding="4" DataSourceID="sdsUpload" ForeColor="#333333"
                        GridLines="None" OnRowCommand="gvUpload_RowCommand" PageSize="5" Width="100%">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemStyle Width="1%" Wrap="False" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                        CommandName="Download" Text="下載"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sFromName" HeaderText="sFromName" SortExpression="sFromName"
                                Visible="False" />
                            <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                Visible="False" />
                            <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                Visible="False" />
                            <asp:BoundField DataField="sNobr" HeaderText="sNobr" SortExpression="sNobr" Visible="False" />
                            <asp:BoundField DataField="sUpName" HeaderText="檔名" SortExpression="sUpName" />
                            <asp:BoundField DataField="sType" HeaderText="檔案類別" SortExpression="sType" />
                            <asp:BoundField DataField="iSize" HeaderText="檔案大小(KB)" SortExpression="iSize" />
                            <asp:BoundField DataField="sServerName" HeaderText="sServerName" SortExpression="sServerName"
                                Visible="False" />
                            <asp:BoundField DataField="sDesc" HeaderText="簡介" SortExpression="sDesc" />
                            <asp:BoundField DataField="dUpDate" HeaderText="上傳時間" SortExpression="dUpDate" />
                        </Columns>
                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            目前沒有任何附件上傳。
                        </EmptyDataTemplate>
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsUpload" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        DeleteCommand="DELETE FROM [wfUpFile] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfUpFile] WHERE (([sProcessID] = @sProcessID) AND ([sNobr] = @sNobr))">
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label><asp:Label
                        ID="lblNobr" runat="server" Visible="False">00000</asp:Label></td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
