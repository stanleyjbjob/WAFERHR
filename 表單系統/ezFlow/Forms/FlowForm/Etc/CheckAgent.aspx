<%@ Page Title="" Language="C#" MasterPageFile="~/mpMT20140325.master" AutoEventWireup="true"
    CodeFile="CheckAgent.aspx.cs" Inherits="Etc_CheckAgent" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .style1
        {
            width: 100%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">
        <script language="javascript" type="text/javascript">
            function refreshGrid() {
                var masterTable = $find("<%=gvAgent.ClientID%>").get_masterTableView();
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
             OnClientClose="refreshGrid"    Left="150px" ReloadOnShow="true" ShowContentDuringLoad="false" Modal="true">
            </telerik:RadWindow>
        </Windows>
    </telerik:RadWindowManager>
    <asp:Panel ID="plContent" runat="server">
        <table>
            <tr>
                <td>
                    <table class="style1">
                        <tr>
                            <td align="center" colspan="5">
                                代理設定
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                被代理人
                            </td>
                            <td align="center">
                                被代理人角色
                            </td>
                            <td align="center">
                                代理人
                            </td>
                            <td align="center">
                                順位
                            </td>
                            <td align="center" rowspan="2">
                                <telerik:RadButton ID="btnAgentAdd" runat="server" Text="儲存" 
                                    onclick="btnAgentAdd_Click">
                                </telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <telerik:RadComboBox ID="txtNobr" runat="server" AllowCustomText="True" AutoPostBack="True"
                                    Culture="zh-TW" EnableVirtualScrolling="True" Filter="Contains" ItemsPerRequest="10"
                                    LoadingMessage="載入中…" OnDataBound="txtName_DataBound" OnSelectedIndexChanged="txtName_SelectedIndexChanged"
                                    OnTextChanged="txtName_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
                            </td>
                            <td align="center">
                                <telerik:RadComboBox ID="txtRole" runat="server" Culture="zh-TW" EnableVirtualScrolling="True"
                                    ItemsPerRequest="10" LoadingMessage="載入中…">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblRole" runat="server" Visible="False"></asp:Label>
                            </td>
                            <td align="center">
                                <telerik:RadComboBox ID="txtNameAgent" runat="server" AllowCustomText="True" Culture="zh-TW"
                                    EnableVirtualScrolling="True" Filter="Contains" ItemsPerRequest="10" LoadingMessage="載入中…"
                                    AutoPostBack="True" OnDataBound="txtNameAgent_DataBound" OnSelectedIndexChanged="txtNameAgent_SelectedIndexChanged"
                                    OnTextChanged="txtNameAgent_TextChanged">
                                </telerik:RadComboBox>
                                <asp:Label ID="lblNobrAgent" runat="server" Visible="False"></asp:Label>
                            </td>
                            <td align="center">
                                <telerik:RadComboBox ID="txtSort" runat="server" Culture="zh-TW" EnableVirtualScrolling="True"
                                    ItemsPerRequest="10" LoadingMessage="載入中…" Width="40px">
                                </telerik:RadComboBox>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    說明：<br /> 1.名單裡有你選的相同選項，順位是可以被修改的。<br /> 2.如果沒有設定任何一張表單，代表全部表單都符合代理條件。<br /> 3.順位相同的情況下會用亂數決定優先順序。</td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gvAgent" runat="server" AllowMultiRowSelection="True" 
                        AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" 
                        CellSpacing="0" Culture="zh-TW" DataSourceID="sdsAgent" GridLines="None" 
                        onitemcommand="gvAgent_ItemCommand" ondatabound="gvAgent_DataBound">
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" UseClientSelectColumnOnly="True" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="auto" DataSourceID="sdsAgent">
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" 
                                Visible="True">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" 
                                Visible="True">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" 
                                    UniqueName="TemplateColumn">
                                    <ItemTemplate>
                                        <telerik:RadButton ID="btnForm" runat="server" 
                                            CommandArgument='<%# Eval("Guid") %>' CommandName="Form" Text="表單權限">
                                        </telerik:RadButton>
                                        <telerik:RadButton ID="btnDel" runat="server" 
                                            CommandArgument='<%# Eval("Guid") %>' CommandName="Del" 
                                            OnClientClicking="ExcuteConfirm" Text="刪除">
                                        </telerik:RadButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="Dept_nameSource" 
                                    FilterControlAltText="Filter Dept_nameSource column" HeaderText="被代理人部門" 
                                    SortExpression="Dept_nameSource" UniqueName="Dept_nameSource">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Pos_nameSource" 
                                    FilterControlAltText="Filter Pos_nameSource column" HeaderText="被代理人職稱" 
                                    SortExpression="Pos_nameSource" UniqueName="Pos_nameSource">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Emp_idTarget" 
                                    FilterControlAltText="Filter Emp_idTarget column" HeaderText="代理人工號" 
                                    SortExpression="Emp_idTarget" UniqueName="Emp_idTarget">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Emp_nameTarget" 
                                    FilterControlAltText="Filter Emp_nameTarget column" HeaderText="代理人姓名" 
                                    SortExpression="Emp_nameTarget" UniqueName="Emp_nameTarget">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Dept_nameTarget" 
                                    FilterControlAltText="Filter Dept_nameTarget column" HeaderText="代理人部門" 
                                    SortExpression="Dept_nameTarget" UniqueName="Dept_nameTarget">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Pos_nameTarget" 
                                    FilterControlAltText="Filter Pos_nameTarget column" HeaderText="代理人職稱" 
                                    SortExpression="Pos_nameTarget" UniqueName="Pos_nameTarget">
                                </telerik:GridBoundColumn>
                                                                <telerik:GridBoundColumn DataField="Guid" 
                                    FilterControlAltText="Filter Form column" HeaderText="代理表單" 
                                    SortExpression="Form" UniqueName="Form">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="Sort" DataType="System.Int32" 
                                    FilterControlAltText="Filter Sort column" HeaderText="順位" SortExpression="Sort" 
                                    UniqueName="Sort">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="KeyMan" 
                                    FilterControlAltText="Filter KeyMan column" HeaderText="登錄者" 
                                    SortExpression="KeyMan" UniqueName="KeyMan">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="KeyDate" DataType="System.DateTime" 
                                    FilterControlAltText="Filter KeyDate column" HeaderText="登錄日期" 
                                    SortExpression="KeyDate" UniqueName="KeyDate">
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
                    <asp:SqlDataSource ID="sdsAgent" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:Flow %>" 
                        DeleteCommand="DELETE FROM [CheckAgent] WHERE [auto] = @auto" 
                        SelectCommand="SELECT CheckAgent.auto, CheckAgent.Role_idSource, CheckAgent.Emp_idSource, CheckAgent.Role_idTarget, CheckAgent.Emp_idTarget, CheckAgent.Sort, CheckAgent.Guid, CheckAgent.KeyMan, CheckAgent.KeyDate, Emp_1.name AS Emp_nameSource, Emp.name AS Emp_nameTarget, Dept.name AS Dept_nameSource, Dept_1.name AS Dept_nameTarget, Pos.name AS Pos_nameSource, Pos_1.name AS Pos_nameTarget FROM Emp AS Emp_1 RIGHT OUTER JOIN Dept RIGHT OUTER JOIN Pos RIGHT OUTER JOIN Emp RIGHT OUTER JOIN Pos AS Pos_1 RIGHT OUTER JOIN CheckAgent LEFT OUTER JOIN Role AS Role_1 ON CheckAgent.Emp_idTarget = Role_1.Emp_id AND CheckAgent.Role_idTarget = Role_1.id LEFT OUTER JOIN Role ON CheckAgent.Emp_idSource = Role.Emp_id AND CheckAgent.Role_idSource = Role.id ON Pos_1.id = Role_1.Pos_id LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id ON Emp.id = Role_1.Emp_id ON Pos.id = Role.Pos_id ON Dept.id = Role.Dept_id ON Emp_1.id = Role.Emp_id WHERE (CheckAgent.Emp_idSource = @Emp_idSource) AND (GETDATE() BETWEEN Role_1.dateB AND Role_1.dateE) AND (GETDATE() BETWEEN Role.dateB AND Role.dateE)">
                        <DeleteParameters>
                            <asp:Parameter Name="auto" Type="Int32" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNobr" Name="Emp_idSource" 
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <table class="style1">
                        <tr>
                            <td align="center" colspan="3">
                                代理日期
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                開始
                            </td>
                            <td align="center">
                                結束
                            </td>
                            <td align="center" rowspan="2">
                                <telerik:RadButton ID="btnDateAdd" runat="server" Text="新增" 
                                    onclick="btnDateAdd_Click">
                                </telerik:RadButton>
                            </td>
                        </tr>
                        <tr>
                            <td align="center">
                                <telerik:RadDateTimePicker ID="txtDateA" runat="server" Width="200px">
                                </telerik:RadDateTimePicker>
                            </td>
                            <td align="center">
                                <telerik:RadDateTimePicker ID="txtDateD" runat="server" Width="200px">
                                </telerik:RadDateTimePicker>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadGrid ID="gvDate" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CellSpacing="0" Culture="zh-TW" GridLines="None"
                        DataSourceID="sdsDate" onitemcommand="gvDate_ItemCommand">
                        <ClientSettings>
                            <Selecting AllowRowSelect="True" UseClientSelectColumnOnly="True" />
                        </ClientSettings>
                        <MasterTableView DataKeyNames="auto" DataSourceID="sdsDate">
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
                                <telerik:GridBoundColumn DataField="dateB" DataType="System.DateTime" FilterControlAltText="Filter dateB column"
                                    HeaderText="開始日期" SortExpression="dateB" UniqueName="dateB">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dateE" DataType="System.DateTime" FilterControlAltText="Filter dateE column"
                                    HeaderText="結束日期" SortExpression="dateE" UniqueName="dateE">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="KeyMan" FilterControlAltText="Filter KeyMan column"
                                    HeaderText="登錄者" SortExpression="KeyMan" UniqueName="KeyMan">
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="KeyDate" DataType="System.DateTime" FilterControlAltText="Filter KeyDate column"
                                    HeaderText="登錄日期" SortExpression="KeyDate" UniqueName="KeyDate">
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
                    <asp:SqlDataSource ID="sdsDate" runat="server" ConnectionString="<%$ ConnectionStrings:Flow %>"
                        DeleteCommand="DELETE FROM [EmpAgentDate] WHERE [auto] = @auto" SelectCommand="SELECT * FROM [EmpAgentDate] 
WHERE          (Emp_id = @Emp_id) AND (IsValid = 1)">
                        <DeleteParameters>
                            <asp:Parameter Name="auto" Type="Int32" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNobr" Name="Emp_id" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
        <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblViewUrl" runat="server" Visible="False"></asp:Label>
        <asp:Label ID="lblAppNobr" runat="server" Visible="False"></asp:Label>
    </asp:Panel>
</asp:Content>
