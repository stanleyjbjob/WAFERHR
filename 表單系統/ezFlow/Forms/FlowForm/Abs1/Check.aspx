<%@ Page Title="" Language="C#" MasterPageFile="~/mpCheck20140115.master" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="Abs1_Check" %>


<%@ Register Assembly="Telerik.Web.UI" Namespace="Telerik.Web.UI" TagPrefix="telerik" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <style type="text/css">
.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox_Default{color:#333;font-size:12px;font-family:"Segoe UI",Arial,Helvetica,sans-serif}.RadComboBox{text-align:left;display:inline-block;vertical-align:middle;white-space:nowrap;*display:inline;*zoom:1}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox .rcbReadOnly .rcbInputCellLeft{background-position:0 -88px}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2017.1.118.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbInputCell{background-image:url('mvwres://Telerik.Web.UI, Version=2017.1.118.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbInputCellLeft{background-position:0 0}.RadComboBox .rcbInputCell{padding-right:4px;padding-left:5px;width:100%;height:20px;line-height:20px;text-align:left;vertical-align:middle}.RadComboBox .rcbInputCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox .rcbReadOnly .rcbArrowCellRight{background-position:-162px -176px}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2017.1.118.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}.RadComboBox_Default .rcbArrowCell{background-image:url('mvwres://Telerik.Web.UI, Version=2017.1.118.40, Culture=neutral, PublicKeyToken=121fae78165ba3d4/Telerik.Web.UI.Skins.Default.Common.radFormSprite.png')}.RadComboBox .rcbArrowCellRight{background-position:-18px -176px}.RadComboBox .rcbArrowCell{width:18px}.RadComboBox .rcbArrowCell{padding:0;border-width:0;border-style:solid;background-color:transparent;background-repeat:no-repeat}</style>

    </asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1">
        <AjaxSettings>
            <telerik:AjaxSetting AjaxControlID="btnSave">
                <UpdatedControls>
                    <telerik:AjaxUpdatedControl ControlID="plAppS" />
                    <telerik:AjaxUpdatedControl ControlID="plSubmit" UpdatePanelCssClass="" />
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
    <asp:Panel ID="plAppM" runat="server" ToolTip="申請人" style='font-size:16px !important'>
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
    <asp:Panel ID="plAppS" runat="server" ToolTip="被申請人" style='font-size:16px !important'>
        <table width="100%">
            <tr>
                <th>
                    被申請人資訊</th>
            </tr>
            <tr>
                <td>
                    <table width="100%">
                        <tr>
                            <th>
                                姓名
                            </th>
                            <td>
                                <asp:Label ID="lblName" runat="server"></asp:Label>
                            </td>
                            <th>
                                代理人</th>
                            <td>
                                <asp:Label ID="lblNameAgent" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <th>
                                日期
                            </th>
                            <td colspan="3">

                                <asp:Label ID="lblDate" runat="server"></asp:Label>

                            </td>
                        </tr>
                        <tr>
                            <th>
                                公出地點</th>
                            <td colspan="3">
                                <telerik:RadComboBox ID="txtHcode" runat="server" Culture="zh-TW" EnableVirtualScrolling="True" ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                                <telerik:RadButton ID="btnSave" runat="server" OnClick="btnSave_Click" Text="儲存">
                                </telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <th>事由</th>
                            <td colspan="3">
                                <asp:Label ID="lblDesc" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td colspan="4">
                                <asp:Label ID="lblMsgAdd" runat="server"></asp:Label>
                                <asp:Label ID="lblAddGuid" runat="server" Visible="False"></asp:Label>
                            </td>
                        </tr>
                    </table>
                </td>
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
                <tr>
                    <td>
                        <asp:RadioButtonList ID="rblSign" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                            <asp:ListItem Selected="True" Value="1">核准</asp:ListItem>
                            <asp:ListItem Value="0">駁回</asp:ListItem>
                        </asp:RadioButtonList>
                    </td>
                </tr>
            </table>
        </asp:Panel>
    </asp:Panel>
    <asp:Panel ID="plSubmit" runat="server" ToolTip="送出傳簽">
        <telerik:RadButton ID="btnSubmit" runat="server" Text="送出傳簽" OnClick="btnSubmit_Click"  Font-Bold="True" Font-Size="XX-Large" ForeColor="Blue" Height="50px"
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
          <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
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
