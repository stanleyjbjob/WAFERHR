<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Mang.aspx.cs" Inherits="Booking_Mang" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>預約單---管理</title>
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
                                    <asp:FormView ID="fvClass" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsClassFV" DefaultMode="Insert" OnItemInserting="fvClass_ItemInserting" OnItemInserted="fvClass_ItemInserted" OnItemUpdated="fvClass_ItemUpdated" OnItemUpdating="fvClass_ItemUpdating" Width="100%">
                                        <EditItemTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%">
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" nowrap="noWrap">
                                                        類別代碼</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="noWrap">
                                                        類別名稱</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="noWrap">
                                                        類別等級</td>
                                                    <td class="UltraWebGrid1-ic" rowspan="2" nowrap="noWrap" width="1%">
                                                        <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                                            Text="修改" />
                                                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                            CssClass="UltraWebGrid1-hc" Text="取消" /></td>
                                                </tr>
                                                <tr>
                                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                                        <asp:TextBox ID="sClassCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                                            Text='<%# Bind("sClassCode") %>' Width="70px" ReadOnly="True"></asp:TextBox></td>
                                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                                        <asp:TextBox ID="sClassNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("sClassName") %>'></asp:TextBox></td>
                                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("iLv") %>'>
                                                            <asp:ListItem>0</asp:ListItem>
                                                            <asp:ListItem>1</asp:ListItem>
                                                            <asp:ListItem>2</asp:ListItem>
                                                            <asp:ListItem>3</asp:ListItem>
                                                            <asp:ListItem>4</asp:ListItem>
                                                            <asp:ListItem>5</asp:ListItem>
                                                            <asp:ListItem>6</asp:ListItem>
                                                            <asp:ListItem>7</asp:ListItem>
                                                            <asp:ListItem>8</asp:ListItem>
                                                            <asp:ListItem>9</asp:ListItem>
                                                            <asp:ListItem>10</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                </tr>
                                            </table>
                                            <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label>
                                        </EditItemTemplate>
                                        <InsertItemTemplate>
                                            <table border="0" cellpadding="0" cellspacing="0" style="width: 100%; height: 100%" >
                                                <tr>
                                                    <td class="UltraWebGrid1-hc" nowrap="noWrap">
                                                        類別代碼</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="noWrap">
                                                        類別名稱</td>
                                                    <td class="UltraWebGrid1-hc" nowrap="noWrap">
                                                        類別等級</td>
                                                    <td class="UltraWebGrid1-ic" rowspan="2" nowrap="noWrap" width="1%">
                                                        <asp:Button ID="Button1" runat="server" CommandName="Insert" CssClass="UltraWebGrid1-hc"
                                                            Text="新增" /></td>
                                                </tr>
                                                <tr>
                                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                                        <asp:TextBox ID="sClassCodeTextBox" runat="server" CssClass="txtBoxLine" MaxLength="10"
                                                            Text='<%# Bind("sClassCode") %>' Width="70px"></asp:TextBox></td>
                                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                                        <asp:TextBox ID="sClassNameTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("sClassName") %>'></asp:TextBox></td>
                                                    <td class="UltraWebGrid1-ic" align="center" nowrap="noWrap">
                                                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("iLv") %>'>
                                                            <asp:ListItem>0</asp:ListItem>
                                                            <asp:ListItem>1</asp:ListItem>
                                                            <asp:ListItem>2</asp:ListItem>
                                                            <asp:ListItem>3</asp:ListItem>
                                                            <asp:ListItem>4</asp:ListItem>
                                                            <asp:ListItem>5</asp:ListItem>
                                                            <asp:ListItem>6</asp:ListItem>
                                                            <asp:ListItem>7</asp:ListItem>
                                                            <asp:ListItem>8</asp:ListItem>
                                                            <asp:ListItem>9</asp:ListItem>
                                                            <asp:ListItem>10</asp:ListItem>
                                                        </asp:DropDownList></td>
                                                </tr>
                                            </table>
                                        </InsertItemTemplate>
                                    </asp:FormView>
                                    <asp:SqlDataSource ID="sdsClassFV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>" InsertCommand="INSERT INTO [wfBookingClass] ([sClassCode], [sClassName], [iLv], [sKeyMan], [dKeyDate]) VALUES (@sClassCode, @sClassName, @iLv, @sKeyMan, @dKeyDate)"
                                        SelectCommand="SELECT * FROM [wfBookingClass] WHERE ([iAutoKey] = @iAutoKey)" UpdateCommand="UPDATE wfBookingClass SET sClassName = @sClassName, iLv = @iLv, sKeyMan = @sKeyMan, dKeyDate = @dKeyDate WHERE (iAutoKey = @iAutoKey)"><UpdateParameters>
                                            <asp:Parameter Name="sClassName" Type="String" />
                                            <asp:Parameter Name="iLv" Type="Int32" />
                                            <asp:Parameter Name="sKeyMan" Type="String" />
                                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                                        </UpdateParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="gvClass" Name="iAutoKey" PropertyName="SelectedValue"
                                                Type="Int32" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="sClassCode" Type="String" />
                                            <asp:Parameter Name="sClassName" Type="String" />
                                            <asp:Parameter Name="iLv" Type="Int32" />
                                            <asp:Parameter Name="sKeyMan" Type="String" />
                                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                                        </InsertParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gvClass" runat="server" AutoGenerateColumns="False" CellPadding="4"
                                        DataKeyNames="iAutoKey,sClassCode" DataSourceID="sdsClassGV" ForeColor="#333333" GridLines="None" AllowSorting="True" OnRowCommand="gvClass_RowCommand" OnRowDataBound="gvClass_RowDataBound" OnSelectedIndexChanged="gvClass_SelectedIndexChanged" OnRowDeleting="gvClass_RowDeleting">
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <Columns>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemStyle Width="1%" Wrap="False" />
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="lbSelect" runat="server" CausesValidation="False" CommandName="Select"
                                                        Text="選取"></asp:LinkButton>
                                                    <asp:LinkButton ID="lbDelete" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sClassCode") %>'
                                                        CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                                    <asp:LinkButton ID="lbNew" runat="server" CommandArgument='<%# Eval("sClassCode") %>'
                                                        CommandName="New">型號管理</asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                            <asp:BoundField DataField="sClassCode" HeaderText="類別代碼" SortExpression="sClassCode" />
                                            <asp:BoundField DataField="sClassName" HeaderText="類別名稱" SortExpression="sClassName" />
                                            <asp:BoundField DataField="iLv" HeaderText="類別等級" SortExpression="iLv" />
                                            <asp:BoundField DataField="sKeyMan" HeaderText="登錄者" SortExpression="sKeyMan" />
                                            <asp:BoundField DataField="dKeyDate" HeaderText="登錄日期" SortExpression="dKeyDate" />
                                        </Columns>
                                        <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" />
                                        <EditRowStyle BackColor="#2461BF" />
                                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center" />
                                        <AlternatingRowStyle BackColor="White" />
                                        <EmptyDataTemplate>
                                            目前沒有任何設備，請先新增。
                                        </EmptyDataTemplate>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sdsClassGV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                        DeleteCommand="DELETE FROM [wfBookingClass] WHERE [iAutoKey] = @iAutoKey"
                                        SelectCommand="SELECT * FROM [wfBookingClass]">
                                        <DeleteParameters>
                                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                                        </DeleteParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
