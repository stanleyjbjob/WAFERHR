<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="Abs_Std" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>請假單---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
    <script language="JavaScript" src="../webdosform.js"></script>
    <script language="JavaScript" src="../webdosform_aspwizard.js"></script>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="sm" runat="server" EnableScriptGlobalization="True">
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
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td nowrap="nowrap" style="text-align: right">
                            <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl="~/Abs/Desc.htm" Target="_blank"
                                Font-Bold="True" ForeColor="Red">使用說明</asp:HyperLink>
                        </td>
                    </tr>
                    <tr>
                        <td align="center" class="style1" nowrap="nowrap">
                            請假申請單
                        </td>
                    </tr>
                    <tr>
                        <td align="center" nowrap="nowrap">
                            <table border="0" class="WebPanel2ctl" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <asp:FormView ID="fvAppM" runat="server" DataSourceID="sdsAppM" Width="100%">
                                            <ItemTemplate>
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td align="left" class="WebPanel2hdrxpnd " nowrap="nowrap" width="33%">
                                                            申請人資料
                                                        </td>
                                                        <td align="center" class="WebPanel2hdrxpnd " nowrap="nowrap" width="34%">
                                                        </td>
                                                        <td align="right" class="WebPanel2hdrxpnd " nowrap="nowrap" width="33%">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" class="WebPanel2hdrxpnd " nowrap="nowrap" width="33%">
                                                            單位：<asp:Label ID="d_nameLabel" runat="server" Font-Underline="True" Text='<%# Eval("Dept_Name") %>'></asp:Label>
                                                        </td>
                                                        <td align="center" class="WebPanel2hdrxpnd " nowrap="nowrap" width="34%">
                                                            姓名：<asp:Label ID="name_cLabel" runat="server" Font-Underline="True" Text='<%# Eval("name") %>'></asp:Label>
                                                        </td>
                                                        <td align="right" class="WebPanel2hdrxpnd " nowrap="nowrap" width="33%">
                                                            工號：<asp:Label ID="NobrLabel" runat="server" Font-Underline="True" Text='<%# Eval("Emp_id") %>'></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                                <asp:Label ID="lblDept" runat="server" Font-Underline="True" Text='<%# Eval("Dept_id") %>'
                                                    Visible="False"></asp:Label>
                                            </ItemTemplate>
                                        </asp:FormView>
                                        <asp:SqlDataSource ID="sdsAppM" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Role.Emp_id, Emp.pw, Emp.name, Emp.email, Emp.login, Emp.sex, Role.Dept_id, Dept.name AS Dept_Name, Role.Pos_id, Pos.name AS Pos_Name, Dept.path, Role.dateB, Role.dateE, Role.mgDefault, Role.deptMg, Role.id FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id INNER JOIN Pos ON Role.Pos_id = Pos.id INNER JOIN Dept ON Role.Dept_id = Dept.id WHERE (Role.Emp_id = @Emp_id)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblEmpID" Name="Emp_id" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label>
                                        <asp:Label ID="lblRote" runat="server" Visible="False"></asp:Label>
                                        <asp:Label ID="lblEmpID" runat="server" Visible="False"></asp:Label>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" colspan="6" nowrap="nowrap">
                                                    <span style="font-size: 12pt; color: blue"><strong>新增請假人員</strong></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    工號
                                                </td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    姓名
                                                </td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    假別
                                                </td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    起迄時間
                                                </td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    職務代理人
                                                </td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="3" width="1%">
                                                    <asp:Button ID="btnAdd" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                                        Font-Size="XX-Large" ForeColor="Blue" OnClick="btnAdd_Click" Text="新增" />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:Label ID="lblNobr" runat="server">00000</asp:Label>
                                                </td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlName" runat="server" AutoPostBack="True" DataSourceID="sdsName"
                                                        DataTextField="name" DataValueField="Emp_id" OnSelectedIndexChanged="ddlName_SelectedIndexChanged"
                                                        OnDataBound="ddlName_DataBound">
                                                    </asp:DropDownList>
                                                    ,<asp:TextBox ID="txtName" runat="server" AutoPostBack="True" CssClass="txtBoxLine"
                                                        OnTextChanged="txtName_TextChanged" Width="70px"></asp:TextBox>
                                                </td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlHcode" runat="server" DataSourceID="sdsHcode" DataTextField="h_name"
                                                        DataValueField="h_code" AutoPostBack="True" OnSelectedIndexChanged="ddlHcode_SelectedIndexChanged">
                                                    </asp:DropDownList>
                                                    <asp:DropDownList ID="ddlAname" runat="server">
                                                    </asp:DropDownList>
                                                </td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    自<asp:TextBox ID="txtDateB" runat="server" AutoPostBack="True" CssClass="txtBoxLine"
                                                        OnTextChanged="txtDate_TextChanged" Width="95px" ToolTip="yyyy/MM/dd"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateB" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />
                                                    <asp:TextBox ID="txtTimeB" runat="server" CssClass="txtBoxLine" MaxLength="4" Width="40px">0000</asp:TextBox><br />
                                                    至<asp:TextBox ID="txtDateE" runat="server" CssClass="txtBoxLine" OnTextChanged="txtDate_TextChanged"
                                                        Width="95px" ToolTip="yyyy/MM/dd"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateE" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png">
                                                    </asp:ImageButton>
                                                    <asp:TextBox ID="txtTimeE" runat="server" CssClass="txtBoxLine" MaxLength="4" Width="40px">0000</asp:TextBox>
                                                </td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlAgent" runat="server" AutoPostBack="True" DataSourceID="sdsName"
                                                        DataTextField="name" DataValueField="Emp_id" OnSelectedIndexChanged="ddlAgent_SelectedIndexChanged"
                                                        OnDataBound="ddlAgent_DataBound" AppendDataBoundItems="True">
                                                        <asp:ListItem Value="0">請選擇</asp:ListItem>
                                                    </asp:DropDownList>
                                                    ,<asp:TextBox ID="txtAgent" runat="server" AutoPostBack="True" CssClass="txtBoxLine"
                                                        Width="70px" OnTextChanged="txtAgent_TextChanged"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <span style="font-size: 12pt">事由</span>
                                                </td>
                                                <td align="left" class="UltraWebGrid1-ic" colspan="4" nowrap="nowrap">
                                                    <asp:TextBox ID="txtNote" runat="server" CssClass="txtBoxLine" Width="95%"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" colspan="6" nowrap="nowrap" style="text-align: left">
                                                                                          <asp:Panel ID="plCheck" runat="server" Visible="False">
                                            <asp:Panel ID="plTxt1" runat="server" Visible="False">
                                                本人願意接受公司勞資會議協調結果，配合公司進行排休調整，但因今年特補休皆已用罄，自願申請預借 明年特休時數，如因故提前離職，願依公司規定辦理。
                                            </asp:Panel>
                                            <asp:Panel ID="plTxt2" runat="server" Visible="False">
                                                本人願意接受公司勞資會議協調結果，配合公司進行排休調整，因特補休假不足，願請不計薪假。
                                            </asp:Panel>
                                            <asp:RadioButtonList ID="rblCheck" runat="server">
                                                <asp:ListItem Value="1">本人願意並提出申請 </asp:ListItem>
                                                <asp:ListItem Value="2">本人不願意提出申請 </asp:ListItem>
                                                <asp:ListItem Value="3">向人資單位反應</asp:ListItem>
                                            </asp:RadioButtonList>
                                                                                              意見：<asp:TextBox ID="txtCheck" runat="server" CssClass="txtBoxLine" Width="80%"></asp:TextBox>
                                                                                              <br />
                                                                                              備註：上述選項勾選完成後，請按新增，方可送出傳簽</asp:Panel>
                                                </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" colspan="6" nowrap="nowrap" style="text-align: left">
                                                        <asp:GridView ID="gvInfo" runat="server" CellPadding="4" ForeColor="#333333" GridLines="None">
                                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Right" />
                                                            <EditRowStyle BackColor="#2461BF" />
                                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Right" />
                                                            <AlternatingRowStyle BackColor="White" />
                                                        </asp:GridView>
                                                        <span style="color: red"> ※某些假別會合併計算剩餘時數，例如病假會併生理假。</span>
                                                    </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" colspan="6" nowrap="nowrap" style="text-align: left">
                                                    <asp:LinkButton ID="lbtnSignState" runat="server" CommandName="SignState" OnClick="lbtn_Click">歷史流程</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnHoliday" runat="server" OnClick="lbtnHoliday_Click">個人行事曆</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnOt" runat="server" OnClick="lbtnOt_Click">補休資料</asp:LinkButton>
                                                    <span style="color: red">
                                                    <asp:Label ID="lblOldHour" runat="server" Visible="False"></asp:Label>
                                                    </span>
                                                </td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Emp.id AS Emp_id, Emp.name FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id WHERE (Role.Dept_id IN (SELECT sSubDept FROM SubWork WHERE (sNobr = @Emp_id))) UNION SELECT Role_2.Emp_id, Emp_2.name FROM Role AS Role_2 INNER JOIN Dept ON Role_2.Dept_id = Dept.id INNER JOIN Emp AS Emp_2 ON Role_2.Emp_id = Emp_2.id WHERE (Dept.path LIKE (SELECT TOP (1) Dept_1.path FROM Role AS Role_1 LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id LEFT OUTER JOIN Emp AS Emp_1 ON Role_1.Emp_id = Emp_1.id WHERE (Emp_1.id = @Emp_id) AND (Role_1.Dept_id NOT IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = Role_1.Emp_id)))) + '%') AND (GETDATE() BETWEEN Role_2.dateB AND Role_2.dateE)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblEmpID" Name="Emp_id" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsHcode" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT RTRIM(H_CODE) AS h_code, RTRIM(H_NAME) AS h_name FROM HCODE WHERE (NOT_DEL <> 1) AND (YEAR_REST IN ('0', '2', '4', '6')) ORDER BY H_CODE">
                                        </asp:SqlDataSource>
                                        <AjaxControlToolkit:MaskedEditExtender AcceptNegative="Left" DisplayMoney="Left"
                                            ID="meeDateB" Mask="9999/99/99" MaskType="Date" runat="server" TargetControlID="txtDateB"
                                            Enabled="True">
                                        </AjaxControlToolkit:MaskedEditExtender>
                                        <AjaxControlToolkit:MaskedEditExtender AcceptNegative="Left" DisplayMoney="Left"
                                            ID="meeDateE" Mask="9999/99/99" MaskType="Date" runat="server" TargetControlID="txtDateE">
                                        </AjaxControlToolkit:MaskedEditExtender>
                                        <AjaxControlToolkit:CalendarExtender Format="yyyy/MM/dd" ID="ceDateB" PopupButtonID="ibtnDateB"
                                            runat="server" TargetControlID="txtDateB">
                                        </AjaxControlToolkit:CalendarExtender>
                                        <AjaxControlToolkit:CalendarExtender ID="ceDateE" runat="server" Format="yyyy/MM/dd"
                                            PopupButtonID="ibtnDateE" TargetControlID="txtDateE">
                                        </AjaxControlToolkit:CalendarExtender>
                                        <AjaxControlToolkit:MaskedEditExtender AcceptNegative="Left" DisplayMoney="Left"
                                            ID="meeTimeB" Mask="9999" MaskType="None" runat="server" TargetControlID="txtTimeB">
                                        </AjaxControlToolkit:MaskedEditExtender>
                                        <AjaxControlToolkit:MaskedEditExtender AcceptNegative="Left" DisplayMoney="Left"
                                            ID="meeTimeE" Mask="9999" MaskType="None" runat="server" TargetControlID="txtTimeE">
                                        </AjaxControlToolkit:MaskedEditExtender>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <asp:Panel ID="plAppS" runat="server" Height="100%" Width="100%">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        <strong><span style="font-size: 12pt; color: blue">請假人員基本資料</span></strong>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None" Width="100%"
                                                            OnRowCommand="gvAppS_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemStyle Width="1%" Wrap="False" />
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Del"
                                                                            OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" CommandArgument='<%# Eval("iAutoKey") %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                                                <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sDept" HeaderText="sDept" SortExpression="sDept" Visible="False" />
                                                                <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" />
                                                                <asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" />
                                                                <asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sEmpcd" HeaderText="sEmpcd" SortExpression="sEmpcd" Visible="False" />
                                                                <asp:BoundField DataField="sEmpcdName" HeaderText="sEmpcdName" SortExpression="sEmpcdName"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="dStrDateFull" HeaderText="開始日期及時間" SortExpression="dStrDateFull">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="dEndDateFull" HeaderText="結束日期及時間" SortExpression="dEndDateFull">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="dStrDate" DataFormatString="{0:d}" HeaderText="開始日期" HtmlEncode="False"
                                                                    SortExpression="dStrDate" Visible="False">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="dEndDate" DataFormatString="{0:d}" HeaderText="結束日期" HtmlEncode="False"
                                                                    SortExpression="dEndDate" Visible="False">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sStrTime" HeaderText="開始時間" SortExpression="sStrTime"
                                                                    Visible="False">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sEndTime" HeaderText="結束時間" SortExpression="sEndTime"
                                                                    Visible="False">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sHcode" HeaderText="sHcode" SortExpression="sHcode" Visible="False" />
                                                                <asp:BoundField DataField="sHname" HeaderText="假別" SortExpression="sHname">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="iDay" HeaderText="天數" SortExpression="iDay">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="iHour" HeaderText="時數" SortExpression="iHour">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="iTotalDay" HeaderText="iTotalDay" SortExpression="iTotalDay"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="iTotalHour" HeaderText="iTotalHour" SortExpression="iTotalHour"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sReserve1" HeaderText="sReserve1" SortExpression="sReserve1"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sReserve2" HeaderText="sReserve2" SortExpression="sReserve2"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sReserve3" HeaderText="sReserve3" SortExpression="sReserve3"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sSalYYMM" HeaderText="sSalYYMM" SortExpression="sSalYYMM"
                                                                    Visible="False" />
                                                                <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
                                                                <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
                                                                <asp:BoundField DataField="sAgentNobr1" HeaderText="sAgentNobr1" SortExpression="sAgentNobr1"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sAgentName1" HeaderText="代理人" SortExpression="sAgentName1">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sAgentNobr2" HeaderText="sAgentNobr2" SortExpression="sAgentNobr2"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sAgentName2" HeaderText="知會人" SortExpression="sAgentName2"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sAgentNobr3" HeaderText="sAgentNobr3" SortExpression="sAgentNobr3"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sAgentName3" HeaderText="sAgentName3" SortExpression="sAgentName3"
                                                                    Visible="False" />
                                                                <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                                                                <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                                                                <asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate"
                                                                    Visible="False" />
                                                                <asp:TemplateField HeaderText="檔案管理" Visible="False">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnUpload" runat="server" CommandArgument='<%# Eval("sNobr") %>'
                                                                            CommandName="Upload">上傳檔案</asp:LinkButton>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Center" Width="1%" Wrap="False" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                            <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                                                            <EditRowStyle BackColor="#2461BF" />
                                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                            <AlternatingRowStyle BackColor="White" />
                                                            <EmptyDataTemplate>
                                                                目前沒有人請假。
                                                            </EmptyDataTemplate>
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            DeleteCommand="DELETE FROM [wfAbsAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfAbsAppS] WHERE ([sProcessID] = @sProcessID)">
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </DeleteParameters>
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text"
                                                                    Type="String" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                    </td>
                                                </tr>
                                            </table>
                                        </asp:Panel>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <asp:Label ID="lblNote" runat="server"></asp:Label>
                                    </td>
                                </tr>

                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:Button ID="btnSign" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                Font-Size="XX-Large" Font-Underline="False" ForeColor="Blue" OnClick="btnSign_Click"
                                OnClientClick="return confirm('您確定要送出傳簽嗎？');" Text="送出傳簽" />
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
                        </td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
        <br />
    </div>
    </form>
</body>
</html>
