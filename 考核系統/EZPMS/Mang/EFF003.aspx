<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true"
    CodeFile="EFF003.aspx.cs" Inherits="Mang_EFF003" Title="合晶科技績效考核系統（Web版）v1.0" ValidateRequest="false" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <asp:Menu ID="Menu1" runat="server" OnMenuItemClick="Menu1_MenuItemClick" Orientation="Horizontal">
        <Items>
            <asp:MenuItem Selected="True" Text="考核年度" Value="0"></asp:MenuItem>
            <asp:MenuItem Text="受評核者名單" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
    <uc1:loading ID="Loading1" runat="server" />
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<h5>員工年度績效考核</h5>
    
            <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
                <asp:View ID="View1" runat="server">
                    
                        <table width="100%">
                            <tr>
                                <td style="height: 49px" colspan="3">
                                    <asp:RadioButtonList ID="AttendRadioButtonList" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged1"
                                                RepeatDirection="Horizontal">
                                        <asp:ListItem Selected="True">本期資料</asp:ListItem>
                                        <asp:ListItem Value="歷史資料">歷次資料</asp:ListItem>
                                    </asp:RadioButtonList></td>
                            </tr>
                        </table>
                            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                                DataSourceID="AttendDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                                Text="選取" />
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="yy" HeaderText="考核年度" SortExpression="yy" />
                                    <asp:BoundField DataField="seq" HeaderText="考核次數" SortExpression="seq" />
                                    <asp:BoundField DataField="Desc" HeaderText="說明" SortExpression="Desc" />
                                    <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                                        Visible="False" />
                                    <asp:BoundField DataField="StdDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="開始日期"
                                        HtmlEncode="False" SortExpression="StdDate" />
                                    <asp:BoundField DataField="EndDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="結束日期"
                                        SortExpression="EndDate" />
                                    <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                                        SortExpression="autoKey" Visible="False" />
                                </Columns>
                            </asp:GridView>
                            <asp:ObjectDataSource ID="AttendDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter"></asp:ObjectDataSource>
                            <asp:Label ID="lb_yy" runat="server" Visible="False"></asp:Label><asp:Label ID="lb_seq"
                                runat="server" Visible="False"></asp:Label>
                            <asp:ObjectDataSource ID="AttendAllDataSource" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByALLDATAForYear"
                                TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter">
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                                </DeleteParameters>
                            </asp:ObjectDataSource>
         
              
                </asp:View>
                <asp:View ID="View2" runat="server">
                    &nbsp; &nbsp; &nbsp;&nbsp;
                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            &nbsp;<fieldset>
                                <legend>
                                    <asp:Label ID="Label4" runat="server" ForeColor="Blue" Text="直線人員名單"></asp:Label></legend>
                                <table width="100%" style="font-size: 12pt; color: #000000">
                                    <tr>
                                        <td colspan="1" rowspan="3" valign="top" style="width: 150px">
                                            <fieldset>
                                            <asp:TreeView ID="TreeView1" runat="server" ExpandDepth="3" OnSelectedNodeChanged="TreeView1_SelectedNodeChanged">
                                            </asp:TreeView>
                                                <asp:Label ID="lb_select_dept" runat="server" Visible="False"></asp:Label></fieldset>
                                            &nbsp; &nbsp;
                                        </td>
                                        <td colspan="3" rowspan="3" valign="top">
                                <asp:GridView ID="GridView7" runat="server"  AutoGenerateColumns="False"
                                    DataKeyNames="yy,seq,nobr,templetID" OnRowDataBound="GridView7_RowDataBound"
                                    ShowFooter="True" OnDataBound="GridView7_DataBound" Visible="False">
                                    <Columns>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/mang/EFF004.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                                                    Target="_blank">績效考核表</asp:HyperLink><br />
                                                      <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/MANG/PrintEffst.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                                                    Target="_blank">查看及列印</asp:HyperLink>
                                                <asp:LinkButton ID="LinkButton1" runat="server" CommandName="appoint" Visible="False">評核者設定</asp:LinkButton>
                                                <asp:Label ID="lb_tmplet" runat="server" Text='<%# Bind("templetID") %>' Visible="False"></asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="jobl" />
                                        <asp:BoundField DataField="effbaseID" HeaderText="effbaseID" ReadOnly="True" SortExpression="effbaseID"
                                            Visible="False" />
                                        <asp:BoundField DataField="templetName" HeaderText="樣板" SortExpression="templetName"
                                            Visible="False" />
                                        <asp:TemplateField HeaderText="templetID" SortExpression="templetID" Visible="False">
                                            <EditItemTemplate>
                                                <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("templetID") %>'></asp:TextBox>
                                            </EditItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="nobr" HeaderText="工號" SortExpression="nobr" />
                                        <asp:BoundField DataField="dept" HeaderText="dept" SortExpression="dept" Visible="False" />
                                        <asp:BoundField DataField="depts" HeaderText="depts" SortExpression="depts" Visible="False" />
                                        <asp:BoundField DataField="JOB" HeaderText="JOB" SortExpression="JOB" Visible="False" />
                                        <asp:BoundField DataField="stddate" HeaderText="stddate" SortExpression="stddate"
                                            Visible="False" />
                                        <asp:BoundField DataField="enddate" HeaderText="enddate" SortExpression="enddate"
                                            Visible="False" />
                                        <asp:BoundField DataField="firstdate" HeaderText="firstdate" SortExpression="firstdate"
                                            Visible="False" />
                                        <asp:BoundField DataField="deptorder" HeaderText="deptorder" SortExpression="deptorder"
                                            Visible="False" />
                                        <asp:BoundField DataField="jobplan" HeaderText="jobplan" SortExpression="jobplan"
                                            Visible="False" />
                                        <asp:CheckBoxField DataField="mangfinish" HeaderText="mangfinish" SortExpression="mangfinish"
                                            Visible="False" />
                                        <asp:CheckBoxField DataField="isdeff" HeaderText="isdeff" SortExpression="isdeff"
                                            Visible="False" />
                                        <asp:BoundField DataField="effsfinally" HeaderText="effsfinally" SortExpression="effsfinally"
                                            Visible="False" />
                                        <asp:BoundField DataField="effsgroupID" HeaderText="effsgroupID" SortExpression="effsgroupID"
                                            Visible="False" />
                                        <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                                        <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" Visible="False" />
                                        <asp:BoundField DataField="DEPTSNAME" HeaderText="成本中心" SortExpression="DEPTSNAME" />
                                        <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
                                        <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" Visible="False" />
                                        <asp:BoundField DataField="effsgroupname" HeaderText="群組" SortExpression="effsgroupname"
                                            Visible="False" />
                                        <asp:TemplateField HeaderText="自評目標">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_a1" runat="server" Text='<%# Eval("effs_a1") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_a1_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="自評考核">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_b1" runat="server" Text='<%# Eval("effs_b1") %>' ></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_b1_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="自評分數">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_c1" runat="server" Text='<%# Eval("effs_c1") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_c1_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="自評評等" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_d1" runat="server" Text='<%# Eval("effs_d1") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_d1_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="目標">
                                            <ItemTemplate>
                                                <asp:Label ID="_nobr" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label>
                                                <asp:Label ID="effs_a" runat="server" Text='<%# Eval("effs_a") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_a_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="考核">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_b" runat="server" Text='<%# Eval("effs_b") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_b_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="合計">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_c" runat="server" Text='<%# Eval("effs_c") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_c_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="評等" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_d" runat="server" Text='<%# Eval("effs_d") %>'></asp:Label>
                                            </ItemTemplate>
                                            <FooterTemplate>
                                                <asp:Label ID="effs_d_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="調整後分數">
                                            <ItemTemplate>
                                                <asp:TextBox ID="effs_f" runat="server" Width="40px" AutoPostBack="True" CssClass="Text_int"
                                                    OnTextChanged="effs_f_TextChanged" Text='<%# Eval("effs_f") %>' ValidationGroup='<%# Eval("nobr") %>'></asp:TextBox>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                <asp:Label ID="effs_f_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            <FooterStyle HorizontalAlign="Center" />

                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="調整後評等" Visible="False">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_g" runat="server" Text='<%# Eval("effs_g") %>'></asp:Label>
                                            </ItemTemplate>
                                             <FooterTemplate>
                                                <asp:Label ID="effs_g_f" runat="server"></asp:Label>
                                            </FooterTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="50px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="排名">
                                            <ItemTemplate>
                                                <asp:Label ID="effs_e" runat="server" Text='<%# Eval("effs_e") %>'></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" Width="30px" />
                                            <FooterStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>

                                        <asp:BoundField DataField="templetID" HeaderText="templetID" Visible="False" />
                                    </Columns>
                                </asp:GridView>
                                            <asp:DataList ID="DataList2" runat="server" OnItemDataBound="DataList2_ItemDataBound">
                                                <ItemTemplate>
                                                    <fieldset>
                                                        <legend>
                                                            <asp:Label ID="name" runat="server" Text='<%# Eval("name") %>'></asp:Label></legend>
                                                        <asp:Label ID="groupid" runat="server" Text='<%# Eval("id") %>' Visible="False"></asp:Label>
                                                        <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView3_RowDataBound1">
                                                            <Columns>
                                                                <asp:TemplateField ShowHeader="False">
                                                                    <ItemTemplate>
                                                                        <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/MANG/EFF004.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                                                                            Target="_blank">績效考核表</asp:HyperLink><br />
                                                                        <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/MANG/PrintEffst.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                                                                            Target="_blank">查看績效考核表/列印</asp:HyperLink>
                                                                        <asp:LinkButton ID="LinkButton1" runat="server" CommandName="appoint" Visible="False">評核者設定</asp:LinkButton>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="nobr" HeaderText="工號" SortExpression="nobr" />
                                                                <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                                                                <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
                                                                <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
                                                                <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" Visible="False" />
                                                                <asp:BoundField DataField="effsgroupname" HeaderText="群組" SortExpression="effsgroupname"
                                                                    Visible="False" />
                                                                <asp:TemplateField HeaderText="評分">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="templetID" runat="server" Text='<%# Eval("templetID") %>' Visible="false"></asp:Label>
                                                                        <asp:Label ID="effsgroupname" runat="server" Text='<%# Eval("effsgroupID") %>' Visible="false"></asp:Label>
                                                                        <asp:GridView ID="gv_mang" runat="server" AutoGenerateColumns="False">
                                                                            <Columns>
                                                                                <asp:TemplateField>
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="cate" runat="server" Text='<%# Eval("cate") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="self" runat="server" Text='<%# Eval("self") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang1" runat="server" Text='<%# Eval("mang1") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang2" runat="server" Text='<%# Eval("mang2") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang3" runat="server" Text='<%# Eval("mang3") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang4" runat="server" Text='<%# Eval("mang4") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang5" runat="server" Text='<%# Eval("mang5") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang6" runat="server" Text='<%# Eval("mang6") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang7" runat="server" Text='<%# Eval("mang7") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="False">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang8" runat="server" Text='<%# Eval("mang8") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="false">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang9" runat="server" Text='<%# Eval("mang9") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                                <asp:TemplateField Visible="false">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="nummang10" runat="server" Text='<%# Eval("mang10") %>'></asp:Label>
                                                                                    </ItemTemplate>
                                                                                </asp:TemplateField>
                                                                            </Columns>
                                                                        </asp:GridView>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="評分調整" Visible="False">
                                                                    <ItemTemplate>
                                                                        <asp:TextBox ID="m_num" runat="server" AutoPostBack="True" CssClass="Text_int" Font-Bold="True"
                                                                            ForeColor="Red" OnTextChanged="m_num_TextChanged" ValidationGroup='<%# Eval("nobr") %>'
                                                                            Width="59px">0</asp:TextBox>
                                                                    </ItemTemplate>
                                                                </asp:TemplateField>
                                                                <asp:BoundField DataField="f_mang_ef" HeaderText="排名" Visible="False" />
                                                            </Columns>
                                                        </asp:GridView>
                                                    </fieldset>
                                                </ItemTemplate>
                                            </asp:DataList></td>
                                    </tr>
                                    <tr>
                                    </tr>
                                    <tr>
                                    </tr>
                                    <tr>
                                        <td colspan="1" rowspan="1" style="width: 150px" valign="top">
                                        </td>
                                        <td colspan="3" valign="top">
                                            <asp:CheckBox ID="CheckBox1" runat="server" AutoPostBack="True" OnCheckedChanged="CheckBox1_CheckedChanged"
                                                Text="檢視評核傳送時間" /><asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView8_RowDataBound" Visible="False">
                                    <Columns>
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:Label ID="_nobr" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label><asp:DataList ID="DataList1" runat="server" OnItemDataBound="DataList1_ItemDataBound"
                                                    RepeatDirection="Horizontal">
                                                    <ItemTemplate>
                                                        <table id="TABLE1" runat="server" cellpadding="0" cellspacing="0">
                                                            <tr>
                                                                <td align="left" valign="top" height="60">
                                                                    <table id="TABLE2" runat="server" border="1" bordercolor="#eeeeee" style="border-collapse: collapse"
                                                                        visible="false">
                                                                        <tr height="25">
                                                                            <td align="center" style="width: 100px; color: #000000">
                                                                                <asp:Label ID="Label23" runat="server" Text="姓名"></asp:Label></td>
                                                                        </tr>
                                                                        <tr bgcolor="lemonchiffon" height="25">
                                                                            <td align="center" style="width: 100px">
                                                                                <asp:Label ID="Label21" runat="server" Font-Bold="True" ForeColor="Blue" Text="傳送時間"></asp:Label></td>
                                                                        </tr>
                                                                        <tr bgcolor="lemonchiffon" height="25">
                                                                            <td align="center" style="width: 100px">
                                                                                <asp:Label ID="Label22" runat="server" Font-Bold="True" ForeColor="Blue" Text="類別"></asp:Label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                                <td valign="top"  height="60">
                                                                    <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse">
                                                                        <tr height="25">
                                                                            <td align="center" style="width: 100px; color: #000000">
                                                                                <asp:Label ID="YYMMLabel" runat="server" Height="16px" Text='<%# DataBinder.Eval(Container.DataItem,"name") %>'></asp:Label>&nbsp;
                                                                            </td>
                                                                        </tr>
                                                                        <tr bgcolor="lemonchiffon" height="25">
                                                                            <td align="center" style="width: 100px">
                                                                                &nbsp;<asp:Label ID="EFFVARLabel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"adate") %>'></asp:Label></td>
                                                                        </tr>
                                                                        <tr bgcolor="lemonchiffon" height="25">
                                                                            <td align="center" style="width: 100px">
                                                                                <asp:Label ID="EFFLVLLabel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"type") %>'></asp:Label></td>
                                                                        </tr>
                                                                    </table>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </ItemTemplate>
                                                </asp:DataList>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                            <asp:Label ID="Label3" runat="server" Text="排序："></asp:Label><asp:RadioButtonList ID="RadioButtonList1" runat="server" AutoPostBack="True" OnSelectedIndexChanged="RadioButtonList1_SelectedIndexChanged"
                                                RepeatDirection="Horizontal" Width="154px">
                                                <asp:ListItem Selected="True">職等</asp:ListItem>
                                                <asp:ListItem>排名</asp:ListItem>
                                            </asp:RadioButtonList><asp:Label ID="to_effs_f" runat="server" Text="0" Visible="False"></asp:Label></td>
                                    </tr>
                                </table>
                                &nbsp;&nbsp;
                                <fieldset id="mangNote" runat="server" visible="false">
                                    <asp:Label ID="Label6" runat="server" Text="總結意見：" ForeColor="Blue"></asp:Label>
                                    <FTB:FreeTextBox ID="PlanText1" 
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
                        Width="600px" OnTextChanged="PlanText1_TextChanged"></FTB:FreeTextBox>

                                    <asp:Button ID="Button4" runat="server" Text="本期部門評核資料完成，發Mail通知管理部" OnClick="Button4_Click" OnClientClick="return confirm('確定完成本期考核！！傳送後就不可修改資料！！');" />
                                </fieldset>
                               </fieldset>
                               
                            <fieldset>
                                <legend>
                                    <asp:Label ID="Label5" runat="server" ForeColor="Blue" Text="非直線人員名單"></asp:Label></legend>
                                <asp:GridView ID="GridView5" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                    DataKeyNames="yy,seq,nobr,templetID" OnSelectedIndexChanged="GridView3_SelectedIndexChanged"
                                    OnRowCommand="GridView3_RowCommand" OnRowDataBound="GridView5_RowDataBound">
                                    <Columns>
                                        <asp:TemplateField ShowHeader="False">
                                            <ItemTemplate>
                                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/MANG/EFF004.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID")+"&Appoint=True" %>'
                                                    Target="_blank">績效考核表</asp:HyperLink>
                                                    <br />
                                                      <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/MANG/PrintEffs.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID")+"&Appoint=True" %>'
                                                    Target="_blank" Visible="False">列印</asp:HyperLink>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        <asp:BoundField DataField="effbaseID" HeaderText="effbaseID" ReadOnly="True" SortExpression="effbaseID"
                                            Visible="False" />
                                        <asp:BoundField DataField="templetName" HeaderText="樣板" SortExpression="templetName"
                                            Visible="False" />
                                        <asp:BoundField DataField="yy" HeaderText="年度" SortExpression="yy" Visible="False" />
                                        <asp:BoundField DataField="seq" HeaderText="頻率" SortExpression="seq" Visible="False" />
                                        <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID"
                                            Visible="False" />
                                        <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" />
                                        <asp:BoundField DataField="nobr" HeaderText="工號" SortExpression="nobr" />
                                        <asp:BoundField DataField="dept" HeaderText="dept" SortExpression="dept" Visible="False" />
                                        <asp:BoundField DataField="depts" HeaderText="depts" SortExpression="depts" Visible="False" />
                                        <asp:BoundField DataField="JOB" HeaderText="JOB" SortExpression="JOB" Visible="False" />
                                        <asp:BoundField DataField="jobl" HeaderText="jobl" SortExpression="jobl" Visible="False" />
                                        <asp:BoundField DataField="stddate" HeaderText="stddate" SortExpression="stddate"
                                            Visible="False" />
                                        <asp:BoundField DataField="enddate" HeaderText="enddate" SortExpression="enddate"
                                            Visible="False" />
                                        <asp:BoundField DataField="firstdate" HeaderText="firstdate" SortExpression="firstdate"
                                            Visible="False" />
                                        <asp:BoundField DataField="deptorder" HeaderText="deptorder" SortExpression="deptorder"
                                            Visible="False" />
                                        <asp:BoundField DataField="jobplan" HeaderText="jobplan" SortExpression="jobplan"
                                            Visible="False" />
                                        <asp:CheckBoxField DataField="mangfinish" HeaderText="mangfinish" SortExpression="mangfinish"
                                            Visible="False" />
                                        <asp:CheckBoxField DataField="isdeff" HeaderText="isdeff" SortExpression="isdeff"
                                            Visible="False" />
                                        <asp:BoundField DataField="effsfinally" HeaderText="effsfinally" SortExpression="effsfinally"
                                            Visible="False" />
                                        <asp:BoundField DataField="effsgroupID" HeaderText="effsgroupID" SortExpression="effsgroupID"
                                            Visible="False" />
                                        <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                                        <asp:BoundField DataField="DEPTSNAME" HeaderText="成本中心" SortExpression="DEPTSNAME"
                                            Visible="False" />
                                        <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
                                        <asp:BoundField DataField="effsgroupname" HeaderText="群組" SortExpression="effsgroupname"
                                            Visible="False" />
                                        <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
                                        <asp:BoundField DataField="templetID" HeaderText="templetID" Visible="False" />
                                        <asp:BoundField DataField="mangname" HeaderText="指派主管" />
                                        <asp:BoundField DataField="mangdname" HeaderText="部門" Visible="False" />
                                        <asp:BoundField DataField="mangjobname" HeaderText="職稱" Visible="False" />
                                        <asp:TemplateField HeaderText="員工自評">
                                            <ItemTemplate>
                                                <asp:Label ID="_nobr" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label><asp:Label
                                                    ID="effs" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="自評評等">
                                            <ItemTemplate>
                                                <asp:Label ID="effs1" runat="server"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="主管評分">
                                            <ItemTemplate>
                                                <asp:Label ID="mangeffs" runat="server" ForeColor="Blue"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="主管評等">
                                            <ItemTemplate>
                                                <asp:Label ID="mangeffs1" runat="server" ForeColor="Blue"></asp:Label>
                                            </ItemTemplate>
                                            <ItemStyle HorizontalAlign="Center" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </fieldset>
                        </ContentTemplate>
                    </asp:UpdatePanel>
                </asp:View>
                <asp:View ID="View3" runat="server">
                    Appoint<asp:Label ID="app_yy" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="app_seq" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="app_nobr" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="mangnobr" runat="server" Visible="False"></asp:Label>
                    <asp:GridView ID="GridView2" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        DataKeyNames="yy,seq,nobr,templetID" OnSelectedIndexChanged="GridView3_SelectedIndexChanged"
                        OnRowCommand="GridView3_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="effbaseID" HeaderText="effbaseID" ReadOnly="True" SortExpression="effbaseID"
                                Visible="False" />
                            <asp:BoundField DataField="templetName" HeaderText="樣板" SortExpression="templetName"
                                Visible="False" />
                            <asp:BoundField DataField="yy" HeaderText="年度" SortExpression="yy" />
                            <asp:BoundField DataField="seq" HeaderText="頻率" SortExpression="seq" />
                            <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID"
                                Visible="False" />
                            <asp:BoundField DataField="nobr" HeaderText="工號" SortExpression="nobr" />
                            <asp:BoundField DataField="dept" HeaderText="dept" SortExpression="dept" Visible="False" />
                            <asp:BoundField DataField="depts" HeaderText="depts" SortExpression="depts" Visible="False" />
                            <asp:BoundField DataField="JOB" HeaderText="JOB" SortExpression="JOB" Visible="False" />
                            <asp:BoundField DataField="jobl" HeaderText="jobl" SortExpression="jobl" Visible="False" />
                            <asp:BoundField DataField="stddate" HeaderText="stddate" SortExpression="stddate"
                                Visible="False" />
                            <asp:BoundField DataField="enddate" HeaderText="enddate" SortExpression="enddate"
                                Visible="False" />
                            <asp:BoundField DataField="firstdate" HeaderText="firstdate" SortExpression="firstdate"
                                Visible="False" />
                            <asp:BoundField DataField="deptorder" HeaderText="deptorder" SortExpression="deptorder"
                                Visible="False" />
                            <asp:BoundField DataField="jobplan" HeaderText="jobplan" SortExpression="jobplan"
                                Visible="False" />
                            <asp:CheckBoxField DataField="mangfinish" HeaderText="mangfinish" SortExpression="mangfinish"
                                Visible="False" />
                            <asp:CheckBoxField DataField="isdeff" HeaderText="isdeff" SortExpression="isdeff"
                                Visible="False" />
                            <asp:BoundField DataField="effsfinally" HeaderText="effsfinally" SortExpression="effsfinally"
                                Visible="False" />
                            <asp:BoundField DataField="effsgroupID" HeaderText="effsgroupID" SortExpression="effsgroupID"
                                Visible="False" />
                            <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                            <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
                            <asp:BoundField DataField="DEPTSNAME" HeaderText="成本中心" SortExpression="DEPTSNAME"
                                Visible="False" />
                            <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
                            <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" />
                            <asp:BoundField DataField="effsgroupname" HeaderText="群組" SortExpression="effsgroupname" />
                            <asp:BoundField DataField="templetID" HeaderText="templetID" Visible="False" />
                        </Columns>
                    </asp:GridView>
                    <hr />
                    指定主管：<asp:TextBox ID="txt_nobr" runat="server"></asp:TextBox>
                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="新增" />
                    <asp:Label ID="Label1" runat="server" Text="(輸入工號或性名)"></asp:Label>&nbsp;
                    <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView4_RowCommand">
                        <Columns>
                            <asp:BoundField DataField="yy" HeaderText="年度" />
                            <asp:BoundField DataField="seq" HeaderText="頻率" />
                            <asp:BoundField DataField="nobr" HeaderText="工號" />
                            <asp:BoundField DataField="name" HeaderText="姓名" />
                            <asp:BoundField DataField="assignname" HeaderText="指派員工" />
                            <asp:BoundField DataField="assigndept" HeaderText="部門" />
                            <asp:BoundField DataField="assignjob" HeaderText="職稱" />
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <asp:TEMPLATEFIELD></asp:TEMPLATEFIELD>
                                    <itemtemplate>
</itemtemplate>
                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Bind("AutoKey") %>'
                                        CommandName="DeleteE" OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </asp:View>
                <asp:View ID="View4" runat="server">
                    <span style="color: blue; font-family: 標楷體; mso-hansi-font-family: 'Times New Roman'">
                        <br />
                        <table>
                            <tr>
                                <td valign="top">
                                    <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoKey"
                                        DataSourceID="ObjectDataSource1">
                                        <Columns>
                                            <asp:CommandField ShowSelectButton="True" />
                                            <asp:BoundField DataField="AutoKey" HeaderText="AutoKey" ReadOnly="True" SortExpression="AutoKey"
                                                Visible="False" />
                                            <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" />
                                            <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" />
                                            <asp:BoundField DataField="nobr" HeaderText="工號" SortExpression="nobr" />
                                            <asp:BoundField DataField="name" HeaderText="姓名" SortExpression="nobr" />
                                            <asp:BoundField DataField="arrprate" HeaderText="工作績效比重" SortExpression="arrprate" />
                                            <asp:BoundField DataField="caterate" HeaderText="行為態度比重" SortExpression="caterate" />
                                            <asp:BoundField DataField="mangnobr" HeaderText="mangnobr" SortExpression="mangnobr"
                                                Visible="False" />
                                        </Columns>
                                    </asp:GridView>
                                </td>
                                <td valign="top">
                                    <asp:FormView ID="FormView1" runat="server" DataKeyNames="AutoKey" DataSourceID="ObjectDataSource2"
                                        OnItemDeleted="FormView1_ItemDeleted" OnItemInserted="FormView1_ItemInserted"
                                        OnItemInserting="FormView1_ItemInserting" OnItemUpdated="FormView1_ItemUpdated"
                                        OnItemUpdating="FormView1_ItemUpdating">
                                        <EditItemTemplate>
                                            工作績效比重:
                                            <asp:TextBox ID="arrprateTextBox" runat="server" Text='<%# Bind("arrprate") %>' Width="61px"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="arrprateTextBox"
                                                Display="Dynamic" ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*請輸入數值</asp:CompareValidator><br />
                                            行為態度比重:
                                            <asp:TextBox ID="caterateTextBox" runat="server" Text='<%# Bind("caterate") %>' Width="62px"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="caterateTextBox"
                                                Display="Dynamic" ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*請輸入數值</asp:CompareValidator><br />
                                            <asp:TextBox ID="yyTextBox" runat="server" Text='<%# Bind("yy") %>' Visible="False"
                                                Width="27px"></asp:TextBox><asp:TextBox ID="seqTextBox" runat="server" Text='<%# Bind("seq") %>'
                                                    Visible="False" Width="28px"></asp:TextBox><asp:TextBox ID="mangnobrTextBox" runat="server"
                                                        Text='<%# Bind("mangnobr") %>' Visible="False" Width="32px"></asp:TextBox><asp:TextBox
                                                            ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>' Visible="False" Width="31px"></asp:TextBox><br />
                                            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="更新"></asp:LinkButton>
                                            <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="取消"></asp:LinkButton>
                                            <asp:Label ID="AutoKeyLabel1" runat="server" Text='<%# Eval("AutoKey") %>' Visible="False"></asp:Label>
                                        </EditItemTemplate>
                                        <EmptyDataTemplate>
                                            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                Text="新增比重資料"></asp:LinkButton>
                                        </EmptyDataTemplate>
                                        <InsertItemTemplate>
                                            員工工號：<asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("nobr") %>' Width="72px"></asp:TextBox>
                                            <asp:Label ID="Label2" runat="server" Text="（輸入工號或姓名）"></asp:Label><br />
                                            工作績效比重:
                                            <asp:TextBox ID="arrprateTextBox" runat="server" Text='<%# Bind("arrprate") %>' Width="61px"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="arrprateTextBox"
                                                Display="Dynamic" ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*請輸入數值</asp:CompareValidator><br />
                                            行為態度比重:
                                            <asp:TextBox ID="caterateTextBox" runat="server" Text='<%# Bind("caterate") %>' Width="62px"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="caterateTextBox"
                                                Display="Dynamic" ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*請輸入數值</asp:CompareValidator><br />
                                            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                                                Text="插入"></asp:LinkButton>
                                            <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                                                Text="取消"></asp:LinkButton>
                                        </InsertItemTemplate>
                                        <ItemTemplate>
                                            工作績效比重:
                                            <asp:TextBox ID="arrprateTextBox" runat="server" ReadOnly="True" Text='<%# Bind("arrprate") %>'
                                                Width="61px"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="arrprateTextBox"
                                                Display="Dynamic" ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*請輸入數值</asp:CompareValidator><br />
                                            行為態度比重:
                                            <asp:TextBox ID="caterateTextBox" runat="server" ReadOnly="True" Text='<%# Bind("caterate") %>'
                                                Width="62px"></asp:TextBox>
                                            <asp:CompareValidator ID="CompareValidator2" runat="server" ControlToValidate="caterateTextBox"
                                                Display="Dynamic" ErrorMessage="CompareValidator" Operator="DataTypeCheck" Type="Double">*請輸入數值</asp:CompareValidator><br />
                                            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                                                Text="編輯"></asp:LinkButton>
                                            <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                                                Text="刪除"></asp:LinkButton>
                                            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                                Text="新增"></asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:FormView>
                                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                                        TypeName="EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter" UpdateMethod="Update">
                                        <DeleteParameters>
                                            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                                        </DeleteParameters>
                                        <UpdateParameters>
                                            <asp:Parameter Name="yy" Type="Int32" />
                                            <asp:Parameter Name="seq" Type="Int32" />
                                            <asp:Parameter Name="nobr" Type="String" />
                                            <asp:Parameter Name="arrprate" Type="Decimal" />
                                            <asp:Parameter Name="caterate" Type="Decimal" />
                                            <asp:Parameter Name="mangnobr" Type="String" />
                                            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                                        </UpdateParameters>
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="GridView6" DefaultValue="9999" Name="ID" PropertyName="SelectedValue"
                                                Type="Int32" />
                                        </SelectParameters>
                                        <InsertParameters>
                                            <asp:Parameter Name="yy" Type="Int32" />
                                            <asp:Parameter Name="seq" Type="Int32" />
                                            <asp:Parameter Name="nobr" Type="String" />
                                            <asp:Parameter Name="arrprate" Type="Decimal" />
                                            <asp:Parameter Name="caterate" Type="Decimal" />
                                            <asp:Parameter Name="mangnobr" Type="String" />
                                        </InsertParameters>
                                    </asp:ObjectDataSource>
                                </td>
                            </tr>
                        </table>
                        <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
                            InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByMangForEmps"
                            TypeName="EFFMANGDSTableAdapters.EFFS_MANGRATETableAdapter" UpdateMethod="Update">
                            <DeleteParameters>
                                <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                            </DeleteParameters>
                            <UpdateParameters>
                                <asp:Parameter Name="AutoKey" Type="Int32" />
                                <asp:Parameter Name="yy" Type="Int32" />
                                <asp:Parameter Name="seq" Type="Int32" />
                                <asp:Parameter Name="nobr" Type="String" />
                                <asp:Parameter Name="arrprate" Type="Decimal" />
                                <asp:Parameter Name="caterate" Type="Decimal" />
                                <asp:Parameter Name="mangnobr" Type="String" />
                                <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                            </UpdateParameters>
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lb_yy" DefaultValue="0" Name="yy" PropertyName="Text"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="lb_seq" DefaultValue="0" Name="seq" PropertyName="Text"
                                    Type="Int32" />
                                <asp:ControlParameter ControlID="mangnobr" DefaultValue="&quot;&quot;" Name="mangnobr"
                                    PropertyName="Text" Type="String" />
                            </SelectParameters>
                            <InsertParameters>
                                <asp:Parameter Name="AutoKey" Type="Int32" />
                                <asp:Parameter Name="yy" Type="Int32" />
                                <asp:Parameter Name="seq" Type="Int32" />
                                <asp:Parameter Name="nobr" Type="String" />
                                <asp:Parameter Name="arrprate" Type="Decimal" />
                                <asp:Parameter Name="caterate" Type="Decimal" />
                                <asp:Parameter Name="mangnobr" Type="String" />
                            </InsertParameters>
                        </asp:ObjectDataSource>
                        &nbsp;&nbsp;<br />
                        &nbsp; &nbsp; &nbsp;&nbsp; </span>
                </asp:View>
            </asp:MultiView>
       
 
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
</asp:Content>
