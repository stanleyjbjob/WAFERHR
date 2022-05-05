<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="sysLoginUser.aspx.cs" Inherits="sysLoginUser" Title="Untitled Page" %>

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
                                                                        <th nowrap="nowrap">
                                                                            帳號</th>
                                                                        <th nowrap="nowrap">
                                                                            密碼</th>
                                                                        <th nowrap="nowrap">
                                                                            密碼提示</th>
                                                                        <th nowrap="nowrap">
                                                                            權限代碼</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap">
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("sUserID") %>'></asp:Label>
                                                                            <asp:CheckBox ID="bPwLockCheckBox" runat="server" Checked='<%# Bind("bPwLock") %>'
                                                                                Text="鎖定" /></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtUserPW" runat="server" CssClass="txtCode" Text='<%# Bind("sUserPW") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="sLeadPWTextBox" runat="server" CssClass="txtCode" Text='<%# Bind("sLeadPW") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:DropDownList ID="ddlRole" runat="server" DataSourceID="sdsRole" DataTextField="sName"
                                                                                DataValueField="iKey" SelectedValue='<%# Bind("sysRole_iKey") %>' AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="0">無任何權限者</asp:ListItem>
                                                                            </asp:DropDownList><span style="color: #0000ff"> </span>
                                                                            <asp:SqlDataSource ID="sdsRole" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [iKey], [sName] FROM [sysRole] ORDER BY [iKey]"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <th colspan="4" nowrap="nowrap">
                                                                            其它進階設定</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("bFirstChange") %>'
                                                                                Text="第一次登入強迫換密碼" /><br />
                                                                            最少<asp:TextBox ID="txtDayChange" runat="server" CssClass="txtOrder" MaxLength="4"
                                                                                Text='<%# Bind("iDayChange") %>' Width="30px" ValidationGroup="fv"></asp:TextBox>天換1次密碼<span
                                                                                    style="color: blue">(0天表示可永久不用換密碼)<br />
                                                                                </span>密碼最少<asp:TextBox ID="txtPwLen" runat="server" CssClass="txtOrder" MaxLength="4"
                                                                                    Text='<%# Bind("iPwLen") %>' Width="30px" ValidationGroup="fv"></asp:TextBox><span>碼<br />
                                                                                    </span>密碼不可與前<asp:TextBox ID="txtPwChange" runat="server" CssClass="txtOrder" MaxLength="4"
                                                                                        Text='<%# Bind("iPwChange") %>' Width="30px" ValidationGroup="fv"></asp:TextBox>次相同<span
                                                                                            style="color: blue">(0次表示可每次相同)<br />
                                                                                        </span>登入失敗<asp:TextBox ID="txtPwLock" runat="server" CssClass="txtOrder" MaxLength="4"
                                                                                            Text='<%# Bind("iPwLock") %>' Width="30px" ValidationGroup="fv"></asp:TextBox>次鎖帳號<asp:TextBox
                                                                                                ID="txtLockTime" runat="server" CssClass="txtOrder" MaxLength="4" Text='<%# Bind("iLockTime") %>'
                                                                                                Width="30px" ValidationGroup="fv"></asp:TextBox>分鐘後自動解開<span style="color: blue">(0次表示不會限制失敗次數，0分表示永久鎖定)<br />
                                                                                                </span>
                                                                            <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap">
                                                                            <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="修改" ValidationGroup="fv" />
                                                                            <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                                                Text="取消" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvUserPW" runat="server" ControlToValidate="txtUserPW"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator>
                                                                            &nbsp; &nbsp;
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:MaskedEditExtender ID="meeUserPW" runat="server" ErrorTooltipEnabled="True"
                                                                                Mask="?{50}" MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtUserPW">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceUserPW" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvUserPW">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:MaskedEditExtender ID="meeDayChange" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtDayChange">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meePwLen" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtPwLen">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meePwChange" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtPwChange">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meePwLock" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtPwLock">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:MaskedEditExtender ID="meeLockTime" runat="server" AutoComplete="false" ErrorTooltipEnabled="True"
                                                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtLockTime">
                                                                            </asp:MaskedEditExtender>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </EditItemTemplate>
                                                            <InsertItemTemplate>
                                                                <table class="TableFullBorder">
                                                                    <tr>
                                                                        <th nowrap="nowrap">
                                                                            帳號</th>
                                                                        <th nowrap="nowrap">
                                                                            密碼</th>
                                                                        <th nowrap="nowrap">
                                                                            密碼提示</th>
                                                                        <th nowrap="nowrap">
                                                                            權限代碼</th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtUserID" runat="server" CssClass="txtCode" Text='<%# Bind("sUserID") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtUserPW" runat="server" CssClass="txtCode" Text='<%# Bind("sUserPW") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:TextBox ID="txtLeadPW" runat="server" CssClass="txtCode" Text='<%# Bind("sLeadPW") %>'
                                                                                ValidationGroup="fv"></asp:TextBox></td>
                                                                        <td nowrap="nowrap">
                                                                            <asp:DropDownList ID="ddlRole" runat="server" DataSourceID="sdsRole" DataTextField="sName"
                                                                                DataValueField="iKey" SelectedValue='<%# Bind("sysRole_iKey") %>' AppendDataBoundItems="True">
                                                                                <asp:ListItem Selected="True" Value="0">無任何權限者</asp:ListItem>
                                                                            </asp:DropDownList>
                                                                            <asp:SqlDataSource ID="sdsRole" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT [iKey], [sName] FROM [sysRole] ORDER BY [iKey]"></asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap">
                                                                            <asp:Button ID="btnInsert" runat="server" CommandName="Insert" Text="新增" ValidationGroup="fv" /></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:RequiredFieldValidator ID="rfvUserID" runat="server" ControlToValidate="txtUserID"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator>
                                                                            <asp:RequiredFieldValidator ID="rfvUserPW" runat="server" ControlToValidate="txtUserPW"
                                                                                Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fv"></asp:RequiredFieldValidator></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                            <asp:MaskedEditExtender ID="meeUserID" runat="server" ErrorTooltipEnabled="True"
                                                                                Mask="?{50}" MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtUserID">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceUserID" runat="Server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvUserID">
                                                                            </asp:ValidatorCalloutExtender>
                                                                            <asp:MaskedEditExtender ID="meeUserPW" runat="server" ErrorTooltipEnabled="True"
                                                                                Mask="?{50}" MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtUserPW">
                                                                            </asp:MaskedEditExtender>
                                                                            <asp:ValidatorCalloutExtender ID="vceUserPW" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                TargetControlID="rfvUserPW">
                                                                            </asp:ValidatorCalloutExtender>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </InsertItemTemplate>
                                                        </asp:FormView>
                                                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            InsertCommand="INSERT INTO sysLoginUser(sUserID, sUserPW, sLeadPW, sysRole_iKey, dRegDate, bFirstChange, iDayChange, iPwLen, iPwChange, iPwLock, iLockTime, bPwLock, sKeyMan, dKeyDate) VALUES (@sUserID, RTRIM(@sUserPW), @sLeadPW, @sysRole_iKey, @dRegDate, @bFirstChange, @iDayChange, @iPwLen, @iPwChange, @iPwLock, @iLockTime, @bPwLock, @sKeyMan, @dKeyDate)"
                                                            SelectCommand="SELECT * FROM [sysLoginUser] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE sysLoginUser SET sUserID = @sUserID, sUserPW = RTRIM(@sUserPW), sLeadPW = @sLeadPW, sysRole_iKey = @sysRole_iKey, bFirstChange = @bFirstChange, iDayChange = @iDayChange, iPwLen = @iPwLen, iPwChange = @iPwChange, iPwLock = @iPwLock, iLockTime = @iLockTime, bPwLock = @bPwLock, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate WHERE (iAutoKey = @iAutoKey)">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                                                    Type="Int32" />
                                                            </SelectParameters>
                                                            <UpdateParameters>
                                                                <asp:Parameter Name="sUserID" Type="String" />
                                                                <asp:Parameter Name="sUserPW" Type="String" />
                                                                <asp:Parameter Name="sLeadPW" Type="String" />
                                                                <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                                                <asp:Parameter Name="bFirstChange" Type="Boolean" />
                                                                <asp:Parameter Name="iDayChange" Type="Int32" />
                                                                <asp:Parameter Name="iPwLen" Type="Int32" />
                                                                <asp:Parameter Name="iPwChange" Type="Int32" />
                                                                <asp:Parameter Name="iPwLock" Type="Int32" />
                                                                <asp:Parameter Name="iLockTime" Type="Int32" />
                                                                <asp:Parameter Name="bPwLock" Type="Boolean" />
                                                                <asp:Parameter Name="sKeyMan" Type="String" />
                                                                <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </UpdateParameters>
                                                            <InsertParameters>
                                                                <asp:Parameter Name="sUserID" Type="String" />
                                                                <asp:Parameter Name="sUserPW" Type="String" />
                                                                <asp:Parameter Name="sLeadPW" Type="String" />
                                                                <asp:Parameter Name="sysRole_iKey" Type="Int32" />
                                                                <asp:Parameter Name="dRegDate" Type="DateTime" />
                                                                <asp:Parameter Name="bFirstChange" Type="Boolean" />
                                                                <asp:Parameter Name="iDayChange" Type="Int32" />
                                                                <asp:Parameter Name="iPwLen" Type="Int32" />
                                                                <asp:Parameter Name="iPwChange" Type="Int32" />
                                                                <asp:Parameter Name="iPwLock" Type="Int32" />
                                                                <asp:Parameter Name="iLockTime" Type="Int32" />
                                                                <asp:Parameter Name="bPwLock" Type="Boolean" />
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
                                        <asp:Button ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="選取" />
                                        <asp:Button ID="btnCustomerData" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sUserID") %>'
                                            CommandName="sysCustomerData" Text="基本資料" />
                                        <asp:Button ID="btnDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sUserID") %>'
                                            CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                    <HeaderTemplate>
                                        <asp:Button ID="btnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                            Text="新增" />
                                        <asp:Button ID="btnImport" runat="server" CommandName="Import" Text="匯入" />
                                        <asp:Button ID="btnExport" runat="server" CommandName="Export" Text="匯出" />
                                    </HeaderTemplate>
                                    <HeaderStyle Wrap="False" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                <asp:BoundField DataField="sUserID" HeaderText="帳號" SortExpression="sUserID">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sUserPW" HeaderText="密碼" SortExpression="sUserPW">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="sRoleName" HeaderText="權限名稱" SortExpression="sRoleName">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="dRegDate" DataFormatString="{0:d}" HeaderText="註冊日期" HtmlEncode="False"
                                    SortExpression="dRegDate">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="iPcount" HeaderText="密碼修改次數" SortExpression="iPcount">
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="iLcount" HeaderText="登入次數" SortExpression="iLcount">
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
                                <asp:Button ID="btnImport" runat="server" CommandName="Import" Text="匯入" />
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            DeleteCommand="DELETE FROM [sysLoginUser] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT sysLoginUser.iAutoKey, sysLoginUser.sUserID, sysLoginUser.sUserPW, sysLoginUser.sLeadPW, sysLoginUser.sysRole_iKey, sysLoginUser.dRegDate, sysLoginUser.bFirstChange, sysLoginUser.iDayChange, sysLoginUser.iPwLen, sysLoginUser.iPwChange, sysLoginUser.iPwLock, sysLoginUser.iLockTime, sysLoginUser.bPwLock, sysLoginUser.sKeyMan, sysLoginUser.dKeyDate, sysRole.sName AS sRoleName, (SELECT COUNT(*) AS c FROM sysLoginPW WHERE (sysLoginUser_sUserID = sysLoginUser.sUserID)) AS iPcount, (SELECT COUNT(*) AS c FROM sysLoginTime WHERE (sysLoginUser_sUserID = sysLoginUser.sUserID)) AS iLcount FROM sysLoginUser LEFT OUTER JOIN sysRole ON sysLoginUser.sysRole_iKey = sysRole.iKey">
                            <DeleteParameters>
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupCustomerData" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="600px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragCustomerData" runat="server" Style="border-right: gray 1px solid;
                                            border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                                            border-bottom: gray 1px solid; background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameCustomerData" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitCustomerData" runat="server" CssClass="ButtonExit" Text="×"
                                                                OnClick="btnExitCustomerData_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblCustomerDataID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <table class="TableFullBorder" width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:FormView ID="fvCustomerData" runat="server" DataKeyNames="iAutoKey,sysLoginUser_sUserID"
                                                                        DataSourceID="sdsCustomerData" DefaultMode="Edit" Width="100%" OnItemUpdated="fvCustomerData_ItemUpdated"
                                                                        OnItemUpdating="fvCustomerData_ItemUpdating">
                                                                        <EditItemTemplate>
                                                                            <table class="TableFullBorder">
                                                                                <tr>
                                                                                    <th nowrap="nowrap">
                                                                                        帳號</th>
                                                                                    <th nowrap="nowrap">
                                                                                        中文姓名</th>
                                                                                    <th nowrap="nowrap">
                                                                                        英文姓名</th>
                                                                                    <th nowrap="nowrap">
                                                                                        身份證字號</th>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:Label ID="Label1" runat="server" Text='<%# Eval("sysLoginUser_sUserID") %>'></asp:Label></td>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtNameC" runat="server" CssClass="txtCode" Text='<%# Bind("sNameC") %>'
                                                                                            ValidationGroup="fvCustomerData"></asp:TextBox>
                                                                                        <asp:RadioButtonList ID="RadioButtonList1" runat="server" RepeatDirection="Horizontal"
                                                                                            RepeatLayout="Flow" SelectedValue='<%# Bind("bSex") %>'>
                                                                                            <asp:ListItem Value="True">男</asp:ListItem>
                                                                                            <asp:ListItem Value="False">女</asp:ListItem>
                                                                                        </asp:RadioButtonList></td>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtNameE" runat="server" CssClass="txtName" Text='<%# Bind("sNameE") %>'
                                                                                            ValidationGroup="fvCustomerData"></asp:TextBox></td>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtKey" runat="server" CssClass="txtCode" Text='<%# Bind("sKey") %>'
                                                                                            ValidationGroup="fvCustomerData"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <th nowrap="nowrap">
                                                                                        生日</th>
                                                                                    <th nowrap="nowrap">
                                                                                        電話</th>
                                                                                    <th colspan="2" nowrap="nowrap">
                                                                                        信箱</th>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtBirthday" runat="server" CssClass="txtDate" Text='<%# Bind("dBirthday", "{0:d}") %>'
                                                                                            ValidationGroup="fvCustomerData"></asp:TextBox></td>
                                                                                    <td nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtTel" runat="server" CssClass="txtCode" Text='<%# Bind("sTel") %>'
                                                                                            ValidationGroup="fvCustomerData"></asp:TextBox></td>
                                                                                    <td colspan="2" nowrap="nowrap">
                                                                                        <asp:TextBox ID="txtEmail" runat="server" CssClass="txtDescription" Text='<%# Bind("sEmail") %>'
                                                                                            ValidationGroup="fvCustomerData"></asp:TextBox></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="4" nowrap="nowrap">
                                                                                        <asp:Button ID="btnUpdate" runat="server" CommandName="Update" OnClientClick=" "
                                                                                            Text="修改" ValidationGroup="fvCustomerData" UseSubmitBehavior="False" /></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                                        <asp:RequiredFieldValidator ID="rfvNameC" runat="server" ControlToValidate="txtNameC"
                                                                                            Display="None" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fvCustomerData"></asp:RequiredFieldValidator><asp:RequiredFieldValidator
                                                                                                ID="rfvBirthday" runat="server" ControlToValidate="txtBirthday" Display="None"
                                                                                                ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="fvCustomerData"></asp:RequiredFieldValidator><asp:RangeValidator
                                                                                                    ID="rvBirthday" runat="server" ControlToValidate="txtBirthday" Display="None"
                                                                                                    ErrorMessage="格式不正確" MaximumValue="9999/12/31" MinimumValue="1900/1/1" SetFocusOnError="True"
                                                                                                    Type="Date" ValidationGroup="fvCustomerData"></asp:RangeValidator><asp:RegularExpressionValidator
                                                                                                        ID="revEmail" runat="server" ControlToValidate="txtEmail" Display="None" ErrorMessage="格式不正確"
                                                                                                        SetFocusOnError="True" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"
                                                                                                        ValidationGroup="fvCustomerData"></asp:RegularExpressionValidator></td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                                        <asp:MaskedEditExtender ID="meeNameC" runat="server" ErrorTooltipEnabled="True" Mask="?{50}"
                                                                                            MaskType="none" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                                            OnInvalidCssClass="MaskedEditError" PromptCharacter=" " TargetControlID="txtNameC">
                                                                                        </asp:MaskedEditExtender>
                                                                                        <asp:ValidatorCalloutExtender ID="vceNameC" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                            TargetControlID="rfvNameC">
                                                                                        </asp:ValidatorCalloutExtender>
                                                                                        <asp:MaskedEditExtender ID="meeBirthday" runat="server" AcceptNegative="Left" AutoComplete="true"
                                                                                            AutoCompleteValue="1900/01/01" DisplayMoney="Left" Mask="9999/99/99" MaskType="Date"
                                                                                            MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError"
                                                                                            TargetControlID="txtBirthday">
                                                                                        </asp:MaskedEditExtender>
                                                                                        <asp:ValidatorCalloutExtender ID="vceBirthday" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                            TargetControlID="rfvBirthday">
                                                                                        </asp:ValidatorCalloutExtender>
                                                                                        <asp:ValidatorCalloutExtender ID="vceBirthday1" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                            TargetControlID="rvBirthday">
                                                                                        </asp:ValidatorCalloutExtender>
                                                                                        <asp:ValidatorCalloutExtender ID="vceEmail" runat="server" HighlightCssClass="validatorCalloutHighlight"
                                                                                            TargetControlID="revEmail">
                                                                                        </asp:ValidatorCalloutExtender>
                                                                                    </td>
                                                                                </tr>
                                                                                <tr>
                                                                                    <td colspan="4" nowrap="nowrap" style="text-align: left">
                                                                                        <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label></td>
                                                                                </tr>
                                                                            </table>
                                                                        </EditItemTemplate>
                                                                        <EmptyDataTemplate>
                                                                            目前沒有資料。
                                                                        </EmptyDataTemplate>
                                                                    </asp:FormView>
                                                                    <asp:SqlDataSource ID="sdsCustomerData" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                        SelectCommand="SELECT * FROM [sysCustomerData] WHERE ([sysLoginUser_sUserID] = @sysLoginUser_sUserID)"
                                                                        UpdateCommand="UPDATE sysCustomerData SET sKey = @sKey, sNobr = @sNobr, sNameC = @sNameC, sNameE = @sNameE, dBirthday = @dBirthday, bSex = @bSex, sTel = @sTel, sEmail = @sEmail, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate WHERE (sysLoginUser_sUserID = @sysLoginUser_sUserID)">
                                                                        <SelectParameters>
                                                                            <asp:ControlParameter ControlID="lblCustomerDataID" Name="sysLoginUser_sUserID" PropertyName="Text"
                                                                                Type="String" />
                                                                        </SelectParameters>
                                                                        <UpdateParameters>
                                                                            <asp:Parameter Name="sKey" Type="String" />
                                                                            <asp:Parameter Name="sNobr" Type="String" />
                                                                            <asp:Parameter Name="sNameC" Type="String" />
                                                                            <asp:Parameter Name="sNameE" Type="String" />
                                                                            <asp:Parameter Name="dBirthday" Type="DateTime" />
                                                                            <asp:Parameter Name="bSex" Type="Boolean" />
                                                                            <asp:Parameter Name="sTel" Type="String" />
                                                                            <asp:Parameter Name="sEmail" Type="String" />
                                                                            <asp:Parameter Name="sKeyMan" Type="String" />
                                                                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                                                            <asp:Parameter Name="sysLoginUser_sUserID" Type="String" />
                                                                        </UpdateParameters>
                                                                    </asp:SqlDataSource>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                        <tr>
                                                                            <th>
                                                                                登入記錄(會記最後六次)</th>
                                                                            <th>
                                                                                密碼修改記錄(會記最後四次)</th>
                                                                        </tr>
                                                                        <tr>
                                                                            <td valign="top">
                                                                                <asp:GridView ID="gvLogin" runat="server" AutoGenerateColumns="False" DataKeyNames="iAutoKey"
                                                                                    DataSourceID="sdsLogin" Width="100%">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                                            ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                                                                        <asp:BoundField DataField="sLoginIP" HeaderText="登入位置" SortExpression="sLoginIP">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="sLoginSuccess" HeaderText="成功與否" SortExpression="sLoginSuccess">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="dLoginTime" HeaderText="登入時間" SortExpression="dLoginTime">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="dLogoutTime" HeaderText="dLogoutTime" SortExpression="dLogoutTime"
                                                                                            Visible="False" />
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                                <asp:SqlDataSource ID="sdsLogin" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                    SelectCommand="SELECT TOP 6 iAutoKey, sysLoginUser_sUserID, sLoginIP, bLoginSuccess, dLoginTime, dLogoutTime, CASE bLoginSuccess WHEN '1' THEN '是' ELSE '否' END AS sLoginSuccess FROM sysLoginTime WHERE (sysLoginUser_sUserID = @sysLoginUser_sUserID) ORDER BY dLoginTime DESC">
                                                                                    <SelectParameters>
                                                                                        <asp:ControlParameter ControlID="lblCustomerDataID" Name="sysLoginUser_sUserID" PropertyName="Text" />
                                                                                    </SelectParameters>
                                                                                </asp:SqlDataSource>
                                                                            </td>
                                                                            <td valign="top">
                                                                                <asp:GridView ID="gvPW" runat="server" AutoGenerateColumns="False" DataKeyNames="iAutoKey"
                                                                                    DataSourceID="sdsPW" Width="100%">
                                                                                    <Columns>
                                                                                        <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                                            ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                                                                        <asp:BoundField DataField="umcLoginUser_sUserID" HeaderText="umcLoginUser_sUserID"
                                                                                            SortExpression="umcLoginUser_sUserID" Visible="False" />
                                                                                        <asp:BoundField DataField="sUserPWold" HeaderText="原本密碼" SortExpression="sUserPWold">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="sUserPWnew" HeaderText="新的密碼" SortExpression="sUserPWnew">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                        <asp:BoundField DataField="sKeyMan" HeaderText="sKeyMan" SortExpression="sKeyMan"
                                                                                            Visible="False" />
                                                                                        <asp:BoundField DataField="dKeyDate" HeaderText="修改時間" SortExpression="dKeyDate">
                                                                                            <ItemStyle HorizontalAlign="Center" />
                                                                                        </asp:BoundField>
                                                                                    </Columns>
                                                                                </asp:GridView>
                                                                                <asp:SqlDataSource ID="sdsPW" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                    SelectCommand="SELECT TOP 4 * FROM [sysLoginPW]&#13;&#10;WHERE         (sysLoginUser_sUserID = @sysLoginUser_sUserID)&#13;&#10;ORDER BY  dKeyDate DESC">
                                                                                    <SelectParameters>
                                                                                        <asp:ControlParameter ControlID="lblCustomerDataID" Name="sysLoginUser_sUserID" PropertyName="Text" />
                                                                                    </SelectParameters>
                                                                                </asp:SqlDataSource>
                                                                            </td>
                                                                        </tr>
                                                                    </table>
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
                        <asp:Button ID="hiddenTargetControlForModalPopupCustomerData" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupCustomerData" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupCustomerData"
                            PopupDragHandleControlID="plDragCustomerData" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupCustomerData">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
            </table>
            &nbsp;
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
