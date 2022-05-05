<%@ Control Language="C#" AutoEventWireup="true" CodeFile="EFF002.ascx.cs" Inherits="Mang_EFF002" %>


<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>

<h5>員工工作目標設定</h5>
<fieldset>
    <asp:UpdatePanel ID="UpdatePanel4" runat="server">
        <ContentTemplate>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="1">
        <asp:View ID="View1" runat="server">
    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="nobr" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                        Text="選取" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="NOBR" HeaderText="工號" SortExpression="NOBR" />
            <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
            <asp:BoundField DataField="INDT" DataFormatString="{0:yyyy/MM/dd}" HeaderText="到職日"
                HtmlEncode="False" SortExpression="INDT" />
            <asp:BoundField DataField="TTSCODE" HeaderText="TTSCODE" SortExpression="TTSCODE"
                Visible="False" />
            <asp:BoundField DataField="DEPT" HeaderText="DEPT" SortExpression="DEPT" Visible="False" />
            <asp:BoundField DataField="DEPTS" HeaderText="DEPTS" SortExpression="DEPTS" Visible="False" />
            <asp:CheckBoxField DataField="MANG" HeaderText="MANG" SortExpression="MANG" Visible="False" />
            <asp:CheckBoxField DataField="MANGE" HeaderText="MANGE" SortExpression="MANGE" Visible="False" />
            <asp:BoundField DataField="JOB" HeaderText="JOB" SortExpression="JOB" Visible="False" />
            <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
            <asp:BoundField DataField="DI" HeaderText="直接間" SortExpression="DI" Visible="False" />
            <asp:BoundField DataField="JOBS" HeaderText="JOBS" SortExpression="JOBS" Visible="False" />
            <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" />
            <asp:BoundField DataField="JOBSNAME" HeaderText="職系" SortExpression="JOBSNAME" />
            <asp:BoundField DataField="JOBL" HeaderText="JOBL" SortExpression="JOBL" Visible="False" />
            <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
            <asp:BoundField DataField="DEPTSNAME" HeaderText="成本中心" SortExpression="DEPTSNAME" Visible="False"/>
        </Columns>
    </asp:GridView>
            &nbsp;&nbsp;
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                <ContentTemplate>
            <fieldset id="FIELDSET1" runat="server" visible="false">
                <legend>員工資料</legend>
                <table style="width: 100%" id="TABLE1" runat="server" visible="false">
                    <tr>
                        <td style="width: 25%; height: 18px">
                            <asp:Label ID="Label1" runat="server" Text="姓名："></asp:Label>
                            <asp:Label ID="name_c" runat="server" Text=""></asp:Label></td>
                        <td style="font-size: 12pt; width: 20%; color: #000000; height: 18px">
                            <asp:Label ID="Label5" runat="server" Text="工號："></asp:Label>&nbsp;
                            <asp:Label ID="seq" runat="server" Text="" Visible="False"></asp:Label>
                        </td>
                        <td style="font-size: 12pt; width: 20%; height: 18px">
                            <asp:Label ID="Label4" runat="server" Text="到職日："></asp:Label>
                            <asp:Label ID="indt" runat="server"></asp:Label>
                        </td>
                        <td style="font-size: 12pt; width: 20%; height: 18px">
                         <asp:Label ID="year"
                                runat="server" Text=""></asp:Label></td>
                        <td style="font-size: 12pt; width: 20%; height: 18px">
                            <asp:Label ID="desc" runat="server" Text=""></asp:Label></td>
                    </tr>
                    <tr style="font-size: 12pt">
                        <td style="width: 20%; height: 17px">
                            <asp:Label ID="Label2" runat="server" Text="部門："></asp:Label>
                            <asp:Label ID="dept" runat="server" Text=""></asp:Label></td>
                        <td style="width: 20%; height: 17px">
                            <asp:Label ID="Label6" runat="server" Text="成本中心："></asp:Label>
                            <asp:Label ID="deps" runat="server" Text=""></asp:Label></td>
                        <td style="width: 20%; height: 17px">
                            &nbsp;<asp:Label ID="Label7" runat="server" Text="職稱："></asp:Label>
                            <asp:Label ID="job" runat="server"></asp:Label></td>
                        <td style="width: 20%; height: 17px">
                            <asp:Label ID="Label8" runat="server" Text="職等："></asp:Label>
                            <asp:Label ID="jobl" runat="server" Text=" "></asp:Label>
                            <asp:Label ID="templet" runat="server" Text="" Visible="False"></asp:Label></td>
                        <td style="width: 20%; height: 17px">
                        </td>
                    </tr>
                    <tr style="font-size: 12pt">
                        <td colspan="3" style="height: 17px">
                            <asp:Label ID="Label9" runat="server" Font-Bold="True" Font-Size="Small" Text="目標年度："></asp:Label><asp:DropDownList ID="DropDownList3" runat="server" AutoPostBack="True" OnSelectedIndexChanged="DropDownList3_SelectedIndexChanged">
                                <asp:ListItem Value="2006,1">2006年上半年工作目標</asp:ListItem>
                                <asp:ListItem Value="2006,2">2006年下半年工作目標</asp:ListItem>
                                <asp:ListItem Value="2007,1">2007年上半年工作目標</asp:ListItem>
                                <asp:ListItem Value="2007,2">2007年下半年工作目標</asp:ListItem>
                                <asp:ListItem Value="2008,1">2008年上半年工作目標</asp:ListItem>
                                <asp:ListItem Value="2008,2">2008年下半年工作目標</asp:ListItem>
                             
                            </asp:DropDownList>
                            <asp:Label ID="Label10" runat="server" Font-Bold="True" ForeColor="Red" Text="*請先選擇目標年度"></asp:Label>
                            &nbsp;&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                            &nbsp;&nbsp;
                        </td>
                        <td align="left" colspan="2" style="height: 17px">
                            <asp:Label ID="Label11" runat="server" Font-Bold="True" Font-Size="Small" Text="年度比重總分：" Visible="False"></asp:Label>
                            <asp:Label ID="_ratenum" runat="server" Font-Bold="True" ForeColor="Red" Text="0" Visible="False"></asp:Label></td>
                    </tr>
                    <tr style="font-size: 12pt">
                        <td colspan="5" style="height: 17px">
                            <asp:Button ID="Button8" runat="server" OnClick="Button8_Click" OnClientClick="return confirm('確定要發送Mail？');"
                                Text="工作目標確認完成！發送Mail給員工確認" /></td>
                    </tr>
                </table>
                </fieldset>
                            <asp:Label ID="_yy" runat="server"></asp:Label>年,第<asp:Label ID="_seq" runat="server"></asp:Label>
                    期
                </ContentTemplate>
            </asp:UpdatePanel>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByNobrYearSeq"
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
                    <asp:ControlParameter ControlID="lb_nobr" Name="nobr" PropertyName="Text"
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
                            <asp:Label ID="lb_nobr" runat="server" Visible="false"></asp:Label>
            <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
            <fieldset>
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                    DataKeyNames="autoKey" DataSourceID="ObjectDataSource1" OnRowDataBound="GridView1_RowDataBound"
                    PageSize="5" OnSelectedIndexChanging="GridView1_SelectedIndexChanging" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnDataBound="GridView1_DataBound" OnRowCommand="GridView1_RowCommand" OnSelectedIndexChanged="GridView1_SelectedIndexChanged" ShowFooter="True">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                            SortExpression="autoKey" Visible="False" />
                        <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                        <asp:BoundField DataField="works" HeaderText="工作目標" HtmlEncode="False">
                            <ItemStyle Width="500px" />
                        </asp:BoundField>
                        <asp:BoundField DataField="rate" DataFormatString="{0:0.0}" HeaderText="比重" >
                            <ItemStyle HorizontalAlign="Center" />
                            <FooterStyle HorizontalAlign="Center" />
                        </asp:BoundField>
                        <asp:BoundField DataField="standard" HeaderText="衡重準標" SortExpression="standard"
                            Visible="False" />
                        <asp:BoundField DataField="appr" HeaderText="執行之質與量的綜合成果" SortExpression="appr" Visible="False" HtmlEncode="False" />
                        <asp:BoundField DataField="bespeak" HeaderText="bespeak" SortExpression="bespeak"
                            Visible="False" />
                        <asp:BoundField DataField="reality" HeaderText="reality" SortExpression="reality"
                            Visible="False" />
                        <asp:TemplateField HeaderText="納入考核" SortExpression="included" Visible="False">
                            <ItemTemplate>
                                <asp:CheckBox ID="cb_included" runat="server" Checked='<%# Bind("included") %>' />
                                <asp:Label ID="lb_yy" runat="server" Text='<%# Bind("yy") %>' Visible="false"></asp:Label>
                                <asp:Label ID="lb_seq" runat="server" Text='<%# Bind("seq") %>' Visible="false"></asp:Label>
                                <asp:Label ID="LB_show" runat="server" Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="key_date" DataFormatString="{0:yyyy/MM/dd}" HeaderText="輸人日期"
                            HtmlEncode="False" SortExpression="key_date" Visible="False" />
                        <asp:TemplateField HeaderText="主管確認" SortExpression="mangCheck">
                            <ItemTemplate>
                                <asp:CheckBox ID="cb_mangCheck" runat="server" Checked='<%# Bind("mangCheck") %>' ValidationGroup='<%# Eval("autoKey") %>' AutoPostBack="True" OnCheckedChanged="cb_mangCheck_CheckedChanged" />
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("mangname") %>' Visible="False"></asp:Label>
                                <asp:Label ID="chdate" runat="server" Text='<%# Bind("mangcheckDate") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                            <ItemStyle HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False" Visible="False" >
                            <ItemTemplate>
                                <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("autoKey") %>'
                                    CommandName="Select1" Text="修改"></asp:LinkButton>
                                <asp:Label ID="autoKey" runat="server" Text='<%# Eval("autoKey") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
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
            <table width="100%">
                    <tr>
                        <td style="height: 28px">
                            <asp:Label ID="_autokey" runat="server" Text="99999" Visible="False"></asp:Label></td>
                        <td align="left">
                            <asp:Label ID="Label12" runat="server" Font-Bold="True" Font-Size="Small" Text="年度比重總分：" Visible="False"></asp:Label><asp:Label
                                ID="_ratenum1" runat="server" Font-Bold="True" ForeColor="Red" Text="0" Visible="False"></asp:Label></td>
                        <td align="right" width="30%" style="height: 28px">
                            </td>
                    </tr>
                </table>
                </fieldset>
                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource2"
                        OnItemInserted="FormView1_ItemInserted" OnItemInserting="FormView1_ItemInserting"
                        OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating">
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
                            &nbsp;<strong style="color: #ff0000">比重:</strong><asp:TextBox ID="rateTextBox" runat="server"
                                Text='<%# Bind("rate") %>' Width="50px"></asp:TextBox>%<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="rateTextBox"
                                Display="Dynamic" ErrorMessage="*不可空白">*不可空白</asp:RequiredFieldValidator>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="rateTextBox"
                                Display="Dynamic" ErrorMessage="*只能輸入數值" Operator="DataTypeCheck" Type="Integer">*只能輸入數值</asp:CompareValidator><br />
                            <asp:Label ID="Label5" runat="server" ForeColor="Blue" Text="工作目標:"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FreeTextBox1"
                                Display="Dynamic" ErrorMessage="*不可空白">*不可空白</asp:RequiredFieldValidator>
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
                                TabMode="InsertSpaces" Text='<%# Bind("works") %>' TextDirection="LeftToRight"
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
                                Visible="False" Width="600px">
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
                            <asp:TextBox ID="standardTextBox" runat="server" Rows="2" Text='<%# Bind("standard") %>'
                                TextMode="MultiLine" Visible="False" Width="400px"></asp:TextBox>
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
                            &nbsp;<strong><span style="color: #ff0000">比重：</span></strong><asp:TextBox ID="rateTextBox"
                                runat="server" Text='<%# Bind("rate") %>' Width="50px"></asp:TextBox>%<asp:RequiredFieldValidator
                                    ID="RequiredFieldValidator1" runat="server" ControlToValidate="rateTextBox" Display="Dynamic"
                                    ErrorMessage="*不可空白">*不可空白</asp:RequiredFieldValidator><asp:CompareValidator ID="CompareValidator1"
                                        runat="server" ControlToValidate="rateTextBox" Display="Dynamic" ErrorMessage="*只能輸入數值"
                                        Operator="DataTypeCheck" Type="Integer">*只能輸入數值</asp:CompareValidator>
                            <asp:TextBox ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>' Visible="false">
            </asp:TextBox><br />
                            <br />
                            <asp:Label ID="Label5" runat="server" ForeColor="Blue" Text="工作目標:"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="FreeTextBox1"
                                Display="Dynamic" ErrorMessage="*不可空白">*不可空白</asp:RequiredFieldValidator>
                            <FTB:FreeTextBox ID="FreeTextBox1" runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath=""
                                AutoConfigure="" AutoGenerateToolbarsFromString="True" AutoHideToolbar="True"
                                AutoParseStyles="True" BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak"
                                ButtonDownImage="False" ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20"
                                ButtonImagesLocation="InternalResource" ButtonOverImage="False" ButtonPath=""
                                ButtonSet="Office2003" ButtonWidth="21" ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False"
                                DesignModeBodyTagCssClass="" DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50"
                                DownLevelMessage="" DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="128, 128, 128"
                                EditorBorderColorLight="128, 128, 128" EnableHtmlMode="False" EnableSsl="False"
                                EnableToolbars="False" Focus="False" FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226"
                                GutterBorderColorDark="128, 128, 128" GutterBorderColorLight="255, 255, 255"
                                Height="150px" HelperFilesParameters="" HelperFilesPath="" HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True"
                                ImageGalleryPath="~/images/" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}"
                                InstallationErrorMessage="InlineMessage" JavaScriptLocation="InternalResource"
                                Language="en-US" PasteMode="Default" ReadOnly="False" RemoveScriptNameFromBookmarks="True"
                                RemoveServerNameFromUrls="True" RenderMode="NotSet" ScriptMode="External" ShowTagPath="False"
                                SslUrl="/." StartMode="DesignMode" StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/"
                                TabIndex="-1" TabMode="InsertSpaces" Text='<%# Bind("works") %>' TextDirection="LeftToRight"
                                ToolbarBackColor="Transparent" ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource"
                                ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                                ToolbarStyleConfiguration="NotSet" UpdateToolbar="True" UseToolbarBackGroundImage="True"
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
                                Visible="False" Width="600px">
                            </FTB:FreeTextBox>
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
                            <asp:TextBox ID="standardTextBox" runat="server" Rows="2" Text='<%# Bind("standard") %>'
                                TextMode="MultiLine" Visible="False" Width="400px"></asp:TextBox>
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
                            <asp:Label ID="Label5" runat="server" ForeColor="Blue" Text="工作目標:"></asp:Label><br />
                            <asp:Label ID="worksLabel" runat="server" Text='<%# Bind("works") %>'></asp:Label><br />
                            <asp:Label ID="Label6" runat="server" ForeColor="Blue" Text="比重:"></asp:Label><br />
                            <asp:Label ID="rateLabel" runat="server" Text='<%# Bind("rate") %>'></asp:Label>%<br />
                            <asp:Label ID="Label7" runat="server" ForeColor="Blue" Text="主管確認:"></asp:Label><br />
                            <asp:CheckBox ID="mangCheckCheckBox" runat="server" Checked='<%# Bind("mangCheck") %>'
                                Enabled="false" /><br />
                            <asp:Label ID="Label8" runat="server" ForeColor="Blue" Text="主管姓名及確認時間:"></asp:Label>
                            <asp:Label ID="mangnameLabel" runat="server" Text='<%# Bind("mangname") %>'></asp:Label>
                            <asp:Label ID="mangcheckDateLabel" runat="server" Text='<%# Bind("mangcheckDate") %>'>
            </asp:Label><br />
                            <asp:Label ID="Label9" runat="server" ForeColor="Blue" Text="輸入日期:"></asp:Label><br />
                            <asp:Label ID="key_dateLabel" runat="server" Text='<%# Bind("key_date") %>'></asp:Label><br />
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
                    </asp:FormView>
            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
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
                    <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                        Type="Int32" DefaultValue="99999" />
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
        </asp:View>
    </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
    &nbsp;&nbsp;
    </fieldset>