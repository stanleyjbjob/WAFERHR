<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ErrorPage.aspx.cs" Inherits="error" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>�X������Z�ĦҮ֨t�Ρ]Web���^v1.0</title>
</head>
<body>
    <form id="form1" runat="server">
    <table border="0" width="100%" cellspacing="0" cellpadding="0" height="100%" id="table1">
	<tr>
		<td align="center" valign="middle">
		<table class="error" border="0" width="580" cellspacing="0" cellpadding="0" id="table2">
			<tr>
				<td class="errortitle">
				</td>
			</tr>
			<tr>
				<td align="center">
				<table border="0" width="460" id="table3">
					<tr>
						<td rowspan="3" align="center" valign="top"><asp:Image ID="Image1" runat="server" SkinID="errorIcon" /></td>
						<td align="right">
                            �{�����|�G&nbsp;</td>
						<td>&nbsp;<asp:Label ID="lb_strSource" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td align="right">
                            ���~����G&nbsp;</td>
						<td>&nbsp;<asp:Label ID="lb_strCode" runat="server"></asp:Label></td>
					</tr>
					<tr>
						<td align="right">
                            ���~�T���G&nbsp;</td>
						<td>
                            &nbsp;<asp:Label ID="lb_strMsg" runat="server"></asp:Label></td>
					</tr>
				</table>
				</td>
			</tr>
			<tr>
				<td class="errorend">
				</td>
			</tr>
		</table>
		</td>
	</tr>
</table>
    </form>
</body>
</html>
