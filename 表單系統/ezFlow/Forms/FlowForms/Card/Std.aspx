<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="Card_Std" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>忘刷單---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
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
                        <td align="center" class="style1" nowrap="nowrap">
                            忘刷申請單</td>
                    </tr>
                    <tr>
                        <td align="center" nowrap="nowrap">
                            <table border="0" cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                                <tr>
                                    <td align="left">
                                        <asp:FormView ID="fvAppM" runat="server" DataSourceID="sdsAppM" Width="100%">
                                            <ItemTemplate>
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td align="left" class="WebPanel2hdrxpnd border" nowrap="nowrap" width="33%">
                                                            申請人資料</td>
                                                        <td align="center" class="WebPanel2hdrxpnd border" nowrap="nowrap" width="34%">
                                                        </td>
                                                        <td align="right" class="WebPanel2hdrxpnd border" nowrap="nowrap" width="33%">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" class="WebPanel2hdrxpnd border" nowrap="nowrap" width="33%">
                                                            單位：<asp:Label ID="d_nameLabel" runat="server" Font-Underline="True" Text='<%# Eval("Dept_Name") %>'></asp:Label></td>
                                                        <td align="center" class="WebPanel2hdrxpnd border" nowrap="nowrap" width="34%">
                                                            姓名：<asp:Label ID="name_cLabel" runat="server" Font-Underline="True" Text='<%# Eval("name") %>'></asp:Label></td>
                                                        <td align="right" class="WebPanel2hdrxpnd border" nowrap="nowrap" width="33%">
                                                            工號：<asp:Label ID="NobrLabel" runat="server" Font-Underline="True" Text='<%# Eval("Emp_id") %>'></asp:Label></td>
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
                                        <asp:Label ID="lblDate" runat="server" Visible="False"></asp:Label>
                                        <asp:Label ID="lblEmpID" runat="server" Visible="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" colspan="5" nowrap="nowrap">
                                                    <span style="font-size: 12pt; color: blue"><strong>新增忘刷人員</strong></span></td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    工號</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    姓名</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    &nbsp;忘刷日期</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    忘刷時間</td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="3" width="1%">
                                                    <asp:Button ID="btnAdd" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                                        Font-Size="XX-Large" ForeColor="Blue" OnClick="btnAdd_Click" Text="新增" /></td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:Label ID="lblNobr" runat="server">00000</asp:Label></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlName" runat="server" AutoPostBack="True" DataSourceID="sdsName"
                                                        DataTextField="name" DataValueField="Emp_id" OnSelectedIndexChanged="ddlName_SelectedIndexChanged" OnDataBound="ddlName_DataBound">
                                                    </asp:DropDownList>,<asp:TextBox ID="txtName" runat="server" AutoPostBack="True"
                                                        CssClass="txtBoxLine" OnTextChanged="txtName_TextChanged" Width="70px"></asp:TextBox>
                                                </td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlDate" runat="server" AutoPostBack="True" DataSourceID="sdsDate"
                                                        DataTextField="ADATE" DataValueField="ADATE" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged" AppendDataBoundItems="True" Visible="False">
                                                        <asp:ListItem Value="0">自訂日期</asp:ListItem>
                                                    </asp:DropDownList>
                                                    <asp:TextBox ID="txtDate" runat="server" CssClass="txtBoxLine" OnTextChanged="txtDate_TextChanged"
                                                        Width="95px" AutoPostBack="True">9999/12/31</asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateB" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" /></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:TextBox ID="txtTime" runat="server" CssClass="txtBoxLine" MaxLength="4" Width="40px">0000</asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    事由</td>
                                                <td align="left" class="UltraWebGrid1-ic" colspan="3" nowrap="nowrap">
													<asp:DropDownList ID="ddlNote" runat="server" DataSourceID="sdsNote" DataTextField="DESCR"
														DataValueField="CODE">
													</asp:DropDownList><asp:TextBox ID="txtNote" runat="server" CssClass="txtBoxLine" Width="60%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" colspan="5" nowrap="nowrap" style="text-align: left">
                                                    <asp:LinkButton ID="lbtnSignState" runat="server" CommandName="SignState" OnClick="lbtn_Click">歷史流程</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnHoliday" runat="server" OnClick="lbtnHoliday_Click">個人行事曆</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Emp.id AS Emp_id, Emp.name FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id WHERE (Role.Dept_id IN (SELECT sSubDept FROM SubWork WHERE (sNobr = @Emp_id))) UNION SELECT Role_2.Emp_id, Emp_2.name FROM Role AS Role_2 INNER JOIN Dept ON Role_2.Dept_id = Dept.id INNER JOIN Emp AS Emp_2 ON Role_2.Emp_id = Emp_2.id WHERE (Dept.path LIKE (SELECT Dept_1.path FROM Role AS Role_1 LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id LEFT OUTER JOIN Emp AS Emp_1 ON Role_1.Emp_id = Emp_1.id WHERE (Emp_1.id = @Emp_id) AND (Role_1.Dept_id NOT IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = Role_1.Emp_id)))) + '%') AND (GETDATE() BETWEEN Role_2.dateB AND Role_2.dateE)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblEmpID" Name="Emp_id" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsDate" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT CONVERT (NVARCHAR, ADATE, 111) AS ADATE FROM ATTEND WHERE (ADATE BETWEEN @BDATE AND GETDATE()) AND (NOBR = @NOBR) AND (ROTE <> @ROTE) AND ((SELECT COUNT(*) AS c FROM CARD WHERE (NOBR = ATTEND.NOBR) AND (ADATE = ATTEND.ADATE)) < 10) ORDER BY ADATE DESC">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblDate" Name="BDATE" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="lblNobr" Name="NOBR" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="lblRote" Name="ROTE" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
										<asp:SqlDataSource ID="sdsNote" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
											
                                            SelectCommand="SELECT RTRIM(CODE) AS CODE, RTRIM(DESCR) AS DESCR FROM CARDLOSD WHERE (SORT &gt; 0) ORDER BY SORT">
										</asp:SqlDataSource>
                                        <AjaxControlToolkit:MaskedEditExtender ID="meeDateB" runat="server" AcceptNegative="Left"
                                            DisplayMoney="Left" Mask="9999/99/99" MaskType="Date" TargetControlID="txtDate">
                                        </AjaxControlToolkit:MaskedEditExtender>
                                        <AjaxControlToolkit:CalendarExtender ID="ceDateB" runat="server" Format="yyyy/MM/dd"
                                            PopupButtonID="ibtnDateB" TargetControlID="txtDate">
                                        </AjaxControlToolkit:CalendarExtender>
                                        <AjaxControlToolkit:MaskedEditExtender ID="meeTimeB" runat="server" AcceptNegative="Left"
                                            DisplayMoney="Left" Mask="9999" MaskType="None" TargetControlID="txtTime">
                                        </AjaxControlToolkit:MaskedEditExtender>
                                        &nbsp;
										&nbsp;&nbsp;
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <asp:Panel ID="plAppS" runat="server" Height="100%" Width="100%">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        <strong><span style="font-size: 12pt; color: blue">忘刷人員基本資料</span></strong></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None" OnRowCommand="gvAppS_RowCommand"
                                                            Width="100%">
                                                            <Columns>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemStyle Width="1%" Wrap="False" />
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="Del" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                                                <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                                                                <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                                                                <asp:BoundField DataField="sDept" HeaderText="sDept" SortExpression="sDept" Visible="False" />
                                                                <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName" />
                                                                <asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" />
                                                                <asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" />
                                                                <asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sEmpcd" HeaderText="sEmpcd" SortExpression="sEmpcd" Visible="False" />
                                                                <asp:BoundField DataField="sEmpcdName" HeaderText="sEmpcdName" SortExpression="sEmpcdName"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="dDateTime" HeaderText="日期時間" SortExpression="dDateTime" />
                                                                <asp:BoundField DataField="sReserve3" HeaderText="sReserve3" SortExpression="sReserve3"
                                                                    Visible="False" />
                                                                <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
                                                                <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
                                                                <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                                                                <asp:BoundField DataField="sReserve2" HeaderText="原因代碼" SortExpression="sReserve2"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="sReserve1" HeaderText="原因" SortExpression="sReserve1" />
                                                                <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                                                                <asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate"
                                                                    Visible="False" />
                                                                <asp:BoundField DataField="iTime" HeaderText="iTime" SortExpression="iTime" Visible="False" />
                                                                <asp:TemplateField HeaderText="檔案管理" Visible="False">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnUpload" runat="server" CommandArgument='<%# Eval("sNobr") %>'
                                                                            CommandName="Upload">上傳檔案</asp:LinkButton>
                                                                    </ItemTemplate>
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
                                                                目前沒有人銷假。
                                                            </EmptyDataTemplate>
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            DeleteCommand="DELETE FROM [wfCardAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfCardAppS] WHERE ([sProcessID] = @sProcessID)">
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </DeleteParameters>
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
                                    <td align="left">
                                        <asp:Label ID="lblNote" runat="server"></asp:Label></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:Button ID="btnSign" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                Font-Size="XX-Large" Font-Underline="False" ForeColor="Blue" OnClick="btnSign_Click"
                                OnClientClick="return confirm('您確定要送出傳簽嗎？');" Text="送出傳簽" />
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
