<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="lnCategoryS.aspx.cs" Inherits="lnCategoryS" Title="Untitled Page" ValidateRequest="false" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<%@ Register Src="ucAuth.ascx" TagName="ucAuth" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
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
                                                            <asp:Label ID="lblDragNameFV" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitFV" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitFV_Click" />
                                                        </td>
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
                                                                        <th nowrap="nowrap">
                                                                            題目代碼
                                                                        </th>
                                                                        <th nowrap="nowrap">
                                                                            題目名稱
                                                                        </th>
                                                                        <th nowrap="nowrap">
                                                                            所屬中類別
                                                                        </th>
                                                                        <th nowrap="nowrap">
                                                                            順位
                                                                        </th>
                                                                        <th nowrap="nowrap">
                                                                            生失效日
                                                                        </th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap">
                                                                            <asp:Label ID="Label5" runat="server" Text='<%# Bind("sCode") %>'></asp:Label>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox>
                                                                        </td>
                                                                        <td nowrap="nowrap" style="width: 81px">
                                                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCate"
                                                                                DataTextField="sName" DataValueField="sCode" SelectedValue='<%# Bind("lnCategoryM_sCode") %>'>
                                                                                <asp:ListItem Value="0">無</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'
                                                                                ValidationGroup="fv"></asp:TextBox>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtDateB" runat="server" CssClass="txtDate" Text='<%# Bind("dDateA", "{0:d}") %>'
                                                                                Width="70px" ValidationGroup="fv"></asp:TextBox>到<asp:TextBox ID="txtDateE" runat="server"
                                                                                    CssClass="txtDate" Text='<%# Bind("dDateD", "{0:d}") %>' Width="70px" ValidationGroup="fv"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" nowrap="nowrap">
                                                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fv" />
                                                                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                Text="取消" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvName" runat="server" ControlToValidate="txtName"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                                                                    ID="rfvDateB" runat="server" ControlToValidate="txtDateB" Display="None" ErrorMessage="不允許空白"
                                                                                    SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RangeValidator
                                                                                        ID="rvDateB" runat="server" ControlToValidate="txtDateB" Display="None" ErrorMessage="格式不正確"
                                                                                        MaximumValue="9999/12/31" MinimumValue="1900/1/1" SetFocusOnError="True" Type="Date"
                                                                                        ValidationGroup="fv"></asp:RangeValidator><asp:RequiredFieldValidator ID="rfvDateE"
                                                                                            runat="server" ControlToValidate="txtDateE" Display="None" ErrorMessage="不允許空白"
                                                                                            SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RangeValidator
                                                                                                ID="rvDateE" runat="server" ControlToValidate="txtDateE" Display="None" ErrorMessage="格式不正確"
                                                                                                MaximumValue="9999/12/31" MinimumValue="1900/1/1" SetFocusOnError="True" Type="Date"
                                                                                                ValidationGroup="fv"></asp:RangeValidator><asp:Label ID="iAutoKeyLabel1" runat="server"
                                                                                                    Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label><asp:Label ID="Label1"
                                                                                                        runat="server" Text='<%# Bind("iEdition") %>' Visible="False"></asp:Label><asp:Label
                                                                                                            ID="Label2" runat="server" Text='<%# Bind("sysRole_iKey") %>' Visible="False"></asp:Label><asp:Label
                                                                                                                ID="Label3" runat="server" 
                                                                                Text='<%# Bind("iView") %>' Visible="False"></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="5" nowrap="nowrap" style="text-align: left">
                                                                            <asp:SqlDataSource ID="sdsCate" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [sCode], [sName] FROM [lnCategorym] ORDER BY [iOrder]">
                                                                            </asp:SqlDataSource>
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
                                                                            <asp:MaskedEditExtender ID="meeDateB" runat="server" AcceptNegative="Left" AutoComplete="true"
                                                                                AutoCompleteValue="1900/01/01" DisplayMoney="Left" Mask="9999/99/99" MaskType="Date"
                                                                                MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                                                TargetControlID="txtDateB">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeDateE" runat="server" AcceptNegative="Left" AutoComplete="true"
                                                                                AutoCompleteValue="9999/12/31" DisplayMoney="Left" Mask="9999/99/99" MaskType="Date"
                                                                                MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                                                TargetControlID="txtDateE">
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
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <table class="TableFullBorder">
                                                                    <tr>
                                                                        <th nowrap="nowrap">
                                                                            題目代碼
                                                                        </th>
                                                                        <th nowrap="nowrap">
                                                                            題目名稱
                                                                        </th>
                                                                        <th nowrap="nowrap">
                                                                            所屬中類別
                                                                        </th>
                                                                        <th nowrap="nowrap">
                                                                            順位
                                                                        </th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtCode" runat="server" CssClass="txtCode" Text='<%# Bind("sCode") %>'
                                                                                ValidationGroup="fv"></asp:TextBox>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtName" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox>
                                                                        </td>
                                                                        <td nowrap="nowrap" style="width: 81px">
                                                                            <asp:DropDownList ID="DropDownList1" runat="server" AppendDataBoundItems="True" DataSourceID="sdsCate"
                                                                                DataTextField="sName" DataValueField="sCode" SelectedValue='<%# Bind("lnCategoryM_sCode") %>'
                                                                                ValidationGroup="fv">
                                                                                <asp:ListItem Value="0">無</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                        </td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'
                                                                                ValidationGroup="fv"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap">
                                                                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fv" />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                                                                    ID="rfvName" runat="server" ControlToValidate="txtName" Display="None" ErrorMessage="不允許空白"
                                                                                    SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:SqlDataSource ID="sdsCate" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT sCode, sName FROM lnCategoryM ORDER BY iOrder"></asp:SqlDataSource>
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
                                                            InsertCommand="INSERT INTO [lnCategoryS] ([sysRole_iKey], [lnCategoryM_sCode], [sCode], [sName], [sContent], [iOrder], [iEdition], [iView], [dDateA], [dDateD], [sKeyMan], [dKeyDate], [sDept], [sJob]) VALUES (@sysRole_iKey, @lnCategoryM_sCode, @sCode, @sName, @sContent, @iOrder, @iEdition, @iView, @dDateA, @dDateD, @sKeyMan, @dKeyDate, @sDept, @sJob)"
                                                            SelectCommand="SELECT * FROM [lnCategoryS]
 WHERE ([iAutoKey] = @iAutoKey)" 
                                                            
                                                            UpdateCommand="UPDATE lnCategoryS SET sysRole_iKey = @sysRole_iKey, lnCategoryM_sCode = @lnCategoryM_sCode, sCode = @sCode, sName = @sName, iOrder = @iOrder, iEdition = @iEdition, iView = @iView, dDateA = @dDateA, dDateD = @dDateD, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate, sDept = @sDept, sJob = @sJob WHERE (iAutoKey = @iAutoKey)">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv" Name="iAutoKey" 
                                                                    PropertyName="SelectedValue" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                                                <asp:Parameter Name="lnCategoryM_sCode" Type="String" />
                                                                <asp:Parameter Name="sCode" Type="String" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="iOrder" Type="Int32" />
                                                                <asp:Parameter Name="iEdition" Type="Int32" />
                                                                <asp:Parameter Name="iView" Type="Int32" />
                                                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="sDept" Type="String" />
                                                                <asp:Parameter Name="sJob" Type="String" />
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </UpdateParameters>
                                                            <InsertParameters>
                                                                <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                                                <asp:Parameter Name="lnCategoryM_sCode" Type="String" />
                                                                <asp:Parameter Name="sCode" Type="String" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="sContent" Type="String" />
                                                                <asp:Parameter Name="iOrder" Type="Int32" />
                                                                <asp:Parameter Name="iEdition" Type="Int32" />
                                                                <asp:Parameter Name="iView" Type="Int32" />
                                                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="sDept" Type="String" />
                                                                <asp:Parameter Name="sJob" Type="String" />
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
                                            CommandName="lnAuth" Text="權限" />
                                        <asp:Button ID="Button4" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                            CommandName="lnCategorySEdit" Text="內容" />
                                        <asp:Button ID="btnTest" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                            CommandName="Test" Text="考卷" />&nbsp;<asp:Button ID="Button3" runat="server" CausesValidation="False"
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
                                <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                <asp:BoundField DataField="lnCategoryMName" HeaderText="中分類名稱" SortExpression="lnCategoryMName" />
                                <asp:BoundField DataField="sCode" HeaderText="題目代碼" SortExpression="sCode" />
                                <asp:BoundField DataField="sName" HeaderText="題目名稱" SortExpression="sName" />
                                <asp:BoundField DataField="iOrder" HeaderText="順位" SortExpression="iOrder" />
                                <asp:BoundField DataField="sysRole_iKey" HeaderText="權限代碼" SortExpression="sysRole_iKey" />
                                <asp:BoundField DataField="iEdition" HeaderText="修改次數" SortExpression="iEdition" />
                                <asp:BoundField DataField="iView" HeaderText="瀏覽人次" SortExpression="iView" />
                                <asp:BoundField DataField="iFileCount" HeaderText="檔案數" SortExpression="iFileCount" />
                                <asp:BoundField DataField="iTestCount" HeaderText="考卷數" SortExpression="iTestCount" />
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                                <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                    Text="新增" />
                            </EmptyDataTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="True" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [lnCategoryS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT lnCategoryS.iAutoKey, lnCategoryS.sysRole_iKey, lnCategoryS.lnCategoryM_sCode, lnCategoryS.sCode, lnCategoryS.sName, lnCategoryS.sContent, lnCategoryS.iOrder, lnCategoryS.iEdition, lnCategoryS.iView, ISNULL(lnCategoryM.sName, N'') AS lnCategoryMName, lnCategoryS.dDateA, lnCategoryS.dDateD, lnCategoryS.sKeyMan, lnCategoryS.dKeyDate, ISNULL((SELECT COUNT(*) AS c FROM lnUpFile WHERE (lnCategoryS_sCode = lnCategoryS.sCode)), 0) AS iFileCount, ISNULL((SELECT COUNT(*) AS c FROM lnTest WHERE (lnCategoryS_sCode = lnCategoryS.sCode)), 0) AS iTestCount FROM lnCategoryS LEFT OUTER JOIN lnCategoryM ON lnCategoryS.lnCategoryM_sCode = lnCategoryM.sCode">
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
                                                            <asp:Label ID="lblDragNameRole" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitRole" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitRole_Click" />
                                                        </td>
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
                                                    <td style="text-align: center">
                                                        <asp:Button ID="btnSaveRole" runat="server" CausesValidation="False" OnClick="btnSaveRole_Click"
                                                            OnClientClick="return confirm('您確定要儲存嗎？');" Text="儲存" />
                                                    </td>
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
                        <asp:Panel ID="plPopupAuth" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="320px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragAuth" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameAuth" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitAuth" runat="server" CssClass="ButtonExit" Text="×" 
                                                                onclick="btnExitAuth_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblAuthID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <table style="width: 100%">
                                                            <tr>
                                                                <td nowrap="true" width="1%">
                                                                    部門</td>
                                                                <td>
                                                                    <asp:TextBox ID="txtDept" runat="server" Height="200px" TextMode="MultiLine" 
                                                                        Width="100%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="true" width="1%">
                                                                    職稱</td>
                                                                <td>
                                                                    <asp:TextBox ID="txtJob" runat="server" Height="200px" TextMode="MultiLine" 
                                                                        Width="100%"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td nowrap="true" width="1%">
                                                                    &nbsp;</td>
                                                                <td>
                                                                    <asp:Button ID="btnAuthSave" runat="server" onclick="btnAuthSave_Click" 
                                                                        Text="儲存" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblMsgAuth" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupAuth" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupAuth" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior8" DropShadow="true" PopupControlID="plPopupAuth"
                            PopupDragHandleControlID="plDragAuth" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupAuth">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupEdit" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="600px">
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
                                                            <asp:Label ID="lblDragNameEdit" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitEdit" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitEdit_Click" />
                                                        </td>
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
                                            <table cellpadding="0" cellspacing="0" width="100%" class="TableFullBorder">
                                                <tr>
                                                    <th>
                                                        瀏覽者
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnViewExport" runat="server" OnClick="btnViewExport_Click" Text="匯出" />
                                                        <br />
                                                        <asp:GridView ID="gvView" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                                            DataKeyNames="iAutoKey" DataSourceID="sdsView" OnRowDataBound="gv_RowDataBound"
                                                            Width="100%" PageSize="5" OnRowCommand="gvView_RowCommand">
                                                            <RowStyle HorizontalAlign="Center" Wrap="True" />
                                                            <Columns>
                                                                <asp:BoundField DataField="sUserID" HeaderText="登入帳號" SortExpression="sUserID" />
                                                                <asp:BoundField DataField="dDateTimeB" HeaderText="登入開始時間" SortExpression="dDateTimeB" />
                                                                <asp:BoundField DataField="dDateTimeE" HeaderText="登入結束時間" SortExpression="dDateTimeE" />
                                                                <asp:BoundField DataField="iTime" HeaderText="總登入時間" SortExpression="iTime" />
                                                            </Columns>
                                                            <EmptyDataTemplate>
                                                                目前沒有資料。
                                                            </EmptyDataTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsView" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            SelectCommand="SELECT lnView.iAutoKey, lnView.sUserID, lnView.lnCategoryS_sCode, lnView.dDateTimeB, lnView.dDateTimeE, lnView.iTime, lnCategoryS.sName FROM lnView INNER JOIN lnCategoryS ON lnView.lnCategoryS_sCode = lnCategoryS.sCode WHERE (lnView.lnCategoryS_sCode = @sCode) ORDER BY lnView.dDateTimeB DESC">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblEditID" Name="sCode" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center">
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>
                                                        課程內容
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <FCKeditorV2:FCKeditor ID="fckContent" runat="server" BasePath="./FCKeditor/" Height="200px"
                                                            ToolbarSet="Ming">
                                                        </FCKeditorV2:FCKeditor>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnSaveEdit" runat="server" CausesValidation="False" OnClientClick="return confirm('您確定要儲存嗎？');"
                                                            Text="儲存" OnClick="btnSaveEdit_Click" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left">
                                                        <asp:Button ID="btnLinkTest" runat="server" CausesValidation="False" CommandName="Test"
                                                            OnClick="btnLink_Click" Text="加入相關考題" Visible="False" />
                                                        <asp:Button ID="btnLinkFile" runat="server" CausesValidation="False" CommandName="File"
                                                            OnClick="btnLink_Click" Text="加入檔案或影片" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupEdit" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupEdit" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior3" DropShadow="true" PopupControlID="plPopupEdit"
                            PopupDragHandleControlID="plDragEdit" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupEdit">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupTest" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="400px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragTest" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameTest" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitTest" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitRole_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblTestID" runat="server" Visible="False"></asp:Label></asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <uc1:ucAuth ID="ucTest" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: center">
                                                        <asp:Button ID="btnSaveTest" runat="server" CausesValidation="False" OnClientClick="return confirm('您確定要儲存嗎？');"
                                                            Text="儲存" OnClick="btnSaveTest_Click" />
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupTest" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupTest" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior4" DropShadow="true" PopupControlID="plPopupTest"
                            PopupDragHandleControlID="plDragTest" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupTest">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupFile" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="600px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragFile" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameFile" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitFile" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExit_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblFileID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvUpload" runat="server" AllowPaging="True" AllowSorting="True"
                                                            AutoGenerateColumns="False" DataKeyNames="iAutoKey" DataSourceID="sdsUpload"
                                                            OnRowCommand="gvUpload_RowCommand" OnRowDataBound="gv_RowDataBound" PageSize="5"
                                                            Width="100%">
                                                            <RowStyle HorizontalAlign="Center" />
                                                            <Columns>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <EditItemTemplate>
                                                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="Update" Text="更新" />
                                                                        <asp:Button ID="Button6" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="Cancel" Text="取消" />
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="Edit" Text="編輯" />
                                                                        <asp:Button ID="btnDownload" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="Download" Text="下載" />
                                                                        <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="Del" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" />
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="1%" Wrap="False" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="檔案類型" SortExpression="sCat">
                                                                    <EditItemTemplate>
                                                                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("sCat") %>'>
                                                                            <asp:ListItem Value="1">下載</asp:ListItem>
                                                                            <asp:ListItem Value="2">播放</asp:ListItem>
                                                                        </asp:DropDownList>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCat" runat="server" Text='<%# Bind("sCat") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="sUpName" HeaderText="檔名" ReadOnly="True" SortExpression="sUpName" />
                                                                <asp:BoundField DataField="sType" HeaderText="檔案類別" ReadOnly="True" SortExpression="sType" />
                                                                <asp:BoundField DataField="iSize" HeaderText="檔案大小(KB)" ReadOnly="True" SortExpression="iSize" />
                                                                <asp:BoundField DataField="sContent" HeaderText="說明" ReadOnly="True" SortExpression="sContent" />
                                                                <asp:BoundField DataField="sKeyMan" HeaderText="登錄者" ReadOnly="True" SortExpression="sKeyMan"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="dKeyDate" DataFormatString="{0:d}" HeaderText="登錄日期" HtmlEncode="False"
                                                                    ReadOnly="True" SortExpression="dKeyDate" Visible="False" />
                                                            </Columns>
                                                            <EmptyDataTemplate>
                                                                目前沒有任何附件上傳。
                                                            </EmptyDataTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsUpload" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            DeleteCommand="DELETE FROM [lnUpFile] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [lnUpFile] WHERE ([lnCategoryS_sCode] = @lnCategoryS_sCode)"
                                                            UpdateCommand="UPDATE lnUpFile SET sCat = @sCat WHERE (iAutoKey = @iAutoKey)">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblEditID" Name="lnCategoryS_sCode" PropertyName="Text" />
                                                            </SelectParameters>
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </DeleteParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="sCat" Type="String" />
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </UpdateParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table class="TableFullBorder">
                                                            <tr>
                                                                <th nowrap="nowrap" width="1%">
                                                                    選擇檔案
                                                                </th>
                                                                <td nowrap="nowrap">
                                                                    <asp:FileUpload ID="fu" runat="server" Width="100%" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th nowrap="nowrap" width="1%">
                                                                    檔案簡介
                                                                </th>
                                                                <td nowrap="nowrap">
                                                                    <asp:TextBox ID="txtDescription" runat="server" CssClass="txtDescription"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" nowrap="nowrap">

                                                                    <script type="text/javascript">                                                                        function showUploadProgress() { document.getElementById("UploadProgress").style.display = ""; frames["UploadProgressFrame"].location = "UploadProgress.ashx"; }</script>

                                                                    <asp:Button ID="btnSaveFile" runat="server" CausesValidation="False" Text="上傳" OnClick="btnSaveFile_Click"
                                                                        OnClientClick="setTimeout('showUploadProgress()', 1000);" />&nbsp;
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" nowrap="nowrap">
                                                                    <asp:Label ID="lblMsgFile" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupFile" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupFile" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior5" DropShadow="true" PopupControlID="plPopupFile"
                            PopupDragHandleControlID="plDragFile" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupFile">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSaveFile" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
