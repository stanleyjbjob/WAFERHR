<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Check2.aspx.cs" Inherits="Shift_Check2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>調班單---審核</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0" >
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
            <asp:Button ID="btnPrint" runat="server" CssClass="UltraWebGrid1-hc" OnClientClick="print();"
                Text="列印" />
            <asp:UpdatePanel ID="upl" runat="server">
                <ContentTemplate>
                    <asp:Label ID="lblUrl" runat="server" Visible="False"></asp:Label>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="center" nowrap="nowrap" class="style1">
                                調班單審核</td>
                        </tr>
                        <tr>
                            <td align="center" nowrap="nowrap">
                                <table border="0" style="width: 100%" class="WebPanel2ctl" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:FormView ID="fvAppM" runat="server" DataSourceID="sdsAppM" Width="100%">
                                                <ItemTemplate>
                                                    <table border="0" style="width: 100%">
                                                        <tr>
                                                            <td align="left" nowrap="nowrap" width="33%">
                                                                申請人資料</td>
                                                            <td align="center" nowrap="nowrap" width="34%">
                                                            </td>
                                                            <td align="right" nowrap="nowrap" width="33%">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap" width="33%">
                                                                單位：<asp:Label ID="d_nameLabel" runat="server" Font-Underline="True" Text='<%# Eval("sDeptName") %>'></asp:Label></td>
                                                            <td align="center" nowrap="nowrap" width="34%">
                                                                姓名：<asp:Label ID="name_cLabel" runat="server" Font-Underline="True" Text='<%# Eval("sName") %>'></asp:Label></td>
                                                            <td align="right" nowrap="nowrap" width="33%">
                                                                工號：<asp:Label ID="NobrLabel" runat="server" Font-Underline="True" Text='<%# Eval("sNobr") %>'></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblDept" runat="server" Font-Underline="True" Text='<%# Eval("sDept") %>'
                                                        Visible="False"></asp:Label>
                                                </ItemTemplate>
                                            </asp:FormView>
                                            <asp:SqlDataSource ID="sdsAppM" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                SelectCommand="SELECT * FROM [wfShiftAppM] WHERE ([sProcessID] = @sProcessID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                                        Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label><br />
                                            <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="text-align: center;" class="UltraWebGrid1-hc">
                                                        調班人員基本資料</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsAppS" ForeColor="#333333"
                                                            GridLines="None" Width="100%" OnRowCommand="gvAppS_RowCommand" OnRowDataBound="gvAppS_RowDataBound">
                                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnState" runat="server" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="State">駁回</asp:LinkButton>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="1%" Wrap="False" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                                                <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sRoteCate" HeaderText="sRoteCate" SortExpression="sRoteCate"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sRoteCateName" HeaderText="短期/長期" SortExpression="sRoteCateName"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                                                                <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                                                                <asp:BoundField DataField="sDept" HeaderText="sDept" SortExpression="sDept" Visible="False" />
                                                                <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" />
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
                                                                <asp:BoundField DataField="sRoteName" HeaderText="原班別" SortExpression="sRoteName" />
                                                                <asp:BoundField DataField="dAuthority" DataFormatString="{0:d}" HeaderText="調班日"
                                                                    HtmlEncode="False" SortExpression="dAuthority" />
                                                                <asp:BoundField DataField="sNobrB" HeaderText="工號B" SortExpression="sNobrB" Visible="False" />
                                                                <asp:BoundField DataField="sNameB" HeaderText="姓名B" SortExpression="sNameB" Visible="False" />
                                                                <asp:BoundField DataField="sDeptB" HeaderText="sDeptB" SortExpression="sDeptB" Visible="False" />
                                                                <asp:BoundField DataField="sDeptNameB" HeaderText="部門名稱B" SortExpression="sDeptNameB"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sRoteB" HeaderText="sRoteB" SortExpression="sRoteB" Visible="False" />
                                                                <asp:BoundField DataField="sRoteNameB" HeaderText="調班後班別" SortExpression="sRoteNameB" />
                                                                <asp:BoundField DataField="dAim" DataFormatString="{0:d}" HeaderText="調班日期B" HtmlEncode="False"
                                                                    SortExpression="dAim" Visible="False" />
                                                                <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
                                                                <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
                                                                <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                                                                <asp:BoundField DataField="sHolidayName" HeaderText="行事曆" SortExpression="sHolidayName" />
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
                                                        <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            DeleteCommand="DELETE FROM [wfShiftAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM wfShiftAppS WHERE (sProcessID = @sProcessID)">
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </DeleteParameters>
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:Panel ID="pNote" runat="server">
                                            <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="text-align: center" class="UltraWebGrid1-hc">
                                                        簽核者資料</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvNote" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsSign" ForeColor="#333333"
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
                                                                <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
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
                                                        <asp:SqlDataSource ID="sdsSign" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            DeleteCommand="DELETE FROM [wfShiftAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (sProcessID = @sProcessID) AND (sFromCode = 'Shift')">
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </DeleteParameters>
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                                                <tr>
                                                    <td style="text-align: center" class="UltraWebGrid1-hc">
                                                        意見</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtNote" runat="server" Height="100px" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblNote" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:RadioButtonList ID="rblCheck" runat="server" Font-Size="X-Large" meta:resourcekey="rblCheckResource1"
                                    RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem meta:resourceKey="ListItemResource1" Selected="True" Text="繼續傳送" Value="1"></asp:ListItem>
                                    <asp:ListItem meta:resourceKey="ListItemResource2" Text="全部駁回" Value="0"></asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Button ID="btnSign" runat="server" Font-Bold="True" Font-Size="XX-Large" Font-Underline="False"
                                    ForeColor="Blue" OnClick="btnSign_Click" OnClientClick="return confirm('您確定要送出傳簽嗎？');"
                                    Text="送出傳簽" CssClass="UltraWebGrid1-hc" />
                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
                        </tr>
                    </table>
                </ContentTemplate>
            </asp:UpdatePanel>
            &nbsp;
        </div>
    </form>
</body>
</html>
