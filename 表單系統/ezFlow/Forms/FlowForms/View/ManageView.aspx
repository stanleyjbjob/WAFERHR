<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ManageView.aspx.cs" Inherits="View_ManageView" %>

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
                <td nowrap="nowrap">
                    <table cellpadding="0" cellspacing="0">
                        <tr>
                            <td>
                                表單</td>
                            <td>
                                <asp:DropDownList ID="DropDownList1" runat="server">
                                </asp:DropDownList></td>
                            <td>
                                流程序</td>
                            <td>
                                <asp:TextBox ID="txtProcessID" runat="server"></asp:TextBox></td>
                            <td>
                                工號</td>
                            <td>
                                <asp:TextBox ID="txtNobr" runat="server"></asp:TextBox></td>
                            <td>
                                <asp:Button ID="btnSearch" runat="server" Text="查詢" /></td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:Menu ID="mu" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2"
                        Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" Orientation="Horizontal"
                        StaticSubMenuIndent="10px">
                        <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                        <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
                        <DynamicMenuStyle BackColor="#B5C7DE" />
                        <StaticSelectedStyle BackColor="#507CD1" />
                        <DynamicSelectedStyle BackColor="#507CD1" />
                        <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                        <Items>
                            <asp:MenuItem Selected="True" Text="全部" Value="a"></asp:MenuItem>
                            <asp:MenuItem Text="簽核中" Value="1"></asp:MenuItem>
                            <asp:MenuItem Text="已駁回" Value="2"></asp:MenuItem>
                            <asp:MenuItem Text="簽核完成" Value="3"></asp:MenuItem>
                            <asp:MenuItem Text="已刪除" Value="4"></asp:MenuItem>
                            <asp:MenuItem Text="尚未送出" Value="0"></asp:MenuItem>
                        </Items>
                        <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                    </asp:Menu>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap">
                    <asp:GridView ID="gv" runat="server">
                    </asp:GridView>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
