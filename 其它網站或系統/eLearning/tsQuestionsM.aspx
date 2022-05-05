<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="tsQuestionsM.aspx.cs" Inherits="tsQuestionsM" Title="Untitled Page"  ValidateRequest="false"%>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
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
                                                                        <th nowrap="nowrap" width="1%">
                                                                            考卷代碼</th>
                                                                        <th nowrap="nowrap" colspan="6">
                                                                            考卷名稱</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("sCode") %>'></asp:Label></td>
                                                                        <td colspan="6" nowrap="nowrap">
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtDescription" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            考題數目</th>
                                                                        <th nowrap="nowrap">
                                                                            考試時間</th>
                                                                        <th nowrap="nowrap">
                                                                            可考試次數</th>
                                                                        <th nowrap="nowrap">
                                                                            範圍</th>
                                                                        <th nowrap="nowrap">
                                                                            評等群組</th>
                                                                        <th nowrap="nowrap">
                                                                            作答方式</th>
                                                                        <th nowrap="nowrap">
                                                                            生失效日</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:TextBox ID="txtMax" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iMax") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtMinute" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iMinute") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtRepeat" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iRepeat") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtScope" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iScope") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:DropDownList ID="ddlTitleM" runat="server" AppendDataBoundItems="True" DataSourceID="sdsTitleM"
                                                                                DataTextField="sName" DataValueField="sCode" SelectedValue='<%# Bind("tsTitleM_sCode") %>'>
                                                                                <asp:ListItem Value="0">預設</asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("sRespondMode") %>'
                                                                                ValidationGroup="fv" Enabled="False">
                                                                                <asp:ListItem Value="1">全部</asp:ListItem>
                                                                                <asp:ListItem Value="2">分類</asp:ListItem>
                                                                                <asp:ListItem Value="3">逐一</asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtDateB" runat="server" CssClass="txtDate" Text='<%# Bind("dDateA", "{0:d}") %>'
                                                                                ValidationGroup="fv"></asp:TextBox>到<asp:TextBox ID="txtDateE" runat="server" CssClass="txtDate"
                                                                                    Text='<%# Bind("dDateD", "{0:d}") %>' ValidationGroup="fv"></asp:TextBox>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="7" nowrap="nowrap" style="text-align: left">
                                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("bRandomEaxm") %>'
                                                                                Text="題目隨機編排" ValidationGroup="fv" />
                                                                            <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("bRandomChoose") %>'
                                                                                Text="答案隨機編排" ValidationGroup="fv" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="7" nowrap="nowrap">
                                                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fv" />
                                                                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                Text="取消" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="7" nowrap="nowrap" style="text-align: left">
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
                                                                                                    Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="7" nowrap="nowrap" style="text-align: left">
                                                                            <asp:ValidatorCalloutExtender ID="vceName" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvName">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:MaskedEditExtender ID="meeMax" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMax">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeMinute" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMinute">
                                                                            </asp:MaskedEditExtender>
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
                                                                            <asp:MaskedEditExtender ID="meeRepeat" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtRepeat">
                                                                            </asp:MaskedEditExtender><asp:MaskedEditExtender ID="meeScope" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtScope">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:SqlDataSource ID="sdsTitleM" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [sCode], [sName] FROM [tsTitleM]"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <table class="TableFullBorder">
                                                                    <tr>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            考卷代碼</th>
                                                                        <th nowrap="nowrap" colspan="7">
                                                                            考卷名稱</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:TextBox ID="txtCode" runat="server" CssClass="txtCode" MaxLength="10" Text='<%# Bind("sCode") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td colspan="7" nowrap="nowrap">
                                                                            <asp:TextBox ID="txtName" runat="server" CssClass="txtDescription" Text='<%# Bind("sName") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th nowrap="nowrap" width="1%">
                                                                            考題數目</th>
                                                                        <th nowrap="nowrap">
                                                                            考試時間</th>
                                                                        <th nowrap="nowrap">
                                                                            可考試次數</th>
                                                                        <th nowrap="nowrap">
                                                                            範圍</th>
                                                                        <th nowrap="nowrap">
                                                                            評等群組</th>
                                                                        <th colspan="3" nowrap="nowrap">
                                                                            作答方式</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap" width="1%">
                                                                            <asp:TextBox ID="txtMax" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iMax") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtMinute" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iMinute") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtRepeat" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iRepeat") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtScope" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iScope") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:DropDownList ID="ddlTitleM" runat="server" AppendDataBoundItems="True" DataSourceID="sdsTitleM"
                                                                                DataTextField="sName" DataValueField="sCode" SelectedValue='<%# Bind("tsTitleM_sCode") %>'>
                                                                                <asp:ListItem Value="0">預設</asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                                        <td colspan="3" nowrap="nowrap">
                                                                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("sRespondMode") %>'
                                                                                ValidationGroup="fv" Enabled="False">
                                                                                <asp:ListItem Value="1">全部</asp:ListItem>
                                                                                <asp:ListItem Value="2">分類</asp:ListItem>
                                                                                <asp:ListItem Value="3">逐一</asp:ListItem>
                                                                            </asp:DropDownList></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="8" nowrap="nowrap" style="text-align: left">
                                                                            <asp:CheckBox ID="bRandomEaxmCheckBox" runat="server" Checked='<%# Bind("bRandomEaxm") %>'
                                                                                Text="題目隨機編排" ValidationGroup="fv" />
                                                                            <asp:CheckBox ID="bRandomChooseCheckBox" runat="server" Checked='<%# Bind("bRandomChoose") %>'
                                                                                Text="答案隨機編排" ValidationGroup="fv" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="8" nowrap="nowrap">
                                                                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fv" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="8" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvCode" runat="server" ControlToValidate="txtCode"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                                                                    ID="rfvName" runat="server" ControlToValidate="txtName" Display="None" ErrorMessage="不允許空白"
                                                                                    SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="8" nowrap="nowrap" style="text-align: left">
                                                                            <asp:ValidatorCalloutExtender ID="vceCode" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvCode">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceName" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvName">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:MaskedEditExtender ID="meeMax" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMax">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeMinute" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtMinute">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeRepeat" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtRepeat">
                                                                            </asp:MaskedEditExtender><asp:MaskedEditExtender ID="meeScope" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtScope">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:SqlDataSource ID="sdsTitleM" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [sCode], [sName] FROM [tsTitleM]"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </InsertItemTemplate>
                                                        </asp:FormView>
                                                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            InsertCommand="INSERT INTO tsQuestionsM(sCode, sName, sysRole_iKey, iMax, iMinute, iRepeat, sRespondMode, bRandomEaxm, bRandomChoose, dDateA, dDateD, sKeyMan, dKeyDate, tsTitleM_sCode, iScope) VALUES (@sCode, @sName, @sysRole_iKey, @iMax, @iMinute, @iRepeat, @sRespondMode, @bRandomEaxm, @bRandomChoose, @dDateA, @dDateD, @sKeyMan, @dKeyDate, @tsTitleM_sCode, @iScope)"
                                                            SelectCommand="SELECT * FROM [tsQuestionsM] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE tsQuestionsM SET sCode = @sCode, sName = @sName, iMax = @iMax, iMinute = @iMinute, iRepeat = @iRepeat, sRespondMode = @sRespondMode, bRandomEaxm = @bRandomEaxm, bRandomChoose = @bRandomChoose, dDateA = @dDateA, dDateD = @dDateD, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate, tsTitleM_sCode = @tsTitleM_sCode, iScope = @iScope WHERE (iAutoKey = @iAutoKey)"
                                                            DeleteCommand="DELETE FROM [tsQuestionsM] WHERE [iAutoKey] = @iAutoKey">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="sCode" Type="String" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="iMax" Type="Int32" />
                                                                <asp:Parameter Name="iMinute" Type="Int32" />
                                                                <asp:Parameter Name="iRepeat" Type="Int32" />
                                                                <asp:Parameter Name="sRespondMode" Type="String" />
                                                                <asp:Parameter Name="bRandomEaxm" Type="Boolean" />
                                                                <asp:Parameter Name="bRandomChoose" Type="Boolean" />
                                                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="tsTitleM_sCode" />
                                                                <asp:Parameter Name="iScope" />
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </UpdateParameters>
                                                            <InsertParameters>
                                                                <asp:Parameter Name="sCode" Type="String" />
                                                                <asp:Parameter Name="sName" Type="String" />
                                                                <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                                                <asp:Parameter Name="iMax" Type="Int32" />
                                                                <asp:Parameter Name="iMinute" Type="Int32" />
                                                                <asp:Parameter Name="iRepeat" Type="Int32" />
                                                                <asp:Parameter Name="sRespondMode" Type="String" />
                                                                <asp:Parameter Name="bRandomEaxm" Type="Boolean" />
                                                                <asp:Parameter Name="bRandomChoose" Type="Boolean" />
                                                                <asp:Parameter Name="dDateA" Type="DateTime" />
                                                                <asp:Parameter Name="dDateD" Type="DateTime" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="tsTitleM_sCode" />
                                                                <asp:Parameter Name="iScope" />
                                                            </InsertParameters>
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </DeleteParameters>
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
                        <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                            DataKeyNames="iAutoKey,sCode" DataSourceID="sdsGV" OnPageIndexChanged="gv_PageIndexChanged"
                            OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound" OnSelectedIndexChanged="gv_SelectedIndexChanged"
                            Width="100%" OnRowDeleted="gv_RowDeleted">
                            <RowStyle HorizontalAlign="Center" Wrap="True" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                            CommandName="Select" Text="選取" />&nbsp;<asp:Button ID="btnQuestionsS" runat="server"
                                                CausesValidation="False" CommandArgument='<%# Eval("sCode") %>' CommandName="tsQuestionsS"
                                                Text="考題管理" />
                                        <asp:Button ID="btnHeader" runat="server"
                                                CausesValidation="False" CommandArgument='<%# Eval("sCode") %>' CommandName="sHeader"
                                                Text="頁首" />
                                        <asp:Button ID="btnNotice" runat="server"
                                                CausesValidation="False" CommandArgument='<%# Eval("sCode") %>' CommandName="sNotice"
                                                Text="內容" />
                                        <asp:Button ID="btnFooter" runat="server"
                                                CausesValidation="False" CommandArgument='<%# Eval("sCode") %>' CommandName="sFooter"
                                                Text="頁尾" />&nbsp;<asp:Button ID="Button3" runat="server" CausesValidation="False"
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
                                <asp:BoundField DataField="sCode" HeaderText="考卷代碼" SortExpression="sCode" />
                                <asp:BoundField DataField="sName" HeaderText="考卷名稱" SortExpression="sName" />
                                <asp:BoundField DataField="iMax" HeaderText="考題數目" SortExpression="iMax" />
                                <asp:BoundField DataField="iRepeat" HeaderText="可考次數" SortExpression="iRepeat" />
                                <asp:BoundField DataField="iMinute" HeaderText="考試時間" SortExpression="iMinute" />
                                <asp:BoundField DataField="iScope" HeaderText="範圍" SortExpression="iScope" />
                                <asp:BoundField DataField="tsTitleMsName" HeaderText="評等群組" SortExpression="tsTitleMsName" />
                                <asp:BoundField DataField="sRespondModeN" HeaderText="回答方式" SortExpression="sRespondModeN" />
                                <asp:BoundField DataField="sRandomEaxm" HeaderText="題目隨機" SortExpression="sRandomEaxm" />
                                <asp:BoundField DataField="sRandomChoose" HeaderText="答案隨機" SortExpression="sRandomChoose" />
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                                <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                    Text="新增" />
                            </EmptyDataTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [tsQuestionsM] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT tsQuestionsM.iAutoKey, tsQuestionsM.sCode, tsQuestionsM.sName, tsQuestionsM.sysRole_iKey, tsQuestionsM.iMax, tsQuestionsM.iMinute, tsQuestionsM.sRespondMode, CASE sRespondMode WHEN '1' THEN '全部' WHEN '2' THEN '分類' ELSE '逐一' END AS sRespondModeN, tsQuestionsM.bRandomEaxm, CASE bRandomEaxm WHEN '1' THEN '是' ELSE '否' END AS sRandomEaxm, tsQuestionsM.bRandomChoose, CASE bRandomChoose WHEN '1' THEN '是' ELSE '否' END AS sRandomChoose, tsQuestionsM.sKeyMan, tsQuestionsM.dKeyDate, tsQuestionsM.iRepeat, tsQuestionsM.dDateA, tsQuestionsM.dDateD, tsQuestionsM.tsTitleM_sCode, tsQuestionsM.iScope, ISNULL(tsTitleM.sName, N'預設') AS tsTitleMsName FROM tsQuestionsM LEFT OUTER JOIN tsTitleM ON tsQuestionsM.tsTitleM_sCode = tsTitleM.sCode">
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupQuestionsS" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="900px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragQuestionsS" runat="server" Style="border-right: gray 1px solid;
                                            border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                                            border-bottom: gray 1px solid; background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameQuestionsS" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitQuestionsS" runat="server" CssClass="ButtonExit" Text="×"
                                                                OnClick="btnExitQuestionsS_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblQuestionsSID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%" class="TableFullBorder">
                                                <tr>
                                                    <th align="center" nowrap="nowrap" style="width: 1%">
                                                    </th>
                                                    <td align="center" colspan="5" nowrap="nowrap" style="text-align: left">
                                                        <asp:DropDownList ID="ddlCategoryS" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                            DataSourceID="sdsCategoryS" DataTextField="sName" DataValueField="sCode" OnSelectedIndexChanged="ddlCategoryS_SelectedIndexChanged">
                                                            <asp:ListItem Value="a">課程小分類</asp:ListItem>
                                                        </asp:DropDownList><asp:DropDownList ID="ddlCategory" runat="server" AppendDataBoundItems="True"
                                                            AutoPostBack="True" DataSourceID="sdsCategory" DataTextField="sName" DataValueField="sCode"
                                                            OnSelectedIndexChanged="ddlCategory_SelectedIndexChanged">
                                                            <asp:ListItem Value="a">考題類別</asp:ListItem>
                                                        </asp:DropDownList>
                                                        <asp:TextBox ID="txtSearch" runat="server" Width="200px"></asp:TextBox>
                                                        <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="搜尋關鍵字" />
                                                        <asp:TextBoxWatermarkExtender ID="tbweSearch" runat="server" TargetControlID="txtSearch"
                                                            WatermarkCssClass="watermarked" WatermarkText="請輸入您所要搜尋的關鍵字">
                                                        </asp:TextBoxWatermarkExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th align="center" nowrap="nowrap" style="width: 1%">
                                                        未<br />
                                                        加<br />
                                                        入</th>
                                                    <td align="center" colspan="5" nowrap="nowrap">
                                                        <asp:ListBox ID="lbU" runat="server" Height="200px" SelectionMode="Multiple" 
                                                            Width="100%" DataSourceID="sdsEaxmination" DataTextField="sContent" DataValueField="iAutoKey"
                                                            OnDataBound="lbU_DataBound"></asp:ListBox>&nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" nowrap="nowrap" style="width: 1%">
                                                    </td>
                                                    <td align="center" nowrap="nowrap">
                                                        <asp:Button ID="btnDA" runat="server" CausesValidation="False" CommandArgument="1"
                                                            CommandName="D" OnCommand="btnDU_Command" Text="↓↓↓" OnClientClick="return confirm('您確定全部要移過去？');"
                                                            Font-Names="細明體" /></td>
                                                    <td align="center" nowrap="nowrap">
                                                        <asp:Button ID="btnD" runat="server" CausesValidation="False" CommandArgument="0"
                                                            CommandName="D" OnCommand="btnDU_Command" Text="　↓　" Font-Names="細明體" /></td>
                                                    <td align="center" nowrap="nowrap">
                                                        <span style="color: #000000"></span>
                                                        <asp:Button ID="btnU" runat="server" CausesValidation="False" CommandArgument="0"
                                                            CommandName="U" OnCommand="btnDU_Command" Text="　↑　" Font-Names="細明體" /><span style="color: #ff0000"></span></td>
                                                    <td align="center" nowrap="nowrap">
                                                        <asp:Button ID="btnUA" runat="server" CausesValidation="False" CommandArgument="1"
                                                            CommandName="U" OnCommand="btnDU_Command" Text="↑↑↑" OnClientClick="return confirm('您確定全部要移過去？');"
                                                            Font-Names="細明體" /></td>
                                                    <td align="center" nowrap="nowrap" width="1%">
                                                        <span style="color: #000000"></span>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" nowrap="nowrap" style="width: 1%">
                                                    </td>
                                                    <td align="center" nowrap="nowrap">
                                                        <span style="color: #000000"></span>
                                                    </td>
                                                    <td align="center" nowrap="nowrap">
                                                        <span style="color: #000000">每題<asp:TextBox ID="txtFraction" runat="server" CssClass="txtOrder"
                                                            MaxLength="4">1</asp:TextBox>分</span></td>
                                                    <td align="center" nowrap="nowrap">
                                                        <span style="color: #000000"></span>共加入<asp:Label ID="lblNum" runat="server">0</asp:Label>題</td>
                                                    <td align="center" nowrap="nowrap">
                                                        <span style="color: #000000"></span>共<asp:Label ID="lblSum" runat="server">0</asp:Label>分</td>
                                                    <td align="center" nowrap="nowrap" width="1%">
                                                        考題順序</td>
                                                </tr>
                                                <tr>
                                                    <th align="center" nowrap="nowrap" style="width: 1%">
                                                        已<br />
                                                        加<br />
                                                        入</th>
                                                    <td align="center" colspan="4" nowrap="nowrap">
                                                        <asp:ListBox ID="lbD" runat="server" Height="200px" SelectionMode="Multiple" 
                                                            Width="100%" OnDataBound="lbD_DataBound"></asp:ListBox></td>
                                                    <td align="center" colspan="1" nowrap="nowrap" width="1%">
                                                        <br />
                                                        <table cellspacing="0" class="0" height="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnUA1" runat="server" CausesValidation="False" CommandArgument="1"
                                                                        CommandName="U1" OnCommand="btnDU_Command" Text="置　頂" OnClientClick="return confirm('您確定全部置頂嗎？');"
                                                                        Font-Names="細明體" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnU1" runat="server" CausesValidation="False" CommandArgument="0"
                                                                        CommandName="U1" OnCommand="btnDU_Command" Text="向上移" Font-Names="細明體" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnD1" runat="server" CausesValidation="False" CommandArgument="0"
                                                                        CommandName="D1" OnCommand="btnDU_Command" Text="向下移" Font-Names="細明體" /></td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:Button ID="btnDA1" runat="server" CausesValidation="False" CommandArgument="1"
                                                                        CommandName="D1" OnCommand="btnDU_Command" Text="置　尾" OnClientClick="return confirm('您確定全部置尾嗎？');"
                                                                        Font-Names="細明體" /></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="center" colspan="6" nowrap="nowrap">
                                                        <span style="color: #000000"></span><span style="color: black">
                                                            <asp:Button ID="btnSave" runat="server" Text="儲存" OnClick="btnSave_Click" OnClientClick="return confirm('您確定要儲存嗎？');" /></span></td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:MaskedEditExtender ID="meeFraction" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                            InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                            OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtFraction">
                                        </asp:MaskedEditExtender>
                                        <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                            SelectCommand="SELECT [sCode], [sName] FROM [tsCategory]"></asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsCategoryS" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                            SelectCommand="SELECT sCode, sName FROM lnCategoryS ORDER BY sName"></asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsEaxmination" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                            
                                            SelectCommand="SELECT iAutoKey, lnCategoryS_sCode, tsCategory_sCode, sContent, iAnswer, sKeyMan, dKeyDate FROM tsEaxmination WHERE (lnCategoryS_sCode = @lnCategoryS_sCode) AND (tsCategory_sCode = @tsCategory_sCode OR @tsCategory_sCode = 'a')">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="ddlCategoryS" Name="lnCategoryS_sCode" PropertyName="SelectedValue"
                                                    Type="String" />
                                                <asp:ControlParameter ControlID="ddlCategory" Name="tsCategory_sCode" PropertyName="SelectedValue"
                                                    Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:ListBox ID="lbD1" runat="server" SelectionMode="Multiple" Font-Names="細明體" OnDataBound="lbD_DataBound"
                                            Visible="False"></asp:ListBox></td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupQuestionsS" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupQuestionsS" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupQuestionsS"
                            PopupDragHandleControlID="plDragQuestionsS" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupQuestionsS">
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
                                        <asp:Panel ID="plDragEdit" runat="server" Style="border-right: gray 1px solid;
                                            border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                                            border-bottom: gray 1px solid; background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameEdit" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitEdit" runat="server" CssClass="ButtonExit" Text="×" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblEditID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td style="text-align: center">
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <FCKeditorV2:FCKeditor ID="fckContent" runat="server" BasePath="./FCKeditor/" Height="300px"
                                                            ToolbarSet="Ming">
                                                        </FCKeditorV2:FCKeditor>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        </td>
                                                </tr>
                                            </table>
                                        </div>
                                        <asp:Button ID="btnSaveEdit" runat="server" CausesValidation="False" OnClick="btnSaveEdit_Click"
                                            OnClientClick="return confirm('您確定要儲存嗎？');" Text="儲存" /></td>
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
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
