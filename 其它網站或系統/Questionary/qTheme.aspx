<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qTheme.aspx.cs" Inherits="qTheme"
    ValidateRequest="false" MasterPageFile="~/MasterPage_WithSubMenu.master" Title="題目-小分類" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <table width="100%" cellpadding="0" cellspacing="0">
                    <tr>
                        <td nowrap="nowrap">
                            <asp:FormView ID="fv" runat="server" DataKeyNames="ASKCODE" DataSourceID="sdsFV"
                                DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting"
                                OnItemUpdated="fv_ItemUpdated" OnItemUpdating="fv_ItemUpdating" OnModeChanged="fv_ModeChanged"
                                Width="100%">
                                <EditItemTemplate><table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            代碼</td>
                                        <td align="center" class="UltraWebGrid1-hc" colspan="3" nowrap="nowrap">
                                            題目內容</td>
                                        <td align="center" class="UltraWebGrid1-hc" colspan="1" nowrap="nowrap">
                                            評量抬頭</td>
                                        <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="2" width="1%">
                                                <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                                    Text="修改" />
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False"
                                                        CommandName="Cancel" CssClass="UltraWebGrid1-hc" Text="取消" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-ic">
                                            <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="3"
                                                ReadOnly="True" Text='<%# Bind("ASKCODE") %>' Width="25px"></asp:TextBox></td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="3">
                                            <asp:TextBox ID="sNameTextBox" runat="server" CssClass="txtBoxLine" MaxLength="60"
                                                Text='<%# Bind("ASKDESCRC") %>' Width="360px"></asp:TextBox></td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="1">
                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsTitle" DataTextField="CAP"
                                                    DataValueField="VALCODE" SelectedValue='<%# Bind("VALCODE") %>'>
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sdsTitle" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                    SelectCommand="SELECT VALCODE, RTRIM(VALCODE) + '| ' + RTRIM(L5CAP) + ' ' + RTRIM(L4CAP) + ' ' + RTRIM(L3CAP) + ' ' + RTRIM(L2CAP) + ' ' + RTRIM(L1CAP) AS CAP FROM TRVALCD">
                                            </asp:SqlDataSource>
                                        </td>
                                    </tr>
                                </table>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                        <tr>
                                            <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                代碼</td>
                                            <td align="center" class="UltraWebGrid1-hc" colspan="3" nowrap="nowrap">
                                                題目內容</td>
                                            <td align="center" class="UltraWebGrid1-hc" colspan="1" nowrap="nowrap">
                                                評量抬頭</td>
                                            <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="2" width="1%">
                                                <asp:Button ID="Button1" runat="server" CommandName="Insert" CssClass="UltraWebGrid1-hc"
                                                    Text="新增" /></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="UltraWebGrid1-ic">
                                                <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("ASKCODE") %>' MaxLength="3" Width="25px"></asp:TextBox></td>
                                            <td align="center" class="UltraWebGrid1-ic" colspan="3">
                                                <asp:TextBox ID="sNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("ASKDESCRC") %>' MaxLength="60" Width="360px"></asp:TextBox></td>
                                            <td align="center" class="UltraWebGrid1-ic" colspan="1">
                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsTitle" DataTextField="CAP"
                                                    DataValueField="VALCODE" SelectedValue='<%# Bind("VALCODE") %>'>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="sdsTitle" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                    SelectCommand="SELECT VALCODE, RTRIM(VALCODE) + '| ' + RTRIM(L5CAP) + ' ' + RTRIM(L4CAP) + ' ' + RTRIM(L3CAP) + ' ' + RTRIM(L2CAP) + ' ' + RTRIM(L1CAP) AS CAP FROM TRVALCD"></asp:SqlDataSource>
                                            </td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                InsertCommand="INSERT INTO [TRASKCD] ([ASKCODE], [ASKDESCRC], [ASKDESCRE], [TEMPLATE], [KEY_MAN], [KEY_DATE], [VALCODE], [TCR_NO]) VALUES (@ASKCODE, @ASKDESCRC, @ASKDESCRE, @TEMPLATE, @KEY_MAN, @KEY_DATE, @VALCODE, @TCR_NO)"
                                SelectCommand="SELECT * FROM [TRASKCD] WHERE ([ASKCODE] = @ASKCODE)" UpdateCommand="UPDATE TRASKCD SET ASKDESCRC = @ASKDESCRC, KEY_MAN = @KEY_MAN, KEY_DATE = @KEY_DATE, VALCODE = @VALCODE WHERE (ASKCODE = @ASKCODE)">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" Name="ASKCODE" PropertyName="SelectedValue"
                                        Type="String" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="ASKDESCRC" Type="String" />
                                    <asp:Parameter Name="KEY_MAN" Type="String" />
                                    <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                    <asp:Parameter Name="VALCODE" Type="String" />
                                    <asp:Parameter Name="ASKCODE" Type="String" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="ASKCODE" Type="String" />
                                    <asp:Parameter Name="ASKDESCRC" Type="String" />
                                    <asp:Parameter Name="ASKDESCRE" Type="String" />
                                    <asp:Parameter Name="TEMPLATE" Type="String" />
                                    <asp:Parameter Name="KEY_MAN" Type="String" />
                                    <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                    <asp:Parameter Name="VALCODE" Type="String" />
                                    <asp:Parameter Name="TCR_NO" Type="String" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                           
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:GridView ID="gv" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="ASKCODE" DataSourceID="sdsGV" OnRowDataBound="gv_RowDataBound" OnSelectedIndexChanged="gv_SelectedIndexChanged"
                                OnRowCommand="gv_RowCommand" Width="100%" AllowPaging="True">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                Text="選取"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandName="Delete"
                                                OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="1%" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="ASKCODE" HeaderText="代碼" ReadOnly="True" SortExpression="ASKCODE" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="ASKDESCRC" HeaderText="題目內容" SortExpression="ASKDESCRC" />
                                    <asp:BoundField DataField="CAP" HeaderText="評量抬頭" SortExpression="CAP" />
                                    <asp:BoundField DataField="KEY_MAN" HeaderText="登錄者" SortExpression="KEY_MAN" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="KEY_DATE" DataFormatString="{0:d}" HeaderText="登錄日期" HtmlEncode="False"
                                        SortExpression="KEY_DATE" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                                <EmptyDataTemplate>
                                    您尚未輸入任何資料，請先<asp:LinkButton ID="LinkButton3" runat="server" CommandName="New">按我</asp:LinkButton>新增資料。
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                DeleteCommand="DELETE FROM [TRASKCD] WHERE [ASKCODE] = @ASKCODE" SelectCommand="SELECT TRASKCD.ASKCODE, TRASKCD.ASKDESCRC, TRASKCD.ASKDESCRE, TRASKCD.TEMPLATE, TRASKCD.KEY_MAN, TRASKCD.KEY_DATE, TRASKCD.VALCODE, TRASKCD.TCR_NO, RTRIM(TRASKCD.VALCODE) + '| ' + RTRIM(TRVALCD.L5CAP) + ' ' + RTRIM(TRVALCD.L4CAP) + ' ' + RTRIM(TRVALCD.L3CAP) + ' ' + RTRIM(TRVALCD.L2CAP) + ' ' + RTRIM(TRVALCD.L1CAP) AS CAP FROM TRASKCD INNER JOIN TRVALCD ON TRASKCD.VALCODE = TRVALCD.VALCODE">
                                <DeleteParameters>
                                    <asp:Parameter Name="ASKCODE" Type="String" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        
    </div>
</asp:Content>
