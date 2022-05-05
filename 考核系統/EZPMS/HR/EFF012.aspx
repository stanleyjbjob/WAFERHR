<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF012.aspx.cs" Inherits="HR_EFF012" Title="合晶科技績效考核系統（Web版）v1.0" ValidateRequest ="false" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick1">
        <Items>
            <asp:MenuItem Text="系統說明設定" Value="系統說明設定">
                <asp:MenuItem Text="首頁說明設定" Value="Default.aspx"></asp:MenuItem>
            </asp:MenuItem>
            <asp:MenuItem Text="一般員工說明設定" Value="一般員工說明設定">
                <asp:MenuItem Text="平日績效記要" Value="EMP.EFF003.aspx"></asp:MenuItem>
                <asp:MenuItem Text="工作目標設定" Value="EMP.EFF004.aspx"></asp:MenuItem>
                <asp:MenuItem Text="工作目標與行為態度比重查詢" Value="EMP.EFF006.aspx"></asp:MenuItem>
                <asp:MenuItem Text="評核者查詢" Value="EMP.EFF005.aspx"></asp:MenuItem>
                <asp:MenuItem Text="非直線員工評核" Value="EMP.EFFS007.aspx"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-名單" Value="EMP.EFF001.aspx"></asp:MenuItem>
                <asp:MenuItem Text="其它考核項目" Value="EMP.EFF001t.aspx"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-工作目標" Value="EMP.EFF002.aspx.1"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-行為態度" Value="EMP.EFF002.aspx.2"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-績效面談" Value="EMP.EFF002.aspx.3"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-訓練需求" Value="EMP.EFF002.aspx.4"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-發展計劃" Value="EMP.EFF002.aspx.5"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-上傳參考資料" Value="EMP.EFF002.aspx.6"></asp:MenuItem>
                <asp:MenuItem Text="績效考核表-完成" Value="EMP.EFF002.aspx.7"></asp:MenuItem>
                <asp:MenuItem Text="其它考核項目-考核項目" Value="EMP.EFF002t.aspx.1"></asp:MenuItem>
                <asp:MenuItem Text="其它考核項目-員工問題及建議" Value="EMP.EFF002t.aspx.2"></asp:MenuItem>
                <asp:MenuItem Text="其它考核項目-完成" Value="EMP.EFF002t.aspx.3"></asp:MenuItem>
            </asp:MenuItem>
            <asp:MenuItem Text="主管說明設定" Value="主管說明設定">
                <asp:MenuItem Text="員工平日績效記要" Value="Mang.EFF001.aspx"></asp:MenuItem>
                <asp:MenuItem Text="員工工作目標設定" Value="Mang.EFF002.aspx"></asp:MenuItem>
                <asp:MenuItem Text="評核者設定" Value="Mang.EFF007.aspx"></asp:MenuItem>
                <asp:MenuItem Text="考核類別比重設定" Value="Mang.EFF006.aspx"></asp:MenuItem>
                <asp:MenuItem Text="行為態度比重設定" Value="Mang.EFF005.aspx"></asp:MenuItem>
                <asp:MenuItem Text="員工年度績效考核-員工名單" Value="Mang.EFF003.aspx"></asp:MenuItem>
                
                <asp:MenuItem Text="員工年度績效考核-工作目標" Value="Mang.EFF004.aspx.1"></asp:MenuItem>
                <asp:MenuItem Text="員工年度績效考核-行為態度" Value="Mang.EFF004.aspx.2"></asp:MenuItem>
                <asp:MenuItem Text="員工年度績效考核-績效面談" Value="Mang.EFF004.aspx.3"></asp:MenuItem>
                <asp:MenuItem Text="員工年度績效考核-訓練需求" Value="Mang.EFF004.aspx.4"></asp:MenuItem>
                <asp:MenuItem Text="員工年度績效考核-發展計劃" Value="Mang.EFF004.aspx.5"></asp:MenuItem>
                <asp:MenuItem Text="員工年度績效考核-上傳參考資料" Value="Mang.EFF004.aspx.6"></asp:MenuItem>
                <asp:MenuItem Text="員工年度績效考核-完成" Value="Mang.EFF004.aspx.7"></asp:MenuItem>
            </asp:MenuItem>
        </Items>
    </asp:Menu>
 <fieldset>
 <legend><asp:Label ID="title" runat="server"></asp:Label></legend>
 
 <asp:FormView ID="FormView1" runat="server" DataKeyNames="AuotKey" DataSourceID="ObjectDataSource1"
                    DefaultMode="Edit" Width="100%">
                    <InsertItemTemplate>
                    
                        app:
                        <asp:TextBox ID="appTextBox" runat="server" Text='<%# Bind("app") %>'>
                        </asp:TextBox><br />
                        note:
                        <asp:TextBox ID="noteTextBox" runat="server" Text='<%# Bind("note") %>'>
                        </asp:TextBox><br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="插入">
                        </asp:LinkButton>
                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="取消">
                        </asp:LinkButton>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        AuotKey:
                        <asp:Label ID="AuotKeyLabel" runat="server" Text='<%# Eval("AuotKey") %>'></asp:Label><br />
                        app:
                        <asp:Label ID="appLabel" runat="server" Text='<%# Bind("app") %>'></asp:Label><br />
                        note:
                        <asp:Label ID="noteLabel" runat="server" Text='<%# Bind("note") %>'></asp:Label><br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                            Text="編輯"></asp:LinkButton>
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                            Text="刪除"></asp:LinkButton>
                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                            Text="新增"></asp:LinkButton>
                    </ItemTemplate>
                    <EditItemTemplate>
                   
                        <FTB:FreeTextBox ID="FreeTextBox1" runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                            AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                            AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak"
                            ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20"
                            ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath=""
                            ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                            DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50"
                            DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="Gray"
                            EditorBorderColorLight="Gray" EnableHtmlMode="True" EnableSsl="False"
                            EnableToolbars="True" Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226"
                            GutterBorderColorDark="Gray" GutterBorderColorLight="White"
                            Height="350px" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True"
                            ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}"
                            InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource"
                            Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True"
                            RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False"
                            SslUrl="/." StartMode="DesignMode" StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/"
                            TabIndex="-1" TabMode="InsertSpaces" Text='<%# Bind("note") %>' TextDirection="LeftToRight"
                            ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                            ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                            ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True"
                            Width="100%">
                        </FTB:FreeTextBox>
                           <hr />    
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
                      
                        <asp:TextBox
                            ID="appTextBox" runat="server" Text='<%# Bind("app") %>' Visible="False" Width="58px"></asp:TextBox>
                        <asp:Label ID="AuotKeyLabel1" runat="server" Text='<%# Eval("AuotKey") %>' Visible="false"></asp:Label>
                    </EditItemTemplate>
                </asp:FormView>
                </fieldset>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByApp"
        TypeName="EFFMANGDSTableAdapters.EFFS_NOTETableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_AuotKey" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="app" Type="String" />
            <asp:Parameter Name="note" Type="String" />
            <asp:Parameter Name="Original_AuotKey" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="Label1" DefaultValue="&quot;&quot;" Name="app" PropertyName="Text"
                Type="String" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="app" Type="String" />
            <asp:Parameter Name="note" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
</asp:Content>

