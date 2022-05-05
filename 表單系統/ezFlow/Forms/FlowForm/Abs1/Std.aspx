<%@ Page Title="" Language="C#" MasterPageFile="~/mpStd1021202.master" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="Abs1_Std" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSubmit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="rwMT" runat="server" Title="" Height="500px" Width="700px"
                Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:Panel ID="plAppM" runat="server" ToolTip="申請人">
        <table width="100%">
            <tr>
                <th colspan="6">
                    申請人資訊
                </th>
            </tr>
            <tr>
                <td>
                    姓名
                </td>
                <td>
                    <asp:Label ID="lblNameAppM" runat="server"></asp:Label>
                    <asp:Label ID="lblNobrAppM" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblRoleAppM" runat="server" Visible="False"></asp:Label>
                </td>
                <td>
                    部門
                </td>
                <td>
                    <asp:Label ID="lblDeptNameAppM" runat="server"></asp:Label>
                    <asp:Label ID="lblDeptCodeAppM" runat="server" Visible="False"></asp:Label>
                </td>
                <td>
                    職稱
                </td>
                <td>
                    <asp:Label ID="lblJobNameAppM" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="plAppS" runat="server" ToolTip="被申請人">
        <table width="100%">
            <tr>
                <th>
                    新增申請人員
                </th>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <th>
                                姓名
                            </th>
                            <td>
                                <telerik:RadComboBox ID="txtNameAppS" runat="server" Culture="zh-TW" AllowCustomText="True"
                                    AutoPostBack="True" EnableVirtualScrolling="True" ItemsPerRequest="10" Filter="Contains"
                                    LoadingMessage="載入中…" OnDataBound="txtNameAppS_DataBound" OnSelectedIndexChanged="txtNameAppS_SelectedIndexChanged"
                                    OnTextChanged="txtNameAppS_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobrAppS" runat="server"></asp:Label>
                            </td>
                            <th>
                                代理人
                            </th>
                            <td>
                                <telerik:RadComboBox ID="txtNameAgent1" runat="server" Culture="zh-TW" AllowCustomText="True"
                                    AutoPostBack="True" EnableVirtualScrolling="True" ItemsPerRequest="10" Filter="Contains"
                                    LoadingMessage="載入中…" OnDataBound="txtNameAgent1_DataBound" OnSelectedIndexChanged="txtNameAgent1_SelectedIndexChanged"
                                    OnTextChanged="txtNameAgent1_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobrAgent1" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                日期
                            </th>
                            <td colspan="3">
                                <table>
                                    <tr>
                                        <td>
                                            <telerik:RadDatePicker ID="txtDateB" runat="server" AutoPostBack="True" OnSelectedDateChanged="txtDateB_SelectedDateChanged"
                                                Width="100px">
                                                <Calendar UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                                </Calendar>
                                                <DateInput AutoPostBack="True" DateFormat="yyyy/M/d" DisplayDateFormat="yyyy/M/d"
                                                    DisplayText="" LabelWidth="40%" type="text" value="">
                                                </DateInput>
                                                <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                            </telerik:RadDatePicker>
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="txtTimeB" runat="server" Mask="####" Width="40px">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>
                                            到
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="txtDateE" runat="server" Width="100px">
                                            </telerik:RadDatePicker>
                                        </td>
                                        <td>
                                            <telerik:RadMaskedTextBox ID="txtTimeE" runat="server" Mask="####" Width="40px">
                                            </telerik:RadMaskedTextBox>
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="btnCalendar" runat="server" CommandArgument="../MT/Calendar.aspx"
                                                CommandName="Calendar" OnClick="Dialog_Click" Text="行事曆" Visible="False">
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                假別
                            </th>
                            <td colspan="3">
                                <table>
                                    <tr>
                                        <td>
                                            <telerik:RadComboBox ID="txtHcode" runat="server" Culture="zh-TW" EnableVirtualScrolling="True"
                                                ItemsPerRequest="10" LoadingMessage="載入中…" AutoPostBack="True" OnSelectedIndexChanged="txtHcode_SelectedIndexChanged">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            <telerik:RadButton ID="btnAbsd" runat="server" CausesValidation="false" CommandArgument="Absd.aspx"
                                                CommandName="Absd" OnClick="Dialog_Click" Text="請假明細" Visible="False">
                                            </telerik:RadButton>
                                        </td>
                                        <td>
                                            剩餘
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBalance" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblBalanceUnit" runat="server"></asp:Label>
                                        </td>
                                        <td>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                事由
                            </th>
                            <td colspan="3">
                                <telerik:RadTextBox ID="txtNote" runat="server" Height="50px" TextMode="MultiLine"
                                    Width="100%" EmptyMessage="請輸入您的原因...">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <telerik:RadButton ID="btnFlow" runat="server" Text="進行中流程" OnClick="Dialog_Click"
                                    CommandArgument="../MT/Flow.aspx" CommandName="Flow">
                                </telerik:RadButton>
                                <asp:Label ID="lblMsgAdd" runat="server"></asp:Label>
                                <asp:Label ID="lblAddGuid" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="plSubmit" runat="server" ToolTip="送出傳簽">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="送出傳簽" OnClick="btnSubmit_Click"  Font-Bold="True" Font-Size="XX-Large" ForeColor="Blue" Height="50px"
            OnClientClicking="ExcuteConfirm">
        </telerik:RadButton>
        <asp:Label ID="lblMsgSubmit" runat="server"></asp:Label>
        <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblFlowTreeID" runat="server" Visible="False"></asp:Label>
    </asp:Panel>
    <asp:Panel ID="plNote" runat="server" ToolTip="備註事項">
        <table>
            <tr>
                <th>
                    備註事項
                </th>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblNote" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
