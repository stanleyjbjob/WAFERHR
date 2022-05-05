<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EmpInfo.aspx.cs" Inherits="EmpInfo" %>

<%@ Register Assembly="RadCalendar.Net2" Namespace="Telerik.WebControls" TagPrefix="radCln" %>
<%@ Register Src="UC/EmpInfo.ascx" TagName="EmpInfo" TagPrefix="uc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>合晶科技績效考核系統（Web版）v1.0</title>
</head>
<body>
<script language="JavaScript"><!--
if (navigator.appName.indexOf("Internet Explorer") != -1)
document.onmousedown = noSourceExplorer;
function noSourceExplorer(){if (event.button == 2 | event.button == 3)
{
alert("版權所有，不得抄襲！");}}
// --></script>
    <form id="form1" runat="server">
        <div>
            <uc1:EmpInfo ID="EmpInfo1" runat="server" />
            <asp:Label ID="_nobr" runat="server"></asp:Label>
            <asp:Label ID="Label19" runat="server" Text="查詢日期"></asp:Label>
            <radCln:RadDatePicker ID="RadDatePicker1" runat="server">
            </radCln:RadDatePicker>
            <asp:Label ID="Label20" runat="server" Text="至"></asp:Label>
            <radCln:RadDatePicker ID="RadDatePicker2" runat="server">
            </radCln:RadDatePicker>
            &nbsp;
            <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢" /><fieldset>
                <legend>出勤記錄</legend>
                <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse">
                    <tr>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="Label7" runat="server" Text="特休"></asp:Label></td>
                        <td align="center" style="font-size: 12pt; width: 100px; color: #000000">
                            <asp:Label ID="Label8" runat="server" Text="病假"></asp:Label></td>
                        <td align="center" style="font-size: 12pt; width: 100px; color: #000000">
                            <asp:Label ID="Label9" runat="server" Text="事假"></asp:Label></td>
                        <td align="center" style="font-size: 12pt; width: 100px">
                            <asp:Label ID="Label10" runat="server" Text="補休"></asp:Label></td>
                        <td align="center" style="font-size: 12pt; width: 100px; color: #000000">
                            <asp:Label ID="Label11" runat="server" Text="曠工"></asp:Label></td>
                    </tr>
                    <tr bgcolor="lemonchiffon" style="font-size: 12pt; color: #000000">
                        <td align="center" style="width: 100px">
                            <asp:Label ID="Label12" runat="server" Text="Label"></asp:Label></td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="Label13" runat="server" Text="Label"></asp:Label></td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="Label14" runat="server" Text="Label"></asp:Label></td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="Label15" runat="server" Text="Label"></asp:Label></td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="Label16" runat="server" Text="Label"></asp:Label></td>
                    </tr>
                </table>
            </fieldset>
            <fieldset>
                <legend>獎懲記錄</legend>
                <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse">
                    <tr>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="Label1" runat="server" Text="大功"></asp:Label></td>
                        <td align="center" style="font-size: 12pt; width: 100px; color: #000000">
                            <asp:Label ID="Label2" runat="server" Text="小功"></asp:Label></td>
                        <td align="center" style="font-size: 12pt; width: 100px; color: #000000">
                            <asp:Label ID="Label3" runat="server" Text="嘉獎"></asp:Label></td>
                        <td align="center" style="font-size: 12pt; width: 100px; color: #000000">
                            <asp:Label ID="Label5" runat="server" Text="大過"></asp:Label></td>
                        <td align="center" style="width: 100px; color: #000000">
                            <asp:Label ID="Label4" runat="server" Text="小過"></asp:Label></td>
                        <td align="center" style="width: 100px; color: #000000">
                            <asp:Label ID="Label6" runat="server" Text="警告"></asp:Label></td>
                    </tr>
                    <tr bgcolor="lemonchiffon">
                        <td align="center" style="width: 100px">
                            <asp:Label ID="award1" runat="server" Text="0"></asp:Label>
                        </td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="award2" runat="server" Text="0"></asp:Label>
                        </td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="award3" runat="server" Text="0"></asp:Label>
                        </td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="fault1" runat="server" Text="0"></asp:Label>
                        </td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="fault2" runat="server" Text="0"></asp:Label>
                        </td>
                        <td align="center" style="width: 100px">
                            <asp:Label ID="fault3" runat="server" Text="0"></asp:Label>
                        </td>
                    </tr>
                </table>
                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="NOBR" HeaderText="NOBR" SortExpression="NOBR" Visible="False" />
                        <asp:BoundField DataField="ADATE" DataFormatString="{0:yyyy/MM/dd}" HeaderText="日期"
                            SortExpression="ADATE" />
                        <asp:BoundField DataField="AWARD_CODE" HeaderText="AWARD_CODE" SortExpression="AWARD_CODE"
                            Visible="False" />
                        <asp:BoundField DataField="AWARD1" HeaderText="大功" SortExpression="AWARD1" />
                        <asp:BoundField DataField="AWARD2" HeaderText="小功" SortExpression="AWARD2" />
                        <asp:BoundField DataField="AWARD3" HeaderText="嘉獎" SortExpression="AWARD3" />
                        <asp:BoundField DataField="AWARD4" HeaderText="AWARD4" SortExpression="AWARD4" Visible="False" />
                        <asp:CheckBoxField DataField="AWARD5" HeaderText="AWARD5" SortExpression="AWARD5"
                            Visible="False" />
                        <asp:BoundField DataField="FAULT1" HeaderText="大過" SortExpression="FAULT1" />
                        <asp:BoundField DataField="FAULT2" HeaderText="小過" SortExpression="FAULT2" />
                        <asp:BoundField DataField="FAULT3" HeaderText="警告" SortExpression="FAULT3" />
                        <asp:BoundField DataField="KEY_MAN" HeaderText="KEY_MAN" SortExpression="KEY_MAN"
                            Visible="False" />
                        <asp:BoundField DataField="KEY_DATE" HeaderText="KEY_DATE" SortExpression="KEY_DATE"
                            Visible="False" />
                        <asp:BoundField DataField="NOTE" HeaderText="備註" SortExpression="NOTE" />
                    </Columns>
                </asp:GridView>
            </fieldset>
            <fieldset id="FIELDSET2" runat="server">
                <legend>考核記錄</legend>
                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataSourceID="EffsSqlDataSource"
                    Visible="False">
                    <Columns>
                        <asp:BoundField DataField="YYMM" HeaderText="年度" SortExpression="YYMM">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="NOBR" HeaderText="NOBR" SortExpression="NOBR" Visible="False" />
                        <asp:BoundField DataField="NAME_C" HeaderText="NAME_C" SortExpression="NAME_C" Visible="False" />
                        <asp:BoundField DataField="EFFTYPE" HeaderText="次數" SortExpression="EFFTYPE">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EFFBA" DataFormatString="{0:0.0}" HeaderText="工作目標" SortExpression="EFFBA"
                            Visible="False">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EFFBB" DataFormatString="{0:0.0}" HeaderText="行為態度" SortExpression="EFFBB"
                            Visible="False">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EFFVAR" DataFormatString="{0:0.0}" HeaderText="考核分數" SortExpression="EFFVAR">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="EFFLVL" HeaderText="評等" SortExpression="EFFLVL">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                </asp:GridView>
                <asp:DataList ID="DataList1" runat="server" DataSourceID="EffsSqlDataSource" RepeatDirection="Horizontal" OnItemDataBound="DataList1_ItemDataBound">
                    <ItemTemplate>
                        <table id="TABLE1" runat="server" cellpadding="0" cellspacing="0">
                            <tr>
                                <td align="left" valign="top">
                                    <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse" id="TABLE2"
                                        runat="server" visible="false">
                                        <tr  Height="20">
                                            <td align="center" style="width: 100px; color: #000000">
                                                <asp:Label ID="Label23" runat="server" Text="年度"></asp:Label></td>
                                        </tr>
                                        <tr bgcolor="lemonchiffon"  Height="20">
                                            <td align="center" style="width: 100px">
                                                <asp:Label ID="Label22" runat="server" Font-Bold="True" ForeColor="Blue" Text="評等"></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                                <td valign="top">
                                    <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse">
                                        <tr  Height="20">
                                            <td align="center" style="width: 100px; color: #000000">
                                                <asp:Label ID="YYMMLabel" runat="server" Height="16px" Text='<%# Eval("YYMM", "{0}") %>'></asp:Label>
                                                <asp:Label ID="Label6" runat="server" Text="年"></asp:Label></td>
                                        </tr>
                                        <tr bgcolor="lemonchiffon"  Height="20">
                                            <td align="center" style="width: 100px">
                                                <asp:Label ID="EFFLVLLabel" runat="server" Text='<%# Eval("EFFLVL") %>'></asp:Label></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="EffsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT CAST(EFFEMPLOY.YYMM AS int) + 1911 AS YYMM, EFFEMPLOY.NOBR, BASE.NAME_C, EFFEMPLOY.EFFTYPE, EFFEMPLOY.EFFBA, EFFEMPLOY.EFFBB, EFFEMPLOY.EFFVAR, EFFEMPLOY.EFFLVL FROM EFFEMPLOY INNER JOIN BASE ON EFFEMPLOY.NOBR = BASE.NOBR WHERE (BASE.NOBR = @nobr) AND (CAST(EFFEMPLOY.YYMM AS int) >= YEAR(GETDATE()) - 1911 - 4) ORDER BY YYMM DESC, EFFEMPLOY.EFFTYPE, EFFEMPLOY.NOBR">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <span style="color: #cc0000"></span></fieldset>
            <fieldset>
                <legend>人事異動記錄</legend>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataSourceID="ttsSqlDataSource">
                    <Columns>
                        <asp:BoundField DataField="異動日期" DataFormatString="{0:yyyy/MM/dd}" HeaderText="異動日期"
                            HtmlEncode="False" SortExpression="異動日期" />
                        <asp:BoundField DataField="異動" HeaderText="異動" SortExpression="異動" />
                        <asp:BoundField DataField="原因" HeaderText="原因" SortExpression="原因" />
                        <asp:BoundField DataField="編制部門" HeaderText="編制部門" SortExpression="編制部門" />
                        <asp:BoundField DataField="職等" HeaderText="職等" SortExpression="職等"  />
                        <asp:BoundField DataField="職稱" HeaderText="職稱" SortExpression="職稱" />
                    </Columns>
                    <RowStyle Font-Size="Small" />
                    <HeaderStyle Font-Size="Small" />
                </asp:GridView>
                <asp:SqlDataSource ID="ttsSqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="                          SELECT   BASETTS.JOBL AS 職等   ,   BASETTS.ADATE AS 異動日期, TTSCODE.TTSDESC AS 異動, &#13;&#10;                          TTSCD.TTSNAME AS 原因, DEPT.D_NAME AS 編制部門, &#13;&#10;                          JOB.JOB_NAME AS 職稱&#13;&#10;FROM             BASETTS INNER JOIN&#13;&#10;                          TTSCODE ON BASETTS.TTSCODE = TTSCODE.TTSCODE LEFT OUTER JOIN&#13;&#10;                          JOB ON BASETTS.JOB = JOB.JOB LEFT OUTER JOIN&#13;&#10;                          DEPTS ON BASETTS.DEPTS = DEPTS.D_NO LEFT OUTER JOIN&#13;&#10;                          DEPT ON BASETTS.DEPT = DEPT.D_NO LEFT OUTER JOIN&#13;&#10;                          TTSCD ON BASETTS.TTSCD = TTSCD.TTSCD&#13;&#10;WHERE         (BASETTS.NOBR = @nobr) AND (BASETTS.ADATE BETWEEN '1900/1/1' AND &#13;&#10;                          '9999/12/31')&#13;&#10;ORDER BY  BASETTS.ADATE DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
            </fieldset>
            <fieldset>
                <legend>必訓資料</legend>
                <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Font-Size="X-Small" ForeColor="#333333" GridLines="None" OnRowDataBound="GridView6_RowDataBound"
                    Width="100%">
                    <RowStyle BackColor="#EFF3FB" />
                    <Columns>
                        <asp:BoundField DataField="JOBLEVEL" HeaderText="職稱代碼" Visible="False">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="JOB_NAME" HeaderText="職稱" />
                        <asp:BoundField DataField="JOBCLASS" HeaderText="職系代碼" Visible="False">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="JOBS_NAME" HeaderText="職系名稱" />
                        <asp:BoundField DataField="COSCODE" HeaderText="課程代碼">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DESCRC" HeaderText="課程名稱" />
                        <asp:BoundField DataField="SUBCODE" HeaderText="類別代碼" Visible="False">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DESCR" HeaderText="類別名稱" />
                        <asp:BoundField HeaderText="已訓" />
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </fieldset>
            <fieldset>
                <legend>內訓資料</legend>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="Edu1SqlDataSource"
                    OnRowDataBound="GridView1_RowDataBound1" ShowFooter="True" Visible="False">
                    <Columns>
                        <asp:BoundField DataField="DESCR" HeaderText="課程名稱" SortExpression="DESCR">
                            <FooterStyle Font-Bold="True" ForeColor="Blue" />
                        </asp:BoundField>
                        <asp:BoundField DataField="COSDATEB" DataFormatString="{0:yyyy/MM/dd}" HeaderText="開課時間"
                            HtmlEncode="False" SortExpression="COSDATEB" />
                        <asp:BoundField DataField="HOURS" HeaderText="時數" SortExpression="HOURS">
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle Font-Size="Small" />
                    <HeaderStyle Font-Size="Small" />
                    <FooterStyle ForeColor="Blue" />
                </asp:GridView>
                <asp:SqlDataSource ID="Edu1SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT TRCOS.DESCR, TRCOS.HOURS, TRCOS.COSDATEB FROM BASETTS INNER JOIN BASE ON BASETTS.NOBR = BASE.NOBR INNER JOIN DEPT ON BASETTS.DEPT = DEPT.D_NO INNER JOIN TRATT INNER JOIN TRCOS ON TRATT.COSCODE = TRCOS.COSCODE AND TRATT.SER = TRCOS.SER AND TRATT.YYMM = TRCOS.YYMM ON BASE.NOBR = TRATT.IDNO WHERE (TRATT.IDNO = @IDNO) AND (GETDATE() BETWEEN BASETTS.ADATE AND BASETTS.DDATE) AND (GETDATE() BETWEEN DEPT.ADATE AND DEPT.DDATE) AND (TRATT.COSCLOSE = 1) AND (TRCOS.COSDATEB BETWEEN @adate AND @ddate) ORDER BY TRCOS.COSDATEB DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_nobr" DefaultValue="" Name="IDNO" PropertyName="Text" />
                        <asp:ControlParameter ControlID="RadDatePicker1" Name="adate" PropertyName="SelectedDate" />
                        <asp:ControlParameter ControlID="RadDatePicker2" Name="ddate" PropertyName="SelectedDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" CellPadding="4"
                    Font-Size="X-Small" ForeColor="#333333" GridLines="None" Width="100%">
                    <RowStyle BackColor="#EFF3FB" />
                    <Columns>
                        <asp:BoundField DataField="SUBCODE" HeaderText="課程類別">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="DESCR" HeaderText="課程名稱" />
                        <asp:BoundField DataField="name_c" HeaderText="參訓人員">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="cosdateb" DataFormatString="{0:d}" HeaderText="開訓日期" HtmlEncode="False" />
                        <asp:BoundField DataField="cosdatee" DataFormatString="{0:d}" HeaderText="結訓日期" HtmlEncode="False" />
                        <asp:BoundField DataField="selcodename" HeaderText="必/選修">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tcr_name" HeaderText="講師">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="hours" HeaderText="上課時數">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="abshrs" HeaderText="缺課時數">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="COSCLNAME" HeaderText="完成評核" />
                        <asp:BoundField DataField="TR_ASNAME" HeaderText="評估">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="score" HeaderText="成績">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
            </fieldset>
            <fieldset id="FIELDSET1" runat="server">
                <legend>外訓資料</legend>
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataSourceID="Edu2qlDataSource"
                    OnRowDataBound="GridView2_RowDataBound" ShowFooter="True" OnDataBound="GridView2_DataBound">
                    <Columns>
                        <asp:BoundField DataField="課程名稱" HeaderText="課程名稱" SortExpression="課程名稱">
                            <FooterStyle Font-Bold="True" ForeColor="Blue" />
                        </asp:BoundField>
                        <asp:BoundField DataField="開訓日期" HeaderText="開訓日期" HtmlEncode="False" DataFormatString="{0:yyyy/MM/dd}"
                            SortExpression="開訓日期" />
                        <asp:BoundField DataField="結訓日期" HeaderText="結訓日期" Visible="False" HtmlEncode="False"
                            DataFormatString="{0:yyyy/MM/dd}" SortExpression="結訓日期" />
                        <asp:BoundField DataField="訓練機構" HeaderText="訓練機構" SortExpression="訓練機構" />
                        <asp:BoundField DataField="總時數" HeaderText="總時數" SortExpression="總時數">
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="公司負擔金額" HeaderText="公司負擔金額" SortExpression="公司負擔金額" Visible="False">
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="個人負擔金額" HeaderText="個人負擔金額" SortExpression="個人負擔金額" Visible="False">
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="上課費用" HeaderText="上課費用" SortExpression="上課費用">
                            <ItemStyle HorizontalAlign="Center" />
                            <HeaderStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <RowStyle Font-Size="Small" />
                    <HeaderStyle Font-Size="Small" />
                    <FooterStyle HorizontalAlign="Center" ForeColor="Blue" />
                </asp:GridView>
                <asp:SqlDataSource ID="Edu2qlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT COURSE AS 課程名稱, DATE_B AS 開訓日期, DATE_E AS 結訓日期, TR_COMP AS 訓練機構, TR_HRS AS 總時數,  COS_FEE AS 上課費用 FROM TRCOSF WHERE (IDNO = @Idno) AND (CLOSE_ = 1) AND (DATE_B BETWEEN @adate AND @ddate) ORDER BY 開訓日期 DESC">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_nobr" Name="Idno" PropertyName="Text" />
                        <asp:ControlParameter ControlID="RadDatePicker1" Name="adate" PropertyName="SelectedDate" />
                        <asp:ControlParameter ControlID="RadDatePicker2" Name="ddate" PropertyName="SelectedDate" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:GridView ID="GridView8" runat="server" AllowPaging="True" AutoGenerateColumns="False"
                    CellPadding="4" Font-Size="X-Small" ForeColor="#333333" GridLines="None" Width="100%">
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EFF3FB" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <AlternatingRowStyle BackColor="White" />
                    <Columns>
                        <asp:BoundField DataField="tr_type" HeaderText="類別">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="course" HeaderText="課程名稱" />
                        <asp:BoundField DataField="date_b" DataFormatString="{0:d}" HeaderText="開訓日期" HtmlEncode="False" />
                        <asp:BoundField DataField="date_e" DataFormatString="{0:d}" HeaderText="結訓日期" HtmlEncode="False" />
                        <asp:BoundField DataField="tr_hrs" HeaderText="上課時數">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="at_hrs" HeaderText="缺課時數">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="tr_comp" HeaderText="上課地點" />
                        <asp:BoundField DataField="cos_fee" HeaderText="費用">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="COSCLNAME" HeaderText="完成評核" />
                        <asp:BoundField DataField="tr_asname" HeaderText="評估">
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                    </Columns>
                    <EditRowStyle BackColor="#2461BF" />
                </asp:GridView>
            </fieldset>
            <fieldset>
                <asp:Label ID="Label18" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="訓練全部時數總計：" Visible="False"></asp:Label>
                <asp:Label ID="to_hours" runat="server" Font-Bold="True" Font-Size="Medium" ForeColor="Blue"
                    Text="０" Visible="False"></asp:Label>
            </fieldset>
        </div>
    </form>
</body>
</html>
