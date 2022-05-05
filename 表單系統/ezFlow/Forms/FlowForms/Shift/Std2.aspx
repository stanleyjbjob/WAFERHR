<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std2.aspx.cs" Inherits="Shift_Std2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>調班單---申請</title>
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
        <asp:UpdatePanel ID="upl" runat="server"><ContentTemplate>
<table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td align="center" nowrap="nowrap" class="style1">調班申請單</td></tr><tr><td align="center" nowrap="nowrap"><table border="0" style="width: 100%" class="WebPanel2ctl" cellpadding="0" cellspacing="0"><tr><td align="center" style="text-align: left"><asp:FormView ID="fvAppM" runat="server" DataSourceID="sdsAppM" Width="100%">
                                            <ItemTemplate>
                                                <table border="0" style="width: 100%" cellpadding="0" cellspacing="0">
                                                    <tr>
                                                        <td align="left" nowrap="nowrap" width="33%" class="WebPanel2hdrxpnd border">
                                                            申請人資料</td>
                                                        <td align="center" nowrap="nowrap" width="34%" class="WebPanel2hdrxpnd border">
                                                        </td>
                                                        <td align="right" nowrap="nowrap" width="33%" class="WebPanel2hdrxpnd border">
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="left" nowrap="nowrap" width="33%" class="WebPanel2hdrxpnd border">
                                                            單位：<asp:Label ID="d_nameLabel" runat="server" Font-Underline="True" Text='<%# Eval("Dept_Name") %>'></asp:Label></td>
                                                        <td align="center" nowrap="nowrap" width="34%" class="WebPanel2hdrxpnd border">
                                                            姓名：<asp:Label ID="name_cLabel" runat="server" Font-Underline="True" Text='<%# Eval("name") %>'></asp:Label></td>
                                                        <td align="right" nowrap="nowrap" width="33%" class="WebPanel2hdrxpnd border">
                                                            工號：<asp:Label ID="NobrLabel" runat="server" Font-Underline="True" Text='<%# Eval("Emp_id") %>'></asp:Label></td>
                                                    </tr>
                                                </table>
                                                <asp:Label ID="lblDept" runat="server" Font-Underline="True" Text='<%# Eval("Dept_id") %>'
                                                    Visible="False"></asp:Label>
                                            </ItemTemplate>
                                        </asp:FormView> <asp:SqlDataSource ID="sdsAppM" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Role.Emp_id, Emp.pw, Emp.name, Emp.email, Emp.login, Emp.sex, Role.Dept_id, Dept.name AS Dept_Name, Role.Pos_id, Pos.name AS Pos_Name, Dept.path, Role.dateB, Role.dateE, Role.mgDefault, Role.deptMg, Role.id FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id INNER JOIN Pos ON Role.Pos_id = Pos.id INNER JOIN Dept ON Role.Dept_id = Dept.id WHERE (Role.Emp_id = @Emp_id)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_id" QueryStringField="idEmp_Start" />
                                            </SelectParameters>
                                        </asp:SqlDataSource> <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label></td></tr><tr><td align="center" style="text-align: left"><table border="0" cellpadding="0" cellspacing="0" width="100%"><tr><td class="UltraWebGrid1-hc" colspan="7" nowrap="nowrap" width="1%" style="font-size: 12pt; color: blue"><strong>新增調班人員</strong></td></tr><tr><td nowrap="nowrap" class="UltraWebGrid1-hc" colspan="2">&nbsp;工號</td><td nowrap="nowrap" align="center" class="UltraWebGrid1-hc">姓名</td><td nowrap="nowrap" align="center" class="UltraWebGrid1-hc">調班日期</td><td nowrap="nowrap" align="center" class="UltraWebGrid1-hc">
                                            原班別/行事曆</td><td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            調班後班別/行事曆</td><td nowrap="nowrap" rowspan="3" class="UltraWebGrid1-ic" width="1%"><asp:Button ID="btnAdd" runat="server" Font-Bold="True" Font-Size="XX-Large"
                                                        Text="新增" OnClick="btnAdd_Click" ForeColor="Blue" CssClass="UltraWebGrid1-hc" /></td></tr><tr><td nowrap="nowrap" align="center" class="UltraWebGrid1-ic" colspan="2"><asp:Label ID="lblNobr" runat="server">00000</asp:Label></td><td nowrap="nowrap" align="center" class="UltraWebGrid1-ic"><asp:DropDownList ID="ddlName" runat="server" AutoPostBack="True" DataSourceID="sdsName" DataTextField="name" DataValueField="Emp_id" OnSelectedIndexChanged="ddlName_SelectedIndexChanged">
                                                    </asp:DropDownList>,<asp:TextBox ID="txtName" runat="server" AutoPostBack="True"
                                                        Width="50px" OnTextChanged="txtName_TextChanged" CssClass="txtBoxLine"></asp:TextBox> </td><td nowrap="nowrap" align="center" class="UltraWebGrid1-ic"><asp:TextBox ID="txtAuthority" runat="server" Width="55px" AutoPostBack="True" OnTextChanged="txtAuthority_TextChanged" CssClass="txtBoxLine"></asp:TextBox></td><td nowrap="nowrap" align="center" class="UltraWebGrid1-ic"><asp:DropDownList ID="ddlRotet" runat="server" DataSourceID="sdsRotet" DataTextField="ROTETNAME"
                                                        DataValueField="ROTET">
                                                    </asp:DropDownList> 
                                                            <asp:DropDownList ID="ddlHolidayOld" runat="server" DataSourceID="sdsHoliday" DataTextField="HOLI_NAME"
                                                                DataValueField="HOLI_CODE" Enabled="False">
                                                            </asp:DropDownList></td><td align="center" class="UltraWebGrid1-ic" nowrap="nowrap"><asp:DropDownList ID="ddlRotetB" runat="server" DataSourceID="sdsRotet" DataTextField="ROTETNAME"
                                                        DataValueField="ROTET">
                                                    </asp:DropDownList> 
                                                        <asp:DropDownList ID="ddlHolidayNew" runat="server" AppendDataBoundItems="True" DataSourceID="sdsHoliday"
                                                            DataTextField="HOLI_NAME" DataValueField="HOLI_CODE"><asp:ListItem Value="000">預設行事曆</asp:ListItem>
</asp:DropDownList></td></tr><tr><td align="right" class="UltraWebGrid1-ic" colspan="2" nowrap="nowrap">事由</td><td class="UltraWebGrid1-ic" colspan="4" nowrap="nowrap"><asp:TextBox ID="txtNote" runat="server" Width="95%" CssClass="txtBoxLine"></asp:TextBox></td></tr>
                                            <tr>
                                                <td class="UltraWebGrid1-ic" colspan="7" nowrap="nowrap">
                                                    <asp:LinkButton ID="lbtnSignState" runat="server" CommandName="SignState" OnClick="lbtn_Click">進行中流程</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnHoliday" runat="server" OnClick="lbtnHoliday_Click">行事曆查詢</asp:LinkButton></td>
                                            </tr>
                                        </table><asp:SqlDataSource ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Emp.id AS Emp_id, Emp.name FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id WHERE (Role.Dept_id IN (SELECT sSubDept FROM SubWork WHERE (sNobr = @Emp_id))) UNION SELECT Role_2.Emp_id, Emp_2.name FROM Role AS Role_2 INNER JOIN Dept ON Role_2.Dept_id = Dept.id INNER JOIN Emp AS Emp_2 ON Role_2.Emp_id = Emp_2.id WHERE (Dept.path LIKE (SELECT Dept_1.path FROM Role AS Role_1 LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id LEFT OUTER JOIN Emp AS Emp_1 ON Role_1.Emp_id = Emp_1.id WHERE (Emp_1.id = @Emp_id) AND (Role_1.Dept_id NOT IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = Role_1.Emp_id)))) + '%') AND (GETDATE() BETWEEN Role_2.dateB AND Role_2.dateE)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_id" QueryStringField="idEmp_Start" />
                                            </SelectParameters>
                                        </asp:SqlDataSource> <asp:SqlDataSource ID="sdsRote" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT RTRIM(ROTE) AS ROTE, RTRIM(ROTENAME) + '(' + RTRIM(ROTE) + ')' AS ROTENAME FROM ROTE">
                                                </asp:SqlDataSource> <asp:SqlDataSource ID="sdsRotet" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT RTRIM(ROTET) AS ROTET, RTRIM(ROTETNAME) + '(' + RTRIM(ROTET) + ')' AS ROTETNAME FROM ROTET">
                                        </asp:SqlDataSource> <asp:SqlDataSource ID="sdsHoliday" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT RTRIM(HOLI_CODE) AS HOLI_CODE, RTRIM(HOLI_NAME) AS HOLI_NAME FROM HOLICD">
                                        </asp:SqlDataSource> <asp:DropDownList ID="ddlRoteCate" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlRoteCate_SelectedIndexChanged" Visible="False">
                                                        <asp:ListItem Value="1">短期調班單</asp:ListItem>
                                                        <asp:ListItem Value="2" Selected="True">長期調班單</asp:ListItem>
                                                    </asp:DropDownList> <asp:Label ID="lblNobrB" runat="server" Visible="False">00000</asp:Label> <asp:DropDownList ID="ddlNameB" runat="server" AutoPostBack="True" DataSourceID="sdsName" DataTextField="name" DataValueField="Emp_id" OnSelectedIndexChanged="ddlName_SelectedIndexChanged" CssClass="UltraWebGrid1-hc" Visible="False">
                                                        </asp:DropDownList> <asp:TextBox ID="txtNameB" runat="server" AutoPostBack="True"
                                                            Width="50px" OnTextChanged="txtName_TextChanged" CssClass="txtBoxLine" Visible="False"></asp:TextBox> <asp:TextBox ID="txtAim" runat="server" Width="55px" AutoPostBack="True" OnTextChanged="txtAuthority_TextChanged" CssClass="txtBoxLine" Visible="False"></asp:TextBox> <asp:DropDownList ID="ddlRoteB" runat="server" DataSourceID="sdsRote" DataTextField="ROTENAME"
                                                        DataValueField="ROTE" CssClass="UltraWebGrid1-hc" Visible="False">
                                                    </asp:DropDownList> <asp:DropDownList ID="ddlRote" runat="server" DataSourceID="sdsRote" DataTextField="ROTENAME"
                                                        DataValueField="ROTE" Visible="False">
                                                    </asp:DropDownList></td></tr><tr><td align="center" style="text-align: left"><table border="0" style="width: 100%" cellpadding="0" cellspacing="0"><tr><td style="font-size: 12pt; color: blue;" class="UltraWebGrid1-hc"><strong>調班人員基本資料</strong></td></tr><tr><td><asp:GridView ID="gvAppS" runat="server" Width="100%" AutoGenerateColumns="False" DataSourceID="sdsAppS" CellPadding="4" ForeColor="#333333" GridLines="None" AllowSorting="True" DataKeyNames="iAutoKey">
<Columns>
<asp:TemplateField ShowHeader="False"><ItemStyle Wrap="False" />
<HeaderStyle Wrap="True" />

<ItemTemplate>
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                                            OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                                    
</ItemTemplate>

</asp:TemplateField>
<asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                    ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
<asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                                    Visible="False" />
<asp:BoundField DataField="idProcess" HeaderText="idProcess" SortExpression="idProcess"
                                                    Visible="False" />
<asp:BoundField DataField="sRoteCate" HeaderText="sRoteCate" SortExpression="sRoteCate"
                                                    Visible="False" />
<asp:BoundField DataField="sRoteCateName" HeaderText="短期/長期" SortExpression="sRoteCateName" Visible="False" />
<asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
<asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
<asp:BoundField DataField="sDept" HeaderText="sDept" SortExpression="sDept" Visible="False" />
<asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" />
<asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" />
<asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                                    Visible="False" />
<asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" />
<asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                                    Visible="False" />
<asp:BoundField DataField="sEmpcd" HeaderText="sEmpcd" SortExpression="sEmpcd" Visible="False" />
<asp:BoundField DataField="sEmpcdName" HeaderText="sEmpcdName" SortExpression="sEmpcdName"
                                                    Visible="False" />
<asp:BoundField DataField="sRote" HeaderText="班別代碼" SortExpression="sRote" Visible="False" />
<asp:BoundField DataField="sRoteName" HeaderText="原班別" SortExpression="sRoteName" />
<asp:BoundField DataField="dAuthority" DataFormatString="{0:d}" HeaderText="調班日"
                                                    HtmlEncode="False" SortExpression="dAuthority" />
<asp:BoundField DataField="sNobrB" HeaderText="工號B" SortExpression="sNobrB" Visible="False" />
<asp:BoundField DataField="sNameB" HeaderText="姓名B" SortExpression="sNameB" Visible="False" />
<asp:BoundField DataField="sDeptB" HeaderText="sDeptB" SortExpression="sDeptB" Visible="False" />
<asp:BoundField DataField="sDeptNameB" HeaderText="部門名稱B" SortExpression="sDeptNameB" Visible="False" />
<asp:BoundField DataField="sRoteB" HeaderText="sRoteB" SortExpression="sRoteB" Visible="False" />
<asp:BoundField DataField="sRoteNameB" HeaderText="調班後班別" SortExpression="sRoteNameB" />
<asp:BoundField DataField="dAim" DataFormatString="{0:d}" HeaderText="調班日期B" HtmlEncode="False"
                                                    SortExpression="dAim" Visible="False" />
<asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
<asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
<asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
    <asp:BoundField DataField="sHolidayName" HeaderText="行事曆" SortExpression="sHolidayName" />
<asp:BoundField DataField="sNote" HeaderText="事由" SortExpression="sNote" />
<asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate"
                                                    Visible="False" />
</Columns>

<HeaderStyle Wrap="True" BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />

<FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />

<RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
<EditRowStyle BackColor="#2461BF" />

<SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />

<PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
<AlternatingRowStyle BackColor="White" />
<EmptyDataTemplate>
                                                目前沒有申請資料。
                                            
</EmptyDataTemplate>

</asp:GridView><asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT * FROM wfShiftAppS WHERE (sProcessID = @sProcessID)" DeleteCommand="DELETE FROM [wfShiftAppS] WHERE [iAutoKey] = @iAutoKey"><DeleteParameters>
<asp:Parameter Name="iAutoKey" Type="Int32" />
</DeleteParameters>
<SelectParameters>
<asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text" />
</SelectParameters>
</asp:SqlDataSource> </td></tr></table></td></tr><tr><td align="left"><asp:Label ID="lblNote" runat="server"></asp:Label></td></tr></table></td></tr><tr><td nowrap="nowrap"><asp:Button ID="btnSign" runat="server" Text="送出傳簽" Font-Bold="True" Font-Size="XX-Large" ForeColor="Blue" OnClick="btnSign_Click" OnClientClick="return confirm('您確定要送出傳簽嗎？');" Font-Underline="False" CssClass="UltraWebGrid1-hc" /> <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td></tr></table>
</ContentTemplate>
</asp:UpdatePanel>
    </div>
    </form>
    </body>
</html>
