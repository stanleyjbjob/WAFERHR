<%@ Page Language="C#"  AutoEventWireup="true"
    CodeFile="PrintEffst.aspx.cs" Inherits="PrintEffst" Title="合晶科技績效考核系統（Web版）v1.0" ValidateRequest="false"  StylesheetTheme ="JBRPrint_theme" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc2" %>

<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="../UC/EmpInfo.ascx" TagName="EmpInfo" TagPrefix="uc1" %>
<%@ Register TagPrefix="custom" Namespace="WOW.Web.UI.MyControls" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
</head>
<body>


    <form id="form1" runat="server">

    <table width="760">
        <tr>
            <td>
            
           
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
    <fieldset>
        <legend>考核面談確認</legend>1.<asp:CheckBox ID="CheckBox1" runat="server" ValidationGroup="A" />已和主管面談完成,且同意主管評核。<br>
        2.<asp:CheckBox ID="CheckBox2" runat="server" ValidationGroup="A" />不同意,這主管評核,原因：
        <asp:TextBox ID="TextBox3" runat="server" Width="596px"></asp:TextBox><br />
        <asp:Button ID="Button2" runat="server" Text="確認" OnClick="Button2_Click" /><br />
        <br />
        <fieldset>
            <legend>本次考核總分</legend>考核總分為：<asp:Label ID="lb_num" runat="server"></asp:Label><br />
            考核評等：<asp:Label ID="lb_eff" runat="server"></asp:Label><br />
            備註：<asp:Label ID="lb_note" runat="server"></asp:Label></fieldset>
    </fieldset>
    <fieldset id="AP01" runat="server" visible="false">
        <legend>1.工作目標評估</legend>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
            DataSourceID="ObjectDataSource1" OnDataBound="GridView1_DataBound" OnRowDataBound="GridView1_RowDataBound"
            ShowFooter="True" Width="100%" SkinID="gridviewprint">
            <Columns>
                <asp:BoundField DataField="autoKey" HeaderText="autoKey" ReadOnly="True" SortExpression="autoKey"
                    Visible="False" />
                <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                <asp:BoundField DataField="works" HeaderText="工作目標" HtmlEncode="False" SortExpression="works" />
                <asp:BoundField DataField="standard" HeaderText="衡重準標" SortExpression="standard"
                    Visible="False" HtmlEncode="False" />
                <asp:BoundField DataField="rate" DataFormatString="{0}%" HeaderText="比重" SortExpression="rate">
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Blue" HorizontalAlign="Center" />
                    <ItemStyle Font-Bold="True" ForeColor="Blue" HorizontalAlign="Center" Width="40px" />
                </asp:BoundField>
                <asp:BoundField DataField="appr" HeaderText="衡量標準" HtmlEncode="False" SortExpression="appr" />
                <asp:BoundField DataField="bespeak" HeaderText="執行之質與量的綜合成果" SortExpression="bespeak" HtmlEncode="False" />
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
                <asp:TemplateField HeaderText="員工自評">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:Label ID="num" runat="server" Visible="False"></asp:Label>
                        <asp:Label ID="LB_Apprid" runat="server" Text='<%# Bind("AutoKey") %>' Visible="False"></asp:Label>
                        <asp:DropDownList ID="ddl_num" runat="server" Enabled="False" Visible="False">
                            <asp:ListItem Value=" ">※請選擇※ </asp:ListItem>
                            <asp:ListItem Value="4">超過標準</asp:ListItem>
                            <asp:ListItem Value="3">符合標準</asp:ListItem>
                            <asp:ListItem Value="2">需改進</asp:ListItem>
                            <asp:ListItem Value="1">極需改進</asp:ListItem>
                            <asp:ListItem Value="0">低於標準</asp:ListItem>
                        </asp:DropDownList><asp:Label ID="lb_snum" runat="server" Font-Bold="True"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                    <ItemStyle Width="40px" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang1" runat="server" ForeColor="Black"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang2" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang3" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang4" runat="server"></asp:Label>
                    </ItemTemplate>
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
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang7" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang8" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang9" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField Visible="False">
                    <ItemTemplate>
                        <asp:Label ID="nummang10" runat="server"></asp:Label>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                </asp:TemplateField>
                <asp:TemplateField HeaderText="主管評分" Visible="False">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>
                    </EditItemTemplate>
                    <ItemTemplate>
                        <asp:TextBox ID="mangnum" runat="server" CssClass="Text_int" Font-Bold="True" ForeColor="Red"
                            Width="40px"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="mangnum"
                            Display="Dynamic" ErrorMessage="*不能空白">*不能空白</asp:RequiredFieldValidator>
                        <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="mangnum"
                            Display="Dynamic" ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*只能輸入數值</asp:CompareValidator>
                        <asp:DropDownList ID="ddl_mangnum" runat="server">
                            <asp:ListItem Value=" ">※請選擇※ </asp:ListItem>
                            <asp:ListItem Value="4">超過標準</asp:ListItem>
                            <asp:ListItem Value="3">符合標準</asp:ListItem>
                            <asp:ListItem Value="2">需改進</asp:ListItem>
                            <asp:ListItem Value="1">極需改進</asp:ListItem>
                            <asp:ListItem Value="0">低於標準</asp:ListItem>
                        </asp:DropDownList>
                    </ItemTemplate>
                    <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                    <ItemStyle HorizontalAlign="Center" Width="40px" />
                </asp:TemplateField>
            </Columns>
            <RowStyle Font-Size="Small" />
            <FooterStyle Font-Size="Small" />
            <HeaderStyle Font-Size="Small" />
        </asp:GridView>
                <fieldset id="FIELDSET1" runat="server" visible="false">
                    <legend>說明</legend>
                    <asp:Label ID="note1" runat="server"></asp:Label>
                </fieldset>
    </fieldset>
    <fieldset id="AP02" runat="server">
        <legend>1.行為態度評估</legend>
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
                    <asp:Label ID="effcateIDLabel" runat="server" Text='<%# Eval("effcateID") %>' Visible="False"></asp:Label>
                    <table width="100%" border="1" bordercolor="#000000">
                        <tr>
                            <td width="15%">
                                <asp:Label ID="effcateNameLabel" runat="server" Font-Size="Small" ForeColor="Black"
                                    meta:resourcekey="effcateNameLabelResource1" Text='<%# Eval("effcateName") %>'></asp:Label></td>
                            <td colspan="3" width="90%">
                                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="dataViewDs"
                                    meta:resourcekey="GridView5Resource1" OnDataBound="GridView5_DataBound" OnRowDataBound="GridView5_RowDataBound" SkinID="gridviewprint">
                                    <Columns>
                                        <asp:BoundField DataField="effsID" meta:resourcekey="BoundFieldResource17" SortExpression="effsID"
                                            Visible="False" />
                                        <asp:BoundField DataField="effsName" HeaderText="考核細目" meta:resourcekey="BoundFieldResource18"
                                            SortExpression="effsName">
                                            <ItemStyle Width="400px" />
                                        </asp:BoundField>
                                        <asp:TemplateField HeaderText="比重" SortExpression="effsNum" Visible="False">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="g5_f_rate" runat="server" Font-Bold="True" ForeColor="Blue" Height="16px"></asp:Label><asp:Label
                                                    ID="Label5" runat="server" Font-Bold="True" ForeColor="Blue" Text="%"></asp:Label>
                                            </FooterTemplate>
                                            <ItemTemplate>
                                                <asp:Label ID="_rate" runat="server" ForeColor="Blue" Text='<%# Bind("rate","{0:00.00}") %>'></asp:Label><asp:Label
                                                    ID="Label5" runat="server" ForeColor="Blue" Text="%"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="自評分數" meta:resourcekey="TemplateFieldResource5">
                                            <ItemTemplate>
                                                <asp:Label ID="num" runat="server"></asp:Label>
                                                <asp:DropDownList ID="ddl_num" runat="server" Visible="False">
                                                    <asp:ListItem Value=" ">※請選擇※ </asp:ListItem>
                                                    <asp:ListItem Value="4">超過標準</asp:ListItem>
                                                    <asp:ListItem Value="3">符合標準</asp:ListItem>
                                                    <asp:ListItem Value="2">需改進</asp:ListItem>
                                                    <asp:ListItem Value="1">極需改進</asp:ListItem>
                                                    <asp:ListItem Value="0">低於標準</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:Label ID="lb_effsID" runat="server" Text='<%# Bind("effsID") %>' Visible="False"></asp:Label>
                                                <asp:Label ID="lb_snum" runat="server" Font-Bold="True"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang1" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang2" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang3" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang4" runat="server"></asp:Label>
                                            </ItemTemplate>
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
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang7" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang8" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang9" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="nummang10" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="主管評分" Visible="False">
                                            <ItemTemplate>
                                                <asp:TextBox ID="mangnum" runat="server" Font-Bold="True" ForeColor="Red" Visible="false"
                                                    Width="40px"></asp:TextBox>
                                                <asp:DropDownList ID="ddl_mangnum" runat="server">
                                                    <asp:ListItem Value=" ">※請選擇※ </asp:ListItem>
                                                    <asp:ListItem Value="4">超過標準</asp:ListItem>
                                                    <asp:ListItem Value="3">符合標準</asp:ListItem>
                                                    <asp:ListItem Value="2">需改進</asp:ListItem>
                                                    <asp:ListItem Value="1">極需改進</asp:ListItem>
                                                    <asp:ListItem Value="0">低於標準</asp:ListItem>
                                                </asp:DropDownList>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="mangnum"
                                                    Display="Dynamic" ErrorMessage="*不能空白">*不能空白</asp:RequiredFieldValidator><asp:CompareValidator
                                                        ID="CompareValidator1" runat="server" ControlToValidate="mangnum" Display="Dynamic"
                                                        ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*只能輸入數值</asp:CompareValidator>
                                            </ItemTemplate>
                                            <FooterStyle Font-Bold="True" Font-Size="X-Small" ForeColor="Red" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <RowStyle Font-Size="Small" />
                                    <HeaderStyle Font-Size="Small" />
                                </asp:GridView>
                                <table width="100%">
                                    <tr>
                                        <td width="20%">
                                            對低於標準之項目請舉實例說明</td>
                                        <td width="30%">
                                            &nbsp;<asp:Label ID="o1" runat="server"></asp:Label></td>
                                        <td width="20%">
                                            對超過標準之項目請舉例說明</td>
                                        <td width="30%">
                                            <asp:Label ID="o2" runat="server"></asp:Label></td>
                                    </tr>
                                    <tr>
                                        <td>
                                            需改進方向</td>
                                        <td colspan="3">
                                            <asp:Label ID="o3" runat="server"></asp:Label></td>
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

                <asp:SqlDataSource ID="dataViewDs" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT EFFS_CATE.effcateName, EFFS_CATEITEM.effsID, EFFS_CATEITEM.effsName, EFFS_TEMPLETCATEITEM.rate FROM EFFS_TEMPLETCATEITEM INNER JOIN EFFS_CATEITEM ON EFFS_TEMPLETCATEITEM.effsID = EFFS_CATEITEM.effsID INNER JOIN EFFS_CATE ON EFFS_CATEITEM.effcateID = EFFS_CATE.effcateID WHERE (EFFS_TEMPLETCATEITEM.templetID = @TempID) ORDER BY EFFS_TEMPLETCATEITEM.[order]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_temp" DefaultValue="A001" Name="TempID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT EFFS_CATE.effcateID, EFFS_CATE.effcateName FROM EFFS_TEMPLETCATE INNER JOIN EFFS_CATE ON EFFS_TEMPLETCATE.effcateID = EFFS_CATE.effcateID WHERE (EFFS_TEMPLETCATE.templetID = @TempID) ORDER BY EFFS_TEMPLETCATE.[order]">
            <SelectParameters>
                <asp:ControlParameter ControlID="_temp" DefaultValue="A001" Name="TempID" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
                <fieldset id="FIELDSET2" runat="server" visible="false">
                    <legend>說明</legend>
                    <asp:Label ID="note2" runat="server"></asp:Label>
                </fieldset>
    </fieldset>
    <fieldset id="AP03" runat="server">
        <legend>2.績效面談</legend>
                        <asp:GridView ID="GridViewInterView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
                            DataSourceID="SqlDataSource_INTERVIEW" OnRowDataBound="GridViewInterView_RowDataBound"
                            Width="100%" OnDataBound="GridViewInterView_DataBound" SkinID="gridviewprint">
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
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang2" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang3" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang4" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang5" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                    <ItemStyle Width="15%" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang6" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang7" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang8" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang9" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
                                </asp:TemplateField>
                                <asp:TemplateField Visible="False">
                                    <ItemTemplate>
                                        <asp:Label ID="nummang10" runat="server"></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle Width="15%" />
                                    <FooterStyle Font-Bold="True" Font-Size="Small" ForeColor="Red" />
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
                            <RowStyle Font-Size="Small" />
                            <HeaderStyle Font-Size="Small" />
                        </asp:GridView>
                <asp:SqlDataSource ID="SqlDataSource_INTERVIEW" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                    SelectCommand="SELECT         EFFS_INTERVIEW.ID, EFFS_INTERVIEW.interview&#13;&#10;FROM             EFFS_TEMPLETINTERVIEW INNER JOIN&#13;&#10;                          EFFS_INTERVIEW ON &#13;&#10;                          EFFS_TEMPLETINTERVIEW.interviewID = EFFS_INTERVIEW.ID&#13;&#10;WHERE         (EFFS_TEMPLETINTERVIEW.templetID = @templetID)&#13;&#10;ORDER BY  EFFS_TEMPLETINTERVIEW.[order]">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_temp" Name="templetID" PropertyName="Text" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <fieldset id="FIELDSET3" runat="server" visible="false">
                    <legend>說明</legend>
                    <asp:Label ID="note3" runat="server"></asp:Label>
                </fieldset>
    </fieldset>
               <FIELDSET id="AP04" runat="server" visible="false"><LEGEND>4.訓練需求</LEGEND><asp:ObjectDataSource id="SelfEduObjectDataSource" runat="server" UpdateMethod="Update" TypeName="EFFDSTableAdapters.EFFS_SELFEDUTableAdapter" SelectMethod="GetDataByEduCateItemID" OldValuesParameterFormatString="original_{0}" InsertMethod="Insert" DeleteMethod="Delete">
                    <InsertParameters>
                        <asp:Parameter Name="yy" Type="Int32"  />
                        <asp:Parameter Name="seq" Type="Int32"  />
                        <asp:Parameter Name="nobr" Type="String"  />
                        <asp:Parameter Name="eduCateID" Type="String"  />
                        <asp:Parameter Name="eduCateItemID" Type="String"  />
                        <asp:Parameter Name="other" Type="String"  />
                        <asp:Parameter Name="keydate" Type="DateTime"  />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_yy" Name="yy" PropertyName="Text" Type="Int32"  />
                        <asp:ControlParameter ControlID="_seq" Name="seq" PropertyName="Text" Type="Int32"  />
                        <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" Type="String"  />
                        <asp:Parameter DefaultValue="xxx" Name="itemID" Type="String"  />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Original_AutoKey" Type="Int32"  />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="yy" Type="Int32"  />
                        <asp:Parameter Name="seq" Type="Int32"  />
                        <asp:Parameter Name="nobr" Type="String"  />
                        <asp:Parameter Name="eduCateID" Type="String"  />
                        <asp:Parameter Name="eduCateItemID" Type="String"  />
                        <asp:Parameter Name="other" Type="String"  />
                        <asp:Parameter Name="keydate" Type="DateTime"  />
                        <asp:Parameter Name="Original_AutoKey" Type="Int32"  />
                    </UpdateParameters>
                </asp:ObjectDataSource> <asp:ObjectDataSource id="CateObjectDataSource" runat="server" UpdateMethod="Update" TypeName="EFFDSTableAdapters.EFFS_EDUCATETableAdapter" SelectMethod="GetData" OldValuesParameterFormatString="original_{0}" InsertMethod="Insert" DeleteMethod="Delete">
                    <InsertParameters>
                        <asp:Parameter Name="eduCateID" Type="String"  />
                        <asp:Parameter Name="cateName" Type="String"  />
                        <asp:Parameter Name="Order" Type="Int32"  />
                    </InsertParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Original_eduCateID" Type="String"  />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="eduCateID" Type="String"  />
                        <asp:Parameter Name="cateName" Type="String"  />
                        <asp:Parameter Name="Order" Type="Int32"  />
                        <asp:Parameter Name="Original_eduCateID" Type="String"  />
                    </UpdateParameters>
                </asp:ObjectDataSource> <asp:GridView id="GridView2" runat="server" DataSourceID="SelectEduObjectDataSource" DataKeyNames="AutoKey" AutoGenerateColumns="False">
                    <Columns>
                        <asp:BoundField DataField="AutoKey" HeaderText="AutoKey" ReadOnly="True" SortExpression="AutoKey"
                            Visible="False" ></asp:BoundField>
                        <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" ></asp:BoundField>
                        <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" ></asp:BoundField>
                        <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" ></asp:BoundField>
                        <asp:BoundField DataField="eduCateID" HeaderText="eduCateID" SortExpression="eduCateID"
                            Visible="False" ></asp:BoundField>
                        <asp:BoundField DataField="eduCateItemID" HeaderText="eduCateItemID" SortExpression="eduCateItemID"
                            Visible="False" ></asp:BoundField>
                        <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                            Visible="False" ></asp:BoundField>
                        <asp:BoundField DataField="cateName" HeaderText="訓練類別" SortExpression="cateName" ></asp:BoundField>
                        <asp:BoundField DataField="CateItemName" HeaderText="訓練項目" SortExpression="CateItemName" ></asp:BoundField>
                        <asp:BoundField DataField="other" HeaderText="說明" SortExpression="other" HtmlEncode="False" ></asp:BoundField>
                        <asp:TemplateField Visible="False">
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除"  />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <FooterStyle Font-Size="Small"  />
                    <RowStyle Font-Size="Small"  />
                    <HeaderStyle Font-Size="Small"  />
                </asp:GridView> <asp:ObjectDataSource id="SelectEduObjectDataSource" runat="server" UpdateMethod="Update" TypeName="EFFDSTableAdapters.EFFS_SELFEDUTableAdapter" SelectMethod="GetDataBySeleView" OldValuesParameterFormatString="original_{0}" InsertMethod="Insert" DeleteMethod="Delete">
                    <InsertParameters>
                        <asp:Parameter Name="AutoKey" Type="Int32"  />
                        <asp:Parameter Name="yy" Type="Int32"  />
                        <asp:Parameter Name="seq" Type="Int32"  />
                        <asp:Parameter Name="nobr" Type="String"  />
                        <asp:Parameter Name="eduCateID" Type="String"  />
                        <asp:Parameter Name="eduCateItemID" Type="String"  />
                        <asp:Parameter Name="other" Type="String"  />
                        <asp:Parameter Name="keydate" Type="DateTime"  />
                    </InsertParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="_yy" Name="yy" PropertyName="Text" Type="Int32"  />
                        <asp:ControlParameter ControlID="_seq" Name="seq" PropertyName="Text" Type="Int32"  />
                        <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" Type="String"  />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="Original_AutoKey" Type="Int32"  />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="AutoKey" Type="Int32"  />
                        <asp:Parameter Name="yy" Type="Int32"  />
                        <asp:Parameter Name="seq" Type="Int32"  />
                        <asp:Parameter Name="nobr" Type="String"  />
                        <asp:Parameter Name="eduCateID" Type="String"  />
                        <asp:Parameter Name="eduCateItemID" Type="String"  />
                        <asp:Parameter Name="other" Type="String"  />
                        <asp:Parameter Name="keydate" Type="DateTime"  />
                        <asp:Parameter Name="Original_AutoKey" Type="Int32"  />
                    </UpdateParameters>
                </asp:ObjectDataSource><FIELDSET id="FIELDSET10" runat="server" visible="false"><LEGEND>其他評核主管意見：</LEGEND><asp:GridView id="GridView31" runat="server" DataSourceID="ObjectDataSource21" DataKeyNames="AuotKey" AutoGenerateColumns="False" SkinID="gridviewprint">
                        <Columns>
                            <asp:BoundField DataField="AuotKey" HeaderText="AuotKey" InsertVisible="False" ReadOnly="True"
                                SortExpression="AuotKey" Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="mangname" HeaderText="主管姓名" SortExpression="mangname" ></asp:BoundField>
                            <asp:BoundField DataField="mangdept" HeaderText="mangdept" SortExpression="mangdept"
                                Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="mangjob" HeaderText="mangjob" SortExpression="mangjob"
                                Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="note2" HeaderText="主管意見" SortExpression="note2" HtmlEncode="False">
                                <ItemStyle Width="500px"  />
                            </asp:BoundField>
                            <asp:BoundField DataField="note2" HeaderText="note2" SortExpression="note2" Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="note3" HeaderText="note3" SortExpression="note3" Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="note4" HeaderText="note4" SortExpression="note4" Visible="False" ></asp:BoundField>
                            <asp:BoundField DataField="note5" HeaderText="note5" SortExpression="note5" Visible="False" ></asp:BoundField>
                        </Columns>
                        <FooterStyle Font-Size="Small"  />
                        <RowStyle Font-Size="Small"  />
                        <HeaderStyle Font-Size="Small"  />
                    </asp:GridView> <asp:ObjectDataSource id="ObjectDataSource21" runat="server" UpdateMethod="Update" TypeName="EFFMANGDSTableAdapters.EFFS_MANGLEARNPLANTableAdapter" SelectMethod="GetDataBynote2" OldValuesParameterFormatString="original_{0}" InsertMethod="Insert" DeleteMethod="Delete">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_yy" DefaultValue="2007" Name="yy" PropertyName="Text"
                                Type="Int32"  />
                            <asp:ControlParameter ControlID="_seq" DefaultValue="3" Name="seq" PropertyName="Text"
                                Type="Int32"  />
                            <asp:ControlParameter ControlID="_nobr" DefaultValue="&quot;&quot;" Name="nobr" PropertyName="Text"
                                Type="String"  />
                            <asp:ControlParameter ControlID="_deptorder" DefaultValue="0" Name="cateorder" PropertyName="Text"
                                Type="Int32"  />
                            <asp:ControlParameter ControlID="_mangnobr" DefaultValue="&quot;&quot;" Name="mangnobr"
                                PropertyName="Text" Type="String"  />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="yy" Type="Int32"  />
                            <asp:Parameter Name="seq" Type="Int32"  />
                            <asp:Parameter Name="nobr" Type="String"  />
                            <asp:Parameter Name="mangnobr" Type="String"  />
                            <asp:Parameter Name="mangdept" Type="String"  />
                            <asp:Parameter Name="mangjob" Type="String"  />
                            <asp:Parameter Name="note1" Type="String"  />
                            <asp:Parameter Name="note2" Type="String"  />
                            <asp:Parameter Name="note3" Type="String"  />
                            <asp:Parameter Name="note4" Type="String"  />
                            <asp:Parameter Name="note5" Type="String"  />
                        </InsertParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="Original_AuotKey" Type="Int32"  />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="yy" Type="Int32"  />
                            <asp:Parameter Name="seq" Type="Int32"  />
                            <asp:Parameter Name="nobr" Type="String"  />
                            <asp:Parameter Name="mangnobr" Type="String"  />
                            <asp:Parameter Name="mangdept" Type="String"  />
                            <asp:Parameter Name="mangjob" Type="String"  />
                            <asp:Parameter Name="note1" Type="String"  />
                            <asp:Parameter Name="note2" Type="String"  />
                            <asp:Parameter Name="note3" Type="String"  />
                            <asp:Parameter Name="note4" Type="String"  />
                            <asp:Parameter Name="note5" Type="String"  />
                            <asp:Parameter Name="Original_AuotKey" Type="Int32"  />
                        </UpdateParameters>
                    </asp:ObjectDataSource> </FIELDSET> <FIELDSET id="FIELDSET11" runat="server" visible="false"><LEGEND>主管意見</LEGEND><FTB:FreeTextBox id="PlanText1" language="en-US" tabIndex=-1 runat="server" Width="600px" UseToolbarBackGroundImage="True" UpdateToolbar="True" ToolbarStyleConfiguration="Office2003" ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print" ToolbarImagesLocation="InternalResource" ToolbarBackgroundImage="True" ToolbarBackColor="Transparent" TextDirection="LeftToRight" Text="" TabMode="InsertSpaces" SupportFolder="/aspnet_client/FreeTextBox/" StripAllScripting="False" StartMode="DesignMode" SslUrl="/." ShowTagPath="False" ScriptMode="External" RenderMode="NotSet" RemoveServerNameFromUrls="True" RemoveScriptNameFromBookmarks="True" ReadOnly="False" PasteMode="Default" JavaScriptLocation="InternalResource" InstallationErrorMessage="InlineMessage" ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" ImageGalleryPath="~/images/" HtmlModeDefaultsToMonoSpaceFont="True" HtmlModeCss="" HelperFilesPath="" HelperFilesParameters="" Height="100px" GutterBorderColorLight="White" GutterBorderColorDark="Gray" GutterBackColor="129, 169, 226" FormatHtmlTagsToXhtml="True" Focus="False" EnableToolbars="False" EnableSsl="False" EnableHtmlMode="False" EditorBorderColorLight="Gray" EditorBorderColorDark="Gray" DownLevelRows="10" DownLevelMode="TextArea" DownLevelMessage="" DownLevelCols="50" DisableIEBackButton="False" DesignModeCss="" DesignModeBodyTagCssClass="" ConvertHtmlSymbolsToHtmlCodes="False" ClientSideTextChanged="" ButtonWidth="21" ButtonSet="Office2003" ButtonPath="" ButtonOverImage="False" ButtonImagesLocation="InternalResource" ButtonHeight="20" ButtonFolder="Images" ButtonFileExtention="gif" ButtonDownImage="False" BreakMode="LineBreak" BaseUrl="" BackColor="158, 190, 245" AutoParseStyles="True" AutoHideToolbar="True" AutoGenerateToolbarsFromString="True" AutoConfigure="" AssemblyResourceHandlerPath="" AllowHtmlMode="False">
                    </FTB:FreeTextBox> </FIELDSET> <FIELDSET id="FIELDSET4" runat="server" Visible="false"><LEGEND>說明</LEGEND><asp:Label id="note4" runat="server"></asp:Label> 
</FIELDSET> </FIELDSET>
    <fieldset id="AP05" runat="server">
        <legend id="LEGEND1" runat="server">5.主管總評</legend>
                <fieldset id="FIELDSET5" runat="server" visible="false">
                    <legend>說明</legend>
                    <asp:Label ID="note5" runat="server"></asp:Label>
                </fieldset>
                <span style="font-size: 12pt; color: #000000; font-family: 新細明體; mso-ascii-font-family: 'Times New Roman';
                    mso-hansi-font-family: 'Times New Roman'; mso-bidi-font-family: 'Times New Roman';
                    mso-font-kerning: 1.0pt; mso-ansi-language: EN-US; mso-fareast-language: ZH-TW;
                    mso-bidi-language: AR-SA">
                    <asp:GridView ID="leanplanGridView" runat="server" AutoGenerateColumns="False" DataSourceID="leanplanSqlDataSource1"
                        OnRowDataBound="leanplanGridView_RowDataBound" Width="100%" SkinID="gridviewprint">
                        <Columns>
                            <asp:BoundField DataField="note" SortExpression="note">
                                <ItemStyle Width="330px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID"
                                Visible="False" />
                            <asp:BoundField DataField="learnplanID" HeaderText="learnplanID" SortExpression="learnplanID"
                                Visible="False" />
                            <asp:TemplateField HeaderText="員工意見">
                                <ItemTemplate>
                                    &nbsp;<asp:Label ID="PlanText" runat="server"></asp:Label>
                                    <asp:Label ID="planID" runat="server" Text='<%# Eval("learnplanID") %>' Visible="False"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <FooterStyle Font-Size="Small" />
                        <RowStyle Font-Size="Small" />
                        <HeaderStyle Font-Size="Small" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="leanplanSqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                        SelectCommand="SELECT EFFS_LEARNPLAN.note, EFFS_TEMPLETLEARNPLAN.templetID, EFFS_TEMPLETLEARNPLAN.learnplanID FROM EFFS_TEMPLETLEARNPLAN INNER JOIN EFFS_LEARNPLAN ON EFFS_TEMPLETLEARNPLAN.learnplanID = EFFS_LEARNPLAN.ID WHERE (EFFS_TEMPLETLEARNPLAN.templetID = @templetID) ORDER BY EFFS_TEMPLETLEARNPLAN.[order]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_temp" DefaultValue="&quot;&quot;" Name="templetID"
                                PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                      </span>
                     <fieldset id="FIELDSET12" runat="server" visible="false">
                    <legend>主管總評：</legend>
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="AuotKey"
                        DataSourceID="ObjectDataSource2" SkinID="gridviewprint">
                        <Columns>
                            <asp:BoundField DataField="AuotKey" HeaderText="AuotKey" InsertVisible="False" ReadOnly="True"
                                SortExpression="AuotKey" Visible="False" />
                            <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" />
                            <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" />
                            <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                            <asp:BoundField DataField="mangname" HeaderText="主管姓名" SortExpression="mangname" />
                            <asp:BoundField DataField="mangdept" HeaderText="mangdept" SortExpression="mangdept"
                                Visible="False" />
                            <asp:BoundField DataField="mangjob" HeaderText="mangjob" SortExpression="mangjob"
                                Visible="False" />
                            <asp:BoundField DataField="note1" HeaderText="主管意見" SortExpression="note1" HtmlEncode="False">
                                <ItemStyle Width="500px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="note2" HeaderText="note2" SortExpression="note2" Visible="False" />
                            <asp:BoundField DataField="note3" HeaderText="note3" SortExpression="note3" Visible="False" />
                            <asp:BoundField DataField="note4" HeaderText="note4" SortExpression="note4" Visible="False" />
                            <asp:BoundField DataField="note5" HeaderText="note5" SortExpression="note5" Visible="False" />
                        </Columns>
                        <FooterStyle Font-Size="Small" />
                        <RowStyle Font-Size="Small" />
                        <HeaderStyle Font-Size="Small" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" OldValuesParameterFormatString="original_{0}"
                        SelectMethod="GetDataByNote1" TypeName="EFFMANGDSTableAdapters.EFFS_MANGLEARNPLANTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_yy" DefaultValue="2007" Name="yy" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="_seq" DefaultValue="3" Name="seq" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="_nobr" DefaultValue="&quot;&quot;" Name="nobr" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="_deptorder" DefaultValue="0" Name="cateorder" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="_mangnobr" DefaultValue="&quot;&quot;" Name="mangnobr"
                                PropertyName="Text" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="mangnobr" Type="String" />
                            <asp:Parameter Name="mangdept" Type="String" />
                            <asp:Parameter Name="mangjob" Type="String" />
                            <asp:Parameter Name="note1" Type="String" />
                            <asp:Parameter Name="note2" Type="String" />
                            <asp:Parameter Name="note3" Type="String" />
                            <asp:Parameter Name="note4" Type="String" />
                            <asp:Parameter Name="note5" Type="String" />
                        </InsertParameters>
                        <DeleteParameters>
                            <asp:Parameter Name="Original_AuotKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="mangnobr" Type="String" />
                            <asp:Parameter Name="mangdept" Type="String" />
                            <asp:Parameter Name="mangjob" Type="String" />
                            <asp:Parameter Name="note1" Type="String" />
                            <asp:Parameter Name="note2" Type="String" />
                            <asp:Parameter Name="note3" Type="String" />
                            <asp:Parameter Name="note4" Type="String" />
                            <asp:Parameter Name="note5" Type="String" />
                            <asp:Parameter Name="Original_AuotKey" Type="Int32" />
                        </UpdateParameters>
                    </asp:ObjectDataSource>
                    </fieldset>
                    
                    
              
                <fieldset><legend>主管意見</legend>
                <FTB:FreeTextBox ID="PlanText"
                        runat="server" AllowHtmlMode="False" AssemblyResourceHandlerPath="" AutoConfigure=""
                        AutoGenerateToolbarsFromString="True" AutoHideToolbar="True" AutoParseStyles="True"
                        BackColor="158, 190, 245" BaseUrl="" BreakMode="LineBreak" ButtonDownImage="False"
                        ButtonFileExtention="gif" ButtonFolder="Images" ButtonHeight="20" ButtonImagesLocation="InternalResource"
                        ButtonOverImage="False" ButtonPath="" ButtonSet="Office2003" ButtonWidth="21"
                        ClientSideTextChanged="" ConvertHtmlSymbolsToHtmlCodes="False" DesignModeBodyTagCssClass=""
                        DesignModeCss="" DisableIEBackButton="False" DownLevelCols="50" DownLevelMessage=""
                        DownLevelMode="TextArea" DownLevelRows="10" EditorBorderColorDark="Gray" EditorBorderColorLight="Gray"
                        EnableHtmlMode="False" EnableSsl="False" EnableToolbars="False" Focus="False"
                        FormatHtmlTagsToXhtml="True" GutterBackColor="129, 169, 226" GutterBorderColorDark="Gray"
                        GutterBorderColorLight="White" Height="100px" HelperFilesParameters="" HelperFilesPath=""
                        HtmlModeCss="" HtmlModeDefaultsToMonoSpaceFont="True" ImageGalleryPath="~/images/"
                        ImageGalleryUrl="ftb.imagegallery.aspx?rif={0}&cif={0}" InstallationErrorMessage="InlineMessage"
                        JavaScriptLocation="InternalResource" Language="en-US" PasteMode="Default" ReadOnly="False"
                        RemoveScriptNameFromBookmarks="True" RemoveServerNameFromUrls="True" RenderMode="NotSet"
                        ScriptMode="External" ShowTagPath="False" SslUrl="/." StartMode="DesignMode"
                        StripAllScripting="False" SupportFolder="/aspnet_client/FreeTextBox/" TabIndex="-1"
                        TabMode="InsertSpaces" Text="" TextDirection="LeftToRight" ToolbarBackColor="Transparent"
                        ToolbarBackgroundImage="True" ToolbarImagesLocation="InternalResource" ToolbarLayout="ParagraphMenu,FontFacesMenu,FontSizesMenu,FontForeColorsMenu|Bold,Italic,Underline,Strikethrough;Superscript,Subscript,RemoveFormat|JustifyLeft,JustifyRight,JustifyCenter,JustifyFull;BulletedList,NumberedList,Indent,Outdent;CreateLink,Unlink,InsertImage,InsertRule|Cut,Copy,Paste;Undo,Redo,Print"
                        ToolbarStyleConfiguration="Office2003" UpdateToolbar="True" UseToolbarBackGroundImage="True"
                        Width="600px">
                    </FTB:FreeTextBox>
                    </fieldset>
    </fieldset>
    <fieldset id="AP06" runat="server" visible="false">
        <legend>6.上傳參考資料</legend>
                <fieldset>
                    <table width="100%">
                        <tr valign="top">
                            <td colspan="2">
                                <fieldset>
                                    &nbsp;※上傳有關績效考核附加資料！！<asp:FormView ID="FormView5" runat="server" DataKeyNames="autoKey"
                                        DataSourceID="SqlDataSource_UPFILE" DefaultMode="Insert" meta:resourceKey="FormView5Resource1"
                                        OnItemInserting="FormView5_ItemInserting" OnPageIndexChanging="FormView5_PageIndexChanging"
                                        Width="100%" Visible="False">
                                        <InsertItemTemplate>
                                            上傳檔案路徑：<br />
                                            &nbsp;
                                            <asp:FileUpload ID="FileUpload1" runat="server" meta:resourcekey="FileUpload1Resource1" /><br />
                                            檔案說明：<br />
                                            &nbsp;<asp:TextBox ID="filedesc" runat="server" meta:resourcekey="filedescResource1"></asp:TextBox><br />
                                            <asp:Button ID="Button1" runat="server" CommandName="Insert" meta:resourcekey="Button1Resource3"
                                                Text="上傳檔案" />
                                            <br />
                                            <table style="width: 100%">
                                                <tr>
                                                    <td>
                                                        ※</td>
                                                    <td style="width: 90%">
                                                        １.績效考核如有相關資料需呈閱,請上傳<br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td width="5%">
                                                    </td>
                                                    <td style="width: 90%; color: red">
                                                        2.上傳檔案一次限傳檔案大小為1MB/個</td>
                                                </tr>
                                            </table>
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
                                        meta:resourceKey="DataList1Resource1" OnSelectedIndexChanged="UPFILEDATELIST_SelectedIndexChanged"
                                        RepeatColumns="3">
                                        <ItemTemplate>
                                            <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse; width: 300px">
                                                <tr>
                                                    <td align="center" rowspan="5" style="width: 10%">
                                                        <asp:Image ID="Image1" runat="server" ImageUrl="~/images/btn_action-log_bg.gif" meta:resourcekey="Image1Resource1" />
                                                        <br />
                                                    </td>
                                                    <td style="width: 35%; color: #000000">
                                                        檔案名稱：</td>
                                                    <td>
                                                        <asp:Label ID="upfilenameLabel" runat="server" meta:resourcekey="upfilenameLabelResource2"
                                                            Text='<%# Eval("upfilename") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 35%">
                                                        檔案大小：</td>
                                                    <td>
                                                        <asp:Label ID="filesizeLabel" runat="server" meta:resourcekey="filesizeLabelResource2"
                                                            Text='<%# Eval("filesize") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 35%">
                                                        上傳日期：</td>
                                                    <td>
                                                        <asp:Label ID="upfiledateLabel" runat="server" meta:resourcekey="upfiledateLabelResource2"
                                                            Text='<%# Eval("upfiledate") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 35%">
                                                        檔案說明：</td>
                                                    <td>
                                                        <asp:Label ID="filetypeLabel" runat="server" meta:resourcekey="filetypeLabelResource2"
                                                            Text='<%# Eval("filedesc") %>'></asp:Label></td>
                                                </tr>
                                                <tr>
                                                    <td style="width: 35%">
                                                    </td>
                                                    <td>
                                                        <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("serverfilename") %>'
                                                            CommandName="Select" meta:resourcekey="LinkButton2Resource1">瀏覽上傳檔案</asp:LinkButton></td>
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
    </fieldset>
    <fieldset id="AP08" runat="server" visible="false">
        <legend>8.完成</legend>
                <fieldset id="FIELDSET7" runat="server" visible="false">
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
        <asp:DataList ID="DataList3" runat="server" OnItemDataBound="DataList3_ItemDataBound">
            <ItemTemplate>
                <table border="1" cellpadding="0" cellspacing="0" class="MsoNormalTable" style="border-right: medium none;
                    border-top: medium none; margin: auto auto auto 0pt; border-left: medium none;
                    width: 531pt; border-bottom: medium none; border-collapse: collapse; mso-border-alt: solid windowtext 2.25pt;
                    mso-padding-alt: 0cm 1.4pt 0cm 1.4pt; mso-border-insideh: 1.0pt solid windowtext;
                    mso-border-insidev: 2.25pt solid windowtext">
                    <tr style="mso-yfti-irow: 0; mso-yfti-firstrow: yes">
                        <td rowspan="3" style="border-right: windowtext 1pt solid; padding-right: 1.4pt;
                            border-top: windowtext 1.5pt solid; padding-left: 1.4pt; padding-bottom: 0cm;
                            border-left: windowtext 1.5pt solid; padding-top: 0cm; border-bottom: windowtext 1pt solid;
                            background-color: transparent; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt;
                            mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext;
                            mso-border-style-alt: solid" valign="middle" width="50">
                            <asp:Label ID="lb_name" runat="server" Font-Bold="True" Text='<%# Eval("mangname") %>'></asp:Label>
                            <asp:Label ID="lb_nobr" runat="server" Font-Bold="True" Text='<%# Eval("mangnobr") %>'></asp:Label></td>
                        <td align="left" colspan="6" rowspan="3" style="border-right: windowtext 1pt solid;
                            padding-right: 1.4pt; border-top: windowtext 1.5pt solid; padding-left: 1.4pt;
                            padding-bottom: 0cm; border-left: windowtext 1.5pt solid; padding-top: 0cm; border-bottom: windowtext 1pt solid;
                            background-color: transparent; mso-border-top-alt: 1.5pt; mso-border-left-alt: 1.5pt;
                            mso-border-bottom-alt: .5pt; mso-border-right-alt: .5pt; mso-border-color-alt: windowtext;
                            mso-border-style-alt: solid" valign="middle">
                            <asp:GridView ID="GridView2" runat="server" OnDataBound="GridView2_DataBound" OnRowCreated="GridView2_RowCreated"
                                ShowFooter="True" Width="100%">
                                <RowStyle Font-Size="Small" />
                                <FooterStyle Font-Size="Small" />
                                <HeaderStyle Font-Size="Small" />
                            </asp:GridView>
                        </td>
                    </tr>
                    <tr style="mso-yfti-irow: 1; page-break-inside: avoid">
                    </tr>
                    <tr style="mso-yfti-irow: 2; page-break-inside: avoid; mso-yfti-lastrow: yes">
                    </tr>
                </table>
            </ItemTemplate>
        </asp:DataList></fieldset>
    <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="7" BackColor="#EFF3FB" BorderColor="#B5C7DE"
        BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" Width="100%" OnNextButtonClick="Wizard1_NextButtonClick"
        OnSideBarButtonClick="Wizard1_SideBarButtonClick" Visible="False">
        <StepStyle Font-Size="0.8em" ForeColor="#333333" />
        <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" Width="120px" />
        <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
        <WizardSteps>
            <asp:WizardStep runat="server" Title="1.工作目標評估">
                &nbsp;
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="2.行為態度評估">
                <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                    <asp:View ID="View3" runat="server">
                        &nbsp;</asp:View>
                </asp:MultiView>
                &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="3.績效面談">
                <asp:MultiView ID="MultiView3" runat="server" ActiveViewIndex="0">
                    <asp:View ID="View5" runat="server">
                        &nbsp;</asp:View>
                </asp:MultiView>
                &nbsp; &nbsp;&nbsp;
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="4.訓練需求">
                &nbsp;</asp:WizardStep>
            <asp:WizardStep runat="server" Title="5.發展計劃">
                &nbsp;</asp:WizardStep>
            <asp:WizardStep runat="server" Title="6.上傳參考資料">
                &nbsp;</asp:WizardStep>
            <asp:WizardStep runat="server" Title="7.員工基本資料參考">
                &nbsp;<div id="Layer1" style="border-right: #000000 0px; border-top: #000000 0px;
                    z-index: 1; border-left: #000000 0px; border-bottom: #000000 0px; position: relative;
                    height: 700px; background-color: #0099ff; layer-background-color: #0099FF">
                    <iframe id="Qryframe" runat="server" frameborder="1" height="700" marginheight="0"
                        marginwidth="0" scrolling="auto" width="100%"></iframe>
                </div>
            </asp:WizardStep>
            <asp:WizardStep runat="server" Title="8.完成">
                &nbsp; &nbsp;
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
                    ForeColor="White" Text="本年度考核資料填寫完成，並發MAIL通知給主管" />
        </FinishNavigationTemplate>
 
    </asp:Wizard>
    &nbsp;
    <asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_yy"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_seq" runat="server" Visible="False"></asp:Label><asp:Label
            ID="_temp" runat="server" Visible="False"></asp:Label><asp:Label ID="_mangnobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_mangnobrother" runat="server" Visible="False"></asp:Label><asp:Label ID="_deptm" runat="server" Visible="False"></asp:Label><asp:Label ID="_deptorder" runat="server" Text="0" Visible="False"></asp:Label><asp:Label ID="_Appoint" runat="server" Text="false" Visible="False"></asp:Label>
    <asp:Label ID="_mange" runat="server" Text="False" Visible="False"></asp:Label>
     </td>
        </tr>
    </table>   

    </form>
 

</body>
</html>
