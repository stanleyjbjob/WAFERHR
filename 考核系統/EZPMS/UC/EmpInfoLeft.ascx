<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EmpInfoLeft.ascx.cs" Inherits="UC_EmpInfoLeft" %>
<fieldset align="left">
			<legend>
                <asp:Label ID="Label1" runat="server" Text="員工資料" ForeColor="Blue"></asp:Label></legend>
			<table width="100%">
			<tr>
			    <td align="left">
			    工號：<asp:Label ID="_nobr" runat="server"></asp:Label><br />
			姓名：<asp:Label ID="_name_c" runat="server"></asp:Label><br />
			職稱：<asp:Label ID="_job" runat="server"></asp:Label><br />
			部門：<asp:Label ID="_dept" runat="server"></asp:Label><br />
			    </td>
			</tr>
			</table>
			
</fieldset>
