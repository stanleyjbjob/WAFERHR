<%@ Page Language="C#" MasterPageFile="~/mpUser.master" AutoEventWireup="true" CodeFile="LearningDefault.aspx.cs"
    Inherits="LearningDefault" Title="Untitled Page" ValidateRequest="false" %>

<%@ Register Assembly="Media_Player_Control" Namespace="Media_Player_ASP" TagPrefix="cc3" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="cphL" ContentPlaceHolderID="cphL" runat="Server">
    <asp:Menu ID="mu" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2"
        Font-Names="Verdana" Font-Size="Small" ForeColor="#284E98" StaticSubMenuIndent="10px"
        OnMenuItemClick="mu_MenuItemClick" Width="100%" StaticDisplayLevels="3">
        <StaticSelectedStyle BackColor="#507CD1" />
        <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
        <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
        <DynamicMenuStyle BackColor="#B5C7DE" />
        <DynamicSelectedStyle BackColor="#507CD1" />
        <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
        <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
    </asp:Menu>
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
    <br />
</asp:Content>
<asp:Content ID="cphM" ContentPlaceHolderID="cphM" runat="Server">
    <asp:ScriptManagerProxy ID="ScriptManagerProxy1" runat="server">
    </asp:ScriptManagerProxy>
    <asp:Label ID="lblMenu" runat="server" Visible="False"></asp:Label>
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td nowrap="nowrap" valign="top" width="1">
                        &nbsp;
                    </td>
                    <td nowrap="nowrap" valign="top">
                        <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" DataSourceID="sdsCategoryS"
                            Width="100%" OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound" AllowSorting="True">
                            <RowStyle HorizontalAlign="Center" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnCategory" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCodeS") %>'
                                            CommandName="lnCategory" Text="閱讀" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="sCodeS" HeaderText="編號" SortExpression="sCodeS" />
                                <asp:BoundField DataField="sNameS" HeaderText="課程名稱" SortExpression="sNameS" />
                                <asp:BoundField DataField="iEdition" HeaderText="修訂次數" SortExpression="iEdition" />
                                <asp:BoundField DataField="iView" HeaderText="檢視人數" SortExpression="iView" />
                                <asp:BoundField DataField="sKeyMan" HeaderText="修改者" SortExpression="sKeyMan" />
                                <asp:BoundField DataField="dKeyDate" HeaderText="修改日期" SortExpression="dKeyDate" />
                            </Columns>
                            <HeaderStyle Wrap="False" />
                            <EmptyDataTemplate>
                                請點選左邊的類別。
                             
                                <br />
                                【管理小品】 歡迎點閱以下連結！<br />
                                <a href="http://www.emba.com.tw/" target="_blank">EMBA雜誌 - 管理文章小品</a><br />
                                <a href="http://www.chinamgt.com" target="_blank">華文企管網 - 管理新思維</a><br />
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsCategoryS" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT lnCategoryL.sCode AS sCodeL, lnCategoryL.sName AS sNameL, lnCategoryL.iOrder AS iOrderL, lnCategoryM.sCode AS sCodeM, lnCategoryM.sName AS sNameM, lnCategoryM.iOrder AS iOrderM, lnCategoryS.sysRole_iKey, lnCategoryS.sCode AS sCodeS, lnCategoryS.sName AS sNameS, lnCategoryS.iOrder AS iOrderS, lnCategoryS.iEdition, lnCategoryS.iView, lnCategoryS.dDateA, lnCategoryS.dDateD, lnCategoryS.dKeyDate, lnCategoryS.sKeyMan FROM lnCategoryL INNER JOIN lnCategoryM ON lnCategoryL.sCode = lnCategoryM.lnCategoryL_sCode INNER JOIN lnCategoryS ON lnCategoryM.sCode = lnCategoryS.lnCategoryM_sCode WHERE (GETDATE() BETWEEN lnCategoryS.dDateA AND lnCategoryS.dDateD) AND (lnCategoryS.lnCategoryM_sCode = @sCodeM) ORDER BY lnCategoryL.iOrder, lnCategoryM.iOrder, lnCategoryS.iOrder">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblMenu" Name="sCodeM" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" valign="top" width="1">
                    </td>
                    <td nowrap="nowrap" valign="top">
                        <asp:Panel ID="plPopup" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="600px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDrag" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragName" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExit" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExit_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblKeyID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <asp:Panel ID="plOverflow" runat="server">
                                            <table cellpadding="0" cellspacing="0" width="100%" class="TableFullBorder">
                                                <tr>
                                                    <td>
                                                        <asp:FormView ID="fv" runat="server" DataSourceID="sdsFV" Width="100%">
                                                            <ItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" class="TableFullBorder" width="100%">
                                                                    <tr>
                                                                        <th>
                                                                            <asp:Label ID="sNameSLabel" runat="server" Text='<%# Bind("sNameS") %>'></asp:Label>
                                                                        </th>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="height: 25px; text-align: left;">
                                                                            <asp:Label ID="Label1" runat="server" Text='<%# Bind("sContent") %>'></asp:Label>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </ItemTemplate>
                                                        </asp:FormView>
                                                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            SelectCommand="SELECT lnCategoryL.sCode AS sCodeL, lnCategoryL.sName AS sNameL, lnCategoryL.iOrder AS iOrderL, lnCategoryM.sCode AS sCodeM, lnCategoryM.sName AS sNameM, lnCategoryM.iOrder AS iOrderM, lnCategoryS.sysRole_iKey, lnCategoryS.sCode AS sCodeS, lnCategoryS.sName AS sNameS, lnCategoryS.iOrder AS iOrderS, lnCategoryS.iEdition, lnCategoryS.iView, lnCategoryS.dDateA, lnCategoryS.dDateD, lnCategoryS.dKeyDate, lnCategoryS.sKeyMan, lnCategoryS.sContent FROM lnCategoryL INNER JOIN lnCategoryM ON lnCategoryL.sCode = lnCategoryM.lnCategoryL_sCode INNER JOIN lnCategoryS ON lnCategoryM.sCode = lnCategoryS.lnCategoryM_sCode WHERE (GETDATE() BETWEEN lnCategoryS.dDateA AND lnCategoryS.dDateD) AND (lnCategoryS.sCode = @sCodeS) ORDER BY lnCategoryL.iOrder, lnCategoryM.iOrder, lnCategoryS.iOrder">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblKeyID" Name="sCodeS" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <th>
                                                        附檔下載或播放
                                                    </th>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvUpload" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            DataSourceID="sdsUpload" OnRowCommand="gvUpload_RowCommand" OnRowDataBound="gvUpload_RowDataBound"
                                                            PageSize="5" Width="100%">
                                                            <RowStyle HorizontalAlign="Center" />
                                                            <Columns>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:Button ID="btnDownload" runat="server" CausesValidation="False" CommandArgument='<%# Bind("iAutoKey") %>'
                                                                            CommandName="Download" Text='<%# Bind("sCat") %>' />
                                                                        <asp:Button ID="btnPlay" runat="server" CausesValidation="False" CommandArgument='<%# Bind("iAutoKey") %>'
                                                                            CommandName="Play" Text='<%# Bind("sCat") %>' />
                                                                    </ItemTemplate>
                                                                    <ItemStyle Width="1%" Wrap="False" />
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="sUpName" HeaderText="檔名" SortExpression="sUpName" />
                                                                <asp:BoundField DataField="sType" HeaderText="檔案類別" SortExpression="sType" />
                                                                <asp:BoundField DataField="iSize" HeaderText="檔案大小(KB)" SortExpression="iSize" />
                                                                <asp:BoundField DataField="sContent" HeaderText="說明" SortExpression="sContent" />
                                                            </Columns>
                                                            <EmptyDataTemplate>
                                                                目前沒有任何附件上傳。
                                                            </EmptyDataTemplate>
                                                            <HeaderStyle HorizontalAlign="Center" />
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsUpload" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            SelectCommand="SELECT * FROM [lnUpFile] WHERE ([lnCategoryS_sCode] = @lnCategoryS_sCode)">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblKeyID" Name="lnCategoryS_sCode" PropertyName="Text"
                                                                    Type="String" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left">
                                                        <asp:DataList ID="dlTest" runat="server" CellPadding="4" DataSourceID="sdsTest" ForeColor="Black"
                                                            OnItemCommand="dlTest_ItemCommand" RepeatDirection="Horizontal" BackColor="White"
                                                            BorderColor="#DEDFDE" BorderStyle="None" BorderWidth="1px" GridLines="Vertical">
                                                            <FooterStyle BackColor="#CCCC99" />
                                                            <AlternatingItemStyle BackColor="White" />
                                                            <ItemStyle BackColor="#F7F7DE" />
                                                            <SelectedItemStyle BackColor="#CE5D5A" Font-Bold="True" ForeColor="White" />
                                                            <SeparatorTemplate>
                                                                ,
                                                            </SeparatorTemplate>
                                                            <HeaderTemplate>
                                                                相關考卷
                                                            </HeaderTemplate>
                                                            <HeaderStyle BackColor="#6B696B" Font-Bold="True" ForeColor="White" />
                                                            <FooterTemplate>
                                                                欲報名考試請點課程名稱
                                                            </FooterTemplate>
                                                            <ItemTemplate>
                                                                <asp:LinkButton ID="lbtnSign" runat="server" CommandArgument='<%# Eval("sCode") %>'
                                                                    CommandName="Sign" OnClientClick="return confirm('您確定要報名考試嗎？');" Text='<%# Eval("sName") %>'></asp:LinkButton><br />
                                                                <br />
                                                            </ItemTemplate>
                                                        </asp:DataList><asp:SqlDataSource ID="sdsTest" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            SelectCommand="SELECT tsQuestionsM.sName, tsQuestionsM.sCode FROM lnTest INNER JOIN tsQuestionsM ON lnTest.tsQuestionsM_sCode = tsQuestionsM.sCode WHERE (lnTest.lnCategoryS_sCode = @sCode)">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblKeyID" Name="sCode" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="text-align: left">
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopup" runat="server" Style="display: none" />
                        <asp:ModalPopupExtender ID="mpePopup" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior1" DropShadow="true" PopupControlID="plPopup"
                            PopupDragHandleControlID="plDrag" RepositionMode="RepositionOnWindowScroll" TargetControlID="hiddenTargetControlForModalPopup">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap" valign="top" width="1">
                    </td>
                    <td nowrap="nowrap" valign="top">
                        <asp:Panel ID="plPopupMovie" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="320px">
                            <table cellpadding="0" cellspacing="0" width="100%">
                                <tr>
                                    <td>
                                        <asp:Panel ID="plDragMovie" runat="server" Style="border-right: gray 1px solid; border-top: gray 1px solid;
                                            border-left: gray 1px solid; cursor: move; color: black; border-bottom: gray 1px solid;
                                            background-color: #dddddd;">
                                            <div>
                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                    <tr>
                                                        <td nowrap="nowrap">
                                                            <asp:Label ID="lblDragNameMovie" runat="server"></asp:Label>
                                                        </td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitMovie" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitMovie_Click" />
                                                        </td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblMovieID" runat="server" Visible="False"></asp:Label>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <div>
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td>
                                                        <cc3:Media_Player_Control ID="mpc" runat="server" />
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
                        <asp:Button ID="hiddenTargetControlForModalPopupMovie" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupMovie" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior2" DropShadow="true" PopupControlID="plPopupMovie"
                            PopupDragHandleControlID="plDragMovie" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupMovie">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                    </td>
                    <td nowrap="nowrap">
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="cphR" ContentPlaceHolderID="cphR" runat="Server">
</asp:Content>
