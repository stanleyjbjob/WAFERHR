<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Preview.aspx.cs" Inherits="TrLearned_Preview" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
</head>
<body>
    <form id="form1" runat="server">
    <div align="center"><table>
        <tr>
                <td style="width: 100px">
                    <asp:Image ID="imgLogo" runat="server" Height="93px" ImageUrl="~/images/logo.JPG"
                        Width="162px" /></td>
                <td>
                    <asp:Label ID="lblTitle" runat="server" Font-Size="20pt" Text="合 晶 科 技 股 份 有 限 公 司"></asp:Label></td>
        </tr>
    </table>
        <table width="90%">
            <tr>
                <td align="center" colspan="2">
                    <asp:Label ID="lblTitleE" runat="server" Text="Wafer Works Corp"></asp:Label></td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:Label ID="lblFormName" runat="server" Text="教育訓練 心得報告表"></asp:Label></td>
            </tr>
            <tr>
                <td align="center" colspan="2">
                    <asp:FormView ID="FV" runat="server" DataKeyNames="iAutoKey" DataSourceID="dsFV"
                        Width="100%">
                        <EditItemTemplate>
                            iAutoKey:
                            <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>'></asp:Label><br />
                            sProcessID:
                            <asp:TextBox ID="sProcessIDTextBox" runat="server" Text='<%# Bind("sProcessID") %>'>
                            </asp:TextBox><br />
                            idProcess:
                            <asp:TextBox ID="idProcessTextBox" runat="server" Text='<%# Bind("idProcess") %>'>
                            </asp:TextBox><br />
                            sNobr:
                            <asp:TextBox ID="sNobrTextBox" runat="server" Text='<%# Bind("sNobr") %>'>
                            </asp:TextBox><br />
                            sName:
                            <asp:TextBox ID="sNameTextBox" runat="server" Text='<%# Bind("sName") %>'>
                            </asp:TextBox><br />
                            sDept:
                            <asp:TextBox ID="sDeptTextBox" runat="server" Text='<%# Bind("sDept") %>'>
                            </asp:TextBox><br />
                            sJob:
                            <asp:TextBox ID="sJobTextBox" runat="server" Text='<%# Bind("sJob") %>'>
                            </asp:TextBox><br />
                            sJobName:
                            <asp:TextBox ID="sJobNameTextBox" runat="server" Text='<%# Bind("sJobName") %>'>
                            </asp:TextBox><br />
                            sJobl:
                            <asp:TextBox ID="sJoblTextBox" runat="server" Text='<%# Bind("sJobl") %>'>
                            </asp:TextBox><br />
                            sJoblName:
                            <asp:TextBox ID="sJoblNameTextBox" runat="server" Text='<%# Bind("sJoblName") %>'>
                            </asp:TextBox><br />
                            sDeptName:
                            <asp:TextBox ID="sDeptNameTextBox" runat="server" Text='<%# Bind("sDeptName") %>'>
                            </asp:TextBox><br />
                            sApplyNo:
                            <asp:TextBox ID="sApplyNoTextBox" runat="server" Text='<%# Bind("sApplyNo") %>'>
                            </asp:TextBox><br />
                            sCourseName:
                            <asp:TextBox ID="sCourseNameTextBox" runat="server" Text='<%# Bind("sCourseName") %>'>
                            </asp:TextBox><br />
                            dDateB:
                            <asp:TextBox ID="dDateBTextBox" runat="server" Text='<%# Bind("dDateB") %>'>
                            </asp:TextBox><br />
                            dDateE:
                            <asp:TextBox ID="dDateETextBox" runat="server" Text='<%# Bind("dDateE") %>'>
                            </asp:TextBox><br />
                            sAddress:
                            <asp:TextBox ID="sAddressTextBox" runat="server" Text='<%# Bind("sAddress") %>'>
                            </asp:TextBox><br />
                            sTcrName1:
                            <asp:TextBox ID="sTcrName1TextBox" runat="server" Text='<%# Bind("sTcrName1") %>'>
                            </asp:TextBox><br />
                            sTcrName2:
                            <asp:TextBox ID="sTcrName2TextBox" runat="server" Text='<%# Bind("sTcrName2") %>'>
                            </asp:TextBox><br />
                            sTcrName3:
                            <asp:TextBox ID="sTcrName3TextBox" runat="server" Text='<%# Bind("sTcrName3") %>'>
                            </asp:TextBox><br />
                            sTcrName4:
                            <asp:TextBox ID="sTcrName4TextBox" runat="server" Text='<%# Bind("sTcrName4") %>'>
                            </asp:TextBox><br />
                            sTcrName5:
                            <asp:TextBox ID="sTcrName5TextBox" runat="server" Text='<%# Bind("sTcrName5") %>'>
                            </asp:TextBox><br />
                            sContent:
                            <asp:TextBox ID="sContentTextBox" runat="server" Text='<%# Bind("sContent") %>'>
                            </asp:TextBox><br />
                            sLearned:
                            <asp:TextBox ID="sLearnedTextBox" runat="server" Text='<%# Bind("sLearned") %>'>
                            </asp:TextBox><br />
                            sEffor1:
                            <asp:TextBox ID="sEffor1TextBox" runat="server" Text='<%# Bind("sEffor1") %>'>
                            </asp:TextBox><br />
                            sEffor2:
                            <asp:TextBox ID="sEffor2TextBox" runat="server" Text='<%# Bind("sEffor2") %>'>
                            </asp:TextBox><br />
                            sEffor3:
                            <asp:TextBox ID="sEffor3TextBox" runat="server" Text='<%# Bind("sEffor3") %>'>
                            </asp:TextBox><br />
                            sEffor4:
                            <asp:TextBox ID="sEffor4TextBox" runat="server" Text='<%# Bind("sEffor4") %>'>
                            </asp:TextBox><br />
                            sComment:
                            <asp:TextBox ID="sCommentTextBox" runat="server" Text='<%# Bind("sComment") %>'>
                            </asp:TextBox><br />
                            sReason:
                            <asp:TextBox ID="sReasonTextBox" runat="server" Text='<%# Bind("sReason") %>'>
                            </asp:TextBox><br />
                            sMangAppraise:
                            <asp:TextBox ID="sMangAppraiseTextBox" runat="server" Text='<%# Bind("sMangAppraise") %>'>
                            </asp:TextBox><br />
                            sNote:
                            <asp:TextBox ID="sNoteTextBox" runat="server" Text='<%# Bind("sNote") %>'>
                            </asp:TextBox><br />
                            sReserve1:
                            <asp:TextBox ID="sReserve1TextBox" runat="server" Text='<%# Bind("sReserve1") %>'>
                            </asp:TextBox><br />
                            sReserve2:
                            <asp:TextBox ID="sReserve2TextBox" runat="server" Text='<%# Bind("sReserve2") %>'>
                            </asp:TextBox><br />
                            sReserve3:
                            <asp:TextBox ID="sReserve3TextBox" runat="server" Text='<%# Bind("sReserve3") %>'>
                            </asp:TextBox><br />
                            bAuth:
                            <asp:CheckBox ID="bAuthCheckBox" runat="server" Checked='<%# Bind("bAuth") %>' /><br />
                            bSign:
                            <asp:CheckBox ID="bSignCheckBox" runat="server" Checked='<%# Bind("bSign") %>' /><br />
                            iTotalHour:
                            <asp:TextBox ID="iTotalHourTextBox" runat="server" Text='<%# Bind("iTotalHour") %>'>
                            </asp:TextBox><br />
                            sState:
                            <asp:TextBox ID="sStateTextBox" runat="server" Text='<%# Bind("sState") %>'>
                            </asp:TextBox><br />
                            sConditions1:
                            <asp:TextBox ID="sConditions1TextBox" runat="server" Text='<%# Bind("sConditions1") %>'>
                            </asp:TextBox><br />
                            sConditions2:
                            <asp:TextBox ID="sConditions2TextBox" runat="server" Text='<%# Bind("sConditions2") %>'>
                            </asp:TextBox><br />
                            sConditions3:
                            <asp:TextBox ID="sConditions3TextBox" runat="server" Text='<%# Bind("sConditions3") %>'>
                            </asp:TextBox><br />
                            sConditions4:
                            <asp:TextBox ID="sConditions4TextBox" runat="server" Text='<%# Bind("sConditions4") %>'>
                            </asp:TextBox><br />
                            sConditions5:
                            <asp:TextBox ID="sConditions5TextBox" runat="server" Text='<%# Bind("sConditions5") %>'>
                            </asp:TextBox><br />
                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                Text="更新">
                            </asp:LinkButton>
                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="取消">
                            </asp:LinkButton>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            sProcessID:
                            <asp:TextBox ID="sProcessIDTextBox" runat="server" Text='<%# Bind("sProcessID") %>'>
                            </asp:TextBox><br />
                            idProcess:
                            <asp:TextBox ID="idProcessTextBox" runat="server" Text='<%# Bind("idProcess") %>'>
                            </asp:TextBox><br />
                            sNobr:
                            <asp:TextBox ID="sNobrTextBox" runat="server" Text='<%# Bind("sNobr") %>'>
                            </asp:TextBox><br />
                            sName:
                            <asp:TextBox ID="sNameTextBox" runat="server" Text='<%# Bind("sName") %>'>
                            </asp:TextBox><br />
                            sDept:
                            <asp:TextBox ID="sDeptTextBox" runat="server" Text='<%# Bind("sDept") %>'>
                            </asp:TextBox><br />
                            sJob:
                            <asp:TextBox ID="sJobTextBox" runat="server" Text='<%# Bind("sJob") %>'>
                            </asp:TextBox><br />
                            sJobName:
                            <asp:TextBox ID="sJobNameTextBox" runat="server" Text='<%# Bind("sJobName") %>'>
                            </asp:TextBox><br />
                            sJobl:
                            <asp:TextBox ID="sJoblTextBox" runat="server" Text='<%# Bind("sJobl") %>'>
                            </asp:TextBox><br />
                            sJoblName:
                            <asp:TextBox ID="sJoblNameTextBox" runat="server" Text='<%# Bind("sJoblName") %>'>
                            </asp:TextBox><br />
                            sDeptName:
                            <asp:TextBox ID="sDeptNameTextBox" runat="server" Text='<%# Bind("sDeptName") %>'>
                            </asp:TextBox><br />
                            sApplyNo:
                            <asp:TextBox ID="sApplyNoTextBox" runat="server" Text='<%# Bind("sApplyNo") %>'>
                            </asp:TextBox><br />
                            sCourseName:
                            <asp:TextBox ID="sCourseNameTextBox" runat="server" Text='<%# Bind("sCourseName") %>'>
                            </asp:TextBox><br />
                            dDateB:
                            <asp:TextBox ID="dDateBTextBox" runat="server" Text='<%# Bind("dDateB") %>'>
                            </asp:TextBox><br />
                            dDateE:
                            <asp:TextBox ID="dDateETextBox" runat="server" Text='<%# Bind("dDateE") %>'>
                            </asp:TextBox><br />
                            sAddress:
                            <asp:TextBox ID="sAddressTextBox" runat="server" Text='<%# Bind("sAddress") %>'>
                            </asp:TextBox><br />
                            sTcrName1:
                            <asp:TextBox ID="sTcrName1TextBox" runat="server" Text='<%# Bind("sTcrName1") %>'>
                            </asp:TextBox><br />
                            sTcrName2:
                            <asp:TextBox ID="sTcrName2TextBox" runat="server" Text='<%# Bind("sTcrName2") %>'>
                            </asp:TextBox><br />
                            sTcrName3:
                            <asp:TextBox ID="sTcrName3TextBox" runat="server" Text='<%# Bind("sTcrName3") %>'>
                            </asp:TextBox><br />
                            sTcrName4:
                            <asp:TextBox ID="sTcrName4TextBox" runat="server" Text='<%# Bind("sTcrName4") %>'>
                            </asp:TextBox><br />
                            sTcrName5:
                            <asp:TextBox ID="sTcrName5TextBox" runat="server" Text='<%# Bind("sTcrName5") %>'>
                            </asp:TextBox><br />
                            sContent:
                            <asp:TextBox ID="sContentTextBox" runat="server" Text='<%# Bind("sContent") %>'>
                            </asp:TextBox><br />
                            sLearned:
                            <asp:TextBox ID="sLearnedTextBox" runat="server" Text='<%# Bind("sLearned") %>'>
                            </asp:TextBox><br />
                            sEffor1:
                            <asp:TextBox ID="sEffor1TextBox" runat="server" Text='<%# Bind("sEffor1") %>'>
                            </asp:TextBox><br />
                            sEffor2:
                            <asp:TextBox ID="sEffor2TextBox" runat="server" Text='<%# Bind("sEffor2") %>'>
                            </asp:TextBox><br />
                            sEffor3:
                            <asp:TextBox ID="sEffor3TextBox" runat="server" Text='<%# Bind("sEffor3") %>'>
                            </asp:TextBox><br />
                            sEffor4:
                            <asp:TextBox ID="sEffor4TextBox" runat="server" Text='<%# Bind("sEffor4") %>'>
                            </asp:TextBox><br />
                            sComment:
                            <asp:TextBox ID="sCommentTextBox" runat="server" Text='<%# Bind("sComment") %>'>
                            </asp:TextBox><br />
                            sReason:
                            <asp:TextBox ID="sReasonTextBox" runat="server" Text='<%# Bind("sReason") %>'>
                            </asp:TextBox><br />
                            sMangAppraise:
                            <asp:TextBox ID="sMangAppraiseTextBox" runat="server" Text='<%# Bind("sMangAppraise") %>'>
                            </asp:TextBox><br />
                            sNote:
                            <asp:TextBox ID="sNoteTextBox" runat="server" Text='<%# Bind("sNote") %>'>
                            </asp:TextBox><br />
                            sReserve1:
                            <asp:TextBox ID="sReserve1TextBox" runat="server" Text='<%# Bind("sReserve1") %>'>
                            </asp:TextBox><br />
                            sReserve2:
                            <asp:TextBox ID="sReserve2TextBox" runat="server" Text='<%# Bind("sReserve2") %>'>
                            </asp:TextBox><br />
                            sReserve3:
                            <asp:TextBox ID="sReserve3TextBox" runat="server" Text='<%# Bind("sReserve3") %>'>
                            </asp:TextBox><br />
                            bAuth:
                            <asp:CheckBox ID="bAuthCheckBox" runat="server" Checked='<%# Bind("bAuth") %>' /><br />
                            bSign:
                            <asp:CheckBox ID="bSignCheckBox" runat="server" Checked='<%# Bind("bSign") %>' /><br />
                            iTotalHour:
                            <asp:TextBox ID="iTotalHourTextBox" runat="server" Text='<%# Bind("iTotalHour") %>'>
                            </asp:TextBox><br />
                            sState:
                            <asp:TextBox ID="sStateTextBox" runat="server" Text='<%# Bind("sState") %>'>
                            </asp:TextBox><br />
                            sConditions1:
                            <asp:TextBox ID="sConditions1TextBox" runat="server" Text='<%# Bind("sConditions1") %>'>
                            </asp:TextBox><br />
                            sConditions2:
                            <asp:TextBox ID="sConditions2TextBox" runat="server" Text='<%# Bind("sConditions2") %>'>
                            </asp:TextBox><br />
                            sConditions3:
                            <asp:TextBox ID="sConditions3TextBox" runat="server" Text='<%# Bind("sConditions3") %>'>
                            </asp:TextBox><br />
                            sConditions4:
                            <asp:TextBox ID="sConditions4TextBox" runat="server" Text='<%# Bind("sConditions4") %>'>
                            </asp:TextBox><br />
                            sConditions5:
                            <asp:TextBox ID="sConditions5TextBox" runat="server" Text='<%# Bind("sConditions5") %>'>
                            </asp:TextBox><br />
                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                Text="插入">
                            </asp:LinkButton>
                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                Text="取消">
                            </asp:LinkButton>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table width="100%">
                                <tr>
                                    <td>
                                        編號：<asp:Label ID="lblApplyNO" runat="server" Text='<%# Eval("sApplyNo") %>'></asp:Label></td>
                                    <td>
                                        部門：<asp:Label ID="lblDept" runat="server" Text='<%# Eval("sDeptName") %>'></asp:Label></td>
                                    <td>
                                        工號：<asp:Label ID="lblNobr" runat="server" Text='<%# Eval("sNobr") %>'></asp:Label></td>
                                    <td>
                                        報告人：<asp:Label ID="lblKeyMan" runat="server" Text='<%# Eval("sName") %>'></asp:Label></td>
                                    <td>
                                        日期：<asp:Label ID="lblKeyDate" runat="server" Text='<%# Eval("dDateB", "{0:d}") %>'></asp:Label></td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="dsFV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                        SelectCommand="SELECT * FROM [TRLEARNED] WHERE ([idProcess] = @idProcess)">
                        <SelectParameters>
                            <asp:QueryStringParameter Name="idProcess" QueryStringField="idProcess" Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <table border="2" bordercolor="#000033" width="90%">
            <tr>
                <td align="center" colspan="1" width="20%">
                    課程名稱</td>
                <td align="left" colspan="2" width="80%">
                    <asp:Label ID="lblCourseName" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="center" colspan="1">
                    課程時間</td>
                <td align="left" colspan="2">
                    <asp:Label ID="lblDateB" runat="server"></asp:Label>
                    至
                    <asp:Label ID="lblDateE" runat="server"></asp:Label>
                    &nbsp; &nbsp;
                    <asp:Label ID="lblTimeB" runat="server"></asp:Label>到<asp:Label ID="lblTimeE" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="center" colspan="1">
                    課程地點</td>
                <td align="left" colspan="2">
                    <asp:Label ID="lblAddress" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="center" colspan="1">
                    講 &nbsp; &nbsp; &nbsp;&nbsp; 師</td>
                <td align="left" colspan="2">
                    <asp:Label ID="lblTcr1" runat="server"></asp:Label>&nbsp; &nbsp;
                    <asp:Label ID="lblTcr2" runat="server"></asp:Label>
                    &nbsp; &nbsp;<asp:Label ID="lblTcr3" runat="server"></asp:Label>
                    &nbsp; &nbsp;<asp:Label ID="lblTcr4" runat="server"></asp:Label>
                    &nbsp; &nbsp;<asp:Label ID="lblTcr5" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" colspan="3">
                    1.課程內容：<asp:Label ID="lblContent" runat="server"></asp:Label><br />
                    <br />
                </td>
            </tr>
            <tr>
                <td align="left" colspan="3">
                    2.心得報告：<asp:Label ID="lblLearned" runat="server"></asp:Label><br />
                    <br />
                </td>
            </tr>
            <tr>
                <td align="left" colspan="3">
                    3.成果：<br />
                    &nbsp; A.對工作助益：<asp:Label ID="lblEffor1" runat="server"></asp:Label>
                    <asp:RadioButtonList ID="rblEffor1" runat="server" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" Visible="False">
                        <asp:ListItem Selected="True" Value="5">極大</asp:ListItem>
                        <asp:ListItem Value="4">大</asp:ListItem>
                        <asp:ListItem Value="3">尚可</asp:ListItem>
                        <asp:ListItem Value="2">小</asp:ListItem>
                        <asp:ListItem Value="1">極小</asp:ListItem>
                    </asp:RadioButtonList><br />
                    &nbsp; B.對個人成長：<asp:Label ID="lblEffor2" runat="server"></asp:Label>
                    <asp:RadioButtonList ID="rblEffor2" runat="server" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" Visible="False">
                        <asp:ListItem Selected="True" Value="5">極大</asp:ListItem>
                        <asp:ListItem Value="4">大</asp:ListItem>
                        <asp:ListItem Value="3">尚可</asp:ListItem>
                        <asp:ListItem Value="2">小</asp:ListItem>
                        <asp:ListItem Value="1">極小</asp:ListItem>
                    </asp:RadioButtonList><br />
                    &nbsp; C.你給予本課程/講師的評語為何？<asp:Label ID="lblComment" runat="server"></asp:Label>
                    <asp:RadioButtonList ID="rblComment" runat="server" RepeatDirection="Horizontal"
                        RepeatLayout="Flow" Visible="False">
                        <asp:ListItem Selected="True" Value="5">極佳</asp:ListItem>
                        <asp:ListItem Value="4">佳</asp:ListItem>
                        <asp:ListItem Value="3">尚可</asp:ListItem>
                        <asp:ListItem Value="2">欠佳</asp:ListItem>
                        <asp:ListItem Value="1">極差</asp:ListItem>
                    </asp:RadioButtonList><br />
                    &nbsp; &nbsp; &nbsp; 理由：<asp:Label ID="lblReason" runat="server"></asp:Label></td>
            </tr>
            <tr>
                <td align="left" colspan="3">
                    4.主管評核：<asp:Label ID="lblMangAppraise" runat="server"></asp:Label><br />
                    <br />
                </td>
            </tr>
            <tr>
                <td align="left" colspan="3">
                    <asp:Label ID="lblFlow" runat="server"></asp:Label></td>
            </tr>
        </table>
        <table style="width: 90%">
            <tr>
                <td align="left" width="33%">
                    表單編號：<asp:Label ID="lblFormNo" runat="server"></asp:Label></td>
                <td align="left" width="33%">
                    版次：<asp:Label ID="lblEdition" runat="server"></asp:Label></td>
                <td align="left" width="33%">
                    正本保存單位：<asp:Label ID="lblSaveUnit" runat="server"></asp:Label></td>
            </tr>
        </table>
        <br />
        <asp:Button ID="btnPrint" runat="server" OnClick="btnPrint_Click" OnClientClick="parent.top.focus();window.print()"
            Text="列印此頁" /></div>
    </form>
</body>
</html>
