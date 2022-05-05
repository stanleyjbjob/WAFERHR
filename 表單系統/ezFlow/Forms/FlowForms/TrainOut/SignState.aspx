<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignState.aspx.cs" Inherits="TrainOut_SignState" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>外訓單---進行中流程</title>
        <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td class="UltraWebGrid1-hc" style="text-align: center">
                    外訓人進行中流程</td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvSignState" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CellPadding="4" DataSourceID="sdsSignState" ForeColor="#333333" GridLines="None"
                        Width="100%" DataKeyNames="idProcess">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField HeaderText="簽核者">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select">選取</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="idProcess" HeaderText="流程序" SortExpression="idProcess" />
                            <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                            <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName" />
                            <asp:BoundField DataField="sJobName" HeaderText="職稱" SortExpression="sJobName" />
                            <asp:BoundField DataField="iNum" HeaderText="累計次數" SortExpression="iNum" />
                            <asp:BoundField DataField="iSum" HeaderText="累計金額" SortExpression="iSum" />
                            <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                            <asp:BoundField DataField="dKeyDate" HeaderText="申請日期" SortExpression="dKeyDate" />
                        </Columns>
                        <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            目前進行中流程。
                        </EmptyDataTemplate>
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsSignState" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        SelectCommand="SELECT * FROM wfTRAINAppS WHERE (sNobr = @sNobr) AND (idProcess <> 0) AND (sState IN ('1', '5'))">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="UltraWebGrid1-hc">
                    簽核者意見</td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvN" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsN" ForeColor="#333333"
                        GridLines="None" Width="100%">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                        <Columns>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sFromCode" HeaderText="sFromCode" SortExpression="sFromCode"
                                Visible="False" />
                            <asp:BoundField DataField="sFromName" HeaderText="sFromName" SortExpression="sFromName"
                                Visible="False" />
                            <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                Visible="False" />
                            <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                Visible="False" />
                            <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                            <asp:CheckBoxField DataField="bSign" HeaderText="是否核准" SortExpression="bSign">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:CheckBoxField>
                            <asp:BoundField DataField="sSign" HeaderText="sSign" SortExpression="sSign" Visible="False" />
                            <asp:BoundField DataField="dKeyDate" HeaderText="簽核時間" SortExpression="dKeyDate">
                                <ItemStyle HorizontalAlign="Center" />
                            </asp:BoundField>
                        </Columns>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            目前尚無任何簽核資料。
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                            Wrap="True" />
                        <EditRowStyle BackColor="#2461BF" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsN" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (idProcess = @idProcess) AND (sFromCode = 'TrainOut')">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvSignState" Name="idProcess" PropertyName="SelectedValue" />
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
