<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="Repair_Std" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>搶修單---申請</title>
        <link href="../css/general.css" rel="stylesheet" type="text/css">
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
                            <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" ForeColor="Red"
                                Target="_blank" Visible="False">使用說明</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td align="center" class="style1" nowrap="nowrap">
                            緊急入廠搶修單</td>
                    </tr>
                    <tr>
                        <td align="center" nowrap="nowrap">
                            <table border="0" cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                                <tr>
                                    <td align="center" style="text-align: left">
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
                                                    <span style="font-size: 12pt; color: blue"><strong>新增入廠人員</strong></span></td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    工號</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    姓名</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    日期</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    時間</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    加班/補休</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    加班班別</td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="3" 
                                                    width="1%">
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
                                                    <asp:TextBox ID="txtDateB" runat="server" CssClass="txtBoxLine" ToolTip="yyyy/MM/dd" Width="95px"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateB" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" /></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    自<asp:TextBox ID="txtTimeB" runat="server" CssClass="txtBoxLine" MaxLength="4" Width="40px">0000</asp:TextBox>至<asp:TextBox ID="txtTimeE" runat="server" CssClass="txtBoxLine" MaxLength="4" Width="40px">0000</asp:TextBox></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlOtcat" runat="server" OnDataBound="ddlOtcat_DataBound">
                                                        <asp:ListItem Value="1">加班費</asp:ListItem>
                                                        <asp:ListItem Value="2">補休假</asp:ListItem>
                                                    </asp:DropDownList></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlRote" runat="server" AppendDataBoundItems="True" DataSourceID="sdsRote"
                                                        DataTextField="ROTENAME" DataValueField="ROTE">
                                                        <asp:ListItem Value="0">預設班別</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    例外</td>
                                                                                                <td align="left" class="UltraWebGrid1-ic" colspan="5" nowrap="nowrap">
                                                    手動輸入加班時數,共<asp:TextBox ID="txtHour" runat="server" CssClass="txtBoxLine" Width="40px"></asp:TextBox>小時,<span
                                                        style="color: red">此為特例狀況經系統無法自動算出才可以輸入<asp:CheckBox ID="cbEat" runat="server" ForeColor="Black"
                                                            Text="未用餐" />
                                                        <span style="color: black">或</span>
                                                        <asp:CheckBox ID="cbRes" runat="server" ForeColor="Black" Text="未休息" /></span>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" colspan="7" nowrap="nowrap" style="text-align: left">
                                                    <asp:LinkButton ID="lbtnSignState" runat="server" CommandName="SignState" OnClick="lbtn_Click">歷史流程</asp:LinkButton>
                                                    <asp:LinkButton ID="lbtnHoliday" runat="server" OnClick="lbtnHoliday_Click">個人行事曆</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Emp.id AS Emp_id, Emp.name FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id WHERE (Role.Dept_id IN (SELECT sSubDept FROM SubWork WHERE (sNobr = @Emp_id))) UNION SELECT Role_2.Emp_id, Emp_2.name FROM Role AS Role_2 INNER JOIN Dept ON Role_2.Dept_id = Dept.id INNER JOIN Emp AS Emp_2 ON Role_2.Emp_id = Emp_2.id WHERE (Dept.path LIKE (SELECT Dept_1.path FROM Role AS Role_1 LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id LEFT OUTER JOIN Emp AS Emp_1 ON Role_1.Emp_id = Emp_1.id WHERE (Emp_1.id = @Emp_id) AND (Role_1.Dept_id NOT IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = Role_1.Emp_id)))) + '%') AND (GETDATE() BETWEEN Role_2.dateB AND Role_2.dateE)">
                                            <SelectParameters>
                                                <asp:ControlParameter ControlID="lblNobr" Name="Emp_id" PropertyName="Text" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsRote" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            
                                            
                                            SelectCommand="SELECT RTRIM(ROTE) AS ROTE, RTRIM(ROTE) + '班：' + RTRIM(ROTENAME) AS ROTENAME FROM ROTE WHERE (ROTE &lt;&gt; '00') AND (OT = 1) AND (SORT &gt; 0) AND (SORT IS NOT NULL) ORDER BY SORT, ROTE">
                                        </asp:SqlDataSource>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="center" style="text-align: left">
                                        <asp:Panel ID="plAppS" runat="server" Height="100%" Width="100%">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        <strong><span style="font-size: 12pt; color: blue">入廠人員基本資料</span></strong></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None"
                                                            Width="100%" DataKeyNames="iAutoKey" OnRowDeleted="gvAppS_RowDeleted" OnRowCommand="gvAppS_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemStyle Width="1%" Wrap="False" />
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("iAutoKey") %>'
                                                                            CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sJobName" HeaderText="職稱" SortExpression="sJobName" />
                                                                <asp:BoundField DataField="dStrDateTime" HeaderText="開始日期時間" SortExpression="dStrDateTime" />
                                                                <asp:BoundField DataField="dEndDateTime" HeaderText="結束日期時間" SortExpression="dEndDateTime" />
                                                                <asp:BoundField DataField="sOtcatName" HeaderText="加班費/補休假" SortExpression="sOtcatName" />
                                                                <asp:BoundField DataField="sRoteName" HeaderText="加班班別" SortExpression="sRoteName" />
                                                                <asp:BoundField DataField="iTotalHours" HeaderText="總時數" SortExpression="iTotalHours" />
                                                                <asp:TemplateField HeaderText="檔案管理">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnUpload" runat="server" CommandArgument='<%# Eval("sNobr") %>'
                                                                            CommandName="Upload">上傳檔案</asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                                                                Wrap="True" />
                                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                                                            <EditRowStyle BackColor="#2461BF" />
                                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                            <AlternatingRowStyle BackColor="White" />
                                                            <EmptyDataTemplate>
                                                                目前沒有資料。
                                                            </EmptyDataTemplate>
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            DeleteCommand="DELETE FROM [wfRepairAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfRepairAppS] WHERE ([sProcessID] = @sProcessID)">
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
                                                    <asp:Label ID="lblTraffic" runat="server" Text="0" Visible="False"></asp:Label>
                                                    <asp:Label ID="lblSpirit" runat="server" Text="0" Visible="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td class="UltraWebGrid1-hc" colspan="2" nowrap="nowrap">
                                                    <strong><span style="font-size: 12pt; color: blue">入廠相關資料</span></strong></td>
                                            </tr>
                                            <tr>
                                                <td class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    入廠原因</td>
                                                <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:TextBox ID="txtReason" runat="server" CssClass="txtBoxLine" Width="95%"></asp:TextBox>
                                                    <asp:Label ID="lblNum1" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    搶修地點</td>
                                                <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="txtBoxLine" Width="95%"></asp:TextBox>
                                                    <asp:Label ID="lblNum2" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    工作內容</td>
                                                <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:TextBox ID="txtContent" runat="server" CssClass="txtBoxLine" Width="95%"></asp:TextBox>
                                                    <asp:Label ID="lblNum3" runat="server"></asp:Label></td>
                                            </tr>
                                            <tr>
                                                <td class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    改善對策</td>
                                                <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:TextBox ID="txtAmend" runat="server" CssClass="txtBoxLine" Width="95%"></asp:TextBox>
                                                    <asp:Label ID="lblNum4" runat="server"></asp:Label></td>
                                            </tr>
                                        </table>
                                        <span style="color: #ff0000">※每個內容請勿超過100個中文字。<asp:Button ID="btnNum" runat="server"
                                            CssClass="UltraWebGrid1-hc" OnClick="btnNum_Click" Text="檢查字數" /></span></td>
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
                <AjaxControlToolkit:MaskedEditExtender ID="meeDateB" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999/99/99" MaskType="Date" TargetControlID="txtDateB">
                </AjaxControlToolkit:MaskedEditExtender>
                <AjaxControlToolkit:CalendarExtender ID="ceDateB" runat="server" Format="yyyy/MM/dd"
                    PopupButtonID="ibtnDateB" TargetControlID="txtDateB">
                </AjaxControlToolkit:CalendarExtender>
                <AjaxControlToolkit:MaskedEditExtender ID="meeTimeB" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999" MaskType="None" TargetControlID="txtTimeB">
                </AjaxControlToolkit:MaskedEditExtender>
                <AjaxControlToolkit:MaskedEditExtender ID="meeTimeE" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999" MaskType="None" TargetControlID="txtTimeE">
                </AjaxControlToolkit:MaskedEditExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
