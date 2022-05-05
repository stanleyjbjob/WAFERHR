<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>ezQuestion</title>
</head>
<body class="LoginPage">
    <form id="form1" runat="server">
    <div align="center">
    <table border="0" width="640" cellpadding="0" style="border-collapse: collapse" id="table1">
		<tr>
			<td>
                <asp:Image ID="Image1" runat="server" SkinID="login_tl1" /></td>
			<td>
                <asp:Image ID="Image2" runat="server" SkinID="login_tc1" /></td>
			<td>
                <asp:Image ID="Image3" runat="server" SkinID="login_tr1" /></td>
		</tr>
		<tr>
			<td>
                <asp:Image ID="Image4" runat="server" SkinID="login_tl2" /></td>
			<td background="App_Themes/smc/images/login_05.gif" style="vertical-align: middle">
			<table border="0" width="100%" cellpadding="4" id="table2">
				<tr>
					<td align="right">帳號：</td>
					<td align="left"><asp:TextBox ID="txtLogin" runat="server" Width="120px"></asp:TextBox>
                        <asp:LinkButton ID="lbID" runat="server" Visible="False" OnClick="lbID_Click">找帳號</asp:LinkButton></td>
				</tr>
				<tr>
					<td align="right">密碼：</td>
					<td align="left"><asp:TextBox ID="txtPass" runat="server" Width="120px" TextMode="Password"></asp:TextBox></td>
				</tr>
				<tr>
					<td align="center">&nbsp;</td>
					<td align="right">
                        <asp:Button ID="Button1" runat="server" Text="登入" /></td>
				</tr>
			</table>
			</td>
			<td>
                <asp:Image ID="Image5" runat="server" SkinID="login_tr2" /></td>
		</tr>
		<tr>
			<td>
                <asp:Image ID="Image6" runat="server" SkinID="login_tl3" /></td>
			<td>
                <asp:Image ID="Image7" runat="server" SkinID="login_tc3" /></td>
			<td>
                <asp:Image ID="Image8" runat="server" SkinID="login_tr3" /></td>
		</tr>
	</table>
    </div>
    <div class="footerLogin"><a href="http://www.jbjob.com.tw/">版權所有©2006 傑報資訊</a>　提醒您，如果您無法正常彈出試窗，請檢查瀏覽器相關設定，如快顯封鎖之類的設定。
</div>
	</form>
</body>
</html>
