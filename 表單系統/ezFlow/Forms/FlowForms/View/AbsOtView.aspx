<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AbsOtView.aspx.cs" Inherits="View_AbsOtView" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>請假加班查詢</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
            <asp:View ID="View1" runat="server">
                <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <asp:DropDownList ID="ddlDept" runat="server" DataSourceID="sdsDept" 
                                DataTextField="name" DataValueField="path">
                            </asp:DropDownList>
                            <asp:CheckBox ID="cbAll" runat="server" Text="包含子部門" />
                            <asp:Button ID="btnSearch" runat="server" Text="查詢" CssClass="UltraWebGrid1-hc" OnClick="btnSearch_Click" /><asp:SqlDataSource ID="sdsDept" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                SelectCommand="SELECT name, path FROM Dept WHERE (path LIKE (SELECT d.path FROM Role AS r INNER JOIN Dept AS d ON r.Dept_id = d.id WHERE (r.Emp_id = @Emp_id) AND (r.Dept_id NOT IN (SELECT sSubDept FROM SubWork WHERE (sNobr = r.Emp_id)))) + '%') UNION SELECT name, path FROM Dept AS Dept_1 WHERE (id IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = @Emp_id))) ORDER BY path">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblEmpID" Name="Emp_id" PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:Label ID="lblEmpID" runat="server" Visible="False"></asp:Label></td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                CellPadding="4" DataSourceID="sdsGV" ForeColor="#333333" GridLines="None" OnRowCommand="gv_RowCommand"
                                OnRowDataBound="gv_RowDataBound" Width="100%" DataKeyNames="id">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <Columns>
                                    <asp:TemplateField>
                                        <ItemStyle Width="1%" Wrap="False" />
                                        <ItemTemplate>
                                            <asp:Button ID="btnSelect" runat="server" CausesValidation="False" CommandArgument='<%# Eval("id") %>'
                                                CommandName="Select" CssClass="UltraWebGrid1-hc" Text="詳細資料" />
                                            <asp:Button ID="btnEat" runat="server" CausesValidation="False" 
                                                CommandArgument='<%# Eval("id") %>' CommandName="Eat" 
                                                CssClass="UltraWebGrid1-hc" Text="用餐時間" />
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("id") %>'
                                                CommandName="OtCalc" CssClass="UltraWebGrid1-hc" Text="加班統計" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="id" HeaderText="工號" SortExpression="id" />
                                    <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="name" />
                                    <asp:BoundField DataField="DeptID" HeaderText="傳簽代瑪" SortExpression="DeptID" />
                                    <asp:BoundField DataField="DeptName" HeaderText="傳簽考勤群組" SortExpression="DeptName" />
                                    <asp:TemplateField HeaderText="本日請假">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAbs" runat="server" Text="--"></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="False" />
                                <EditRowStyle BackColor="#2461BF" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                SelectCommand="SELECT Emp.id, Emp.name, Dept.id AS DeptID, Dept.name AS DeptName FROM Role INNER JOIN Emp ON Role.Emp_id = Emp.id INNER JOIN Dept ON Role.Dept_id = Dept.id">
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
                            <asp:Label ID="lblSql" runat="server" Visible="False"></asp:Label>
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View2" runat="server">
                <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="回查詢頁" CssClass="UltraWebGrid1-hc" />
                            <asp:Button ID="btnSwap" runat="server" OnClick="btnSwap_Click" Text="切換條列顯示" CssClass="UltraWebGrid1-hc" />
                            <asp:CheckBox ID="cbColor" runat="server" AutoPostBack="True" Checked="True" OnCheckedChanged="cbColor_CheckedChanged"
                                Text="套用彩色" />&nbsp;
                            <asp:Panel ID="plColor" runat="server" Width="100%">
                                班別：<asp:Label ID="lblRote" runat="server" BackColor="#FFC0C0" Font-Bold="True" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="50px"></asp:Label>
                                上下班時間：<asp:Label ID="lblTime" runat="server" BackColor="#FFFFC0" Font-Bold="True"
                                    Width="50px"></asp:Label>
                                刷卡時間：<asp:Label ID="lblT" runat="server" BackColor="#C0FFFF" Font-Bold="True" Width="50px"></asp:Label>
                                請假時間：<asp:Label ID="lblAbs" runat="server" BackColor="Red" Font-Bold="True" Width="50px"></asp:Label>
                                    加班時間：<asp:Label ID="lblOt" runat="server" BackColor="Yellow" Font-Bold="True" Width="50px"></asp:Label></asp:Panel>
                            <asp:FormView ID="fv" runat="server" DataSourceID="sdsFV" Width="100%">
                                <EditItemTemplate>
                                    NOBR:
                                    <asp:TextBox ID="NOBRTextBox" runat="server" Text='<%# Bind("NOBR") %>'>
									</asp:TextBox><br />
                                    NAME_C:
                                    <asp:TextBox ID="NAME_CTextBox" runat="server" Text='<%# Bind("NAME_C") %>'>
									</asp:TextBox><br />
                                    DEPT:
                                    <asp:TextBox ID="DEPTTextBox" runat="server" Text='<%# Bind("DEPT") %>'>
									</asp:TextBox><br />
                                    D_NAME:
                                    <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
									</asp:TextBox><br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="更新">
									</asp:LinkButton>
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="取消">
									</asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    NOBR:
                                    <asp:TextBox ID="NOBRTextBox" runat="server" Text='<%# Bind("NOBR") %>'>
									</asp:TextBox><br />
                                    NAME_C:
                                    <asp:TextBox ID="NAME_CTextBox" runat="server" Text='<%# Bind("NAME_C") %>'>
									</asp:TextBox><br />
                                    DEPT:
                                    <asp:TextBox ID="DEPTTextBox" runat="server" Text='<%# Bind("DEPT") %>'>
									</asp:TextBox><br />
                                    D_NAME:
                                    <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
									</asp:TextBox><br />
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                        Text="插入">
									</asp:LinkButton>
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="取消">
									</asp:LinkButton>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <table border="0" style="width: 100%">
                                        <tr>
                                            <td>
                                                工號：<asp:Label ID="lblNobr" runat="server" Text='<%# Eval("id") %>'></asp:Label></td>
                                            <td>
                                                姓名：<asp:Label ID="lblName_c" runat="server" Text='<%# Eval("name") %>'></asp:Label></td>
                                            <td>
                                                部門：<asp:Label ID="lblDept" runat="server" Text='<%# Eval("DeptName") %>'></asp:Label></td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                SelectCommand="SELECT Emp.id, Emp.name, Dept.name AS DeptName FROM Role INNER JOIN Dept ON Role.Dept_id = Dept.id INNER JOIN Emp ON Role.Emp_id = Emp.id WHERE (Emp.id = @id)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" Name="id" PropertyName="SelectedValue" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Calendar ID="cld" runat="server" BackColor="White" BorderColor="#3366CC" BorderWidth="1px"
                                CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="14pt"
                                ForeColor="#003399" OnDayRender="cld_DayRender" SelectionMode="None" Width="100%">
                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <TodayDayStyle BackColor="#99CCCC" ForeColor="Black" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <WeekendDayStyle BackColor="#CCCCFF" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
                                    Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            </asp:Calendar>
                        </td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View3" runat="server">
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td nowrap="nowrap">
                <asp:Button ID="Button1" runat="server" OnClick="btnBack_Click" Text="回查詢頁" CssClass="UltraWebGrid1-hc" />
                <asp:Button ID="btnSwap1" runat="server" OnClick="btnSwap1_Click" Text="切換行事曆顯示" CssClass="UltraWebGrid1-hc" /></td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-hc" nowrap="nowrap">
                            <strong>請假明細</strong></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CellPadding="4" DataSourceID="sdsGV1" ForeColor="#333333"
                        GridLines="None" PageSize="30" Width="100%" EnableModelValidation="True">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                        <Columns>
                            <asp:BoundField DataField="YYMM" HeaderText="計薪年月" SortExpression="YYMM" />
                            <asp:BoundField DataField="NOBR" HeaderText="工號" SortExpression="NOBR" />
                            <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                            <asp:BoundField DataField="D_NO" HeaderText="部門代碼" SortExpression="D_NO" />
                            <asp:BoundField DataField="D_NAME" HeaderText="部門名稱" SortExpression="D_NAME" />
                            <asp:BoundField DataField="BDATE" DataFormatString="{0:d}" HeaderText="請假開始日" HtmlEncode="False"
                                SortExpression="BDATE" />
                            <asp:BoundField DataField="BTIME" HeaderText="請假開始時間" SortExpression="BTIME" />
                            <asp:BoundField DataField="EDATE" DataFormatString="{0:d}" HeaderText="請假結束日" HtmlEncode="False"
                                SortExpression="EDATE" />
                            <asp:BoundField DataField="ETIME" HeaderText="請假結束時間" SortExpression="ETIME" />
                            <asp:BoundField DataField="H_NAME" HeaderText="假別" SortExpression="H_NAME" />
                            <asp:BoundField DataField="TOL_HOURS" HeaderText="時數" SortExpression="TOL_HOURS" />
                            <asp:BoundField DataField="UNIT" HeaderText="單位" SortExpression="UNIT" />
                            <asp:BoundField DataField="NOTE" HeaderText="備註" SortExpression="NOTE" />
                        </Columns>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <EditRowStyle BackColor="#2461BF" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                <asp:SqlDataSource ID="sdsGV1" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                SelectCommand="SELECT ABS_1.YYMM, ABS_1.NOBR, BASE.NAME_C, DEPT.D_NO, DEPT.D_NAME, ABS_1.BDATE, ABS_1.BTIME, ABS_1.EDATE, ABS_1.ETIME, HCODE.H_NAME, ABS_1.TOL_HOURS, HCODE.UNIT, ABS_1.NOTE FROM ABS AS ABS_1 INNER JOIN BASE ON ABS_1.NOBR = BASE.NOBR INNER JOIN BASETTS ON BASE.NOBR = BASETTS.NOBR INNER JOIN DEPT ON BASETTS.DEPT = DEPT.D_NO INNER JOIN HCODE ON ABS_1.H_CODE = HCODE.H_CODE WHERE (GETDATE() BETWEEN BASETTS.ADATE AND BASETTS.DDATE) AND (ABS_1.NOBR = @NOBR) AND (ABS_1.BDATE &gt;= '2007/12/26') AND (ABS_1.BDATE &lt;= GETDATE()) UNION SELECT ABS.YYMM, ABS.NOBR, BASE_1.NAME_C, DEPT_1.D_NO, DEPT_1.D_NAME, ABS.BDATE, ABS.BTIME, ABS.EDATE, ABS.ETIME, HCODE_1.H_NAME, ABS.TOL_HOURS, HCODE_1.UNIT, ABS.NOTE FROM ABS1 AS ABS INNER JOIN BASE AS BASE_1 ON ABS.NOBR = BASE_1.NOBR INNER JOIN BASETTS AS BASETTS_1 ON BASE_1.NOBR = BASETTS_1.NOBR INNER JOIN DEPT AS DEPT_1 ON BASETTS_1.DEPT = DEPT_1.D_NO INNER JOIN HCODE AS HCODE_1 ON ABS.H_CODE = HCODE_1.H_CODE WHERE (GETDATE() BETWEEN BASETTS_1.ADATE AND BASETTS_1.DDATE) AND (ABS.NOBR = @NOBR) AND (ABS.BDATE &gt;= '2007/12/26') AND (ABS.BDATE &lt;= GETDATE()) ORDER BY ABS_1.YYMM DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gv" Name="NOBR" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                        </td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-hc" nowrap="nowrap">
                            <strong>加班明細</strong></td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True"
                        AutoGenerateColumns="False" CellPadding="4" DataSourceID="sdsGV2" ForeColor="#333333"
                        GridLines="None" PageSize="30" Width="100%">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                                <Columns>
                                    <asp:BoundField DataField="YYMM" HeaderText="計薪年月" SortExpression="YYMM" />
                                    <asp:BoundField DataField="NOBR" HeaderText="工號" SortExpression="NOBR" />
                                    <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                                    <asp:BoundField DataField="D_NO" HeaderText="部門代碼" SortExpression="D_NO" />
                                    <asp:BoundField DataField="D_NAME" HeaderText="部門名稱" SortExpression="D_NAME" />
                                    <asp:BoundField DataField="BDATE" HeaderText="加班日期" SortExpression="BDATE" />
                                    <asp:BoundField DataField="BTIME" HeaderText="開始時間" SortExpression="BTIME" />
                                    <asp:BoundField DataField="ETIME" HeaderText="結束時間" SortExpression="ETIME" />
                                    <asp:BoundField DataField="OT_HRS" HeaderText="加班費時數" SortExpression="OT_HRS" />
                                    <asp:BoundField DataField="REST_HRS" HeaderText="補休假時數" SortExpression="REST_HRS" />
                                    <asp:BoundField DataField="NOTE" HeaderText="備註" SortExpression="NOTE" />
                                </Columns>
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                <EditRowStyle BackColor="#2461BF" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsGV2" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                SelectCommand="SELECT OT.NOBR, OT.BDATE, OT.BTIME, OT.ETIME, OT.TOT_HOURS, OT.OT_HRS, OT.REST_HRS, OT.NOTE, OT.YYMM, DEPT.D_NO, DEPT.D_NAME, BASE.NAME_C FROM BASE INNER JOIN BASETTS ON BASE.NOBR = BASETTS.NOBR INNER JOIN OT ON BASETTS.NOBR = OT.NOBR INNER JOIN DEPT ON BASETTS.DEPT = DEPT.D_NO WHERE (GETDATE() BETWEEN BASETTS.ADATE AND BASETTS.DDATE) AND (OT.BDATE >= '2007/12/26') AND (OT.NOBR = @NOBR)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="lblNobr" Name="NOBR" PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                &nbsp;&nbsp;
            </asp:View>
            <asp:View id="View4" runat="server"><asp:Button ID="Button3" runat="server" OnClick="btnBack_Click" Text="回查詢頁" CssClass="UltraWebGrid1-hc" />
                <asp:DropDownList id="ddlYYMM" runat="server"
                AutoPostBack="True" DataSourceID="sdsYYMM" DataTextField="YYMM" DataValueField="YYMM" AppendDataBoundItems="True" OnSelectedIndexChanged="ddlYYMM_SelectedIndexChanged">
                    <asp:ListItem Value="ALL">全部</asp:ListItem>
            </asp:DropDownList><asp:SqlDataSource id="sdsYYMM" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                SelectCommand="SELECT DISTINCT [YYMM] FROM [OT] ORDER BY [YYMM] DESC"></asp:SqlDataSource><asp:FormView ID="FV1" runat="server" DataSourceID="sdsFV1" Width="100%">
                    <EditItemTemplate>
                        NOBR:
                        <asp:TextBox ID="NOBRTextBox" runat="server" Text='<%# Bind("NOBR") %>'>
									</asp:TextBox><br />
                        NAME_C:
                        <asp:TextBox ID="NAME_CTextBox" runat="server" Text='<%# Bind("NAME_C") %>'>
									</asp:TextBox><br />
                        DEPT:
                        <asp:TextBox ID="DEPTTextBox" runat="server" Text='<%# Bind("DEPT") %>'>
									</asp:TextBox><br />
                        D_NAME:
                        <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
									</asp:TextBox><br />
                        <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                            Text="更新">
									</asp:LinkButton>
                        <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="取消">
									</asp:LinkButton>
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        NOBR:
                        <asp:TextBox ID="NOBRTextBox" runat="server" Text='<%# Bind("NOBR") %>'>
									</asp:TextBox><br />
                        NAME_C:
                        <asp:TextBox ID="NAME_CTextBox" runat="server" Text='<%# Bind("NAME_C") %>'>
									</asp:TextBox><br />
                        DEPT:
                        <asp:TextBox ID="DEPTTextBox" runat="server" Text='<%# Bind("DEPT") %>'>
									</asp:TextBox><br />
                        D_NAME:
                        <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
									</asp:TextBox><br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="插入">
									</asp:LinkButton>
                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="取消">
									</asp:LinkButton>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        <table border="0" style="width: 100%">
                            <tr>
                                <td>
                                    工號：<asp:Label ID="lblNobr" runat="server" Text='<%# Eval("id") %>'></asp:Label></td>
                                <td>
                                    姓名：<asp:Label ID="lblName_c" runat="server" Text='<%# Eval("name") %>'></asp:Label></td>
                                <td>
                                    部門：<asp:Label ID="lblDept" runat="server" Text='<%# Eval("DeptName") %>'></asp:Label></td>
                                <td>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView><asp:SqlDataSource ID="sdsFV1" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                SelectCommand="SELECT Emp.id, Emp.name, Dept.name AS DeptName FROM Role INNER JOIN Dept ON Role.Dept_id = Dept.id INNER JOIN Emp ON Role.Emp_id = Emp.id WHERE (Emp.id = @id)">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNobr" Name="id" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView
                    id="gvOT" runat="server" AutoGenerateColumns="False" CellPadding="4" DataSourceID="sdsOT"
                    ForeColor="#333333" GridLines="None" Width="100%" AllowSorting="True">
                    <footerstyle backcolor="#507CD1" font-bold="True" forecolor="White" />
                    <rowstyle backcolor="#EFF3FB" HorizontalAlign="Center" />
                    <columns>
                        <asp:BoundField DataField="YYMM" HeaderText="計薪年月" SortExpression="YYMM" />
<asp:BoundField DataField="OtFixed" HeaderText="固定加班" ReadOnly="True" SortExpression="OtFixed"></asp:BoundField>
<asp:BoundField DataField="Ot21th" HeaderText="第21天加班" ReadOnly="True" SortExpression="Ot21th"></asp:BoundField>
<asp:BoundField DataField="OtTyphoon" HeaderText="颱風加班" ReadOnly="True" SortExpression="OtTyphoon"></asp:BoundField>
<asp:BoundField DataField="OtOther" HeaderText="其他加班" ReadOnly="True" SortExpression="OtOther"></asp:BoundField>
                        <asp:TemplateField HeaderText="加班總計" SortExpression="OtTotal">
                            <EditItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("OtTotal") %>'></asp:Label>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAbs" runat="server" Text='<%# Eval("OtTotal") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
</columns>
                    <pagerstyle backcolor="#2461BF" forecolor="White" horizontalalign="Center" />
                    <selectedrowstyle backcolor="#D1DDF1" font-bold="True" forecolor="#333333" />
                    <headerstyle backcolor="#507CD1" font-bold="True" forecolor="White" HorizontalAlign="Center" />
                    <editrowstyle backcolor="#2461BF" />
                    <alternatingrowstyle backcolor="White" />
                    <EmptyDataTemplate>
                        此期間無加班紀錄
                    </EmptyDataTemplate>
                </asp:GridView>
                <asp:FormView ID="FormView1" runat="server" DataSourceID="sdsTotal" Width="100%">
                    <ItemTemplate>
                        <table align="center" width="100%">
                            <tr>
                                <td align="center" width="15%">
                                    總計：</td>
                                <td align="center" width="17%">
                                    <asp:Label ID="Label2" runat="server" Text='<%# Eval("OtFixed") %>'></asp:Label></td>
                                <td align="center" width="20%">
                                    <asp:Label ID="Label3" runat="server" Text='<%# Eval("Ot21th") %>'></asp:Label></td>
                                <td align="center" width="16%">
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("OtTyphoon") %>'></asp:Label></td>
                                <td align="center">
                                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("OtOther") %>'></asp:Label></td>
                                <td align="center">
                                    <asp:Label ID="Label6" runat="server" Text='<%# Eval("OtTotal") %>'></asp:Label></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsTotal" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                    SelectCommand="SELECT NOBR, SUM((OT_HRS + REST_HRS) * SYSCREAT) AS OtFixed, SUM((OT_HRS + REST_HRS) * SYSCREAT1) AS Ot21th, SUM((OT_HRS + REST_HRS) * SYS_OT) AS OtTyphoon, SUM((OT_HRS + REST_HRS) * (1 - SYSCREAT - SYSCREAT1 - SYS_OT)) AS OtOther, SUM(OT_HRS + REST_HRS) AS OtTotal FROM OT WHERE (NOBR = @NOBR) AND (YYMM = @YYMM OR @YYMM = 'ALL') GROUP BY NOBR">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lblNobr" Name="NOBR" PropertyName="Text" />
                        <asp:ControlParameter ControlID="ddlYYMM" Name="YYMM" PropertyName="SelectedValue" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource id="sdsOT" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                    SelectCommand="SELECT YYMM, NOBR, SUM((OT_HRS + REST_HRS) * SYSCREAT) AS OtFixed, SUM((OT_HRS + REST_HRS) * SYSCREAT1) AS Ot21th, SUM((OT_HRS + REST_HRS) * SYS_OT) AS OtTyphoon, SUM((OT_HRS + REST_HRS) * (1 - SYSCREAT - SYSCREAT1 - SYS_OT)) AS OtOther, SUM(OT_HRS + REST_HRS) AS OtTotal FROM OT WHERE (NOBR = @NOBR) AND (YYMM = @YYMM OR @YYMM = 'ALL') GROUP BY NOBR, YYMM">
                    <selectparameters>
<asp:ControlParameter ControlID="lblNobr" PropertyName="Text" Name="NOBR"></asp:ControlParameter>
<asp:ControlParameter ControlID="ddlYYMM" PropertyName="SelectedValue" Name="YYMM"></asp:ControlParameter>
</selectparameters>
                </asp:SqlDataSource>
                
            </asp:View><asp:View ID="View5" runat="server">


            <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td>
                            <asp:Button ID="Button4" runat="server" OnClick="btnBack_Click" Text="回查詢頁" CssClass="UltraWebGrid1-hc" />
                            <asp:Button ID="Button5" runat="server" OnClick="btnSwap_Click" Text="切換條列顯示" 
                                CssClass="UltraWebGrid1-hc" Visible="False" />
                            &nbsp;
                            <asp:Panel ID="Panel1" runat="server" Width="100%">
                                班別：<asp:Label ID="Label7" runat="server" BackColor="#FFC0C0" Font-Bold="True" Font-Overline="False"
                                    Font-Strikeout="False" Font-Underline="False" Width="50px"></asp:Label>
                                用餐時間：<asp:Label ID="Label8" runat="server" BackColor="#FFFFC0" Font-Bold="True"
                                    Width="50px"></asp:Label>
                                </asp:Panel>
                            <asp:FormView ID="FormView2" runat="server" DataSourceID="sdsFV" Width="100%">
                                <EditItemTemplate>
                                    NOBR:
                                    <asp:TextBox ID="NOBRTextBox" runat="server" Text='<%# Bind("NOBR") %>'>
									</asp:TextBox><br />
                                    NAME_C:
                                    <asp:TextBox ID="NAME_CTextBox" runat="server" Text='<%# Bind("NAME_C") %>'>
									</asp:TextBox><br />
                                    DEPT:
                                    <asp:TextBox ID="DEPTTextBox" runat="server" Text='<%# Bind("DEPT") %>'>
									</asp:TextBox><br />
                                    D_NAME:
                                    <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
									</asp:TextBox><br />
                                    <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                        Text="更新">
									</asp:LinkButton>
                                    <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="取消">
									</asp:LinkButton>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    NOBR:
                                    <asp:TextBox ID="NOBRTextBox" runat="server" Text='<%# Bind("NOBR") %>'>
									</asp:TextBox><br />
                                    NAME_C:
                                    <asp:TextBox ID="NAME_CTextBox" runat="server" Text='<%# Bind("NAME_C") %>'>
									</asp:TextBox><br />
                                    DEPT:
                                    <asp:TextBox ID="DEPTTextBox" runat="server" Text='<%# Bind("DEPT") %>'>
									</asp:TextBox><br />
                                    D_NAME:
                                    <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
									</asp:TextBox><br />
                                    <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                        Text="插入">
									</asp:LinkButton>
                                    <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                        Text="取消">
									</asp:LinkButton>
                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <table border="0" style="width: 100%">
                                        <tr>
                                            <td>
                                                工號：<asp:Label ID="lblNobr" runat="server" Text='<%# Eval("id") %>'></asp:Label></td>
                                            <td>
                                                姓名：<asp:Label ID="lblName_c" runat="server" Text='<%# Eval("name") %>'></asp:Label></td>
                                            <td>
                                                部門：<asp:Label ID="lblDept" runat="server" Text='<%# Eval("DeptName") %>'></asp:Label></td>
                                            <td>
                                            </td>
                                        </tr>
                                    </table>
                                </ItemTemplate>
                            </asp:FormView>
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Calendar ID="cldEat" runat="server" BackColor="White" 
                                BorderColor="#3366CC" BorderWidth="1px"
                                CellPadding="1" DayNameFormat="Shortest" Font-Names="Verdana" Font-Size="14pt"
                                ForeColor="#003399" OnDayRender="cldEat_DayRender" SelectionMode="None" 
                                Width="100%">
                                <SelectedDayStyle BackColor="#009999" Font-Bold="True" ForeColor="#CCFF99" />
                                <TodayDayStyle BackColor="#99CCCC" ForeColor="Black" />
                                <SelectorStyle BackColor="#99CCCC" ForeColor="#336666" />
                                <WeekendDayStyle BackColor="#CCCCFF" />
                                <OtherMonthDayStyle ForeColor="#999999" />
                                <NextPrevStyle Font-Size="8pt" ForeColor="#CCCCFF" />
                                <DayHeaderStyle BackColor="#99CCCC" ForeColor="#336666" Height="1px" />
                                <TitleStyle BackColor="#003399" BorderColor="#3366CC" BorderWidth="1px" Font-Bold="True"
                                    Font-Size="10pt" ForeColor="#CCCCFF" Height="25px" />
                            </asp:Calendar>
                        </td>
                    </tr>
                </table>
                </asp:View>
        </asp:MultiView></div>
    </form>
</body>
</html>
