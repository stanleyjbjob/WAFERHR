<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="sysFileStructure.aspx.cs" Inherits="sysFileStructure" Title="" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Src="ucAuth.ascx" TagName="ucAuth" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:ScriptManagerProxy ID="smp" runat="server">
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
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td>
                                                    <asp:FormView ID="fv" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsFV"
                                                        DefaultMode="Insert" OnItemInserting="fv_ItemInserting" OnItemInserted="fv_ItemInserted"
                                                        OnItemUpdated="fv_ItemUpdated" OnItemUpdating="fv_ItemUpdating" Width="100%">
                                                        <EditItemTemplate>
                                                            <table class="TableFullBorder" width="100%">
                                                                <tr>
                                                                    <th>
                                                                        代碼</th>
                                                                    <th>
                                                                        抬頭</th>
                                                                    <th>
                                                                        上層名稱</th>
                                                                    <th>
                                                                        順位</th>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("sKey") %>'></asp:Label></td>
                                                                    <td>
                                                                        <asp:TextBox ID="sFileTitleTextBox" runat="server" CssClass="txtName" Text='<%# Bind("sFileTitle") %>'
                                                                            ValidationGroup="fv"></asp:TextBox></td>
                                                                    <td>
                                                                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsFileStructure"
                                                                            DataTextField="sFileTitle" DataValueField="sKey" AppendDataBoundItems="True"
                                                                            SelectedValue='<%# Bind("sParentKey") %>'>
                                                                            <asp:ListItem Value="0">獨立檔案</asp:ListItem>
                                                                            <asp:ListItem Value="RootStart">最根層</asp:ListItem>
                                                                        </asp:DropDownList></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <th colspan="2">
                                                                        路徑</th>
                                                                    <th colspan="2">
                                                                        檔名</th>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:TextBox ID="sPathTextBox" runat="server" CssClass="txtPath" Text='<%# Bind("sPath") %>'></asp:TextBox></td>
                                                                    <td colspan="2">
                                                                        <asp:TextBox ID="sFileNameTextBox" runat="server" CssClass="txtPath" Text='<%# Bind("sFileName") %>'></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <th colspan="4">
                                                                        生失效日</th>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <asp:TextBox ID="txtDateB" runat="server" CssClass="txtDate" Text='<%# Bind("dDateA", "{0:d}") %>'
                                                                            ValidationGroup="fv"></asp:TextBox>
                                                                        到<asp:TextBox ID="txtDateE" runat="server" CssClass="txtDate" Text='<%# Bind("dDateD", "{0:d}") %>'
                                                                            ValidationGroup="fv"></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <th colspan="4">
                                                                        說明</th>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <asp:TextBox ID="sDescriptionTextBox" runat="server" CssClass="txtDescription" Text='<%# Bind("sDescription") %>'></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" align="left">
                                                                        <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fv" />
                                                                        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                            Text="取消" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="text-align: left">
                                                                        <asp:RequiredFieldValidator ID="rfvDateB" runat="server" ControlToValidate="txtDateB"
                                                                            Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RangeValidator
                                                                                ID="rvDateB" runat="server" ControlToValidate="txtDateB" Display="None" ErrorMessage="格式不正確"
                                                                                MaximumValue="9999/12/31" MinimumValue="1900/1/1" SetFocusOnError="True" Type="Date"
                                                                                ValidationGroup="fv"></asp:RangeValidator><asp:RequiredFieldValidator ID="rfvDateE"
                                                                                    runat="server" ControlToValidate="txtDateE" Display="None" ErrorMessage="不允許空白"
                                                                                    SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RangeValidator
                                                                                        ID="rvDateE" runat="server" ControlToValidate="txtDateE" Display="None" ErrorMessage="格式不正確"
                                                                                        MaximumValue="9999/12/31" MinimumValue="1900/1/1" SetFocusOnError="True" Type="Date"
                                                                                        ValidationGroup="fv"></asp:RangeValidator></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="text-align: left">
                                                                        <asp:SqlDataSource ID="sdsFileStructure" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                            SelectCommand="SELECT sKey, sFileTitle + '(' + sKey + ')' AS sFileTitle FROM sysFileStructure ORDER BY iOrder">
                                                                        </asp:SqlDataSource>
                                                                        <asp:MaskedEditExtender AutoComplete="false" ErrorTooltipEnabled="True" ID="meeOrder"
                                                                            InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                            OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" runat="server"
                                                                            TargetControlID="txtOrder">
                                                                        </asp:MaskedEditExtender>
                                                                        <asp:MaskedEditExtender ID="meeDateB" runat="server" AcceptNegative="Left" DisplayMoney="Left"
                                                                            Mask="9999/99/99" MaskType="Date" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                            OnInvalidCssClass="MaskedEditError" TargetControlID="txtDateB" AutoComplete="true"
                                                                            AutoCompleteValue="1900/01/01">
                                                                        </asp:MaskedEditExtender>
                                                                        <asp:MaskedEditExtender ID="meeDateE" runat="server" AcceptNegative="Left" DisplayMoney="Left"
                                                                            Mask="9999/99/99" MaskType="Date" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                            OnInvalidCssClass="MaskedEditError" TargetControlID="txtDateE" AutoComplete="true"
                                                                            AutoCompleteValue="9999/12/31">
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
                                                                        <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Bind("iAutoKey") %>' Visible="False"></asp:Label></td>
                                                                </tr>
                                                            </table>
                                                        </EditItemTemplate>
                                                        <InsertItemTemplate>
                                                            <table class="TableFullBorder" width="100%">
                                                                <tr>
                                                                    <th>
                                                                        代碼</th>
                                                                    <th>
                                                                        抬頭</th>
                                                                    <th>
                                                                        上層名稱</th>
                                                                    <th>
                                                                        順位</th>
                                                                </tr>
                                                                <tr>
                                                                    <td>
                                                                        <asp:TextBox ID="txtKey" runat="server" CssClass="txtCode" Text='<%# Bind("sKey") %>'
                                                                            ValidationGroup="fv"></asp:TextBox></td>
                                                                    <td>
                                                                        <asp:TextBox ID="sFileTitleTextBox" runat="server" CssClass="txtName" Text='<%# Bind("sFileTitle") %>'></asp:TextBox></td>
                                                                    <td>
                                                                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsFileStructure"
                                                                            DataTextField="sFileTitle" DataValueField="sKey" AppendDataBoundItems="True"
                                                                            SelectedValue='<%# Bind("sParentKey") %>'>
                                                                            <asp:ListItem Value="0">獨立檔案</asp:ListItem>
                                                                            <asp:ListItem Value="RootStart">最根層</asp:ListItem>
                                                                        </asp:DropDownList></td>
                                                                    <td>
                                                                        <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <th colspan="2">
                                                                        路徑</th>
                                                                    <th colspan="2">
                                                                        檔名</th>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:TextBox ID="sPathTextBox" runat="server" CssClass="txtPath" Text='<%# Bind("sPath") %>'></asp:TextBox></td>
                                                                    <td colspan="2">
                                                                        <asp:TextBox ID="sFileNameTextBox" runat="server" CssClass="txtPath" Text='<%# Bind("sFileName") %>'></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <th colspan="4">
                                                                        說明</th>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4">
                                                                        <asp:TextBox ID="sDescriptionTextBox" runat="server" CssClass="txtDescription" Text='<%# Bind("sDescription") %>'></asp:TextBox></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" align="left">
                                                                        <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fv" />
                                                                        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                            Text="取消" /></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="text-align: left">
                                                                        <asp:RequiredFieldValidator ID="rfvKey" runat="server" ControlToValidate="txtKey"
                                                                            Display="None" ErrorMessage="代碼不允許空白" ValidationGroup="fv" SetFocusOnError="True"></asp:RequiredFieldValidator></td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="4" style="text-align: left">
                                                                        <asp:SqlDataSource ID="sdsFileStructure" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                            SelectCommand="SELECT sKey, sFileTitle + '(' + sKey + ')' AS sFileTitle FROM sysFileStructure ORDER BY iOrder">
                                                                        </asp:SqlDataSource>
                                                                        <asp:MaskedEditExtender ErrorTooltipEnabled="True" ID="meeKey" Mask="?{50}" MaskType="none"
                                                                            MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                                            PromptCharacter=" " runat="server" TargetControlID="txtKey">
                                                                        </asp:MaskedEditExtender>
                                                                        <asp:MaskedEditExtender AutoComplete="false" ErrorTooltipEnabled="True" ID="meeOrder"
                                                                            InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                            OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" runat="server"
                                                                            TargetControlID="txtOrder">
                                                                        </asp:MaskedEditExtender>
                                                                        <asp:ValidatorCalloutExtender ID="vceKey" runat="Server" HighlightCssClass="validatorCalloutHighlight"
                                                                            TargetControlID="rfvKey">
                                                                        </asp:ValidatorCalloutExtender>
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </InsertItemTemplate>
                                                    </asp:FormView>
                                                    <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                        InsertCommand="INSERT INTO sysFileStructure(sKey, sCat, sPath, sFileName, sFileTitle, sDescription, sysRole_iKey, sParentKey, iOrder, dDateA, dDateD, sKeyMan, dKeyDate) VALUES (@sKey, @sCat, @sPath, @sFileName, @sFileTitle, @sDescription, @sysRole_iKey, @sParentKey, @iOrder, @dDateA, @dDateD, @sKeyMan, @dKeyDate)"
                                                        SelectCommand="SELECT * FROM [sysFileStructure] WHERE ([iAutoKey] = @iAutoKey)"
                                                        UpdateCommand="UPDATE sysFileStructure SET sKey = @sKey, sCat = @sCat, sPath = @sPath, sFileName = @sFileName, sFileTitle = @sFileTitle, sDescription = @sDescription, sParentKey = @sParentKey, iOrder = @iOrder, dDateA = @dDateA, dDateD = @dDateD, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate WHERE (iAutoKey = @iAutoKey)">
                                                        <SelectParameters>
                                                            <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                                                Type="Int32" />
                                                        </SelectParameters>
                                                        <UpdateParameters>
                                                            <asp:Parameter Name="sKey" Type="String" />
                                                            <asp:Parameter Name="sCat" Type="String" />
                                                            <asp:Parameter Name="sPath" Type="String" />
                                                            <asp:Parameter Name="sFileName" Type="String" />
                                                            <asp:Parameter Name="sFileTitle" Type="String" />
                                                            <asp:Parameter Name="sDescription" Type="String" />
                                                            <asp:Parameter Name="sParentKey" Type="String" />
                                                            <asp:Parameter Name="iOrder" Type="Int32" />
                                                            <asp:Parameter Name="dDateA" Type="DateTime" />
                                                            <asp:Parameter Name="dDateD" Type="DateTime" />
                                                            <asp:Parameter Name="sKeyMan" Type="String" />
                                                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                        </UpdateParameters>
                                                        <InsertParameters>
                                                            <asp:Parameter Name="sKey" Type="String" />
                                                            <asp:Parameter Name="sCat" Type="String" />
                                                            <asp:Parameter Name="sPath" Type="String" />
                                                            <asp:Parameter Name="sFileName" Type="String" />
                                                            <asp:Parameter Name="sFileTitle" Type="String" />
                                                            <asp:Parameter Name="sDescription" Type="String" />
                                                            <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                                            <asp:Parameter Name="sParentKey" Type="String" />
                                                            <asp:Parameter Name="iOrder" Type="Int32" />
                                                            <asp:Parameter Name="dDateA" Type="DateTime" />
                                                            <asp:Parameter Name="dDateD" Type="DateTime" />
                                                            <asp:Parameter Name="sKeyMan" Type="String" />
                                                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                        </InsertParameters>
                                                    </asp:SqlDataSource>
                                                </td>
                                            </tr>
                                        </table>
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
                            DataKeyNames="iAutoKey" DataSourceID="sdsGV" Width="100%" AllowPaging="True"
                            OnPageIndexChanged="gv_PageIndexChanged" OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound"
                            OnSelectedIndexChanged="gv_SelectedIndexChanged">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="選取" />
                                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sKey") %>'
                                            CommandName="sysFileStructureEdit" Text="角色權限" />
                                        <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandName="Delete"
                                            OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" Enabled="False" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                    <HeaderTemplate>
                                        <asp:Button ID="btnAdd" runat="server" CommandName="Add" Text="新增" CausesValidation="False" />
                                        <asp:Button ID="btnExport" runat="server" CommandName="Export" Text="匯出" CausesValidation="False" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="sKey" HeaderText="代碼" SortExpression="sKey">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sPath" HeaderText="路徑" SortExpression="sPath" />
                                <asp:BoundField DataField="sFileName" HeaderText="檔名" SortExpression="sFileName">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sFileTitle" HeaderText="抬頭" SortExpression="sFileTitle">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sysRole_iKey" HeaderText="權限代碼" SortExpression="sysRole_iKey">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sParentKey" HeaderText="上層名稱" SortExpression="sParentKey" />
                                <asp:BoundField DataField="iOrder" HeaderText="順位" SortExpression="iOrder" />
                            </Columns>
                            <RowStyle HorizontalAlign="Center" Wrap="True" />
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                            <EmptyDataTemplate>
                                目前沒有資料。
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [sysFileStructure] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [sysFileStructure]"
                            InsertCommand="INSERT INTO [sysFileStructure] ([sKey], [sCat], [sPath], [sFileName], [sFileTitle], [sDescription], [sysRole_iKey], [sParentKey], [iOrder], [dDateA], [dDateD], [sKeyMan], [dKeyDate]) VALUES (@sKey, @sCat, @sPath, @sFileName, @sFileTitle, @sDescription, @sysRole_iKey, @sParentKey, @iOrder, @dDateA, @dDateD, @sKeyMan, @dKeyDate)"
                            UpdateCommand="UPDATE [sysFileStructure] SET [sKey] = @sKey, [sCat] = @sCat, [sPath] = @sPath, [sFileName] = @sFileName, [sFileTitle] = @sFileTitle, [sDescription] = @sDescription, [sysRole_iKey] = @sysRole_iKey, [sParentKey] = @sParentKey, [iOrder] = @iOrder, [dDateA] = @dDateA, [dDateD] = @dDateD, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="sKey" Type="String" />
                                <asp:Parameter Name="sCat" Type="String" />
                                <asp:Parameter Name="sPath" Type="String" />
                                <asp:Parameter Name="sFileName" Type="String" />
                                <asp:Parameter Name="sFileTitle" Type="String" />
                                <asp:Parameter Name="sDescription" Type="String" />
                                <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                <asp:Parameter Name="sParentKey" Type="String" />
                                <asp:Parameter Name="iOrder" Type="Int32" />
                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                <asp:Parameter Name="sKeyMan" Type="String" />
                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="sKey" Type="String" />
                                <asp:Parameter Name="sCat" Type="String" />
                                <asp:Parameter Name="sPath" Type="String" />
                                <asp:Parameter Name="sFileName" Type="String" />
                                <asp:Parameter Name="sFileTitle" Type="String" />
                                <asp:Parameter Name="sDescription" Type="String" />
                                <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                <asp:Parameter Name="sParentKey" Type="String" />
                                <asp:Parameter Name="iOrder" Type="Int32" />
                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                <asp:Parameter Name="sKeyMan" Type="String" />
                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                            </InsertParameters>
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
                                                            <asp:Button ID="btnExitRole" runat="server" CssClass="ButtonExit" OnClick="btnExitRole_Click"
                                                                Text="×" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblRoleID" runat="server" Visible="False"></asp:Label></asp:Panel>
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
                                                            OnClientClick="return confirm('您確定要儲存嗎？');" Text="儲存" /></td>
                                                </tr>
                                            </table>
                                        </div>
                                        </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupRole" runat="server" Style="display: none" />
                        <asp:ModalPopupExtender ID="mpePopupRole" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupRole"
                            PopupDragHandleControlID="plDragRole" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupRole">
                        </asp:ModalPopupExtender>
                        &nbsp;
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
