<%@ Page Language="C#" AutoEventWireup="true" CodeFile="JobSign.aspx.cs" Inherits="Manage_JobSign" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <table cellpadding="0" cellspacing="0">
            <tr>
                <td>
                    <asp:FormView ID="fv" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsFV"
                        DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting">
                        <InsertItemTemplate>
                            <table cellpadding="0" cellspacing="0">
                                <tr>
                                    <td nowrap="nowrap" style="text-align: center">
                                        表單名稱</td>
                                    <td nowrap="nowrap" style="text-align: center">
                                        職等S</td>
                                    <td nowrap="nowrap" style="text-align: center">
                                        職等E</td>
                                    <td nowrap="nowrap" style="text-align: center">
                                        天數S</td>
                                    <td nowrap="nowrap" style="text-align: center">
                                        天數E</td>
                                    <td nowrap="nowrap" style="text-align: center">
                                        流程代碼</td>
                                    <td nowrap="nowrap" style="text-align: center">
                                        備用1</td>
                                    <td nowrap="nowrap" style="text-align: center; width: 57px;">
                                        備用2</td>
                                    <td nowrap="nowrap" style="text-align: center">
                                        備用3</td>
                                    <td nowrap="nowrap" rowspan="2">
                                        <asp:Button ID="Button1" runat="server" CommandName="Insert" Text="新增" /></td>
                                </tr>
                                <tr>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sForm") %>' Width="80px"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="sJobTextBox" runat="server" Text='<%# Bind("sJob") %>' Width="50px"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="TextBox5" runat="server" Text='<%# Bind("sJobE") %>' Width="50px"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="iDayTextBox" runat="server" Text='<%# Bind("iDay") %>' Width="50px"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("iDayE") %>' Width="50px"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="sSignCodeTextBox" runat="server" Text='<%# Bind("sSignCode") %>' Width="80px"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("sR1") %>' Width="50px"></asp:TextBox></td>
                                    <td nowrap="nowrap" style="width: 57px">
                                        <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("sR2") %>' Width="50px"></asp:TextBox></td>
                                    <td nowrap="nowrap">
                                        <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("sR3") %>' Width="50px"></asp:TextBox></td>
                                </tr>
                            </table>
                        </InsertItemTemplate>
                    </asp:FormView>
                    <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>" InsertCommand="INSERT INTO [wfJobSign] ([sJob], [sJobE], [iDay], [iDayE], [sSignCode], [sForm], [sR1], [sR2], [sR3]) VALUES (@sJob, @sJobE, @iDay, @iDayE, @sSignCode, @sForm, @sR1, @sR2, @sR3)"
                        SelectCommand="SELECT * FROM [wfJobSign] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE [wfJobSign] SET [sJob] = @sJob, [sJobE] = @sJobE, [iDay] = @iDay, [iDayE] = @iDayE, [sSignCode] = @sSignCode, [sForm] = @sForm, [sR1] = @sR1, [sR2] = @sR2, [sR3] = @sR3 WHERE [iAutoKey] = @iAutoKey">
                        <UpdateParameters>
                            <asp:Parameter Name="sJob" Type="String" />
                            <asp:Parameter Name="sJobE" Type="String" />
                            <asp:Parameter Name="iDay" Type="Int32" />
                            <asp:Parameter Name="iDayE" Type="Int32" />
                            <asp:Parameter Name="sSignCode" Type="String" />
                            <asp:Parameter Name="sForm" Type="String" />
                            <asp:Parameter Name="sR1" Type="String" />
                            <asp:Parameter Name="sR2" Type="String" />
                            <asp:Parameter Name="sR3" Type="String" />
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </UpdateParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sJob" Type="String" />
                            <asp:Parameter Name="sJobE" Type="String" />
                            <asp:Parameter Name="iDay" Type="Int32" />
                            <asp:Parameter Name="iDayE" Type="Int32" />
                            <asp:Parameter Name="sSignCode" Type="String" />
                            <asp:Parameter Name="sForm" Type="String" />
                            <asp:Parameter Name="sR1" Type="String" />
                            <asp:Parameter Name="sR2" Type="String" />
                            <asp:Parameter Name="sR3" Type="String" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="gv" Name="iAutoKey" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gv" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="sdsGV" ForeColor="#333333"
                        GridLines="None">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <RowStyle BackColor="#EFF3FB" />
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandName="Delete"
                                        OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sJob" HeaderText="職等S" SortExpression="sJob" />
                            <asp:BoundField DataField="sJobE" HeaderText="職等E" SortExpression="sJobE" />
                            <asp:BoundField DataField="iDay" HeaderText="天數S" SortExpression="iDay" />
                            <asp:BoundField DataField="iDayE" HeaderText="天數E" SortExpression="iDayE" />
                            <asp:BoundField DataField="sSignCode" HeaderText="流程代碼" SortExpression="sSignCode" />
                            <asp:BoundField DataField="sForm" HeaderText="表單名稱" SortExpression="sForm" />
                            <asp:BoundField DataField="sR1" HeaderText="備用1" SortExpression="sR1" />
                            <asp:BoundField DataField="sR2" HeaderText="備用2" SortExpression="sR2" />
                            <asp:BoundField DataField="sR3" HeaderText="備用3" SortExpression="sR3" />
                        </Columns>
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <EditRowStyle BackColor="#2461BF" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        DeleteCommand="DELETE FROM [wfJobSign] WHERE [iAutoKey] = @iAutoKey"
                        SelectCommand="SELECT * FROM [wfJobSign]">
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                    </asp:SqlDataSource>
                    &nbsp;
                </td>
            </tr>
            <tr>
                <td>
                    表單名稱<asp:TextBox ID="txtForm" runat="server" Width="80px"></asp:TextBox>天數<asp:TextBox
                        ID="txtDay" runat="server" Width="50px"></asp:TextBox>職等<asp:TextBox ID="txtJob"
                            runat="server" Width="50px"></asp:TextBox>
                    <asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="查詢" /></td>
            </tr>
            <tr>
                <td>
                    <asp:Label ID="lblMsg" runat="server"></asp:Label></td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
