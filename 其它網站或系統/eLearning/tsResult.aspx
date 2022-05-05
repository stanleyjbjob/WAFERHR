<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="tsResult.aspx.cs" Inherits="tsResult" %>

<%@ Register Src="ucAuth.ascx" TagName="ucAuth" TagPrefix="uc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table>
                <tr>
                    <td>
                        <asp:Button ID="btnResult" runat="server" OnClick="btnResult_Click" Text="產生名單" />
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gv" runat="server" Width="100%" AutoGenerateColumns="False">
                            <RowStyle HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField HeaderText="通知">
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("bSend") %>' />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbSend" runat="server" Checked='<%# Bind("bSend") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="加入">
                                    <EditItemTemplate>
                                        <asp:CheckBox ID="CheckBox2" runat="server" Checked='<%# Bind("bAdd") %>' />
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:CheckBox ID="cbAdd" runat="server" Checked='<%# Bind("bAdd") %>' />
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:CheckBoxField DataField="bHave" HeaderText="已考" />
                                <asp:BoundField DataField="sTitleCode" HeaderText="評等" />
                                <asp:TemplateField HeaderText="工號" Visible="False">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sNobr") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <asp:Label ID="lblNobr" runat="server" Text='<%# Bind("sNobr") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="sName" HeaderText="工號/姓名" />
                                <asp:BoundField DataField="sDeptName" HeaderText="部門" />
                            </Columns>
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plSave" runat="server" Visible="False">
                            <table>
                                <tr>
                                    <td nowrap="nowrap">
                                        ※沒有加入就不會通知
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">
                                        <asp:Button ID="btnSave" runat="server" OnClick="btnSave_Click" Text="確定儲存" OnClientClick="return confirm('您確定要儲存嗎？');" />
                                    </td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupQuestionsM" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="350px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragQuestionsM" runat="server" Style="border-right: gray 1px solid;
                                            border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                                            border-bottom: gray 1px solid; background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameQuestionsM" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" style="width: 1%">
                                                            <asp:Button ID="btnExitQuestionsM" runat="server" CssClass="ButtonExit" Text="×"
                                                                OnClick="btnExitQuestionsM_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblQuestionsMID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <table width="100%">
                                                            <tr>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlDept" runat="server" AppendDataBoundItems="True" DataSourceID="odsDept"
                                                                        DataTextField="sDeptName" DataValueField="sDeptCode" AutoPostBack="True" OnSelectedIndexChanged="ddlDept_SelectedIndexChanged">
                                                                        <asp:ListItem Value="0">請選擇部門</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:DropDownList ID="ddlQuestionsM" runat="server" DataSourceID="sdsQuestionsM"
                                                                        DataTextField="sName" DataValueField="sCode" AppendDataBoundItems="True">
                                                                        <asp:ListItem Value="0">請選擇考卷</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:ObjectDataSource ID="odsDept" runat="server" OldValuesParameterFormatString="original_{0}"
                                                                        SelectMethod="GetData" TypeName="SysDSTableAdapters.DeptTableAdapter"></asp:ObjectDataSource>
                                                                    <asp:SqlDataSource ID="sdsQuestionsM" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                        SelectCommand="SELECT sCode, sName FROM tsQuestionsM WHERE (GETDATE() BETWEEN dDateA AND dDateD) ORDER BY sCode">
                                                                    </asp:SqlDataSource>
                                                                    <uc1:ucAuth ID="ucResult" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: left">
                                                                    <asp:CheckBox ID="cbPass" runat="server" Text="已有資料重新產生" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td style="text-align: center">
                                                                    <asp:Button ID="btnView" runat="server" OnClick="btnView_Click" Text="產生名單" />
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblMsgQuestionsM" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                                                    </td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupQuestionsM" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupQuestionsM" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupQuestionsM"
                            PopupDragHandleControlID="plDragQuestionsM" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupQuestionsM">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphR" runat="Server">
</asp:Content>
