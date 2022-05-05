<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Set.aspx.cs" Inherits="Shift_Set" validateRequest="false" %>

<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>調班單---設定</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body style="background-color: #eef3ff">
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
                    DefaultMode="Edit" Width="100%" OnItemUpdating="fvSet_ItemUpdating">
                    <EditItemTemplate>
                        <table border="0" cellpadding="0" cellspacing="0" class="WebPanel2ctl" width="100%">
                            <tr>
                                <td class="style1" colspan="4" nowrap="nowrap" width="1%">
                                    更改預設值</td>
                            </tr>
                            <tr>
                                <td style="text-align: right" class="UltraWebGrid1-hc" nowrap="noWrap" width="1%">
                                    申請備註</td>
                                <td colspan="3">
                                    <FCKeditorV2:FCKeditor ID="txtStdNote" runat="server" BasePath="../FCKeditor/" Height="200px"
                                        ToolbarSet="Ming" Value='<%# Bind("sStdNote") %>' Width="100%">
                                    </FCKeditorV2:FCKeditor>
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right" class="UltraWebGrid1-hc" nowrap="noWrap" width="1%">
                                    審核備註</td>
                                <td colspan="3">
                                    <FCKeditorV2:FCKeditor ID="txtCheckNote" runat="server" BasePath="../FCKeditor/"
                                        Height="200px" Value='<%# Bind("sCheckNote") %>' Width="100%" ToolbarSet="Ming">
                                    </FCKeditorV2:FCKeditor>
                                </td>
                            </tr>
                            <tr>
                                <td class="UltraWebGrid1-hc" nowrap="nowrap" style="text-align: right" width="1%">
                                    其它選項</td>
                                <td colspan="3">
                                    <asp:CheckBox ID="CheckBox1" runat="server" Checked='<%# Bind("bSignNote") %>' Text="顯示主管簽核意見" /></td>
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
                    DeleteCommand="DELETE FROM [wfShiftSet] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfShiftSet] ([sStdNote], [sCheckNote], [bSignNote], [sKeyMan], [dKeyDate]) VALUES (@sStdNote, @sCheckNote, @bSignNote, @sKeyMan, @dKeyDate)"
                    SelectCommand="SELECT * FROM [wfShiftSet]" UpdateCommand="UPDATE [wfShiftSet] SET [sStdNote] = @sStdNote, [sCheckNote] = @sCheckNote, [bSignNote] = @bSignNote, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                    <DeleteParameters>
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="sStdNote" Type="String" />
                        <asp:Parameter Name="sCheckNote" Type="String" />
                        <asp:Parameter Name="bSignNote" Type="Boolean" />
                        <asp:Parameter Name="sKeyMan" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="sStdNote" Type="String" />
                        <asp:Parameter Name="sCheckNote" Type="String" />
                        <asp:Parameter Name="bSignNote" Type="Boolean" />
                        <asp:Parameter Name="sKeyMan" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                    </InsertParameters>
                </asp:SqlDataSource>
            </ContentTemplate>
        </asp:UpdatePanel>
        &nbsp;
    </div>
    </form>
    </body>
</html>
