<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="Absc_Std" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>銷假單---申請</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body>
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
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td align="center" class="style1" nowrap="nowrap">
                            銷假申請單</td>
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
                                        <asp:Label ID="lblEmpID" runat="server" Visible="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" colspan="7" nowrap="nowrap">
                                                    <span style="font-size: 12pt; color: blue"><strong>新增銷假人員</strong></span></td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    工號</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    姓名</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    請假日期</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    請假時間</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    假別</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    時數</td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="3" width="1%">
                                                    <asp:Button ID="btnAdd" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                                        Font-Size="XX-Large" ForeColor="Blue" Text="新增" OnClick="btnAdd_Click" /></td>
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
                                                    <asp:DropDownList ID="ddlDate" runat="server" DataSourceID="sdsDate" DataTextField="BDATE"
                                                        DataValueField="BDATE" AutoPostBack="True" OnSelectedIndexChanged="ddlDate_SelectedIndexChanged">
                                                    </asp:DropDownList></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlTime" runat="server" DataSourceID="sdsTime" DataTextField="TIME"
                                                        DataValueField="BTIME" AutoPostBack="True" OnSelectedIndexChanged="ddlTime_SelectedIndexChanged">
                                                    </asp:DropDownList></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:Label ID="lblHcode" runat="server"></asp:Label>&nbsp;</td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:Label ID="lblHours" runat="server"></asp:Label>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    事由</td>
                                                <td align="left" class="UltraWebGrid1-ic" colspan="5" nowrap="nowrap">
                                                    <asp:TextBox ID="txtNote" runat="server" CssClass="txtBoxLine" Width="95%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" colspan="7" nowrap="nowrap" style="text-align: left">
                                                    <asp:LinkButton ID="lbtnSignState" runat="server" CommandName="SignState" OnClick="lbtn_Click">歷史流程</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Emp.id AS Emp_id, Emp.name FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id WHERE (Role.Dept_id IN (SELECT sSubDept FROM SubWork WHERE (sNobr = @Emp_id))) UNION SELECT Role_2.Emp_id, Emp_2.name FROM Role AS Role_2 INNER JOIN Dept ON Role_2.Dept_id = Dept.id INNER JOIN Emp AS Emp_2 ON Role_2.Emp_id = Emp_2.id WHERE (Dept.path LIKE (SELECT Dept_1.path FROM Role AS Role_1 LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id LEFT OUTER JOIN Emp AS Emp_1 ON Role_1.Emp_id = Emp_1.id WHERE (Emp_1.id = @Emp_id) AND (Role_1.Dept_id NOT IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = Role_1.Emp_id)))) + '%') AND (GETDATE() BETWEEN Role_2.dateB AND Role_2.dateE)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblEmpID" Name="Emp_id" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsDate" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            
                                            SelectCommand="SELECT CONVERT (NVARCHAR, ABS_1.BDATE, 111) AS BDATE FROM ABS AS ABS_1 INNER JOIN HCODE ON ABS_1.H_CODE = HCODE.H_CODE WHERE (ABS_1.NOBR = @NOBR) AND (ABS_1.YYMM NOT IN (SELECT YYMM FROM LOCK_WAGE WHERE (SALADR = 'A') AND (SEQ = '2'))) AND (HCODE.YEAR_REST NOT IN ('1', '3', '5')) AND (ABS_1.H_CODE NOT LIKE 'W%') GROUP BY ABS_1.BDATE UNION SELECT CONVERT (NVARCHAR, ABS.BDATE, 111) AS BDATE FROM ABS1 AS ABS INNER JOIN HCODE AS HCODE_1 ON ABS.H_CODE = HCODE_1.H_CODE WHERE (ABS.NOBR = @NOBR) AND (ABS.YYMM NOT IN (SELECT YYMM FROM LOCK_WAGE AS LOCK_WAGE_1 WHERE (SALADR = 'A') AND (SEQ = '2'))) GROUP BY ABS.BDATE ORDER BY BDATE DESC">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblNobr" Name="NOBR" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsTime" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT RTRIM(BTIME) AS BTIME, RTRIM(BTIME) + '-' + RTRIM(ETIME) AS TIME FROM ABS AS ABS_1 WHERE (NOBR = @NOBR) AND (BDATE = @BDATE) UNION SELECT RTRIM(BTIME) AS BTIME, RTRIM(BTIME) + '-' + RTRIM(ETIME) AS TIME FROM ABS1 AS ABS WHERE (NOBR = @NOBR) AND (BDATE = @BDATE) ORDER BY BTIME DESC">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblNobr" Name="NOBR" PropertyName="Text" />
                                                <asp:ControlParameter ControlID="ddlDate" Name="BDATE" PropertyName="SelectedValue" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <asp:Panel ID="plAppS" runat="server" Height="100%" Width="100%">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        <strong><span style="font-size: 12pt; color: blue">銷假人員基本資料</span></strong></td>
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
                                                                <asp:BoundField DataField="dStrDateFull" HeaderText="開始日期時間" SortExpression="dStrDateFull" />
                                                                <asp:BoundField DataField="dEndDateFull" HeaderText="結束日期時間" SortExpression="dEndDateFull" />
                                                                <asp:BoundField DataField="sHname" HeaderText="假別" SortExpression="sHname" />
                                                                <asp:BoundField DataField="iTotalDay" HeaderText="天數" SortExpression="iTotalDay" />
                                                                <asp:BoundField DataField="iTotalHour" HeaderText="時數" SortExpression="iTotalHour" />
                                                                <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
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
                                                            DeleteCommand="DELETE FROM [wfAbscAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfAbscAppS] WHERE ([sProcessID] = @sProcessID)">
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
                                Font-Size="XX-Large" Font-Underline="False" ForeColor="Blue"
                                OnClientClick="return confirm('您確定要送出傳簽嗎？');" Text="送出傳簽" OnClick="btnSign_Click" />
                            <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
                    </tr>
                </table>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
