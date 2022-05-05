<%@ Page Language="C#" MasterPageFile="~/MasterPage_WithSubMenu.master" AutoEventWireup="true" CodeFile="qAmountQuestionary.aspx.cs" Inherits="qAmountQuestionary" Title="問卷-產生" ValidateRequest="false"%>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table width="100%" cellpadding="0" cellspacing="0">
                <tr>
                    <td width="100%">
                        <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
                            <asp:View ID="View1" runat="server">
                                <table cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                                    <tr>
                                        <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                            問卷分類代碼</td>
                                        <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                            問卷代碼+年月+期別+課程代碼</td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                            問卷分類名稱</td>
                                        <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                            問卷名稱+"-"+課程名稱</td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                            年月/期別/課程</td>
                                        <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                            <asp:DropDownList ID="ddlYYMM" runat="server" AutoPostBack="True" DataSourceID="sdsYYMM"
                                                DataTextField="YYMM" DataValueField="YYMM">
                                            </asp:DropDownList><asp:DropDownList ID="ddlSer" runat="server" AutoPostBack="True"
                                                DataSourceID="sdsSer" DataTextField="SERname" DataValueField="SER">
                                            </asp:DropDownList><asp:DropDownList ID="ddlCosCode" runat="server" DataSourceID="sdsCosCode"
                                                DataTextField="DESCR" DataValueField="COSCODE">
                                            </asp:DropDownList><asp:SqlDataSource ID="sdsYYMM" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                SelectCommand="SELECT DISTINCT RTRIM(YYMM) AS YYMM FROM TRCOS ORDER BY YYMM DESC">
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsSer" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                SelectCommand="SELECT DISTINCT RTRIM(SER) AS SER, '第' + RTRIM(SER) + '期' AS SERname FROM TRCOS WHERE (YYMM = @YYMM) ORDER BY SER DESC">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlYYMM" Name="YYMM" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                            <asp:SqlDataSource ID="sdsCosCode" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                SelectCommand="SELECT DISTINCT RTRIM(COSCODE) AS COSCODE, RTRIM(DESCR) AS DESCR FROM TRCOS WHERE (YYMM = @YYMM) AND (SER = @SER) ORDER BY COSCODE">
                                                <SelectParameters>
                                                    <asp:ControlParameter ControlID="ddlYYMM" Name="YYMM" PropertyName="SelectedValue" />
                                                    <asp:ControlParameter ControlID="ddlSer" Name="SER" PropertyName="SelectedValue" />
                                                </SelectParameters>
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                            問卷</td>
                                        <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                            <asp:DropDownList ID="ddlQuestionaryCode" runat="server" DataSourceID="sdsQuestionary"
                                                DataTextField="TRQNAME" DataValueField="TRQCODE">
                                            </asp:DropDownList><asp:SqlDataSource ID="sdsQuestionary" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                SelectCommand="SELECT TRQCODE, TRQCODE + '｜ ' + TRQNAME AS TRQNAME FROM TRQ"></asp:SqlDataSource>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="UltraWebGrid1-hc" nowrap="nowrap" width="1%">
                                            填卷生失效日</td>
                                        <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                            從<asp:TextBox ID="txtDateB" runat="server" CssClass="txtBoxLine" ToolTip="yyyy/MM/dd" Width="70px"></asp:TextBox>到<asp:TextBox
                                                ID="txtDateE" runat="server" CssClass="txtBoxLine" ToolTip="yyyy/MM/dd" Width="70px"></asp:TextBox>止</td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="UltraWebGrid1-ic" colspan="2" nowrap="nowrap" rowspan="1">
                                            <asp:Button ID="btnView" runat="server" CssClass="UltraWebGrid1-hc" OnClick="btnView_Click"
                                                OnClientClick="return confirm('您確定要產預覽嗎？可能需要一點時間，請稍後…');" Text="預覽(不會儲存)" /></td>
                                    </tr>
                                </table>
                            </asp:View>
                            <asp:View ID="View2" runat="server">
                                <table cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                                    <tr>
                                        <td nowrap="nowrap">
                                            <asp:FormView ID="fv" runat="server" Width="100%" EnableTheming="True">
                                                <ItemTemplate>
                                                    <table cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                                                        <tr>
                                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                                問卷分類代碼</td>
                                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                                問卷分類名稱</td>
                                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                                問卷樣版名稱</td>
                                                            <td class="UltraWebGrid1-hc" nowrap="nowrap">
                                                                生失效日</td>
                                                        </tr>
                                                        <tr>
                                                            <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                                <asp:Label ID="sCodeLabel" runat="server" Text='<%# Bind("sCode") %>'></asp:Label></td>
                                                            <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                                <asp:Label ID="sNameLabel" runat="server" Text='<%# Bind("sName") %>'></asp:Label></td>
                                                            <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("sQuestionaryName") %>'></asp:Label></td>
                                                            <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                                                從<asp:Label ID="dDateBLabel" runat="server" Text='<%# Bind("dDateB", "{0:d}") %>'></asp:Label>到<asp:Label
                                                                    ID="dDateELabel" runat="server" Text='<%# Bind("dDateE", "{0:d}") %>'></asp:Label>止</td>
                                                        </tr>
                                                    </table>
                                                </ItemTemplate>
                                            </asp:FormView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td nowrap="nowrap" width="1%">
                                            <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" Width="100%" OnRowDataBound="gv_RowDataBound">
                                                <Columns>
                                                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" >
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" >
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" >
                                                        <ItemStyle HorizontalAlign="Center" />
                                                    </asp:BoundField>
                                                </Columns>
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right" class="UltraWebGrid1-ic" nowrap="nowrap">
                                            <asp:Button ID="btnSubmit" runat="server" CssClass="UltraWebGrid1-hc" OnClick="btnSubmit_Click"
                                                OnClientClick="return confirm('您確定要存入資料庫嗎？');" Text="確定儲存" />
                                            <asp:Button ID="btnCancel" runat="server" CssClass="UltraWebGrid1-hc" OnClick="btnCancel_Click"
                                                OnClientClick="return confirm('您確定要放棄儲存嗎？');" Text="放棄儲存" /></td>
                                    </tr>
                                </table>
                            </asp:View>
                        </asp:MultiView></td>
                </tr>
                <tr>
                    <td width="100%">
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

