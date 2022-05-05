<%@ Control Language="C#" AutoEventWireup="true" CodeFile="AppentCheck.ascx.cs" Inherits="UC_AppentCheck" %>
<asp:DataList id="DataList1" runat="server" DataSourceID="EffsSqlDataSource" OnItemDataBound="DataList1_ItemDataBound" RepeatDirection="Horizontal">
                    <ItemTemplate>
                        <table id="TABLE1" runat="server" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse" id="TABLE2"
                                        runat="server" visible="false">
                                        <tr  Height="20">
                                            <td align="center" style="width: 100px; color: #000000">
                                                <asp:Label ID="Label23" runat="server" Text="姓名"></asp:Label></td>
                                        </tr>
                                        <tr bgcolor="lemonchiffon"  Height="20">
                                            <td align="center" style="width: 100px">
                                                <asp:Label ID="Label21" runat="server" Font-Bold="True" ForeColor="Blue" Text="傳送時間"></asp:Label></td>
                                        </tr>
                                        <tr bgcolor="lemonchiffon"  Height="20">
                                            <td align="center" style="width: 100px">
                                                <asp:Label ID="Label22" runat="server" Font-Bold="True" ForeColor="Blue" Text="類別"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top">
                                    <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse">
                                        <tr  Height="20">
                                            <td align="center" style="width: 100px; color: #000000">
                                                <asp:Label ID="YYMMLabel" runat="server" Height="16px" Text='<%# Eval("name") %>'></asp:Label>&nbsp;
                                            </td>
                                        </tr>
                                        <tr bgcolor="lemonchiffon"  Height="20">
                                            <td align="center" style="width: 100px">
                                                &nbsp;<asp:Label ID="EFFVARLabel" runat="server" Text='<%# Eval("adate") %>'></asp:Label></td>
                                        </tr>
                                        <tr bgcolor="lemonchiffon"  Height="20">
                                            <td align="center" style="width: 100px">
                                                <asp:Label ID="EFFLVLLabel" runat="server" Text='<%# Eval("type") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>