<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="Card_Check" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>忘刷單---審核</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
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
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="center" class="style1" nowrap="nowrap" style="height: 21px">
                            忘刷單審核</td>
                    </tr>
                    <tr>
                        <td align="center" nowrap="nowrap">
                            <table border="0" class="WebPanel2ctl" style="width: 100%">
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
                                            SelectCommand="SELECT * FROM [wfCardAppM] WHERE ([sProcessID] = @sProcessID)">
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
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td class="UltraWebGrid1-hc" style="text-align: center">
                                                    忘刷人員基本資料</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None" Width="100%" OnRowCommand="gvAppS_RowCommand" OnRowDataBound="gvAppS_RowDataBound">
                                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                        <Columns>
                                                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                                            <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                                                            <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                                                            <asp:BoundField DataField="sDept" HeaderText="sDept" SortExpression="sDept" Visible="False" />
                                                            <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName" />
                                                            <asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" />
                                                            <asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" />
                                                            <asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="sEmpcd" HeaderText="sEmpcd" SortExpression="sEmpcd" Visible="False" />
                                                            <asp:BoundField DataField="sEmpcdName" HeaderText="sEmpcdName" SortExpression="sEmpcdName"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="dDateTime" HeaderText="日期時間" SortExpression="dDateTime" />
                                                            <asp:BoundField DataField="sReserve2" HeaderText="sReserve2" SortExpression="sReserve2"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="sReserve3" HeaderText="sReserve3" SortExpression="sReserve3"
                                                                Visible="False" />
                                                            <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
                                                            <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
                                                            <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                                                            <asp:BoundField DataField="sReserve1" HeaderText="原因" SortExpression="sReserve1" />
                                                            <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                                                            <asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="dDateTime" HeaderText="dDateTime" SortExpression="dDateTime"
                                                                Visible="False" />
                                                            <asp:BoundField DataField="iTime" HeaderText="iTime" SortExpression="iTime" Visible="False" />
                                                            <asp:TemplateField HeaderText="檔案下載">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtnDownload" runat="server" CommandArgument='<%# Eval("sNobr") %>'
                                                                        CommandName="Download">附件</asp:LinkButton>
                                                                </ItemTemplate>
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                                                        <EmptyDataTemplate>
                                                            目前沒有人忘刷。
                                                        </EmptyDataTemplate>
                                                        <EditRowStyle BackColor="#2461BF" />
                                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                                                        <AlternatingRowStyle BackColor="White" />
                                                    </asp:GridView>
                                                    <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                        SelectCommand="SELECT * FROM [wfCardAppS] WHERE ([sProcessID] = @sProcessID)">
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
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
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
                                                            DeleteCommand="DELETE FROM [wfShiftAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (sProcessID = @sProcessID) AND (sFromCode = 'Card')">
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
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td class="UltraWebGrid1-hc" style="text-align: center">
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
                            <asp:RadioButtonList ID="rblCheck" runat="server" Font-Size="X-Large" RepeatDirection="Horizontal"
                                RepeatLayout="Flow">
                                <asp:ListItem Selected="True" Value="1">核准</asp:ListItem>
                                <asp:ListItem Value="0">駁回</asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:Button ID="btnSign" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                Font-Size="XX-Large" Font-Underline="False" ForeColor="Blue" OnClick="btnSign_Click"
                                OnClientClick="return confirm('您確定要送出傳簽嗎？');" Text="送出傳簽" />
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
                    </tr>
                </table>
                <asp:Label ID="lblUrl" runat="server"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
