<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignState.aspx.cs" Inherits="Shift_SignState" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>調、換班單---進行中流程</title>
        <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td class="UltraWebGrid1-hc" style="text-align: center">
                    調、換班人進行中流程</td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CellPadding="4" DataKeyNames="idProcess" DataSourceID="sdsSignState" ForeColor="#333333"
                        GridLines="None" Width="100%">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                        <Columns>
                            <asp:TemplateField HeaderText="簽核者">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select">選取</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                Visible="False" />
                            <asp:BoundField DataField="idProcess" HeaderText="流程序" SortExpression="idProcess" />
                            <asp:BoundField DataField="sRoteCate" HeaderText="sRoteCate" SortExpression="sRoteCate"
                                Visible="False" />
                            <asp:BoundField DataField="sRoteCateName" HeaderText="短期/長期" SortExpression="sRoteCateName"
                                Visible="False" />
                            <asp:BoundField DataField="sNobr" HeaderText="工號A" SortExpression="sNobr" />
                            <asp:BoundField DataField="sName" HeaderText="姓名A" SortExpression="sName" />
                            <asp:BoundField DataField="sDept" HeaderText="sDept" SortExpression="sDept" Visible="False" />
                            <asp:BoundField DataField="sDeptName" HeaderText="部門名稱A" SortExpression="sDeptName" />
                            <asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" />
                            <asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                Visible="False" />
                            <asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" />
                            <asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                Visible="False" />
                            <asp:BoundField DataField="sEmpcd" HeaderText="sEmpcd" SortExpression="sEmpcd" Visible="False" />
                            <asp:BoundField DataField="sEmpcdName" HeaderText="sEmpcdName" SortExpression="sEmpcdName"
                                Visible="False" />
                            <asp:BoundField DataField="sRote" HeaderText="班別代碼" SortExpression="sRote" Visible="False" />
                            <asp:BoundField DataField="sRoteName" HeaderText="班別名稱A" SortExpression="sRoteName" />
                            <asp:BoundField DataField="dAuthority" DataFormatString="{0:d}" HeaderText="調班日A"
                                HtmlEncode="False" SortExpression="dAuthority" />
                            <asp:BoundField DataField="sNobrB" HeaderText="工號B" SortExpression="sNobrB" />
                            <asp:BoundField DataField="sNameB" HeaderText="姓名B" SortExpression="sNameB" />
                            <asp:BoundField DataField="sDeptB" HeaderText="sDeptB" SortExpression="sDeptB" Visible="False" />
                            <asp:BoundField DataField="sDeptNameB" HeaderText="部門名稱B" SortExpression="sDeptNameB" />
                            <asp:BoundField DataField="sRoteB" HeaderText="sRoteB" SortExpression="sRoteB" Visible="False" />
                            <asp:BoundField DataField="sRoteNameB" HeaderText="班別名稱B" SortExpression="sRoteNameB" />
                            <asp:BoundField DataField="dAim" DataFormatString="{0:d}" HeaderText="調班日期B" HtmlEncode="False"
                                SortExpression="dAim" />
                            <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
                            <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
                            <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                            <asp:BoundField DataField="sHolidayName" HeaderText="行事曆" SortExpression="sHolidayName" />
                            <asp:BoundField DataField="sNote" HeaderText="事由" SortExpression="sNote" />
                            <asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate"
                                Visible="False" />
                        </Columns>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            目前沒有申請資料。
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                        <EditRowStyle BackColor="#2461BF" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsSignState" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        SelectCommand="SELECT * FROM wfShiftAppS WHERE (sNobr = @sNobr) AND (idProcess <> 0) AND (sState IN ('1', '5'))">
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
                            <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                            <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                            <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept" />
                            <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" />
                            <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" />
                            <asp:CheckBoxField DataField="bSign" HeaderText="是否核准" SortExpression="bSign" />
                            <asp:BoundField DataField="sSign" HeaderText="sSign" SortExpression="sSign" Visible="False" />
                            <asp:BoundField DataField="dKeyDate" HeaderText="簽核時間" SortExpression="dKeyDate" />
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
                        DeleteCommand="DELETE FROM [wfSign] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfSign] ([sFromCode], [sFromName], [sProcessID], [idProcess], [sNobr], [sName], [sDept], [sDeptName], [sNote], [bSign], [sSign], [dKeyDate]) VALUES (@sFromCode, @sFromName, @sProcessID, @idProcess, @sNobr, @sName, @sDept, @sDeptName, @sNote, @bSign, @sSign, @dKeyDate)"
                        SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (idProcess = @idProcess) AND (sFromCode = 'Shift')"
                        UpdateCommand="UPDATE [wfSign] SET [sFromCode] = @sFromCode, [sFromName] = @sFromName, [sProcessID] = @sProcessID, [idProcess] = @idProcess, [sNobr] = @sNobr, [sName] = @sName, [sDept] = @sDept, [sDeptName] = @sDeptName, [sNote] = @sNote, [bSign] = @bSign, [sSign] = @sSign, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvAppS" Name="idProcess" PropertyName="SelectedValue" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="sFromCode" Type="String" />
                            <asp:Parameter Name="sFromName" Type="String" />
                            <asp:Parameter Name="sProcessID" Type="String" />
                            <asp:Parameter Name="idProcess" Type="Int32" />
                            <asp:Parameter Name="sNobr" Type="String" />
                            <asp:Parameter Name="sName" Type="String" />
                            <asp:Parameter Name="sDept" Type="String" />
                            <asp:Parameter Name="sDeptName" Type="String" />
                            <asp:Parameter Name="sNote" Type="String" />
                            <asp:Parameter Name="bSign" Type="Boolean" />
                            <asp:Parameter Name="sSign" Type="String" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sFromCode" Type="String" />
                            <asp:Parameter Name="sFromName" Type="String" />
                            <asp:Parameter Name="sProcessID" Type="String" />
                            <asp:Parameter Name="idProcess" Type="Int32" />
                            <asp:Parameter Name="sNobr" Type="String" />
                            <asp:Parameter Name="sName" Type="String" />
                            <asp:Parameter Name="sDept" Type="String" />
                            <asp:Parameter Name="sDeptName" Type="String" />
                            <asp:Parameter Name="sNote" Type="String" />
                            <asp:Parameter Name="bSign" Type="Boolean" />
                            <asp:Parameter Name="sSign" Type="String" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        </InsertParameters>
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
