<%@ Page Title="" Language="C#" MasterPageFile="~/mpStd1021202.master" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="ShiftLong_Std" %>



<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .auto-style1 {
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
                    
                    <table class="auto-style1">
                        <tr>
                            <td>姓名</td>
                            <td>
                                <telerik:RadComboBox ID="txtNameAppS" runat="server" AllowCustomText="True" AutoPostBack="True" Culture="zh-TW" EnableVirtualScrolling="True" Filter="Contains" ItemsPerRequest="10" LoadingMessage="載入中…" OnDataBound="txtNameAppS_DataBound" OnSelectedIndexChanged="txtNameAppS_SelectedIndexChanged" OnTextChanged="txtNameAppS_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobrAppS" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>調班日期</td>
                            <td>
                                <telerik:RadDatePicker ID="txtDateA" runat="server" AutoPostBack="True" OnSelectedDateChanged="txtDateA_SelectedDateChanged" Width="100px">
                                    <Calendar UseColumnHeadersAsSelectors="False" UseRowHeadersAsSelectors="False" ViewSelectorText="x">
                                    </Calendar>
                                    <DateInput AutoPostBack="True" DateFormat="yyyy/M/d" DisplayDateFormat="yyyy/M/d" DisplayText="" LabelWidth="40%" type="text" value="">
                                    </DateInput>
                                    <DatePopupButton HoverImageUrl="" ImageUrl="" />
                                </telerik:RadDatePicker>
                            </td>
                        </tr>
                        <tr>
                            <td>目前班別</td>
                            <td>
                                <asp:Label ID="lblRotet" runat="server"></asp:Label>
                                ,<asp:Label ID="lblHoli" runat="server"></asp:Label>
                                ,<asp:Label ID="lblOtRate" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>調換班別</td>
                            <td>
                                <telerik:RadComboBox ID="ddlRotet" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                                <telerik:RadComboBox ID="ddlHoli" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…" Enabled="False">
                                </telerik:RadComboBox>
                                <telerik:RadComboBox ID="ddlOtRate" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…" Enabled="False">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                        <tr>
                            <td>申請原因</td>
                            <td>
                                <telerik:RadTextBox ID="txtNote" runat="server" EmptyMessage="請輸入您的原因..." Height="50px" TextMode="MultiLine" Width="80%">
                                </telerik:RadTextBox>
                            </td>
                        </tr>
                    </table>
                    
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadButton ID="btnAdd" runat="server" OnClick="btnAdd_Click" Style="top: 0px; left: 0px" Text="新增">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnFlow" runat="server" CommandArgument="../MT/Flow.aspx" CommandName="Flow" OnClick="Dialog_Click" Text="進行中流程">
                    </telerik:RadButton>
                    <asp:Label ID="lblMsgAdd" runat="server"></asp:Label>
                    <asp:Label ID="lblAddGuid" runat="server" Visible="False"></asp:Label>
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
                                <telerik:GridBoundColumn DataField="sName" FilterControlAltText="Filter sName column"
                                    HeaderText="姓名" SortExpression="sName" UniqueName="sName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dDate" DataFormatString="{0:d}" DataType="System.DateTime"
                                    FilterControlAltText="Filter dDate column" HeaderText="調班日期" SortExpression="dDate"
                                    UniqueName="dDate">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sRotetNameA" FilterControlAltText="Filter sRotetNameA column"
                                    HeaderText="原班別" SortExpression="sRotetNameA" UniqueName="sRotetNameA">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sRotetName" FilterControlAltText="Filter sRotetName column"
                                    HeaderText="換班後班別" SortExpression="sRotetName" UniqueName="sRotetName">
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
