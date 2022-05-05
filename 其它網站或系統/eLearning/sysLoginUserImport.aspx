<%@ Page Language="C#" AutoEventWireup="true" CodeFile="sysLoginUserImport.aspx.cs" Inherits="sysLoginUserImport" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:Menu ID="mu" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2"
            Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" Orientation="Horizontal"
            StaticSubMenuIndent="10px" OnMenuItemClick="mu_MenuItemClick">
            <StaticSelectedStyle BackColor="#507CD1" />
            <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
            <DynamicMenuStyle BackColor="#B5C7DE" />
            <DynamicSelectedStyle BackColor="#507CD1" />
            <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
            <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
            <Items>
                <asp:MenuItem Text="選擇檔案 &gt; " Value="0" Selected="True"></asp:MenuItem>
                <asp:MenuItem Text="選擇工作表 &gt; " Value="1"></asp:MenuItem>
                <asp:MenuItem Text="選擇欄位 &gt; " Value="2"></asp:MenuItem>
                <asp:MenuItem Text="其它選項 &gt; " Value="3"></asp:MenuItem>
                <asp:MenuItem Text="確定匯入 &gt; " Value="4"></asp:MenuItem>
                <asp:MenuItem Text="匯入完成" Value="5"></asp:MenuItem>
            </Items>
        </asp:Menu>
        <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <asp:FileUpload ID="fu" runat="server" />&nbsp;<asp:Button ID="btnUpload" runat="server"
                    OnClick="btnUpload_Click" Text="下一步" /></asp:View>
            <asp:View ID="View2" runat="server">
                <asp:DropDownList ID="ddlSheet" runat="server" ToolTip="Sheet1">
                </asp:DropDownList>
                <asp:Button ID="btnSheet" runat="server" OnClick="btnSheet_Click" Text="下一步" /></asp:View>
            <asp:View ID="View3" runat="server">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td align="center" nowrap="nowrap">
                            對應</td>
                        <td align="center" nowrap="nowrap">
                            帳號/工號</td>
                        <td align="center" nowrap="nowrap">
                            中文姓名</td>
                        <td align="center" nowrap="nowrap">
                            身份證</td>
                        <td align="center" nowrap="nowrap">
                            生日</td>
                        <td align="center" nowrap="nowrap">
                            性別</td>
                        <td align="center" nowrap="nowrap">
                            電話</td>
                        <td align="center" nowrap="nowrap">
                            電子信箱</td>
                    </tr>
                    <tr>
                        <td align="center" nowrap="nowrap">
                            匯入</td>
                        <td align="center" nowrap="nowrap">
                            <asp:DropDownList ID="ddlNobr" runat="server" ToolTip="帳號">
                            </asp:DropDownList></td>
                        <td align="center" nowrap="nowrap">
                            <asp:DropDownList ID="ddlName" runat="server" ToolTip="中文姓名">
                            </asp:DropDownList></td>
                        <td align="center" nowrap="nowrap">
                            <asp:DropDownList ID="ddlKey" runat="server" ToolTip="身份證">
                            </asp:DropDownList></td>
                        <td align="center" nowrap="nowrap">
                            <asp:DropDownList ID="ddlBirthday" runat="server" ToolTip="生日">
                            </asp:DropDownList></td>
                        <td align="center" nowrap="nowrap">
                            <asp:DropDownList ID="ddlSex" runat="server" ToolTip="性別">
                            </asp:DropDownList></td>
                        <td align="center" nowrap="nowrap">
                            <asp:DropDownList ID="ddlTel" runat="server" ToolTip="電話">
                            </asp:DropDownList></td>
                        <td align="center" nowrap="nowrap">
                            <asp:DropDownList ID="ddlEmail" runat="server" ToolTip="電子信箱">
                            </asp:DropDownList></td>
                    </tr>
                    <tr>
                        <td colspan="8" nowrap="nowrap">
                            <asp:Button ID="btnColumns" runat="server" OnClick="btnColumns_Click" Text="下一步" /></td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View4" runat="server">
                <table cellpadding="0" cellspacing="0">
                    <tr>
                        <td nowrap="nowrap">
                            <asp:CheckBox ID="cbFirstChange" runat="server" Text="第一次登入強迫換密碼" /></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            最少<asp:TextBox ID="txtDayChange" runat="server" MaxLength="4" Width="30px">0</asp:TextBox>天換1次密碼<span
                                style="color: blue">(0天表示可永久不用換密碼)</span></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:Button ID="btnOther" runat="server" OnClick="btnOther_Click" Text="下一步" /></td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View5" runat="server">
                <table border="2" cellpadding="2" cellspacing="2" style="width: 100%">
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            上傳檔名</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblFileName" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            工作表名稱</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblSheetText" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right" colspan="2" nowrap="nowrap" style="text-align: center">
                            <strong>對應欄位</strong></td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            帳號/工號</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblNobrText" runat="server"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            密碼</td>
                        <td nowrap="nowrap">
                            預設身份證後6碼</td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            中文姓名</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblNameText" runat="server"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            身份證</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblKeyText" runat="server"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            生日</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblBirthdayText" runat="server"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            性別</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblSexText" runat="server"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            電話</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblTelText" runat="server"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            電子信箱</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblEmailText" runat="server"></asp:Label>
                            </td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            強迫換密碼</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblFirstChange" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td align="right" nowrap="nowrap" width="1%">
                            換密碼天數</td>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblDayChange" runat="server"></asp:Label></td>
                    </tr>
                    <tr>
                        <td colspan="2" nowrap="nowrap">
                            <asp:Button ID="btnImport" runat="server" OnClick="btnImport_Click" Text="確定匯入" OnClientClick="return confirm('您確定要匯入嗎？');" /></td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View6" runat="server">
            </asp:View>
        </asp:MultiView></div>
        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
    </form>
</body>
</html>
