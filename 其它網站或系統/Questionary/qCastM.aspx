<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qCastM.aspx.cs" Inherits="qCastM"
    ValidateRequest="false" MasterPageFile="~/MasterPage_WithSubMenu.master" Title="分類-中分類" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td nowrap="nowrap">
                            <asp:FormView ID="fv" runat="server" DataKeyNames="VALCODE" DataSourceID="sdsFV"
                                DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting"
                                OnItemUpdated="fv_ItemUpdated" OnItemUpdating="fv_ItemUpdating" OnModeChanged="fv_ModeChanged"
                                Width="100%">
                                <EditItemTemplate><table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            代碼</td>
                                        <td align="center" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap">
                                            評量群組名稱</td>
                                        <td align="center" class="UltraWebGrid1-hc" colspan="1" nowrap="nowrap">
                                            答案類型</td>
                                        <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="2" width="1%">
                                                <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                                    Text="修改" />
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False"
                                                        CommandName="Cancel" CssClass="UltraWebGrid1-hc" Text="取消" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-ic" width="1%">
                                            <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="2"
                                                ReadOnly="True" Text='<%# Bind("VALCODE") %>' Width="15px"></asp:TextBox></td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="4">
                                            <asp:TextBox ID="sNameTextBox" runat="server" CssClass="txtBoxLine" MaxLength="200"
                                                Text='<%# Bind("VALNAME") %>' Width="95%"></asp:TextBox>&nbsp;
                                        </td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="1" width="1%">
                                            <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("CATE") %>'>
                                                <asp:ListItem Value="1">五分</asp:ListItem>
                                                <asp:ListItem Value="2">是與否</asp:ListItem>
                                                <asp:ListItem Value="3">意見</asp:ListItem>
                                            </asp:DropDownList></td>
                                    </tr>
                                </table>
                                   
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                        <tr>
                                            <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                代碼</td>
                                            <td align="center" class="UltraWebGrid1-hc" colspan="4" nowrap="nowrap">
                                                評量群組名稱</td>
                                            <td align="center" class="UltraWebGrid1-hc" colspan="1" nowrap="nowrap">
                                                答案類型</td>
                                            <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="2" width="1%">
                                                <asp:Button ID="Button1" runat="server" CommandName="Insert" CssClass="UltraWebGrid1-hc"
                                                    Text="新增" /></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="UltraWebGrid1-ic" width="1%">
                                                <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("VALCODE") %>' MaxLength="2" Width="15px"></asp:TextBox></td>
                                            <td align="center" class="UltraWebGrid1-ic" colspan="4">
                                                <asp:TextBox ID="sNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("VALNAME") %>' MaxLength="200" Width="95%"></asp:TextBox>&nbsp;
                                            </td>
                                            <td align="center" class="UltraWebGrid1-ic" colspan="1" width="1%">
                                                <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("CATE") %>'>
                                                    <asp:ListItem Value="1" Selected="True">五分</asp:ListItem>
                                                    <asp:ListItem Value="2">是與否</asp:ListItem>
                                                    <asp:ListItem Value="3">意見</asp:ListItem>
                                                </asp:DropDownList></td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>" InsertCommand="INSERT INTO [TRVALGD] ([VALCODE], [VALNAME], [CATE], [KEY_MAN], [KEY_DATE]) VALUES (@VALCODE, @VALNAME, @CATE, @KEY_MAN, @KEY_DATE)"
                                SelectCommand="SELECT * FROM [TRVALGD] WHERE ([VALCODE] = @VALCODE)" UpdateCommand="UPDATE [TRVALGD] SET [VALNAME] = @VALNAME, [CATE] = @CATE, [KEY_MAN] = @KEY_MAN, [KEY_DATE] = @KEY_DATE WHERE [VALCODE] = @VALCODE">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" Name="VALCODE" PropertyName="SelectedValue"
                                        Type="String" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="VALNAME" Type="String" />
                                    <asp:Parameter Name="CATE" Type="String" />
                                    <asp:Parameter Name="KEY_MAN" Type="String" />
                                    <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                    <asp:Parameter Name="VALCODE" Type="String" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="VALCODE" Type="String" />
                                    <asp:Parameter Name="VALNAME" Type="String" />
                                    <asp:Parameter Name="CATE" Type="String" />
                                    <asp:Parameter Name="KEY_MAN" Type="String" />
                                    <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            
                        </td>
                    </tr>
                    <tr>
                        <td nowrap="nowrap">
                            <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="VALCODE" DataSourceID="sdsGV" OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound"
                                OnSelectedIndexChanged="gv_SelectedIndexChanged" Width="100%">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                                Text="選取"></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="False" CommandName="Add"
                                                Text="編輯分類題目" CommandArgument='<%# Bind("VALCODE") %>' ToolTip='<%# Bind("CATE") %>'></asp:LinkButton>
                                            <asp:LinkButton ID="lbtnDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                                OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" CommandArgument='<%# Bind("cou") %>'></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="1%" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="VALCODE" HeaderText="代碼" ReadOnly="True" SortExpression="VALCODE" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VALNAME" HeaderText="評量群組名稱" SortExpression="VALNAME" />
                                    <asp:BoundField DataField="CATE" HeaderText="答案類型" SortExpression="CATE" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="cou" HeaderText="子類別數量" SortExpression="cou" >
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
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
                                DeleteCommand="DELETE FROM [TRVALGD] WHERE [VALCODE] = @VALCODE" SelectCommand="SELECT VALCODE, VALNAME, CATE, KEY_MAN, KEY_DATE, (SELECT COUNT(*) AS c FROM TRVALGDG WHERE (VALCODE = TRVALGD.VALCODE)) AS cou FROM TRVALGD">
                                <DeleteParameters>
                                    <asp:Parameter Name="VALCODE" Type="String" />
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
