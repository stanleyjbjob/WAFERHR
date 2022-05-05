<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="rpTest.aspx.cs" Inherits="rpTest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td>
                        <asp:Button ID="btnSelect" runat="server" Text="條件" CausesValidation="False" OnClick="btnSelect_Click" />
                        <asp:Button ID="btnExport" runat="server" Text="匯出" CausesValidation="False" OnClick="btnExport_Click" />
                        </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gv" runat="server" Width="100%" OnRowDataBound="gv_RowDataBound">
                            <RowStyle HorizontalAlign="Center" />
                        </asp:GridView>
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:Panel ID="plPopupSelect" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="320px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragSelect" runat="server" Style="border-right: gray 1px solid;
                                            border-top: gray 1px solid; border-left: gray 1px solid; cursor: move; color: black;
                                            border-bottom: gray 1px solid; background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameSelect" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitSelect" runat="server" CssClass="ButtonExit" Text="×" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblSelectID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <table class="TableFullBorder">
                                                            <tr>
                                                                <th align="right">
                                                                    考試日期：</th>
                                                                <td>
                                                                    <asp:TextBox ID="txtDate" runat="server" CssClass="txtDate"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <th align="right">
                                                                    查詢日期：</th>
                                                                <td>
                                                                    <asp:TextBox ID="txtDateB" runat="server" CssClass="txtDate"></asp:TextBox>到<asp:TextBox
                                                                        ID="txtDateE" runat="server" CssClass="txtDate"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <th align="right">
                                                                    依部門查詢：</th>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlDept" runat="server" AppendDataBoundItems="True" DataSourceID="odsDept"
                                                                        DataTextField="sDeptName" DataValueField="sDeptCode">
                                                                        <asp:ListItem Value="0">全部</asp:ListItem>
                                                                    </asp:DropDownList>
                                                                    <asp:ObjectDataSource ID="odsDept" runat="server" OldValuesParameterFormatString="original_{0}"
                                                                        SelectMethod="GetData" TypeName="SysDSTableAdapters.DeptTableAdapter"></asp:ObjectDataSource>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <th align="right">
                                                                    依工號查詢：</th>
                                                                <td>
                                                                    <asp:TextBox ID="txtNobr" runat="server" CssClass="txtCode"></asp:TextBox></td>
                                                            </tr>
                                                            <tr>
                                                                <th align="right">
                                                                    其它選項：</th>
                                                                <td>
                                                                    <asp:CheckBox ID="ckM" runat="server" Text="儲存格合併" />
                                                                </td>
                                                            </tr>
                                                        </table><asp:MaskedEditExtender ID="meeDate" runat="server"
                                                                            AcceptNegative="Left" AutoComplete="true" AutoCompleteValue="1900/01/01" DisplayMoney="Left"
                                                                            Mask="9999/99/99" MaskType="Date" MessageValidatorTip="true" OnFocusCssClass="MaskedEditFocus"
                                                                            OnInvalidCssClass="MaskedEditError" TargetControlID="txtDate">
                                                        </asp:MaskedEditExtender>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Button ID="btnSubmit" runat="server" Text="確定" OnClick="btnSubmit_Click" /></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:Label ID="lblMsgSelect" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </div>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupSelect" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupSelect" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupSelect"
                            PopupDragHandleControlID="plDragSelect" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupSelect">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td>
                    </td>
                </tr>
            </table>
            &nbsp; &nbsp; &nbsp;
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphR" runat="Server">
</asp:Content>
