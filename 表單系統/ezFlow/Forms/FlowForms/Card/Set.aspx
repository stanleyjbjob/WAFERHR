<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Set.aspx.cs" Inherits="Card_Set"  validateRequest="false"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>忘刷單---設定</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
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
                <asp:FormView ID="fvSet" runat="server" DataKeyNames="iAutoKey" DataSourceID="sdsSet"
                    DefaultMode="Edit" OnItemUpdating="fvSet_ItemUpdating" Width="100%">
                    <EditItemTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                            <tr>
                                <td class="style1" colspan="4" nowrap="nowrap" width="1%">
                                    更改預設值</td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    申請備註</td>
                                <td colspan="3">
                                    <fckeditorv2:fckeditor id="txtStdNote" runat="server" basepath="../FCKeditor/" height="200px"
                                        toolbarset="Ming" value='<%# Bind("sStdNote") %>' width="100%">
                                    </fckeditorv2:fckeditor>
                                </td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    審核備註</td>
                                <td colspan="3">
                                    <fckeditorv2:fckeditor id="txtCheckNote" runat="server" basepath="../FCKeditor/"
                                        height="200px" toolbarset="Ming" value='<%# Bind("sCheckNote") %>' width="100%">
                                    </fckeditorv2:fckeditor>
                                </td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    其它選項</td>
                                <td colspan="3">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("bSignNote") %>' Text="顯示主管簽核意見" /><asp:CheckBox
                                        ID="bAgentAppCheckBox" runat="server" Checked='<%# Bind("bAgentApp") %>' Text="可幫部屬代理申請" /><asp:CheckBox
                                            ID="CheckBox2" runat="server" Checked='<%# Bind("bSignState") %>' Text="顯示進行中流程" /><asp:CheckBox
                                                    ID="bNoteCheckBox" runat="server" Checked='<%# Bind("bNote") %>' Text="事由一定要填" /></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    最大申請筆數</td>
                                <td colspan="3">
                                    <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("iAppCount") %>'>
                                        <asp:ListItem Selected="True">1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                        <asp:ListItem>6</asp:ListItem>
                                        <asp:ListItem>7</asp:ListItem>
                                        <asp:ListItem>8</asp:ListItem>
                                        <asp:ListItem>9</asp:ListItem>
                                        <asp:ListItem>10</asp:ListItem>
                                        <asp:ListItem>9999</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    可延遲天數</td>
                                <td colspan="3">
                                    <asp:DropDownList ID="DropDownList2" runat="server" SelectedValue='<%# Bind("iDelay") %>'>
                                        <asp:ListItem Selected="True">1</asp:ListItem>
                                        <asp:ListItem>2</asp:ListItem>
                                        <asp:ListItem>3</asp:ListItem>
                                        <asp:ListItem>4</asp:ListItem>
                                        <asp:ListItem>5</asp:ListItem>
                                        <asp:ListItem>6</asp:ListItem>
                                        <asp:ListItem>7</asp:ListItem>
                                        <asp:ListItem>8</asp:ListItem>
                                        <asp:ListItem>9</asp:ListItem>
                                        <asp:ListItem>10</asp:ListItem>
                                        <asp:ListItem>9999</asp:ListItem>
                                    </asp:DropDownList></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    修改者</td>
                                <td colspan="3">
                                    <asp:Label ID="lblMan" runat="server" Text='<%# Eval("sKeyMan") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    修改時間</td>
                                <td colspan="3">
                                    <asp:Label ID="lblDate" runat="server" Text='<%# Eval("dKeyDate", "{0:d}") %>'></asp:Label></td>
                            </tr>
                            <tr>
                                <td colspan="4" nowrap="nowrap" style="text-align: right" width="1%">
                                    <asp:Label ID="iAutoKeyLabel1" runat="server" Text='<%# Eval("iAutoKey") %>' Visible="False"></asp:Label>
                                    <asp:Button ID="btnUpdate" runat="server" CommandName="Update" CssClass="UltraWebGrid1-hc"
                                        OnClientClick="return confirm('您確定要更改嗎？');" Text="更改" /></td>
                            </tr>
                        </table>
                    </EditItemTemplate>
                </asp:FormView>
                <asp:SqlDataSource ID="sdsSet" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                    SelectCommand="SELECT * FROM [wfCardSet]" UpdateCommand="UPDATE [wfCardSet] SET [sStdNote] = @sStdNote, [sCheckNote] = @sCheckNote, [bAgentApp] = @bAgentApp, [bSignNote] = @bSignNote, [bSignState] = @bSignState, [bNote] = @bNote, [iAppCount] = @iAppCount, [iDelay] = @iDelay, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                    <UpdateParameters>
                        <asp:Parameter Name="sStdNote" Type="String" />
                        <asp:Parameter Name="sCheckNote" Type="String" />
                        <asp:Parameter Name="bAgentApp" Type="Boolean" />
                        <asp:Parameter Name="bSignNote" Type="Boolean" />
                        <asp:Parameter Name="bSignState" Type="Boolean" />
                        <asp:Parameter Name="bNote" Type="Boolean" />
                        <asp:Parameter Name="iAppCount" Type="Int32" />
                        <asp:Parameter Name="iDelay" Type="Int32" />
                        <asp:Parameter Name="sKeyMan" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </UpdateParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
