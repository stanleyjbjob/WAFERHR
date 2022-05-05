<%@ Page Language="C#" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="Shift_View" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>調班單---設定</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body style="background-color: #eef3ff">
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
                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
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
                            <ItemStyle Wrap="False" />
                            <HeaderStyle Wrap="True" />
                            <ItemTemplate>
                                <asp:LinkButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select">選取</asp:LinkButton>
                                <asp:LinkButton ID="btnDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
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
                        <asp:BoundField DataField="sRoteCate" HeaderText="sRoteCate" SortExpression="sRoteCate"
                            Visible="False" />
                        <asp:BoundField DataField="sRoteCateName" HeaderText="短期/長期" SortExpression="sRoteCateName" />
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
                        <asp:BoundField DataField="sNote" HeaderText="事由" SortExpression="sNote" />
                        <asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate"
                            Visible="False" />
                    </Columns>
                    <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                    <EditRowStyle BackColor="#2461BF" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <asp:SqlDataSource ID="sdsS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                    DeleteCommand="DELETE FROM [wfShiftAppS] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfShiftAppS] ([sProcessID], [idProcess], [sRoteCate], [sRoteCateName], [sNobr], [sName], [sDept], [sDeptName], [sJob], [sJobName], [sJobl], [sJoblName], [sEmpcd], [sEmpcdName], [sRote], [sRoteName], [dAuthority], [sNobrB], [sNameB], [sDeptB], [sDeptNameB], [sRoteB], [sRoteNameB], [dAim], [bSign], [sState], [bAuth], [sNote], [dKeyDate]) VALUES (@sProcessID, @idProcess, @sRoteCate, @sRoteCateName, @sNobr, @sName, @sDept, @sDeptName, @sJob, @sJobName, @sJobl, @sJoblName, @sEmpcd, @sEmpcdName, @sRote, @sRoteName, @dAuthority, @sNobrB, @sNameB, @sDeptB, @sDeptNameB, @sRoteB, @sRoteNameB, @dAim, @bSign, @sState, @bAuth, @sNote, @dKeyDate)"
                    SelectCommand="SELECT * from wfShiftAppS&#13;&#10;WHERE         (sState = @sState OR&#13;&#10;                          @sState = 'a') AND (sNobr = @sNobr OR&#13;&#10;                          @sNobr = 'a')&#13;&#10;ORDER BY sProcessID DESC"
                    UpdateCommand="UPDATE [wfShiftAppS] SET [sProcessID] = @sProcessID, [idProcess] = @idProcess, [sRoteCate] = @sRoteCate, [sRoteCateName] = @sRoteCateName, [sNobr] = @sNobr, [sName] = @sName, [sDept] = @sDept, [sDeptName] = @sDeptName, [sJob] = @sJob, [sJobName] = @sJobName, [sJobl] = @sJobl, [sJoblName] = @sJoblName, [sEmpcd] = @sEmpcd, [sEmpcdName] = @sEmpcdName, [sRote] = @sRote, [sRoteName] = @sRoteName, [dAuthority] = @dAuthority, [sNobrB] = @sNobrB, [sNameB] = @sNameB, [sDeptB] = @sDeptB, [sDeptNameB] = @sDeptNameB, [sRoteB] = @sRoteB, [sRoteNameB] = @sRoteNameB, [dAim] = @dAim, [bSign] = @bSign, [sState] = @sState, [bAuth] = @bAuth, [sNote] = @sNote, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                    <DeleteParameters>
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="sProcessID" Type="String" />
                        <asp:Parameter Name="idProcess" Type="Int32" />
                        <asp:Parameter Name="sRoteCate" Type="String" />
                        <asp:Parameter Name="sRoteCateName" Type="String" />
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
                        <asp:Parameter Name="sRote" Type="String" />
                        <asp:Parameter Name="sRoteName" Type="String" />
                        <asp:Parameter Name="dAuthority" Type="DateTime" />
                        <asp:Parameter Name="sNobrB" Type="String" />
                        <asp:Parameter Name="sNameB" Type="String" />
                        <asp:Parameter Name="sDeptB" Type="String" />
                        <asp:Parameter Name="sDeptNameB" Type="String" />
                        <asp:Parameter Name="sRoteB" Type="String" />
                        <asp:Parameter Name="sRoteNameB" Type="String" />
                        <asp:Parameter Name="dAim" Type="DateTime" />
                        <asp:Parameter Name="bSign" Type="Boolean" />
                        <asp:Parameter Name="sState" Type="String" />
                        <asp:Parameter Name="bAuth" Type="Boolean" />
                        <asp:Parameter Name="sNote" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="mu" Name="sState" PropertyName="SelectedValue" />
                        <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="sProcessID" Type="String" />
                        <asp:Parameter Name="idProcess" Type="Int32" />
                        <asp:Parameter Name="sRoteCate" Type="String" />
                        <asp:Parameter Name="sRoteCateName" Type="String" />
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
                        <asp:Parameter Name="sRote" Type="String" />
                        <asp:Parameter Name="sRoteName" Type="String" />
                        <asp:Parameter Name="dAuthority" Type="DateTime" />
                        <asp:Parameter Name="sNobrB" Type="String" />
                        <asp:Parameter Name="sNameB" Type="String" />
                        <asp:Parameter Name="sDeptB" Type="String" />
                        <asp:Parameter Name="sDeptNameB" Type="String" />
                        <asp:Parameter Name="sRoteB" Type="String" />
                        <asp:Parameter Name="sRoteNameB" Type="String" />
                        <asp:Parameter Name="dAim" Type="DateTime" />
                        <asp:Parameter Name="bSign" Type="Boolean" />
                        <asp:Parameter Name="sState" Type="String" />
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
                                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                                    <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept" />
                                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" />
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
                                    <asp:BoundField DataField="dDateA" HeaderText="申請時間" SortExpression="dDateA" />
                                    <asp:BoundField DataField="dDateD" HeaderText="結束時間" SortExpression="dDateD" />
                                    <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                                    <asp:CheckBoxField DataField="bSign" HeaderText="是否核准" SortExpression="bSign" />
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
                                DeleteCommand="DELETE FROM [wfShiftAppM] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfShiftAppM] ([sProcessID], [idProcess], [sNobr], [sName], [sDept], [sDeptName], [sJob], [sJobName], [sJobl], [sJoblName], [iCateOrder], [bDelay], [sNote], [sReserve1], [sReserve2], [sReserve3], [dDateA], [dDateD], [bAuth], [bSign], [sState], [sConditions1], [sConditions2], [sConditions3], [sConditions4], [sConditions5]) VALUES (@sProcessID, @idProcess, @sNobr, @sName, @sDept, @sDeptName, @sJob, @sJobName, @sJobl, @sJoblName, @iCateOrder, @bDelay, @sNote, @sReserve1, @sReserve2, @sReserve3, @dDateA, @dDateD, @bAuth, @bSign, @sState, @sConditions1, @sConditions2, @sConditions3, @sConditions4, @sConditions5)"
                                SelectCommand="SELECT * FROM [wfShiftAppM] WHERE ([idProcess] = @idProcess)"
                                UpdateCommand="UPDATE [wfShiftAppM] SET [sProcessID] = @sProcessID, [idProcess] = @idProcess, [sNobr] = @sNobr, [sName] = @sName, [sDept] = @sDept, [sDeptName] = @sDeptName, [sJob] = @sJob, [sJobName] = @sJobName, [sJobl] = @sJobl, [sJoblName] = @sJoblName, [iCateOrder] = @iCateOrder, [bDelay] = @bDelay, [sNote] = @sNote, [sReserve1] = @sReserve1, [sReserve2] = @sReserve2, [sReserve3] = @sReserve3, [dDateA] = @dDateA, [dDateD] = @dDateD, [bAuth] = @bAuth, [bSign] = @bSign, [sState] = @sState, [sConditions1] = @sConditions1, [sConditions2] = @sConditions2, [sConditions3] = @sConditions3, [sConditions4] = @sConditions4, [sConditions5] = @sConditions5 WHERE [iAutoKey] = @iAutoKey">
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
                                    <asp:Parameter Name="iCateOrder" Type="Int32" />
                                    <asp:Parameter Name="bDelay" Type="Boolean" />
                                    <asp:Parameter Name="sNote" Type="String" />
                                    <asp:Parameter Name="sReserve1" Type="String" />
                                    <asp:Parameter Name="sReserve2" Type="String" />
                                    <asp:Parameter Name="sReserve3" Type="String" />
                                    <asp:Parameter Name="dDateA" Type="DateTime" />
                                    <asp:Parameter Name="dDateD" Type="DateTime" />
                                    <asp:Parameter Name="bAuth" Type="Boolean" />
                                    <asp:Parameter Name="bSign" Type="Boolean" />
                                    <asp:Parameter Name="sState" Type="String" />
                                    <asp:Parameter Name="sConditions1" Type="String" />
                                    <asp:Parameter Name="sConditions2" Type="String" />
                                    <asp:Parameter Name="sConditions3" Type="String" />
                                    <asp:Parameter Name="sConditions4" Type="String" />
                                    <asp:Parameter Name="sConditions5" Type="String" />
                                    <asp:Parameter Name="iAutoKey" Type="Int32" />
                                </UpdateParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvS" Name="idProcess" PropertyName="SelectedValue"
                                        Type="Int32" />
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
                                    <asp:Parameter Name="iCateOrder" Type="Int32" />
                                    <asp:Parameter Name="bDelay" Type="Boolean" />
                                    <asp:Parameter Name="sNote" Type="String" />
                                    <asp:Parameter Name="sReserve1" Type="String" />
                                    <asp:Parameter Name="sReserve2" Type="String" />
                                    <asp:Parameter Name="sReserve3" Type="String" />
                                    <asp:Parameter Name="dDateA" Type="DateTime" />
                                    <asp:Parameter Name="dDateD" Type="DateTime" />
                                    <asp:Parameter Name="bAuth" Type="Boolean" />
                                    <asp:Parameter Name="bSign" Type="Boolean" />
                                    <asp:Parameter Name="sState" Type="String" />
                                    <asp:Parameter Name="sConditions1" Type="String" />
                                    <asp:Parameter Name="sConditions2" Type="String" />
                                    <asp:Parameter Name="sConditions3" Type="String" />
                                    <asp:Parameter Name="sConditions4" Type="String" />
                                    <asp:Parameter Name="sConditions5" Type="String" />
                                </InsertParameters>
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
                        <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                        <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                        <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept" />
                        <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" />
                        <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" />
                        <asp:CheckBoxField DataField="bSign" HeaderText="是否核准" SortExpression="bSign" />
                        <asp:BoundField DataField="sSign" HeaderText="sSign" SortExpression="sSign" Visible="False" />
                        <asp:BoundField DataField="dKeyDate" HeaderText="簽核時間" SortExpression="dKeyDate" />
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
                    DeleteCommand="DELETE FROM [wfSign] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfSign] ([sFromCode], [sFromName], [sProcessID], [idProcess], [sNobr], [sName], [sDept], [sDeptName], [sNote], [bSign], [sSign], [dKeyDate]) VALUES (@sFromCode, @sFromName, @sProcessID, @idProcess, @sNobr, @sName, @sDept, @sDeptName, @sNote, @bSign, @sSign, @dKeyDate)"
                    SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (idProcess = @idProcess) AND (sFromCode = 'Shift')"
                    UpdateCommand="UPDATE [wfSign] SET [sFromCode] = @sFromCode, [sFromName] = @sFromName, [sProcessID] = @sProcessID, [idProcess] = @idProcess, [sNobr] = @sNobr, [sName] = @sName, [sDept] = @sDept, [sDeptName] = @sDeptName, [sNote] = @sNote, [bSign] = @bSign, [sSign] = @sSign, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
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
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvS" Name="idProcess" PropertyName="SelectedValue" />
                    </SelectParameters>
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
            </ContentTemplate>
      
        </asp:UpdatePanel>
    </div>
    </form>
    </body>
</html>
