<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true"
    CodeFile="tsBaseM.aspx.cs" Inherits="tsBaseM" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" runat="Server">
    <asp:ScriptManagerProxy ID="smp" runat="server">
    </asp:ScriptManagerProxy>
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td nowrap="nowrap">
                        <asp:DropDownList ID="ddlQuestionsM" runat="server" AppendDataBoundItems="True"
                            DataSourceID="sdsQuestionsM" DataTextField="sName" DataValueField="sCode" 
                            AutoPostBack="True">
                            <asp:ListItem Value="a">請選擇考卷名稱</asp:ListItem>
                        </asp:DropDownList>
                        <asp:TextBox ID="txtSearch" runat="server" Width="200px"></asp:TextBox>
                        <asp:Button ID="btnSearch" runat="server" onclick="btnSearch_Click" Text="查詢" />
                        <asp:Label ID="lblSearch" runat="server" Text="a"></asp:Label>
                        <asp:TextBoxWatermarkExtender ID="tbweSearch" runat="server" 
                            TargetControlID="txtSearch" WatermarkCssClass="watermarked" 
                            WatermarkText="請輸入您所要搜尋的關鍵字">
                        </asp:TextBoxWatermarkExtender>
                        <asp:SqlDataSource ID="sdsQuestionsM" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT sCode, sName FROM tsQuestionsM ORDER BY sName"></asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                            DataKeyNames="iAutoKey" DataSourceID="sdsGV" OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound"
                            Width="100%" ondatabound="gv_DataBound">
                            <RowStyle HorizontalAlign="Center" Wrap="True" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnTestView" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sGuid") %>'
                                            CommandName="tsTestView" Text="閱卷" />
                                        <asp:Button ID="btnReTest" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sGuid") %>'
                                            CommandName="ReTest" Text="重考" OnClientClick="return confirm('您確定要設重考');" />
                                        <asp:Button ID="btnDel" runat="server" CausesValidation="False" 
                                            CommandArgument='<%# Eval("sGuid") %>' CommandName="Del" 
                                            OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                    <HeaderTemplate>
                                        <asp:Button ID="btnExport" runat="server" CausesValidation="False" CommandName="Export"
                                            Text="匯出" />
                                    </HeaderTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="tsQuestionsMName" HeaderText="考卷名稱" SortExpression="tsQuestionsMName" />
                                <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                                <asp:BoundField DataField="sNameC" HeaderText="姓名" SortExpression="sNameC" />
                                <asp:BoundField DataField="dWriteDate" HeaderText="填表日期時間" SortExpression="dWriteDate" />
                                <asp:BoundField DataField="iFraction" HeaderText="總分" SortExpression="iFraction" />
                                <asp:BoundField DataField="iMinute" HeaderText="作答時間" SortExpression="iMinute" />
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                            </EmptyDataTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            
                            SelectCommand="SELECT tsBaseM.iAutoKey, tsBaseM.tsQuestionsM_sCode, tsBaseM.iMinute, tsBaseM.sNobr, tsBaseM.sPW, tsBaseM.sName, tsBaseM.dAmountDate, tsBaseM.dWriteDate, tsBaseM.iFraction, tsBaseM.tsTitle_sCode, tsQuestionsM.sName AS tsQuestionsMName, tsQuestionsM.sysRole_iKey, tsQuestionsM.iMax, tsQuestionsM.iMinute AS iMinuteM, tsQuestionsM.sRespondMode, tsQuestionsM.bRandomEaxm, tsQuestionsM.bRandomChoose, tsQuestionsM.dDateA, tsQuestionsM.dDateD, tsBaseM.sGuid, sysCustomerData.sNameC FROM tsBaseM INNER JOIN (SELECT sNobr, tsQuestionsM_sCode, MAX(dAmountDate) AS dAmountDate FROM tsBaseM AS m1 GROUP BY sNobr, tsQuestionsM_sCode) AS m ON tsBaseM.tsQuestionsM_sCode = m.tsQuestionsM_sCode AND tsBaseM.dAmountDate = m.dAmountDate AND tsBaseM.sNobr = m.sNobr LEFT OUTER JOIN sysCustomerData ON tsBaseM.sNobr = sysCustomerData.sysLoginUser_sUserID LEFT OUTER JOIN tsQuestionsM ON tsBaseM.tsQuestionsM_sCode = tsQuestionsM.sCode WHERE (tsBaseM.tsQuestionsM_sCode = @tsBaseMQuestionsM_sCode) AND (tsBaseM.sNobr = @sNobr) OR (tsBaseM.tsQuestionsM_sCode = @tsBaseMQuestionsM_sCode) AND (@sNobr = 'a') OR (@tsBaseMQuestionsM_sCode = 'a') AND (tsBaseM.sNobr = @sNobr) OR (@tsBaseMQuestionsM_sCode = 'a') AND (@sNobr = 'a')">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlQuestionsM" Name="tsBaseMQuestionsM_sCode" 
                                    PropertyName="SelectedValue" DefaultValue="a" />
                                <asp:ControlParameter ControlID="lblSearch" DefaultValue="a" Name="sNobr" 
                                    PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td nowrap="nowrap">
                        <asp:Panel ID="plPopupTest" runat="server" CssClass="modalPopup" Style="display: none;"
                            Width="860">
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
                                                            <asp:Label ID="lblDragNameTest" runat="server"></asp:Label></td>
                                                        <td align="right" width="1%">
                                                            <asp:Button ID="btnExitTest" runat="server" CssClass="ButtonExit" Text="×" OnClick="btnExitTest_Click" /></td>
                                                    </tr>
                                                </table>
                                            </div>
                                            <asp:Label ID="lblKeyID" runat="server" Visible="False"></asp:Label></asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td>
                                        <h4 class="mainheader">
                                            <asp:Label ID="lblHeader" runat="server"></asp:Label></h4>
                                        <div class="ThisIsForm_all">
                                            <div class="UserData">
                                                <asp:FormView ID="fvBaseM" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsBaseM"
                                                    Width="100%" ondatabound="fvBaseM_DataBound">
                                                    <ItemTemplate>
                                                        <table class="TableFullBorder">
                                                            <tr>
                                                                <th nowrap="nowrap">
                                                                    工號</th>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblNobr" runat="server" Text='<%# Bind("sNobr") %>'></asp:Label></td>
                                                                <th nowrap="nowrap">
                                                                    姓名</th>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("sNameC") %>'></asp:Label></td>
                                                                <th nowrap="nowrap">
                                                                    考試時間</th>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="iMinuteMLabel" runat="server" Text='<%# Bind("iMinute") %>'></asp:Label>分鐘</td>
                                                                <th nowrap="nowrap">
                                                                    考題數目</th>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="iMaxLabel" runat="server" Text='<%# Bind("iMax") %>'></asp:Label>題</td>
                                                                <th colspan="2" nowrap="nowrap">
                                                                    分數</th>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("iFraction") %>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="11" nowrap="nowrap" style="text-align: left">
                                                                    <asp:CheckBox ID="bRandomEaxmCheckBox" runat="server" Checked='<%# Bind("bRandomEaxm") %>'
                                                                        Enabled="false" Text="隨機出題" />
                                                                    <asp:CheckBox ID="bRandomChooseCheckBox" runat="server" Checked='<%# Bind("bRandomChoose") %>'
                                                                        Enabled="false" Text="隨機出答案" /></td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:FormView>
                                                <asp:SqlDataSource ID="sdsBaseM" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                    SelectCommand="SELECT tsBaseM_1.iAutoKey, tsBaseM_1.tsQuestionsM_sCode, tsBaseM_1.iMinute, tsBaseM_1.sNobr, tsBaseM_1.sPW, tsBaseM_1.sName, tsBaseM_1.dAmountDate, tsBaseM_1.dWriteDate, tsBaseM_1.iFraction, tsBaseM_1.tsTitle_sCode, tsQuestionsM.sName AS tsQuestionsMName, tsQuestionsM.sysRole_iKey, tsQuestionsM.iMax, tsQuestionsM.iMinute AS iMinuteM, tsQuestionsM.sRespondMode, tsQuestionsM.bRandomEaxm, tsQuestionsM.bRandomChoose, tsQuestionsM.dDateA, tsQuestionsM.dDateD, sysCustomerData.sNameC, tsQuestionsM.iRepeat, tsBaseM_1.sGuid, (SELECT COUNT(*) AS c FROM tsBaseM WHERE (tsQuestionsM_sCode = tsBaseM_1.tsQuestionsM_sCode) AND (sNobr = tsBaseM_1.sNobr)) AS iRepeatNow FROM tsBaseM AS tsBaseM_1 LEFT OUTER JOIN sysCustomerData ON tsBaseM_1.sNobr = sysCustomerData.sysLoginUser_sUserID LEFT OUTER JOIN tsQuestionsM ON tsBaseM_1.tsQuestionsM_sCode = tsQuestionsM.sCode WHERE (tsBaseM_1.sGuid = @sGuid)">
                                                    <SelectParameters>
                                                        <asp:ControlParameter ControlID="lblKeyID" Name="sGuid" PropertyName="Text" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                                <asp:Label ID="lblBaseMAutoKey" runat="server" Visible="False"></asp:Label><asp:Label
                                                    ID="lblQuestionsMCode" runat="server" Visible="False"></asp:Label><asp:Label
                                                                ID="lblNobr" runat="server" Visible="False"></asp:Label></div>
                                            <asp:Panel ID="plOverflow" runat="server">
                                                <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
                                                    <asp:View ID="View0" runat="server">
                                                        <asp:Label ID="lblNotice" runat="server"></asp:Label><br />
                                                        <asp:DataList ID="dlView" runat="server" DataKeyField="iAutoKey" DataSourceID="sdsView"
                                                            OnItemCommand="dlView_ItemCommand" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                            <ItemTemplate>
                                                                <asp:Button ID="btnView" runat="server" CommandArgument='<%# Eval("sGuid") %>' CommandName="View"
                                                                    Text='<%# Eval("sSn") %>' ToolTip='<%# Eval("dWriteDate") %>' />
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                        <asp:SqlDataSource ID="sdsView" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT '第' + CONVERT (nvarchar, (SELECT COUNT(*) AS sSn FROM tsBaseM WHERE (dWriteDate <= m.dWriteDate) AND (tsQuestionsM_sCode = @tsBaseMQuestionsM_sCode) AND (sNobr = @sNobr))) + '次考' + CONVERT (nvarchar, iFraction) + '分' AS sSn, iAutoKey, tsQuestionsM_sCode, sGuid, iMinute, sNobr, sPW, sName, dAmountDate, dWriteDate, iFraction, tsTitle_sCode FROM tsBaseM AS m WHERE (tsQuestionsM_sCode = @tsBaseMQuestionsM_sCode) AND (sNobr = @sNobr) ORDER BY dWriteDate DESC">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblQuestionsMCode" Name="tsBaseMQuestionsM_sCode" PropertyName="Text" />
                                                                <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        </asp:View>
                                                    <asp:View ID="View1" runat="server">
                                                        <asp:DataList ID="dlCategory" runat="server" DataSourceID="sdsCategory" OnItemDataBound="dlCategory_ItemDataBound" EnableViewState="False">
                                                            <ItemTemplate>
                                                                <table cellpadding="0" cellspacing="0" width="100%">
                                                                    <tr>
                                                                        <td align="right" nowrap="nowrap" valign="top" width="1%">
                                                                            <asp:Label ID="lblSn" runat="server" Text='<%# Eval("sSn") %>'></asp:Label>.</td>
                                                                        <td valign="top">
                                                                            <asp:Label ID="lblCategoryName" runat="server" Text='<%# Eval("sName") %>' ToolTip='<%# Eval("sCode") %>'></asp:Label>：</td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td nowrap="nowrap" width="1%">
                                                                        </td>
                                                                        <td>
                                                                            <asp:DataList ID="dlBaseS" runat="server" DataKeyField="tsBaseSiAutoKey" OnItemDataBound="dlBaseS_ItemDataBound">
                                                                                <ItemTemplate>
                                                                                    <table cellpadding="0" cellspacing="0" width="100%">
                                                                                        <tr>
                                                                                            <td align="right" nowrap="nowrap" valign="top" width="1%" style="height: 16px">
                                                                                                <asp:Label ID="lblSn" runat="server"></asp:Label>.</td>
                                                                                            <td valign="top">
                                                                                                <asp:Label ID="lblConten" runat="server" Text='<%# Eval("sContent") %>'></asp:Label></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td nowrap="nowrap" width="1%">
                                                                                            </td>
                                                                                            <td valign="top">
                                                                                                <asp:Panel ID="plAnswer" runat="server" Visible="False">
                                                                                                    <a class="RadioItem">
                                                                                                        <asp:CheckBox ID="cbAnswerYes" runat="server" Text="是" Enabled="False" /></a> <a class="RadioItem">
                                                                                                            <asp:CheckBox ID="cbAnswerNo" runat="server" Text="否" Enabled="False" /></a></asp:Panel>
                                                                                                <asp:DataList ID="dlAnswer" runat="server" RepeatDirection="Horizontal"
                                                                                                    Visible="False" RepeatLayout="Flow" Enabled="False" OnItemDataBound="dlAnswer_ItemDataBound">
                                                                                                    <ItemTemplate>
                                                                                                        <a class="RadioItem">
                                                                                                            <asp:CheckBox ID="cbAnswer" runat="server" Text='<%# Eval("sContent") %>' ToolTip='<%# Eval("iAutoKey") %>'
                                                                                                                ValidationGroup='<%# Eval("bAnswer") %>' /></a>
                                                                                                    </ItemTemplate>
                                                                                                </asp:DataList><asp:SqlDataSource ID="sdsAnswer" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                                    SelectCommand="SELECT * FROM tsChoose &#13;&#10;WHERE (tsEaxmination_iAutoKey = @tsEaxmination_iAutoKey)&#13;&#10;ORDER BY  iOrder">
                                                                                                    <SelectParameters>
                                                                                                        <asp:ControlParameter ControlID="lblEaxminationAutoKey" Name="tsEaxmination_iAutoKey"
                                                                                                            PropertyName="Text" />
                                                                                                    </SelectParameters>
                                                                                                </asp:SqlDataSource>
                                                                                                <asp:TextBox ID="txtAnswer" runat="server" CssClass="txtDescription" Visible="False" ReadOnly="True" Text='<%# Eval("sAnswer") %>'></asp:TextBox></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    <asp:Label ID="lblEaxminationAutoKey" runat="server" Text='<%# Eval("tsEaxminationiAutoKey") %>'
                                                                                        Visible="False"></asp:Label><asp:Label ID="lblBaseSAutoKey" runat="server" Text='<%# Eval("tsBaseSiAutoKey") %>'
                                                                                            Visible="False"></asp:Label><asp:Label ID="lblFraction" runat="server" Text='<%# Eval("iFraction") %>'
                                                                                                Visible="False"></asp:Label><asp:Label ID="lblAnswer" runat="server" Text='<%# Eval("sAnswer") %>'
                                                                                                    Visible="False"></asp:Label><asp:Label ID="lblPass" runat="server" Text='<%# Eval("bPass") %>'
                                                                                                        Visible="False"></asp:Label><asp:Label ID="lblChooseAutoKey" runat="server" Text='<%# Eval("tsChoose_iAutoKey") %>'
                                                                                                            Visible="False"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:DataList>
                                                                            <asp:SqlDataSource ID="sdsBaseS" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT tsEaxmination.iAutoKey AS tsEaxminationiAutoKey, tsEaxmination.sContent, tsEaxmination.iAnswer, tsBaseS.iAutoKey AS tsBaseSiAutoKey, tsBaseS.tsChoose_iAutoKey, tsBaseS.sAnswer, tsBaseS.bPass, tsBaseS.iFraction FROM tsBaseS INNER JOIN tsEaxmination ON tsBaseS.tsEaxmination_iAutoKey = tsEaxmination.iAutoKey INNER JOIN tsBaseM ON tsBaseS.tsBaseM_iAutoKey = tsBaseM.iAutoKey INNER JOIN tsQuestionsS ON tsBaseM.tsQuestionsM_sCode = tsQuestionsS.tsQuestionsM_sCode AND tsBaseS.tsEaxmination_iAutoKey = tsQuestionsS.tsEaxmination_iAutoKey WHERE (tsEaxmination.tsCategory_sCode = @tsCategory_sCode) AND (tsBaseS.tsBaseM_iAutoKey = @tsBaseM_iAutoKey) ORDER BY tsQuestionsS.iOrder">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="lblCategoryCode" Name="tsCategory_sCode" PropertyName="Text" />
                                                                                    <asp:ControlParameter ControlID="lblBaseMAutoKey" Name="tsBaseM_iAutoKey" PropertyName="Text" />
                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                                <asp:Label ID="lblCategoryCode" runat="server" Text='<%# Eval("sCode") %>' Visible="False"></asp:Label>
                                                            </ItemTemplate>
                                                        </asp:DataList>
                                                        <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            SelectCommand="SELECT (SELECT COUNT(*) AS sSn FROM tsCategory WHERE (sCode <= c1.sCode)) AS sSn, sCode, sName FROM tsCategory AS c1 WHERE (sCode IN (SELECT DISTINCT tsEaxmination.tsCategory_sCode FROM tsBaseS INNER JOIN tsEaxmination ON tsBaseS.tsEaxmination_iAutoKey = tsEaxmination.iAutoKey WHERE (tsBaseS.tsBaseM_iAutoKey = @tsBaseM_iAutoKey))) ORDER BY sCode">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblBaseMAutoKey" Name="tsBaseM_iAutoKey" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Label ID="lblCategoryCode" runat="server" Visible="False"></asp:Label><asp:Label
                                                            ID="lblEaxminationAutoKey" runat="server" Visible="False"></asp:Label><asp:Label
                                                                ID="lblFraction" runat="server" Visible="False"></asp:Label><asp:Label
                                                                    ID="lblAnswer" runat="server" Visible="False"></asp:Label><asp:Label
                                                                        ID="lblPass" runat="server" Visible="False"></asp:Label><asp:Label
                                                                            ID="lblChooseAutoKey" runat="server" 
                                                                            Visible="False"></asp:Label></asp:View>
                                                    <asp:View ID="View2" runat="server">
                                                    </asp:View>
                                                    <asp:View ID="View3" runat="server">
                                                    </asp:View>
                                                </asp:MultiView>
                                            </asp:Panel>
                                        </div>
                                        <h4 class="mainfooter">
                                                        <asp:Button ID="btnPrv" runat="server" OnClick="btnPrv_Click" Text="查閱歷史考卷" />
                                            <asp:Label ID="lblFooter" runat="server"></asp:Label></h4>
                                    </td>
                                </tr>
                            </table>
                        </asp:Panel>
                        <asp:Button ID="hiddenTargetControlForModalPopupTest" runat="server" Style="display: none" />&nbsp;
                        <asp:ModalPopupExtender ID="mpePopupTest" runat="server" BackgroundCssClass="modalBackground"
                            BehaviorID="programmaticModalPopupBehavior" DropShadow="true" PopupControlID="plPopupTest"
                            PopupDragHandleControlID="plDragTest" RepositionMode="RepositionOnWindowScroll"
                            TargetControlID="hiddenTargetControlForModalPopupTest">
                        </asp:ModalPopupExtender>
                    </td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
