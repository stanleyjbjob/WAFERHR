<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="tsTitle.aspx.cs" Inherits="tsTitle" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <asp:Panel ID="plPopupFV" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="400px">
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
                            <EditItemTemplate><table class="TableFullBorder">
                                <tr>
                                    <th nowrap="nowrap">
                                        評量代碼</th>
                                    <th nowrap="nowrap">
                                        評量名稱</th>
                                    <th nowrap="nowrap">
                                        最小到最大區間</th>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">
                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("sCode") %>'></asp:Label></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="txtName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>'
                                            ValidationGroup="fv"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        從<asp:TextBox ID="txtMin" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iMin") %>'
                                            ValidationGroup="fv"></asp:TextBox>分到<asp:TextBox ID="txtMax" runat="server" CssClass="txtOrder"
                                                MaxLength="4" Text='<%# Bind("iMax") %>' ValidationGroup="fv"></asp:TextBox>分</td>
                                </tr>
                                <tr>
                                    <td colspan="3" nowrap="nowrap">
                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update"
                                                Text="修改" ValidationGroup="fv" />
                                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" Text="取消" /></td>
                                </tr>
                                <tr>
                                    <td colspan="3" nowrap="nowrap" style="text-align: left">
                                        <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                            Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td colspan="3" nowrap="nowrap" style="text-align: left">
                                        <asp:MaskedEditExtender ID="meeName" runat="server" ErrorTooltipEnabled="True" Mask="?{50}"
                                                MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtName">
                                        </asp:MaskedEditExtender>
                                        <asp:MaskedEditExtender ID="meeMin" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMin">
                                        </asp:MaskedEditExtender>
                                        <asp:MaskedEditExtender ID="meeMax" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMax">
                                        </asp:MaskedEditExtender>
                                        <asp:ValidatorCalloutExtender ID="vceName" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                TargetControlID="rfvName">
                                        </asp:ValidatorCalloutExtender>
                                    </td>
                                </tr>
                            </table>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <table class="TableFullBorder">
                                    <tr>
                                        <th nowrap="nowrap">
                                            評量代碼</th>
                                        <th nowrap="nowrap">
                                            評量名稱</th>
                                        <th nowrap="nowrap">
                                            最小到最大區間</th>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap">
                                            <asp:TextBox ID="txtCode" runat="server" CssClass="txtCode"
                                                Text='<%# Bind("sCode") %>' ValidationGroup="fv"></asp:TextBox></td>
                                        <td nowrap="nowrap">
                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>' ValidationGroup="fv"></asp:TextBox></td>
                                        <td nowrap="nowrap">
                                            從<asp:TextBox ID="txtMin" runat="server" CssClass="txtOrder" MaxLength="4"
                                                Text='<%# Bind("iMin") %>' ValidationGroup="fv"></asp:TextBox>分到<asp:TextBox ID="txtMax"
                                                    runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iMax") %>' ValidationGroup="fv"></asp:TextBox>分</td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" nowrap="nowrap">
                                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert"
                                                Text="新增" ValidationGroup="fv" /></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" nowrap="nowrap" style="text-align: left">
                                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                                    ID="rfvName" runat="server" ControlToValidate="txtName" Display="None" ErrorMessage="不允許空白"
                                                    SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator></td>
                                    </tr>
                                    <tr>
                                        <td colspan="3" nowrap="nowrap" style="text-align: left">
                                            <asp:MaskedEditExtender ID="meeCode" runat="server" ErrorTooltipEnabled="True" Mask="?{50}"
                                                MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtCode">
                                            </asp:MaskedEditExtender>
                                            <asp:MaskedEditExtender ID="meeName" runat="server" ErrorTooltipEnabled="True" Mask="?{50}"
                                                MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtName">
                                            </asp:MaskedEditExtender>
                                            <asp:MaskedEditExtender ID="meeMin" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMin">
                                            </asp:MaskedEditExtender>
                                            <asp:MaskedEditExtender ID="meeMax" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMax">
                                            </asp:MaskedEditExtender>
                                            <asp:ValidatorCalloutExtender ID="vceCode" runat="Server" HighlightCssClass="validatorCalloutHighlight"
                                                TargetControlID="rfvCode">
                                            </asp:ValidatorCalloutExtender>
                                            <asp:ValidatorCalloutExtender ID="vceName" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                TargetControlID="rfvName">
                                            </asp:ValidatorCalloutExtender>
                                            &nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [tsTitle] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO tsTitle(sCode, sName, iMin, iMax, sKeyMan, dKeyDate, tsTitleM_sCode) VALUES (@sCode, @sName, @iMin, @iMax, @sKeyMan, @dKeyDate, @tsTitleM_sCode)"
                            SelectCommand="SELECT * FROM [tsTitle] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE tsTitle SET sCode = @sCode, sName = @sName, iMin = @iMin, iMax = @iMax, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate WHERE (iAutoKey = @iAutoKey)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="sCode" Type="String" />
                                <asp:Parameter Name="sName" Type="String" />
                                <asp:Parameter Name="iMin" Type="Int32" />
                                <asp:Parameter Name="iMax" Type="Int32" />
                                <asp:Parameter Name="sKeyMan" Type="String" />
                                <asp:Parameter Name="dKeyDate" Type="String" />
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="sCode" Type="String" />
                                <asp:Parameter Name="sName" Type="String" />
                                <asp:Parameter Name="iMin" Type="Int32" />
                                <asp:Parameter Name="iMax" Type="Int32" />
                                <asp:Parameter Name="sKeyMan" Type="String" />
                                <asp:Parameter Name="dKeyDate" Type="String" />
                                <asp:Parameter Name="tsTitleM_sCode" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
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
                    <td nowrap="nowrap">
                        評等群組：<asp:DropDownList ID="ddlTitleM" runat="server" AppendDataBoundItems="True"
                            AutoPostBack="True" DataSourceID="sdsTitleM" DataTextField="sName" DataValueField="sCode">
                            <asp:ListItem Value="0">預設</asp:ListItem>
                        </asp:DropDownList><asp:SqlDataSource ID="sdsTitleM" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT [sCode], [sName] FROM [tsTitleM]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                            DataKeyNames="iAutoKey" DataSourceID="sdsGV" OnPageIndexChanged="gv_PageIndexChanged"
                            OnRowDataBound="gv_RowDataBound" OnSelectedIndexChanged="gv_SelectedIndexChanged"
                            Width="100%" OnRowCommand="gv_RowCommand" OnRowDeleted="gv_RowDeleted">
                            <RowStyle HorizontalAlign="Center" Wrap="True" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                            CommandName="Select" Text="選取" />&nbsp;<asp:Button ID="Button3" runat="server" CausesValidation="False"
                                                CommandArgument='<%# Eval("sCode") %>' CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');"
                                                Text="刪除" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                    <HeaderTemplate>
                                        <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                            Text="新增" />&nbsp;<asp:Button ID="btnExport" runat="server" CausesValidation="False"
                                                CommandName="Export" Text="匯出" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="sCode" HeaderText="評量代碼" SortExpression="sCode" />
                                <asp:BoundField DataField="sName" HeaderText="評量名稱" SortExpression="sName" />
                                <asp:BoundField DataField="iMin" HeaderText="最小值" SortExpression="iMin" />
                                <asp:BoundField DataField="iMax" HeaderText="最大值" SortExpression="iMax" />
                                <asp:BoundField DataField="sKeyMan" HeaderText="修改者" SortExpression="sKeyMan" />
                                <asp:BoundField DataField="dKeyDate" DataFormatString="{0:d}" HeaderText="修改日期" HtmlEncode="False"
                                    SortExpression="dKeyDate" />
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                                <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                    Text="新增" />
                            </EmptyDataTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [tsTitle] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO tsTitle(sCode, sName, iMin, iMax, sKeyMan, dKeyDate, tsTitleM_sCode) VALUES (@sCode, @sName, @iMin, @iMax, @sKeyMan, @dKeyDate, @tsTitleM_sCode)"
                            SelectCommand="SELECT * FROM [tsTitle]&#13;&#10;WHERE         (tsTitleM_sCode = @tsTitleM_sCode)" UpdateCommand="UPDATE tsTitle SET sCode = @sCode, sName = @sName, iMin = @iMin, iMax = @iMax, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate, tsTitleM_sCode = @tsTitleM_sCode WHERE (iAutoKey = @iAutoKey)">
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="sCode" Type="String" />
                                <asp:Parameter Name="sName" Type="String" />
                                <asp:Parameter Name="iMin" Type="Int32" />
                                <asp:Parameter Name="iMax" Type="Int32" />
                                <asp:Parameter Name="sKeyMan" Type="String" />
                                <asp:Parameter Name="dKeyDate" Type="String" />
                                <asp:Parameter Name="tsTitleM_sCode" />
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="sCode" Type="String" />
                                <asp:Parameter Name="sName" Type="String" />
                                <asp:Parameter Name="iMin" Type="Int32" />
                                <asp:Parameter Name="iMax" Type="Int32" />
                                <asp:Parameter Name="sKeyMan" Type="String" />
                                <asp:Parameter Name="dKeyDate" Type="String" />
                                <asp:Parameter Name="tsTitleM_sCode" />
                            </InsertParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlTitleM" DefaultValue="0" Name="tsTitleM_sCode"
                                    PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            &nbsp;
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
