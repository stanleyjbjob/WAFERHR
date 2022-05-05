<%@ Page Title="" Language="C#" MasterPageFile="~/mpDialog20140102.master" AutoEventWireup="true" CodeFile="CheckEdit.aspx.cs" Inherits="Ot_CheckEdit" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including classic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

                return oWindow;
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plContent" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gvAppM">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plContent" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="True">
    </telerik:RadWindowManager>
    <asp:Panel ID="plContent" runat="server">
        <table class="auto-style1">
            <tr>
                <th nowrap="nowrap" width="1%">工號</th>
                <td>
                    <asp:Label ID="lblNobr" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th nowrap="nowrap" width="1%">姓名</th>
                <td>
                    <asp:Label ID="lblName" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th nowrap="nowrap" width="1%">日期</th>
                <td>
                    <asp:Label ID="lblDate" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th nowrap="nowrap" width="1%">刷卡時間</th>
                <td>
                    <asp:Label ID="lblCardTime" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <th nowrap="nowrap" width="1%">時間</th>
                <td>
                    <telerik:RadMaskedTextBox ID="txtTimeB" runat="server" Mask="####" Width="40px">
                    </telerik:RadMaskedTextBox>
                    到<telerik:RadMaskedTextBox ID="txtTimeE" runat="server" Mask="####" Width="40px">
                    </telerik:RadMaskedTextBox>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" width="1%">&nbsp;</td>
                <td>
                    <telerik:RadButton ID="btnConfirm" runat="server" OnClick="btnConfirm_Click" Text="確認">
                    </telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td nowrap="nowrap" width="1%">&nbsp;</td>
                <td>&nbsp;</td>
            </tr>
        </table>
        <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblKey1" runat="server" Visible="False"></asp:Label>
    </asp:Panel>
</asp:Content>
