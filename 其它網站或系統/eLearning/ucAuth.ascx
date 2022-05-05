<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucAuth.ascx.cs" Inherits="ucAuth" %>
<table cellpadding="0" cellspacing="0" width="100%" class="TableFullBorder">
    <tr>
        <th align="center" nowrap="nowrap" style="width: 1%">
            未<br />
            加<br />
            入</th>
        <td align="center" colspan="4" nowrap="nowrap">
            <asp:ListBox ID="lbU" runat="server" Height="200px" SelectionMode="Multiple" Width="100%" Font-Names="細明體" AppendDataBoundItems="True">
            </asp:ListBox>&nbsp;
        </td>
    </tr>
    <tr>
        <td align="center" nowrap="nowrap" style="width: 1%">
        </td>
        <td align="center" nowrap="nowrap">
            <asp:Button ID="btnDA" runat="server" CausesValidation="False" CommandArgument="1"
                CommandName="D" OnCommand="btnDU_Command" Text="↓↓↓" OnClientClick="return confirm('您確定全部要移過去？');" Font-Names="細明體" /></td>
        <td align="center" nowrap="nowrap">
            <asp:Button ID="btnD" runat="server" CausesValidation="False" CommandArgument="0"
                CommandName="D" OnCommand="btnDU_Command" Text="　↓　" Font-Names="細明體" /></td>
        <td align="center" nowrap="nowrap">
            <asp:Button ID="btnU" runat="server" CausesValidation="False" CommandArgument="0"
                CommandName="U" OnCommand="btnDU_Command" Text="　↑　" Font-Names="細明體" /></td>
        <td align="center" nowrap="nowrap">
            <asp:Button ID="btnUA" runat="server" CausesValidation="False" CommandArgument="1"
                CommandName="U" OnCommand="btnDU_Command" Text="↑↑↑" OnClientClick="return confirm('您確定全部要移過去？');" Font-Names="細明體" /></td>
    </tr>
    <tr>
        <th align="center" nowrap="nowrap" style="width: 1%">
            已<br />
            加<br />
            入</th>
        <td align="center" colspan="4" nowrap="nowrap">
            <asp:ListBox ID="lbD" runat="server" Height="200px" SelectionMode="Multiple" Width="100%" Font-Names="細明體" AppendDataBoundItems="True">
            </asp:ListBox></td>
    </tr>
</table>

