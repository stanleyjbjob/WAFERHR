<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Set.aspx.cs" Inherits="TrLearned_Set" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css" />
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
        <asp:UpdatePanel ID="up1" runat="server">
            <ContentTemplate>
                <asp:DetailsView ID="DV" runat="server" AutoGenerateRows="False" Caption="心得報告--參數設定"
                    CellPadding="4" DataKeyNames="iAutoKey" DataSourceID="dsDV" DefaultMode="Edit"
                    ForeColor="#333333" GridLines="None" Height="50px" OnItemUpdating="DV_ItemUpdating"
                    Width="443px" OnItemUpdated="DV_ItemUpdated">
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <CommandRowStyle BackColor="#D1DDF1" Font-Bold="True" />
                    <RowStyle BackColor="#EFF3FB" />
                    <FieldHeaderStyle BackColor="#DEE8F5" Font-Bold="True" />
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <Fields>
                        <asp:TemplateField HeaderText="＊申請設定＊">
                            <HeaderStyle ForeColor="Blue" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="iCntMinLnth" HeaderText="課程內容最小長度" SortExpression="iCntMinLnth" />
                        <asp:BoundField DataField="iCntMaxLnth" HeaderText="課程內容最大長度" SortExpression="iCntMaxLnth" />
                        <asp:BoundField DataField="iLndMinLnth" HeaderText="心得報告最小長度" SortExpression="iLndMinLnth" />
                        <asp:BoundField DataField="iLndMaxLnth" HeaderText="心得報告最大長度" SortExpression="iLndMaxLnth" />
                        <asp:BoundField DataField="iRsnMinLnth" HeaderText="評比理由最小長度" SortExpression="iRsnMinLnth" />
                        <asp:BoundField DataField="iRsnMaxLnth" HeaderText="評比理由最大長度" SortExpression="iRsnMaxLnth" />
                        <asp:TemplateField HeaderText="申請備註" SortExpression="sStdNote">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Height="52px" Text='<%# Bind("sStdNote") %>'
                                    TextMode="MultiLine" Width="100%"></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("sStdNote") %>'></asp:TextBox>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("sStdNote") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle BorderColor="Blue" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="＊預覽設定＊">
                            <HeaderStyle ForeColor="Blue" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="sPvwLogoPath" HeaderText="Logo檔案路徑" SortExpression="sPvwLogoPath" />
                        <asp:BoundField DataField="sPvwTitle" HeaderText="大標題" SortExpression="sPvwTitle" />
                        <asp:BoundField DataField="sPvwTitleSize" HeaderText="大標題字體大小" SortExpression="sPvwTitleSize" />
                        <asp:BoundField DataField="sPvwTitleE" HeaderText="小標題" SortExpression="sPvwTitleE" />
                        <asp:BoundField DataField="sPvwFormName" HeaderText="報表名稱" SortExpression="sPvwFormName" />
                        <asp:BoundField DataField="sPvwFlow" HeaderText="表單流程敘述" SortExpression="sPvwFlow" />
                        <asp:BoundField DataField="sPvwFormNo" HeaderText="表單編號" SortExpression="sPvwFormNo" />
                        <asp:BoundField DataField="sPvwEdition" HeaderText="版次" SortExpression="sPvwEdition" />
                        <asp:BoundField DataField="sPvwSaveUnit" HeaderText="正本存檔單位" SortExpression="sPvwSaveUnit" />
                        <asp:BoundField DataField="sKeyMan" HeaderText="最近異動者" SortExpression="sKeyMan" ReadOnly="True" />
                        <asp:BoundField DataField="dKeyDate" HeaderText="最近異動日期" SortExpression="dKeyDate" ReadOnly="True" />
                        <asp:CommandField ShowEditButton="True" />
                    </Fields>
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="WhiteSmoke" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:DetailsView>
                <asp:SqlDataSource ID="dsDV" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                    DeleteCommand="DELETE FROM [wfTrLearnedSet] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfTrLearnedSet] ([sStdNote], [iCntMinLnth], [iCntMaxLnth], [iLndMinLnth], [iLndMaxLnth], [iRsnMinLnth], [iRsnMaxLnth], [sPvwLogoPath], [sPvwTitle], [sPvwTitleE], [sPvwFormName], [sPvwFlow], [sPvwFormNo], [sPvwEdition], [sPvwSaveUnit], [sKeyMan], [dKeyDate]) VALUES (@sStdNote, @iCntMinLnth, @iCntMaxLnth, @iLndMinLnth, @iLndMaxLnth, @iRsnMinLnth, @iRsnMaxLnth, @sPvwLogoPath, @sPvwTitle, @sPvwTitleE, @sPvwFormName, @sPvwFlow, @sPvwFormNo, @sPvwEdition, @sPvwSaveUnit, @sKeyMan, @dKeyDate)"
                    SelectCommand="SELECT * FROM [wfTrLearnedSet]" UpdateCommand="UPDATE [wfTrLearnedSet] SET [sStdNote] = @sStdNote, [iCntMinLnth] = @iCntMinLnth, [iCntMaxLnth] = @iCntMaxLnth, [iLndMinLnth] = @iLndMinLnth, [iLndMaxLnth] = @iLndMaxLnth, [iRsnMinLnth] = @iRsnMinLnth, [iRsnMaxLnth] = @iRsnMaxLnth, [sPvwLogoPath] = @sPvwLogoPath, [sPvwTitle] = @sPvwTitle, [sPvwTitleE] = @sPvwTitleE, [sPvwFormName] = @sPvwFormName, [sPvwFlow] = @sPvwFlow, [sPvwFormNo] = @sPvwFormNo, [sPvwEdition] = @sPvwEdition, [sPvwSaveUnit] = @sPvwSaveUnit, [sKeyMan] = @sKeyMan, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                    <DeleteParameters>
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="sStdNote" Type="String" />
                        <asp:Parameter Name="iCntMinLnth" Type="Int32" />
                        <asp:Parameter Name="iCntMaxLnth" Type="Int32" />
                        <asp:Parameter Name="iLndMinLnth" Type="Int32" />
                        <asp:Parameter Name="iLndMaxLnth" Type="Int32" />
                        <asp:Parameter Name="iRsnMinLnth" Type="Int32" />
                        <asp:Parameter Name="iRsnMaxLnth" Type="Int32" />
                        <asp:Parameter Name="sPvwLogoPath" Type="String" />
                        <asp:Parameter Name="sPvwTitle" Type="String" />
                        <asp:Parameter Name="sPvwTitleE" Type="String" />
                        <asp:Parameter Name="sPvwFormName" Type="String" />
                        <asp:Parameter Name="sPvwFlow" Type="String" />
                        <asp:Parameter Name="sPvwFormNo" Type="String" />
                        <asp:Parameter Name="sPvwEdition" Type="String" />
                        <asp:Parameter Name="sPvwSaveUnit" Type="String" />
                        <asp:Parameter Name="sKeyMan" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        <asp:Parameter Name="iAutoKey" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="sStdNote" Type="String" />
                        <asp:Parameter Name="iCntMinLnth" Type="Int32" />
                        <asp:Parameter Name="iCntMaxLnth" Type="Int32" />
                        <asp:Parameter Name="iLndMinLnth" Type="Int32" />
                        <asp:Parameter Name="iLndMaxLnth" Type="Int32" />
                        <asp:Parameter Name="iRsnMinLnth" Type="Int32" />
                        <asp:Parameter Name="iRsnMaxLnth" Type="Int32" />
                        <asp:Parameter Name="sPvwLogoPath" Type="String" />
                        <asp:Parameter Name="sPvwTitle" Type="String" />
                        <asp:Parameter Name="sPvwTitleE" Type="String" />
                        <asp:Parameter Name="sPvwFormName" Type="String" />
                        <asp:Parameter Name="sPvwFlow" Type="String" />
                        <asp:Parameter Name="sPvwFormNo" Type="String" />
                        <asp:Parameter Name="sPvwEdition" Type="String" />
                        <asp:Parameter Name="sPvwSaveUnit" Type="String" />
                        <asp:Parameter Name="sKeyMan" Type="String" />
                        <asp:Parameter Name="dKeyDate" Type="DateTime" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
