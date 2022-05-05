<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Check.aspx.cs" Inherits="TrainIn_Check" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>內訓單---審核</title>
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
        <asp:Button ID="btnPrint" runat="server" CssClass="UltraWebGrid1-hc" OnClientClick="print();"
            Text="列印" /><asp:UpdatePanel ID="upl" runat="server">
                <ContentTemplate>
                    <table border="0" cellpadding="0" cellspacing="0" width="100%">
                        <tr>
                            <td align="center" class="style1" nowrap="nowrap">
                                內訓單審核(<asp:Label ID="lblSign" runat="server"></asp:Label>)</td>
                        </tr>
                        <tr>
                            <td align="center" nowrap="nowrap">
                                <table border="0" class="WebPanel2ctl" style="width: 100%">
                                    <tr>
                                        <td align="center" style="text-align: left" nowrap="noWrap">
                                            <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label><asp:Label
                                                ID="lblNobr" runat="server" Visible="False"></asp:Label><asp:Label ID="lblCosCode"
                                                    runat="server" Visible="False"></asp:Label><asp:Label ID="lblYYMM" runat="server"
                                                        Visible="False"></asp:Label><asp:Label ID="lblSer" runat="server" Visible="False"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        內訓人員基本資料</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:GridView ID="GV" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                            CellPadding="4" DataSourceID="sdsAppS" ForeColor="#333333" GridLines="None" OnRowCommand="GV_RowCommand"
                                                            Width="100%" OnRowDataBound="GV_RowDataBound">
                                                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                            <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                                                            <Columns>
                                                                <asp:BoundField DataField="COSCODE" HeaderText="課程代碼" SortExpression="COSCODE" />
                                                                <asp:TemplateField HeaderText="課程名稱" SortExpression="DESCR">
                                                                    <EditItemTemplate>
                                                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DESCR") %>'></asp:TextBox>
                                                                    </EditItemTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:LinkButton ID="lbtnCosData" runat="server" CommandName="CosData" Text='<%# Eval("DESCR") %>'></asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="開訓日期時間">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDateTimeB" runat="server" Text='<%# Eval("COSCODE") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="結訓日期時間">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDateTimeE" runat="server" Text='<%# Eval("SER") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="HOURS" HeaderText="總時數" SortExpression="HOURS" />
                                                                <asp:BoundField DataField="TR_NAME" HeaderText="承辦單位" SortExpression="TR_NAME" />
                                                                <asp:BoundField DataField="TRADDR" HeaderText="上課地點" SortExpression="TRADDR" />
                                                                <asp:TemplateField HeaderText="講師">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblTcrName" runat="server" Text='<%# Eval("YYMM") %>' Visible="False"></asp:Label><asp:DataList
                                                                            ID="dlTrtcr" runat="server" DataSourceID="sdsTrtcr" OnItemCommand="dlTrtcr_ItemCommand"
                                                                            RepeatDirection="Horizontal">
                                                                            <SeparatorTemplate>
                                                                                &nbsp;,
                                                                            </SeparatorTemplate>
                                                                            <ItemTemplate>
                                                                                <asp:LinkButton ID="lbtnTcrData" runat="server" CommandArgument='<%# Eval("TCR_NO") %>'
                                                                                    CommandName="TcrData" Text='<%# Eval("TCR_NAME") %>' Visible="False"></asp:LinkButton>
                                                                                <asp:Label ID="Label1" runat="server" Text='<%# Eval("TCR_NAME") %>'></asp:Label><br />
                                                                            </ItemTemplate>
                                                                        </asp:DataList>
                                                                        <asp:SqlDataSource ID="sdsTrtcr" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                                            SelectCommand="SELECT TRTCRDT.TCR_NO, TRTCR.TCR_NAME FROM TRTCRDT INNER JOIN TRTCR ON TRTCRDT.TCR_NO = TRTCR.TCR_NO WHERE (RTRIM(TRTCRDT.COSCODE) + RTRIM(TRTCRDT.YYMM) + RTRIM(TRTCRDT.SER) = @COS)">
                                                                            <SelectParameters>
                                                                                <asp:ControlParameter ControlID="lblTcrName" Name="COS" PropertyName="Text" />
                                                                            </SelectParameters>
                                                                        </asp:SqlDataSource>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                            <EmptyDataTemplate>
                                                                目前沒有課程。
                                                            </EmptyDataTemplate>
                                                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                                                                Wrap="True" />
                                                            <EditRowStyle BackColor="#2461BF" />
                                                            <AlternatingRowStyle BackColor="White" />
                                                        </asp:GridView>
                                                    </td>
                                                </tr>
                                            </table>
                                            <asp:SqlDataSource ID="sdsAppS" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>" SelectCommand="SELECT TRCOS.COSCODE, TRCOS.DESCR, TRCOS.SER, TRCOS.YYMM, TRCOS.COSDATEB, TRCOS.COSDATEE, TRCOS.HOURS, TRCOS.ATTCNT, TRCOS.CLSCNT, TRCOS.CLSPER, TRCOS.ABSCNT, TRCOS.ABTCNT, TRCOS.PREFEE, TRCOS.RELFEE, TRCOS.VALSCORE, TRCOS.VALLEVEL, TRCOS.KEY_MAN, TRCOS.KEY_DATE, TRCOS.TRADDR, TRCOS.COSTIMEB, TRCOS.COSTIMEE, TRCOS.TR_PERSON, TRCOS.TR_CNT, TRCOS.TESTING, TRCOS.HOMEWORK, TRCOS.COSINTRO, TRCOS.RELPER, TRCOS.CLOSENOTE, TRCOS.ADDRCD, TRCOS.SIGNDATE_B, TRCOS.SIGNDATE_E, TRCOS.PREFINAMT, TRCOS.WEB, TRCOS.CRE_DATE, TRCOS.CRE_MAN, TRCOS.TR_NO, TRCOS.SALADR, TRCOS.TR_ASNO, TRCOS.MENO, TRCOS.APPLYNO, TRCOS.PLANIN, TRCOS.PLANTO, TRCOS.TR_ISO, TRCOMPY.TR_NAME FROM TRCOS LEFT OUTER JOIN TRCOMPY ON TRCOS.TR_NO = TRCOMPY.TR_NO WHERE (TRCOS.COSCODE = @COSCODE) AND (TRCOS.YYMM = @YYMM) AND (TRCOS.SER = @SER)">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="lblCosCode" Name="COSCODE" PropertyName="Text" />
                                                    <asp:ControlParameter ControlID="lblYYMM" Name="YYMM" PropertyName="Text" />
                                                    <asp:ControlParameter ControlID="lblSer" Name="SER" PropertyName="Text" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:Label ID="lblEXPECTt" runat="server">上課期望：</asp:Label><br />
                                            <asp:Label ID="lblEXPECT" runat="server"></asp:Label><strong><span><span style="font-size: 12pt"><span style="color: blue"><span></span></span></span></span></strong></td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="text-align: left">
                                            <asp:Panel ID="pNote" runat="server">
                                                <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                    <tr>
                                                        <td class="UltraWebGrid1-hc" style="text-align: center">
                                                            簽核者資料</td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:GridView ID="gvNote" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                                                CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsSign" ForeColor="#333333"
                                                                GridLines="None" Width="100%">
                                                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                                                <Columns>
                                                                    <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                                        ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                                                    <asp:BoundField DataField="sFromCode" HeaderText="sFromCode" SortExpression="sFromCode"
                                                                        Visible="False" />
                                                                    <asp:BoundField DataField="sFromName" HeaderText="sFromName" SortExpression="sFromName"
                                                                        Visible="False" />
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
                                                                    <asp:BoundField DataField="sDept" HeaderText="部門代碼" SortExpression="sDept">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                    <asp:BoundField DataField="sNote" HeaderText="意見" SortExpression="sNote" />
                                                                    <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
                                                                    <asp:BoundField DataField="sSign" HeaderText="sSign" SortExpression="sSign" Visible="False" />
                                                                    <asp:BoundField DataField="dKeyDate" HeaderText="簽核時間" SortExpression="dKeyDate">
                                                                        <ItemStyle HorizontalAlign="Center" />
                                                                    </asp:BoundField>
                                                                </Columns>
                                                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                                                                <EmptyDataTemplate>
                                                                    目前尚無任何簽核資料。
                                                                </EmptyDataTemplate>
                                                                <EditRowStyle BackColor="#2461BF" />
                                                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                                                                    Wrap="True" />
                                                                <AlternatingRowStyle BackColor="White" />
                                                            </asp:GridView>
                                                            <asp:SqlDataSource ID="sdsSign" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                                                DeleteCommand="DELETE FROM [wfShiftAppS] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT iAutoKey, sFromCode, sFromName, sProcessID, idProcess, sNobr, sName, sDept, sDeptName, sNote, bSign, sSign, dKeyDate FROM wfSign WHERE (sProcessID = @sProcessID) AND (sFromCode = 'TrainIn')">
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
                                        <td align="center" style="text-align: left">
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" style="text-align: center">
                                                        意見</td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                        <asp:TextBox ID="txtNote" runat="server" Height="100px" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Label ID="lblNote" runat="server"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:RadioButtonList ID="rblCheck" runat="server" Font-Size="X-Large" RepeatDirection="Horizontal"
                                    RepeatLayout="Flow">
                                    <asp:ListItem Selected="True" Value="1">核准</asp:ListItem>
                                    <asp:ListItem Value="0">駁回</asp:ListItem>
                                </asp:RadioButtonList></td>
                        </tr>
                        <tr>
                            <td nowrap="nowrap">
                                <asp:Button ID="btnSign" runat="server" CssClass="UltraWebGrid1-hc" Font-Bold="True"
                                    Font-Size="XX-Large" Font-Underline="False" ForeColor="Blue" OnClick="btnSign_Click"
                                    OnClientClick="return confirm('您確定要送出傳簽嗎？');" Text="送出傳簽" />
                                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label></td>
                        </tr>
                    </table>
                    <asp:Label ID="lblUrl" runat="server"></asp:Label>
                </ContentTemplate>
            </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
