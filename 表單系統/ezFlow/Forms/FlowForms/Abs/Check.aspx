<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="Abs_Check" Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>請假單---審核</title>
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
        <asp:Button ID="btnPrint" runat="server" CssClass="UltraWebGrid1-hc" OnClientClick="print();"
            Text="列印" meta:resourcekey="btnPrintResource1" />
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="center" class="style1" nowrap="nowrap">
                            請假單審核</td>
                    </tr>
                    <tr>
                        <td align="center" nowrap="nowrap">
                            <table border="0" class="WebPanel2ctl" style="width: 100%">
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <asp:FormView ID="fvAppM" runat="server" DataSourceID="sdsAppM" Width="100%" meta:resourcekey="fvAppMResource1">
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
                                                            單位：<asp:Label ID="d_nameLabel" runat="server" Font-Underline="True" Text='<%# Eval("sDeptName") %>' meta:resourcekey="d_nameLabelResource1"></asp:Label></td>
                                                        <td align="center" nowrap="nowrap" width="34%">
                                                            姓名：<asp:Label ID="name_cLabel" runat="server" Font-Underline="True" Text='<%# Eval("sName") %>' meta:resourcekey="name_cLabelResource1"></asp:Label></td>
                                                        <td align="right" nowrap="nowrap" width="33%">
                                                            工號：<asp:Label ID="NobrLabel" runat="server" Font-Underline="True" Text='<%# Eval("sNobr") %>' meta:resourcekey="NobrLabelResource1"></asp:Label></td>
                                                    </tr>
                                                </table>
                                                <asp:Label ID="lblDept" runat="server" Font-Underline="True" Text='<%# Eval("sDept") %>'
                                                    Visible="False" meta:resourcekey="lblDeptResource1"></asp:Label>
                                            </ItemTemplate>
                                        </asp:FormView>
                                        <asp:SqlDataSource ID="sdsAppM" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT * FROM [wfAbsAppM] WHERE ([sProcessID] = @sProcessID)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                                    Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:Label ID="lblProcessID" runat="server" Visible="False" meta:resourcekey="lblProcessIDResource1"></asp:Label><br />
                                        <asp:Label ID="lblNobr" runat="server" Visible="False" meta:resourcekey="lblNobrResource1"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td class="UltraWebGrid1-hc" style="text-align: center">
                                                    請假人員基本資料</td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                        CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None" OnRowCommand="gvAppS_RowCommand"
                                                        OnRowDataBound="gvAppS_RowDataBound" Width="100%" meta:resourcekey="gvAppSResource1">
                                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                        <Columns>
                                                            <asp:TemplateField meta:resourcekey="TemplateFieldResource1">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtnState" runat="server" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                        CommandName="State" meta:resourcekey="lbtnStateResource1" Text="此筆駁回"></asp:LinkButton>
                                                                </ItemTemplate>
                                                                <ItemStyle Width="1%" Wrap="False" />
                                                            </asp:TemplateField>
                                                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" meta:resourcekey="BoundFieldResource1" />
                                                            <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                                                Visible="False" meta:resourcekey="BoundFieldResource2" />
                                                            <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                                                Visible="False" meta:resourcekey="BoundFieldResource3" />
                                                            <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" meta:resourcekey="BoundFieldResource4" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" meta:resourcekey="BoundFieldResource5" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="sDept" HeaderText="sDept" SortExpression="sDept" Visible="False" meta:resourcekey="BoundFieldResource6" />
                                                            <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName" meta:resourcekey="BoundFieldResource7" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" meta:resourcekey="BoundFieldResource8" />
                                                            <asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                                                Visible="False" meta:resourcekey="BoundFieldResource9" />
                                                            <asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" meta:resourcekey="BoundFieldResource10" />
                                                            <asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                                                Visible="False" meta:resourcekey="BoundFieldResource11" />
                                                            <asp:BoundField DataField="sEmpcd" HeaderText="sEmpcd" SortExpression="sEmpcd" Visible="False" meta:resourcekey="BoundFieldResource12" />
                                                            <asp:BoundField DataField="sEmpcdName" HeaderText="sEmpcdName" SortExpression="sEmpcdName"
                                                                Visible="False" meta:resourcekey="BoundFieldResource13" />
                                                            <asp:BoundField DataField="dStrDateFull" HeaderText="開始日期時間" SortExpression="dStrDateFull" meta:resourcekey="BoundFieldResource14" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="dEndDateFull" HeaderText="結束日期時間" SortExpression="dEndDateFull" meta:resourcekey="BoundFieldResource15" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="dStrDate" DataFormatString="{0:d}" HeaderText="開始日期" HtmlEncode="False"
                                                                SortExpression="dStrDate" Visible="False" meta:resourcekey="BoundFieldResource16" />
                                                            <asp:BoundField DataField="dEndDate" DataFormatString="{0:d}" HeaderText="結束日期" HtmlEncode="False"
                                                                SortExpression="dEndDate" Visible="False" meta:resourcekey="BoundFieldResource17" />
                                                            <asp:BoundField DataField="sStrTime" HeaderText="開始時間" SortExpression="sStrTime" Visible="False" meta:resourcekey="BoundFieldResource18" />
                                                            <asp:BoundField DataField="sEndTime" HeaderText="結束時間" SortExpression="sEndTime" Visible="False" meta:resourcekey="BoundFieldResource19" />
                                                            <asp:BoundField DataField="sHcode" HeaderText="sHcode" SortExpression="sHcode" Visible="False" meta:resourcekey="BoundFieldResource20" />
                                                            <asp:BoundField DataField="sHname" HeaderText="假別" SortExpression="sHname" meta:resourcekey="BoundFieldResource21" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="iDay" HeaderText="天數" SortExpression="iDay" meta:resourcekey="BoundFieldResource22" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="iHour" HeaderText="時數" SortExpression="iHour" meta:resourcekey="BoundFieldResource23" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="iTotalDay" HeaderText="iTotalDay" SortExpression="iTotalDay"
                                                                Visible="False" meta:resourcekey="BoundFieldResource24" />
                                                            <asp:BoundField DataField="iTotalHour" HeaderText="iTotalHour" SortExpression="iTotalHour"
                                                                Visible="False" meta:resourcekey="BoundFieldResource25" />
                                                            <asp:BoundField DataField="sReserve1" HeaderText="類別" SortExpression="sReserve1" meta:resourcekey="BoundFieldResource26" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="sReserve2" HeaderText="sReserve2" SortExpression="sReserve2"
                                                                Visible="False" meta:resourcekey="BoundFieldResource27" />
                                                            <asp:BoundField DataField="sReserve3" HeaderText="例外" SortExpression="sReserve3" meta:resourcekey="BoundFieldResource28" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="sSalYYMM" HeaderText="sSalYYMM" SortExpression="sSalYYMM"
                                                                Visible="False" meta:resourcekey="BoundFieldResource29" />
                                                            <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" meta:resourcekey="CheckBoxFieldResource1" />
                                                            <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" meta:resourcekey="BoundFieldResource30" />
                                                            <asp:BoundField DataField="sAgentNobr1" HeaderText="sAgentNobr1" SortExpression="sAgentNobr1"
                                                                Visible="False" meta:resourcekey="BoundFieldResource31" />
                                                            <asp:BoundField DataField="sAgentName1" HeaderText="代理人" SortExpression="sAgentName1" meta:resourcekey="BoundFieldResource32" >
                                                                <ItemStyle HorizontalAlign="Center" />
                                                            </asp:BoundField>
                                                            <asp:BoundField DataField="sAgentNobr2" HeaderText="sAgentNobr2" SortExpression="sAgentNobr2"
                                                                Visible="False" meta:resourcekey="BoundFieldResource33" />
                                                            <asp:BoundField DataField="sAgentName2" HeaderText="知會人" SortExpression="sAgentName2" Visible="False" meta:resourcekey="BoundFieldResource34" />
                                                            <asp:BoundField DataField="sAgentNobr3" HeaderText="sAgentNobr3" SortExpression="sAgentNobr3"
                                                                Visible="False" meta:resourcekey="BoundFieldResource35" />
                                                            <asp:BoundField DataField="sAgentName3" HeaderText="sAgentName3" SortExpression="sAgentName3"
                                                                Visible="False" meta:resourcekey="BoundFieldResource36" />
                                                            <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" meta:resourcekey="CheckBoxFieldResource2" />
                                                            <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" meta:resourcekey="BoundFieldResource37" />
                                                            <asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate"
                                                                Visible="False" meta:resourcekey="BoundFieldResource38" />
                                                            <asp:TemplateField HeaderText="檔案下載" meta:resourcekey="TemplateFieldResource2">
                                                                <ItemTemplate>
                                                                    <asp:LinkButton ID="lbtnDownload" runat="server" CommandArgument='<%# Eval("sNobr") %>'
                                                                        CommandName="Download" meta:resourcekey="lbtnDownloadResource1">附件</asp:LinkButton>
                                                                </ItemTemplate>
                                                                <ItemStyle HorizontalAlign="Center" Width="1%" Wrap="False" />
                                                            </asp:TemplateField>
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
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            DeleteCommand="DELETE FROM [wfAbsAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfAbsAppS] WHERE ([sProcessID] = @sProcessID)">
                                            <DeleteParameters>
                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                            </DeleteParameters>
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                                    Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <asp:Panel ID="pNote" runat="server" meta:resourcekey="pNoteResource1">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        簽核者資料</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvNote" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsSign" ForeColor="#333333"
                                                            GridLines="None" Width="100%" meta:resourcekey="gvNoteResource1">
                                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                            <Columns>
                                                                <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" meta:resourcekey="BoundFieldResource39" />
                                                                <asp:BoundField DataField="sFromCode" HeaderText="sFromCode" SortExpression="sFromCode"
                                                                    Visible="False" meta:resourcekey="BoundFieldResource40" />
                                                                <asp:BoundField DataField="sFromName" HeaderText="sFromName" SortExpression="sFromName"
                                                                    Visible="False" meta:resourcekey="BoundFieldResource41" />
                                                                <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                                                    Visible="False" meta:resourcekey="BoundFieldResource42" />
                                                                <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                                                    Visible="False" meta:resourcekey="BoundFieldResource43" />
                                                                <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" meta:resourcekey="BoundFieldResource44" >
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" meta:resourcekey="BoundFieldResource45" >
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept" meta:resourcekey="BoundFieldResource46" >
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" meta:resourcekey="BoundFieldResource47" >
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" meta:resourcekey="BoundFieldResource48" />
                                                                <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" meta:resourcekey="CheckBoxFieldResource3" />
                                                                <asp:BoundField DataField="sSign" HeaderText="sSign" SortExpression="sSign" Visible="False" meta:resourcekey="BoundFieldResource49" />
                                                                <asp:BoundField DataField="dKeyDate" HeaderText="簽核時間" SortExpression="dKeyDate" meta:resourcekey="BoundFieldResource50" >
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
                                                        <asp:SqlDataSource ID="sdsSign" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            DeleteCommand="DELETE FROM [wfShiftAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (sProcessID = @sProcessID) AND (sFromCode = 'Abs')">
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
                                                    <asp:TextBox ID="txtNote" runat="server" Height="100px" TextMode="MultiLine" Width="100%" meta:resourcekey="txtNoteResource1"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:Label ID="lblNote" runat="server" meta:resourcekey="lblNoteResource1"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:RadioButtonList ID="rblCheck" runat="server" Font-Size="X-Large" RepeatDirection="Horizontal"
                                RepeatLayout="Flow" meta:resourcekey="rblCheckResource1">
                                <asp:ListItem Selected="True" Value="1" meta:resourcekey="ListItemResource1" Text="繼續傳送"></asp:ListItem>
                                <asp:ListItem Value="0" meta:resourcekey="ListItemResource2" Text="全部駁回"></asp:ListItem>
                            </asp:RadioButtonList></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:Button ID="btnSign" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                Font-Size="XX-Large" Font-Underline="False" ForeColor="Blue" OnClick="btnSign_Click"
                                OnClientClick="return confirm('您確定要送出傳簽嗎？');" Text="送出傳簽" meta:resourcekey="btnSignResource1" />
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red" meta:resourcekey="lblMsgResource1"></asp:Label></td>
                    </tr>
                </table>
                <asp:Label ID="lblUrl" runat="server" meta:resourcekey="lblUrlResource1"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
