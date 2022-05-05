<%@ Page Language="C#" AutoEventWireup="true" CodeFile="OtInfo.aspx.cs" Inherits="Ot_OtInfo" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
    
        員工：<asp:Label ID="lblNobr" runat="server"></asp:Label>
        <asp:Label ID="lblDateB" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblDateD" runat="server" Visible="False"></asp:Label>
        <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" 
            AutoGenerateColumns="False" CellPadding="4" DataSourceID="sdsOt" 
            ForeColor="#333333" GridLines="None">
            <RowStyle BackColor="#EFF3FB" />
            <Columns>
                <asp:BoundField DataField="NOBR" HeaderText="工號" SortExpression="NOBR" />
                <asp:BoundField DataField="BDATE" DataFormatString="{0:d}" HeaderText="生效日" 
                    SortExpression="BDATE" />
                <asp:BoundField DataField="EDATE" DataFormatString="{0:d}" HeaderText="失效日" 
                    SortExpression="EDATE" />
                <asp:BoundField DataField="TOL_HOURS" HeaderText="時數" 
                    SortExpression="TOL_HOURS" />
                <asp:BoundField DataField="KEY_DATE" HeaderText="登錄日期" 
                    SortExpression="KEY_DATE" />
            </Columns>
            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
            <EditRowStyle BackColor="#2461BF" />
            <AlternatingRowStyle BackColor="White" />
        </asp:GridView>
        <asp:SqlDataSource ID="sdsOt" runat="server" 
            ConnectionString="<%$ ConnectionStrings:hr %>" 
            SelectCommand="SELECT NOBR, BDATE, EDATE, BTIME, ETIME, H_CODE, TOL_HOURS, KEY_MAN, KEY_DATE, YYMM, NOTEDIT, NOTE, SYSCREATE, TOL_DAY, A_NAME, SERNO FROM ABS WHERE (NOBR = @NOBR) AND (BDATE BETWEEN @DATEB AND @DATEE) AND (H_CODE IN (SELECT H_CODE FROM HCODE WHERE (YEAR_REST IN (3)))) ORDER BY BDATE">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblNobr" Name="NOBR" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblDateB" Name="DATEB" PropertyName="Text" />
                <asp:ControlParameter ControlID="lblDateD" Name="DATEE" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
    
    </div>
    </form>
</body>
</html>
