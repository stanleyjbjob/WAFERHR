<%@ Page Title="" Language="C#" MasterPageFile="~/mpMT20140325.master" AutoEventWireup="true"
    CodeFile="FormMail.aspx.cs" Inherits="MT_FormMail" %>

<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1" >
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plContent" />
                </UpdatedControls>
            </telerik:AjaxSetting>
            <telerik:AjaxSetting AjaxControlID="gvAppM">
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
        <table>
            <tr>
                <td align="center">
                    表單名稱
                </td>
                <td align="center">
                    代碼
                </td>
                <td align="center">
                    名稱
                </td>
                <td align="center" class="style1">
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadComboBox ID="txtFlowForm" runat="server" CssClass="formItem" Culture="zh-TW"
                        Filter="Contains" ItemsPerRequest="10" LoadingMessage="載入中…" 
                        AutoPostBack="True">
                    </telerik:RadComboBox>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtCode" runat="server" Width="100px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadTextBox ID="txtName" runat="server" Width="200px">
                    </telerik:RadTextBox>
                </td>
                <td>
                    <telerik:RadButton ID="btnAdd" runat="server" Text="新增" OnClick="btnAdd_Click">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>
        &nbsp;<telerik:RadGrid ID="gvAppM" runat="server" CellSpacing="0" Culture="zh-TW"
            DataSourceID="sdsAppM" GridLines="None" Width="100%" OnItemCommand="gvAppM_ItemCommand">
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
                            <telerik:RadButton ID="btnEditMail" runat="server" CommandArgument='<%# Eval("iAutoKey") %>'
                                CommandName="EditMail" Text="編輯主旨及內文">
                            </telerik:RadButton>
                            <telerik:RadButton ID="btnDel" runat="server" CommandArgument='<%# Eval("iAutoKey") %>'
                                CommandName="Del" Text="刪除"  OnClientClicking="ExcuteConfirm">
                            </telerik:RadButton>
                        </ItemTemplate>
                    </telerik:GridTemplateColumn>
                    <telerik:GridBoundColumn DataField="sCode" FilterControlAltText="Filter sCode column"
                        HeaderText="代碼" SortExpression="sCode" UniqueName="sCode">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="sName" FilterControlAltText="Filter sName column"
                        HeaderText="名稱" SortExpression="sName" UniqueName="sName">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="sKeyMan" FilterControlAltText="Filter sKeyMan column"
                        HeaderText="登錄者" SortExpression="sKeyMan" UniqueName="sKeyMan">
                    </telerik:GridBoundColumn>
                    <telerik:GridBoundColumn DataField="dKeyDate" DataType="System.DateTime" FilterControlAltText="Filter dKeyDate column"
                        HeaderText="登入時間" SortExpression="dKeyDate" UniqueName="dKeyDate">
                    </telerik:GridBoundColumn>
                </Columns>
                <EditFormSettings>
                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                    </EditColumn>
                </EditFormSettings>
                <ItemStyle HorizontalAlign="Center" />
                <GroupHeaderItemStyle HorizontalAlign="Center" />
                <AlternatingItemStyle HorizontalAlign="Center" />
                <CommandItemStyle HorizontalAlign="Center" />
            </MasterTableView>
            <HeaderStyle HorizontalAlign="Center" />
            <ItemStyle HorizontalAlign="Center" />
            <FilterMenu EnableImageSprites="False">
            </FilterMenu>
        </telerik:RadGrid>
        <asp:SqlDataSource ID="sdsAppM" runat="server" ConnectionString="<%$ ConnectionStrings:Flow %>"
            SelectCommand="SELECT wfFormMail.* FROM wfFormMail
WHERE          (sFormCode = @sFormCode)">
            <SelectParameters>
                <asp:ControlParameter ControlID="txtFlowForm" Name="sFormCode" 
                    PropertyName="SelectedValue" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblViewUrl" runat="server" Visible="False"></asp:Label>
    </asp:Panel>
</asp:Content>
