<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Strict//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>eLearning - Login</title>
    <link href="css/StyleSheet.css" rel="stylesheet" type="text/css" />
    <asp:Literal runat="server" ID="ltModalProgress"></asp:Literal>
</head>
<body class="LoginPage">
    <form id="form1" runat="server">
    <asp:Panel ID="plFooter" runat="server" Width="100%">
        <asp:ToolkitScriptManager ID="ToolkitScriptManager1" runat="server" EnableScriptGlobalization="True">
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
            BackgroundCssClass="modalBackground" PopupControlID="panelUpdateProgress" />
        <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>
                <div align="center">
                    <table border="0" width="640" cellpadding="0" style="border-collapse: collapse" id="table3">
                        <tr>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_01.gif');
                                height: 164px; width: 139px;">
                            </td>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_02.gif');
                                height: 164px; width: 363px;">
                            </td>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_03.gif');
                                height: 164px; width: 138px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_04.gif');
                                height: 142px; width: 139px;">
                            </td>
                            <td background="App_Themes/jb_ezflow_style_b/images/login_05.gif" style="vertical-align: middle">
                                <table border="0" width="100%" cellpadding="4" id="table4">
                                    <tr>
                                        <td align="right">
                                            帳號（工號）：
                                        </td>
                                        <td style="text-align: left">
                                            <asp:TextBox ID="txtLogin" runat="server" Width="120px"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            密碼（預設身份證後四碼）：
                                        </td>
                                        <td style="text-align: left">
                                            <asp:TextBox ID="txtPass" runat="server" Width="120px" TextMode="Password"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            &nbsp;
                                        </td>
                                        <td style="text-align: left">
                                            <asp:Button ID="btnSubmit" runat="server" Text="登入" OnClick="btnSubmit_Click" /><asp:Label
                                                ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_06.gif');
                                height: 142px; width: 138px;">
                            </td>
                        </tr>
                        <tr>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_07.gif');
                                height: 94px; width: 139px;">
                            </td>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_08.gif');
                                height: 94px; width: 363px;">
                            </td>
                            <td style="background: transparent url('App_Themes/jb_ezflow_style_b/images/login_09.gif');
                                height: 94px; width: 138px;">
                            </td>
                        </tr>
                    </table>
                </div>
                <div class="footerLogin" style="text-align: center">
                    <a href="http://www.jbjob.com.tw/" target="_blank">版權所有©2006 傑報資訊</a>
                </div>
                <asp:Panel ID="plChangePW" runat="server" CssClass="modalPopup" Style="display: none"
                    Width="250px">
                    <asp:Panel ID="plDragChangePW" runat="server" Style="border-right: gray 1px solid;
                        border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                        border-bottom: gray 1px solid; background-color: #dddddd">
                        <div>
                            <p>
                                <asp:Label ID="lblDragNameChangePW" runat="server"></asp:Label>&nbsp;</p>
                        </div>
                    </asp:Panel>
                    <div>
                        <table>
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap">
                                    <asp:Label ID="lblPwChange" runat="server" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    原始密碼
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:TextBox ID="txtPWold" runat="server" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    新的密碼
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:TextBox ID="txtPWnew" runat="server" TextMode="Password"></asp:TextBox><br />
                                    <asp:Label ID="lblPwLen" runat="server"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" nowrap="nowrap">
                                    確認密碼
                                </td>
                                <td align="left" nowrap="nowrap">
                                    <asp:TextBox ID="txtPWchk" runat="server" TextMode="Password"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2" nowrap="nowrap">
                                    <asp:Button ID="btnUpdateChangePW" runat="server" CausesValidation="False" Text="確定修改"
                                        OnClick="btnUpdateChangePW_Click" />
                                    <asp:Button ID="btnCancelChangePW" runat="server" CausesValidation="False" Text="取消離開" />
                                </td>
                            </tr>
                            <tr>
                                <td align="left" colspan="2" nowrap="nowrap">
                                    <asp:Label ID="lblMsgChangePW" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </div>
                </asp:Panel>
                <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none" />
                <asp:ModalPopupExtender ID="mpeChangePW" runat="server" BackgroundCssClass="modalBackground"
                    BehaviorID="programmaticModalPopupBehavior" DropShadow="true" PopupControlID="plChangePW"
                    RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopup">
                </asp:ModalPopupExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
    </asp:Panel>
    <asp:AlwaysVisibleControlExtender ID="avceFooter" runat="server" TargetControlID="plFooter"
        HorizontalSide="Center" VerticalSide="Middle" />
    </form>
</body>
</html>
