<%@ Page Title="" Language="C#" MasterPageFile="~/mpDialog20140102.master" AutoEventWireup="true" CodeFile="Batch.aspx.cs" Inherits="Ot_Batch" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function refreshGrid() {
                var masterTable = $find("<%=gv.ClientID%>").get_masterTableView();
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
            <telerik:AjaxSetting AjaxControlID="txtDate">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtDate" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="gv" />
                    <telerik:AjaxUpdatedControl ControlID="btnSave" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gv">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtDate" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="gv" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="btnSave" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="btnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="txtDate" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="gv" UpdatePanelCssClass="" />
                    <telerik:AjaxUpdatedControl ControlID="btnSave" UpdatePanelCssClass="" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
        <Windows>
            <telerik:RadWindow ID="rwMT" runat="server" Title="" Height="400px" Width="500px"
                OnClientClose="refreshGrid" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
            <telerik:RadWindow ID="rwView" runat="server" Title="" Height="600px" Width="800px"
                OnClientClose="refreshGrid" Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <table class="auto-style1">
        <tr>
            <td>
                <table class="auto-style1">
                    <tr>
                        <td>日<br />
                            期</td>
                        <td>
                            <telerik:RadDatePicker ID="txtDate" runat="server" OnSelectedDateChanged="txtDate_SelectedDateChanged" Width="100px" AutoPostBack="True">
                                <Calendar UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                </Calendar>
                                <DateInput DateFormat="yyyy/M/d" DisplayDateFormat="yyyy/M/d" DisplayText="" LabelWidth="40%" type="text" value="" AutoPostBack="True">
                                    <EmptyMessageStyle Resize="None"></EmptyMessageStyle>
                                    <ReadOnlyStyle Resize="None"></ReadOnlyStyle>
                                    <FocusedStyle Resize="None"></FocusedStyle>
                                    <DisabledStyle Resize="None"></DisabledStyle>
                                    <InvalidStyle Resize="None"></InvalidStyle>
                                    <HoveredStyle Resize="None"></HoveredStyle>
                                    <EnabledStyle Resize="None"></EnabledStyle>
                                </DateInput>
                                <DatePopupButton HoverImageUrl="" ImageUrl="" />
                            </telerik:RadDatePicker>
                        </td>
                        <td>給付<br />
                            方式</td>
                        <td>
                            <telerik:RadComboBox ID="ddlOtCat" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                            </telerik:RadComboBox>
                        </td>
                        <td>加班<br />
                            原因</td>
                        <td>
                            <telerik:RadComboBox ID="ddlOtrcd" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                            </telerik:RadComboBox>
                        </td>
                        <td>
                            <telerik:RadButton ID="btnSearch" runat="server"
                                Text="查詢" OnClick="btnSearch_Click">
                            </telerik:RadButton>
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadGrid ID="gv" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" Culture="zh-TW" AllowMultiRowSelection="True"
                    ResolvedRenderMode="Classic" OnNeedDataSource="gv_NeedDataSource" OnItemDataBound="gv_ItemDataBound">
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
                            <telerik:GridBoundColumn DataField="Nobr" FilterControlAltText="Filter Nobr column"
                                HeaderText="工號" SortExpression="Nobr" UniqueName="Nobr">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Name" FilterControlAltText="Filter Name column"
                                HeaderText="姓名" SortExpression="Name" UniqueName="Name">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="RoteName" FilterControlAltText="Filter RoteName column"
                                HeaderText="加班班別" SortExpression="RoteName" UniqueName="RoteName">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateB" DataFormatString="{0:d}" DataType="System.DateTime"
                                FilterControlAltText="Filter DateB column" HeaderText="開始日期" SortExpression="DateB"
                                UniqueName="DateB">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TimeB" FilterControlAltText="Filter TimeB column"
                                HeaderText="開始時間" SortExpression="TimeB" UniqueName="TimeB">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="DateE" DataFormatString="{0:d}" DataType="System.DateTime"
                                FilterControlAltText="Filter DateE column" HeaderText="結束日期" SortExpression="DateE"
                                UniqueName="DateE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="TimeE" FilterControlAltText="Filter TimeE column"
                                HeaderText="結束時間" SortExpression="TimeE" UniqueName="TimeE">
                            </telerik:GridBoundColumn>
                            <telerik:GridBoundColumn DataField="Hour" FilterControlAltText="Filter Hour column"
                                HeaderText="時數" SortExpression="Hour" UniqueName="Hour">
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
            </td>
        </tr>
        <tr>
            <td>
                <telerik:RadButton ID="btnSave" runat="server"
                    Text="帶入" OnClick="btnSave_Click">
                </telerik:RadButton>
                <telerik:RadButton ID="btnClose" runat="server" OnClientClicking="CancelEdit"
                    Text="關閉">
                </telerik:RadButton>
            </td>
        </tr>
        <tr>
            <td>
                <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
            </td>
        </tr>
    </table>
</asp:Content>


