<%@ Page Title="" Language="C#" MasterPageFile="~/mpStd1021202.master" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="ShiftShort_Std" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
            width: 100%;
        }
        .auto-style2 {
            width: 45px;
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
                    <table class="auto-style1">
                        <tr>
                            <th class="auto-style2" nowrap="nowrap" width="1%">姓名</th>
                            <td>&nbsp;</td>
                            <th>日期</th>
                            <th>班別</th>
                        </tr>
                        <tr>
                            <td rowspan="2" class="auto-style2" nowrap="nowrap" width="1%">
                                <telerik:RadComboBox ID="txtNameAppS" runat="server" AllowCustomText="True" AutoPostBack="True" Culture="zh-TW" EnableVirtualScrolling="True" Filter="Contains" ItemsPerRequest="10" LoadingMessage="載入中…" OnDataBound="txtNameAppS_DataBound" OnSelectedIndexChanged="txtNameAppS_SelectedIndexChanged" OnTextChanged="txtNameAppS_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobrAppS" runat="server"></asp:Label>
                            </td>
                            <th>原日期</th>
                            <td>
                                <telerik:RadDatePicker ID="txtDateA" runat="server" AutoPostBack="True" OnSelectedDateChanged="txtDateA_SelectedDateChanged" Width="100px">
                                    <Calendar UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DateInput AutoPostBack="True" DateFormat="yyyy/M/d" DisplayDateFormat="yyyy/M/d" DisplayText="" LabelWidth="40%" type="text" value="">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                            <td>
                                <asp:Label ID="lblRoteA" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th>調班後</th>
                            <td>
                                <telerik:RadDatePicker ID="txtDateB" runat="server" Width="100px" AutoPostBack="True" OnSelectedDateChanged="txtDateB_SelectedDateChanged">
                                    <Calendar Culture="zh-TW" EnableWeekends="True" FastNavigationNextText="&amp;lt;&amp;lt;" UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False">
                                    </Calendar>
                                    <DateInput AutoPostBack="True" DateFormat="yyyy/M/d" DisplayDateFormat="yyyy/M/d" LabelWidth="40%">
                                        <EmptyMessageStyle Resize="None" />
                                        <ReadOnlyStyle Resize="None" />
                                        <FocusedStyle Resize="None" />
                                        <DisabledStyle Resize="None" />
                                        <InvalidStyle Resize="None" />
                                        <HoveredStyle Resize="None" />
                                        <EnabledStyle Resize="None" />
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                            <td>
                                <telerik:RadComboBox ID="ddlRoteB" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblRoteB_Old" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th class="auto-style2" nowrap="nowrap" width="1%">申請原因</th>
                            <td colspan="3">
                                <telerik:RadTextBox ID="txtNote" runat="server" EmptyMessage="請輸入您的原因..." Height="50px" TextMode="MultiLine" Width="80%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" nowrap="nowrap" width="1%">
                                <telerik:RadButton ID="btnAdd" runat="server" OnClick="btnAdd_Click" Style="top: 0px; left: 0px" Text="新增">
                                </telerik:RadButton>
                                <telerik:RadButton ID="btnFlow" runat="server" CommandArgument="../MT/Flow.aspx" CommandName="Flow" OnClick="Dialog_Click" Text="進行中流程">
                                </telerik:RadButton>
                                <asp:Label ID="lblMsgAdd" runat="server"></asp:Label>
                                <asp:Label ID="lblAddGuid" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <th>
                    被申請人資訊
                </th>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gvAppS" runat="server" Culture="zh-TW" Width="90%" OnItemCommand="gvAppS_ItemCommand" OnNeedDataSource="gvAppS_NeedDataSource">
                        <AlternatingItemStyle HorizontalAlign="Center" />
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="iAutoKey">
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                                <HeaderStyle Width="20px" />
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                                <HeaderStyle Width="20px" />
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                                    <ItemTemplate>
                                        <telerik:RadButton ID="btnDelete" runat="server" CommandArgument='<%# Eval("iAutoKey") %>'
                                            CommandName="Del" Text="刪除">
                                        </telerik:RadButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="sNobr" FilterControlAltText="Filter sNobr column"
                                    HeaderText="工號" SortExpression="sNobr" UniqueName="sNobr">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sNameA" FilterControlAltText="Filter sNameA column"
                                    HeaderText="姓名" SortExpression="sNameA" UniqueName="sNameA">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dDateA" DataFormatString="{0:d}" DataType="System.DateTime"
                                    FilterControlAltText="Filter dDateA column" HeaderText="原日期" SortExpression="dDateA"
                                    UniqueName="dDateA">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sRoteNameA" FilterControlAltText="Filter sRoteNameA column"
                                    HeaderText="原班別" SortExpression="sRoteNameA" UniqueName="sRoteNameA">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dDateB" DataFormatString="{0:d}" DataType="System.DateTime"
                                    FilterControlAltText="Filter dDateB column" HeaderText="調班後日期" SortExpression="dDateB"
                                    UniqueName="dDateB">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sRoteNameB" FilterControlAltText="Filter sRoteNameB column"
                                    HeaderText="調班後班別" SortExpression="sRoteNameB" UniqueName="sRoteNameB">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sNote" FilterControlAltText="Filter sNote column"
                                    HeaderText="原因" SortExpression="sNote" UniqueName="sNote">
                                </telerik:GridBoundColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                            </EditFormSettings>
                            <ItemStyle HorizontalAlign="Center" />
                            <AlternatingItemStyle HorizontalAlign="Center" />
                        </MasterTableView>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <asp:Panel ID="plSubmit" runat="server" ToolTip="送出傳簽">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="送出傳簽" OnClick="btnSubmit_Click"
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
