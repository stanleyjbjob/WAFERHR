<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Send.aspx.cs" Inherits="TrainIn_Send" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>內訓課程飾選通知</title>
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
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
                    <asp:View ID="View1" runat="server">
                        <table cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                            <tr>
                                <td class="UltraWebGrid1-hc" colspan="7" nowrap="nowrap">
                                    <span style="font-size: 12pt; color: blue"><strong>受訓名單條件設定</strong></span></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" colspan="3" nowrap="nowrap" width="50%">
                                    部門</td>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                </td>
                                <td class="UltraWebGrid1-hc" colspan="3" nowrap="nowrap" width="50%">
                                    職稱</td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="4" width="25%">
                                    <asp:ListBox ID="lbDeptL" runat="server" DataSourceID="sdsDept" DataTextField="D_NAME" DataValueField="D_NO" Height="300px" SelectionMode="Multiple" Width="100%"></asp:ListBox></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%">
                                    <asp:ImageButton ID="ibtnDeptAllR" runat="server" ImageUrl="~/TrainIn/images/rightAll.gif" CommandName="DeptAllR" OnClick="ibtn_Click" OnClientClick="return confirm('您確定都要移到右邊嗎？');" /></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="4" width="25%"><asp:ListBox ID="lbDeptR" runat="server" Height="300px" SelectionMode="Multiple" Width="100%">
                                </asp:ListBox></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="4" width="1%">
                                    <asp:RadioButtonList ID="rblLogic" runat="server" RepeatLayout="Flow">
                                        <asp:ListItem Value="AND">且</asp:ListItem>
                                        <asp:ListItem Selected="True" Value="OR">或</asp:ListItem>
                                    </asp:RadioButtonList></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="4" width="25%"><asp:ListBox ID="lbJobL" runat="server" DataSourceID="sdsJob" DataTextField="JOB_NAME" DataValueField="JOB" Height="300px" SelectionMode="Multiple" Width="100%">
                                </asp:ListBox></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%"><asp:ImageButton ID="ibtnJobAllR" runat="server" ImageUrl="~/TrainIn/images/rightAll.gif" CommandName="JobAllR" OnClick="ibtn_Click" OnClientClick="return confirm('您確定都要移到右邊嗎？');" /></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="4" width="25%"><asp:ListBox ID="lbJobR" runat="server" Height="300px" SelectionMode="Multiple" Width="100%">
                                </asp:ListBox></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%"><asp:ImageButton ID="ibtnDeptR" runat="server" ImageUrl="~/TrainIn/images/right.gif" CommandName="DeptR" OnClick="ibtn_Click" /></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%"><asp:ImageButton ID="ibtnJobR" runat="server" ImageUrl="~/TrainIn/images/right.gif" CommandName="JobR" OnClick="ibtn_Click" /></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%"><asp:ImageButton ID="ibtnDeptL" runat="server" ImageUrl="~/TrainIn/images/left.gif" CommandName="DeptL" OnClick="ibtn_Click" /></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%"><asp:ImageButton ID="ibtnJobL" runat="server" ImageUrl="~/TrainIn/images/left.gif" CommandName="JobL" OnClick="ibtn_Click" /></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%"><asp:ImageButton ID="ibtnDeptAllL" runat="server" ImageUrl="~/TrainIn/images/leftAll.gif" CommandName="DeptAllL" OnClick="ibtn_Click" OnClientClick="return confirm('您確定都要移到左邊嗎？');" /></td>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" width="1%"><asp:ImageButton ID="ibtnJobAllL" runat="server" ImageUrl="~/TrainIn/images/leftAll.gif" CommandName="JobAllL" OnClick="ibtn_Click" OnClientClick="return confirm('您確定都要移到左邊嗎？');" /></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap" colspan="7">
                                    課程名稱/年月/期數<asp:DropDownList ID="ddlCourse" runat="server" AppendDataBoundItems="True"
                                        AutoPostBack="True" DataSourceID="sdsCourse" DataTextField="DESCR" DataValueField="COSCODE"
                                        OnSelectedIndexChanged="ddlCourse_SelectedIndexChanged">
                                        <asp:ListItem Value="a">請選擇課程</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlYYMM" runat="server" AppendDataBoundItems="True" AutoPostBack="True"
                                        DataSourceID="sdsYYMM" DataTextField="YYMM" DataValueField="YYMM" OnSelectedIndexChanged="ddlYYMM_SelectedIndexChanged">
                                        <asp:ListItem Value="a">請選擇年月</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:DropDownList ID="ddlSer" runat="server" AppendDataBoundItems="True" DataSourceID="sdsSer"
                                        DataTextField="SER" DataValueField="SER">
                                        <asp:ListItem Value="a">請選擇期別</asp:ListItem>
                                    </asp:DropDownList>
                                    <asp:CheckBox ID="cbSelectTrain" runat="server" Text="必修" />
                                    <asp:CheckBox ID="cbTratt" runat="server" Text="包含已調訓人員" Checked="True" />
                                    <asp:CheckBox ID="cbOK" runat="server" Text="包含已受訓人員" Checked="True" />
                                    <asp:Button ID="btnView" runat="server" CssClass="UltraWebGrid1-hc" OnClick="btnView_Click"
                                        OnClientClick="return confirm('您確定要產生名單嗎？(不會儲存只是預覽)');" Text="產生名單(不會儲存)" /></td>
                            </tr>
                        </table>
                        <asp:SqlDataSource ID="sdsDept" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            SelectCommand="SELECT RTRIM(D_NO) AS D_NO, RTRIM(D_NAME) + '(' + RTRIM(D_NO) + ')' AS D_NAME FROM DEPT WHERE (GETDATE() BETWEEN ADATE AND DDATE) ORDER BY D_NO">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsJob" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            SelectCommand="SELECT RTRIM(JOB) AS JOB, RTRIM(JOB_NAME) + '(' + RTRIM(JOB) + ')' AS JOB_NAME FROM JOB ORDER BY JOB">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsCourse" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            SelectCommand="SELECT DISTINCT RTRIM(COSCODE) AS COSCODE, RTRIM(DESCR) AS DESCR FROM TRCOS ORDER BY COSCODE">
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsYYMM" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            SelectCommand="SELECT DISTINCT RTRIM(YYMM) AS YYMM FROM TRCOS WHERE (COSCODE = @COSCODE) OR (@COSCODE = 'a') ORDER BY YYMM">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCourse" DefaultValue="a" Name="COSCODE" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:SqlDataSource ID="sdsSer" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            SelectCommand="SELECT DISTINCT RTRIM(SER) AS SER FROM TRCOS WHERE (COSCODE = @COSCODE OR @COSCODE = 'a') AND (YYMM = @YYMM OR @YYMM = 'a') ORDER BY SER">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="ddlCourse" DefaultValue="a" Name="COSCODE" PropertyName="SelectedValue" />
                                <asp:ControlParameter ControlID="ddlYYMM" DefaultValue="a" Name="YYMM" PropertyName="SelectedValue" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="lblWhere" runat="server" Visible="False"></asp:Label></asp:View>
                    <asp:View ID="View2" runat="server">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <asp:FormView ID="fvTrain" runat="server" DataSourceID="sdsFV" Width="100%">
                                        <EditItemTemplate>
                                            DESCR:
                                            <asp:TextBox ID="DESCRTextBox" runat="server" Text='<%# Bind("DESCR") %>'>
                                            </asp:TextBox><br />
                                            COSCODE:
                                            <asp:TextBox ID="COSCODETextBox" runat="server" Text='<%# Bind("COSCODE") %>'>
                                            </asp:TextBox><br />
                                            YYMM:
                                            <asp:TextBox ID="YYMMTextBox" runat="server" Text='<%# Bind("YYMM") %>'>
                                            </asp:TextBox><br />
                                            SER:
                                            <asp:TextBox ID="SERTextBox" runat="server" Text='<%# Bind("SER") %>'>
                                            </asp:TextBox><br />
                                            TR_NAME:
                                            <asp:TextBox ID="TR_NAMETextBox" runat="server" Text='<%# Bind("TR_NAME") %>'>
                                            </asp:TextBox><br />
                                            TCR_NAME:
                                            <asp:TextBox ID="TCR_NAMETextBox" runat="server" Text='<%# Bind("TCR_NAME") %>'>
                                            </asp:TextBox><br />
                                            SCHOOL:
                                            <asp:TextBox ID="SCHOOLTextBox" runat="server" Text='<%# Bind("SCHOOL") %>'>
                                            </asp:TextBox><br />
                                            SPECIALITY:
                                            <asp:TextBox ID="SPECIALITYTextBox" runat="server" Text='<%# Bind("SPECIALITY") %>'>
                                            </asp:TextBox><br />
                                            COSINTRO:
                                            <asp:TextBox ID="COSINTROTextBox" runat="server" Text='<%# Bind("COSINTRO") %>'>
                                            </asp:TextBox><br />
                                            TR_PERSON:
                                            <asp:TextBox ID="TR_PERSONTextBox" runat="server" Text='<%# Bind("TR_PERSON") %>'>
                                            </asp:TextBox><br />
                                            MENO:
                                            <asp:TextBox ID="MENOTextBox" runat="server" Text='<%# Bind("MENO") %>'>
                                            </asp:TextBox><br />
                                            COSDATEB:
                                            <asp:TextBox ID="COSDATEBTextBox" runat="server" Text='<%# Bind("COSDATEB") %>'>
                                            </asp:TextBox><br />
                                            COSDATEE:
                                            <asp:TextBox ID="COSDATEETextBox" runat="server" Text='<%# Bind("COSDATEE") %>'>
                                            </asp:TextBox><br />
                                            TR_CNT:
                                            <asp:TextBox ID="TR_CNTTextBox" runat="server" Text='<%# Bind("TR_CNT") %>'>
                                            </asp:TextBox><br />
                                            SIGNDATE_E:
                                            <asp:TextBox ID="SIGNDATE_ETextBox" runat="server" Text='<%# Bind("SIGNDATE_E") %>'>
                                            </asp:TextBox><br />
                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="更新">
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="取消">
                                            </asp:LinkButton>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            DESCR:
                                            <asp:TextBox ID="DESCRTextBox" runat="server" Text='<%# Bind("DESCR") %>'>
                                            </asp:TextBox><br />
                                            COSCODE:
                                            <asp:TextBox ID="COSCODETextBox" runat="server" Text='<%# Bind("COSCODE") %>'>
                                            </asp:TextBox><br />
                                            YYMM:
                                            <asp:TextBox ID="YYMMTextBox" runat="server" Text='<%# Bind("YYMM") %>'>
                                            </asp:TextBox><br />
                                            SER:
                                            <asp:TextBox ID="SERTextBox" runat="server" Text='<%# Bind("SER") %>'>
                                            </asp:TextBox><br />
                                            TR_NAME:
                                            <asp:TextBox ID="TR_NAMETextBox" runat="server" Text='<%# Bind("TR_NAME") %>'>
                                            </asp:TextBox><br />
                                            TCR_NAME:
                                            <asp:TextBox ID="TCR_NAMETextBox" runat="server" Text='<%# Bind("TCR_NAME") %>'>
                                            </asp:TextBox><br />
                                            SCHOOL:
                                            <asp:TextBox ID="SCHOOLTextBox" runat="server" Text='<%# Bind("SCHOOL") %>'>
                                            </asp:TextBox><br />
                                            SPECIALITY:
                                            <asp:TextBox ID="SPECIALITYTextBox" runat="server" Text='<%# Bind("SPECIALITY") %>'>
                                            </asp:TextBox><br />
                                            COSINTRO:
                                            <asp:TextBox ID="COSINTROTextBox" runat="server" Text='<%# Bind("COSINTRO") %>'>
                                            </asp:TextBox><br />
                                            TR_PERSON:
                                            <asp:TextBox ID="TR_PERSONTextBox" runat="server" Text='<%# Bind("TR_PERSON") %>'>
                                            </asp:TextBox><br />
                                            MENO:
                                            <asp:TextBox ID="MENOTextBox" runat="server" Text='<%# Bind("MENO") %>'>
                                            </asp:TextBox><br />
                                            COSDATEB:
                                            <asp:TextBox ID="COSDATEBTextBox" runat="server" Text='<%# Bind("COSDATEB") %>'>
                                            </asp:TextBox><br />
                                            COSDATEE:
                                            <asp:TextBox ID="COSDATEETextBox" runat="server" Text='<%# Bind("COSDATEE") %>'>
                                            </asp:TextBox><br />
                                            TR_CNT:
                                            <asp:TextBox ID="TR_CNTTextBox" runat="server" Text='<%# Bind("TR_CNT") %>'>
                                            </asp:TextBox><br />
                                            SIGNDATE_E:
                                            <asp:TextBox ID="SIGNDATE_ETextBox" runat="server" Text='<%# Bind("SIGNDATE_E") %>'>
                                            </asp:TextBox><br />
                                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                Text="插入">
                                            </asp:LinkButton>
                                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="取消">
                                            </asp:LinkButton>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            <table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                        課程名稱</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                        日期</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                        地點</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                        承辦單位</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                        課程大綱</td>
                                                </tr>
                                                <tr>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        <asp:Label ID="DESCRLabel" runat="server" Text='<%# Bind("DESCR") %>'></asp:Label>/<asp:Label
                                                            ID="COSCODELabel" runat="server" Text='<%# Bind("COSCODE") %>'></asp:Label>/<asp:Label
                                                                ID="YYMMLabel" runat="server" Text='<%# Bind("YYMM") %>'></asp:Label>/<asp:Label
                                                                    ID="SERLabel" runat="server" Text='<%# Bind("SER") %>'></asp:Label></td>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        <asp:Label ID="COSDATEBLabel" runat="server" Text='<%# Bind("COSDATEB", "{0:d}") %>'></asp:Label>-<asp:Label
                                                            ID="COSDATEELabel" runat="server" Text='<%# Bind("COSDATEE", "{0:d}") %>'></asp:Label></td>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        &nbsp;<asp:Label ID="Label1" runat="server" Text='<%# Bind("TRADDR") %>'></asp:Label></td>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        <asp:Label ID="TR_NAMELabel" runat="server" Text='<%# Bind("TR_NAME") %>'></asp:Label>&nbsp;</td>
                                                    <td class="UltraWebGrid1-ic">
                                                        <asp:Label ID="COSINTROLabel" runat="server" Text='<%# Bind("COSINTRO") %>'></asp:Label>&nbsp;</td>
                                                </tr>
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap" align="center">
                                                        講師/學歷/專長</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap" align="center">
                                                        訓練對象</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap" align="center">
                                                        預計上課人數</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap" align="center">
                                                        回覆日期</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="nowrap" align="center">
                                                        備註</td>
                                                </tr>
                                                <tr>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        <asp:Label ID="TCR_NAMELabel" runat="server" Text='<%# Bind("TCR_NAME") %>'></asp:Label>/<asp:Label
                                                            ID="SCHOOLLabel" runat="server" Text='<%# Bind("SCHOOL") %>'></asp:Label>/<asp:Label
                                                                ID="SPECIALITYLabel" runat="server" Text='<%# Bind("SPECIALITY") %>'></asp:Label>&nbsp;</td>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        <asp:Label ID="TR_PERSONLabel" runat="server" Text='<%# Bind("TR_PERSON") %>'></asp:Label>&nbsp;</td>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        <asp:Label ID="TR_CNTLabel" runat="server" Text='<%# Bind("TR_CNT") %>'></asp:Label>&nbsp;</td>
                                                    <td class="UltraWebGrid1-ic" nowrap="nowrap" align="center">
                                                        <asp:Label ID="SIGNDATE_ELabel" runat="server" Text='<%# Bind("SIGNDATE_E") %>'></asp:Label>&nbsp;</td>
                                                    <td class="UltraWebGrid1-ic">
                                                        <asp:Label ID="MENOLabel" runat="server" Text='<%# Bind("MENO") %>'></asp:Label>&nbsp;</td>
                                                </tr>
                                            </table>
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                        SelectCommand="SELECT TRCOS.DESCR, TRCOS.COSCODE, TRCOS.YYMM, TRCOS.SER, TRCOMPY.TR_NAME, TRTCR.TCR_NAME, TRTCR.SCHOOL, TRTCR.SPECIALITY, TRCOS.COSINTRO, TRCOS.TR_PERSON, TRCOS.MENO, TRCOS.COSDATEB, TRCOS.COSDATEE, TRCOS.TR_CNT, TRCOS.SIGNDATE_E, TRCOS.TRADDR FROM TRTCR RIGHT OUTER JOIN TRTCRDT ON TRTCR.TCR_NO = TRTCRDT.TCR_NO RIGHT OUTER JOIN TRCOS ON TRTCRDT.COSCODE = TRCOS.COSCODE AND TRTCRDT.SER = TRCOS.SER AND TRTCRDT.YYMM = TRCOS.YYMM LEFT OUTER JOIN TRCOMPY ON TRCOS.TR_NO = TRCOMPY.TR_NO WHERE (TRCOS.COSCODE = @COSCODE) AND (TRCOS.YYMM = @YYMM) AND (TRCOS.SER = @SER)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="ddlCourse" Name="COSCODE" PropertyName="SelectedValue" />
                                            <asp:ControlParameter ControlID="ddlYYMM" Name="YYMM" PropertyName="SelectedValue" />
                                            <asp:ControlParameter ControlID="ddlSer" Name="SER" PropertyName="SelectedValue" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:LinkButton ID="lbtnUpload" runat="server" CommandName="Upload" OnClick="lbtnUpload_Click">受訓文件管理</asp:LinkButton>
                                    <asp:LinkButton ID="lbtnCosDataEdit" runat="server" CommandName="CosDataEdit" OnClick="lbtnUpload_Click">相關資料編輯</asp:LinkButton>
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvTrain" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        ForeColor="#333333" GridLines="None" Width="100%" OnRowDataBound="gvTrain_RowDataBound">
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                                        <Columns>
                                            <asp:TemplateField HeaderText="顯示">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbAdd" runat="server" Checked='<%# Bind("bAdd") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="寄送">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbSend" runat="server" Checked='<%# Bind("bSend") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="必修">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="cbSelect" runat="server" Checked='<%# Bind("bSelect") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="工號" SortExpression="NOBR">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("NOBR") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblNobr" runat="server" Text='<%# Bind("NOBR") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="姓名" SortExpression="NAME_C">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("NAME_C") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblName" runat="server" Text='<%# Bind("NAME_C") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="編制部門" SortExpression="D_NAME">
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("D_NAME") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                                <ItemTemplate>
                                                    <asp:Label ID="lblDept" runat="server" Text='<%# Bind("D_NAME") %>'></asp:Label>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="DS_NAME" HeaderText="成本中心" SortExpression="DS_NAME" />
                                            <asp:BoundField DataField="JOB_NAME" HeaderText="職稱" SortExpression="JOB_NAME" />
                                        </Columns>
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <AlternatingRowStyle BackColor="White" />
                                    </asp:GridView>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    電子信箱：<asp:TextBox ID="txtMail" runat="server" CssClass="txtBoxLine"></asp:TextBox>(您可寫一個信箱先行測試，查看信件內容是否正確)</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:CheckBox ID="cbWrite" runat="server" Text="將資料寫入訓練系統" />
                                    <asp:Button ID="btnSend" runat="server" CssClass="UltraWebGrid1-hc" OnClick="btnSend_Click"
                                        OnClientClick="return confirm('您確定要通知嗎？');" Text="送出通知" />
                                    <asp:Button ID="btnCancel" runat="server" CssClass="UltraWebGrid1-hc" OnClick="btnCancel_Click" Text="放棄儲存" /></td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView>
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        &nbsp; &nbsp;&nbsp; &nbsp;&nbsp; &nbsp;
    
    </div>
    </form>
</body>
</html>
