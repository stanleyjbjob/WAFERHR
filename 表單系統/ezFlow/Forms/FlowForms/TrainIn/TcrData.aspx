<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TcrData.aspx.cs" Inherits="TrainIn_TcrData" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>線上報名---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <asp:FormView ID="fvTrtcr" runat="server" DataKeyNames="TCR_NO" DataSourceID="sdsTrtcr"
            Width="100%">
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
                            電話</td>
                        <td class="UltraWebGrid1-hc" nowrap="nowrap">
                            地址</td>
                    </tr>
                    <tr>
                        <td align="center" nowrap="nowrap">
                            <asp:Label ID="TCR_NAMELabel" runat="server" Text='<%# Bind("TCR_NAME") %>'></asp:Label></td>
                        <td align="center" nowrap="nowrap">
                            <asp:Label ID="TEL1Label" runat="server" Text='<%# Bind("TEL1") %>'></asp:Label></td>
                        <td align="center" nowrap="nowrap">
                            <asp:Label ID="ADDR1Label" runat="server" Text='<%# Bind("ADDR1") %>'></asp:Label></td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-hc" nowrap="nowrap">
                            學歷</td>
                        <td class="UltraWebGrid1-hc" nowrap="nowrap">
                            專長</td>
                        <td class="UltraWebGrid1-hc" nowrap="nowrap">
                            信箱</td>
                    </tr>
                    <tr>
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
    
    </div>
        <asp:SqlDataSource ID="sdsTrtcr" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
            SelectCommand="SELECT * FROM [TRTCR] WHERE ([TCR_NO] = @TCR_NO)">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblKey" Name="TCR_NO" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblKey" runat="server" Visible="False"></asp:Label>
    </form>
</body>
</html>
