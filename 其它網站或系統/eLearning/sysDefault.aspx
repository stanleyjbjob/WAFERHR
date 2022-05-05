<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true" CodeFile="sysDefault.aspx.cs" Inherits="sysDefault" Title="Untitled Page" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0">
                <tr>
                    <td>
                        <asp:DropDownList ID="ddlCategory" runat="server" AutoPostBack="True">
                            <asp:ListItem Value="sys">系統設定</asp:ListItem>
                            <asp:ListItem Value="mail">電子信箱</asp:ListItem>
                            <asp:ListItem Value="com">公司資料</asp:ListItem>
                            <asp:ListItem Value="sysLoginUser">預設帳號值</asp:ListItem>
                            <asp:ListItem Value="tsTest">考卷相關</asp:ListItem>
                        </asp:DropDownList></td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False"
                            DataKeyNames="iAutoKey" DataSourceID="sdsGV" Font-Size="Small" OnRowDataBound="gv_RowDataBound" OnRowUpdating="gv_RowUpdating"
                            Width="100%">
                            <RowStyle HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <EditItemTemplate>
                                        <asp:Button ID="btnUpdate" runat="server" CommandName="Update" Text="更新" ValidationGroup="gv" />
                                        <asp:Button ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="取消" />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Button ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            Text="編輯" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="sName" HeaderText="說明" ReadOnly="True" SortExpression="sName" />
                                <asp:TemplateField HeaderText="值" SortExpression="sValue">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="txtValue" runat="server" Text='<%# Bind("sValue") %>' ToolTip='<%# Eval("sType") %>'
                                            Visible="False" ValidationGroup="gv"></asp:TextBox><asp:CheckBox ID="cbValue" runat="server" Visible="False" ValidationGroup="gv" />
                                        <asp:RequiredFieldValidator ID="rfvValue" runat="server" ControlToValidate="txtValue"
                                            Display="None" Enabled="False" ErrorMessage="不允許空白" SetFocusOnError="True" ValidationGroup="gv"></asp:RequiredFieldValidator><asp:MaskedEditExtender
                                                ID="meeValue" runat="server" AutoComplete="false" Enabled="False" ErrorTooltipEnabled="True"
                                                InputDirection="RightToLeft" Mask="9999" MaskType="Number" MessageValidatorTip="true"
                                                OnFocusCssClass="MaskedEditFocus" OnInvalidCssClass="MaskedEditError" TargetControlID="txtValue">
                                            </asp:MaskedEditExtender>
                                        <asp:ValidatorCalloutExtender ID="vceValue" runat="Server" Enabled="True" HighlightCssClass="validatorCalloutHighlight"
                                            TargetControlID="rfvValue">
                                        </asp:ValidatorCalloutExtender>
                                        <asp:Label ID="lblTypeP" runat="server" Text='<%# Eval("sTypeP") %>' Visible="False"></asp:Label><asp:Label
                                            ID="lblNull" runat="server" Text='<%# Eval("bNull") %>' Visible="False"></asp:Label>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        &nbsp;<asp:TextBox ID="txtValue" runat="server" Enabled="False" Text='<%# Bind("sValue") %>'
                                            ToolTip='<%# Eval("sType") %>' Visible="False"></asp:TextBox><asp:CheckBox ID="cbValue"
                                                runat="server" Enabled="False" Visible="False" />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="dKeyDate" HeaderText="修改日期" ReadOnly="True" SortExpression="dKeyDate" />
                            </Columns>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT * FROM [sysDefault]&#13;&#10;WHERE         (sCategory = @sCategory)&#13;&#10;ORDER BY  iOrder"
                            UpdateCommand="UPDATE sysDefault SET sValue = @sValue, dKeyDate = GETDATE(), sKeyMan = @sKeyMan WHERE (iAutoKey = @iAutoKey)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCategory" Name="sCategory" PropertyName="SelectedValue" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="sValue" Type="String" />
                                <asp:Parameter Name="sKeyMan" />
                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                            </UpdateParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
            </table>
            &nbsp;
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

