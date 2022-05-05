<%@ Page Title="" Language="C#" MasterPageFile="~/mpMT20140325.master" AutoEventWireup="true"
    CodeFile="FlowView.aspx.cs" Inherits="Etc_FlowView" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="txtNameAppS">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSearch" />
                    <telerik:AjaxUpdatedControl ControlID="plManage" />
                    <telerik:AjaxUpdatedControl ControlID="gvAppM" />
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSearch">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSearch" />
                    <telerik:AjaxUpdatedControl ControlID="plManage" />
                    <telerik:AjaxUpdatedControl ControlID="gvAppM" />
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnActive">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSearch" />
                    <telerik:AjaxUpdatedControl ControlID="plManage" />
                    <telerik:AjaxUpdatedControl ControlID="gvAppM" />
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gvAppM">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="btnSearch" />
                    <telerik:AjaxUpdatedControl ControlID="plManage" />
                    <telerik:AjaxUpdatedControl ControlID="gvAppM" />
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
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
    <asp:Panel ID="plContent" runat="server">
        <table>
            <tr>
                <td>
                    表單名稱<telerik:RadComboBox ID="txtFlowForm" runat="server" CssClass="formItem" Culture="zh-TW"
                        LoadingMessage="載入中…" AppendDataBoundItems="True">
                        <Items>
                            <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Selected="True" Text="All"
                                Value="0" />
                        </Items>
                    </telerik:RadComboBox>
                </td>
                <td>
                    <asp:CheckBox ID="ckbManage" runat="server" Text="全部" />
                </td>
            </tr>
            <tr>
                <td>
                    流程序號<telerik:RadNumericTextBox ID="txtProcessID" runat="server" CssClass="formItem"
                        DataType="System.Int32">
                        <NumberFormat DecimalDigits="0" GroupSeparator="" ZeroPattern="n" />
                    </telerik:RadNumericTextBox>
                </td>
                <td>
                    <asp:Panel ID="plAppS" runat="server">
                        工號
                        <telerik:RadComboBox ID="txtNameAppS" runat="server" Culture="zh-TW" AllowCustomText="True"
                            AutoPostBack="True" EnableVirtualScrolling="True" ItemsPerRequest="10" Filter="Contains"
                            LoadingMessage="載入中…" OnDataBound="txtNameAppS_DataBound" OnSelectedIndexChanged="txtNameAppS_SelectedIndexChanged"
                            OnTextChanged="txtNameAppS_TextChanged">
                        </telerik:RadComboBox>
                        <asp:Label ID="lblNobrAppS" runat="server" Visible="False"></asp:Label></asp:Panel>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="style1">
                        <tr>
                            <td>
                                申請日期
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txtDateAppB" runat="server" CssClass="formItem">
                                    <Calendar ID="cldDateAppB" runat="server" EnableKeyboardNavigation="true">
                                    </Calendar>
                                    <DateInput ToolTip="Date input">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                            <td>
                                到
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txtDateAppE" runat="server" CssClass="formItem" Width="150px">
                                    <Calendar ID="cldDateAppE" runat="server" EnableKeyboardNavigation="true">
                                    </Calendar>
                                    <DateInput ToolTip="Date input">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <table class="style1">
                        <tr>
                            <td>
                                核准日期
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txtDateSignB" runat="server" CssClass="formItem" Width="150px">
                                    <Calendar ID="cldDateSignB" runat="server" EnableKeyboardNavigation="true">
                                    </Calendar>
                                    <DateInput ToolTip="Date input">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                            <td>
                                到
                            </td>
                            <td>
                                <telerik:RadDatePicker ID="txtDateSignE" runat="server" CssClass="formItem" Width="150px">
                                    <Calendar ID="cldDateSignE" runat="server" EnableKeyboardNavigation="true">
                                    </Calendar>
                                    <DateInput ToolTip="Date input">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadMenu ID="muApp" runat="server" Style="top: 0px; left: 0px; z-index: 2900">
                        <Items>
                            <telerik:RadMenuItem runat="server" Selected="True" Text="申請者" Value="1">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="被申請者" Value="2">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="已審核" Value="3">
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenu>
                </td>
                <td>
                    <telerik:RadMenu ID="muState" runat="server" Style="top: 0px; left: 0px; z-index: 2900">
                        <Items>
                            <telerik:RadMenuItem runat="server" Selected="True" Text="進行中" Value="1">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="已完成" Value="3">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="已駁回" Value="2">
                            </telerik:RadMenuItem>
                            <telerik:RadMenuItem runat="server" Text="已抽單" Value="7" Visible="False">
                            </telerik:RadMenuItem>
                        </Items>
                    </telerik:RadMenu>
                </td>
            </tr>
            <tr>
                <td>
                    <table>
                        <tr>
                            <td width="80">
                                <telerik:RadButton ID="btnSearch" runat="server" Text="查詢" OnClick="btnSearch_Click">
                                </telerik:RadButton>
                            </td>
                            <td width="80">
                                <telerik:RadButton ID="btnExportExcel" runat="server" Text="匯出" OnClick="btnExportExcel_Click">
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </td>
                <td>
                    <asp:Panel ID="plManage" runat="server">
                        <telerik:RadComboBox ID="txtActive" runat="server" CssClass="formItem" Culture="zh-TW"
                            LoadingMessage="載入中…" AppendDataBoundItems="True" AutoPostBack="True" OnSelectedIndexChanged="txtActive_SelectedIndexChanged">
                            <Items>
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Selected="True" Text="起點重送流程"
                                    Value="1" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="上點重送流程" Value="2" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="核准存入" Value="3" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="駁回" Value="4" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="作廢" Value="5" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="刪除實體資料" Value="6" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="指向正職簽核" Value="7" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="指向代理簽核" Value="8" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="下點傳送" Value="9" />
                                <telerik:RadComboBoxItem runat="server" Owner="txtFlowForm" Text="通知" Value="10"
                                    Visible="False" />
                            </Items>
                        </telerik:RadComboBox>
                        <telerik:RadComboBox ID="txtSignName" runat="server" Culture="zh-TW" AllowCustomText="True"
                            AutoPostBack="True" EnableVirtualScrolling="True" ItemsPerRequest="10" Filter="Contains"
                            LoadingMessage="載入中…" OnDataBound="txtSignName_DataBound" OnSelectedIndexChanged="txtSignName_SelectedIndexChanged"
                            OnTextChanged="txtSignName_TextChanged">
                        </telerik:RadComboBox>
                        <asp:Label ID="lblSignName" runat="server" Visible="false"></asp:Label>
                        <telerik:RadButton ID="btnActive" runat="server" Text="執行" OnClientClicking="ExcuteConfirm"
                            OnClick="btnActive_Click">
                        </telerik:RadButton>
                    </asp:Panel>
                </td>
            </tr>
        </table>
        <telerik:RadGrid ID="gvAppM" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" Culture="zh-TW" AllowMultiRowSelection="True" OnItemCommand="gvAppM_ItemCommand"
            OnItemDataBound="gvAppM_ItemDataBound" OnExportCellFormatting="gvAppM_ExportCellFormatting"
            OnBiffExporting="gvAppM_BiffExporting" OnDataBound="gvAppM_DataBound" OnNeedDataSource="gvAppM_NeedDataSource"
            ResolvedRenderMode="Classic">
            <ClientSettings>
                <Selecting AllowRowSelect="True" UseClientSelectColumnOnly="True" />
            </ClientSettings>
            <MasterTableView>
                <CommandItemSettings ExportToPdfText="Export to PDF" />
                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                </RowIndicatorColumn>
                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                </ExpandCollapseColumn>
                <Columns>
                    <telerik:GridClientSelectColumn FilterControlAltText="Filter cbxSelect column" UniqueName="cbxSelect"
                        meta:resourcekey="GridClientSelectColumnResource1">
                        <ItemStyle Width="10px" />
                    </telerik:GridClientSelectColumn>
                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                        <ItemTemplate> 
                         <asp:HyperLink ID="hlView" runat="server" NavigateUrl="#" Target="_blank"  ToolTip='<%# Eval("ProcessID") %>'>檢視</asp:HyperLink>
                            <telerik:RadButton ID="btnView" runat="server" CommandArgument='<%# Eval("ProcessID") %>'
                               Visible="false"  CommandName="View" Text="檢視">
                            </telerik:RadButton>
                              
                            <telerik:RadButton ID="btnProcessFlow" runat="server" CommandArgument='<%# Eval("ProcessID") %>'
                                CommandName="ProcessFlow" Text="流程">
                            </telerik:RadButton>
                            <telerik:RadButton ID="btnTake" runat="server" CommandArgument='<%# Eval("ProcessID") %>'
                                ToolTip='<%# Eval("Nobr") %>' CommandName="Take" Text="抽單" OnClientClicking="ExcuteConfirm">
                            </telerik:RadButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ProcessID" FilterControlAltText="Filter ProcessID column"
                        HeaderText="流程序號" SortExpression="ProcessID" UniqueName="ProcessID">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FormName" FilterControlAltText="Filter FormName column"
                        HeaderText="表單名稱" SortExpression="FormName" UniqueName="FormName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="DeptName" FilterControlAltText="Filter DeptName column"
                        HeaderText="單位名稱" SortExpression="DeptName" UniqueName="DeptName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ManageName" FilterControlAltText="Filter ManageName column"
                        HeaderText="審核主管" SortExpression="ManageName" UniqueName="ManageName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AgentManageName" FilterControlAltText="Filter AgentManageName column"
                        HeaderText="代理主管" SortExpression="AgentManageName" UniqueName="AgentManageName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="PendingDay" FilterControlAltText="Filter PendingDay column"
                        HeaderText="待簽天數" SortExpression="PendingDay" UniqueName="PendingDay">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Info" FilterControlAltText="Filter Info column"
                        HeaderText="資訊" SortExpression="Info" UniqueName="Info">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                    </EditColumn>
                </EditFormSettings>
            </MasterTableView>
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
        </telerik:RadGrid>
        <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblViewUrl" runat="server" Visible="False"></asp:Label>
    </asp:Panel>
    <br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br /><br />
</asp:Content>
