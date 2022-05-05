<%@ Page Language="C#" AutoEventWireup="true" CodeFile="login.aspx.cs" Inherits="login" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>合晶科技績效考核系統（Web版）v1.0</title>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" width="100%" cellspacing="0" cellpadding="0" height="100%" id="table1">
	<tr>
		<td align="center" valign="middle">
		<table class="login" border="0" width="580" cellspacing="0" cellpadding="0" id="table2">
			<tr>
				<td class="logintitle">
				</td>
			</tr>
			<tr>
				<td align="center">
				<table border="0" width="460" id="table3">
					<tr>
						<td rowspan="3" align="center" valign="top"><asp:Image ID="Image1" runat="server" SkinID="LoginIcon" /></td>
						<td align="right"><asp:Label ID="Label1" runat="server" Text="帳號："></asp:Label></td>
						<td><asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="TextBox1"
                                Display="Dynamic" ErrorMessage="*不能空白">*不能空白</asp:RequiredFieldValidator></td>
					</tr>
					<tr>
						<td align="right"><asp:Label ID="Label2" runat="server" Text="密碼："></asp:Label></td>
						<td><asp:TextBox ID="TextBox2" runat="server" TextMode="Password"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox2"
                                Display="Dynamic" ErrorMessage="*不能空白">*不能空白</asp:RequiredFieldValidator></td>
					</tr>
					<tr>
						<td align="right">
                            </td>
						<td>
                            <asp:Button ID="Button1" runat="server" Text="登入" OnClick="Button1_Click" /></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="loginend">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
    </form>
</body>
</html>
