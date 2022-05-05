<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calendar.aspx.cs" Inherits="Abs_Calendar" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>請假單---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body STYLE="OVERFLOW:SCROLL;OVERFLOW-X:HIDDEN" scroll="auto" bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
        <asp:DropDownList ID="ddlHoliday" runat="server" AutoPostBack="True" DataSourceID="sdsHoliday"
            DataTextField="HOLI_NAME" DataValueField="HOLI_CODE" OnSelectedIndexChanged="ddlHoliday_SelectedIndexChanged">
        </asp:DropDownList>
        <asp:CheckBox ID="cbColor" runat="server" AutoPostBack="True" Checked="True" Text="套用色彩" />
        <asp:SqlDataSource ID="sdsHoliday" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
            SelectCommand="SELECT RTRIM(HOLI_CODE) AS HOLI_CODE, RTRIM(HOLI_NAME) AS HOLI_NAME FROM HOLICD">
        </asp:SqlDataSource>
        <asp:Calendar ID="cldAbs"
            runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1"
            DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399"
            Height="100%" OnDayRender="cldAbs_DayRender"
            Width="100%" SelectionMode="None">
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
    </form>
</body>
</html>
