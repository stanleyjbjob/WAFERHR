<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qQuestionaryS.aspx.cs" Inherits="qQuestionaryS" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>問卷分類問題(大分類)</title>
    <link href="./css/general.css" rel="stylesheet" type="text/css">
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
                                                <img id="IMG1" alt="" height="32" src="./images/loading.gif" width="32" /><strong>請稍後～<br />
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
                <table cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td>
                            <asp:FormView ID="fv" runat="server" DataKeyNames="AUTOKEY" DataSourceID="sdsFV"
                                DefaultMode="Insert" OnItemInserted="fv_ItemInserted" OnItemInserting="fv_ItemInserting"
                                OnItemUpdated="fv_ItemUpdated" OnItemUpdating="fv_ItemUpdating" OnModeChanged="fv_ModeChanged"
                                Width="100%">
                                <EditItemTemplate><table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            題目</td>
                                        <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                            順位</td>
                                        <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="2">
                                                <asp:Button ID="Button1" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                                    Text="修改" />
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Cancel"
                                                    CssClass="UltraWebGrid1-hc" Text="取消" /></td>
                                    </tr>
                                    <tr>
                                        <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                            <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsCast" DataTextField="VALNAME"
                                                    DataValueField="VALCODE" SelectedValue='<%# Bind("VALCODE") %>' Enabled="False">
                                            </asp:DropDownList>
                                            <asp:SqlDataSource ID="sdsCast" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                    SelectCommand="SELECT VALCODE, VALCODE + '| ' + RTRIM(VALNAME) AS VALNAME FROM TRVALGD">
                                            </asp:SqlDataSource>
                                        </td>
                                        <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                            <asp:TextBox ID="iOrderTextBox" runat="server" CssClass="txtBoxLine" MaxLength="3"
                                                Text='<%# Bind("SORT") %>' Width="20px"></asp:TextBox></td>
                                    </tr>
                                </table>
                                    <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Bind("AUTOKEY") %>'></asp:Label>
                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                                        <tr>
                                            <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                題目</td>
                                            <td align="center" class="UltraWebGrid1-hc" nowrap="nowrap">
                                                順位</td>
                                            <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap" rowspan="2">
                                                <asp:Button ID="Button2" runat="server" CommandName="Insert" CssClass="UltraWebGrid1-hc"
                                                    Text="新增" /></td>
                                        </tr>
                                        <tr>
                                            <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="sdsCast" DataTextField="VALNAME"
                                                    DataValueField="VALCODE" SelectedValue='<%# Bind("VALCODE") %>'>
                                                </asp:DropDownList>
                                                <asp:SqlDataSource ID="sdsCast" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                                    SelectCommand="SELECT VALCODE, VALCODE + '| ' + RTRIM(VALNAME) AS VALNAME FROM TRVALGD WHERE (VALCODE NOT IN (SELECT VALCODE FROM TRQG WHERE (TRQCODE = @TRQCODE)))">
                                                    <SelectParameters>
                                                        <asp:QueryStringParameter Name="TRQCODE" QueryStringField="Code" />
                                                    </SelectParameters>
                                                </asp:SqlDataSource>
                                            </td>
                                            <td align="center" class="UltraWebGrid1-ic" nowrap="nowrap">
                                                <asp:TextBox ID="iOrderTextBox" runat="server" CssClass="txtBoxLine" Text='<%# Bind("SORT") %>' MaxLength="3" Width="20px"></asp:TextBox></td>
                                        </tr>
                                    </table>
                                </InsertItemTemplate>
                            </asp:FormView>
                            <asp:SqlDataSource ID="sdsFV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                InsertCommand="INSERT INTO [TRQG] ([TRQCODE], [VALCODE], [SORT]) VALUES (@TRQCODE, @VALCODE, @SORT)"
                                SelectCommand="SELECT * FROM [TRQG] WHERE ([AUTOKEY] = @AUTOKEY)" UpdateCommand="UPDATE [TRQG] SET [TRQCODE] = @TRQCODE, [VALCODE] = @VALCODE, [SORT] = @SORT WHERE [AUTOKEY] = @AUTOKEY">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gv" Name="AUTOKEY" PropertyName="SelectedValue"
                                        Type="Int32" />
                                </SelectParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="TRQCODE" Type="String" />
                                    <asp:Parameter Name="VALCODE" Type="String" />
                                    <asp:Parameter Name="SORT" Type="Int32" />
                                    <asp:Parameter Name="AUTOKEY" Type="Int32" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="TRQCODE" Type="String" />
                                    <asp:Parameter Name="VALCODE" Type="String" />
                                    <asp:Parameter Name="SORT" Type="Int32" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            &nbsp;&nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:GridView ID="gv" runat="server" AllowSorting="True" AutoGenerateColumns="False" DataKeyNames="AUTOKEY" DataSourceID="sdsGV" OnRowDataBound="gv_RowDataBound" OnSelectedIndexChanged="gv_SelectedIndexChanged"
                                Width="100%" OnRowDeleted="gv_RowDeleted">
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
                                    <asp:BoundField DataField="VALCODE" HeaderText="代碼" SortExpression="VALCODE">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                    <asp:BoundField DataField="VALNAME" HeaderText="名稱" SortExpression="VALNAME" />
                                    <asp:BoundField DataField="SORT" HeaderText="順位" SortExpression="SORT">
                                        <ItemStyle HorizontalAlign="Center" />
                                    </asp:BoundField>
                                </Columns>
                                <EmptyDataTemplate>
                                    您尚未輸入任何資料，請先新增資料。
                                </EmptyDataTemplate>
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                DeleteCommand="DELETE FROM [TRQG] WHERE [AUTOKEY] = @AUTOKEY" SelectCommand="SELECT TRQG.AUTOKEY, TRQG.TRQCODE, TRQG.VALCODE, TRQG.SORT, TRVALGD.VALNAME FROM TRQG INNER JOIN TRVALGD ON TRQG.VALCODE = TRVALGD.VALCODE WHERE (TRQG.TRQCODE = @TRQCODE)">
                                <SelectParameters>
                                    <asp:QueryStringParameter Name="TRQCODE" QueryStringField="Code" Type="String" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="AUTOKEY" Type="Int32" />
                                </DeleteParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
