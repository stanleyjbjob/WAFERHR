<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Calendar.aspx.cs" Inherits="Booking_Calendar" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>請假單---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body STYLE="OVERFLOW:SCROLL;OVERFLOW-X:HIDDEN" scroll="auto" bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
        &nbsp;設備設施名稱：<asp:DropDownList ID="ddlClass" runat="server" AppendDataBoundItems="True"
            AutoPostBack="True" DataSourceID="sdsClass" DataTextField="sClassName" DataValueField="sClassCode">
            <asp:ListItem Value="000000">請選擇</asp:ListItem>
        </asp:DropDownList>(型/車/編/料)號：<asp:DropDownList ID="ddlType" runat="server" AppendDataBoundItems="True"
            AutoPostBack="True" DataSourceID="sdsType" DataTextField="sTypeName" DataValueField="sTypeCode"
            EnableViewState="False">
            <asp:ListItem Value="000000">請選擇</asp:ListItem>
        </asp:DropDownList>
        <asp:CheckBox ID="cbColor" runat="server" AutoPostBack="True" Checked="True" Text="套用色彩" /><br />
        <asp:SqlDataSource ID="sdsClass" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
            SelectCommand="SELECT [sClassCode], [sClassName] FROM [wfBookingClass]"></asp:SqlDataSource>
        <asp:SqlDataSource ID="sdsType" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
            SelectCommand="SELECT [sTypeCode], [sTypeName] FROM [wfBookingType] WHERE ([sClassCode] = @sClassCode)">
            <SelectParameters>
                <asp:ControlParameter ControlID="ddlClass" Name="sClassCode" PropertyName="SelectedValue"
                    Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Calendar ID="cldAbs"
            runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px" CellPadding="1"
            DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="8pt" ForeColor="#003399" OnDayRender="cldAbs_DayRender"
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
