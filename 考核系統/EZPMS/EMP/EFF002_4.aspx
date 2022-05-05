<%@ Page Language="C#" AutoEventWireup="true" CodeFile="EFF002_4.aspx.cs" Inherits="EMP_EFF002_4" ValidateRequest="false" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>合晶科技績效考核系統（Web版）v1.0</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        &nbsp;</div>
        <fieldset>
           
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoKey"
                        DataSourceID="SelectEduObjectDataSource" OnRowDataBound="GridView2_RowDataBound">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                        Text="選取" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="AutoKey" HeaderText="AutoKey" ReadOnly="True" SortExpression="AutoKey"
                                Visible="False" />
                            <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" />
                            <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" />
                            <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                            <asp:BoundField DataField="eduCateID" HeaderText="eduCateID" SortExpression="eduCateID"
                                Visible="False" />
                            <asp:BoundField DataField="eduCateItemID" HeaderText="eduCateItemID" SortExpression="eduCateItemID"
                                Visible="False" />
                            <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                                Visible="False" />
                            <asp:BoundField DataField="cateName" HeaderText="訓練類別" SortExpression="cateName" />
                            <asp:BoundField DataField="CateItemName" HeaderText="訓練項目" SortExpression="CateItemName" Visible="False" />
                            <asp:BoundField DataField="other" HeaderText="說明" HtmlEncode="False" SortExpression="other" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                        OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <RowStyle Font-Size="Small" />
                        <HeaderStyle Font-Size="Small" />
                    </asp:GridView>

                    <asp:ObjectDataSource ID="SelectEduObjectDataSource" runat="server" DeleteMethod="Delete"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySeleView"
                        TypeName="EFFDSTableAdapters.EFFS_SELFEDUTableAdapter" UpdateMethod="Update">
                        <InsertParameters>
                            <asp:Parameter Name="AutoKey" Type="Int32" />
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="eduCateID" Type="String" />
                            <asp:Parameter Name="eduCateItemID" Type="String" />
                            <asp:Parameter Name="other" Type="String" />
                            <asp:Parameter Name="keydate" Type="DateTime" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_yy" Name="yy" PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="_seq" Name="seq" PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" Type="String" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="AutoKey" Type="Int32" />
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="eduCateID" Type="String" />
                            <asp:Parameter Name="eduCateItemID" Type="String" />
                            <asp:Parameter Name="other" Type="String" />
                            <asp:Parameter Name="keydate" Type="DateTime" />
                            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
        </fieldset>
        <fieldset>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="AutoKey" DataSourceID="SelfEduObjectDataSource"
                        OnDataBound="FormView1_DataBound" OnItemInserted="FormView1_ItemInserted1" OnItemInserting="FormView1_ItemInserting1"
                        OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating"
                        OnModeChanged="FormView1_ModeChanged">
                        <EditItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td align="left" style="width: 50%; height: 23px">
                                        &nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Update"
                                            Text="儲存資料" /></td>
                                    <td align="right" style="width: 50%; height: 23px">
                                        <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="取消" />
                                    </td>
                                </tr>
                            </table>
                            <hr />
                            <asp:Label ID="AutoKeyLabel1" runat="server" Text='<%# Eval("AutoKey") %>' Visible="False"></asp:Label>
                            <asp:TextBox ID="yyTextBox" runat="server" Text='<%# Bind("yy") %>' Visible="False"
                                Width="21px"></asp:TextBox>
                            <asp:TextBox ID="seqTextBox" runat="server" Text='<%# Bind("seq") %>' Visible="False"
                                Width="21px"></asp:TextBox>
                            <asp:TextBox ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>' Visible="False"
                                Width="17px"></asp:TextBox><br />
                            <asp:Label ID="Label13" runat="server" ForeColor="Blue" Text="訓練類別:"></asp:Label>
                            <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="CateObjectDataSource"
                                DataTextField="cateName" DataValueField="eduCateID" SelectedValue='<%# Bind("eduCateID") %>'>
                            </asp:DropDownList>
                            <asp:DropDownList ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="CateItemObjectDataSource"
                                DataTextField="CateItemName" DataValueField="eduCateItemID" Visible="False">
                            </asp:DropDownList><br />
                            &nbsp;<br />
                            <asp:Label ID="Label15" runat="server" ForeColor="Blue" Text="說明:"></asp:Label>
                            <ftb:freetextbox id="FreeTextBox1" runat="server" allowhtmlmode="False" assemblyresourcehandlerpath=""
                                autoconfigure="" autogeneratetoolbarsfromstring="True" autohidetoolbar="True"
                                autoparsestyles="True" backcolor="158, 190, 245" baseurl="" breakmode="LineBreak"
                                buttondownimage="False" buttonfileextention="gif" buttonfolder="Images" buttonheight="20"
                                buttonimageslocation="InternalResource" buttonoverimage="False" buttonpath=""
                                buttonset="Office2003" buttonwidth="21" clientsidetextchanged="" converthtmlsymbolstohtmlcodes="False"
                                designmodebodytagcssclass="" designmodecss="" disableiebackbutton="False" downlevelcols="50"
                                downlevelmessage="" downlevelmode="TextArea" downlevelrows="10" editorbordercolordark="Gray"
                                editorbordercolorlight="Gray" enablehtmlmode="False" enablessl="False" enabletoolbars="False"
                                focus="False" formathtmltagstoxhtml="True" gutterbackcolor="129, 169, 226" gutterbordercolordark="Gray"
                                gutterbordercolorlight="White" height="150px" helperfilesparameters="" helperfilespath=""
                                htmlmodecss="" htmlmodedefaultstomonospacefont="True" imagegallerypath="~/images/"
                                imagegalleryurl="ftb.imagegallery.aspx?rif={0}&cif={0}" installationerrormessage="InlineMessage"
                                javascriptlocation="InternalResource" language="en-US" pastemode="Default" readonly="False"
                                removescriptnamefrombookmarks="True" removeservernamefromurls="True" rendermode="NotSet"
                                scriptmode="External" showtagpath="False" sslurl="/." startmode="DesignMode"
                                stripallscripting="False" supportfolder="/aspnet_client/FreeTextBox/" tabindex="-1"
                                tabmode="InsertSpaces" text='<%# Bind("other") %>' textdirection="LeftToRight"
                                toolbarbackcolor="Transparent" toolbarbackgroundimage="True" toolbarimageslocation="InternalResource"
                                toolbarlayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                                toolbarstyleconfiguration="Office2003" updatetoolbar="True" usetoolbarbackgroundimage="True"
                                width="600px"></ftb:freetextbox>
                            <asp:ObjectDataSource ID="CateItemObjectDataSource" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                TypeName="EFFDSTableAdapters.EFFS_EDUCATEITEMTableAdapter" UpdateMethod="Update">
                                <InsertParameters>
                                    <asp:Parameter Name="eduCateItemID" Type="String" />
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="CateItemName" Type="String" />
                                </InsertParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="eduCateItemID" Type="String" />
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="CateItemName" Type="String" />
                                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                                </UpdateParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList1" Name="cateID" PropertyName="SelectedValue"
                                        Type="String" />
                                </SelectParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="CateObjectDataSource" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                TypeName="EFFDSTableAdapters.EFFS_EDUCATETableAdapter" UpdateMethod="Update">
                                <InsertParameters>
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="cateName" Type="String" />
                                    <asp:Parameter Name="Order" Type="Int32" />
                                </InsertParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_eduCateID" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="cateName" Type="String" />
                                    <asp:Parameter Name="Order" Type="Int32" />
                                    <asp:Parameter Name="Original_eduCateID" Type="String" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <hr />
                            <table style="width: 100%">
                                <tr>
                                    <td align="left" style="width: 50%; height: 23px">
                                        &nbsp;<asp:Button ID="Button3" runat="server" CausesValidation="True" CommandName="Update"
                                            Text="儲存資料" /></td>
                                    <td align="right" style="width: 50%; height: 23px">
                                        <asp:Button ID="Button4" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="取消" />
                                    </td>
                                </tr>
                            </table>
                        </EditItemTemplate>
                        <EmptyDataTemplate>
                            <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                Text="新增資料" />
                        </EmptyDataTemplate>
                        <InsertItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td align="left" style="width: 50%; height: 23px">
                                        &nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Insert"
                                            Text="儲存資料" /></td>
                                    <td align="right" style="width: 50%; height: 23px">
                                        <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="取消" />
                                    </td>
                                </tr>
                            </table>
                            <hr />
                            <asp:Label ID="Label13" runat="server" ForeColor="Blue" Text="訓練類別:"></asp:Label><asp:DropDownList
                                ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="CateObjectDataSource"
                                DataTextField="cateName" DataValueField="eduCateID" SelectedValue='<%# Bind("eduCateID") %>'>
                            </asp:DropDownList>
                            <asp:DropDownList
                                ID="DropDownList2" runat="server" DataSourceID="CateItemObjectDataSource" DataTextField="CateItemName"
                                DataValueField="eduCateItemID" Visible="False">
                            </asp:DropDownList><br />
                            <br />
                            <asp:Label ID="Label15" runat="server" ForeColor="Blue" Text="說明:"></asp:Label>
                            <ftb:freetextbox id="FreeTextBox1" runat="server" allowhtmlmode="False" assemblyresourcehandlerpath=""
                                autoconfigure="" autogeneratetoolbarsfromstring="True" autohidetoolbar="True"
                                autoparsestyles="True" backcolor="158, 190, 245" baseurl="" breakmode="LineBreak"
                                buttondownimage="False" buttonfileextention="gif" buttonfolder="Images" buttonheight="20"
                                buttonimageslocation="InternalResource" buttonoverimage="False" buttonpath=""
                                buttonset="Office2003" buttonwidth="21" clientsidetextchanged="" converthtmlsymbolstohtmlcodes="False"
                                designmodebodytagcssclass="" designmodecss="" disableiebackbutton="False" downlevelcols="50"
                                downlevelmessage="" downlevelmode="TextArea" downlevelrows="10" editorbordercolordark="Gray"
                                editorbordercolorlight="Gray" enablehtmlmode="False" enablessl="False" enabletoolbars="False"
                                focus="False" formathtmltagstoxhtml="True" gutterbackcolor="129, 169, 226" gutterbordercolordark="Gray"
                                gutterbordercolorlight="White" height="150px" helperfilesparameters="" helperfilespath=""
                                htmlmodecss="" htmlmodedefaultstomonospacefont="True" imagegallerypath="~/images/"
                                imagegalleryurl="ftb.imagegallery.aspx?rif={0}&cif={0}" installationerrormessage="InlineMessage"
                                javascriptlocation="InternalResource" language="en-US" pastemode="Default" readonly="False"
                                removescriptnamefrombookmarks="True" removeservernamefromurls="True" rendermode="NotSet"
                                scriptmode="External" showtagpath="False" sslurl="/." startmode="DesignMode"
                                stripallscripting="False" supportfolder="/aspnet_client/FreeTextBox/" tabindex="-1"
                                tabmode="InsertSpaces" text='<%# Bind("other") %>' textdirection="LeftToRight"
                                toolbarbackcolor="Transparent" toolbarbackgroundimage="True" toolbarimageslocation="InternalResource"
                                toolbarlayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                                toolbarstyleconfiguration="Office2003" updatetoolbar="True" usetoolbarbackgroundimage="True"
                                width="600px"></ftb:freetextbox>
                            <hr />
                            <table style="width: 100%">
                                <tr>
                                    <td align="left" style="width: 50%; height: 23px">
                                        &nbsp;<asp:Button ID="Button5" runat="server" CausesValidation="True" CommandName="Insert"
                                            Text="儲存資料" /></td>
                                    <td align="right" style="width: 50%; height: 23px">
                                        <asp:Button ID="Button6" runat="server" CausesValidation="False" CommandName="Cancel"
                                            Text="取消" />
                                    </td>
                                </tr>
                            </table>
                            <asp:ObjectDataSource ID="CateItemObjectDataSource" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                TypeName="EFFDSTableAdapters.EFFS_EDUCATEITEMTableAdapter" UpdateMethod="Update">
                                <InsertParameters>
                                    <asp:Parameter Name="eduCateItemID" Type="String" />
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="CateItemName" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList1" Name="cateID" PropertyName="SelectedValue"
                                        Type="String" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="eduCateItemID" Type="String" />
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="CateItemName" Type="String" />
                                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="CateObjectDataSource" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                TypeName="EFFDSTableAdapters.EFFS_EDUCATETableAdapter" UpdateMethod="Update">
                                <InsertParameters>
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="cateName" Type="String" />
                                    <asp:Parameter Name="Order" Type="Int32" />
                                </InsertParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_eduCateID" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="cateName" Type="String" />
                                    <asp:Parameter Name="Order" Type="Int32" />
                                    <asp:Parameter Name="Original_eduCateID" Type="String" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                        </InsertItemTemplate>
                        <ItemTemplate>
                            <table style="width: 100%">
                                <tr>
                                    <td align="left" style="width: 50%; height: 23px">
                                        <asp:Button ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Edit"
                                            Text="編輯資料" /></td>
                                    <td align="right" style="width: 50%; height: 23px">
                                        <asp:Button ID="LinkButton5" runat="server" CausesValidation="False" CommandName="New"
                                            Text="新增資料" />
                                    </td>
                                </tr>
                            </table>
                            <hr />
                            <asp:Label ID="Label13" runat="server" ForeColor="Blue" Text="訓練類別:"></asp:Label><asp:DropDownList
                                ID="DropDownList1" runat="server" AutoPostBack="True" DataSourceID="CateObjectDataSource"
                                DataTextField="cateName" DataValueField="eduCateID" Enabled="False" SelectedValue='<%# Bind("eduCateID") %>'>
                            </asp:DropDownList>
                            <asp:DropDownList
                                ID="DropDownList2" runat="server" AutoPostBack="True" DataSourceID="CateItemObjectDataSource"
                                DataTextField="CateItemName" DataValueField="eduCateItemID" Enabled="False" SelectedValue='<%# Bind("eduCateItemID") %>' Visible="False">
                            </asp:DropDownList><br />
                            <br />
                            <asp:Label ID="Label15" runat="server" ForeColor="Blue" Text="說明:"></asp:Label>
                            <br />
                            <asp:Label ID="Label16" runat="server" Text='<%# Eval("other") %>'></asp:Label>
                            <asp:ObjectDataSource ID="CateItemObjectDataSource" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                TypeName="EFFDSTableAdapters.EFFS_EDUCATEITEMTableAdapter" UpdateMethod="Update">
                                <InsertParameters>
                                    <asp:Parameter Name="eduCateItemID" Type="String" />
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="CateItemName" Type="String" />
                                </InsertParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="DropDownList1" Name="cateID" PropertyName="SelectedValue"
                                        Type="String" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="eduCateItemID" Type="String" />
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="CateItemName" Type="String" />
                                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="CateObjectDataSource" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                TypeName="EFFDSTableAdapters.EFFS_EDUCATETableAdapter" UpdateMethod="Update">
                                <InsertParameters>
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="cateName" Type="String" />
                                    <asp:Parameter Name="Order" Type="Int32" />
                                </InsertParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_eduCateID" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="eduCateID" Type="String" />
                                    <asp:Parameter Name="cateName" Type="String" />
                                    <asp:Parameter Name="Order" Type="Int32" />
                                    <asp:Parameter Name="Original_eduCateID" Type="String" />
                                </UpdateParameters>
                            </asp:ObjectDataSource>
                        </ItemTemplate>
                        <EditRowStyle Font-Size="Small" />
                        <RowStyle Font-Size="Small" />
                        <PagerStyle Font-Size="Small" />
                    </asp:FormView>
                    <asp:ObjectDataSource ID="SelfEduObjectDataSource" runat="server" DeleteMethod="Delete"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                        TypeName="EFFDSTableAdapters.EFFS_SELFEDUTableAdapter" UpdateMethod="Update">
                        <InsertParameters>
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="eduCateID" Type="String" />
                            <asp:Parameter Name="eduCateItemID" Type="String" />
                            <asp:Parameter Name="other" Type="String" />
                            <asp:Parameter Name="keydate" Type="DateTime" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="GridView2" DefaultValue="99999" Name="ID" PropertyName="SelectedValue"
                                Type="Int32" />
                        </SelectParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="eduCateID" Type="String" />
                            <asp:Parameter Name="eduCateItemID" Type="String" />
                            <asp:Parameter Name="other" Type="String" />
                            <asp:Parameter Name="keydate" Type="DateTime" />
                            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
        </fieldset>
        <asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_yy"
            runat="server" Visible="False"></asp:Label><asp:Label ID="_seq" runat="server" Visible="False"></asp:Label><asp:Label
                ID="_temp" runat="server" Visible="False"></asp:Label>
        <fieldset>
            <legend>說明</legend>
            <asp:Label ID="note" runat="server"></asp:Label>
        </fieldset>
    </form>
</body>
</html>
