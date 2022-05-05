<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="TrainOut_Std" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>外訓單---申請</title>
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
                                Target="_blank">使用說明</asp:HyperLink></td>
                    </tr>
                    <tr>
                        <td align="center" class="style1" nowrap="nowrap">
                            外訓申請單</td>
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
                                        <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label></td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" colspan="5" nowrap="nowrap">
                                                    <span style="font-size: 12pt; color: blue"><strong>新增受訓人員</strong></span></td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    工號</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    姓名</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    派訓次數</td>
                                                <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                    累計外訓金額</td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="2" width="1%">
                                                    <asp:Button ID="btnAdd" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                                        Font-Size="XX-Large" ForeColor="Blue" OnClick="btnAdd_Click" Text="新增" /></td>
                                            </tr>
                                            <tr>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:Label ID="lblNobr" runat="server">00000</asp:Label></td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:DropDownList ID="ddlName" runat="server" AutoPostBack="True" DataSourceID="sdsName"
                                                        DataTextField="name" DataValueField="Emp_id" OnSelectedIndexChanged="ddlName_SelectedIndexChanged">
                                                    </asp:DropDownList>,<asp:TextBox ID="txtName" runat="server" AutoPostBack="True"
                                                        CssClass="txtBoxLine" OnTextChanged="txtName_TextChanged" Width="70px"></asp:TextBox>
                                                </td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:Label ID="lblNum" runat="server"></asp:Label>&nbsp;</td>
                                                <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                    <asp:Label ID="lblSum" runat="server"></asp:Label>&nbsp;</td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-ic" colspan="5" nowrap="nowrap" style="text-align: left">
                                                    <asp:LinkButton ID="lbtnSignState" runat="server" CommandName="SignState" OnClick="lbtn_Click">進行中流程</asp:LinkButton></td>
                                            </tr>
                                        </table>
                                        <asp:SqlDataSource ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                            SelectCommand="SELECT Emp.id AS Emp_id, Emp.name FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id WHERE (Role.Dept_id IN (SELECT sSubDept FROM SubWork WHERE (sNobr = @Emp_id))) UNION SELECT Role_2.Emp_id, Emp_2.name FROM Role AS Role_2 INNER JOIN Dept ON Role_2.Dept_id = Dept.id INNER JOIN Emp AS Emp_2 ON Role_2.Emp_id = Emp_2.id WHERE (Dept.path LIKE (SELECT Dept_1.path FROM Role AS Role_1 LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id LEFT OUTER JOIN Emp AS Emp_1 ON Role_1.Emp_id = Emp_1.id WHERE (Emp_1.id = @Emp_id) AND (Role_1.Dept_id NOT IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = Role_1.Emp_id)))) + '%') AND (GETDATE() BETWEEN Role_2.dateB AND Role_2.dateE)">
                                            <SelectParameters>
                                                <asp:QueryStringParameter Name="Emp_id" QueryStringField="idEmp_Start" />
                                            </SelectParameters>
                                        </asp:SqlDataSource>
                                        <asp:SqlDataSource ID="sdsHcode" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                            SelectCommand="SELECT RTRIM(H_CODE) AS h_code, RTRIM(H_NAME) AS h_name FROM HCODE WHERE (NOT_DEL <> 1) AND (YEAR_REST IN ('0', '2', '4', '6')) ORDER BY H_CODE">
                                        </asp:SqlDataSource>
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        <strong><span style="font-size: 12pt; color: blue">受訓人員基本資料</span></strong></td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="gvAppS" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None"
                                                            Width="100%" DataKeyNames="iAutoKey">
                                                            <Columns>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                                                                            OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
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
                                                                <asp:BoundField DataField="sDeptName" HeaderText="部門" SortExpression="sDeptName">
                                                                    <ItemStyle HorizontalAlign="Center" />
                                                                </asp:BoundField>
                                                                <asp:BoundField DataField="sJobName" HeaderText="職稱" SortExpression="sJobName" />
                                                                <asp:BoundField DataField="iNum" HeaderText="累計受訓次數" SortExpression="iNum" />
                                                                <asp:BoundField DataField="iSum" HeaderText="累計受訓費用" SortExpression="iSum" />
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
                                                                目前沒有人申請。
                                                            </EmptyDataTemplate>
                                                        </asp:GridView>
                                                        <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                            DeleteCommand="DELETE FROM [wfTrainAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [wfTrainAppS] WHERE ([sProcessID] = @sProcessID)">
                                                            <DeleteParameters>
                                                                <asp:Parameter Name="iAutoKey" Type="Int32" />
                                                            </DeleteParameters>
                                                            <SelectParameters>
                                                                <asp:ControlParameter ControlID="lblProcessID" Name="sProcessID" PropertyName="Text" />
                                                            </SelectParameters>
                                                        </asp:SqlDataSource>
                                                        &nbsp;
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td class="UltraWebGrid1-ic">
                                                        <asp:LinkButton ID="lbtnFileManage" runat="server" CommandName="Upload" OnClick="lbtn_Click">相關受訓文件上傳</asp:LinkButton></td>
                                                </tr>
                                            </table>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="left">
                                        <table border="0" width="100%" cellpadding="0" cellspacing="0">
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap" width="1%">
                                                    <strong><span style="font-size: 12pt; color: blue">受訓相關資料</span></strong></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    申請日期<span style="color: red">*</span></td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtDate" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                         Width="95px"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDate" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />(例如：1979/12/3)</td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    課程名稱<span style="color: red">*</span></td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtCourseName" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        
                                                        Width="60%"></asp:TextBox>
                                                    </td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" rowspan="1" width="1%">
                                                    課程效益<span style="color: #ff0000">*</span></td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtAim" runat="server" CssClass="txtBoxLine"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" rowspan="2" class="UltraWebGrid1-hc" width="1%">
                                                    研習日期<span style="color: red">*</span></td>
                                                <td colspan="3" nowrap="nowrap">
                                                    開始日期：<asp:TextBox ID="txtDateB" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        Style="left: 0px; "
                                                        Width="95px"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateB" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />開始時間：<asp:TextBox ID="txtTimeB" runat="server" CssClass="txtBoxLine"
                                                            meta:resourcekey="txtNameResource1" Style="left: 0px;"
                                                            Width="40px" MaxLength="4">0830</asp:TextBox>(例：早上八點半請輸入0830)</td>
                                            </tr>
                                            <tr>
                                                <td colspan="3" nowrap="nowrap">
                                                    結束日期：<asp:TextBox ID="txtDateE" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        Style="left: 0px;"
                                                        Width="95px"></asp:TextBox>
                                                    <asp:ImageButton ID="ibtnDateE" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />結束時間：<asp:TextBox ID="txtTimeE" runat="server" CssClass="txtBoxLine"
                                                            meta:resourcekey="txtNameResource1" Style="left: 0px; " 
                                                            Width="40px" MaxLength="4">1730</asp:TextBox>，共<asp:TextBox ID="txtTotalHours" runat="server" CssClass="txtBoxLine"
                                                        MaxLength="4" meta:resourcekey="txtNameResource1" 
                                                        ValidationGroup="aaa" Width="30px">0</asp:TextBox>小時</td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    上課地點<span style="color: red">*</span></td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtAddress" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                         Width="90%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    主辦單位<span style="color: red">*</span></td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtCompany" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1" Width="200px" ></asp:TextBox><span
                                                            style="color: #ff0000">＊</span><span style="color: red">請填完整單位名稱</span></td>
                                            </tr>
                                            <tr>
                                                <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                                    講師名稱</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="lblTcr1" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                        Width="70px"></asp:TextBox>,<asp:TextBox ID="lblTcr2" runat="server" CssClass="txtBoxLine"
                                                            meta:resourcekey="txtNameResource1" Width="70px"></asp:TextBox>,<asp:TextBox ID="lblTcr3"
                                                                runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1" Width="70px"></asp:TextBox>,<asp:TextBox
                                                                    ID="lblTcr4" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                                    Width="70px"></asp:TextBox>,<asp:TextBox ID="lblTcr5" runat="server" CssClass="txtBoxLine"
                                                                        meta:resourcekey="txtNameResource1" Width="70px"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    全部費用<span style="color: red">*</span></td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtCharge" runat="server" AutoPostBack="True" CssClass="txtBoxLine"
                                                        meta:resourcekey="txtNameResource1" Width="100px" ></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    付款抬頭</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtCheckTitle" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                         Width="200px" ></asp:TextBox>
                                                    <span style="color: #ff0000">＊同主辦單位名稱免填</span></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%" style="height: 23px">
                                                    付款方式</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:RadioButtonList ID="rblPayment" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                                        >
                                                        <asp:ListItem Value="1">現金</asp:ListItem>
                                                        <asp:ListItem Value="2">匯款</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    匯款銀行</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:TextBox ID="txtBank" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                                         Width="100px" ></asp:TextBox><asp:Label ID="lblbranch"
                                                            runat="server"  Text="分行"></asp:Label><asp:TextBox ID="txtBranch"
                                                                runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1" 
                                                                Width="100px" ></asp:TextBox><asp:Label ID="lblaccount" runat="server" 
                                                                    Text="帳號"></asp:Label><asp:TextBox ID="txtAccount" runat="server" CssClass="txtBoxLine"
                                                                        meta:resourcekey="txtNameResource1"  Width="150px" ></asp:TextBox><span
                                                                            style="color: #ff0000">＊選匯款需填</span></td>
                                            </tr>
                                            <tr>
                                                <td align="right" nowrap="nowrap" class="UltraWebGrid1-hc" width="1%">
                                                    報名方式</td>
                                                <td colspan="3" nowrap="nowrap">
                                                    <asp:RadioButtonList ID="rblSignup" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow"
                                                        >
                                                        <asp:ListItem Value="1" Selected="True">上線報名</asp:ListItem>
                                                        <asp:ListItem Value="2">傳真報名</asp:ListItem>
                                                    </asp:RadioButtonList>,是否已自行報名<asp:RadioButtonList ID="rblSignupMe" runat="server"
                                                        RepeatDirection="Horizontal" RepeatLayout="Flow">
                                                        <asp:ListItem Value="1">是</asp:ListItem>
                                                        <asp:ListItem Selected="True" Value="2">否</asp:ListItem>
                                                    </asp:RadioButtonList></td>
                                            </tr>
                                        </table>
                                        <span style="color: red">※「<span style="color: red">*」為必填欄位。</span></span></td>
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
                <AjaxControlToolkit:MaskedEditExtender ID="meeDate" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999/99/99" MaskType="Date" TargetControlID="txtDate">
                </AjaxControlToolkit:MaskedEditExtender>
                <AjaxControlToolkit:CalendarExtender ID="ceDate" runat="server" Format="yyyy/MM/dd"
                    PopupButtonID="ibtnDate" TargetControlID="txtDate">
                </AjaxControlToolkit:CalendarExtender>
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
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
