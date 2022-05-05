<%@ Page Title="" Language="C#" MasterPageFile="~/mpStd1021202.master" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="Ot_Std" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function refreshGrid() {
                var masterTable = $find("<%=gvAppS.ClientID%>").get_masterTableView();
                masterTable.rebind();
            }

            function GetRadWindow() {
                var oWindow = null;
                if (window.radWindow) oWindow = window.radWindow; //Will work in Moz in all cases, including classic dialog
                else if (window.frameElement.radWindow) oWindow = window.frameElement.radWindow; //IE (and Moz as well)

                return oWindow;
            }
        </script>
    </telerik:RadCodeBlock>
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppM" />
                    <telerik:AjaxUpdatedControl ControlID="plAppS" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnTransCard">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnAdd">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnBatch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnBatchByNobr">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSubmit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" UpdatePanelCssClass="" />
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
            <telerik:RadWindow ID="rwBatch" runat="server" Title="" Height="500px" Width="700px"
                OnClientClose="refreshGrid" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:Panel ID="plAppM" runat="server" ToolTip="申請人">
        <table width="100%">
            <tr>
                <th colspan="6">申請人資訊
                </th>
            </tr>
            <tr>
                <td>姓名
                </td>
                <td>
                    <asp:Label ID="lblNameAppM" runat="server"></asp:Label>
                    <asp:Label ID="lblNobrAppM" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblRoleAppM" runat="server" Visible="False"></asp:Label>
                </td>
                <td>部門
                </td>
                <td>
                    <asp:Label ID="lblDeptNameAppM" runat="server"></asp:Label>
                    <asp:Label ID="lblDeptCodeAppM" runat="server" Visible="False"></asp:Label>
                </td>
                <td>職稱
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
                <th>新增申請人員
                </th>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <th nowrap="nowrap" width="1%">姓名</th>
                            <td>
                                <telerik:RadComboBox ID="txtNameAppS" runat="server" Culture="zh-TW" AllowCustomText="True"
                                    AutoPostBack="True" EnableVirtualScrolling="True" ItemsPerRequest="10" Filter="Contains"
                                    LoadingMessage="載入中…" OnDataBound="txtNameAppS_DataBound" OnSelectedIndexChanged="txtNameAppS_SelectedIndexChanged"
                                    OnTextChanged="txtNameAppS_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobrAppS" runat="server"></asp:Label>
                            </td>
                            <th nowrap="nowrap" width="1%">給付方式</th>
                            <td>
                                <telerik:RadComboBox ID="ddlOtCat" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <th nowrap="nowrap" width="1%">日期</th>
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
                                        <td>到
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
                                            <telerik:RadButton ID="btnDate" runat="server" CommandArgument="../MT/Calendar.aspx" CommandName="Calendar" OnClick="btnDate_Click" Text="重新載入">
                                            </telerik:RadButton>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <th nowrap="nowrap" width="1%">刷卡時間</th>
                            <td colspan="3">
                                <asp:Label ID="lblCardTime" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th nowrap="nowrap" width="1%">加班班別</th>
                            <td>
                                <telerik:RadComboBox ID="ddlRote" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                                <telerik:RadButton ID="btnTransCard" runat="server" CommandArgument="../MT/Calendar.aspx" CommandName="Calendar" OnClick="btnTransCard_Click" Text="轉換">
                                </telerik:RadButton>
                            </td>
                            <th nowrap="nowrap" width="1%">加班部門</th>
                            <td>
                                <telerik:RadComboBox ID="ddlDepts" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <th nowrap="nowrap" width="1%">申請原因</th>
                            <td>
                                <telerik:RadComboBox ID="ddlOtrcd" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                            </td>
                            <th nowrap="nowrap" width="1%">&nbsp;</th>
                            <td>&nbsp;</td>
                        </tr>
                        <tr>
                            <th nowrap="nowrap" width="1%">備註原因</th>
                            <td colspan="3">
                                <telerik:RadTextBox ID="txtNote" runat="server" EmptyMessage="請輸入您的原因..." Height="50px"
                                    TextMode="MultiLine" Width="100%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4" nowrap="nowrap" width="1%">
                                <telerik:RadButton ID="btnAdd" runat="server" Text="新增"                                     OnClick="btnAdd_Click">
                                </telerik:RadButton>
                                <telerik:RadButton ID="btnBatch" runat="server" CommandName="Batch" OnClick="btnBatch_Click"  Text="批次帶入(依日期)" Visible="False">
                                </telerik:RadButton>
                                <telerik:RadButton ID="btnBatchByNobr" runat="server" CommandName="BatchByNobr"  Text="批次帶入(依工號)" OnClick="btnBatchByNobr_Click" Visible="False">
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
                <th>被申請人資訊
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
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="sNobr" FilterControlAltText="Filter sNobr column"
                                    HeaderText="工號" SortExpression="sNobr" UniqueName="sNobr">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sName" FilterControlAltText="Filter sName column"
                                    HeaderText="姓名" SortExpression="sName" UniqueName="sName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sOtcatName" FilterControlAltText="Filter sOtcatName column"
                                    HeaderText="給付方式" SortExpression="sOtcatName" UniqueName="sOtcatName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sRoteName" FilterControlAltText="Filter sRoteName column"
                                    HeaderText="加班班別" SortExpression="sRoteName" UniqueName="sRoteName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dDateB" DataFormatString="{0:d}" DataType="System.DateTime"
                                    FilterControlAltText="Filter dDateB column" HeaderText="日期" SortExpression="dDateB"
                                    UniqueName="dDateB">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sTimeB" FilterControlAltText="Filter sTimeB column"
                                    HeaderText="開始時間" SortExpression="sTimeB" UniqueName="sTimeB">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sTimeE" FilterControlAltText="Filter sTimeE column"
                                    HeaderText="結束時間" SortExpression="sTimeE" UniqueName="sTimeE">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="iTotalHour" FilterControlAltText="Filter iTotalHour column"
                                    HeaderText="時數" SortExpression="iTotalHour" UniqueName="iTotalHour">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sOtrcdName" FilterControlAltText="Filter sOtrcdName column"
                                    HeaderText="加班原因" SortExpression="sOtrcdName" UniqueName="sOtrcdName">
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
                <th>備註事項
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
