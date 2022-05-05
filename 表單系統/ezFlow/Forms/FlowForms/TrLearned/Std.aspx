<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="FlowForms_TrLearn_Std" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<%@ Register Assembly="System.Web.Extensions, Version=1.0.61025.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35"
    Namespace="System.Web.UI" TagPrefix="asp" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager id="sm" runat="server" EnableScriptGlobalization="True">
        </asp:ScriptManager><asp:UpdateProgress id="up" runat="server">
            <progresstemplate>
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
            </progresstemplate>
        </asp:UpdateProgress><asp:UpdatePanel id="upl" runat="server">
            <contenttemplate>
                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td nowrap="nowrap" style="text-align: right">
                            <asp:HyperLink ID="HyperLink1" runat="server" Font-Bold="True" ForeColor="Red" Target="_blank" NavigateUrl="~/TrLearned/Help.htm">使用說明</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td align="center" class="style1" nowrap="nowrap">
                            心得報告表</td>
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
                                                <asp:QueryStringParameter Name="Emp_id" QueryStringField="idEmp_Start" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsCourse" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT COURSE, DATE_B, DATE_E, APPLYNO FROM TRCOSF WHERE (IDNO = @IDNO) AND (DATEDIFF(month, DATE_B, GETDATE()) < 12) AND (TR_REPO = 0) ORDER BY DATE_B">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="IDNO" QueryStringField="idEmp_Start" Type="String" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap" width="1%">
                                                    <strong><span style="font-size: 12pt; color: blue">受訓相關資料</span></strong></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    課程名稱</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlCourse" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                                        DataSourceID="sdsCourse" DataTextField="COURSE" DataValueField="APPLYNO" OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged"
                                                        Width="406px">
                                                        <asp:ListItem Value="a">請選擇課程</asp:ListItem>
                                                    </asp:DropDownList></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" rowspan="2" width="1%">
                                                    研習日期</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    開始日期：<asp:TextBox ID="txtDateB" runat="server" CssClass="txtBoxLine"
                                                        Style="left: 0px;" ToolTip="yyyy/MM/dd" Width="95px"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateB" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />開始時間：<asp:TextBox
                                                            ID="txtTimeB" runat="server" CssClass="txtBoxLine" MaxLength="4" meta:resourcekey="txtNameResource1"
                                                            Style="left: 0px;  top: 0px;" Width="40px">0830</asp:TextBox>(例：早上八點半請輸入0830)</td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" nowrap="nowrap">
                                                    結束日期：<asp:TextBox ID="txtDateE" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        Style="left: 0px; " ToolTip="yyyy/MM/dd" Width="95px"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateE" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />結束時間：<asp:TextBox
                                                            ID="txtTimeE" runat="server" CssClass="txtBoxLine" MaxLength="4" meta:resourcekey="txtNameResource1"
                                                            Style="left: 0px; " Width="40px">1730</asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    上課地點</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        Width="90%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    講師名稱</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="lblTcr1" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        Width="100px"></asp:TextBox>,<asp:TextBox ID="lblTcr2" runat="server" CssClass="txtBoxLine"
                                                            meta:resourcekey="txtNameResource1" Width="100px"></asp:TextBox>,<asp:TextBox ID="lblTcr3"
                                                                runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1" Width="100px"></asp:TextBox>,<asp:TextBox
                                                                    ID="lblTcr4" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                                    Width="100px"></asp:TextBox>,<asp:TextBox ID="lblTcr5" runat="server" CssClass="txtBoxLine"
                                                                        meta:resourcekey="txtNameResource1" Width="100px"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                        <span style="color: red"></span></td>
                                </tr>
                                <tr>
                                    <td align="left" style="height: 292px"><table border="0" cellpadding="0" cellspacing="0" width="100%">
                                        <tr>
                                            <td align="right" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap" width="1%">
                                                <strong><span style="font-size: 12pt; color: blue">1.課程內容</span></strong></td>
                                        </tr>
                                        <tr>
                                            <td align="left" colspan="4" nowrap="nowrap" width="1%">
                                                <asp:TextBox ID="txtContent" runat="server" Height="56px" meta:resourcekey="txtNameResource1"
                                                    Width="100%" TextMode="MultiLine"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap" width="1%">
                                                    <strong><span style="font-size: 12pt; color: blue">2.心得報告</span></strong></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="4" nowrap="nowrap" width="1%">
                                                    <asp:TextBox ID="txtLearned" runat="server" Height="56px"
                                                        Width="100%" TextMode="MultiLine"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap" width="1%">
                                                    <strong><span style="font-size: 12pt; color: blue">3.成果</span></strong></td>
                                            </tr>
                                            <tr>
                                                <td align="left" colspan="4" nowrap="nowrap" width="1%">
                                                    A.對工作助益：<asp:RadioButtonList ID="rblEffor1" runat="server" RepeatDirection="Horizontal"
                                                        RepeatLayout="Flow">
                                                        <asp:ListItem Value="5" Selected="True">極大</asp:ListItem>
                                                        <asp:ListItem Value="4">大</asp:ListItem>
                                                        <asp:ListItem Value="3">尚可</asp:ListItem>
                                                        <asp:ListItem Value="2">小</asp:ListItem>
                                                        <asp:ListItem Value="1">極小</asp:ListItem>
                                                    </asp:RadioButtonList><br />
                                                    B.對個人成長：<asp:RadioButtonList ID="rblEffor2" runat="server" RepeatDirection="Horizontal"
                                                        RepeatLayout="Flow">
                                                        <asp:ListItem Value="5" Selected="True">極大</asp:ListItem>
                                                        <asp:ListItem Value="4">大</asp:ListItem>
                                                        <asp:ListItem Value="3">尚可</asp:ListItem>
                                                        <asp:ListItem Value="2">小</asp:ListItem>
                                                        <asp:ListItem Value="1">極小</asp:ListItem>
                                                    </asp:RadioButtonList><br />
                                                    C.你給予本課程/講師的評比為何?<asp:RadioButtonList ID="rblComment" runat="server" RepeatDirection="Horizontal"
                                                        RepeatLayout="Flow">
                                                        <asp:ListItem Value="5" Selected="True">極佳</asp:ListItem>
                                                        <asp:ListItem Value="4">佳</asp:ListItem>
                                                        <asp:ListItem Value="3">尚可</asp:ListItem>
                                                        <asp:ListItem Value="2">欠佳</asp:ListItem>
                                                        <asp:ListItem Value="1">極差</asp:ListItem>
                                                    </asp:RadioButtonList><br />
                                                    理由：<asp:TextBox ID="txtReason" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        Width="90%"></asp:TextBox></td>
                                            </tr>
                                        </table>
                                        <br />
                                        <asp:Label ID="lblNote" runat="server" ForeColor="Red"></asp:Label></td>
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
                <AjaxControlToolkit:MaskedEditExtender ID="meeDateE" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999/99/99" MaskType="Date" TargetControlID="txtDateE">
                </AjaxControlToolkit:MaskedEditExtender>
                <AjaxControlToolkit:CalendarExtender ID="ceDateB" runat="server" Format="yyyy/MM/dd"
                    PopupButtonID="ibtnDateB" TargetControlID="txtDateB">
                </AjaxControlToolkit:CalendarExtender>
                <AjaxControlToolkit:CalendarExtender ID="ceDateE" runat="server" Format="yyyy/MM/dd"
                    PopupButtonID="ibtnDateE" TargetControlID="txtDateE">
                </AjaxControlToolkit:CalendarExtender>
                <AjaxControlToolkit:MaskedEditExtender ID="meeTimeB" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999" MaskType="None" TargetControlID="txtTimeB">
                </AjaxControlToolkit:MaskedEditExtender>
                <AjaxControlToolkit:MaskedEditExtender ID="meeTimeE" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999" MaskType="None" TargetControlID="txtTimeE">
                </AjaxControlToolkit:MaskedEditExtender>
            </contenttemplate>
            
        </asp:UpdatePanel></div>
    </form>
</body>
</html>
