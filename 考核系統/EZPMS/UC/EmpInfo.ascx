<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EmpInfo.ascx.cs" Inherits="UC_EmpInfo" %>
<fieldset>
    <legend>員工資料</legend>
    <table style="width: 100%">
        <tr>
            <td style="font-size: 10pt; width: 25%; height: 18px">
                <asp:Label ID="Label1" runat="server" Text="姓名："></asp:Label>
                <asp:Label ID="name_c" runat="server" Text=""></asp:Label></td>
            <td style="font-size: 10pt; width: 20%; color: #000000; height: 18px">
                <asp:Label ID="Label5" runat="server" Text="工號："></asp:Label>
                <asp:Label ID="lb_nobr" runat="server"></asp:Label>
                <asp:Label ID="seq" runat="server" Text="" Visible="False"></asp:Label>
                </td>
            <td style="font-size: 10pt; width: 20%; height: 18px">
              <asp:Label ID="Label4" runat="server" Text="到職日："></asp:Label>  <asp:Label ID="indt" runat="server"></asp:Label>
            </td>
            <td style="font-size: 10pt; width: 20%; height: 18px">
                <asp:Label ID="Label3" runat="server" Text="考核年度："></asp:Label><asp:Label ID="year"
                    runat="server" Text=""></asp:Label></td>
            <td style="font-size: 10pt; width: 20%; height: 18px">
                <asp:Label ID="desc" runat="server" Text=""></asp:Label></td>
        </tr>
        <tr >
            <td style="font-size: 10pt; width: 20%; height: 18px">
                <asp:Label ID="Label2" runat="server" Text="部門："></asp:Label>
                <asp:Label ID="dept" runat="server" Text=""></asp:Label></td>
            <td style="font-size: 10pt; width: 20%; height: 18px">
                <asp:Label ID="Label6" runat="server" Text="成本中心：" Visible="false"></asp:Label>
                <asp:Label ID="deps" runat="server" Text="" Visible="false"></asp:Label></td>
            <td style="font-size: 10pt; width: 20%; height: 18px">
                 <asp:Label ID="Label7" runat="server" Text="職稱："></asp:Label><asp:Label ID="job" runat="server"></asp:Label></td>
            <td style="font-size: 10pt; width: 20%; height: 18px">
                <asp:Label ID="Label8" runat="server" Text="職等："></asp:Label> <asp:Label ID="jobl" runat="server" Text=" "></asp:Label>
                <asp:Label ID="templet" runat="server" Text="" Visible="False"></asp:Label></td>
            <td style="font-size: 10pt; width: 20%; height: 18px">
            </td>
        </tr>
    </table>
</fieldset>
