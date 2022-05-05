<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Std.aspx.cs" Inherits="TrainIn_Std" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>線上報名---申請</title>
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
            <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label><asp:UpdatePanel ID="upl" runat="server">
                <ContentTemplate>
                    <asp:GridView ID="GV" runat="server" AutoGenerateColumns="False" CellPadding="4"
                        ForeColor="#333333" GridLines="None" Width="100%" DataSourceID="sdsGV" OnRowDataBound="GV_RowDataBound"
                        AllowSorting="True" OnRowCommand="GV_RowCommand">
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                            Wrap="True" />
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                        <EmptyDataTemplate>
                            目前沒有課程。
                        </EmptyDataTemplate>
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
                            <asp:TemplateField HeaderText="報名">
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbtnSign" runat="server">現在無法報名</asp:LinkButton>
                                    <asp:Label ID="lblSign" runat="server" Text="現在無法報名"></asp:Label>
                                    <asp:Panel ID="plSign" runat="server" Style="display: none">
                                        <asp:Label ID="lblEXPECT" runat="server" Text="請輸入上課期望"></asp:Label><br />
                                        <asp:TextBox ID="txtEXPECT" runat="server" Height="100px" TextMode="MultiLine" Width="300px"></asp:TextBox><br />
                                        <asp:Button ID="btnY" runat="server" Text="送出傳簽" />
                                        <asp:Button ID="btnN" runat="server" Text="取消" /></asp:Panel>
                                    <cc1:ModalPopupExtender ID="mpe" runat="server" TargetControlID="lbtnSign" BackgroundCssClass="modalBackground"
                                        PopupControlID="plSign">
                                    </cc1:ModalPopupExtender>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                        SelectCommand="SELECT TRCOS.COSCODE, TRCOS.DESCR, TRCOS.SER, TRCOS.YYMM, TRCOS.COSDATEB, TRCOS.COSDATEE, TRCOS.HOURS, TRCOS.ATTCNT, TRCOS.CLSCNT, TRCOS.CLSPER, TRCOS.ABSCNT, TRCOS.ABTCNT, TRCOS.PREFEE, TRCOS.RELFEE, TRCOS.VALSCORE, TRCOS.VALLEVEL, TRCOS.KEY_MAN, TRCOS.KEY_DATE, TRCOS.TRADDR, TRCOS.COSTIMEB, TRCOS.COSTIMEE, TRCOS.TR_PERSON, TRCOS.TR_CNT, TRCOS.TESTING, TRCOS.HOMEWORK, TRCOS.COSINTRO, TRCOS.RELPER, TRCOS.CLOSENOTE, TRCOS.ADDRCD, TRCOS.SIGNDATE_B, TRCOS.SIGNDATE_E, TRCOS.PREFINAMT, TRCOS.WEB, TRCOS.CRE_DATE, TRCOS.CRE_MAN, TRCOS.TR_NO, TRCOS.SALADR, TRCOS.TR_ASNO, TRCOS.MENO, TRCOS.APPLYNO, TRCOS.PLANIN, TRCOS.PLANTO, TRCOS.TR_ISO, TRCOMPY.TR_NAME FROM TRCOS LEFT OUTER JOIN TRCOMPY ON TRCOS.TR_NO = TRCOMPY.TR_NO WHERE (GETDATE() <= TRCOS.COSDATEB)">
                    </asp:SqlDataSource>
                    <asp:Label ID="lblMsg" runat="server"></asp:Label>
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                    <br />
                </ContentTemplate>
            </asp:UpdatePanel>
            &nbsp;&nbsp;
        </div>
    </form>
</body>
</html>
