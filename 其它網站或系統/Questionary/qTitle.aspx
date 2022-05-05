<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qTitle.aspx.cs" Inherits="qTitle"
    MasterPageFile="~/MasterPage_WithSubMenu.master" Title="答案-評量抬頭" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <asp:FormView ID="fv" runat="server" DataKeyNames="VALCODE" DataSourceID="sdsFV"
                            DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting"
                            OnItemUpdated="fv_ItemUpdated" OnItemUpdating="fv_ItemUpdating" OnModeChanged="fv_ModeChanged"
                            Width="100%">
                            <EditItemTemplate><table cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                                <tr>
                                    <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                        代碼</td>
                                    <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                        分數5名稱</td>
                                    <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                        分數4名稱</td>
                                    <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                        分數3名稱</td>
                                    <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                        分數2名稱</td>
                                    <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                        分數1名稱</td>
                                    <td align="center" nowrap="nowrap" class="UltraWebGrid1-ic" colspan="3" rowspan="2"
                                            width="1%">
                                            <asp:Button ID="Button1" runat="server" CommandName="Update" Text="修改" CssClass="UltraWebGrid1-hc" />
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="取消" CssClass="UltraWebGrid1-hc" /></td>
                                </tr>
                                <tr>
                                    <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                        <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="2"
                                            ReadOnly="True" Text='<%# Bind("VALCODE") %>' Width="15px"></asp:TextBox></td>
                                    <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                        <asp:TextBox ID="sFraction5TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                            Text='<%# Bind("L5CAP") %>' Width="60px"></asp:TextBox></td>
                                    <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                        &nbsp;<asp:TextBox ID="sFraction4TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                            Text='<%# Bind("L4CAP") %>' Width="60px"></asp:TextBox></td>
                                    <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                        <asp:TextBox ID="sFraction3TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                            Text='<%# Bind("L3CAP") %>' Width="60px"></asp:TextBox></td>
                                    <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                        <asp:TextBox ID="sFraction2TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                            Text='<%# Bind("L2CAP") %>' Width="60px"></asp:TextBox></td>
                                    <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                        &nbsp;<asp:TextBox ID="sFraction1TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                            Text='<%# Bind("L1CAP") %>' Width="60px"></asp:TextBox></td>
                                </tr>
                            </table>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <table cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            代碼</td>
                                        <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                            分數5名稱</td>
                                        <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                            分數4名稱</td>
                                        <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                            分數3名稱</td>
                                        <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                            分數2名稱</td>
                                        <td align="center" nowrap="nowrap" class="UltraWebGrid1-hc">
                                            分數1名稱</td>
                                        <td align="center" nowrap="nowrap" class="UltraWebGrid1-ic" colspan="3" rowspan="2"
                                            width="1%">
                                            <asp:Button ID="Button1" runat="server" CommandName="Insert" Text="新增" CssClass="UltraWebGrid1-hc" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                            <asp:TextBox ID="sCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="2"
                                                Text='<%# Bind("VALCODE") %>' Width="15px"></asp:TextBox></td>
                                        <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                            <asp:TextBox ID="sFraction5TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                                Text='<%# Bind("L5CAP") %>' Width="60px"></asp:TextBox></td>
                                        <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                            &nbsp;<asp:TextBox ID="sFraction4TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                                Text='<%# Bind("L4CAP") %>' Width="60px"></asp:TextBox></td>
                                        <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                            <asp:TextBox ID="sFraction3TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                                Text='<%# Bind("L3CAP") %>' Width="60px"></asp:TextBox></td>
                                        <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                            <asp:TextBox ID="sFraction2TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                                Text='<%# Bind("L2CAP") %>' Width="60px"></asp:TextBox></td>
                                        <td nowrap="nowrap" class="UltraWebGrid1-ic" align="center">
                                            &nbsp;<asp:TextBox ID="sFraction1TextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                                Text='<%# Bind("L1CAP") %>' Width="60px"></asp:TextBox></td>
                                    </tr>
                                </table>
                            </InsertItemTemplate>
                        </asp:FormView>
                        <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            InsertCommand="INSERT INTO [TRVALCD] ([VALCODE], [L1CAP], [L2CAP], [L3CAP], [L4CAP], [L5CAP], [KEY_MAN], [KEY_DATE], [L1CAPE], [L2CAPE], [L3CAPE], [L4CAPE], [L5CAPE]) VALUES (@VALCODE, @L1CAP, @L2CAP, @L3CAP, @L4CAP, @L5CAP, @KEY_MAN, @KEY_DATE, @L1CAPE, @L2CAPE, @L3CAPE, @L4CAPE, @L5CAPE)"
                            SelectCommand="SELECT * FROM [TRVALCD] WHERE ([VALCODE] = @VALCODE)" UpdateCommand="UPDATE [TRVALCD] SET [L1CAP] = @L1CAP, [L2CAP] = @L2CAP, [L3CAP] = @L3CAP, [L4CAP] = @L4CAP, [L5CAP] = @L5CAP, [KEY_MAN] = @KEY_MAN, [KEY_DATE] = @KEY_DATE, [L1CAPE] = @L1CAPE, [L2CAPE] = @L2CAPE, [L3CAPE] = @L3CAPE, [L4CAPE] = @L4CAPE, [L5CAPE] = @L5CAPE WHERE [VALCODE] = @VALCODE">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="gv" Name="VALCODE" PropertyName="SelectedValue"
                                    Type="String" />
                            </SelectParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="L1CAP" Type="String" />
                                <asp:Parameter Name="L2CAP" Type="String" />
                                <asp:Parameter Name="L3CAP" Type="String" />
                                <asp:Parameter Name="L4CAP" Type="String" />
                                <asp:Parameter Name="L5CAP" Type="String" />
                                <asp:Parameter Name="KEY_MAN" Type="String" />
                                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                <asp:Parameter Name="L1CAPE" Type="String" />
                                <asp:Parameter Name="L2CAPE" Type="String" />
                                <asp:Parameter Name="L3CAPE" Type="String" />
                                <asp:Parameter Name="L4CAPE" Type="String" />
                                <asp:Parameter Name="L5CAPE" Type="String" />
                                <asp:Parameter Name="VALCODE" Type="String" />
                            </UpdateParameters>
                            <InsertParameters>
                                <asp:Parameter Name="VALCODE" Type="String" />
                                <asp:Parameter Name="L1CAP" Type="String" />
                                <asp:Parameter Name="L2CAP" Type="String" />
                                <asp:Parameter Name="L3CAP" Type="String" />
                                <asp:Parameter Name="L4CAP" Type="String" />
                                <asp:Parameter Name="L5CAP" Type="String" />
                                <asp:Parameter Name="KEY_MAN" Type="String" />
                                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                <asp:Parameter Name="L1CAPE" Type="String" />
                                <asp:Parameter Name="L2CAPE" Type="String" />
                                <asp:Parameter Name="L3CAPE" Type="String" />
                                <asp:Parameter Name="L4CAPE" Type="String" />
                                <asp:Parameter Name="L5CAPE" Type="String" />
                            </InsertParameters>
                        </asp:SqlDataSource>
                       
                    </td>
                </tr>
                <tr>
                    <td>
                        <asp:GridView ID="gv" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="VALCODE" DataSourceID="sdsGV" Width="100%" OnRowDataBound="gv_RowDataBound" OnSelectedIndexChanged="gv_SelectedIndexChanged">
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
                                <asp:BoundField DataField="VALCODE" HeaderText="代碼" ReadOnly="True" SortExpression="VALCODE" >
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="L5CAP" HeaderText="分數5名稱" SortExpression="L5CAP" >
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="L4CAP" HeaderText="分數4名稱" SortExpression="L4CAP" >
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="L3CAP" HeaderText="分數3名稱" SortExpression="L3CAP" >
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="L2CAP" HeaderText="分數2名稱" SortExpression="L2CAP" >
                                    <ItemStyle HorizontalAlign="Center" />
                                </asp:BoundField>
                                <asp:BoundField DataField="L1CAP" HeaderText="分數1名稱" SortExpression="L1CAP" >
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
                                您尚未輸入任何資料，請先新增資料。
                            </EmptyDataTemplate>
                        </asp:GridView>
                        <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            DeleteCommand="DELETE FROM [TRVALCD] WHERE [VALCODE] = @VALCODE" SelectCommand="SELECT * FROM [TRVALCD]">
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
</asp:Content>
