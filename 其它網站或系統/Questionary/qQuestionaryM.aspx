<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qQuestionaryM.aspx.cs" Inherits="qQuestionaryM"
    ValidateRequest="false" MasterPageFile="~/MasterPage_WithSubMenu.master" Title="問卷-大分類" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div>
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
                    <asp:View ID="View1" runat="server">
                        <table cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td nowrap="nowrap">
                        <asp:FormView ID="fv" runat="server" DataKeyNames="AUTOKEY" DataSourceID="sdsFV"
                            DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting"
                            OnItemUpdated="fv_ItemUpdated" OnItemUpdating="fv_ItemUpdating" OnModeChanged="fv_ModeChanged"
                            Width="100%">
                            <InsertItemTemplate>
                                <table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            代碼</td>
                                        <td align="center" class="UltraWebGrid1-hc" colspan="5" nowrap="nowrap">
                                            問卷名稱</td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="1" nowrap="nowrap" rowspan="2"
                                            width="1%">
                                            <asp:Button ID="Button1" runat="server" CommandName="Insert" CssClass="UltraWebGrid1-hc"
                                                Text="新增" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-ic" width="1%">
                                            <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="3"
                                                Text='<%# Bind("TRQCODE") %>' Width="20px"></asp:TextBox></td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="5">
                                            <asp:TextBox ID="sNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("TRQNAME") %>'
                                                Width="95%" MaxLength="50"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td class="UltraWebGrid1-ic" colspan="7">
                                            問卷頁首、頁尾、內容於新增後再行修改。</td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                            <EditItemTemplate>
                                <table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            代碼</td>
                                        <td align="center" class="UltraWebGrid1-hc" colspan="5" nowrap="nowrap">
                                            問卷名稱</td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="1" nowrap="nowrap" rowspan="2"
                                            width="1%">
                                            <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                                Text="修改" />&nbsp;<asp:Button ID="Button2" runat="server" CausesValidation="False"
                                                    CommandName="Cancel" CssClass="UltraWebGrid1-hc" Text="取消" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-ic" width="1%">
                                            <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="3"
                                                Text='<%# Bind("TRQCODE") %>' Width="20px"></asp:TextBox></td>
                                        <td align="center" class="UltraWebGrid1-ic" colspan="5">
                                            <asp:TextBox ID="sNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("TRQNAME") %>'
                                                Width="95%" MaxLength="50"></asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("AUTOKEY") %>' Visible="False"></asp:Label>
                            </EditItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            InsertCommand="INSERT INTO [TRQ] ([TRQCODE], [TRQNAME], [HEADER], [FOOTER], [CONTENT], [KEY_MAN], [KEY_DATE]) VALUES (@TRQCODE, @TRQNAME, @HEADER, @FOOTER, @CONTENT, @KEY_MAN, @KEY_DATE)"
                            SelectCommand="SELECT * FROM [TRQ] WHERE ([AUTOKEY] = @AUTOKEY)"
                            UpdateCommand="UPDATE TRQ SET TRQCODE = @TRQCODE, TRQNAME = @TRQNAME, KEY_MAN = @KEY_MAN, KEY_DATE = @KEY_DATE WHERE (AUTOKEY = @AUTOKEY)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gv" Name="AUTOKEY" PropertyName="SelectedValue"
                                    Type="Int32" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="TRQCODE" Type="String" />
                                <asp:Parameter Name="TRQNAME" Type="String" />
                                <asp:Parameter Name="KEY_MAN" Type="String" />
                                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                <asp:Parameter Name="AUTOKEY" Type="Int32" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="TRQCODE" Type="String" />
                                <asp:Parameter Name="TRQNAME" Type="String" />
                                <asp:Parameter Name="HEADER" Type="String" />
                                <asp:Parameter Name="FOOTER" Type="String" />
                                <asp:Parameter Name="CONTENT" Type="String" />
                                <asp:Parameter Name="KEY_MAN" Type="String" />
                                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td nowrap="nowrap">
                        <asp:GridView ID="gv" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AUTOKEY" DataSourceID="sdsGV" OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound"
                            OnSelectedIndexChanged="gv_SelectedIndexChanged" Width="100%">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="選取"></asp:LinkButton>
                                        <asp:LinkButton ID="lbtnAdd" runat="server" CausesValidation="False" CommandArgument='<%# Eval("TRQCODE") %>'
                                            CommandName="Add" Text="編輯分類題目"></asp:LinkButton>
                                        <asp:LinkButton ID="LinkButton4" runat="server" CausesValidation="False" CommandName="View"
                                            Text="預覽" CommandArgument='<%# Bind("TRQCODE") %>'></asp:LinkButton>
                                        <asp:LinkButton ID="lbtnDelete" runat="server" CausesValidation="False" CommandName="Delete"
                                            OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除" CommandArgument='<%# Bind("cou") %>'></asp:LinkButton>
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" Wrap="False" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="TRQCODE" HeaderText="代碼" SortExpression="TRQCODE" >
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="TRQNAME" HeaderText="名稱" SortExpression="TRQNAME" />
                                <asp:TemplateField HeaderText="頁首" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandArgument='<%# Bind("AUTOKEY") %>'
                                            CommandName="HEADER" Text="編輯" ToolTip='<%# Bind("HEADER") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="內容" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button ID="Button5" runat="server" CausesValidation="False" CommandArgument='<%# Bind("AUTOKEY") %>'
                                            CommandName="CONTENT" Text="編輯" ToolTip='<%# Bind("CONTENT") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="頁尾" ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button ID="Button6" runat="server" CausesValidation="False" CommandArgument='<%# Eval("AUTOKEY") %>'
                                            CommandName="FOOTER" Text="編輯" ToolTip='<%# Bind("FOOTER") %>' />
                                    </ItemTemplate>
                                    <ItemStyle Width="1%" />
                                </asp:TemplateField>
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
                                您尚未輸入任何資料。
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            DeleteCommand="DELETE FROM [TRQ] WHERE [AUTOKEY] = @AUTOKEY" SelectCommand="SELECT AUTOKEY, TRQCODE, TRQNAME, HEADER, FOOTER, CONTENT, KEY_MAN, KEY_DATE, (SELECT COUNT(*) AS c FROM TRQG WHERE (TRQCODE = TRQ.TRQCODE)) AS cou FROM TRQ">
                            <DeleteParameters>
                                <asp:Parameter Name="AUTOKEY" Type="Int32" />
                            </DeleteParameters>
                        </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </asp:View>
                    <asp:View ID="View2" runat="server">
                        <table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                            <tr>
                                <td class="UltraWebGrid1-ic" nowrap="nowrap">
                                    <FCKeditorV2:FCKeditor ID="txt" runat="server" Height="400px" BasePath="./FCKeditor/">
                                    </FCKeditorV2:FCKeditor>
                                </td>
                            </tr>
                            <tr>
                                <td align="right" class="UltraWebGrid1-ic" nowrap="nowrap">
                                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                                Text="修改" OnClick="btnUpdate_Click" />
                                    <asp:Button ID="btnCancel" runat="server" CausesValidation="False"
                                                    CommandName="Cancel" CssClass="UltraWebGrid1-hc" Text="取消" OnClick="btnCancel_Click" /></td>
                            </tr>
                        </table>
                    </asp:View>
                </asp:MultiView>
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    </div>
</asp:Content>
