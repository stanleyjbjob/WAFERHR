<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Encode.aspx.cs" Inherits="Manage_Encode" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:FormView ID="fv" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsFV" DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting">
                        <InsertItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td style="text-align: center">
                                        編碼</td>
                                    <td style="text-align: center">
                                        解碼</td>
                                    <td rowspan="2">
                                        <asp:Button ID="Button1" runat="server" CommandName="Insert" Text="新增" /></td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:TextBox ID="sEncodeTextBox" runat="server" Text='<%# Bind("sEncode") %>'></asp:TextBox></td>
                                    <td>
                                        <asp:TextBox ID="sDecodeTextBox" runat="server" Text='<%# Bind("sDecode") %>'></asp:TextBox></td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>" DeleteCommand="DELETE FROM [wfEncode] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfEncode] ([sEncode], [sDecode]) VALUES (@sEncode, @sDecode)" SelectCommand="SELECT * FROM [wfEncode]" UpdateCommand="UPDATE [wfEncode] SET [sEncode] = @sEncode, [sDecode] = @sDecode WHERE [iAutoKey] = @iAutoKey">
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="sEncode" Type="String" />
                            <asp:Parameter Name="sDecode" Type="String" />
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sEncode" Type="String" />
                            <asp:Parameter Name="sDecode" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gv" runat="server" AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsGV" ForeColor="#333333" GridLines="None">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                                        OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sEncode" HeaderText="編碼" SortExpression="sEncode" />
                            <asp:BoundField DataField="sDecode" HeaderText="解碼" SortExpression="sDecode" />
                        </Columns>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <EditRowStyle BackColor="#2461BF" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>" DeleteCommand="DELETE FROM [wfEncode] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfEncode] ([sEncode], [sDecode]) VALUES (@sEncode, @sDecode)" SelectCommand="SELECT * FROM [wfEncode]" UpdateCommand="UPDATE [wfEncode] SET [sEncode] = @sEncode, [sDecode] = @sDecode WHERE [iAutoKey] = @iAutoKey">
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="sEncode" Type="String" />
                            <asp:Parameter Name="sDecode" Type="String" />
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sEncode" Type="String" />
                            <asp:Parameter Name="sDecode" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsg" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td>
                    <asp:TextBox ID="txtCode" runat="server"></asp:TextBox>
                    <asp:Button ID="btnEncode" runat="server" OnClick="btnEncode_Click" Text="編碼" />
                    <asp:Button ID="btnDecode" runat="server" OnClick="btnDecode_Click" Text="解碼" /></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
