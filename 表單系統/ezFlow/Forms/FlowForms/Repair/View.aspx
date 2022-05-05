<%@ Page Language="C#" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Repair_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>搶修單---檢視</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <asp:UpdateProgress ID="up" runat="server">
            <ProgressTemplate>
                <table id="loaderContainer" border="0" cellpadding="0" cellspacing="0" height="600"
                    onclick="return false;" width="800">
                    <tr>
                        <td id="loaderContainerWH">
                            <div id="loader">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <p>
                                                <img id="IMG1" alt="" height="32" src="../images/loading.gif" width="32" /><strong>請稍後～<br />
                                                    資料連接中............</strong></p>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <table id="tb" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            搜尋工號：<asp:TextBox ID="txtNobr" runat="server"></asp:TextBox>
                            <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="搜尋" />
                            <asp:Label ID="lblNobr" runat="server" Text="a"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Menu ID="mu" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2"
                                Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" Orientation="Horizontal"
                                StaticSubMenuIndent="10px">
                                <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                                <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
                                <DynamicMenuStyle BackColor="#B5C7DE" />
                                <StaticSelectedStyle BackColor="#507CD1" />
                                <DynamicSelectedStyle BackColor="#507CD1" />
                                <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                                <Items>
                                    <asp:MenuItem Selected="True" Text="全部" Value="a"></asp:MenuItem>
                                    <asp:MenuItem Text="簽核中" Value="1"></asp:MenuItem>
                                    <asp:MenuItem Text="已駁回" Value="2"></asp:MenuItem>
                                    <asp:MenuItem Text="簽核完成" Value="3"></asp:MenuItem>
                                    <asp:MenuItem Text="已刪除" Value="4"></asp:MenuItem>
                                    <asp:MenuItem Text="尚未送出" Value="0"></asp:MenuItem>
                                </Items>
                                <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                            </asp:Menu>
                            <asp:GridView ID="gvS" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                CellPadding="4" DataKeyNames="idProcess" DataSourceID="sdsS" ForeColor="#333333"
                                GridLines="None" OnRowCommand="gvS_RowCommand" PageSize="20" Width="100%">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemStyle Width="1%" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select">選取</asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                CommandName="Del" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnServices" runat="server" CausesValidation="False" CommandArgument='<%# Eval("idProcess") %>'
                                                CommandName="Services" OnClientClick="return confirm('您確定要呼叫服務嗎？');" Text="叫用"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("idProcess") %>'
                                                CommandName="Restart" OnClientClick="return confirm('您確定要重送嗎？');" Text="重送"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                        ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                    <asp:BoundField DataField="idProcess" HeaderText="流程序" SortExpression="idProcess" />
                                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dStrDateTime" HeaderText="開始日期時間" SortExpression="dStrDateTime" />
                                    <asp:BoundField DataField="dEndDateTime" HeaderText="結束日期時間" SortExpression="dEndDateTime" />
                                    <asp:BoundField DataField="iTotalHours" HeaderText="總時數" SortExpression="iTotalHours" />
                                    <asp:BoundField DataField="dDateA" HeaderText="申請日期" SortExpression="dDateA" />
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                                <EmptyDataTemplate>
                                    目前沒有資料。
                                </EmptyDataTemplate>
                                <EditRowStyle BackColor="#2461BF" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                                    Wrap="True" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                DeleteCommand="DELETE FROM [wfRepairAppS] WHERE [iAutoKey] = @iAutoKey"
                                SelectCommand="SELECT wfRepairAppS.iAutoKey, wfRepairAppS.sProcessID, wfRepairAppS.idProcess, wfRepairAppS.sNobr, wfRepairAppS.sName, wfRepairAppS.sDept, wfRepairAppS.sDeptName, wfRepairAppS.sJob, wfRepairAppS.sJobName, wfRepairAppS.sJobl, wfRepairAppS.sJoblName, wfRepairAppS.sEmpcd, wfRepairAppS.sEmpcdName, wfRepairAppS.dStrDateTime, wfRepairAppS.dEndDateTime, wfRepairAppS.dStrDate, wfRepairAppS.dEndDate, wfRepairAppS.sStrTime, wfRepairAppS.sEndTime, wfRepairAppS.iTotalHours, wfRepairAppS.sReserve1, wfRepairAppS.sReserve2, wfRepairAppS.sReserve3, wfRepairAppS.bSign, wfRepairAppS.sState, wfRepairAppS.bAuth, wfRepairAppS.sNote, wfRepairAppS.dKeyDate, wfRepairAppS.sOtcatCode, wfRepairAppS.sOtcatName, wfRepairAppS.sRoteCode, wfRepairAppS.sRoteName, wfRepairAppM.dDateA FROM wfRepairAppS INNER JOIN wfRepairAppM ON wfRepairAppS.sProcessID = wfRepairAppM.sProcessID WHERE (wfRepairAppS.sState = @sState OR @sState = 'a') AND (wfRepairAppS.sNobr = @sNobr OR @sNobr = 'a') ORDER BY wfRepairAppS.sProcessID DESC">
                                <DeleteParameters>
                                    <asp:Parameter Name="iAutoKey" Type="Int32" />
                                </DeleteParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="mu" Name="sState" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="lblNobr" DefaultValue="a" Name="sNobr" PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-hc">
                            申請者基本資料</td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gvM" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsM" ForeColor="#333333"
                                GridLines="None" Width="100%">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <Columns>
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
                                    <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" />
                                    <asp:BoundField DataField="dDateA" HeaderText="申請時間" SortExpression="dDateA">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dDateD" HeaderText="結束時間" SortExpression="dDateD">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="bSign" HeaderText="是否核准" SortExpression="bSign">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:CheckBoxField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                                <EmptyDataTemplate>
                                    目前無任何申請者基本資料。
                                </EmptyDataTemplate>
                                <EditRowStyle BackColor="#2461BF" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsM" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                SelectCommand="SELECT * FROM [wfRepairAppM] WHERE ([sProcessID] = @sProcessID)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvS" Name="sProcessID" PropertyName="SelectedValue"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-hc">
                            簽核者基本資料</td>
                    </tr>
                </table>
                <asp:GridView ID="gvN" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsN" ForeColor="#333333"
                    GridLines="None" Width="100%">
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
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
                    <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                    <EmptyDataTemplate>
                        目前尚無任何簽核資料。
                    </EmptyDataTemplate>
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                        Wrap="True" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="sdsN" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                    SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (idProcess = @idProcess) AND (sFromCode = 'Repair')">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvS" Name="idProcess" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
