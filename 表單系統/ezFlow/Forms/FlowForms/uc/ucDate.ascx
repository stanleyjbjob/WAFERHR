<%@ Control Language="C#" AutoEventWireup="true" CodeFile="ucDate.ascx.cs" Inherits="Abs_ucDate" %>
<asp:TextBox ID="txtDate" runat="server"></asp:TextBox>
<asp:ImageButton ID="ibtnDate" runat="server" ImageUrl="~/images/button.GIF" OnClick="ibtnDate_Click" /><asp:Calendar
    ID="cDate" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px"
    CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt"
    ForeColor="#003399" Height="200px" OnSelectionChanged="cDate_SelectionChanged"
    Visible="False" Width="220px" OnDayRender="cDate_DayRender">
    <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
    <TodayDayStyle BackColor="#99CCCC" ForeColor="White" />
    <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
    <WeekendDayStyle BackColor="#CCCCFF" />
    <OtherMonthDayStyle ForeColor="#999999" />
    <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
    <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
    <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
        Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
</asp:Calendar>
