<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="lnCategoryL.aspx.cs" Inherits="lnCategoryL" Title="Untitled Page" %>

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
                                                                <table class="TableFullBorder">
                                                                    <tr>
                                                                        <th nowrap="noWrap">
                                                                            題目代碼</th>
                                                                        <th nowrap="noWrap">
                                                                            題目名稱</th>
                                                                        <th nowrap="noWrap">
                                                                            順位</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("sCode") %>'></asp:Label></td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3">
                                                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fv" />
                                                                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                Text="取消" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" style="text-align: left">
                                                                            <asp:MaskedEditExtender ID="meeName" runat="server" ErrorTooltipEnabled="True" Mask="?{50}"
                                                                                MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtName">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeOrder" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtOrder">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceName" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvName">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label></td>
                                                                    </tr>
                                                                </table>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <table class="TableFullBorder">
                                                                    <tr>
                                                                        <th>
                                                                            題目代碼</th>
                                                                        <th>
                                                                            題目名稱</th>
                                                                        <th>
                                                                            順位</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:TextBox ID="txtCode" runat="server" CssClass="txtCode" Text='<%# Bind("sCode") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3">
                                                                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fv" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                                                                Display="None" ErrorMessage="不允許空白" ValidationGroup="fv" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                                                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                                                                Display="None" ErrorMessage="不允許空白" ValidationGroup="fv" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" style="text-align: left">
                                                                            <asp:MaskedEditExtender ID="meeCode" runat="server" ErrorTooltipEnabled="True" Mask="?{50}"
                                                                                MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtCode">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeName" runat="server" ErrorTooltipEnabled="True" Mask="?{50}"
                                                                                MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtName">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeOrder" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtOrder">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceCode" runat="Server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvCode">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceName" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvName">
                                                                            </asp:ValidatorCalloutExtender>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </InsertItemTemplate>
                                                        </asp:FormView>
                                                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            InsertCommand="INSERT INTO [lnCategoryL] ([sCode], [sName], [iOrder], [sKeyMan], [dKeyDate]) VALUES (@sCode, @sName, @iOrder, @sKeyMan, @dKeyDate)"
                                                            SelectCommand="SELECT * FROM [lnCategoryL] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE [lnCategoryL] SET [sCode] = @sCode, [sName] = @sName, [iOrder] = @iOrder, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="sCode" Type="String" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="iOrder" Type="Int32" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </UpdateParameters>
                                                            <InsertParameters>
                                                                <asp:Parameter Name="sCode" Type="String" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="iOrder" Type="Int32" />
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
                            Width="100%" AllowPaging="True" OnPageIndexChanged="gv_PageIndexChanged">
                            <RowStyle HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                            CommandName="Select" Text="選取" />
                                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                            CommandName="lnCategoryLEdit" Text="編輯中分類" />&nbsp;<asp:Button ID="Button3" runat="server"
                                                CausesValidation="False" CommandArgument='<%# Eval("sCode") %>' CommandName="Delete"
                                                OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                    <HeaderTemplate>
                                        <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                            Text="新增" />&nbsp;<asp:Button ID="btnExport" runat="server" CausesValidation="False"
                                                CommandName="Export" Text="匯出" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                <asp:BoundField DataField="sCode" HeaderText="題目代碼" SortExpression="sCode" />
                                <asp:BoundField DataField="sName" HeaderText="題目名稱" SortExpression="sName" />
                                <asp:BoundField DataField="iOrder" HeaderText="順位" SortExpression="iOrder" />
                                <asp:BoundField DataField="iCount" HeaderText="子類別數" SortExpression="iCount" />
                                <asp:BoundField DataField="sKeyMan" HeaderText="修改者" SortExpression="sKeyMan" />
                                <asp:BoundField DataField="dKeyDate" DataFormatString="{0:d}" HeaderText="修改日期" HtmlEncode="False"
                                    SortExpression="dKeyDate" />
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                                <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                    Text="新增" />
                            </EmptyDataTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [lnCategoryL] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT iAutoKey, sCode, sName, iOrder, sKeyMan, dKeyDate, (SELECT COUNT(*) AS c FROM lnCategoryM WHERE (lnCategoryL_sCode = lnCategoryL.sCode)) AS iCount FROM lnCategoryL">
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupEdit" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="400px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragEdit" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameEdit" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitEdit" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitEdit_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblEditID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <uc1:ucAuth ID="ucEdit" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center">
                                                        <asp:Button ID="btnSaveEdit" runat="server" CausesValidation="False" OnClick="btnSaveLogin_Click"
                                                            OnClientClick="return confirm('您確定要儲存嗎？');" Text="儲存" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupEdit" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupEdit" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupEdit"
                            PopupDragHandleControlID="plDragEdit" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupEdit">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
