<%@ Page Title="" Language="C#" MasterPageFile="~/mpDialog20140102.master" AutoEventWireup="true"
    CodeFile="CheckAgentFlowTree.aspx.cs" Inherits="Etc_CheckAgentFlowTree" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="plEdit">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plEdit" />
                </UpdatedControls>
            </telerik:AjaxSetting>
        </AjaxSettings>
        <ClientEvents OnRequestStart="pnlRequestStarted"></ClientEvents>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" 
        EnableShadow="True">
        <Windows>
            <telerik:RadWindow ID="rwMT" runat="server" Title="" Height="500px" Width="700px"
                Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" 
                Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:Panel ID="plEdit" runat="server" ToolTip="Upload">
        <table>
            <tr>
                <td>
                    <telerik:RadComboBox ID="txtFlowTree" runat="server" Culture="zh-TW" EnableVirtualScrolling="True"
                        ItemsPerRequest="10" LoadingMessage="載入中…">
                    </telerik:RadComboBox>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="新增" OnClick="btnAdd_Click">
                    </telerik:RadButton>
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gvCheckAgentFlowTree" runat="server" CellSpacing="0" 
                        Culture="zh-TW" GridLines="None"
                        DataSourceID="sdsCheckAgentFlowTree" 
                        onitemcommand="gvCheckAgentFlowTree_ItemCommand">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="auto" DataSourceID="sdsCheckAgentFlowTree">
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                                    <ItemTemplate>
                                        <telerik:RadButton ID="btnDel" runat="server" CommandArgument='<%# Eval("auto") %>'
                                            CommandName="Del" Text="刪除" OnClientClicking="ExcuteConfirm">
                                        </telerik:RadButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="FlowTree_id" FilterControlAltText="Filter FlowTree_id column"
                                    HeaderText="表單代碼" SortExpression="FlowTree_id" UniqueName="FlowTree_id">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="FormName" FilterControlAltText="Filter FormName column"
                                    HeaderText="表單名稱" SortExpression="FormName" UniqueName="FormName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="KeyMan" FilterControlAltText="Filter KeyMan column"
                                    HeaderText="登錄者" SortExpression="KeyMan" UniqueName="KeyMan">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="KeyDate" FilterControlAltText="Filter KeyDate column"
                                    HeaderText="登錄日期" SortExpression="KeyDate" UniqueName="KeyDate" DataType="System.DateTime">
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
                    <asp:SqlDataSource ID="sdsCheckAgentFlowTree" runat="server" ConnectionString="<%$ ConnectionStrings:Flow %>"
                        DeleteCommand="DELETE FROM [CheckAgentFlowTree] WHERE [auto] = @auto" SelectCommand="SELECT CheckAgentFlowTree.auto, CheckAgentFlowTree.CheckAgent_Guid, CheckAgentFlowTree.FlowTree_id, CheckAgentFlowTree.KeyMan, CheckAgentFlowTree.KeyDate, wfForm.sFormName AS FormName FROM CheckAgentFlowTree LEFT OUTER JOIN wfForm ON CheckAgentFlowTree.FlowTree_id = wfForm.sFlowTree WHERE (CheckAgentFlowTree.CheckAgent_Guid = @CheckAgent_Guid)">
                        <DeleteParameters>
                            <asp:Parameter Name="auto" Type="Int32" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblKey1" Name="CheckAgent_Guid" PropertyName="Text"
                                Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblNobrM" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblNobrS" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblKey1" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblStd" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadButton ID="btnClose" runat="server" OnClientClicking="CancelEdit" Text="close">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
    </asp:Panel>
</asp:Content>
