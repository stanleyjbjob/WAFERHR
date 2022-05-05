<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CosData.aspx.cs" Inherits="TrainIn_CosData" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>線上報名---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <asp:Button ID="btnPrint" runat="server" CssClass="UltraWebGrid1-hc" OnClientClick="print();"
            Text="列印" />
        <table cellpadding="0" cellspacing="0" width="100%">
            <tr>
                <td class="UltraWebGrid1-hc">
                    課程名稱</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCosName" runat="server">無課程名稱。</asp:Label></td>
            </tr>
            <tr>
                <td class="UltraWebGrid1-hc">
                    建議訓練對象</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblTR_PERSON" runat="server">無訓練對象。</asp:Label></td>
            </tr>
            <tr>
                <td class="UltraWebGrid1-hc">
                    課程簡介</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblCOSINTRO" runat="server">無課程簡介。</asp:Label></td>
            </tr>
            <tr>
                <td class="UltraWebGrid1-hc">
                    課程講師</td>
            </tr>
            <tr>
                <td>
                    <asp:DataList ID="dlTcr" runat="server" DataSourceID="sdsTrtcr">
                        <ItemTemplate>
                            <asp:Label ID="lblTcrName" runat="server" Text='<%# Eval("TCR_NO") %>' Visible="False"></asp:Label><asp:FormView
                                ID="fvTrtcr" runat="server" DataKeyNames="TCR_NO" DataSourceID="sdsTrtcr1" Width="100%">
                                <EditItemTemplate>
                                    TCR_NO:
                                    <asp:Label ID="TCR_NOLabel1" runat="server" Text='<%# Eval("TCR_NO") %>'></asp:Label><br />
                                    TCR_NAME:
                                    <asp:TextBox ID="TCR_NAMETextBox" runat="server" Text='<%# Bind("TCR_NAME") %>'>
                </asp:TextBox><br />
                                    ADDR1:
                                    <asp:TextBox ID="ADDR1TextBox" runat="server" Text='<%# Bind("ADDR1") %>'>
                </asp:TextBox><br />
                                    ADDR2:
                                    <asp:TextBox ID="ADDR2TextBox" runat="server" Text='<%# Bind("ADDR2") %>'>
                </asp:TextBox><br />
                                    TEL1:
                                    <asp:TextBox ID="TEL1TextBox" runat="server" Text='<%# Bind("TEL1") %>'>
                </asp:TextBox><br />
                                    TEL2:
                                    <asp:TextBox ID="TEL2TextBox" runat="server" Text='<%# Bind("TEL2") %>'>
                </asp:TextBox><br />
                                    GSM:
                                    <asp:TextBox ID="GSMTextBox" runat="server" Text='<%# Bind("GSM") %>'>
                </asp:TextBox><br />
                                    BBC:
                                    <asp:TextBox ID="BBCTextBox" runat="server" Text='<%# Bind("BBC") %>'>
                </asp:TextBox><br />
                                    EMAIL:
                                    <asp:TextBox ID="EMAILTextBox" runat="server" Text='<%# Bind("EMAIL") %>'>
                </asp:TextBox><br />
                                    KEY_MAN:
                                    <asp:TextBox ID="KEY_MANTextBox" runat="server" Text='<%# Bind("KEY_MAN") %>'>
                </asp:TextBox><br />
                                    KEY_DATE:
                                    <asp:TextBox ID="KEY_DATETextBox" runat="server" Text='<%# Bind("KEY_DATE") %>'>
                </asp:TextBox><br />
                                    IDNO:
                                    <asp:TextBox ID="IDNOTextBox" runat="server" Text='<%# Bind("IDNO") %>'>
                </asp:TextBox><br />
                                    INCOMP:
                                    <asp:CheckBox ID="INCOMPCheckBox" runat="server" Checked='<%# Bind("INCOMP") %>' /><br />
                                    SPECIALITY:
                                    <asp:TextBox ID="SPECIALITYTextBox" runat="server" Text='<%# Bind("SPECIALITY") %>'>
                </asp:TextBox><br />
                                    SCHOOL:
                                    <asp:TextBox ID="SCHOOLTextBox" runat="server" Text='<%# Bind("SCHOOL") %>'>
                </asp:TextBox><br />
                                    TCR_NAMEE:
                                    <asp:TextBox ID="TCR_NAMEETextBox" runat="server" Text='<%# Bind("TCR_NAMEE") %>'>
                </asp:TextBox><br />
                                    FAX:
                                    <asp:TextBox ID="FAXTextBox" runat="server" Text='<%# Bind("FAX") %>'>
                </asp:TextBox><br />
                                    TRUSE:
                                    <asp:CheckBox ID="TRUSECheckBox" runat="server" Checked='<%# Bind("TRUSE") %>' /><br />
                                    TAXNO:
                                    <asp:TextBox ID="TAXNOTextBox" runat="server" Text='<%# Bind("TAXNO") %>'>
                </asp:TextBox><br />
                                    COMPY:
                                    <asp:TextBox ID="COMPYTextBox" runat="server" Text='<%# Bind("COMPY") %>'>
                </asp:TextBox><br />
                                    CONT_MA:
                                    <asp:TextBox ID="CONT_MATextBox" runat="server" Text='<%# Bind("CONT_MA") %>'>
                </asp:TextBox><br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="更新">
                </asp:LinkButton>
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="取消">
                </asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    TCR_NO:
                                    <asp:TextBox ID="TCR_NOTextBox" runat="server" Text='<%# Bind("TCR_NO") %>'>
                </asp:TextBox><br />
                                    TCR_NAME:
                                    <asp:TextBox ID="TCR_NAMETextBox" runat="server" Text='<%# Bind("TCR_NAME") %>'>
                </asp:TextBox><br />
                                    ADDR1:
                                    <asp:TextBox ID="ADDR1TextBox" runat="server" Text='<%# Bind("ADDR1") %>'>
                </asp:TextBox><br />
                                    ADDR2:
                                    <asp:TextBox ID="ADDR2TextBox" runat="server" Text='<%# Bind("ADDR2") %>'>
                </asp:TextBox><br />
                                    TEL1:
                                    <asp:TextBox ID="TEL1TextBox" runat="server" Text='<%# Bind("TEL1") %>'>
                </asp:TextBox><br />
                                    TEL2:
                                    <asp:TextBox ID="TEL2TextBox" runat="server" Text='<%# Bind("TEL2") %>'>
                </asp:TextBox><br />
                                    GSM:
                                    <asp:TextBox ID="GSMTextBox" runat="server" Text='<%# Bind("GSM") %>'>
                </asp:TextBox><br />
                                    BBC:
                                    <asp:TextBox ID="BBCTextBox" runat="server" Text='<%# Bind("BBC") %>'>
                </asp:TextBox><br />
                                    EMAIL:
                                    <asp:TextBox ID="EMAILTextBox" runat="server" Text='<%# Bind("EMAIL") %>'>
                </asp:TextBox><br />
                                    KEY_MAN:
                                    <asp:TextBox ID="KEY_MANTextBox" runat="server" Text='<%# Bind("KEY_MAN") %>'>
                </asp:TextBox><br />
                                    KEY_DATE:
                                    <asp:TextBox ID="KEY_DATETextBox" runat="server" Text='<%# Bind("KEY_DATE") %>'>
                </asp:TextBox><br />
                                    IDNO:
                                    <asp:TextBox ID="IDNOTextBox" runat="server" Text='<%# Bind("IDNO") %>'>
                </asp:TextBox><br />
                                    INCOMP:
                                    <asp:CheckBox ID="INCOMPCheckBox" runat="server" Checked='<%# Bind("INCOMP") %>' /><br />
                                    SPECIALITY:
                                    <asp:TextBox ID="SPECIALITYTextBox" runat="server" Text='<%# Bind("SPECIALITY") %>'>
                </asp:TextBox><br />
                                    SCHOOL:
                                    <asp:TextBox ID="SCHOOLTextBox" runat="server" Text='<%# Bind("SCHOOL") %>'>
                </asp:TextBox><br />
                                    TCR_NAMEE:
                                    <asp:TextBox ID="TCR_NAMEETextBox" runat="server" Text='<%# Bind("TCR_NAMEE") %>'>
                </asp:TextBox><br />
                                    FAX:
                                    <asp:TextBox ID="FAXTextBox" runat="server" Text='<%# Bind("FAX") %>'>
                </asp:TextBox><br />
                                    TRUSE:
                                    <asp:CheckBox ID="TRUSECheckBox" runat="server" Checked='<%# Bind("TRUSE") %>' /><br />
                                    TAXNO:
                                    <asp:TextBox ID="TAXNOTextBox" runat="server" Text='<%# Bind("TAXNO") %>'>
                </asp:TextBox><br />
                                    COMPY:
                                    <asp:TextBox ID="COMPYTextBox" runat="server" Text='<%# Bind("COMPY") %>'>
                </asp:TextBox><br />
                                    CONT_MA:
                                    <asp:TextBox ID="CONT_MATextBox" runat="server" Text='<%# Bind("CONT_MA") %>'>
                </asp:TextBox><br />
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                        Text="插入">
                </asp:LinkButton>
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="取消">
                </asp:LinkButton>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <table cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                姓名</td>
                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                學歷</td>
                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                專長</td>
                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                信箱</td>
                                        </tr>
                                        <tr>
                                            <td align="center" nowrap="nowrap">
                                                <asp:Label ID="TCR_NAMELabel" runat="server" Text='<%# Bind("TCR_NAME") %>'></asp:Label></td>
                                            <td align="center" nowrap="nowrap">
                                                <asp:Label ID="SCHOOLLabel" runat="server" Text='<%# Bind("SCHOOL") %>'></asp:Label></td>
                                            <td align="center" nowrap="nowrap">
                                                <asp:Label ID="SPECIALITYLabel" runat="server" Text='<%# Bind("SPECIALITY") %>'></asp:Label></td>
                                            <td align="center" nowrap="nowrap">
                                                <asp:Label ID="EMAILLabel" runat="server" Text='<%# Bind("EMAIL") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource ID="sdsTrtcr1" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                SelectCommand="SELECT * FROM [TRTCR] WHERE ([TCR_NO] = @TCR_NO)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblTcrName" DefaultValue="0" Name="TCR_NO" PropertyName="Text"
                                        Type="String" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </ItemTemplate>
                    </asp:DataList>
                    <asp:SqlDataSource ID="sdsTrtcr" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                        SelectCommand="SELECT TRTCRDT.TCR_NO, TRTCR.TCR_NAME FROM TRTCRDT INNER JOIN TRTCR ON TRTCRDT.TCR_NO = TRTCR.TCR_NO WHERE (RTRIM(TRTCRDT.COSCODE) + RTRIM(TRTCRDT.YYMM) + RTRIM(TRTCRDT.SER) = @COS)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblProcessID" Name="COS" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td class="UltraWebGrid1-hc">
                    相關檔案</td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvUpload" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CellPadding="4" DataSourceID="sdsUpload" ForeColor="#333333" GridLines="None"
                        OnRowCommand="gvUpload_RowCommand" PageSize="5" Width="100%">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                        CommandName="Download" Text="下載"></asp:LinkButton>
                                </ItemTemplate>
                                <ItemStyle Width="1%" Wrap="False" />
                            </asp:TemplateField>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sFromName" HeaderText="sFromName" SortExpression="sFromName"
                                Visible="False" />
                            <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                Visible="False" />
                            <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                Visible="False" />
                            <asp:BoundField DataField="sNobr" HeaderText="sNobr" SortExpression="sNobr" Visible="False" />
                            <asp:BoundField DataField="sUpName" HeaderText="檔名" SortExpression="sUpName" />
                            <asp:BoundField DataField="sType" HeaderText="檔案類別" SortExpression="sType" />
                            <asp:BoundField DataField="iSize" HeaderText="檔案大小(KB)" SortExpression="iSize" />
                            <asp:BoundField DataField="sServerName" HeaderText="sServerName" SortExpression="sServerName"
                                Visible="False" />
                            <asp:BoundField DataField="sDesc" HeaderText="簡介" SortExpression="sDesc" />
                            <asp:BoundField DataField="dUpDate" HeaderText="上傳時間" SortExpression="dUpDate" />
                        </Columns>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            沒有任何附件。
                        </EmptyDataTemplate>
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <EditRowStyle BackColor="#2461BF" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsUpload" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        DeleteCommand="DELETE FROM [wfUpFile] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfUpFile] WHERE ([sProcessID] = @sProcessID) ">
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label></td>
            </tr>
            <tr>
                <td class="UltraWebGrid1-hc">
                    備註</td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMENO" runat="server">無備註。</asp:Label></td>
            </tr>
        </table>
    
    </div>
        <asp:Label ID="lblMsg" runat="server"></asp:Label>
    </form>
</body>
</html>
