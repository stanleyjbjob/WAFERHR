<%@ Page Title="" Language="C#" MasterPageFile="~/mpDialog20140102.master" AutoEventWireup="true"
    CodeFile="Calendar.aspx.cs" Inherits="MT_Calendar" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plContent" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="cldAttend">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="cldAttend" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
    <asp:Panel ID="plContent" runat="server">
        <table width="100%">
            <tr>
                <td>
                    <telerik:RadCalendar ID="cldAttend" runat="server" AutoPostBack="True" OnDayRender="cldAttend_DayRender"
                        Width="100%">
                    </telerik:RadCalendar>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadButton ID="btnClose" runat="server" OnClientClicking="CancelEdit" Text="關閉">
                    </telerik:RadButton>
                    <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
