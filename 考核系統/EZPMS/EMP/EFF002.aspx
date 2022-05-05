<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true"
    CodeFile="EFF002.aspx.cs" Inherits="EMP_EFF002" Title="科技績效考核系統（Web版）v1.0" ValidateRequest="false" %>

<%@ Register Src="EFF004.ascx" TagName="EFF004" TagPrefix="uc3" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc2" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="../UC/EmpInfo.ascx" TagName="EmpInfo" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc2:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:EmpInfo ID="EmpInfo1" runat="server" />
    <asp:Wizard ID="Wizard1" runat="server" BackColor="#EFF3FB" BorderColor="#B5C7DE"
        BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" Width="100%" ActiveStepIndex="3"
        OnNextButtonClick="Wizard1_NextButtonClick" OnFinishButtonClick="Wizard1_FinishButtonClick"
        OnActiveStepChanged="Wizard1_ActiveStepChanged" OnSideBarButtonClick="Wizard1_SideBarButtonClick">
        <StepStyle Font-Size="0.8em" ForeColor="#333333" />
        <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" Width="120px" />
        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
        <WizardSteps>
            <asp:WizardStep runat="server" Title="1.工作目標設定 MBO">
                <asp:Button ID="Button4" runat="server" CommandArgument="0" OnClick="Button3_Click"
                    Text="暫時存檔" />
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                    DataSourceID="ObjectDataSource1" Width="100%" OnRowDataBound="GridView1_RowDataBound"
                    ShowFooter="True" OnDataBound="GridView1_DataBound" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                    <Columns>
                        <asp:BoundField DataField="autoKey" HeaderText="autoKey" ReadOnly="True" SortExpression="autoKey"
                            Visible="False" />
                        <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                        <asp:BoundField DataField="works" HeaderText="工作目標" SortExpression="works" HtmlEncode="False" />
                        <asp:BoundField DataField="standard" HeaderText="衡量準標" SortExpression="standard"
                            Visible="False" />
                        <asp:BoundField DataField="rate" HeaderText="比重" SortExpression="rate">
                            <ItemStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Center" />
                            <HeaderStyle Font-Bold="True" />
                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" HorizontalAlign="Right" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="衡量標準" SortExpression="appr">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("appr") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("appr") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="執行之質與量的綜合成果" SortExpression="bespeak">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("bespeak") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <FTB:FreeTextBox ID="ftb_appr" runat="server" Height="80px" Width="100%" BreakMode="LineBreak"
                                    ButtonSet="Office2003" EnableHtmlMode="False" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                                    AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                                    AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" ButtonDownImage="False"
                                    ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource"
                                    ButtonOverImage="False" ButtonPath="" ButtonWidth="21" ClientSideTextChanged=""
                                    ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass="" DesignModeCss=""
                                    DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage="" DownLevelMode="TextArea"
                                    DownLevelRows="10" EditorBorderColorDark="Gray" EditorBorderColorLight="Gray"
                                    EnableSsl="False" EnableToolbars="False" Focus="False" FormatHtmlTagsToXhtml="True"
                                    GutterBackColor="129, 169, 226" GutterBorderColorDark="Gray" GutterBorderColorLight="White"
                                    HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="False"
                                    ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}"
                                    InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource"
                                    Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True"
                                    RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False"
                                    SslUrl="/." StartMode="DesignMode" StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/"
                                    TabIndex="-1" TabMode="InsertSpaces" Text='<%# Bind("bespeak") %>' TextDirection="LeftToRight"
                                    ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                                    ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                                    ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True">
                                </FTB:FreeTextBox>
                                <asp:Label ID="_AutoKey" runat="server" Text='<%# Eval("AutoKey") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="reality" HeaderText="reality" SortExpression="reality"
                            Visible="False" />
                        <asp:CheckBoxField DataField="mangCheck" HeaderText="mangCheck" SortExpression="mangCheck"
                            Visible="False" />
                        <asp:BoundField DataField="mangcheckDate" HeaderText="mangcheckDate" SortExpression="mangcheckDate"
                            Visible="False" />
                        <asp:BoundField DataField="mangname" HeaderText="mangname" SortExpression="mangname"
                            Visible="False" />
                        <asp:BoundField DataField="key_date" HeaderText="key_date" SortExpression="key_date"
                            Visible="False" />
                        <asp:CheckBoxField DataField="included" HeaderText="included" SortExpression="included"
                            Visible="False" />
                        <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" />
                        <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" />
                        <asp:TemplateField HeaderText="評分">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="num" runat="server" Width="50px" Font-Bold="True" ForeColor="Red"
                                    CssClass="Text_int" Visible="False"></asp:TextBox>
                                <asp:Label ID="LB_Apprid" runat="server" Text='<%# Bind("AutoKey") %>' Visible="False"></asp:Label>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="num"
                                    Display="Dynamic" ErrorMessage="*不能空白">*不能空白</asp:RequiredFieldValidator><asp:CompareValidator
                                        ID="CompareValidator1" runat="server" ControlToValidate="num" Display="Dynamic"
                                        ErrorMessage="*只能輸入數值" Operator="DataTypeCheck" Type="Double">*只能輸入數值</asp:CompareValidator>
                            <asp:DropDownList ID="ddl_num" runat="server">
                                                            <asp:ListItem Value=" ">※請選擇※ </asp:ListItem>
                                                            <asp:ListItem Value="4">超過標準</asp:ListItem>
                                                            <asp:ListItem Value="3">符合標準</asp:ListItem>
                                                            <asp:ListItem Value="2">需改進</asp:ListItem>
                                                            <asp:ListItem Value="1">極需改進</asp:ListItem>
                                                            <asp:ListItem Value="0">低於標準</asp:ListItem>
                                                        </asp:DropDownList>
                            </ItemTemplate>
                            <FooterStyle Font-Size="X-Small" ForeColor="Red" HorizontalAlign="Right" />
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByMangCheck"
                    TypeName="EFFDSTableAdapters.EFFS_APPRTableAdapter" UpdateMethod="Update">
                    <InsertParameters>
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="works" Type="String" />
                        <asp:Parameter Name="standard" Type="String" />
                        <asp:Parameter Name="rate" Type="String" />
                        <asp:Parameter Name="appr" Type="String" />
                        <asp:Parameter Name="bespeak" Type="String" />
                        <asp:Parameter Name="reality" Type="String" />
                        <asp:Parameter Name="mangCheck" Type="Boolean" />
                        <asp:Parameter Name="mangcheckDate" Type="DateTime" />
                        <asp:Parameter Name="mangname" Type="String" />
                        <asp:Parameter Name="key_date" Type="DateTime" />
                        <asp:Parameter Name="included" Type="Boolean" />
                        <asp:Parameter Name="yy" Type="Int32" />
                        <asp:Parameter Name="seq" Type="Int32" />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="_yy" Name="yy" PropertyName="Text" Type="Int32" />
                        <asp:ControlParameter ControlID="_seq" Name="seq" PropertyName="Text" Type="Int32" />
                        <asp:Parameter DefaultValue="true" Name="isIncluded" Type="Boolean" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="works" Type="String" />
                        <asp:Parameter Name="standard" Type="String" />
                        <asp:Parameter Name="rate" Type="String" />
                        <asp:Parameter Name="appr" Type="String" />
                        <asp:Parameter Name="bespeak" Type="String" />
                        <asp:Parameter Name="reality" Type="String" />
                        <asp:Parameter Name="mangCheck" Type="Boolean" />
                        <asp:Parameter Name="mangcheckDate" Type="DateTime" />
                        <asp:Parameter Name="mangname" Type="String" />
                        <asp:Parameter Name="key_date" Type="DateTime" />
                        <asp:Parameter Name="included" Type="Boolean" />
                        <asp:Parameter Name="yy" Type="Int32" />
                        <asp:Parameter Name="seq" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                </asp:ObjectDataSource>
                <fieldset>
                    <legend>說明</legend>
                    <asp:Label ID="note1" runat="server"></asp:Label>
                </fieldset>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title=" ">
            <iframe id="Iframe2" runat="server" frameborder="1" height="500" marginheight="0"
                    marginwidth="0" scrolling="auto" src="EFF004t.aspx" width="98%"></iframe>
                
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="2.行為職能發展期望與評核">
                &nbsp;<asp:Button ID="Button41" runat="server" CommandArgument="2" OnClick="Button3_Click"
                    Text="暫時存檔" />
                <asp:DataList ID="DataList2" runat="server" DataSourceID="SqlDataSource1" meta:resourceKey="DataList2Resource1"
                    OnItemDataBound="DataList2_ItemDataBound" Width="100%">
                    <HeaderTemplate>
                        <table width="100%">
                            <tr>
                                <td align="center" width="15%">
                                    績效評估項目</td>
                                <td align="center" width="20%">
                                     </td>
                                <td align="center" width="5%">
                                     </td>
                            </tr>
                        </table>
                    </HeaderTemplate>
                    <ItemTemplate>
                        <fieldset>
                            <asp:Label ID="effcateIDLabel" runat="server" 
                                Text='<%# Eval("effcateID") %>' Visible="false"></asp:Label>
                            <table width="100%">
                                <tr>
                                    <td width="10%">
                                    </td>
                                    <td width="70%">
                                    </td>
                                    <td width="10%">
                                    </td>
                                    <td width="10%">
                                    </td>
                                </tr>
                                <tr>
                                    <td width="15%">
                                        <asp:Label ID="effcateNameLabel" runat="server" meta:resourcekey="effcateNameLabelResource1"
                                            Text='<%# Eval("effcateName") %>' Font-Size="X-Small" ForeColor="Black"></asp:Label></td>
                                    <td colspan="3" width="90%">
                                        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="dataViewDs"
                                            meta:resourcekey="GridView5Resource1" OnRowDataBound="GridView5_RowDataBound"
                                            ShowHeader="False" Width="100%">
                                            <Columns>
                                                <asp:BoundField DataField="effsID" meta:resourcekey="BoundFieldResource17" SortExpression="effsID"
                                                    Visible="False" />
                                                <asp:BoundField DataField="effsName" HeaderText="考核細目" meta:resourcekey="BoundFieldResource18"
                                                    SortExpression="effsName">
                                                    <ItemStyle Width="40%" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="權重" SortExpression="effsNum" Visible="False">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Font-Bold="true" Text='<%# Bind("rate") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemStyle ForeColor="Blue" HorizontalAlign="Center" Width="10%" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="_rate" runat="server" Font-Bold="true" ForeColor="Blue" Text='<%# Bind("rate", "{0:0}") %>'></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="自我評分" meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                                        &nbsp;<asp:TextBox ID="num" runat="server" Font-Bold="true" ForeColor="Red" Width="34px" Visible="False"></asp:TextBox>
                                                        <asp:Label ID="lb_effsID" runat="server" Text='<%# Bind("effsID") %>' Visible="False"></asp:Label>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="num"
                                                            Display="Dynamic" ErrorMessage="*不能空白">*</asp:RequiredFieldValidator><asp:CompareValidator
                                                                ID="CompareValidator1" runat="server" ControlToValidate="num" Display="Dynamic"
                                                                ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*只能輸入數值</asp:CompareValidator>&nbsp;
                                                        <asp:DropDownList ID="ddl_num" runat="server">
                                                            <asp:ListItem Value=" ">※請選擇※ </asp:ListItem>
                                                            <asp:ListItem Value="4">超過標準</asp:ListItem>
                                                            <asp:ListItem Value="3">符合標準</asp:ListItem>
                                                            <asp:ListItem Value="2">需改進</asp:ListItem>
                                                            <asp:ListItem Value="1">極需改進</asp:ListItem>
                                                            <asp:ListItem Value="0">低於標準</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="50%" />
                                                </asp:TemplateField>
                                                
                                            </Columns>
                                        </asp:GridView>
                                        <table width="100%">
                                            <tr>
                                                <td width="20%">
                                                    對低於標準之項目請舉實例說明</td>
                                                <td width="30%">
                                                    <asp:TextBox ID="o1" runat="server" Rows="3" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
                                                <td width="20%">
                                                    對超過標準之項目請舉例說明</td>
                                                <td width="30%">
                                                    <asp:TextBox ID="o2" runat="server" Rows="3" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>
                                    需改進方向</td>
                                                <td colspan="3">
                                                    <asp:TextBox ID="o3" runat="server" Rows="3" TextMode="MultiLine" Width="100%"></asp:TextBox></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td style="width: 3px">
                                                </td>
                                                <td style="width: 3px">
                                                </td>
                                            </tr>
                                        </table>
                                    </td>
                                </tr>
                            </table>
                            <asp:SqlDataSource ID="dataViewDs" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                                SelectCommand="SELECT EFFS_CATEITEM.effsID, EFFS_CATEITEM.effsName, EFFS_TEMPLETCATEITEM.rate FROM EFFS_TEMPLETCATEITEM INNER JOIN EFFS_CATEITEM ON EFFS_TEMPLETCATEITEM.effsID = EFFS_CATEITEM.effsID WHERE (EFFS_TEMPLETCATEITEM.templetID = @TempID) AND (EFFS_CATEITEM.effcateID = @CateID) ORDER BY EFFS_TEMPLETCATEITEM.[order]">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="_temp" DefaultValue="A001" Name="TempID" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="effcateIDLabel" DefaultValue="" Name="CateID" PropertyName="Text" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </fieldset>
                    </ItemTemplate>
                </asp:DataList>
                <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT EFFS_CATE.effcateID, EFFS_CATE.effcateName FROM EFFS_TEMPLETCATE INNER JOIN EFFS_CATE ON EFFS_TEMPLETCATE.effcateID = EFFS_CATE.effcateID WHERE (EFFS_TEMPLETCATE.templetID = @TempID) ORDER BY EFFS_TEMPLETCATE.[order]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_temp" DefaultValue="A001" Name="TempID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <fieldset>
                    <legend>說明</legend>
                    <asp:Label ID="note2" runat="server"></asp:Label>
                </fieldset>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="3.自評項目">
                <asp:Button ID="Button44" runat="server" CommandArgument="3" OnClick="Button3_Click"
                    Text="暫時存檔" />
                <asp:GridView ID="GridViewInterView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
                    DataSourceID="SqlDataSource_INTERVIEW" OnRowDataBound="GridViewInterView_RowDataBound"
                    Width="100%">
                    <Columns>
                        <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"
                            Visible="False" />
                        <asp:BoundField DataField="interview" HeaderText="討論內容" SortExpression="interview">
                            <ItemStyle Width="120px" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="員工意見">
                            <ItemTemplate>
                                <asp:Label ID="lb_ID" runat="server" Text='<%# Eval("ID") %>' Visible="False"></asp:Label>
                                <FTB:FreeTextBox ID="FreeTextBox1" runat="server" Height="100px" Width="100%" BreakMode="LineBreak"
                                    ButtonSet="Office2003" EnableHtmlMode="False" EnableToolbars="False">
                                </FTB:FreeTextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_INTERVIEW" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT         EFFS_INTERVIEW.ID, EFFS_INTERVIEW.interview
FROM             EFFS_TEMPLETINTERVIEW INNER JOIN
                          EFFS_INTERVIEW ON 
                          EFFS_TEMPLETINTERVIEW.interviewID = EFFS_INTERVIEW.ID
WHERE         (EFFS_TEMPLETINTERVIEW.templetID = @templetID)
ORDER BY  EFFS_TEMPLETINTERVIEW.[order]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_temp" Name="templetID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <fieldset>
                    <legend>說明</legend>
                    <asp:Label ID="note3" runat="server"></asp:Label>
                </fieldset>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="4.訓練需求">
               <iframe id="Eduframe" runat="server" frameborder="1" height="500" marginheight="0"
                    marginwidth="0" scrolling="auto" src="EFF002_4.aspx" width="98%"></iframe>
                <hr />
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="5.發展計劃">
                <fieldset>
                    <legend>說明</legend>
                    <asp:Label ID="note5" runat="server"></asp:Label>
                </fieldset>
                <span style="font-size: 12pt; color: #000000; font-family: 新細明體; mso-ascii-font-family: 'Times New Roman';
                    mso-hansi-font-family: 'Times New Roman'; mso-bidi-font-family: 'Times New Roman';
                    mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-TW;
                    mso-bidi-language: AR-SA">
                    <asp:GridView ID="leanplanGridView" runat="server" AutoGenerateColumns="False" DataSourceID="leanplanSqlDataSource1"
                        OnRowDataBound="leanplanGridView_RowDataBound" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="note" HeaderText="" SortExpression="note">
                                <ItemStyle Width="330px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID"
                                Visible="False" />
                            <asp:BoundField DataField="learnplanID" HeaderText="learnplanID" SortExpression="learnplanID"
                                Visible="False" />
                            <asp:TemplateField HeaderText="員工意見">
                                <ItemTemplate>
                                    <FTB:FreeTextBox ID="PlanText" runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                                        AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                                        AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak"
                                        ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20"
                                        ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath=""
                                        ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                                        DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50"
                                        DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="Gray"
                                        EditorBorderColorLight="Gray" EnableHtmlMode="False" EnableSsl="False" EnableToolbars="False"
                                        Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="Gray"
                                        GutterBorderColorLight="White" Height="60px" HelperFilesParameters="" HelperFilesPath=""
                                        HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/"
                                        ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage"
                                        JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False"
                                        RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet"
                                        ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode"
                                        StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/" TabIndex="-1"
                                        TabMode="InsertSpaces" Text="" TextDirection="LeftToRight" ToolbarBackColor="Transparent"
                                        ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource" ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                                        ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True"
                                        Width="100%">
                                    </FTB:FreeTextBox>
                                    <asp:Label ID="planID" runat="server" Text='<%# Eval("learnplanID") %>' Visible="False"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="leanplanSqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                        SelectCommand="SELECT EFFS_LEARNPLAN.note, EFFS_TEMPLETLEARNPLAN.templetID, EFFS_TEMPLETLEARNPLAN.learnplanID FROM EFFS_TEMPLETLEARNPLAN INNER JOIN EFFS_LEARNPLAN ON EFFS_TEMPLETLEARNPLAN.learnplanID = EFFS_LEARNPLAN.ID WHERE (EFFS_TEMPLETLEARNPLAN.templetID = @templetID) ORDER BY EFFS_TEMPLETLEARNPLAN.[order]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_temp" DefaultValue="&quot;&quot;" Name="templetID"
                                PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </span><span style="font-size: 12pt; color: #000000; font-family: 新細明體; mso-ascii-font-family: 'Times New Roman';
                    mso-hansi-font-family: 'Times New Roman'"><span style="font-size: 12pt; font-family: 新細明體;
                        mso-ascii-font-family: 'Times New Roman'; mso-hansi-font-family: 'Times New Roman';
                        mso-bidi-font-family: 'Times New Roman'; mso-font-kerning: 1.0pt; mso-ansi-language: EN-US;
                        mso-fareast-language: ZH-TW; mso-bidi-language: AR-SA"></span></span>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="6.上傳參考資料">
                <fieldset>
                    <table width="100%">
                        <tr valign="top">
                            <td colspan="2">
                                <fieldset>
                                    &nbsp;※上傳有關績效考核附加資料！！<asp:FormView ID="FormView5" runat="server" DataKeyNames="autoKey"
                                        DataSourceID="SqlDataSource_UPFILE" DefaultMode="Insert" meta:resourceKey="FormView5Resource1"
                                        OnItemInserting="FormView5_ItemInserting" OnPageIndexChanging="FormView5_PageIndexChanging"
                                        Width="100%">
                                        <InsertItemTemplate>
                                            <span style="color: #0000ff">上傳檔案路徑：</span><br />
                                            &nbsp;<asp:FileUpload ID="FileUpload1" runat="server" meta:resourcekey="FileUpload1Resource1"
                                                Width="300px" /><br />
                                            <span style="color: #0000ff">檔案說明：</span><br />
                                            &nbsp;<asp:TextBox ID="filedesc" runat="server" meta:resourcekey="filedescResource1"
                                                Width="500px"></asp:TextBox><br />
                                            <asp:Button ID="Button1" runat="server" CommandName="Insert" meta:resourcekey="Button1Resource3"
                                                Text="上傳檔案" />
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            autoKey:
                                            <asp:Label ID="autoKeyLabel" runat="server" meta:resourcekey="autoKeyLabelResource6"
                                                Text='<%# Eval("autoKey") %>'></asp:Label><br />
                                            effbaseID:
                                            <asp:Label ID="effbaseIDLabel" runat="server" meta:resourcekey="effbaseIDLabelResource5"
                                                Text='<%# Bind("effbaseID") %>'></asp:Label><br />
                                            upfilename:
                                            <asp:Label ID="upfilenameLabel" runat="server" meta:resourcekey="upfilenameLabelResource1"
                                                Text='<%# Bind("upfilename") %>'></asp:Label><br />
                                            serverfilename:
                                            <asp:Label ID="serverfilenameLabel" runat="server" meta:resourcekey="serverfilenameLabelResource1"
                                                Text='<%# Bind("serverfilename") %>'></asp:Label><br />
                                            filetype:
                                            <asp:Label ID="filetypeLabel" runat="server" meta:resourcekey="filetypeLabelResource1"
                                                Text='<%# Bind("filetype") %>'></asp:Label><br />
                                            filesize:
                                            <asp:Label ID="filesizeLabel" runat="server" meta:resourcekey="filesizeLabelResource1"
                                                Text='<%# Bind("filesize") %>'></asp:Label><br />
                                            upfiledate:
                                            <asp:Label ID="upfiledateLabel" runat="server" meta:resourcekey="upfiledateLabelResource1"
                                                Text='<%# Bind("upfiledate") %>'></asp:Label><br />
                                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                                meta:resourcekey="EditButtonResource5" Text="編輯"></asp:LinkButton>
                                            <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                                meta:resourcekey="DeleteButtonResource5" Text="刪除"></asp:LinkButton>
                                            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                meta:resourcekey="NewButtonResource5" Text="新增"></asp:LinkButton>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            autoKey:
                                            <asp:Label ID="autoKeyLabel1" runat="server" meta:resourcekey="autoKeyLabel1Resource2"
                                                Text='<%# Eval("autoKey") %>'></asp:Label><br />
                                            effbaseID:
                                            <asp:TextBox ID="effbaseIDTextBox" runat="server" meta:resourcekey="effbaseIDTextBoxResource5"
                                                Text='<%# Bind("effbaseID") %>'></asp:TextBox><br />
                                            upfilename:
                                            <asp:TextBox ID="upfilenameTextBox" runat="server" meta:resourcekey="upfilenameTextBoxResource1"
                                                Text='<%# Bind("upfilename") %>'></asp:TextBox><br />
                                            serverfilename:
                                            <asp:TextBox ID="serverfilenameTextBox" runat="server" meta:resourcekey="serverfilenameTextBoxResource1"
                                                Text='<%# Bind("serverfilename") %>'></asp:TextBox><br />
                                            filetype:
                                            <asp:TextBox ID="filetypeTextBox" runat="server" meta:resourcekey="filetypeTextBoxResource1"
                                                Text='<%# Bind("filetype") %>'></asp:TextBox><br />
                                            filesize:
                                            <asp:TextBox ID="filesizeTextBox" runat="server" meta:resourcekey="filesizeTextBoxResource1"
                                                Text='<%# Bind("filesize") %>'></asp:TextBox><br />
                                            upfiledate:
                                            <asp:TextBox ID="upfiledateTextBox" runat="server" meta:resourcekey="upfiledateTextBoxResource1"
                                                Text='<%# Bind("upfiledate") %>'></asp:TextBox><br />
                                            <asp:LinkButton ID="UpdateButton" runat="server" CommandName="Update" meta:resourcekey="UpdateButtonResource2"
                                                Text="更新"></asp:LinkButton>
                                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                meta:resourcekey="UpdateCancelButtonResource2" Text="取消"></asp:LinkButton>
                                        </EditItemTemplate>
                                    </asp:FormView>
                                    <asp:SqlDataSource ID="SqlDataSource_UPFILE" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                                        DeleteCommand="DELETE FROM [EFFS_UPFILE] WHERE [autoKey] = @autoKey" InsertCommand="INSERT INTO [EFFS_UPFILE] ([yy], [seq], [nobr], [upfilename], [serverfilename], [filetype], [filesize], [upfiledate], [filedesc]) VALUES (@yy, @seq, @nobr, @upfilename, @serverfilename, @filetype, @filesize, @upfiledate, @filedesc)"
                                        SelectCommand="SELECT * FROM [EFFS_UPFILE] WHERE (([yy] = @yy) AND ([seq] = @seq) AND ([nobr] = @nobr)) ORDER BY [upfiledate]"
                                        UpdateCommand="UPDATE [EFFS_UPFILE] SET [yy] = @yy, [seq] = @seq, [nobr] = @nobr, [upfilename] = @upfilename, [serverfilename] = @serverfilename, [filetype] = @filetype, [filesize] = @filesize, [upfiledate] = @upfiledate, [filedesc] = @filedesc WHERE [autoKey] = @autoKey">
                                        <InsertParameters>
                                            <asp:Parameter Name="yy" Type="Int32" />
                                            <asp:Parameter Name="seq" Type="Int32" />
                                            <asp:Parameter Name="nobr" Type="String" />
                                            <asp:Parameter Name="upfilename" Type="String" />
                                            <asp:Parameter Name="serverfilename" Type="String" />
                                            <asp:Parameter Name="filetype" Type="String" />
                                            <asp:Parameter Name="filesize" Type="String" />
                                            <asp:Parameter Name="upfiledate" Type="DateTime" />
                                            <asp:Parameter Name="filedesc" Type="String" />
                                        </InsertParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="_yy" Name="yy" PropertyName="Text" Type="Int32" />
                                            <asp:ControlParameter ControlID="_seq" Name="seq" PropertyName="Text" Type="Int32" />
                                            <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" Type="String" />
                                        </SelectParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="yy" Type="Int32" />
                                            <asp:Parameter Name="seq" Type="Int32" />
                                            <asp:Parameter Name="nobr" Type="String" />
                                            <asp:Parameter Name="upfilename" Type="String" />
                                            <asp:Parameter Name="serverfilename" Type="String" />
                                            <asp:Parameter Name="filetype" Type="String" />
                                            <asp:Parameter Name="filesize" Type="String" />
                                            <asp:Parameter Name="upfiledate" Type="DateTime" />
                                            <asp:Parameter Name="filedesc" Type="String" />
                                            <asp:Parameter Name="autoKey" Type="Int32" />
                                        </UpdateParameters>
                                        <DeleteParameters>
                                            <asp:Parameter Name="autoKey" Type="Int32" />
                                        </DeleteParameters>
                                    </asp:SqlDataSource>
                                    <asp:Label ID="showUpFileMSG" runat="server" meta:resourceKey="showUpFileMSGResource1"></asp:Label>
                                    &nbsp;
                                </fieldset>
                                <fieldset>
                                    <legend>說明</legend>
                                    <asp:Label ID="note6" runat="server"></asp:Label>
                                </fieldset>
                            </td>
                        </tr>
                        <tr valign="top">
                            <td colspan="2">
                                <fieldset>
                                    <asp:DataList ID="UPFILEDATELIST" runat="server" DataSourceID="SqlDataSource_UPFILE"
                                        meta:resourceKey="DataList1Resource1" OnDeleteCommand="UPFILEDATELIST_DeleteCommand"
                                        OnSelectedIndexChanged="UPFILEDATELIST_SelectedIndexChanged" RepeatColumns="2"
                                        Width="100%">
                                        <ItemTemplate>
                                            <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse; width: 100%">
                                                <tr>
                                                    <td align="center" rowspan="5" style="width: 50px">
                                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/btn_action-log_bg.gif" meta:resourcekey="Image1Resource1" />
                                                        <br />
                                                    </td>
                                                    <td style="color: #000000" width="100">
                                                        檔案名稱：</td>
                                                    <td>
                                                        <asp:Label ID="upfilenameLabel" runat="server" meta:resourcekey="upfilenameLabelResource2"
                                                            Text='<%# Eval("upfilename") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td width="100">
                                                        檔案大小：</td>
                                                    <td>
                                                        <asp:Label ID="filesizeLabel" runat="server" meta:resourcekey="filesizeLabelResource2"
                                                            Text='<%# Eval("filesize") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td width="100">
                                                        上傳日期：</td>
                                                    <td>
                                                        <asp:Label ID="upfiledateLabel" runat="server" meta:resourcekey="upfiledateLabelResource2"
                                                            Text='<%# Eval("upfiledate") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td width="100">
                                                        檔案說明：</td>
                                                    <td>
                                                        <asp:Label ID="filetypeLabel" runat="server" meta:resourcekey="filetypeLabelResource2"
                                                            Text='<%# Eval("filedesc") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td width="100">
                                                        <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("serverfilename") %>'
                                                            CommandName="Delete" meta:resourcekey="LinkButton1Resource1" OnClientClick="return confirm('您確定要刪除此資料');">刪除上傳檔案</asp:LinkButton></td>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("serverfilename") %>'
                                                            CommandName="Select" meta:resourcekey="LinkButton2Resource1">確認上傳檔案</asp:LinkButton></td>
                                                </tr>
                                            </table>
                                            <asp:Label ID="fileServerName" runat="server" meta:resourcekey="fileServerNameResource1"
                                                Text='<%# Eval("serverfilename") %>' Visible="False"></asp:Label>
                                        </ItemTemplate>
                                    </asp:DataList>
                                </fieldset>
                                &nbsp;
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="7.員工基本資料">
                <iframe id="Qryframe" runat="server" frameborder="1" height="700" marginheight="0"
                    marginwidth="0" scrolling="auto" width="98%"></iframe>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="8.完成">
                <fieldset>
                    <legend>說明</legend>
                    <asp:Label ID="note7" runat="server"></asp:Label>
                </fieldset>
                <asp:DataList ID="DataList1" runat="server" Visible="False">
                    <ItemTemplate>
                        <table border="1" cellpadding="0" cellspacing="0" class="MsoNormalTable" style="border-right: medium none;
                            border-top: medium none; margin: auto auto auto 0pt; border-left: medium none;
                            width: 531pt; border-bottom: medium none; border-collapse: collapse; mso-border-alt: solid windowtext 2.25pt;
                            mso-padding-alt: 0cm 1.4pt 0cm 1.4pt; mso-border-insideh: 1.0pt solid windowtext;
                            mso-border-insidev: 2.25pt solid windowtext" width="708">
                            <tr style="mso-yfti-irow: 0; mso-yfti-firstrow: yes">
                                <td rowspan="3" style="border-right: windowtext 1pt solid; padding-right: 1.4pt;
                                    border-top: windowtext 1.5pt solid; padding-left: 1.4pt; padding-bottom: 0cm;
                                    border-left: windowtext 1.5pt solid; padding-top: 0cm; border-bottom: windowtext 1pt solid;
                                    background-color: transparent; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt;
                                    mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext;
                                    mso-border-style-alt: solid" valign="middle" width="50">
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("name") %>' Font-Bold="True"></asp:Label>
                                </td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;
                                    height: 18px;" valign="middle" width="156" align="center">
                                    <asp:Label ID="Label5" runat="server" Text="評估種類"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 36pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt;
                                    mso-border-left-alt: solid windowtext .5pt; height: 18px;" valign="middle" align="center">
                                    <asp:Label ID="Label8" runat="server" Text="得分"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 45pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt;
                                    mso-border-left-alt: solid windowtext .5pt; height: 18px;" valign="middle" width="60" align="center">
                                    <asp:Label ID="Label9" runat="server" Text="比重"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;
                                    height: 18px;" valign="middle" width="72" align="center">
                                    <asp:Label ID="Label10" runat="server" Text="加權合計"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 45pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: .25pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;
                                    height: 18px;" valign="middle" width="60" align="center">
                                    <asp:Label ID="Label11" runat="server" Text="總分"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 45pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: .25pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;
                                    height: 18px;" valign="middle" width="60" align="center">
                                    <asp:Label ID="Label12" runat="server" Text="評等" Visible="False"></asp:Label></td>
                            </tr>
                            <tr style="mso-yfti-irow: 1; page-break-inside: avoid">
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="top" width="156">
                                    <asp:Label ID="Label6" runat="server" Text="A.工作目標"></asp:Label>
                                </td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 36pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;
                                    mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .25pt"
                                    valign="middle" align="center">
                                    <asp:Label ID="_num1" runat="server" Font-Bold="True" Text='<%# Eval("apprnum", "{0:0.0}") %>' ForeColor="Blue"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 45pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext .5pt;
                                    mso-border-left-alt: solid windowtext .5pt; mso-border-bottom-alt: solid windowtext .25pt"
                                    valign="middle" width="60" align="center">
                                    <asp:Label ID="Label2" runat="server" Font-Bold="True" Text='<%# Eval("apprrate", "{0:0.0}")+"%" %>' ForeColor="Blue"></asp:Label>
                                </td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: .5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="72" align="center">
                                    <asp:Label ID="_rnum1" runat="server" Font-Bold="True" Text='<%# Eval("apprratenum", "{0:0.0}") %>' ForeColor="Blue"></asp:Label>
                                </td>
                                <td rowspan="2" style="border-right: windowtext 1pt solid; padding-right: 1.4pt;
                                    border-top: #ece9d8; padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8;
                                    width: 45pt; padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .25pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="60" align="center">
                                    <asp:Label ID="_sum" runat="server" Font-Bold="True" Font-Size="Small" ForeColor="Red"
                                        Text='<%# Eval("totnum", "{0:0.0}") %>'></asp:Label></td>
                                <td rowspan="2" style="border-right: windowtext 1pt solid; padding-right: 1.4pt;
                                    border-top: #ece9d8; padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8;
                                    width: 45pt; padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .25pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" align="center">
                                    <asp:Label ID="Label4" runat="server" Font-Size="Small" Text='<%# Eval("effs") %>'
                                        ForeColor="Red" Font-Bold="True" Visible="False"></asp:Label></td>
                            </tr>
                            <tr style="mso-yfti-irow: 2; page-break-inside: avoid; mso-yfti-lastrow: yes">
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="top" width="156">
                                    <asp:Label ID="Label7" runat="server" Text="B.考核項目"></asp:Label>
                                </td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 36pt;
                                    padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" align="center">
                                    <asp:Label ID="_num2" runat="server" Font-Bold="True" Text='<%# Eval("catenum", "{0:0.0}") %>' ForeColor="Blue"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 45pt;
                                    padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="60" align="center">
                                    <asp:Label ID="Label3" runat="server" Font-Bold="True" Text='<%# Eval("caterate", "{0:0.0}")+"%" %>' ForeColor="Blue"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="72" align="center">
                                    <asp:Label ID="_rnum2" runat="server" Font-Bold="True" Text='<%# Eval("cateratenum", "{0:0.0}") %>' ForeColor="Blue"></asp:Label></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                <asp:GridView ID="GridView2" runat="server" OnRowCreated="GridView2_RowCreated" OnDataBound="GridView2_DataBound" ShowFooter="True">
                </asp:GridView>
                <asp:Button ID="FinishButton" runat="server" BackColor="White" BorderColor="#507CD1"
                    BorderStyle="Solid" BorderWidth="1px" CommandName="MoveComplete" Font-Names="Verdana"
                    Font-Size="0.8em" ForeColor="White" OnClientClick="return confirm('確定本期核資料填寫完成，傳送後就不可修改？');"
                    Text="本期考核資料填寫完成，並發MAIL通知給主管" OnClick="FinishButton_Click" />
            </asp:WizardStep>
        </WizardSteps>
        <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="WhiteSmoke" />
        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
            Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
        <StartNavigationTemplate>
            <asp:Button ID="StartNextButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana"
                Font-Size="0.8em" ForeColor="White" Text="儲存資料並執行下一頁" Visible="False" />
        </StartNavigationTemplate>
        <StepNavigationTemplate>
            <asp:Button ID="StepPreviousButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious"
                Font-Names="Verdana" Font-Size="0.8em" ForeColor="White" Text="上一頁" Visible="False" />
            <asp:Button ID="StepNextButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana"
                Font-Size="0.8em" ForeColor="White" Text="儲存資料並執行下一頁" Visible="False" />
        </StepNavigationTemplate>
        <FinishNavigationTemplate>
            <asp:Button ID="FinishPreviousButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious"
                Font-Names="Verdana" Font-Size="0.8em" ForeColor="White" Text="上一頁" Visible="False" />
            <asp:Button ID="FinishButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CommandName="MoveComplete" Font-Names="Verdana"
                Font-Size="0.8em" ForeColor="White" Text="本期考核資料填寫完成，並發MAIL通知給主管" OnClientClick="return confirm('確定本期核資料填寫完成，傳送後就不可修改？');" Visible="False" />
        </FinishNavigationTemplate>
    </asp:Wizard>
    <asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_yy"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_seq" runat="server" Visible="False"></asp:Label><asp:Label
            ID="_temp" runat="server" Visible="False"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" />
</asp:Content>
