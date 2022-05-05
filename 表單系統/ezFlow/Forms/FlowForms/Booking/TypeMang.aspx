<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TypeMang.aspx.cs" Inherits="Booking_TypeMang" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>預約單---型號管理</title>
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
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
        <table border="0" cellpadding="0" cellspacing="0" class="WebPanel2ctl">
            <tr>
                <td>
                    <asp:FormView ID="fvType" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsTypeFV"
                        DefaultMode="Insert" OnItemInserted="fvType_ItemInserted" OnItemInserting="fvType_ItemInserting"
                        OnItemUpdated="fvType_ItemUpdated" OnItemUpdating="fvType_ItemUpdating" Width="100%">
                        <EditItemTemplate>
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="UltraWebGrid1-hc" align="center" nowrap="noWrap">
                                        型號代碼</td>
                                    <td class="UltraWebGrid1-hc" align="center" nowrap="noWrap">
                                        型號名稱</td>
                                    <td class="UltraWebGrid1-hc" align="center" nowrap="noWrap">
                                        生失效日</td>
                                    <td class="UltraWebGrid1-ic" rowspan="3" align="center" nowrap="noWrap" width="1%">
                                        <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                            Text="修改" /><asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                CssClass="UltraWebGrid1-hc" Text="取消" /></td>
                                </tr>
                                <tr>
                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                        <asp:TextBox ID="sTypeCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                            ReadOnly="True" Text='<%# Bind("sTypeCode") %>' Width="70px"></asp:TextBox></td>
                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                        <asp:TextBox ID="sTypeNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("sTypeName") %>'></asp:TextBox></td>
                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                        自<asp:TextBox ID="dAdateTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("dAdate", "{0:d}") %>'
                                            Width="55px"></asp:TextBox>至<asp:TextBox ID="dDdateTextBox" runat="server" CssClass="txtBoxLine"
                                                Text='<%# Bind("dDdate", "{0:d}") %>' Width="55px"></asp:TextBox>止</td>
                                </tr>
                                <tr>
                                    <td align="right" class="UltraWebGrid1-ic" nowrap="noWrap">
                                        備註</td>
                                    <td class="UltraWebGrid1-ic" colspan="2" align="left" nowrap="noWrap">
                                        <asp:TextBox ID="sNoteTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("sNote") %>'
                                            Width="80%"></asp:TextBox></td>
                                </tr>
                            </table>
                            <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>'></asp:Label>
                        </EditItemTemplate>
                        <InsertItemTemplate>
                            <table border="0" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td class="UltraWebGrid1-hc" align="center" nowrap="noWrap">
                                        型號代碼</td>
                                    <td class="UltraWebGrid1-hc" align="center" nowrap="noWrap">
                                        型號名稱</td>
                                    <td class="UltraWebGrid1-hc" align="center" nowrap="noWrap">
                                        生失效日</td>
                                    <td class="UltraWebGrid1-ic" rowspan="3" align="center" nowrap="noWrap" width="1%">
                                        <asp:Button ID="btn" runat="server" CommandName="Insert" CssClass="UltraWebGrid1-hc" Text="新增" /></td>
                                </tr>
                                <tr>
                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                        <asp:TextBox ID="sTypeCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                            Text='<%# Bind("sTypeCode") %>' Width="70px"></asp:TextBox></td>
                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                        <asp:TextBox ID="sTypeNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("sTypeName") %>'></asp:TextBox></td>
                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                        自<asp:TextBox ID="dAdateTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("dAdate") %>'
                                            Width="55px"></asp:TextBox>至<asp:TextBox ID="dDdateTextBox" runat="server" CssClass="txtBoxLine"
                                                Text='<%# Bind("dDdate") %>' Width="55px"></asp:TextBox>止</td>
                                </tr>
                                <tr>
                                    <td align="right" class="UltraWebGrid1-ic" nowrap="noWrap">
                                        備註</td>
                                    <td class="UltraWebGrid1-ic" colspan="2" align="left" nowrap="noWrap">
                                        <asp:TextBox ID="sNoteTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("sNote") %>'
                                            Width="80%"></asp:TextBox></td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="sdsTypeFV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        InsertCommand="INSERT INTO [wfBookingType] ([sClassCode], [sTypeCode], [sTypeName], [sNote], [dAdate], [dDdate], [sKeyMan], [dKeyDate]) VALUES (@sClassCode, @sTypeCode, @sTypeName, @sNote, @dAdate, @dDdate, @sKeyMan, @dKeyDate)"
                        SelectCommand="SELECT * FROM [wfBookingType] WHERE ([iAutoKey] = @iAutoKey)"
                        UpdateCommand="UPDATE wfBookingType SET sTypeName = @sTypeName, sNote = @sNote, dAdate = @dAdate, dDdate = @dDdate, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate WHERE (iAutoKey = @iAutoKey)">
                        <UpdateParameters>
                            <asp:Parameter Name="sTypeName" Type="String" />
                            <asp:Parameter Name="sNote" Type="String" />
                            <asp:Parameter Name="dAdate" Type="DateTime" />
                            <asp:Parameter Name="dDdate" Type="DateTime" />
                            <asp:Parameter Name="sKeyMan" Type="String" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gvType" Name="iAutoKey" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sClassCode" Type="String" />
                            <asp:Parameter Name="sTypeCode" Type="String" />
                            <asp:Parameter Name="sTypeName" Type="String" />
                            <asp:Parameter Name="sNote" Type="String" />
                            <asp:Parameter Name="dAdate" Type="DateTime" />
                            <asp:Parameter Name="dDdate" Type="DateTime" />
                            <asp:Parameter Name="sKeyMan" Type="String" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvType" runat="server" AutoGenerateColumns="False" CellPadding="4"
                        DataKeyNames="iAutoKey" DataSourceID="sdsTypeGV" ForeColor="#333333" GridLines="None" AllowSorting="True" OnSelectedIndexChanged="gvType_SelectedIndexChanged">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemStyle Width="1%" Wrap="False" />
                                <ItemTemplate>
                                    <asp:LinkButton ID="lbSelect" runat="server" CausesValidation="False" CommandName="Select"
                                        Text="選取"></asp:LinkButton>
                                    <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sTypeCode") %>'
                                        CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sClassCode" HeaderText="sClassCode" SortExpression="sClassCode"
                                Visible="False" />
                            <asp:BoundField DataField="sTypeCode" HeaderText="型號代碼" SortExpression="sTypeCode" />
                            <asp:BoundField DataField="sTypeName" HeaderText="型號名稱" SortExpression="sTypeName" />
                            <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                            <asp:BoundField DataField="dAdate" DataFormatString="{0:d}" HeaderText="生效日" HtmlEncode="False"
                                SortExpression="dAdate" />
                            <asp:BoundField DataField="dDdate" DataFormatString="{0:d}" HeaderText="失效日" HtmlEncode="False"
                                SortExpression="dDdate" />
                            <asp:BoundField DataField="sKeyMan" HeaderText="登錄者" SortExpression="sKeyMan" />
                            <asp:BoundField DataField="dKeyDate" HeaderText="登錄日期" SortExpression="dKeyDate" />
                        </Columns>
                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsTypeGV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        DeleteCommand="DELETE FROM [wfBookingType] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfBookingType] ([sClassCode], [sTypeCode], [sTypeName], [sNote], [dAdate], [dDdate], [sKeyMan], [dKeyDate]) VALUES (@sClassCode, @sTypeCode, @sTypeName, @sNote, @dAdate, @dDdate, @sKeyMan, @dKeyDate)"
                        SelectCommand="SELECT * FROM [wfBookingType] WHERE ([sClassCode] = @sClassCode)"
                        UpdateCommand="UPDATE [wfBookingType] SET [sClassCode] = @sClassCode, [sTypeCode] = @sTypeCode, [sTypeName] = @sTypeName, [sNote] = @sNote, [dAdate] = @dAdate, [dDdate] = @dDdate, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="sClassCode" Type="String" />
                            <asp:Parameter Name="sTypeCode" Type="String" />
                            <asp:Parameter Name="sTypeName" Type="String" />
                            <asp:Parameter Name="sNote" Type="String" />
                            <asp:Parameter Name="dAdate" Type="DateTime" />
                            <asp:Parameter Name="dDdate" Type="DateTime" />
                            <asp:Parameter Name="sKeyMan" Type="String" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:QueryStringParameter Name="sClassCode" QueryStringField="ClassCode" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sClassCode" Type="String" />
                            <asp:Parameter Name="sTypeCode" Type="String" />
                            <asp:Parameter Name="sTypeName" Type="String" />
                            <asp:Parameter Name="sNote" Type="String" />
                            <asp:Parameter Name="dAdate" Type="DateTime" />
                            <asp:Parameter Name="dDdate" Type="DateTime" />
                            <asp:Parameter Name="sKeyMan" Type="String" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
        </table>
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
        &nbsp;</div>
    </form>
</body>
</html>
