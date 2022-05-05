<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="sysRole.aspx.cs" Inherits="sysRole" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="ucAuth.ascx" TagName="ucAuth" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <asp:Panel ID="plPopupFV" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="600px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragFV" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameFV" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitFV" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitFV_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblFVID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:FormView ID="fv" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsFV"
                                                            DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting"
                                                            OnItemUpdated="fv_ItemUpdated" OnItemUpdating="fv_ItemUpdating" Width="100%">
                                                            <EditItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" class="TableFullBorder">
                                                                    <tr>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            權限代碼</th>
                                                                        <th nowrap="nowrap" style="height: 14px">
                                                                            權限名稱</th>
                                                                        <th nowrap="nowrap" style="height: 14px">
                                                                            生失效日</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap">
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("iKey") %>'></asp:Label></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtRoleName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtDateB" runat="server" CssClass="txtDate" Text='<%# Bind("dDateA", "{0:d}") %>'
                                                                                ValidationGroup="fv"></asp:TextBox>到<asp:TextBox ID="txtDateE" runat="server" CssClass="txtDate"
                                                                                    Text='<%# Bind("dDateD", "{0:d}") %>' ValidationGroup="fv"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" nowrap="nowrap">
                                                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fv" />
                                                                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                Text="取消" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvRoleName" runat="server" ControlToValidate="txtRoleName"
                                                                                Display="None" ErrorMessage="不允許空白" ValidationGroup="fv" SetFocusOnError="True"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                                                                    ID="rfvDateB" runat="server" ControlToValidate="txtDateB" Display="None" ErrorMessage="不允許空白"
                                                                                    SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RangeValidator
                                                                                        ID="rvDateB" runat="server" ControlToValidate="txtDateB" Display="None" ErrorMessage="格式不正確"
                                                                                        MaximumValue="9999/12/31" MinimumValue="1900/1/1" Type="Date" SetFocusOnError="True"
                                                                                        ValidationGroup="fv"></asp:RangeValidator><asp:RequiredFieldValidator ID="rfvDateE"
                                                                                            runat="server" ControlToValidate="txtDateE" Display="None" ErrorMessage="不允許空白"
                                                                                            SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RangeValidator
                                                                                                ID="rvDateE" runat="server" ControlToValidate="txtDateE" Display="None" ErrorMessage="格式不正確"
                                                                                                MaximumValue="9999/12/31" MinimumValue="1900/1/1" Type="Date" SetFocusOnError="True"
                                                                                                ValidationGroup="fv"></asp:RangeValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" colspan="3" nowrap="nowrap" style="text-align: left">
                                                                            <asp:MaskedEditExtender ID="meeDateB" runat="server" AcceptNegative="Left" AutoComplete="true"
                                                                                AutoCompleteValue="9999/12/31" Mask="9999/99/99" MaskType="Date" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtDateB">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeDateE" runat="server" AcceptNegative="Left" AutoComplete="true"
                                                                                AutoCompleteValue="9999/12/31" Mask="9999/99/99" MaskType="Date" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtDateE">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeRoleName" runat="server" ErrorTooltipEnabled="True"
                                                                                Mask="?{50}" MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtRoleName">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceDateB" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvDateB">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceDateB1" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rvDateB">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceDateE" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvDateE">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceDateE1" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rvDateE">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceRoleName" runat="Server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvRoleName">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Bind("iAutoKey") %>' Visible="False"></asp:Label></td>
                                                                    </tr>
                                                                </table>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" class="TableFullBorder">
                                                                    <tr>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            權限代碼</th>
                                                                        <th nowrap="nowrap" style="height: 14px">
                                                                            權限名稱</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap">
                                                                            系統自訂</td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtRoleName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" nowrap="nowrap">
                                                                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fv" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvRoleName" runat="server" ControlToValidate="txtRoleName"
                                                                                Display="None" ErrorMessage="不允許空白" ValidationGroup="fv" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td align="center" colspan="2" nowrap="nowrap" style="text-align: left">
                                                                            <asp:MaskedEditExtender ID="meeRoleName" runat="server" ErrorTooltipEnabled="True"
                                                                                Mask="?{50}" MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtRoleName">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceRoleName" runat="Server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvRoleName">
                                                                            </asp:ValidatorCalloutExtender>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </InsertItemTemplate>
                                                        </asp:FormView>
                                                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            InsertCommand="INSERT INTO [sysRole] ([iKey], [sName], [dDateA], [dDateD], [sKeyMan], [dKeyDate]) VALUES (@iKey, @sName, @dDateA, @dDateD, @sKeyMan, @dKeyDate)"
                                                            SelectCommand="SELECT * FROM [sysRole] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE [sysRole] SET [iKey] = @iKey, [sName] = @sName, [dDateA] = @dDateA, [dDateD] = @dDateD, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="iKey" Type="Int32" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </UpdateParameters>
                                                            <InsertParameters>
                                                                <asp:Parameter Name="iKey" Type="Int32" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                            </InsertParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupFV" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupFV" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior1" DropShadow="true" PopupControlID="plPopupFV"
                            PopupDragHandleControlID="plDragFV" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupFV">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gv" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                            DataKeyNames="iAutoKey" DataSourceID="sdsGV" OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound"
                            OnRowDeleted="gv_RowDeleted" OnSelectedIndexChanged="gv_SelectedIndexChanged"
                            Width="100%">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="選取" />&nbsp;<asp:Button ID="btnRole" runat="server" CausesValidation="False"
                                                CommandArgument='<%# Eval("iKey") %>' CommandName="sysRoleEdit" Text="網頁權限" />&nbsp;<asp:Button
                                                    ID="btnLoginUser" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iKey") %>'
                                                    CommandName="sysLoginUserEdit" Text="帳號權限" />
                                        <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iKey") %>'
                                            CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" Enabled="False" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                    <HeaderTemplate>
                                        <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                            Text="新增" />&nbsp;<asp:Button ID="btnExport" runat="server" CausesValidation="False"
                                                CommandName="Export" Text="匯出" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="iKey" HeaderText="權限代碼" SortExpression="iKey">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sName" HeaderText="權限名稱" SortExpression="sName">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dDateA" DataFormatString="{0:d}" HeaderText="生效日" HtmlEncode="False"
                                    SortExpression="dDateA">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dDateD" DataFormatString="{0:d}" HeaderText="失效日" HtmlEncode="False"
                                    SortExpression="dDateA">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sKeyMan" HeaderText="修改者" SortExpression="sKeyMan">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dKeyDate" DataFormatString="{0:d}" HeaderText="修改日期" HtmlEncode="False"
                                    SortExpression="dKeyDate">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                                <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                    Text="新增" />
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [sysRole] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [sysRole]">
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupRole" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="320px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragRole" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameRole" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitRole" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitRole_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblRoleID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <uc1:ucAuth ID="ucAuthRole" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center">
                                                        <asp:Button ID="btnSaveRole" runat="server" CausesValidation="False" OnClick="btnSaveRole_Click"
                                                            OnClientClick="return confirm('您確定要儲存嗎？');" Text="儲存" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupRole" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupRole" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupRole"
                            PopupDragHandleControlID="plDragRole" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupRole">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupLogin" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="320px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragLogin" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameLogin" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitLogin" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitLogin_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblLoginID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <uc1:ucAuth ID="ucAuthLogin" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center">
                                                        <asp:Button ID="btnSaveLogin" runat="server" CausesValidation="False" OnClick="btnSaveLogin_Click"
                                                            OnClientClick="return confirm('您確定要儲存嗎？');" Text="儲存" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupLogin" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupLogin" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior3" DropShadow="true" PopupControlID="plPopupLogin"
                            PopupDragHandleControlID="plDragLogin" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupLogin">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
