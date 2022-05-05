<%@ Page Title="" Language="C#" MasterPageFile="~/mpStd1021202.master" AutoEventWireup="true"
    CodeFile="Std.aspx.cs" Inherits="Abs_Std" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
                            <td>
                                姓名
                            </td>
                            <td>
                                <telerik:RadComboBox ID="txtNameAppS" runat="server" Culture="zh-TW" AllowCustomText="True"
                                    AutoPostBack="True" EnableVirtualScrolling="True" ItemsPerRequest="10" Filter="Contains"
                                    LoadingMessage="載入中…" OnDataBound="txtNameAppS_DataBound" OnSelectedIndexChanged="txtNameAppS_SelectedIndexChanged"
                                    OnTextChanged="txtNameAppS_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobrAppS" runat="server"></asp:Label>
                            </td>
                            <td>
                                代理人</td>
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
                            <td>
                                日期
                            </td>
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
                                            <telerik:RadComboBox ID="txtTimeB" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…" Width="80px">
                                            </telerik:RadComboBox>
                                        </td>
                                        <td>
                                            到
                                        </td>
                                        <td>
                                            <telerik:RadDatePicker ID="txtDateE" runat="server" Width="100px">
                                            </telerik:RadDatePicker>
                                        </td>
                                        <td>
                                            <telerik:RadComboBox ID="txtTimeE" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…" Width="80px">
                                            </telerik:RadComboBox>
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
                            <td>
                                假別
                            </td>
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
                                            ※此時數會預先扣除進行中流程的時數
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                原因
                            </td>
                            <td colspan="3">
                                <telerik:RadTextBox ID="txtNote" runat="server" EmptyMessage="請輸入您的原因..." Height="50px"
                                    TextMode="MultiLine" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <telerik:RadButton ID="btnAdd" runat="server" Text="新增" Font-Bold="True" Font-Size="XX-Large" ForeColor="Blue" Height="50px"
                                    OnClick="btnAdd_Click">
                                </telerik:RadButton>
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
            <tr>
                <th>
                    被申請人資訊
                </th>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gvAppS" runat="server" Culture="zh-TW" Width="100%" OnItemCommand="gvAppS_ItemCommand" OnNeedDataSource="gvAppS_NeedDataSource">
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
                                        <telerik:RadButton ID="btnUpload" runat="server" CommandArgument='<%# Eval("iAutoKey") %>'
                                            CommandName="Upload" Text="附件">
                                        </telerik:RadButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="sNobr" FilterControlAltText="Filter sNobr column"
                                    HeaderText="工號" SortExpression="sNobr" UniqueName="sNobr">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sName" FilterControlAltText="Filter sName column"
                                    HeaderText="姓名" SortExpression="sName" UniqueName="sName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dDateB" DataFormatString="{0:d}" DataType="System.DateTime"
                                    FilterControlAltText="Filter dDateB column" HeaderText="開始日期" SortExpression="dDateB"
                                    UniqueName="dDateB">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sTimeB" FilterControlAltText="Filter sTimeB column"
                                    HeaderText="時間" SortExpression="sTimeB" UniqueName="sTimeB">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dDateE" DataFormatString="{0:d}" DataType="System.DateTime"
                                    FilterControlAltText="Filter dDateE column" HeaderText="結束日期" SortExpression="dDateE"
                                    UniqueName="dDateE">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sTimeE" FilterControlAltText="Filter sTimeE column"
                                    HeaderText="時間" SortExpression="sTimeE" UniqueName="sTimeE">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sHname" FilterControlAltText="Filter sHname column"
                                    HeaderText="假別" SortExpression="sHname" UniqueName="sHname">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="iUse" DataType="System.Decimal" FilterControlAltText="Filter iTotalDay column"
                                    HeaderText="使用" SortExpression="iUse" UniqueName="iUse">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="iBalance" DataType="System.Decimal" FilterControlAltText="Filter iTotalDay column"
                                    HeaderText="剩餘" SortExpression="iBalance" UniqueName="iBalance">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sUnit" FilterControlAltText="Filter iTotalHour column"
                                    HeaderText="單位" SortExpression="sUnit" UniqueName="sUnit">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sAgentName" FilterControlAltText="Filter sAgentName column"
                                    HeaderText="代理人" SortExpression="sAgentName" UniqueName="sAgentName">
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
        <telerik:RadButton ID="btnSubmit" runat="server" Text="送出傳簽" OnClick="btnSubmit_Click"  Font-Bold="True" Font-Size="XX-Large" ForeColor="Blue" Height="50px"
            OnClientClicking="ExcuteConfirm"  >
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
