<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ChangePW.aspx.cs" Inherits="Salary_ChangePW" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>合晶薪資單更改密碼</title>
</head>
<body style="font-size: 12pt">
    <form id="form1" runat="server">
    <div>
        <table style="font-size: 14pt">
            <tr>
                <td align="right" colspan="2" nowrap="nowrap" style="text-align: left">
                    密碼長度請設定<span style="color: red">4-10</span>個字元</td>
            </tr>
            <tr>
                <td align="right" nowrap="nowrap">
                    工號</td>
                <td nowrap="nowrap">
                    <asp:TextBox ID="txtNobr" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" nowrap="nowrap">
                    身分證字號</td>
                <td nowrap="nowrap">
                    <asp:TextBox ID="txtID" runat="server"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" nowrap="nowrap">
                    <span style="color: red">
                    舊密碼</span></td>
                <td nowrap="nowrap">
                    <asp:TextBox ID="txtOld" runat="server" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" nowrap="nowrap">
                    <span style="color: blue">
                    新密碼</span></td>
                <td nowrap="nowrap">
                    <asp:TextBox ID="txtNew" runat="server" MaxLength="10" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td align="right" nowrap="nowrap">
                    <span style="color: blue">
                    新密碼確認</span></td>
                <td nowrap="nowrap">
                    <asp:TextBox ID="txtNewCheck" runat="server" MaxLength="10" TextMode="Password"></asp:TextBox></td>
            </tr>
            <tr>
                <td colspan="2" nowrap="nowrap" style="text-align: left">
                    <asp:Button ID="btnSubmit" runat="server" OnClientClick="return confirm('您確定要更改密碼嗎？');"
                        Text="更改" OnClick="btnSubmit_Click" />
                    <asp:Label ID="lblMsg" runat="server"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
