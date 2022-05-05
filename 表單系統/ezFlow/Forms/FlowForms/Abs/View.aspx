<%@ Page Language="C#" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Abs_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>請假單---檢視</title>
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
                <table border="0" cellpadding="0" cellspacing="0" id="tb" width="100%">
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
                <asp:GridView ID="gvS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                    CellPadding="4" DataKeyNames="idProcess" DataSourceID="sdsS" ForeColor="#333333"
                    GridLines="None" OnRowCommand="gvS_RowCommand" Width="100%" AllowPaging="True" PageSize="20">
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
                        <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dStrDateFull" HeaderText="開始日期時間" SortExpression="dStrDateFull" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="dEndDateFull" HeaderText="結束日期時間" SortExpression="dEndDateFull" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sHname" HeaderText="假別" SortExpression="sHname" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="iDay" HeaderText="天數" SortExpression="iDay" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="iHour" HeaderText="時數" SortExpression="iHour" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sAgentName1" HeaderText="代理人" SortExpression="sAgentName1" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                        <asp:TemplateField HeaderText="檔案管理">
                            <ItemTemplate>
                                <asp:LinkButton ID="lbtnUpload" runat="server" CommandArgument='<%# Eval("iAutoKey") %>'
                                    CommandName="Upload">上傳檔案</asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="1%" Wrap="False" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="dDateA" HeaderText="申請日期" SortExpression="dDateA" />
                    </Columns>
                    <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                    <EmptyDataTemplate>
                        目前沒有人請假。
                    </EmptyDataTemplate>
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="sdsS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                    DeleteCommand="DELETE FROM [wfAbsAppS] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfAbsAppS] ([sProcessID], [idProcess], [sNobr], [sName], [sDept], [sDeptName], [sJob], [sJobName], [sJobl], [sJoblName], [sEmpcd], [sEmpcdName], [dStrDateFull], [dEndDateFull], [dStrDate], [dEndDate], [sStrTime], [sEndTime], [sHcode], [sHname], [iDay], [iHour], [iTotalDay], [iTotalHour], [sReserve1], [sReserve2], [sReserve3], [sSalYYMM], [bSign], [sState], [sAgentNobr1], [sAgentName1], [sAgentNobr2], [sAgentName2], [sAgentNobr3], [sAgentName3], [bAuth], [sNote], [dKeyDate]) VALUES (@sProcessID, @idProcess, @sNobr, @sName, @sDept, @sDeptName, @sJob, @sJobName, @sJobl, @sJoblName, @sEmpcd, @sEmpcdName, @dStrDateFull, @dEndDateFull, @dStrDate, @dEndDate, @sStrTime, @sEndTime, @sHcode, @sHname, @iDay, @iHour, @iTotalDay, @iTotalHour, @sReserve1, @sReserve2, @sReserve3, @sSalYYMM, @bSign, @sState, @sAgentNobr1, @sAgentName1, @sAgentNobr2, @sAgentName2, @sAgentNobr3, @sAgentName3, @bAuth, @sNote, @dKeyDate)"
                    SelectCommand="SELECT wfAbsAppS.iAutoKey, wfAbsAppS.sProcessID, wfAbsAppS.idProcess, wfAbsAppS.sNobr, wfAbsAppS.sName, wfAbsAppS.sDept, wfAbsAppS.sDeptName, wfAbsAppS.sJob, wfAbsAppS.sJobName, wfAbsAppS.sJobl, wfAbsAppS.sJoblName, wfAbsAppS.sEmpcd, wfAbsAppS.sEmpcdName, wfAbsAppS.dStrDateFull, wfAbsAppS.dEndDateFull, wfAbsAppS.dStrDate, wfAbsAppS.dEndDate, wfAbsAppS.sStrTime, wfAbsAppS.sEndTime, wfAbsAppS.sHcode, wfAbsAppS.sHname, wfAbsAppS.iDay, wfAbsAppS.iHour, wfAbsAppS.iTotalDay, wfAbsAppS.iTotalHour, wfAbsAppS.sReserve1, wfAbsAppS.sReserve2, wfAbsAppS.sReserve3, wfAbsAppS.sSalYYMM, wfAbsAppS.bSign, wfAbsAppS.sState, wfAbsAppS.sAgentNobr1, wfAbsAppS.sAgentName1, wfAbsAppS.sAgentNobr2, wfAbsAppS.sAgentName2, wfAbsAppS.sAgentNobr3, wfAbsAppS.sAgentName3, wfAbsAppS.bAuth, wfAbsAppS.sNote, wfAbsAppS.dKeyDate, wfAbsAppM.dDateA FROM wfAbsAppS INNER JOIN wfAbsAppM ON wfAbsAppS.sProcessID = wfAbsAppM.sProcessID WHERE (wfAbsAppS.sState = @sState OR @sState = 'a') AND (wfAbsAppS.sNobr = @sNobr OR @sNobr = 'a') ORDER BY wfAbsAppS.sProcessID DESC"
                    UpdateCommand="UPDATE [wfAbsAppS] SET [sProcessID] = @sProcessID, [idProcess] = @idProcess, [sNobr] = @sNobr, [sName] = @sName, [sDept] = @sDept, [sDeptName] = @sDeptName, [sJob] = @sJob, [sJobName] = @sJobName, [sJobl] = @sJobl, [sJoblName] = @sJoblName, [sEmpcd] = @sEmpcd, [sEmpcdName] = @sEmpcdName, [dStrDateFull] = @dStrDateFull, [dEndDateFull] = @dEndDateFull, [dStrDate] = @dStrDate, [dEndDate] = @dEndDate, [sStrTime] = @sStrTime, [sEndTime] = @sEndTime, [sHcode] = @sHcode, [sHname] = @sHname, [iDay] = @iDay, [iHour] = @iHour, [iTotalDay] = @iTotalDay, [iTotalHour] = @iTotalHour, [sReserve1] = @sReserve1, [sReserve2] = @sReserve2, [sReserve3] = @sReserve3, [sSalYYMM] = @sSalYYMM, [bSign] = @bSign, [sState] = @sState, [sAgentNobr1] = @sAgentNobr1, [sAgentName1] = @sAgentName1, [sAgentNobr2] = @sAgentNobr2, [sAgentName2] = @sAgentName2, [sAgentNobr3] = @sAgentNobr3, [sAgentName3] = @sAgentName3, [bAuth] = @bAuth, [sNote] = @sNote, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                    <DeleteParameters>
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="sProcessID" Type="String" />
                        <asp:Parameter Name="idProcess" Type="Int32" />
                        <asp:Parameter Name="sNobr" Type="String" />
                        <asp:Parameter Name="sName" Type="String" />
                        <asp:Parameter Name="sDept" Type="String" />
                        <asp:Parameter Name="sDeptName" Type="String" />
                        <asp:Parameter Name="sJob" Type="String" />
                        <asp:Parameter Name="sJobName" Type="String" />
                        <asp:Parameter Name="sJobl" Type="String" />
                        <asp:Parameter Name="sJoblName" Type="String" />
                        <asp:Parameter Name="sEmpcd" Type="String" />
                        <asp:Parameter Name="sEmpcdName" Type="String" />
                        <asp:Parameter Name="dStrDateFull" Type="DateTime" />
                        <asp:Parameter Name="dEndDateFull" Type="DateTime" />
                        <asp:Parameter Name="dStrDate" Type="DateTime" />
                        <asp:Parameter Name="dEndDate" Type="DateTime" />
                        <asp:Parameter Name="sStrTime" Type="String" />
                        <asp:Parameter Name="sEndTime" Type="String" />
                        <asp:Parameter Name="sHcode" Type="String" />
                        <asp:Parameter Name="sHname" Type="String" />
                        <asp:Parameter Name="iDay" Type="Decimal" />
                        <asp:Parameter Name="iHour" Type="Decimal" />
                        <asp:Parameter Name="iTotalDay" Type="Decimal" />
                        <asp:Parameter Name="iTotalHour" Type="Decimal" />
                        <asp:Parameter Name="sReserve1" Type="String" />
                        <asp:Parameter Name="sReserve2" Type="String" />
                        <asp:Parameter Name="sReserve3" Type="String" />
                        <asp:Parameter Name="sSalYYMM" Type="String" />
                        <asp:Parameter Name="bSign" Type="Boolean" />
                        <asp:Parameter Name="sState" Type="String" />
                        <asp:Parameter Name="sAgentNobr1" Type="String" />
                        <asp:Parameter Name="sAgentName1" Type="String" />
                        <asp:Parameter Name="sAgentNobr2" Type="String" />
                        <asp:Parameter Name="sAgentName2" Type="String" />
                        <asp:Parameter Name="sAgentNobr3" Type="String" />
                        <asp:Parameter Name="sAgentName3" Type="String" />
                        <asp:Parameter Name="bAuth" Type="Boolean" />
                        <asp:Parameter Name="sNote" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="mu" DefaultValue="a" Name="sState" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="lblNobr" DefaultValue="" Name="sNobr" PropertyName="Text" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="sProcessID" Type="String" />
                        <asp:Parameter Name="idProcess" Type="Int32" />
                        <asp:Parameter Name="sNobr" Type="String" />
                        <asp:Parameter Name="sName" Type="String" />
                        <asp:Parameter Name="sDept" Type="String" />
                        <asp:Parameter Name="sDeptName" Type="String" />
                        <asp:Parameter Name="sJob" Type="String" />
                        <asp:Parameter Name="sJobName" Type="String" />
                        <asp:Parameter Name="sJobl" Type="String" />
                        <asp:Parameter Name="sJoblName" Type="String" />
                        <asp:Parameter Name="sEmpcd" Type="String" />
                        <asp:Parameter Name="sEmpcdName" Type="String" />
                        <asp:Parameter Name="dStrDateFull" Type="DateTime" />
                        <asp:Parameter Name="dEndDateFull" Type="DateTime" />
                        <asp:Parameter Name="dStrDate" Type="DateTime" />
                        <asp:Parameter Name="dEndDate" Type="DateTime" />
                        <asp:Parameter Name="sStrTime" Type="String" />
                        <asp:Parameter Name="sEndTime" Type="String" />
                        <asp:Parameter Name="sHcode" Type="String" />
                        <asp:Parameter Name="sHname" Type="String" />
                        <asp:Parameter Name="iDay" Type="Decimal" />
                        <asp:Parameter Name="iHour" Type="Decimal" />
                        <asp:Parameter Name="iTotalDay" Type="Decimal" />
                        <asp:Parameter Name="iTotalHour" Type="Decimal" />
                        <asp:Parameter Name="sReserve1" Type="String" />
                        <asp:Parameter Name="sReserve2" Type="String" />
                        <asp:Parameter Name="sReserve3" Type="String" />
                        <asp:Parameter Name="sSalYYMM" Type="String" />
                        <asp:Parameter Name="bSign" Type="Boolean" />
                        <asp:Parameter Name="sState" Type="String" />
                        <asp:Parameter Name="sAgentNobr1" Type="String" />
                        <asp:Parameter Name="sAgentName1" Type="String" />
                        <asp:Parameter Name="sAgentNobr2" Type="String" />
                        <asp:Parameter Name="sAgentName2" Type="String" />
                        <asp:Parameter Name="sAgentNobr3" Type="String" />
                        <asp:Parameter Name="sAgentName3" Type="String" />
                        <asp:Parameter Name="bAuth" Type="Boolean" />
                        <asp:Parameter Name="sNote" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                    </InsertParameters>
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
                                    <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                        ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                    <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                        Visible="False" />
                                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" />
                                    <asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                        Visible="False" />
                                    <asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" />
                                    <asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                        Visible="False" />
                                    <asp:BoundField DataField="iCateOrder" HeaderText="iCateOrder" SortExpression="iCateOrder"
                                        Visible="False" />
                                    <asp:CheckBoxField DataField="bDelay" HeaderText="bDelay" SortExpression="bDelay"
                                        Visible="False" />
                                    <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" />
                                    <asp:BoundField DataField="sReserve1" HeaderText="sReserve1" SortExpression="sReserve1"
                                        Visible="False" />
                                    <asp:BoundField DataField="sReserve2" HeaderText="sReserve2" SortExpression="sReserve2"
                                        Visible="False" />
                                    <asp:BoundField DataField="sReserve3" HeaderText="sReserve3" SortExpression="sReserve3"
                                        Visible="False" />
                                    <asp:BoundField DataField="dDateA" HeaderText="申請時間" SortExpression="dDateA" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="dDateD" HeaderText="結束時間" SortExpression="dDateD" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                                    <asp:CheckBoxField DataField="bSign" HeaderText="是否核准" SortExpression="bSign" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:CheckBoxField>
                                    <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
                                    <asp:BoundField DataField="sConditions1" HeaderText="sConditions1" SortExpression="sConditions1"
                                        Visible="False" />
                                    <asp:BoundField DataField="sConditions2" HeaderText="sConditions2" SortExpression="sConditions2"
                                        Visible="False" />
                                    <asp:BoundField DataField="sConditions3" HeaderText="sConditions3" SortExpression="sConditions3"
                                        Visible="False" />
                                    <asp:BoundField DataField="sConditions4" HeaderText="sConditions4" SortExpression="sConditions4"
                                        Visible="False" />
                                    <asp:BoundField DataField="sConditions5" HeaderText="sConditions5" SortExpression="sConditions5"
                                        Visible="False" />
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
                                SelectCommand="SELECT * FROM [wfAbsAppM] WHERE ([sProcessID] = @sProcessID)">
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
                        <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:CheckBoxField DataField="bSign" HeaderText="是否核准" SortExpression="bSign" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:CheckBoxField>
                        <asp:BoundField DataField="sSign" HeaderText="sSign" SortExpression="sSign" Visible="False" />
                        <asp:BoundField DataField="dKeyDate" HeaderText="簽核時間" SortExpression="dKeyDate" >
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                    <EmptyDataTemplate>
                        目前尚無任何簽核資料。
                    </EmptyDataTemplate>
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="sdsN" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                    SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (idProcess = @idProcess) AND (sFromCode = 'Abs')">
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
