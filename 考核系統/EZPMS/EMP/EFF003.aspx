<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF003.aspx.cs" Inherits="EMP_EFF003" Title="合晶科技績效考核系統（Web版）v1.0" validateRequest="false"  %>

<%@ Register Assembly="RadCalendar.Net2" Namespace="Telerik.WebControls" TagPrefix="radCln" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc2" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>

<%@ Register Src="../UC/EmpInfo.ascx" TagName="EmpInfo" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc2:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>平日績效記要</h5>
    <asp:Label ID="nobr" runat="server"></asp:Label>
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note1" runat="server"></asp:Label></fieldset>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoKey"
        DataSourceID="ObjectDataSource1" AllowPaging="True" PageSize="5" AllowSorting="True" Width="100%">
        <Columns>
         <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>     
            <asp:BoundField DataField="AutoKey" HeaderText="AutoKey" InsertVisible="False" ReadOnly="True"
                SortExpression="AutoKey" Visible="False" />
            <asp:BoundField DataField="adate" HeaderText="日期" SortExpression="adate" DataFormatString="{0:yyyy/MM/dd}" HtmlEncode="False" />
            <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
            <asp:TemplateField HeaderText="關連項目" SortExpression="effscate">
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownListcate" runat="server" Enabled="False" SelectedValue='<%# Bind("effscate") %>' DataSourceID="ObjectDataSource3" DataTextField="effcateName" DataValueField="effcateID">
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="類別" SortExpression="type">
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownListtype" runat="server" Enabled="False" SelectedValue='<%# Bind("type") %>'>
                        <asp:ListItem Selected="True" Value="A001">優良事蹟</asp:ListItem>
                        <asp:ListItem Value="B001">待改進事項</asp:ListItem>
                    </asp:DropDownList>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="record" HeaderText="記要" SortExpression="record" HtmlEncode="False" >
                <ItemStyle Width="200px" />
            </asp:BoundField>
            <asp:BoundField DataField="mangname" HeaderText="主管" Visible="False" />
            <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate" Visible="False"  />
             <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByNobr"
        TypeName="EFFDSTableAdapters.EFFS_RECORDTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="nobr" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="record" Type="String" />
            <asp:Parameter Name="adate" Type="DateTime" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="effscate" Type="String" />
            <asp:Parameter Name="mangname" Type="String" />
            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:SessionParameter Name="nobr" SessionField="nobr" Type="String" />
            <asp:SessionParameter DefaultValue="" Name="mangname" SessionField="nobr" Type="String" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="nobr" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="record" Type="String" />
            <asp:Parameter Name="adate" Type="DateTime" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="effscate" Type="String" />
            <asp:Parameter Name="mangname" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:FormView ID="FormView1" runat="server" DataKeyNames="AutoKey" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemInserting="FormView1_ItemInserting" OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating" OnModeChanged="FormView1_ModeChanged" OnModeChanging="FormView1_ModeChanging">
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
            <table>
                <tr>
                    <td colspan="3">
                        <span style="color: #0000ff">日期：</span><radCln:RadDatePicker ID="RadDatePicker1" runat="server" Culture="Chinese (Taiwan)"
                            SelectedDate='<%# Bind("adate") %>'>
                            <DateInput Skin="">
                            </DateInput>
                        </radCln:RadDatePicker>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <span style="color: #0000ff">關連項目：</span>
             <asp:DropDownList ID="DropDownList2" runat="server" Enabled="True" SelectedValue='<%# Bind("effscate") %>' DataSourceID="ObjectDataSource3" DataTextField="effcateName" DataValueField="effcateID">
                    </asp:DropDownList></td>
                </tr>
                <tr>
                    <td colspan="3">
                        <span style="color: #0000ff">類別：</span>
             <asp:DropDownList ID="DropDownListtye" runat="server" Enabled="True" SelectedValue='<%# Bind("type") %>'>
                        <asp:ListItem Selected="True" Value="A001">優良事蹟</asp:ListItem>
                        <asp:ListItem Value="B001">待改進事項</asp:ListItem>
                    </asp:DropDownList>
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
                        <span style="color: #0000ff">記事：</span><FTB:FreeTextBox ID="FreeTextBox1" runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak"
                ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20"
                ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath=""
                ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50"
                DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="Gray"
                EditorBorderColorLight="Gray" EnableHtmlMode="False" EnableSsl="False" EnableToolbars="False"
                Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="Gray"
                GutterBorderColorLight="White" Height="150px" HelperFilesParameters="" HelperFilesPath=""
                HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/"
                ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage"
                JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False"
                RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet"
                ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode"
                StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/" TabIndex="-1"
                TabMode="InsertSpaces" Text='<%# Bind("record") %>' TextDirection="LeftToRight"
                ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True"
                Width="600px">
            </FTB:FreeTextBox>
                    </td>
                </tr>
            </table>
            <br />
            &nbsp;<br />
            
            <asp:Label ID="AutoKeyLabel1" runat="server" Text='<%# Eval("AutoKey") %>' Visible="false"></asp:Label>
            <asp:TextBox ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>'  Visible="false" Width="18px"></asp:TextBox>
           
        
         
        </EditItemTemplate>
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
            <span style="color: #0000ff">日期：</span>&nbsp;<radCln:RadDatePicker ID="RadDatePicker2" runat="server" Culture="Chinese (Taiwan)"
                SelectedDate='<%# Bind("adate") %>'>
                <DateInput Skin="">
                </DateInput>
            </radCln:RadDatePicker>
            &nbsp;<br />
            <span style="color: #0000ff">關連項目：</span>
             <asp:DropDownList ID="DropDownList2" runat="server" Enabled="True" SelectedValue='<%# Bind("effscate") %>' DataSourceID="ObjectDataSource3" DataTextField="effcateName" DataValueField="effcateID">
                    </asp:DropDownList><br />
            <span style="color: #0000ff">類別：</span>
             <asp:DropDownList ID="DropDownListtye" runat="server" Enabled="True" SelectedValue='<%# Bind("type") %>'>
                        <asp:ListItem Selected="True" Value="A001">優良事蹟</asp:ListItem>
                        <asp:ListItem Value="B001">待改進事項</asp:ListItem>
                    </asp:DropDownList><br />
            <span style="color: #0000ff">記事：</span>
            <FTB:FreeTextBox ID="FreeTextBox1" runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak"
                ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20"
                ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath=""
                ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50"
                DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="Gray"
                EditorBorderColorLight="Gray" EnableHtmlMode="False" EnableSsl="False" EnableToolbars="False"
                Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="Gray"
                GutterBorderColorLight="White" Height="150px" HelperFilesParameters="" HelperFilesPath=""
                HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/"
                ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage"
                JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False"
                RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet"
                ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode"
                StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/" TabIndex="-1"
                TabMode="InsertSpaces" Text='<%# Bind("record") %>' TextDirection="LeftToRight"
                ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True" Width="600px">
            </FTB:FreeTextBox>
            <br />

       
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
            
            <asp:Label ID="AutoKeyLabel" runat="server" Text='<%# Eval("AutoKey") %>' Visible="false"></asp:Label>
            <asp:Label ID="nobrLabel" runat="server" Text='<%# Bind("nobr") %>'  Visible="false"></asp:Label>
            <span style="color: #0000ff">日期：</span>
            <asp:Label ID="adateLabel" runat="server" Text='<%# Bind("adate", "{0:d}") %>'></asp:Label><br />
            <span style="color: #0000ff">關連項目：</span>
             <asp:DropDownList ID="DropDownList2" runat="server" Enabled="False" SelectedValue='<%# Bind("effscate") %>' DataSourceID="ObjectDataSource3" DataTextField="effcateName" DataValueField="effcateID">
                    </asp:DropDownList><br />
            <span style="color: #0000ff">類別：</span>
             <asp:DropDownList ID="DropDownListtype" runat="server" Enabled="False" SelectedValue='<%# Bind("type") %>'>
                        <asp:ListItem Selected="True" Value="A001">優良事蹟</asp:ListItem>
                        <asp:ListItem Value="B001">待改進事項</asp:ListItem>
                    </asp:DropDownList><br />
            <span style="color: #0000ff">記事:：</span><asp:Label ID="recordLabel" runat="server" Text='<%# Bind("record") %>'></asp:Label><br />
            <span style="color: #0000ff">輸入日期：</span>
            <asp:Label ID="keydateLabel" runat="server" Text='<%# Bind("keydate") %>'></asp:Label><br />
          
           
        </ItemTemplate>
         <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
        TypeName="EFFDSTableAdapters.EFFS_RECORDTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="nobr" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="record" Type="String" />
            <asp:Parameter Name="adate" Type="DateTime" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="effscate" Type="String" />
            <asp:Parameter Name="mangname" Type="String" />
            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="nobr" Type="String" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="record" Type="String" />
            <asp:Parameter Name="adate" Type="DateTime" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="effscate" Type="String" />
            <asp:Parameter Name="mangname" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_CATETableAdapter"></asp:ObjectDataSource>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="GridView1" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>
    <table width="100%">
        <tr>
            <td>
            </td>
            <td align="right">
    <radCln:RadDatePicker ID="RadDatePicker2" runat="server" Width="30px">
        <DateInput Skin="">
        </DateInput>
    </radCln:RadDatePicker>
            </td>
        </tr>
    </table>
</asp:Content>

