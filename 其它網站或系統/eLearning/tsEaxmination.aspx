<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="tsEaxmination.aspx.cs" Inherits="tsEaxmination" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <asp:Panel ID="plPopupFV" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="800px">
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
                                                                        <th nowrap="nowrap" width="1%">
                                                                            題目種類</th>
                                                                        <th nowrap="nowrap">
                                                                            題目內容</th>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            答案(是非題用)</th>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            題目分類</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsCategory" DataTextField="sName"
                                                                                DataValueField="sCode" SelectedValue='<%# Bind("tsCategory_sCode") %>'>
                                                                            </asp:DropDownList></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtContent" runat="server" Text='<%# Bind("sContent") %>' TextMode="MultiLine"
                                                                                Width="99%" ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                                                                RepeatLayout="Flow" SelectedValue='<%# Bind("iAnswer") %>'>
                                                                                <asp:ListItem Value="1">對</asp:ListItem>
                                                                                <asp:ListItem Value="0">錯</asp:ListItem>
                                                                            </asp:RadioButtonList></td>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="sdsCategoryS" DataTextField="sName"
                                                                                DataValueField="sCode" SelectedValue='<%# Bind("lnCategoryS_sCode") %>'>
                                                                            </asp:DropDownList></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap">
                                                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fv" />
                                                                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                Text="取消" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label><asp:RequiredFieldValidator
                                                                                ID="rfvContent" runat="server" ControlToValidate="txtContent" Display="None"
                                                                                ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [sCode], [sName] FROM [tsCategory]"></asp:SqlDataSource>
                                                                            <asp:SqlDataSource ID="sdsCategoryS" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [sCode], [sName] FROM [lnCategoryS]"></asp:SqlDataSource>
                                                                            <asp:ValidatorCalloutExtender ID="vceContent" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvContent">
                                                                            </asp:ValidatorCalloutExtender>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <table class="TableFullBorder">
                                                                    <tr>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            題目種類</th>
                                                                        <th nowrap="nowrap">
                                                                            題目內容</th>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            答案(是非題用)</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap">
                                                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsCategory" DataTextField="sName"
                                                                                DataValueField="sCode" SelectedValue='<%# Bind("tsCategory_sCode") %>'>
                                                                            </asp:DropDownList></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtContent" runat="server" Text='<%# Bind("sContent") %>' TextMode="MultiLine"
                                                                                Width="99%" ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                                                                RepeatLayout="Flow" SelectedValue='<%# Bind("iAnswer") %>'>
                                                                                <asp:ListItem Selected="True" Value="1">對</asp:ListItem>
                                                                                <asp:ListItem Value="0">錯</asp:ListItem>
                                                                            </asp:RadioButtonList></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" nowrap="nowrap">
                                                                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fv" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvContent" runat="server" ControlToValidate="txtContent"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="3" nowrap="nowrap" style="text-align: left">
                                                                            <asp:ValidatorCalloutExtender ID="vceContent" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvContent">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:SqlDataSource ID="sdsCategoryS" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [sCode], [sName] FROM [lnCategoryS]"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </InsertItemTemplate>
                                                        </asp:FormView>
                                                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            InsertCommand="INSERT INTO [tsEaxmination] ([lnCategoryS_sCode], [tsCategory_sCode], [sContent], [iAnswer], [sKeyMan], [dKeyDate]) VALUES (@lnCategoryS_sCode, @tsCategory_sCode, @sContent, @iAnswer, @sKeyMan, @dKeyDate)"
                                                            SelectCommand="SELECT * FROM [tsEaxmination] WHERE ([iAutoKey] = @iAutoKey)"
                                                            UpdateCommand="UPDATE [tsEaxmination] SET [lnCategoryS_sCode] = @lnCategoryS_sCode, [tsCategory_sCode] = @tsCategory_sCode, [sContent] = @sContent, [iAnswer] = @iAnswer, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="lnCategoryS_sCode" Type="String" />
                                                                <asp:Parameter Name="tsCategory_sCode" Type="String" />
                                                                <asp:Parameter Name="sContent" Type="String" />
                                                                <asp:Parameter Name="iAnswer" Type="Int32" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </UpdateParameters>
                                                            <InsertParameters>
                                                                <asp:Parameter Name="lnCategoryS_sCode" Type="String" />
                                                                <asp:Parameter Name="tsCategory_sCode" Type="String" />
                                                                <asp:Parameter Name="sContent" Type="String" />
                                                                <asp:Parameter Name="iAnswer" Type="Int32" />
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
                        <asp:DropDownList ID="ddlCategoryL" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                            DataSourceID="sdsCategoryL" DataTextField="sName" DataValueField="sCode" OnSelectedIndexChanged="ddlCategoryL_SelectedIndexChanged">
                            <asp:ListItem Value="a">課程大分類(全部)</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlCategoryM" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                            DataSourceID="sdsCategoryM" DataTextField="sName" DataValueField="sCode" OnSelectedIndexChanged="ddlCategoryM_SelectedIndexChanged">
                            <asp:ListItem Value="a">課程中分類(全部)</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlCategoryS" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                            DataSourceID="sdsCategoryS" DataTextField="sName" DataValueField="sCode">
                            <asp:ListItem Value="a">課程小分類(全部)</asp:ListItem>
                        </asp:DropDownList>
                        <asp:DropDownList ID="ddlCategory" runat="server" DataSourceID="sdsCategory" DataTextField="sName"
                            DataValueField="sCode" AppendDataBoundItems="True" AutoPostBack="True">
                            <asp:ListItem Selected="True" Value="a">題目種類(全部)</asp:ListItem>
                        </asp:DropDownList><asp:SqlDataSource ID="sdsCategoryL" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT [sCode], [sName] FROM [lnCategoryL] ORDER BY [iOrder]"></asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsCategoryM" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT [sCode], [sName] FROM [lnCategoryM] WHERE ([lnCategoryL_sCode] = @lnCategoryL_sCode) ORDER BY [iOrder]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCategoryL" Name="lnCategoryL_sCode" PropertyName="SelectedValue"
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsCategoryS" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT [sCode], [sName] FROM [lnCategoryS] WHERE ([lnCategoryM_sCode] = @lnCategoryM_sCode) ORDER BY [iOrder]">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCategoryM" Name="lnCategoryM_sCode" PropertyName="SelectedValue"
                                    Type="String" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT [sCode], [sName] FROM [tsCategory]"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <table class="TableFullBorder" width="100%">
                            <tr>
                                <td width="100%">
                                    <asp:TextBox ID="txtSearch" runat="server" Width="98%"></asp:TextBox>&nbsp;</td>
                                <td width="1%">
                                    <asp:Button ID="btnSearch" runat="server" Text="搜尋" OnClick="btnSearch_Click" /></td>
                            </tr>
                        </table>
                        <asp:TextBoxWatermarkExtender ID="tbweSearch" runat="server" TargetControlID="txtSearch"
                            WatermarkCssClass="watermarked" WatermarkText="請輸入您所要搜尋的關鍵字">
                        </asp:TextBoxWatermarkExtender>
                        <asp:Label ID="lblSearch" runat="server" Text="a" Visible="False"></asp:Label></td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                            DataKeyNames="iAutoKey" DataSourceID="sdsGV" OnPageIndexChanged="gv_PageIndexChanged"
                            OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound" OnSelectedIndexChanged="gv_SelectedIndexChanged"
                            Width="100%" OnRowDeleted="gv_RowDeleted" ShowFooter="True">
                            <RowStyle HorizontalAlign="Center" Wrap="True" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                            CommandName="Select" Text="選取" />
                                        <asp:Button ID="btnChoose" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                            CommandName="tsChoose" Text="答案編輯" />&nbsp;<asp:Button ID="Button3" runat="server"
                                                CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>' CommandName="Delete"
                                                OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" />
                                        <asp:CheckBox ID="cbDelete" runat="server" ToolTip='<%# Eval("iAutoKey") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                    <HeaderTemplate>
                                        <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                            Text="新增" />&nbsp;<asp:Button ID="btnExport" runat="server" CausesValidation="False"
                                                CommandName="Export" Text="匯出" />
                                        <asp:Button ID="btnImport" runat="server" CausesValidation="False" CommandName="Import"
                                            Text="匯入" />
                                    </HeaderTemplate>
                                    <FooterTemplate>
                                        <asp:Button ID="btnDeleteSelect" runat="server" CommandName="DeleteSelect" OnClientClick="return confirm('您確定要刪除所選的項目？');"
                                            Text="刪除所勾選的" />
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="tsCategoryName" HeaderText="題目種類" SortExpression="tsCategoryName" />
                                <asp:BoundField DataField="sContent" HeaderText="內容" SortExpression="sContent" />
                                <asp:BoundField DataField="iAnswer" HeaderText="答案" SortExpression="iAnswer" />
                                <asp:BoundField DataField="lnCategorySName" HeaderText="課程名稱" SortExpression="lnCategorySName" />
                                <asp:BoundField DataField="iCount" HeaderText="答案數目" SortExpression="iCount" />
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                                <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                    Text="新增" />
                                <asp:Button ID="btnImport" runat="server" CausesValidation="False" CommandName="Import"
                                            Text="匯入" />
                            </EmptyDataTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                            <FooterStyle Wrap="False" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [tsEaxmination] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT tsEaxmination.iAutoKey, tsEaxmination.lnCategoryS_sCode, tsEaxmination.tsCategory_sCode, tsEaxmination.sContent, tsEaxmination.iAnswer, tsEaxmination.sKeyMan, tsEaxmination.dKeyDate, lnCategoryS.sName AS lnCategorySName, tsCategory.sName AS tsCategoryName, ISNULL((SELECT COUNT(*) AS c FROM tsChoose WHERE (tsEaxmination_iAutoKey = tsEaxmination.iAutoKey)), 0) AS iCount FROM tsEaxmination LEFT OUTER JOIN tsCategory ON tsEaxmination.tsCategory_sCode = tsCategory.sCode LEFT OUTER JOIN lnCategoryS ON tsEaxmination.lnCategoryS_sCode = lnCategoryS.sCode WHERE (tsEaxmination.lnCategoryS_sCode = @lnCategoryS_sCode) AND (tsEaxmination.tsCategory_sCode = @tsCategory_sCode) AND (tsEaxmination.sContent LIKE '%' + @sContent + '%') OR (tsEaxmination.lnCategoryS_sCode = @lnCategoryS_sCode) AND (tsEaxmination.sContent LIKE '%' + @sContent + '%') AND (@tsCategory_sCode = 'a') OR (tsEaxmination.tsCategory_sCode = @tsCategory_sCode) AND (tsEaxmination.sContent LIKE '%' + @sContent + '%') AND (@lnCategoryS_sCode = 'a') OR (tsEaxmination.sContent LIKE '%' + @sContent + '%') AND (@tsCategory_sCode = 'a') AND (@lnCategoryS_sCode = 'a') OR (tsEaxmination.lnCategoryS_sCode = @lnCategoryS_sCode) AND (tsEaxmination.tsCategory_sCode = @tsCategory_sCode) AND (@sContent = 'a') OR (tsEaxmination.lnCategoryS_sCode = @lnCategoryS_sCode) AND (@tsCategory_sCode = 'a') AND (@sContent = 'a') OR (tsEaxmination.tsCategory_sCode = @tsCategory_sCode) AND (@lnCategoryS_sCode = 'a') AND (@sContent = 'a') OR (@tsCategory_sCode = 'a') AND (@lnCategoryS_sCode = 'a') AND (@sContent = 'a')">
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCategoryS" Name="lnCategoryS_sCode" PropertyName="SelectedValue"
                                    DefaultValue="a" />
                                <asp:ControlParameter ControlID="ddlCategory" DefaultValue="a" Name="tsCategory_sCode"
                                    PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="lblSearch" DefaultValue="a" Name="sContent" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupChoose" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="700px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragChoose" runat="server" Style="border-right: gray 1px solid;
                                            border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                                            border-bottom: gray 1px solid; background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameChoose" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitChoose" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitChoose_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblChooseID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div style="overflow-x: hidden; overflow-y: auto; height: 500px; padding: 0 17px 0 0">
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:FormView ID="fvChoose" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsChooseFV"
                                                                        DefaultMode="Insert" OnItemInserted="fvChoose_ItemInserted" OnItemInserting="fvChoose_ItemInserting"
                                                                        OnItemUpdated="fvChoose_ItemUpdated" OnItemUpdating="fvChoose_ItemUpdating" Width="100%"
                                                                        OnItemCommand="fvChoose_ItemCommand">
                                                                        <EditItemTemplate>
                                                                            <table class="TableFullBorder">
                                                                                <tr>
                                                                                    <th nowrap="nowrap">
                                                                                        答案內容</th>
                                                                                    <th nowrap="nowrap">
                                                                                        順位</th>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtContent" runat="server" CssClass="txtDescription" Text='<%# Bind("sContent") %>'
                                                                                            ValidationGroup="fvChoose"></asp:TextBox></td>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'
                                                                                            ValidationGroup="fvChoose" Width="30px"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" nowrap="nowrap">
                                                                                        <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fvChoose" />
                                                                                        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                            Text="取消" /></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" nowrap="nowrap" style="text-align: left">
                                                                                        <asp:RequiredFieldValidator ID="rfvContent" runat="server" ControlToValidate="txtContent"
                                                                                            Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fvChoose"></asp:RequiredFieldValidator><asp:Label
                                                                                                ID="iAutoKeyLabel1" runat="server" Text='<%# Bind("iAutoKey") %>' Visible="False"></asp:Label></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" nowrap="nowrap" style="text-align: left">
                                                                                        <asp:ValidatorCalloutExtender ID="vceContent" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                            TargetControlID="rfvContent">
                                                                                        </asp:ValidatorCalloutExtender>
                                                                                        <asp:MaskedEditExtender ID="meeOrder" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                            InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                            OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtOrder">
                                                                                        </asp:MaskedEditExtender>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </EditItemTemplate>
                                                                        <InsertItemTemplate>
                                                                            <table class="TableFullBorder">
                                                                                <tr>
                                                                                    <th nowrap="nowrap">
                                                                                        答案內容</th>
                                                                                    <th nowrap="nowrap">
                                                                                        順位</th>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtContent" runat="server" CssClass="txtDescription" Text='<%# Bind("sContent") %>'
                                                                                            ValidationGroup="fvChoose"></asp:TextBox></td>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtOrder" runat="server" CssClass="txtOrder" Text='<%# Bind("iOrder") %>'
                                                                                            ValidationGroup="fvChoose" Width="30px"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" nowrap="nowrap">
                                                                                        <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fvChoose" /></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" nowrap="nowrap" style="text-align: left">
                                                                                        <asp:RequiredFieldValidator ID="rfvContent" runat="server" ControlToValidate="txtContent"
                                                                                            Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fvChoose"></asp:RequiredFieldValidator></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="2" nowrap="nowrap" style="text-align: left">
                                                                                        <asp:ValidatorCalloutExtender ID="vceContent" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                            TargetControlID="rfvContent">
                                                                                        </asp:ValidatorCalloutExtender>
                                                                                        <asp:MaskedEditExtender ID="meeOrder" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                            InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                            OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtOrder">
                                                                                        </asp:MaskedEditExtender>
                                                                                    </td>
                                                                                </tr>
                                                                            </table>
                                                                        </InsertItemTemplate>
                                                                    </asp:FormView>
                                                                    <asp:SqlDataSource ID="sdsChooseFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                        InsertCommand="INSERT INTO [tsChoose] ([tsEaxmination_iAutoKey], [sContent], [bAnswer], [iOrder], [sKeyMan], [dKeyDate]) VALUES (@tsEaxmination_iAutoKey, @sContent, @bAnswer, @iOrder, @sKeyMan, @dKeyDate)"
                                                                        SelectCommand="SELECT * FROM [tsChoose] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE tsChoose SET sContent = @sContent, iOrder = @iOrder, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate WHERE (iAutoKey = @iAutoKey)">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="gvChoose" Name="iAutoKey" PropertyName="SelectedValue"
                                                                                Type="Int32" />
                                                                        </SelectParameters>
                                                                        <UpdateParameters>
                                                                            <asp:Parameter Name="sContent" Type="String" />
                                                                            <asp:Parameter Name="iOrder" Type="Int32" />
                                                                            <asp:Parameter Name="sKeyMan" Type="String" />
                                                                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                                        </UpdateParameters>
                                                                        <InsertParameters>
                                                                            <asp:Parameter Name="tsEaxmination_iAutoKey" Type="String" />
                                                                            <asp:Parameter Name="sContent" Type="String" />
                                                                            <asp:Parameter Name="bAnswer" Type="Boolean" />
                                                                            <asp:Parameter Name="iOrder" Type="Int32" />
                                                                            <asp:Parameter Name="sKeyMan" Type="String" />
                                                                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                        </InsertParameters>
                                                                    </asp:SqlDataSource>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:GridView ID="gvChoose" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                        DataKeyNames="iAutoKey" DataSourceID="sdsChooseGV" OnPageIndexChanged="gvChoose_PageIndexChanged"
                                                                        OnRowDataBound="gv_RowDataBound" OnSelectedIndexChanged="gvChoose_SelectedIndexChanged"
                                                                        Width="100%" AllowPaging="True" OnRowCommand="gvChoose_RowCommand" OnRowDeleted="gvChoose_RowDeleted"
                                                                        PageSize="5">
                                                                        <RowStyle HorizontalAlign="Center" Wrap="True" />
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                                        CommandName="Select" Text="選取" />
                                                                                    <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                                        CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" />
                                                                                </ItemTemplate>
                                                                                <ItemStyle Width="1%" Wrap="False" />
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="sContent" HeaderText="內容" SortExpression="sContent">
                                                                                <ItemStyle HorizontalAlign="Left" />
                                                                            </asp:BoundField>
                                                                            <asp:TemplateField HeaderText="正解" SortExpression="bAnswer">
                                                                                <ItemTemplate>
                                                                                    <asp:CheckBox ID="cbAnswer" runat="server" Checked='<%# Bind("bAnswer") %>' ToolTip='<%# Eval("iAutoKey") %>' /><asp:MutuallyExclusiveCheckBoxExtender
                                                                                        ID="mecbeAnswer" runat="server" Enabled="False" Key='<%# Eval("tsEaxmination_iAutoKey") %>'
                                                                                        TargetControlID="cbAnswer">
                                                                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                                                                </ItemTemplate>
                                                                            </asp:TemplateField>
                                                                            <asp:BoundField DataField="iOrder" HeaderText="順位" SortExpression="iOrder" />
                                                                            <asp:BoundField DataField="sKeyMan" HeaderText="修改者" SortExpression="sKeyMan" />
                                                                            <asp:BoundField DataField="dKeyDate" HeaderText="修改日期" SortExpression="dKeyDate" />
                                                                        </Columns>
                                                                        <EmptyDataTemplate>
                                                                            目前沒有資料。
                                                                        </EmptyDataTemplate>
                                                                        <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                                                                    </asp:GridView>
                                                                    <asp:SqlDataSource ID="sdsChooseGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                        DeleteCommand="DELETE FROM [tsChoose] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [tsChoose] WHERE ([tsEaxmination_iAutoKey] = @tsEaxmination_iAutoKey)">
                                                                        <DeleteParameters>
                                                                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                                        </DeleteParameters>
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="lblChooseID" Name="tsEaxmination_iAutoKey" PropertyName="Text"
                                                                                Type="Int32" />
                                                                        </SelectParameters>
                                                                    </asp:SqlDataSource>
                                                                </td>
                                                            </tr>
                                                        </table>
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
                        <asp:Button ID="hiddenTargetControlForModalPopupChoose" runat="server" Style="display: none" /><asp:ModalPopupExtender
                            ID="mpePopupChoose" runat="server" BackgroundCssClass="modalBackground" BehaviorID="programmaticModalPopupBehavior2"
                            DropShadow="true" PopupControlID="plPopupChoose" PopupDragHandleControlID="plDragChoose"
                            RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopupChoose">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupImport" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="400px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragImport" runat="server" Style="border-right: gray 1px solid;
                                            border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                                            border-bottom: gray 1px solid; background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameImport" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitImport" runat="server" CssClass="ButtonExit" Text="×" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblImportID" runat="server" Visible="False"></asp:Label><asp:Label
                                                ID="lblConn" runat="server" Visible="False"></asp:Label></asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <asp:Wizard ID="wzImport" runat="server" ActiveStepIndex="0" Height="100%" Width="100%"
                                                            FinishCompleteButtonText="確定上傳" FinishPreviousButtonText="上一步" OnFinishButtonClick="wzImport_FinishButtonClick"
                                                            OnNextButtonClick="wzImport_NextButtonClick" OnPreviousButtonClick="wzImport_PreviousButtonClick"
                                                            OnSideBarButtonClick="wzImport_SideBarButtonClick" StartNextButtonText="下一步"
                                                            StepNextButtonText="下一步" StepPreviousButtonText="上一步" BackColor="#F7F6F3" BorderColor="#CCCCCC"
                                                            BorderStyle="Solid" BorderWidth="1px" Font-Names="Verdana" 
                                                            Font-Size="0.8em">
                                                            <WizardSteps>
                                                                <asp:WizardStep runat="server" Title="選擇上傳檔案">
                                                                    <anthem:FileUpload ID="fuExcel" runat="server" AutoUpdateAfterCallBack="True" UpdateAfterCallBack="True" />
                                                                    &nbsp;<anthem:Button ID="btnUpload" TextDuringCallBack="請稍後" EnabledDuringCallBack="False"
                                                                        runat="server" Text="上傳" OnClick="btnUpload_Click" AutoUpdateAfterCallBack="True" UpdateAfterCallBack="True" />
                                                                    <br />
                                                                    <asp:HyperLink ID="hlExcel" runat="server" NavigateUrl="~/Files/EaxminationSample.xls">範例檔案下載</asp:HyperLink>
                                                                </asp:WizardStep>
                                                                <asp:WizardStep runat="server" Title="選擇工作表">
                                                                    <asp:DropDownList ID="ddlSheet" runat="server">
                                                                    </asp:DropDownList>
                                                                </asp:WizardStep>
                                                                <asp:WizardStep runat="server" Title="選擇對應欄位">
                                                                    <table class="TableFullBorder">
                                                                        <tr>
                                                                            <th nowrap="nowrap" width="1%">
                                                                                目的欄位</th>
                                                                            <td nowrap="nowrap" style="text-align: left">
                                                                                Excel來源欄位</td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="nowrap" width="1%">
                                                                                課程分類</th>
                                                                            <td nowrap="nowrap" style="text-align: left">
                                                                                <asp:DropDownList ID="ddlCategorySCode" runat="server" DataSourceID="sdsCategorySCode" DataTextField="sName"
                            DataValueField="sCode">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="noWrap" width="1%">
                                                                                題型</th>
                                                                            <td style="text-align: left;" nowrap="noWrap">
                                                                                <asp:DropDownList ID="ddlCategoryCode" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="noWrap" width="1%">
                                                                                題目</th>
                                                                            <td style="text-align: left;" nowrap="noWrap">
                                                                                <asp:DropDownList ID="ddlContent" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="noWrap" width="1%">
                                                                                答案</th>
                                                                            <td style="text-align: left;" nowrap="noWrap">
                                                                                <asp:DropDownList ID="ddlAnswer" runat="server">
                                                                                </asp:DropDownList>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:WizardStep>
                                                                <asp:WizardStep runat="server" Title="確認上傳">
                                                                    <table class="TableFullBorder">
                                                                        <tr>
                                                                            <th nowrap="nowrap" width="1%">
                                                                                檔案</th>
                                                                            <td nowrap="nowrap" style="text-align: left">
                                                                                <asp:Label ID="lblExcel" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="nowrap" width="1%">
                                                                                工作表</th>
                                                                            <td nowrap="nowrap" style="text-align: left">
                                                                                <asp:Label ID="lblSheet" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="nowrap" width="1%">
                                                                                課程分類</th>
                                                                            <td nowrap="nowrap" style="text-align: left">
                                                                                <asp:Label ID="lblCategorySCode" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="noWrap" width="1%">
                                                                                題型</th>
                                                                            <td style="text-align: left;" nowrap="noWrap">
                                                                                <asp:Label ID="lblCategoryCode" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="noWrap" width="1%">
                                                                                題目</th>
                                                                            <td style="text-align: left;" nowrap="noWrap">
                                                                                <asp:Label ID="lblContent" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="noWrap" width="1%">
                                                                                答案</th>
                                                                            <td style="text-align: left;" nowrap="noWrap">
                                                                                <asp:Label ID="lblAnswer" runat="server"></asp:Label>
                                                                            </td>
                                                                        </tr>
                                                                        <tr>
                                                                            <th nowrap="nowrap" width="1%">
                                                                                其它選項</th>
                                                                            <td nowrap="nowrap" style="text-align: left">
                                                                                <asp:CheckBox ID="cbRep" runat="server" Text="重複可匯入" />
                                                                            </td>
                                                                        </tr>
                                                                    </table>
                                                                </asp:WizardStep>
                                                            </WizardSteps>
                                                            <StepStyle BorderWidth="0px" ForeColor="#5D7B9D" />
                                                            <SideBarButtonStyle BorderWidth="0px" Font-Names="Verdana" ForeColor="White" />
                                                            <NavigationButtonStyle BackColor="#FFFBFF" BorderColor="#CCCCCC" BorderStyle="Solid"
                                                                BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284775" />
                                                            <SideBarStyle BackColor="#7C6F57" BorderWidth="0px" Font-Size="0.9em" VerticalAlign="Top" />
                                                            <HeaderStyle BackColor="#5D7B9D" BorderStyle="Solid" Font-Bold="True" Font-Size="0.9em"
                                                                ForeColor="White" HorizontalAlign="Left" />
                                                        </asp:Wizard>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <anthem:Label ID="lblMsgImport" runat="server" Font-Bold="True" ForeColor="Red" AutoUpdateAfterCallBack="True" UpdateAfterCallBack="True">請上傳Excel的檔案</anthem:Label></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:SqlDataSource ID="sdsCategorySCode" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT sCode, sName FROM lnCategoryS ORDER BY sName"></asp:SqlDataSource>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupImport" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupImport" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior3" DropShadow="true" PopupControlID="plPopupImport"
                            PopupDragHandleControlID="plDragImport" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupImport">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
