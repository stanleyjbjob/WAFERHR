<%@ Page Title="" Language="C#" MasterPageFile="~/mpCheck20140115.master" AutoEventWireup="true" CodeFile="Check1.aspx.cs" Inherits="Ovt_Check1" %>


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
                    被申請人資訊
                </th>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gvAppS" runat="server" Culture="zh-TW" Width="100%" OnItemCommand="gvAppS_ItemCommand" 
                        onitemdatabound="gvAppS_ItemDataBound" OnNeedDataSource="gvAppS_NeedDataSource">
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
                                        <telerik:RadButton ID="btnDelete" runat="server" CommandName="Del" Text="駁回" ForeColor="Red"
                                            CommandArgument='<%# Eval("iAutoKey") %>' ToolTip='<%# Eval("sState") %>'>
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
                                <telerik:GridBoundColumn DataField="dDateB1" DataFormatString="{0:d}" DataType="System.DateTime"
                                    FilterControlAltText="Filter dDateB1 column" HeaderText="預估日期" SortExpression="dDateB1"
                                    UniqueName="dDateB1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sTimeB1" FilterControlAltText="Filter sTimeB1 column"
                                    HeaderText="開始時間" SortExpression="sTimeB1" UniqueName="sTimeB1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sTimeE1" FilterControlAltText="Filter sTimeE1 column"
                                    HeaderText="結束時間" SortExpression="sTimeE1" UniqueName="sTimeE1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="iTotalHour1" FilterControlAltText="Filter iTotalHour1 column"
                                    HeaderText="預估時數" SortExpression="iTotalHour1" UniqueName="iTotalHour1">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sOtrcdName" FilterControlAltText="Filter sOtrcdName column"
                                    HeaderText="加班原因" SortExpression="sOtrcdName" UniqueName="sOtrcdName">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="sNote" FilterControlAltText="Filter sNote column"
                                    HeaderText="說明" SortExpression="sNote" UniqueName="sNote">
                                </telerik:GridBoundColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <HeaderStyle HorizontalAlign="Center" />
                        <ItemStyle HorizontalAlign="Center" />
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                </td>
            </tr>
            <tr>
                <td>
                    ※被駁回的資料將以整列<font color="red">紅色</font>表示。</td>
            </tr>
        </table>
        <asp:Panel ID="plManageNote" runat="server" ToolTip="意見">
            <table width="100%">
                <tr>
                    <th>
                        主管意見
                    </th>
                </tr>
                <tr>
                    <th>
                        <telerik:RadTextBox ID="txtNote" runat="server" EmptyMessage="請輸入您的意見..." 
                            Height="50px" TextMode="MultiLine" Width="100%">
                        </telerik:RadTextBox>
                    </th>
                </tr>
                <tr>
                    <td align="center">
                        審核過程</td>
                </tr>
                <tr>
                    <td>
                        <telerik:RadGrid ID="gvSign" runat="server" CellSpacing="0" Culture="zh-TW" 
                            DataSourceID="sdsSign" GridLines="None" Width="100%">
                            <MasterTableView AutoGenerateColumns="False" DataKeyNames="iAutoKey" 
                                DataSourceID="sdsSign">
                                <CommandItemSettings ExportToPdfText="Export to PDF" />
                                <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" 
                                    Visible="True">
                                </RowIndicatorColumn>
                                <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                                    Visible="True">
                                </ExpandCollapseColumn>
                                <Columns>
                                    <telerik:GridBoundColumn DataField="sNobr" 
                                        FilterControlAltText="Filter sNobr column" HeaderText="工號" 
                                        SortExpression="sNobr" UniqueName="sNobr">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="sName" 
                                        FilterControlAltText="Filter sName column" HeaderText="姓名" 
                                        SortExpression="sName" UniqueName="sName">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="sDeptName" 
                                        FilterControlAltText="Filter sDeptName column" HeaderText="部門" 
                                        SortExpression="sDeptName" UniqueName="sDeptName">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="sNote" 
                                        FilterControlAltText="Filter sNote column" HeaderText="意見" 
                                        SortExpression="sNote" UniqueName="sNote">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                    <telerik:GridBoundColumn DataField="dKeyDate" DataType="System.DateTime" 
                                        FilterControlAltText="Filter dKeyDate column" HeaderText="簽核日期" 
                                        SortExpression="dKeyDate" UniqueName="dKeyDate">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </telerik:GridBoundColumn>
                                </Columns>
                                <EditFormSettings>
                                    <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                    </EditColumn>
                                </EditFormSettings>
                            </MasterTableView>
                            <HeaderStyle HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" />
                            <FilterMenu EnableImageSprites="False">
                            </FilterMenu>
                        </telerik:RadGrid>
                        <asp:SqlDataSource ID="sdsSign" runat="server" 
                            ConnectionString="<%$ ConnectionStrings:Flow %>" 
                            SelectCommand="SELECT * FROM [wfFormSignM] WHERE ([sProcessID] = @sProcessID)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" 
                                    PropertyName="Text" Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>
    <asp:Panel ID="plSubmit" runat="server" ToolTip="送出傳簽">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="送出傳簽" OnClick="btnSubmit_Click" Font-Bold="True" Font-Size="XX-Large" ForeColor="Blue" Height="50px"
            OnClientClicking="ExcuteConfirm">
        </telerik:RadButton>
        <asp:Label ID="lblMsgSubmit" runat="server"></asp:Label>
        <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblFlowTreeID" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblNobrSign" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblDeptTree" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblManage" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblApKey" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblUserInfo" runat="server" Visible="False"></asp:Label>
    </asp:Panel>
    <asp:Panel ID="plNote" runat="server" ToolTip="備註事項">
        <table width="100%">
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
