<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calendar.aspx.cs" Inherits="Abs_Calendar" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>加班單---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body STYLE="OVERFLOW:SCROLL;OVERFLOW-X:HIDDEN" scroll="auto" bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
        <asp:TextBox ID="txtDate" runat="server" CssClass="txtBoxLine" ReadOnly="True" Width="60px" Visible="False"></asp:TextBox>
        <asp:Button ID="btnSubmit" runat="server" Text="確定" CssClass="UltraWebGrid1-hc" Visible="False" />
        <asp:Button ID="btnCancel" runat="server" Text="取消" CssClass="UltraWebGrid1-hc" Visible="False" />
        <asp:CheckBox ID="cbColor" runat="server" AutoPostBack="True" Checked="True" Text="套用色彩" />
        <asp:Calendar ID="cldAbs"
            runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1"
            DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399"
            Height="100%" OnDayRender="cldAbs_DayRender" OnSelectionChanged="cldAbs_SelectionChanged"
            Width="100%" NextMonthText="&gt;下個月" PrevMonthText="上個月&lt;">
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
