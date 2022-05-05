<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>未命名頁面</title>
    <link href="CSS/general.css" rel="stylesheet" type="text/css">
    <link href="CSS/StyleSheet.css" rel="stylesheet" type="text/css">
    <asp:literal runat="server" id="ltModalProgress"></asp:literal>
</head>
<body>
    <form id="form1" runat="server">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server">
        </asp:ToolkitScriptManager>

        <script type="text/javascript" src="Script/jsUpdateProgress.js"></script>

        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <asp:Panel ID="panelUpdateProgress" runat="server" CssClass="updateProgress" Style="left: 0px;
                    top: 0px">
                    <div style="position: relative; top: 30%; text-align: center;">
                        <img src="Images/loading.gif" style="vertical-align: middle" alt="Processing" />
                        資料讀取中，請稍後 ...
                    </div>
                </asp:Panel>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:ModalPopupExtender ID="ModalProgress" runat="server" TargetControlID="panelUpdateProgress"
            BackgroundCssClass="modalBackground" PopupControlID="panelUpdateProgress" Enabled="True" />
        <asp:Button ID="Button3" runat="server" Text="Button" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <asp:ImageButton ID="ImageButton1" runat="server" Width="80px" Height="23px" ImageUrl="~/ValidateCode.ashx"
                    AlternateText="更換" />
                <asp:Panel ID="plPopupFV" runat="server" CssClass="modalPopup" Style="display: none;"
                    Width="600px">
                    <table cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td>
                                <asp:Panel ID="plDragFV" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                    border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                    background-color: #dddddd;">
                                    <div>
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td nowrap="nowrap">
                                                    <asp:Label ID="lblDragNameFV" runat="server"></asp:Label></td>
                                                <td align="right" width="1%">
                                                    <asp:Button ID="btnExitFV" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitFV_Click" /></td>
                                            </tr>
                                        </table>
                                    </div>
                                    <asp:Label ID="lblFVID" runat="server" Visible="False"></asp:Label>
                                </asp:Panel>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                    &nbsp;
                </asp:Panel>
                <asp:Button ID="hiddenTargetControlForModalPopupFV" runat="server" Style="display: none" />
                <asp:ModalPopupExtender ID="mpePopupFV" runat="server" BackgroundCssClass="modalBackground"
                    BehaviorID="programmaticModalPopupBehavior1" DropShadow="true" PopupControlID="plPopupFV"
                    PopupDragHandleControlID="plDragFV" RepositionMode="RepositionOnWindowScroll"
                    TargetControlID="hiddenTargetControlForModalPopupFV">
                </asp:ModalPopupExtender>
                &nbsp;
                <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="Button" />&nbsp;
                <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="1">
                    <WizardSteps>
                        <asp:WizardStep runat="server" Title="Step 1">
                            xxxx</asp:WizardStep>
                        <asp:WizardStep runat="server" Title="Step 2">
                            cvcvc</asp:WizardStep>
                    </WizardSteps>
                </asp:Wizard>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <table>
                                <tr>
                                    <td>
                                        Name:</td>
                                    <td>
                                        <asp:TextBox ID="NameTextBox" runat="server" BorderColor="#a9a9a9" BorderStyle="solid"
                                            BorderWidth="1px" ValidationGroup="fv"></asp:TextBox></td>
                                </tr>
                                <tr>
                                    <td>
                                        Phone Number:</td>
                                    <td>
                                        <asp:TextBox ID="PhoneNumberTextBox" runat="server" BorderColor="#a9a9a9" BorderStyle="solid"
                                            BorderWidth="1px" ValidationGroup="fv"></asp:TextBox></td>
                                </tr>
                            </table>
                            <asp:RequiredFieldValidator ID="NReq" runat="server" ControlToValidate="NameTextBox"
                                Display="None" ErrorMessage="<b>Required Field Missing</b><br />A name is required."
                                ValidationGroup="fv"></asp:RequiredFieldValidator><asp:ValidatorCalloutExtender ID="NReqE"
                                    runat="Server" HighlightCssClass="validatorCalloutHighlight" TargetControlID="NReq">
                                </asp:ValidatorCalloutExtender>
                            <asp:RequiredFieldValidator ID="PNReq" runat="server" ControlToValidate="PhoneNumberTextBox"
                                Display="None" ErrorMessage="<b>Required Field Missing</b><br />A phone number is required.<div style='margin-top:5px;padding:5px;border:1px solid #e9e9e9;background-color:white;'><b>Other Options:</b><br /><a href='javascript:alert(&quot;No phone number available in profile.&quot;);'>Extract from Profile</a></div>"
                                ValidationGroup="fv"></asp:RequiredFieldValidator><asp:ValidatorCalloutExtender ID="PNReqE"
                                    runat="Server" HighlightCssClass="validatorCalloutHighlight" TargetControlID="PNReq"
                                    Width="350px">
                                </asp:ValidatorCalloutExtender>
                            <asp:RegularExpressionValidator ID="PNRegEx" runat="server" ControlToValidate="PhoneNumberTextBox"
                                Display="None" ErrorMessage="<b>Invalid Field</b><br />Please enter a phone number in the format:<br />(###) ###-####"
                                ValidationExpression="((\(\d{3}\) ?)|(\d{3}-))?\d{3}-\d{4}" ValidationGroup="fv"></asp:RegularExpressionValidator><asp:ValidatorCalloutExtender
                                    ID="PNReqEx" runat="Server" HighlightCssClass="validatorCalloutHighlight" TargetControlID="PNRegEx">
                                </asp:ValidatorCalloutExtender>
                            <asp:Button ID="Button1" runat="server" Text="Submit" ValidationGroup="fv" OnClick="Button1_Click" /><asp:Label
                                ID="lblMessage" runat="server"></asp:Label>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblMsgFV" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    </form>
</body>
</html>
