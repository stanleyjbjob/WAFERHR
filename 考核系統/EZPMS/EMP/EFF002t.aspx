<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true"
    CodeFile="EFF002t.aspx.cs" Inherits="EFF002t" Title="合晶科技績效考核系統（Web版）v1.0" ValidateRequest="false" %>

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
        BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" Width="100%" ActiveStepIndex="0"
        OnNextButtonClick="Wizard1_NextButtonClick" OnFinishButtonClick="Wizard1_FinishButtonClick"
        OnActiveStepChanged="Wizard1_ActiveStepChanged" OnSideBarButtonClick="Wizard1_SideBarButtonClick">
        <StepStyle Font-Size="0.8em" ForeColor="#333333" />
        <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" Width="120px" />
        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
        <WizardSteps>
            <asp:WizardStep runat="server" Title="1.評核項目">
                <asp:DataList ID="DataList2" runat="server" meta:resourcekey="DataList2Resource1"
                    DataSourceID="SqlDataSource1" OnItemDataBound="DataList2_ItemDataBound" Width="100%">
                    <ItemTemplate>
                        <fieldset>
                            <asp:Label ID="effcateIDLabel" runat="server" Text='<%# Eval("effcateID") %>' Visible="False"
                                meta:resourcekey="effcateIDLabelResource1"></asp:Label>
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
                                    <td width="20%">
                                        <asp:Label ID="effcateNameLabel" runat="server" Text='<%# Eval("effcateName") %>'
                                            meta:resourcekey="effcateNameLabelResource1"></asp:Label></td>
                                    <td colspan="3" width="90%">
                                        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="dataViewDs"
                                            meta:resourcekey="GridView5Resource1" OnRowDataBound="GridView5_RowDataBound"
                                            ShowHeader="False" Width="100%">
                                            <Columns>
                                                <asp:BoundField DataField="effsID" SortExpression="effsID" Visible="False" meta:resourcekey="BoundFieldResource17">
                                                </asp:BoundField>
                                                <asp:BoundField DataField="effsName" HeaderText="考核細目" SortExpression="effsName"
                                                    meta:resourcekey="BoundFieldResource18">
                                                    <ItemStyle Width="60%" />
                                                </asp:BoundField>
                                                <asp:TemplateField HeaderText="比重" SortExpression="effsNum">
                                                    <EditItemTemplate>
                                                        <asp:TextBox ID="TextBox1" runat="server" Font-Bold="true" Text='<%# Bind("rate") %>'></asp:TextBox>
                                                    </EditItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" ForeColor="Blue" />
                                                    <ItemTemplate>
                                                        <asp:Label ID="_rate" runat="server" Font-Bold="true" Text='<%# Bind("rate", "{0:0}") %>'
                                                            ForeColor="Blue"></asp:Label>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="自我評分" meta:resourcekey="TemplateFieldResource5">
                                                    <ItemTemplate>
                                                        &nbsp;<asp:TextBox ID="num" runat="server" Width="34px" ForeColor="Red" Font-Bold="true"></asp:TextBox>
                                                        <asp:Label ID="lb_effsID" runat="server" Text='<%# Bind("effsID") %>' Visible="False"></asp:Label>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="num"
                                                            Display="Dynamic" ErrorMessage="*不能空白">*不能空白</asp:RequiredFieldValidator><asp:CompareValidator
                                                                ID="CompareValidator1" runat="server" ControlToValidate="num" Display="Dynamic"
                                                                ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*只能輸入數值</asp:CompareValidator>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                            </Columns>
                                        </asp:GridView>
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
                    <HeaderTemplate>
                        <table width="100%">
                            <tr>
                                <td align="center" width="20%">
                                    評核項目</td>
                                <td align="center" width="60%">
                                    評核主要重點</td>
                                <td align="center" width="10%">
                                    比重</td>
                                <td align="center" width="10%">
                                    自評分數</td>
                            </tr>
                        </table>
                    </HeaderTemplate>
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
            <asp:WizardStep runat="server" Title="2.工作問題及建意">
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
            <asp:WizardStep runat="server" Title="3.員工基本資料">
                <iframe id="Qryframe" runat="server" frameborder="1" height="700" marginheight="0"
                    marginwidth="0" scrolling="auto" width="98%"></iframe>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="4.完成">
                <fieldset>
                    <legend>說明</legend>
                    <asp:Label ID="note7" runat="server"></asp:Label>
                </fieldset>
                <asp:DataList ID="DataList1" runat="server">
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
                                    <asp:Label ID="Label12" runat="server" Text="評等"></asp:Label></td>
                            </tr>
                            <tr style="mso-yfti-irow: 1; page-break-inside: avoid">
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="top" width="156">
                                    <asp:Label ID="Label6" runat="server" Text="A.工作績效評估"></asp:Label>
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
                                        ForeColor="Red" Font-Bold="True"></asp:Label></td>
                            </tr>
                            <tr style="mso-yfti-irow: 2; page-break-inside: avoid; mso-yfti-lastrow: yes">
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="top" width="156">
                                    <asp:Label ID="Label7" runat="server" Text="B.行為態度評估"></asp:Label>
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
            </asp:WizardStep>
        </WizardSteps>
        <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="WhiteSmoke" />
        <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
            Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
        <StartNavigationTemplate>
            <asp:Button ID="StartNextButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana"
                Font-Size="0.8em" ForeColor="White" Text="儲存資料並執行下一頁" />
        </StartNavigationTemplate>
        <StepNavigationTemplate>
            <asp:Button ID="StepPreviousButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious"
                Font-Names="Verdana" Font-Size="0.8em" ForeColor="White" Text="上一頁" />
            <asp:Button ID="StepNextButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana"
                Font-Size="0.8em" ForeColor="White" Text="儲存資料並執行下一頁" />
        </StepNavigationTemplate>
        <FinishNavigationTemplate>
            <asp:Button ID="FinishPreviousButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious"
                Font-Names="Verdana" Font-Size="0.8em" ForeColor="White" Text="上一頁" />
            <asp:Button ID="FinishButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CommandName="MoveComplete" Font-Names="Verdana"
                Font-Size="0.8em" ForeColor="White" Text="本期考核資料填寫完成，並發MAIL通知給主管" OnClientClick="return confirm('確定本期核資料填寫完成，傳送後就不可修改？');" />
        </FinishNavigationTemplate>
    </asp:Wizard>
    <asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_yy"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_seq" runat="server" Visible="False"></asp:Label><asp:Label
            ID="_temp" runat="server" Visible="False"></asp:Label>
    <asp:ValidationSummary ID="ValidationSummary1" runat="server" ShowMessageBox="True"
        ShowSummary="False" />
</asp:Content>
