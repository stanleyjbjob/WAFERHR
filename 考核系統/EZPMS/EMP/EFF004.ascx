<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EFF004.ascx.cs" Inherits="EMP_EFF004" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register TagPrefix="custom" Namespace="WOW.Web.UI.MyControls" %>


   
 &nbsp;<h5>工作目標設定</h5>
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note1" runat="server"></asp:Label></fieldset>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <table style="width: 100%">
        <tr>
            <td colspan="4" style="height: 17px">
    &nbsp;<asp:Label ID="Label3" runat="server" Font-Bold="True" Font-Size="Small" Text="目標年度：" Visible="False"></asp:Label>
                <asp:Label ID="_yy" runat="server"></asp:Label>
                年,第<asp:Label ID="_seq" runat="server"></asp:Label>
                期<asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged" Visible="False">
      <asp:ListItem Value="2006,1">2006年上半年工作目標</asp:ListItem>
        <asp:ListItem Value="2006,2">2006年下半年工作目標</asp:ListItem>
           <asp:ListItem Value="2007,1">2007年上半年工作目標</asp:ListItem>
        <asp:ListItem Value="2007,2">2007年下半年工作目標</asp:ListItem>
        <asp:ListItem Value="2008,1">2008年上半年工作目標</asp:ListItem>
        <asp:ListItem Value="2008,2">2008年下半年工作目標</asp:ListItem>
        <asp:ListItem Value="2009,1">2009年上半年工作目標</asp:ListItem>
        <asp:ListItem Value="2009,2">2009年下半年工作目標</asp:ListItem>
        <asp:ListItem Value="2010,1">2010年上半年工作目標</asp:ListItem>
        <asp:ListItem Value="2010,2">2010年下半年工作目標</asp:ListItem>
        <asp:ListItem Value="2011,1">2011年上半年工作目標</asp:ListItem>
        <asp:ListItem Value="2011,2">2011年下半年工作目標</asp:ListItem>
    
    </asp:DropDownList><asp:Label ID="Label4" runat="server" Font-Bold="True" ForeColor="Red" Text="*請先選擇目標年度" Visible="False"></asp:Label>
                &nbsp;<br />
            </td>
            <td align="right" style="width: 20%; height: 17px">
                <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Small" Text="年度比重總分：" ForeColor="White" Visible="False"></asp:Label><asp:Label
                    ID="_ratenum" runat="server" Font-Bold="True" ForeColor="Red" Text="0" Visible="False"></asp:Label></td>
        </tr>
    </table>
            <asp:Button ID="Button8" runat="server" Text="工作目標填寫完成！發送Mail給主管確認" OnClick="Button8_Click" OnClientClick="return confirm('確定要發送Mail？');" Visible="False" />
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
    <fieldset>
        <asp:Label ID="Label10" runat="server" Text="員工工號："></asp:Label><asp:TextBox ID="tb_nobr"
            runat="server" Width="100px"></asp:TextBox><asp:Button ID="Button9" runat="server"
                OnClick="Button9_Click" Text="查詢" />
    </fieldset>
            &nbsp;&nbsp;&nbsp;&nbsp;
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
            DataSourceID="ObjectDataSource2" PageSize="5" OnRowDataBound="GridView1_RowDataBound"
            AllowSorting="True" Width="100%" ShowFooter="True" OnRowDeleted="GridView1_RowDeleted" OnRowUpdating="GridView1_RowUpdating">
            <Columns>
                <asp:CommandField ButtonType="Button" ShowEditButton="True" />
                <asp:TemplateField ShowHeader="False" Visible="False">
                    <ItemTemplate>
                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                            Text="選取" />
                    </ItemTemplate>
                    <ItemStyle Width="30px" />
                </asp:TemplateField>
                <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                    SortExpression="autoKey" Visible="False" />
                <asp:TemplateField HeaderText="工號" SortExpression="nobr">
                    <EditItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("nobr") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("nobr") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="年度" SortExpression="yy">
                    <EditItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("yy") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("yy") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="期別" SortExpression="seq">
                    <EditItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("seq") %>'></asp:Label>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("seq") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("seq") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("seq") %>'
                            Enabled="False">
                            <asp:ListItem Value="0"> </asp:ListItem>
                            <asp:ListItem Selected="True" Value="1">上半年度</asp:ListItem>
                            <asp:ListItem Value="2">下半年度</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="standard" HeaderText="standard" SortExpression="standard" />
                <asp:TemplateField HeaderText="工作目標" SortExpression="works">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox6" runat="server" Text='<%# Bind("works") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label7" runat="server" Text='<%# Bind("works") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="衡量準標" SortExpression="standard" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox7" runat="server" Text='<%# Bind("standard") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label8" runat="server" Text='<%# Bind("standard") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="比重" SortExpression="rate">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox8" runat="server" Text='<%# Bind("rate") %>' Width="79px"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label9" runat="server" Text='<%# Bind("rate", "{0:0.0}%") %>'></asp:Label>
                    </ItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="50px" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="執行之質與量的綜合成果" SortExpression="appr">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server" Rows="6" Text='<%# Bind("appr") %>' TextMode="MultiLine"
                            Width="100%"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("appr") %>'></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="bespeak" HeaderText="bespeak" SortExpression="bespeak"
                    Visible="False" />
                <asp:BoundField DataField="reality" HeaderText="reality" SortExpression="reality"
                    Visible="False" />
                <asp:TemplateField HeaderText="主管確認" SortExpression="mangCheck">
                    <ItemTemplate>
                        <asp:CheckBox ID="cb_mangCheck" runat="server" Checked='<%# Bind("mangCheck") %>'
                            Enabled="false" />
                        <asp:Label ID="Label2" runat="server" Text='<%# Bind("mangname") %>' Visible="False"></asp:Label>
                        <asp:Label ID="chdate" runat="server" Text='<%# Bind("mangcheckDate") %>' Visible="False"
                            Width="50px"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="40px" HorizontalAlign="Center" />
                </asp:TemplateField>
               
                <asp:BoundField DataField="key_date" DataFormatString="{0:yyyy/MM/dd}" HeaderText="輸人日期"
                    HtmlEncode="False" SortExpression="key_date" Visible="False" />
                <asp:TemplateField>
                    <ItemTemplate>
                        <asp:Button ID="delBtn" runat="server" CausesValidation="False" CommandName="Delete"
                            OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                        <asp:Label ID="autoKey" runat="server" Text='<%# Eval("autoKey") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                    <ItemStyle Width="20px" />
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByNobrYearSeq"
        TypeName="EFFDSTableAdapters.EFFS_APPRTableAdapter" UpdateMethod="Update" OnSelecting="ObjectDataSource2_Selecting">
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
        <SelectParameters>
            <asp:ControlParameter ControlID="tb_nobr" DefaultValue="" Name="nobr" PropertyName="Text"
                Type="String" />
            <asp:ControlParameter ControlID="_yy" DefaultValue="2007" Name="yy" PropertyName="Text"
                Type="Int32" />
            <asp:ControlParameter ControlID="_seq" DefaultValue="3" Name="seq" PropertyName="Text"
                Type="Int32" />
        </SelectParameters>
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
    </asp:ObjectDataSource>
        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
            DataSourceID="ObjectDataSourcetts">
            <Columns>
                <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                    SortExpression="autoKey" Visible="False" />
                <asp:BoundField DataField="EffS_APPRID" HeaderText="EffS_APPRID" SortExpression="EffS_APPRID"
                    Visible="False" />
                <asp:BoundField DataField="works" HeaderText="工作目標" HtmlEncode="False" SortExpression="works" />
                <asp:BoundField DataField="standard" HeaderText="standard" SortExpression="standard"
                    Visible="False" />
                <asp:BoundField DataField="rate" HeaderText="比重" SortExpression="rate" />
                <asp:BoundField DataField="appr" HeaderText="appr" SortExpression="appr" Visible="False" />
                <asp:BoundField DataField="bespeak" HeaderText="bespeak" SortExpression="bespeak"
                    Visible="False" />
                <asp:BoundField DataField="reality" HeaderText="reality" SortExpression="reality"
                    Visible="False" />
                <asp:BoundField DataField="original" HeaderText="主管" SortExpression="original" />
                <asp:BoundField DataField="keydate" HeaderText="修改時間" SortExpression="keydate" />
                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" Visible="False" />
                <asp:BoundField DataField="adate" HeaderText="adate" SortExpression="adate" Visible="False" />
                <asp:BoundField DataField="ddate" HeaderText="ddate" SortExpression="ddate" Visible="False" />
            </Columns>
        </asp:GridView>
        <asp:ObjectDataSource ID="ObjectDataSourcetts" runat="server" DeleteMethod="Delete"
            InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByIDNOTTYPE"
            TypeName="EFFMANGDSTableAdapters.EFFS_APPRTTSTableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_autoKey" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="EffS_APPRID" Type="Int32" />
                <asp:Parameter Name="works" Type="String" />
                <asp:Parameter Name="standard" Type="String" />
                <asp:Parameter Name="rate" Type="String" />
                <asp:Parameter Name="appr" Type="String" />
                <asp:Parameter Name="bespeak" Type="String" />
                <asp:Parameter Name="reality" Type="String" />
                <asp:Parameter Name="keydate" Type="DateTime" />
                <asp:Parameter Name="original" Type="String" />
                <asp:Parameter Name="type" Type="String" />
                <asp:Parameter Name="adate" Type="DateTime" />
                <asp:Parameter Name="ddate" Type="DateTime" />
                <asp:Parameter Name="Original_autoKey" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" DefaultValue="99999" Name="id" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="EffS_APPRID" Type="Int32" />
                <asp:Parameter Name="works" Type="String" />
                <asp:Parameter Name="standard" Type="String" />
                <asp:Parameter Name="rate" Type="String" />
                <asp:Parameter Name="appr" Type="String" />
                <asp:Parameter Name="bespeak" Type="String" />
                <asp:Parameter Name="reality" Type="String" />
                <asp:Parameter Name="keydate" Type="DateTime" />
                <asp:Parameter Name="original" Type="String" />
                <asp:Parameter Name="type" Type="String" />
                <asp:Parameter Name="adate" Type="DateTime" />
                <asp:Parameter Name="ddate" Type="DateTime" />
            </InsertParameters>
        </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
&nbsp; &nbsp;&nbsp;
    <asp:UpdatePanel ID="UpdatePanel3" runat="server">
        <ContentTemplate>
    <fieldset>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource1"
        OnItemInserting="FormView1_ItemInserting" OnItemUpdating="FormView1_ItemUpdating"
        OnDataBinding="FormView1_DataBinding" OnDataBound="FormView1_DataBound" OnItemInserted="FormView1_ItemInserted"
        OnItemUpdated="FormView1_ItemUpdated" >
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
            <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>' Visible="false"></asp:Label>
            <asp:Label ID="nobrLabel" runat="server" Text='<%# Bind("nobr") %>' Visible="false"></asp:Label>
            <asp:Label ID="bespeakLabel" runat="server" Text='<%# Bind("bespeak") %>' Visible="false"></asp:Label>
            <asp:Label ID="realityLabel" runat="server" Text='<%# Bind("reality") %>' Visible="false"></asp:Label>
            <asp:Label ID="mangcheckDateLabel" runat="server" Text='<%# Bind("mangcheckDate") %>'
                Visible="false"></asp:Label>
            <asp:Label ID="mangnameLabel" runat="server" Text='<%# Bind("mangname") %>' Visible="false"></asp:Label>
            <asp:Label ID="key_dateLabel" runat="server" Text='<%# Bind("key_date") %>' Visible="false"></asp:Label>
            <asp:CheckBox ID="cb_mangCheck" runat="server" Checked='<%# Bind("mangCheck")  %>'
                Visible="false" /><br />
            &nbsp;<strong style="color: #ff0000">比重:</strong><asp:TextBox ID="rateTextBox" runat="server" Text='<%# Bind("rate") %>' Width="50px"></asp:TextBox>%<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rateTextBox"
                Display="Dynamic" ErrorMessage="*不可空白">*不可空白</asp:RequiredFieldValidator>
            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="rateTextBox"
                Display="Dynamic" ErrorMessage="*只能輸入數值" Operator="DataTypeCheck" Type="Integer">*只能輸入數值</asp:CompareValidator><br />
            <asp:Label ID="Label5" runat="server" ForeColor="Blue" Text="工作目標:"></asp:Label>
      
            <FTB:FreeTextBox ID="FreeTextBox1" runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak"
                ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20"
                ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath=""
                ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50"
                DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="Gray"
                EditorBorderColorLight="Gray" EnableHtmlMode="False" EnableSsl="False"
                EnableToolbars="False" Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226"
                GutterBorderColorDark="Gray" GutterBorderColorLight="White"
                Height="150px" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True"
                ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}"
                InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource"
                Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True"
                RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False"
                SslUrl="/." StartMode="DesignMode" StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/"
                TabIndex="-1" TabMode="InsertSpaces" Text='<%# Bind("works") %>' TextDirection="LeftToRight"
                ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True"
                Width="600px">
            </FTB:FreeTextBox>
            <FTB:FreeTextBox ID="FreeTextBox2" runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak"
                ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20"
                ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath=""
                ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50"
                DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="Gray"
                EditorBorderColorLight="Gray" EnableHtmlMode="True" EnableSsl="False" EnableToolbars="True"
                Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="Gray"
                GutterBorderColorLight="White" Height="150px" HelperFilesParameters="" HelperFilesPath=""
                HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/"
                ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage"
                JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False"
                RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet"
                ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode"
                StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/" TabIndex="-1"
                TabMode="InsertSpaces" Text='<%# Bind("appr") %>' TextDirection="LeftToRight"
                ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True"
                Width="600px" Visible="False">
            </FTB:FreeTextBox>
            <table style="width: 100%">
                <tr>
                    <td align="left" style="width: 50%; height: 23px">
                        &nbsp;<asp:Button ID="Button1" runat="server" CausesValidation="True" CommandName="Update"
                            Text="儲存資料" /></td>
                    <td align="right" style="width: 50%; height: 23px">
                        <asp:Button ID="Button3" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="取消" />
                    </td>
                </tr>
            </table>
            <asp:TextBox ID="standardTextBox" runat="server" Text='<%# Bind("standard") %>' Rows="2"
                TextMode="MultiLine" Width="400px" Visible="False"></asp:TextBox>
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
            &nbsp;<strong><span style="color: #ff0000">比重：</span></strong><asp:TextBox ID="rateTextBox" runat="server" Text='<%# Bind("rate") %>' Width="50px"></asp:TextBox>%<asp:RequiredFieldValidator
                ID="RequiredFieldValidator1" runat="server" ControlToValidate="rateTextBox" Display="Dynamic"
                ErrorMessage="*不可空白">*不可空白</asp:RequiredFieldValidator>
            <asp:TextBox ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:TextBox><br />
            <br />
             standard: 
             <asp:TextBox ID="tb_standard" runat="server" Text='<%# Bind("standard") %>' 
             ></asp:TextBox><br>
            

            <asp:Label ID="Label5" runat="server" ForeColor="Blue" Text="工作目標:"></asp:Label>
          
          
           <asp:TextBox ID="TextBox3" runat="server" Rows="6"  Text='<%# Bind("works") %>' TextMode="MultiLine"
                            Width="100%"></asp:TextBox><br>
                       執行之質與量的綜合成果:  <asp:TextBox ID="TextBox122" runat="server" Rows="6" Text='<%# Bind("appr") %>' TextMode="MultiLine"
                            Width="100%"></asp:TextBox><br>

            <hr />
            <table style="width: 100%">
                <tr>
                    <td align="left" style="width: 50%; height: 23px">
                        &nbsp;<asp:Button ID="Button4" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="儲存資料" /></td>
                    <td align="right" style="width: 50%; height: 23px">
                        <asp:Button ID="Button5" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="取消" />
                    </td>
                </tr>
            </table>
            
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
            <asp:Label ID="Label7" runat="server" ForeColor="Blue" Text="主管確認:"></asp:Label>
            <asp:CheckBox ID="mangCheckCheckBox" runat="server" Checked='<%# Bind("mangCheck") %>'
                Enabled="false" /><br />
            <asp:Label ID="Label8" runat="server" ForeColor="Blue" Text="主管姓名及確認時間:"></asp:Label>
            <asp:Label ID="mangnameLabel" runat="server" Text='<%# Bind("mangname") %>'></asp:Label>
            <asp:Label ID="mangcheckDateLabel" runat="server" Text='<%# Bind("mangcheckDate") %>'>
            </asp:Label><br />
            <asp:Label ID="Label9" runat="server" ForeColor="Blue" Text="輸入日期:"></asp:Label><asp:Label ID="key_dateLabel" runat="server" Text='<%# Bind("key_date") %>'></asp:Label><br />
            <br />
            <br />
            &nbsp;<br />
            <br />
            <hr />
            <table style="width: 100%">
                <tr>
                    <td align="left" style="width: 50%; height: 23px">
                        <asp:Button ID="Button6" runat="server" CausesValidation="False" CommandName="Edit"
                            Text="編輯資料" /></td>
                    <td align="right" style="width: 50%; height: 23px">
                        <asp:Button ID="Button7" runat="server" CausesValidation="False" CommandName="New"
                            Text="新增資料" />
                    </td>
                </tr>
            </table>
        </ItemTemplate>
        <EmptyDataTemplate>
            <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                Text="新增資料" />
        </EmptyDataTemplate>
    </asp:FormView>
        &nbsp;</fieldset>
    <asp:ObjectDataSource ID="attendDataSource1" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="yy" Type="Int32" />
            <asp:Parameter Name="seq" Type="Int32" />
            <asp:Parameter Name="Desc" Type="String" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="StdDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="yy" Type="Int32" />
            <asp:Parameter Name="seq" Type="Int32" />
            <asp:Parameter Name="Desc" Type="String" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="StdDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
        TypeName="EFFDSTableAdapters.EFFS_APPRTableAdapter" UpdateMethod="Update">
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
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" DefaultValue="999999" Name="ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
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
    </asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>