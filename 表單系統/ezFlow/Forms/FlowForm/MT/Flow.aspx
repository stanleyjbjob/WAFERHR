<%@ Page Title="" Language="C#" MasterPageFile="~/mpDialog20140102.master" AutoEventWireup="true"
    CodeFile="Flow.aspx.cs" Inherits="MT_Flow" %>

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
        </AjaxSettings>
    </telerik:RadAjaxManager>
    <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server" Skin="Default">
    </telerik:RadAjaxLoadingPanel>
    <telerik:RadWindowManager ID="RadWindowManager1" runat="server" EnableShadow="true">
    </telerik:RadWindowManager>
    <asp:Panel ID="plContent" runat="server">
        <telerik:RadGrid ID="gvAppM" runat="server" CellSpacing="0" Culture="zh-TW" DataSourceID="sdsAppM"
            GridLines="None" Width="100%" OnItemCommand="gvAppM_ItemCommand">
            <MasterTableView AutoGenerateColumns="False" DataKeyNames="iAutoKey" DataSourceID="sdsAppM">
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
                            <telerik:RadButton ID="btnView" runat="server" CommandArgument='<%# Eval("idProcess") %>'
                               Visible="false"  CommandName="View" Text="內容">
                            </telerik:RadButton>
                            <telerik:RadButton ID="btnTake" runat="server" CommandArgument='<%# Eval("idProcess") %>'
                                CommandName="Take" Text="抽單" OnClientClicking="ExcuteConfirm">
                            </telerik:RadButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="idProcess" FilterControlAltText="Filter idProcess column"
                        HeaderText="流程序號" SortExpression="idProcess" UniqueName="idProcess">
                        <ItemStyle HorizontalAlign="Center" />
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="sInfo" FilterControlAltText="Filter sInfo column"
                        HeaderText="資訊" SortExpression="sInfo" UniqueName="sInfo">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                    </EditColumn>
                </EditFormSettings>
                <ItemStyle HorizontalAlign="Left" />
            </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
        </telerik:RadGrid>
        <asp:SqlDataSource ID="sdsAppM" runat="server" ConnectionString="<%$ ConnectionStrings:Flow %>"
            SelectCommand="SELECT * FROM wfFormApp WHERE (sFormCode = @sFormCode) AND (sNobr = @sNobr) AND (sState = '1')">
            <SelectParameters>
                <asp:ControlParameter ControlID="lblFormCode" Name="sFormCode" PropertyName="Text"
                    Type="String" />
                <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" Type="String" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
        <telerik:RadButton ID="btnClose" runat="server" onclientclicking="CancelEdit" 
            Text="關閉">
        </telerik:RadButton>
    </asp:Panel>
</asp:Content>
