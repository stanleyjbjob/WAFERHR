<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignState.aspx.cs" Inherits="Booking_SignState" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>請假單---進行中流程</title>
        <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td class="UltraWebGrid1-hc" style="text-align: center">
                    設備申請進行中流程</td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsSignState" ForeColor="#333333"
                        GridLines="None" Width="100%">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:BoundField DataField="idProcess" HeaderText="流程序" SortExpression="idProcess" />
                            <asp:BoundField DataField="sClassName" HeaderText="設施設備名稱" SortExpression="sClassName" />
                            <asp:BoundField DataField="sTypeName" HeaderText="(型/車/編/料)號" SortExpression="sTypeName" />
                            <asp:BoundField DataField="sCatName" HeaderText="對象" SortExpression="sCatName" />
                            <asp:BoundField DataField="dStrDateTime" HeaderText="開始日期時間" SortExpression="dStrDateTime" />
                            <asp:BoundField DataField="dEndDateTime" HeaderText="結束日期時間" SortExpression="dEndDateTime" />
                            <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                            <asp:BoundField DataField="dKeyDate" HeaderText="申請時間" SortExpression="dKeyDate" />
                        </Columns>
                        <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            目前沒有申請流程。
                        </EmptyDataTemplate>
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsSignState" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        SelectCommand="SELECT * FROM wfBookingAppS WHERE (sNobr = @sNobr) AND (idProcess <> 0) AND (sState IN ('1', '5'))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    被申請人工號：<asp:Label ID="lblNobr" runat="server" Text="000000"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
