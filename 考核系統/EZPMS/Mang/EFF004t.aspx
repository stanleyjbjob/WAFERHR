<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true"
    CodeFile="EFF004t.aspx.cs" Inherits="EFF004t" Title="合晶科技績效考核系統（Web版）v1.0" ValidateRequest="false" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc2" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="../UC/EmpInfo.ascx" TagName="EmpInfo" TagPrefix="uc1" %>
<%@ Register TagPrefix="custom" Namespace="WOW.Web.UI.MyControls" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc2:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <uc1:EmpInfo ID="EmpInfo1" runat="server" />
  
   
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
            <asp:Parameter DefaultValue="True" Name="isIncluded" Type="Boolean" />
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
    &nbsp;
    <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="0" BackColor="#EFF3FB" BorderColor="#B5C7DE"
        BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" Width="100%" OnNextButtonClick="Wizard1_NextButtonClick"
        OnSideBarButtonClick="Wizard1_SideBarButtonClick" OnFinishButtonClick="Wizard1_FinishButtonClick">
        <StepStyle Font-Size="0.8em" ForeColor="#333333" />
        <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" Width="120px" />
        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
        <WizardSteps>
            <asp:WizardStep runat="server" Title="1.行為態度評估">
                <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                    <asp:View ID="View3" runat="server">
                        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="dataViewDs"
                            meta:resourcekey="GridView5Resource1" OnRowDataBound="GridView5_RowDataBound"
                            Width="100%" OnDataBound="GridView5_DataBound" ShowFooter="True">
                            <Columns>
                                <asp:BoundField DataField="effsID" meta:resourcekey="BoundFieldResource17" SortExpression="effsID"
                                    Visible="False" />
                                <asp:BoundField DataField="effcateName" HeaderText="考核項目" SortExpression="effcateName">
                                    <ItemStyle Width="15%" />
                                </asp:BoundField>
                                <asp:BoundField DataField="effsName" HeaderText="考核細目" meta:resourcekey="BoundFieldResource18"
                                    SortExpression="effsName">
                                    <ItemStyle Width="50%" />
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="比重" SortExpression="effsNum">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                    <ItemTemplate>
                                        <asp:Label ID="_rate" runat="server" Text='<%# Bind("rate", "{0:0}") %>' ForeColor="Blue"></asp:Label><asp:Label
                                            ID="Label5" runat="server" ForeColor="Blue" Text="%"></asp:Label>
                                    </ItemTemplate>
                                    <FooterTemplate>
                                        <asp:Label ID="g5_f_rate" runat="server" Font-Bold="True" ForeColor="Blue" Height="16px"
                                            ></asp:Label><asp:Label ID="Label5" runat="server"
                                                Font-Bold="True" ForeColor="Blue" Text="%"></asp:Label>
                                    </FooterTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="自評分數" meta:resourcekey="TemplateFieldResource5">
                                    <ItemTemplate>
                                        <asp:Label ID="num" runat="server"></asp:Label>
                                        <asp:Label ID="lb_effsID" runat="server" Text='<%# Bind("effsID") %>' Visible="False"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang1" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang2" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang3" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang4" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang5" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang6" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang7" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang8" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang9" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang10" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="主管評分">
                                    <ItemTemplate>
                                        <asp:TextBox ID="mangnum" runat="server" Width="40px" Font-Bold="True" ForeColor="Red"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="mangnum"
                                            Display="Dynamic" ErrorMessage="*不能空白">*不能空白</asp:RequiredFieldValidator><asp:CompareValidator
                                                ID="CompareValidator1" runat="server" ControlToValidate="mangnum" Display="Dynamic"
                                                ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*只能輸入數值</asp:CompareValidator>
                                    </ItemTemplate>
                                    <ItemStyle Width="5%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:View>
                </asp:MultiView>

                <asp:SqlDataSource ID="dataViewDs" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT EFFS_CATE.effcateName, EFFS_CATEITEM.effsID, EFFS_CATEITEM.effsName, EFFS_TEMPLETCATEITEM.rate FROM EFFS_TEMPLETCATEITEM INNER JOIN EFFS_CATEITEM ON EFFS_TEMPLETCATEITEM.effsID = EFFS_CATEITEM.effsID INNER JOIN EFFS_CATE ON EFFS_CATEITEM.effcateID = EFFS_CATE.effcateID WHERE (EFFS_TEMPLETCATEITEM.templetID = @TempID) ORDER BY EFFS_TEMPLETCATEITEM.[order]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_temp" DefaultValue="A001" Name="TempID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                &nbsp;&nbsp;
                <fieldset>
                    <legend>說明</legend>
                    <asp:Label ID="note2" runat="server"></asp:Label>
                </fieldset>
                &nbsp;&nbsp;
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="2.績效面談">
                <asp:MultiView ID="MultiView3" runat="server" ActiveViewIndex="0">
                    <asp:View ID="View5" runat="server">
                        <asp:GridView ID="GridViewInterView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
                            DataSourceID="SqlDataSource_INTERVIEW" OnRowDataBound="GridViewInterView_RowDataBound"
                            Width="100%" OnDataBound="GridViewInterView_DataBound">
                            <Columns>
                                <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"
                                    Visible="False" />
                                <asp:BoundField DataField="interview" HeaderText="討論內容" SortExpression="interview">
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="員工意見">
                                    <ItemTemplate>
                                        <asp:Label ID="lb_ID" runat="server" Text='<%# Eval("ID") %>' Visible="False"></asp:Label>
                                        <asp:Label ID="FreeTextBox1" runat="server"></asp:Label>&nbsp;
                                    </ItemTemplate>
                                </asp:TemplateField>
                                       <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang1" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang2" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang3" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang4" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang5" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                    <ItemStyle Width="15%" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang6" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang7" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang8" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang9" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang10" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="主管竟見與回饋">
                                    <EditItemTemplate>
                                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                                    </EditItemTemplate>
                                    <ItemTemplate>
                                        <FTB:FreeTextBox ID="FreeTextBox2" runat="server" BreakMode="LineBreak" Height="100px"
                                            Width="100%" EnableHtmlMode="False" EnableToolbars="False">
                                        </FTB:FreeTextBox>
                                    </ItemTemplate>
                                    <ItemStyle Width="30%" />
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </asp:View>
                </asp:MultiView>
                &nbsp;
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
            <asp:WizardStep runat="server" Title="3.完成">
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
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("name") %>' Font-Bold="True"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="156" align="center">
                                    <asp:Label ID="Label6" runat="server" Text="評估種類 "></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt;
                                    mso-border-left-alt: solid windowtext .5pt" valign="middle" width="72" align="center">
                                    <asp:Label ID="Label9" runat="server" Text="得分 "></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-alt: solid windowtext .5pt; mso-border-top-alt: solid windowtext 1.5pt;
                                    mso-border-left-alt: solid windowtext .5pt" valign="middle" width="72" align="center">
                                    <asp:Label ID="Label10" runat="server" Text="比重"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .5pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="72" align="center">
                                    <asp:Label ID="Label11" runat="server" Text="加權合計"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 45pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: .25pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="60" align="center">
                                    <asp:Label ID="Label12" runat="server" Text="總分"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: windowtext 1.5pt solid;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 45pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: 1.5pt; mso-border-left-alt: .25pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="60" align="center">
                                    <asp:Label ID="Label13" runat="server" Text="評等 "></asp:Label></td>
                            </tr>
                            <tr style="mso-yfti-irow: 1; page-break-inside: avoid">
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: .5pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="top" width="156">
                                    <asp:Label ID="Label7" runat="server" Text="工作績效評估"></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent; mso-border-top-alt: .5pt;
                                    mso-border-left-alt: .5pt; mso-border-bottom-alt: .25pt; mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;"
                                    valign="middle" width="48" align="center">
                                    
                                            <asp:Label ID="_num1" runat="server" Font-Bold="True" ForeColor="Blue" Text='<%# Eval("apprnum", "{0:0.0}") %>'></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent; mso-border-top-alt: .5pt;
                                    mso-border-left-alt: .5pt; mso-border-bottom-alt: .25pt; mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid;"
                                    valign="middle" width="60" align="center">
                                   
                                            <asp:Label ID="Label2" runat="server" Font-Bold="True" ForeColor="Blue" Text='<%# Eval("apprrate", "{0:0.0}")+"%" %>'></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1pt solid; background-color: transparent;
                                    mso-border-top-alt: .5pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: .25pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="72" align="center">
                                   
                                            <asp:Label ID="_rnum1" runat="server" Font-Bold="True" ForeColor="Blue" Text='<%# Eval("apprratenum", "{0:0.0}") %>'></asp:Label></td>
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
                                    valign="middle" width="60" align="center">
                                    <p class="MsoNormal" style="margin: 0cm -34.7pt 0pt 0cm; text-align: justify; mso-para-margin-right: -2.89gd">
   <asp:Label id="Label4" runat="server" Font-Size="Small" ForeColor="Red" Text='<%# Eval("effs") %>' Font-Bold="True"></asp:Label>
                                </td>
                            </tr>
                            <tr style="mso-yfti-irow: 2; page-break-inside: avoid; mso-yfti-lastrow: yes">
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: windowtext 1.5pt solid;
                                    width: 117pt; padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: 1.5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .5pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="top" width="156">
                                    <asp:Label ID="Label8" runat="server" Text="行為態度評估 "></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="48" align="center">
                                    
                                            <asp:Label ID="_num2" runat="server" Font-Bold="True" ForeColor="Blue" Text='<%# Eval("catenum", "{0:0.0}") %>'></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8;
                                    padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="72" align="center">
                                   
                                            <asp:Label ID="Label3" runat="server" Font-Bold="True" ForeColor="Blue" Text='<%# Eval("caterate", "{0:0.0}")+"%" %>'></asp:Label></td>
                                <td style="border-right: windowtext 1pt solid; padding-right: 1.4pt; border-top: #ece9d8;
                                    padding-left: 1.4pt; padding-bottom: 0cm; border-left: #ece9d8; width: 54pt;
                                    padding-top: 0cm; border-bottom: windowtext 1.5pt solid; background-color: transparent;
                                    mso-border-top-alt: .25pt; mso-border-left-alt: .5pt; mso-border-bottom-alt: 1.5pt;
                                    mso-border-right-alt: .25pt; mso-border-color-alt: windowtext; mso-border-style-alt: solid"
                                    valign="middle" width="72" align="center">
                                    
                                            <asp:Label ID="_rnum2" runat="server" Font-Bold="True" ForeColor="Blue" Text='<%# Eval("cateratenum", "{0:0.0}") %>'></asp:Label></td>
                            </tr>
                        </table>
                    </ItemTemplate>
                </asp:DataList>
                &nbsp;
            </asp:WizardStep>
        </WizardSteps>
        <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
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
                Font-Names="Verdana" Font-Size="0.8em" ForeColor="White" Text="上一頁" />&nbsp;<asp:Button
                    ID="StepNextButton" runat="server" BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" CommandName="MoveNext" Font-Names="Verdana" Font-Size="0.8em"
                    ForeColor="White" Text="儲存資料並執行下一頁" />
        </StepNavigationTemplate>
        <FinishNavigationTemplate>
            <asp:Button ID="FinishPreviousButton" runat="server" BackColor="White" BorderColor="#507CD1"
                BorderStyle="Solid" BorderWidth="1px" CausesValidation="False" CommandName="MovePrevious"
                Font-Names="Verdana" Font-Size="0.8em" ForeColor="White" Text="上一頁" />&nbsp;<asp:Button
                    ID="FinishButton" runat="server" BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                    BorderWidth="1px" CommandName="MoveComplete" Font-Names="Verdana" Font-Size="0.8em"
                    ForeColor="White" Text="本期考核資料評核完成，並發MAIL通知給主管" OnClientClick="return confirm('確定本期核資料評核完成，傳送後就不可修改？');" />
        </FinishNavigationTemplate>
 
    </asp:Wizard>
    &nbsp;
    <asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_yy"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_seq" runat="server" Visible="False"></asp:Label><asp:Label
            ID="_temp" runat="server" Visible="False"></asp:Label><asp:Label ID="_mangnobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_mangnobrother" runat="server" Visible="False"></asp:Label><asp:Label ID="_deptm" runat="server" Visible="False"></asp:Label><asp:Label ID="_deptorder" runat="server" Text="0" Visible="False"></asp:Label><asp:Label ID="_Appoint" runat="server" Text="false" Visible="False"></asp:Label>
    <asp:Label ID="_mange" runat="server" Text="False" Visible="False"></asp:Label>
       

</asp:Content>
