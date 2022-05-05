<%@ Page Title="" Language="C#" MasterPageFile="~/mpMT20140325.master" AutoEventWireup="true" CodeFile="ProcessNode.aspx.cs" Inherits="Manage_ProcessNode" %>


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
            <telerik:AjaxSetting AjaxControlID="plContent">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plContent" />
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
        <table class="auto-style1">
            <tr>
                <td nowrap="nowrap" width="1%">流程序號</td>
                <td width="1%">
                    <telerik:RadTextBox ID="txtProcessID" runat="server" Width="100px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="查詢" Style="top: 0px; left: 0px">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
        <br />
        <telerik:RadGrid ID="gvAppM" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" Culture="zh-TW" AllowMultiRowSelection="True" OnItemCommand="gvAppM_ItemCommand"
            OnItemDataBound="gvAppM_ItemDataBound" OnNeedDataSource="gvAppM_NeedDataSource"
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
                    <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                        <ItemTemplate>
                            <telerik:RadButton ID="btnStart" runat="server" CommandArgument='<%# Eval("ProcessNodeAuto") %>'
                                CommandName="Start" Text="欲退簽核主管" OnClientClicking="ExcuteConfirmOld">
                            </telerik:RadButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="ProcessNodeAuto" FilterControlAltText="Filter ProcessNodeAuto column"
                        HeaderText="節點編號" SortExpression="ProcessNodeAuto" UniqueName="ProcessNodeAuto">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="FlowNodeName" FilterControlAltText="Filter FlowNodeName column"
                        HeaderText="節點名稱" SortExpression="FlowNodeName" UniqueName="FlowNodeName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="ProcessCheckAuto" FilterControlAltText="Filter ProcessCheckAuto column"
                        HeaderText="審核點編號" SortExpression="ProcessCheckAuto" UniqueName="ProcessCheckAuto">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AppName" FilterControlAltText="Filter AppName column"
                        HeaderText="申請人名稱" SortExpression="AppName" UniqueName="AppName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CheckName" FilterControlAltText="Filter CheckName column"
                        HeaderText="審核者名稱" SortExpression="CheckName" UniqueName="CheckName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="AgentName" FilterControlAltText="Filter AgentName column"
                        HeaderText="代理審核者名稱" SortExpression="AgentName" UniqueName="AgentName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="CheckDate" FilterControlAltText="Filter CheckDate column"
                        HeaderText="審核時間" SortExpression="CheckDate" UniqueName="CheckDate">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="NodeFinish" FilterControlAltText="Filter NodeFinish column"
                        HeaderText="節點簽結" SortExpression="NodeFinish" UniqueName="NodeFinish">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="Multi" FilterControlAltText="Filter Multi column"
                        HeaderText="子流程" SortExpression="Multi" UniqueName="Multi">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="SubProcessIds" FilterControlAltText="Filter SubProcessIds column"
                        HeaderText="子流程編號" SortExpression="SubProcessIds" UniqueName="SubProcessIds">
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
</asp:Content>
