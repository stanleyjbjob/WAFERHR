<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="TrainOut_Check"
    Culture="auto" meta:resourcekey="PageResource1" UICulture="auto" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>請假單---審核</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
        <div>
            <asp:ScriptManager ID="sm" runat="server">
            </asp:ScriptManager>
            <asp:UpdateProgress ID="up" runat="server">
                <ProgressTemplate>
                    <table id="loaderContainer" border="0" cellpadding="0" cellspacing="0" height="600"
                        onclick="return false;" width="800">
                        <tr>
                            <td id="loaderContainerWH">
                                <div id="loader">
                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td>
                                                <p>
                                                    <img id="IMG1" alt="" height="32" src="../images/loading.gif" width="32" /><strong>請稍後～<br />
                                                        資料連接中............</strong></p>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </td>
                        </tr>
                    </table>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <asp:Button ID="btnPrint" runat="server" CssClass="UltraWebGrid1-hc" OnClientClick="print();"
                Text="列印" meta:resourcekey="btnPrintResource1" />
            <asp:UpdatePanel ID="upl" runat="server">
                <ContentTemplate>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="center" class="style1" nowrap="nowrap">
                                外訓單審核</td>
                        </tr>
                        <tr>
                            <td align="center" nowrap="nowrap">
                                <table border="0" class="WebPanel2ctl" style="width: 100%" cellpadding="0" cellspacing="0">
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:FormView ID="fvAppM" runat="server" DataSourceID="sdsAppM" Width="100%" meta:resourcekey="fvAppMResource1">
                                                <ItemTemplate>
                                                    <table border="0" style="width: 100%">
                                                        <tr>
                                                            <td align="left" nowrap="nowrap" width="33%">
                                                                申請人資料</td>
                                                            <td align="center" nowrap="nowrap" width="34%">
                                                            </td>
                                                            <td align="right" nowrap="nowrap" width="33%">
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="left" nowrap="nowrap" width="33%">
                                                                單位：<asp:Label ID="d_nameLabel" runat="server" Font-Underline="True" Text='<%# Eval("sDeptName") %>'
                                                                    meta:resourcekey="d_nameLabelResource1"></asp:Label></td>
                                                            <td align="center" nowrap="nowrap" width="34%">
                                                                姓名：<asp:Label ID="name_cLabel" runat="server" Font-Underline="True" Text='<%# Eval("sName") %>'
                                                                    meta:resourcekey="name_cLabelResource1"></asp:Label></td>
                                                            <td align="right" nowrap="nowrap" width="33%">
                                                                工號：<asp:Label ID="NobrLabel" runat="server" Font-Underline="True" Text='<%# Eval("sNobr") %>'
                                                                    meta:resourcekey="NobrLabelResource1"></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                    <asp:Label ID="lblDept" runat="server" Font-Underline="True" Text='<%# Eval("sDept") %>'
                                                        Visible="False" meta:resourcekey="lblDeptResource1"></asp:Label>
                                                </ItemTemplate>
                                            </asp:FormView>
                                            <asp:SqlDataSource ID="sdsAppM" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                SelectCommand="SELECT * FROM [wfTrainAppM] WHERE ([sProcessID] = @sProcessID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                                        Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblProcessID" runat="server" Visible="False" meta:resourcekey="lblProcessIDResource1"></asp:Label><asp:Label ID="lblNobr" runat="server" Visible="False" meta:resourcekey="lblNobrResource1"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        <span style="font-size: 12pt; color: blue"><strong>受訓人員基本資料</strong></span></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None"
                                                            OnRowDataBound="gvAppS_RowDataBound" Width="100%" meta:resourcekey="gvAppSResource1"
                                                            DataKeyNames="iAutoKey" OnDataBound="gvAppS_DataBound">
                                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                            <Columns>
                                                                <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" meta:resourcekey="BoundFieldResource4">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" meta:resourcekey="BoundFieldResource5">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName"
                                                                    meta:resourcekey="BoundFieldResource7">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sJobName" HeaderText="職稱" SortExpression="sJobName" meta:resourcekey="BoundFieldResource9" />
                                                                <asp:BoundField DataField="iNum" HeaderText="前次派訓次數" SortExpression="iNum" />
                                                                <asp:BoundField DataField="iSum" HeaderText="前次累計金額" SortExpression="iSum" />
                                                                <asp:TemplateField meta:resourcekey="TemplateFieldResource1" HeaderText="主管核決">
                                                                    <ItemTemplate>
                                                                        <asp:RadioButtonList ID="rblSign" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow" OnSelectedIndexChanged="rblSign_SelectedIndexChanged" AutoPostBack="True">
                                                                            <asp:ListItem Value="1" Selected="True">核准</asp:ListItem>
                                                                            <asp:ListItem Value="0">駁回</asp:ListItem>
                                                                        </asp:RadioButtonList>
                                                                        <asp:Label ID="lblState" runat="server" Text="核准" Visible="False"></asp:Label>
                                                                        <asp:Label ID="lblSign" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle Wrap="False" />
                                                                    <HeaderStyle ForeColor="Red" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                                                            <EmptyDataTemplate>
                                                                目前沒有人請假。
                                                            </EmptyDataTemplate>
                                                            <EditRowStyle BackColor="#2461BF" />
                                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                                                            <AlternatingRowStyle BackColor="White" />
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            SelectCommand="SELECT * FROM [wfTrainAppS] WHERE ([sProcessID] = @sProcessID)">
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        <asp:Label ID="lblCountT" runat="server" Text="0" Visible="False"></asp:Label>
                                                        <asp:Label ID="lblCount" runat="server" Text="0" Visible="False"></asp:Label></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:LinkButton ID="lbtnFileManage" runat="server" CommandName="Download" ForeColor="Red"
                                                OnClick="lbtn_Click">相關受訓文件</asp:LinkButton></td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:Panel ID="pNote" runat="server" meta:resourcekey="pNoteResource1" Width="100%">
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td class="UltraWebGrid1-hc" style="text-align: center">
                                                            <strong><span style="font-size: 12pt; color: blue">簽核者資料</span></strong></td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="gvNote" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsSign" ForeColor="#333333"
                                                                GridLines="None" Width="100%" meta:resourcekey="gvNoteResource1">
                                                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" meta:resourcekey="BoundFieldResource44">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" meta:resourcekey="BoundFieldResource45">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept" meta:resourcekey="BoundFieldResource46">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName"
                                                                        meta:resourcekey="BoundFieldResource47">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="iBounty" HeaderText="公司負擔比例" SortExpression="iBounty" />
                                                                    <asp:BoundField DataField="sBakerday" HeaderText="心得分享日期" SortExpression="sBakerday" />
                                                                    <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" meta:resourcekey="BoundFieldResource48" />
                                                                    <asp:BoundField DataField="dKeyDate" HeaderText="簽核時間" SortExpression="dKeyDate"
                                                                        meta:resourcekey="BoundFieldResource50">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                                                                <EmptyDataTemplate>
                                                                    目前尚無任何簽核資料。
                                                                </EmptyDataTemplate>
                                                                <EditRowStyle BackColor="#2461BF" />
                                                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                                                                <AlternatingRowStyle BackColor="White" />
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="sdsSign" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                                SelectCommand="SELECT wfSign.iAutoKey, wfSign.sFromCode, wfSign.sFromName, wfSign.sProcessID, wfSign.idProcess, wfSign.sNobr, wfSign.sName, wfSign.sDept, wfSign.sDeptName, wfSign.sNote, wfSign.bSign, wfSign.sSign, wfSign.dKeyDate, wfTrainAppN.iBounty, wfTrainAppN.sBakerday FROM wfSign LEFT OUTER JOIN wfTrainAppN ON wfSign.sProcessID = wfTrainAppN.sProcessID WHERE (wfSign.sProcessID = @sProcessID) AND (wfSign.sFromCode = 'TrainOut')">
                                                                <SelectParameters>
                                                                    <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text" />
                                                                </SelectParameters>
                                                            </asp:SqlDataSource>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:FormView ID="fvApp" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsApp"
                                                Width="100%">
                                                <ItemTemplate>
                                                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap" width="1%">
                                                                <strong><span style="font-size: 12pt; color: blue">受訓相關資料</span></strong></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                申請日期</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="dDateLabel" runat="server" Text='<%# Bind("dDate", "{0:d}") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                課程名稱</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sCourseNameLabel" runat="server" Text='<%# Bind("sCourseName") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" rowspan="1" width="1%">
                                                                研習日期</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                從<asp:Label ID="dDateTimeBLabel" runat="server" Text='<%# Bind("dDateTimeB") %>'></asp:Label>到<asp:Label
                                                                    ID="dDateTimeELabel" runat="server" Text='<%# Bind("dDateTimeE") %>'></asp:Label>止，共<asp:Label
                                                                        ID="iTotalHoursLabel" runat="server" Text='<%# Bind("iTotalHours") %>'></asp:Label>小時</td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                上課地點</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sAddressLabel" runat="server" Text='<%# Bind("sAddress") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                主辦單位</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sCompanyLabel" runat="server" Text='<%# Bind("sCompany") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                派訓理由</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                &nbsp;<asp:Label ID="sAimLabel" runat="server" Text='<%# Bind("sAim") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                付款抬頭</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sCheckTitleLabel" runat="server" Text='<%# Bind("sCheckTitle") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                付款方式</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sPaymentLabel" runat="server" Text='<%# Bind("sPayment") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                匯款銀行</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sBankLabel" runat="server" Text='<%# Bind("sBank") %>'></asp:Label>分行<asp:Label
                                                                    ID="sBranchLabel" runat="server" Text='<%# Bind("sBranch") %>'></asp:Label>帳號<asp:Label
                                                                        ID="sAccountLabel" runat="server" Text='<%# Bind("sAccount") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                劃撥帳號</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sAllotLabel" runat="server" Text='<%# Bind("sAllot") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                憑證</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sCertificateLabel" runat="server" Text='<%# Bind("sCertificate") %>'></asp:Label></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                                報名方式</td>
                                                            <td colspan="3" nowrap="nowrap">
                                                                <asp:Label ID="sSignupLabel" runat="server" Text='<%# Bind("sSignup") %>'></asp:Label></td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:FormView>
                                            <asp:SqlDataSource ID="sdsApp" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                SelectCommand="SELECT * FROM [wfTrainAppM] WHERE ([sProcessID] = @sProcessID)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                                        Type="String" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:Panel ID="plSign" runat="server" Width="100%">
                                            <table cellpadding="0" cellspacing="0" width="100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc">
                                                        <span style="font-size: 12pt; color: red"><strong>主管簽註</strong></span></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <table cellpadding="0" cellspacing="0" width="100%">
                                                            <tr>
                                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                                全部費用</td>
                                                                <td nowrap="nowrap">
                                                                <asp:Label ID="lblCharge" runat="server"></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc">
                                                                    補助額度</td>
                                                                <td nowrap="nowrap">
                                                                    <asp:RadioButtonList ID="rblBounty" runat="server" AutoPostBack="True"
                                                                        RepeatDirection="Horizontal" RepeatLayout="Flow" OnSelectedIndexChanged="rblBounty_SelectedIndexChanged">
                                                                        <asp:ListItem Selected="True" Value="1">全額補助</asp:ListItem>
                                                                        <asp:ListItem Value="0">補助學雜費</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                    <asp:TextBox ID="txtBounty" runat="server" AutoPostBack="True" CssClass="txtBoxLine"
                                                                        MaxLength="3" meta:resourcekey="txtNameResource1"
                                                                        Width="20px" OnTextChanged="txtBounty_TextChanged"></asp:TextBox>％ ／原申請者提出補助學雜費
                                                                    <asp:Label ID="lblBounty" runat="server" Text="0" ForeColor="Blue"></asp:Label>
                                                                    ％／需付金額公司<asp:Label ID="lblPartCom" runat="server" Text="0" ForeColor="Red"></asp:Label>／個人<asp:Label
                                                                        ID="lblPartP" runat="server" Text="0" ForeColor="Red"></asp:Label><span style="color: #ff0000"></span></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc">
                                                                    研習心得分享日期</td>
                                                                <td nowrap="nowrap">
                                                                    <asp:RadioButtonList ID="rblBaker" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                                        <asp:ListItem Selected="True" Value="0">不必提出</asp:ListItem>
                                                                        <asp:ListItem Value="1">請於</asp:ListItem>
                                                                    </asp:RadioButtonList>
                                                                    <asp:TextBox ID="txtBaker" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                                        Style="left: 0px;"></asp:TextBox>部門會議提出報告</td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                                    合計</td>
                                                                <td nowrap="nowrap">
                                                                    <asp:Label ID="lblSum" runat="server" Text='<%# Bind("sReserve1") %>'></asp:Label></td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" class="UltraWebGrid1-hc" colspan="2" nowrap="nowrap">
                                                                    <strong><span style="font-size: 12pt; color: #ff0000">意見</span></strong></td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" nowrap="nowrap">
                                                        <asp:TextBox ID="txtNote" runat="server" Height="100px" TextMode="MultiLine" Width="100%"
                                                            meta:resourcekey="txtNoteResource1"></asp:TextBox></td>
                                                            </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                            </table>
                                            </asp:Panel>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblNote" runat="server" meta:resourcekey="lblNoteResource1"></asp:Label></td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:RadioButtonList ID="rblCheck" runat="server" Font-Size="X-Large" RepeatDirection="Horizontal"
                                    RepeatLayout="Flow" meta:resourcekey="rblCheckResource1">
                                    <asp:ListItem Selected="True" Value="1" meta:resourcekey="ListItemResource1" Text="繼續傳送"></asp:ListItem>
                                    <asp:ListItem Value="0" meta:resourcekey="ListItemResource2" Text="全部駁回"></asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Button ID="btnSign" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                    Font-Size="XX-Large" Font-Underline="False" ForeColor="Blue" OnClick="btnSign_Click"
                                    OnClientClick="return confirm('您確定要送出傳簽嗎？');" Text="送出傳簽" meta:resourcekey="btnSignResource1" />
                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red" meta:resourcekey="lblMsgResource1"></asp:Label></td>
                        </tr>
                    </table>
                    <asp:Label ID="lblUrl" runat="server" meta:resourcekey="lblUrlResource1"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
        </div>
    </form>
</body>
</html>
