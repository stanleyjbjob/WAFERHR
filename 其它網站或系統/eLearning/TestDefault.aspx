<%@ Page Language="C#" MasterPageFile="mpUser.master" AutoEventWireup="true" CodeFile="TestDefault.aspx.cs"
    Inherits="TestDefault" Title="Untitled Page" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<asp:Content ID="cphL" ContentPlaceHolderID="cphL" runat="Server">
    <asp:Menu ID="mu" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2"
        Font-Names="Verdana" Font-Size="Small" ForeColor="#284E98" StaticDisplayLevels="2"
        StaticSubMenuIndent="10px" OnMenuItemClick="mu_MenuItemClick" Font-Bold="False"
        Width="100%">
        <StaticSelectedStyle BackColor="#507CD1" />
        <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
        <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
        <DynamicMenuStyle BackColor="#B5C7DE" />
        <DynamicSelectedStyle BackColor="#507CD1" />
        <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
        <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
        <Items>
            <asp:MenuItem Text="全部的考卷" Value="0"></asp:MenuItem>
            <asp:MenuItem Selected="True" Text="現有的考卷" Value="1"></asp:MenuItem>
            <asp:MenuItem Text="已考的考卷" Value="2"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="cphM" ContentPlaceHolderID="cphM" runat="Server">
    <asp:ScriptManagerProxy ID="smp" runat="server">
    </asp:ScriptManagerProxy>
    <asp:Label ID="lblUserID" runat="server" Visible="False"></asp:Label><asp:Label ID="lblMenu" runat="server" Visible="False"></asp:Label><asp:UpdatePanel
        ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                            DataKeyNames="iAutoKey" DataSourceID="sdsGV" OnRowDataBound="gv_RowDataBound"
                            Width="100%" OnRowCommand="gv_RowCommand">
                            <RowStyle HorizontalAlign="Center" Wrap="True" />
                            <Columns>
                                <asp:TemplateField>
                                    <ItemTemplate>
                                        <asp:Button ID="btnSelect" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sGuid") %>'
                                            CommandName="Select" OnClientClick="return confirm('您確定要開始考試嗎？');" Text="考試" />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="tsQuestionsMName" HeaderText="考卷名稱" SortExpression="tsQuestionsMName" />
                                <asp:BoundField DataField="dAmountDate" HeaderText="產表日期時間" SortExpression="dAmountDate" />
                                <asp:BoundField DataField="dWriteDate" HeaderText="填表日期時間" SortExpression="dWriteDate" />
                                <asp:BoundField DataField="iFraction" HeaderText="總分" SortExpression="iFraction" />
                                <asp:BoundField DataField="iMinute" HeaderText="作答時間" SortExpression="iMinute" />
                                <asp:TemplateField HeaderText="可考/已考">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRepeat" runat="server" Text='<%# Eval("iRepeat") %>'></asp:Label>/<asp:Label
                                            ID="lblRepeatNow" runat="server" Text='<%# Eval("iRepeatNow") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <EmptyDataTemplate>
                                目前沒有資料。
                            </EmptyDataTemplate>
                            <HeaderStyle HorizontalAlign="Center" Wrap="False" />
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                            SelectCommand="SELECT tsBaseM.iAutoKey, tsBaseM.tsQuestionsM_sCode, tsBaseM.iMinute, tsBaseM.sNobr, tsBaseM.sPW, tsBaseM.sName, tsBaseM.dAmountDate, tsBaseM.dWriteDate, tsBaseM.iFraction, tsBaseM.tsTitle_sCode, tsQuestionsM.sName AS tsQuestionsMName, tsQuestionsM.sysRole_iKey, tsQuestionsM.iMax, tsQuestionsM.iMinute AS iMinuteM, tsQuestionsM.sRespondMode, tsQuestionsM.bRandomEaxm, tsQuestionsM.bRandomChoose, tsQuestionsM.dDateA, tsQuestionsM.dDateD, tsBaseM.sNobr + tsBaseM.sPW + tsBaseM.tsQuestionsM_sCode AS sKey, tsBaseM.sGuid, sysCustomerData.sNameC, (SELECT COUNT(*) AS c FROM tsBaseM AS m WHERE (tsQuestionsM_sCode = tsBaseM.tsQuestionsM_sCode) AND (sNobr = tsBaseM.sNobr)) AS iRepeatNow, tsQuestionsM.iRepeat FROM tsBaseM INNER JOIN (SELECT tsQuestionsM_sCode, MAX(dAmountDate) AS dAmountDate FROM tsBaseM AS m1 WHERE (sNobr = @sNobr) GROUP BY tsQuestionsM_sCode) AS m_1 ON tsBaseM.tsQuestionsM_sCode = m_1.tsQuestionsM_sCode AND tsBaseM.dAmountDate = m_1.dAmountDate LEFT OUTER JOIN sysCustomerData ON tsBaseM.sNobr = sysCustomerData.sysLoginUser_sUserID LEFT OUTER JOIN tsQuestionsM ON tsBaseM.tsQuestionsM_sCode = tsQuestionsM.sCode WHERE (tsBaseM.sNobr = @sNobr) AND ('0' = @mu) OR (tsBaseM.sNobr = @sNobr) AND (CONVERT (nvarchar, GETDATE(), 112) BETWEEN CONVERT (nvarchar, tsQuestionsM.dDateA, 112) AND CONVERT (nvarchar, tsQuestionsM.dDateD, 112)) AND ('1' = @mu) AND (tsBaseM.dWriteDate IS NULL) OR (tsBaseM.sNobr = @sNobr) AND (CONVERT (nvarchar, GETDATE(), 112) BETWEEN CONVERT (nvarchar, tsQuestionsM.dDateA, 112) AND CONVERT (nvarchar, tsQuestionsM.dDateD, 112)) AND (tsBaseM.dWriteDate IS NOT NULL) AND ('2' = @mu)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblUserID" Name="sNobr" PropertyName="Text" />
                                <asp:ControlParameter ControlID="lblMenu" DefaultValue="1" Name="mu" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                    </td>
                </tr>
                <tr>
                    <td>
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
                                                                    <asp:Label ID="iMinuteMLabel" runat="server" Text='<%# Bind("iMinuteM") %>'></asp:Label>分鐘</td>
                                                                <th nowrap="nowrap">
                                                                    考題數目</th>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="iMaxLabel" runat="server" Text='<%# Bind("iMax") %>'></asp:Label>題</td>
                                                                <th colspan="2" nowrap="nowrap">
                                                                    已考/可考次數</th>
                                                                <td colspan="1" nowrap="nowrap">
                                                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("iRepeatNow") %>'></asp:Label>/<asp:Label
                                                                        ID="Label1" runat="server" Text='<%# Bind("iRepeat") %>'></asp:Label></td>
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
                                                    ID="lblQuestionsMCode" runat="server" Visible="False"></asp:Label><asp:Label ID="lblRandomEaxm"
                                                        runat="server" Visible="False"></asp:Label><asp:Label ID="lblRandomChoose" runat="server"
                                                            Visible="False"></asp:Label><asp:Label ID="lblSecond" runat="server" Visible="False"></asp:Label><asp:Label
                                                                ID="lblMinute" runat="server" Visible="False"></asp:Label><asp:Label ID="lblRespondMode"
                                                                    runat="server" Visible="False"></asp:Label>
                                                <asp:Label ID="lblTitleM" runat="server" Visible="False"></asp:Label>剩餘時間：<asp:Label ID="lblTime" runat="server" Visible="False">0 : 0</asp:Label>&nbsp;
                                                <asp:TextBox ID="txtShowTime" runat="server" ReadOnly="True" Width="60px"></asp:TextBox><asp:TextBox
                                                    ID="txtOutTime" runat="server" Width="1px" Style="visibility: hidden; display: none;"></asp:TextBox><asp:Timer
                                                        ID="tmTest" runat="server" Interval="1000" OnTick="tmTest_Tick" Enabled="False">
                                                    </asp:Timer>
                                            </div>
                                            <asp:Panel ID="plOverflow" runat="server">
                                                <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
                                                    <asp:View ID="View0" runat="server">
                                                        <asp:Label ID="lblNotice" runat="server"></asp:Label><br />
                                                        <asp:Button ID="btnStart" runat="server" OnClick="btnStart_Click" OnClientClick="if (confirm('您確定要開始考試嗎？')==false) {return false;}else{startTimer();};"
                                                            Text="開始考試" UseSubmitBehavior="False" /></asp:View>
                                                    <asp:View ID="View1" runat="server">
                                                    <div style="line-height: 30px">
                                                        <asp:DataList ID="dlCategory" runat="server" OnItemDataBound="dlCategory_ItemDataBound">
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
                                                                                                <asp:Label ID="lblSn" runat="server" Font-Size="Medium"></asp:Label>.</td>
                                                                                            <td valign="top">
                                                                                                <asp:Label ID="lblConten" runat="server" Text='<%# Eval("sContent") %>' 
                                                                                                    ToolTip='<%# Eval("tsEaxminationiAutoKey") %>' Font-Size="Medium"></asp:Label></td>
                                                                                        </tr>
                                                                                        <tr>
                                                                                            <td nowrap="nowrap" width="1%">
                                                                                            </td>
                                                                                            <td valign="top">
                                                                                                <asp:Panel ID="plAnswer" runat="server" Visible="False">
                                                                                                    <a class="RadioItem">
                                                                                                        <asp:CheckBox ID="cbAnswerYes" runat="server" Text="是" Font-Size="Medium" /></a> <a class="RadioItem">
                                                                                                                <asp:CheckBox ID="cbAnswerNo" runat="server" Text="否" 
                                                                                                        Font-Size="Medium" /></a><asp:MutuallyExclusiveCheckBoxExtender
                                                                                                                        ID="mecbeAnswerYes" runat="server" Enabled="True" TargetControlID="cbAnswerYes"
                                                                                                                        Key='<%# Eval("tsEaxminationiAutoKey") %>'>
                                                                                                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                                                                                    <asp:MutuallyExclusiveCheckBoxExtender ID="mecbeAnswerNo" runat="server" Enabled="True"
                                                                                                        TargetControlID="cbAnswerNo" Key='<%# Eval("tsEaxminationiAutoKey") %>'>
                                                                                                    </asp:MutuallyExclusiveCheckBoxExtender>
                                                                                                </asp:Panel>
                                                                                                <asp:DataList ID="dlAnswer" runat="server" RepeatDirection="Horizontal" OnItemDataBound="dlAnswer_ItemDataBound"
                                                                                                    Visible="False" RepeatLayout="Flow" Font-Size="Medium">
                                                                                                    <ItemTemplate>
                                                                                                        <a class="RadioItem">
                                                                                                            <asp:CheckBox ID="cbAnswer" runat="server" Text='<%# Eval("sContent") %>' ToolTip='<%# Eval("iAutoKey") %>'
                                                                                                                ValidationGroup='<%# Eval("bAnswer") %>' /></a><asp:MutuallyExclusiveCheckBoxExtender
                                                                                                                    ID="mecbeAnswer" runat="server" Key='<%# Eval("tsEaxmination_iAutoKey") %>' Enabled="True"
                                                                                                                    TargetControlID="cbAnswer">
                                                                                                                </asp:MutuallyExclusiveCheckBoxExtender>
                                                                                                    </ItemTemplate>
                                                                                                </asp:DataList>
                                                                                                <asp:SqlDataSource ID="sdsAnswer" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                                    SelectCommand="SELECT * FROM tsChoose &#13;&#10;WHERE (tsEaxmination_iAutoKey = @tsEaxmination_iAutoKey)&#13;&#10;ORDER BY  iOrder">
                                                                                                    <SelectParameters>
                                                                                                        <asp:ControlParameter ControlID="lblEaxminationAutoKey" Name="tsEaxmination_iAutoKey"
                                                                                                            PropertyName="Text" />
                                                                                                    </SelectParameters>
                                                                                                </asp:SqlDataSource>
                                                                                                <asp:SqlDataSource ID="sdsAnswerNewID" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                                    SelectCommand="SELECT iAutoKey, tsEaxmination_iAutoKey, sContent, bAnswer, iOrder, sKeyMan, dKeyDate FROM tsChoose WHERE (tsEaxmination_iAutoKey = @tsEaxmination_iAutoKey) ORDER BY NEWID()">
                                                                                                    <SelectParameters>
                                                                                                        <asp:ControlParameter ControlID="lblEaxminationAutoKey" Name="tsEaxmination_iAutoKey"
                                                                                                            PropertyName="Text" />
                                                                                                    </SelectParameters>
                                                                                                </asp:SqlDataSource>
                                                                                                <asp:TextBox ID="txtAnswer" runat="server" CssClass="txtDescription" Visible="False"></asp:TextBox></td>
                                                                                        </tr>
                                                                                    </table>
                                                                                    <asp:Label ID="lblEaxminationAutoKey" runat="server" Text='<%# Eval("tsEaxminationiAutoKey") %>'
                                                                                        Visible="False"></asp:Label><asp:Label ID="lblBaseSAutoKey" runat="server" Text='<%# Eval("tsBaseSiAutoKey") %>'
                                                                                            Visible="False"></asp:Label><asp:Label ID="lblFraction" runat="server" Text='<%# Eval("iFraction") %>'
                                                                                                Visible="False"></asp:Label><asp:Label ID="lblAnswer" runat="server" Text='<%# Eval("iAnswer") %>'
                                                                                                    Visible="False"></asp:Label>
                                                                                </ItemTemplate>
                                                                            </asp:DataList>
                                                                            <asp:SqlDataSource ID="sdsBaseS" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT tsEaxmination.iAutoKey AS tsEaxminationiAutoKey, tsEaxmination.sContent, tsEaxmination.iAnswer, tsBaseS.iAutoKey AS tsBaseSiAutoKey, tsQuestionsS.iFraction FROM tsBaseS INNER JOIN tsEaxmination ON tsBaseS.tsEaxmination_iAutoKey = tsEaxmination.iAutoKey INNER JOIN tsBaseM ON tsBaseS.tsBaseM_iAutoKey = tsBaseM.iAutoKey INNER JOIN tsQuestionsS ON tsBaseM.tsQuestionsM_sCode = tsQuestionsS.tsQuestionsM_sCode AND tsBaseS.tsEaxmination_iAutoKey = tsQuestionsS.tsEaxmination_iAutoKey WHERE (tsEaxmination.tsCategory_sCode = @tsCategory_sCode) AND (tsBaseS.tsBaseM_iAutoKey = @tsBaseM_iAutoKey) ORDER BY tsQuestionsS.iOrder">
                                                                                <SelectParameters>
                                                                                    <asp:ControlParameter ControlID="lblCategoryCode" Name="tsCategory_sCode" PropertyName="Text" />
                                                                                    <asp:ControlParameter ControlID="lblBaseMAutoKey" Name="tsBaseM_iAutoKey" PropertyName="Text" />
                                                                                </SelectParameters>
                                                                            </asp:SqlDataSource>
                                                                            <asp:SqlDataSource ID="sdsBaseSNewID" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                                                SelectCommand="SELECT tsEaxmination.iAutoKey AS tsEaxminationiAutoKey, tsEaxmination.sContent, tsEaxmination.iAnswer, tsBaseS.iAutoKey AS tsBaseSiAutoKey, tsQuestionsS.iFraction FROM tsBaseS INNER JOIN tsEaxmination ON tsBaseS.tsEaxmination_iAutoKey = tsEaxmination.iAutoKey INNER JOIN tsBaseM ON tsBaseS.tsBaseM_iAutoKey = tsBaseM.iAutoKey INNER JOIN tsQuestionsS ON tsBaseM.tsQuestionsM_sCode = tsQuestionsS.tsQuestionsM_sCode AND tsBaseS.tsEaxmination_iAutoKey = tsQuestionsS.tsEaxmination_iAutoKey WHERE (tsEaxmination.tsCategory_sCode = @tsCategory_sCode) AND (tsBaseS.tsBaseM_iAutoKey = @tsBaseM_iAutoKey) ORDER BY NEWID()">
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
                                                        </div>
                                                        <asp:SqlDataSource ID="sdsCategory" runat="server" ConnectionString="<%$ ConnectionStrings:eLearning %>"
                                                            SelectCommand="SELECT (SELECT COUNT(*) AS sSn FROM tsCategory WHERE (sCode <= c1.sCode)) AS sSn, sCode, sName FROM tsCategory AS c1 WHERE (sCode IN (SELECT DISTINCT tsEaxmination.tsCategory_sCode FROM tsBaseS INNER JOIN tsEaxmination ON tsBaseS.tsEaxmination_iAutoKey = tsEaxmination.iAutoKey WHERE (tsBaseS.tsBaseM_iAutoKey = @tsBaseM_iAutoKey))) ORDER BY sCode">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblBaseMAutoKey" Name="tsBaseM_iAutoKey" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Label ID="lblCategoryCode" runat="server" Visible="False"></asp:Label><asp:Label
                                                            ID="lblEaxminationAutoKey" runat="server" Visible="False"></asp:Label></asp:View>
                                                    <asp:View ID="View2" runat="server">
                                                    </asp:View>
                                                    <asp:View ID="View3" runat="server">
                                                    </asp:View>
                                                </asp:MultiView>
                                            </asp:Panel>
                                        </div>
                                        <h4 class="mainfooter">
                                            <asp:Button ID="btnSubmit" runat="server" OnClick="btnSubmit_Click" OnClientClick="return confirm('您確定要交卷嗎？');"
                                                Text="交卷啦！" Visible="False" />
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
                <tr>
                    <td>
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
<asp:Content ID="cphR" ContentPlaceHolderID="cphR" runat="Server">
</asp:Content>
