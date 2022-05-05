<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master"  EnableEventValidation="false" AutoEventWireup="true" CodeFile="Rep002.aspx.cs" Inherits="Reports_Rep002" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>查詢條件</legend>
        <asp:DropDownList ID="dll_attend" runat="server" DataSourceID="SqlDataSource1" DataTextField="Desc"
            DataValueField="keyValue">
        </asp:DropDownList>
        <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="Button" Visible="False" />
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT CONVERT (char(4), yy) + ',' + CONVERT (char(2), seq) AS keyValue, [Desc] FROM EFFS_ATTEND ORDER BY yy desc, seq desc">
        </asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Text="年度：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_year" runat="server" Width="53px" Visible="False"></asp:TextBox>
        <asp:Label ID="Label2" runat="server" Text="期數：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_seq" runat="server" Width="42px" Visible="False"></asp:TextBox>&nbsp;
        <asp:Label ID="Label3" runat="server" Text="部門："></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DeptA_SqlDataSource"
            DataTextField="D_NAME" DataValueField="D_NO" OnDataBound="DropDownList1_DataBound">
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="匯出Excel" />&nbsp;<asp:Button
            ID="Button4" runat="server" OnClick="Button4_Click" Text="最後評等匯入HR資料庫" /><br />
        
      
        <asp:ObjectDataSource ID="DeptMDataSource1" runat="server" DeleteMethod="Delete"
            InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
            TypeName="EFFDSTableAdapters.DEPTATableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_D_NO" Type="String" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="D_NO" Type="String" />
                <asp:Parameter Name="D_NAME" Type="String" />
                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                <asp:Parameter Name="KEY_MAN" Type="String" />
                <asp:Parameter Name="OLD_DEPT" Type="String" />
                <asp:Parameter Name="ADATE" Type="DateTime" />
                <asp:Parameter Name="DDATE" Type="DateTime" />
                <asp:Parameter Name="DEPT_GROUP" Type="String" />
                <asp:Parameter Name="DEPT_CATE" Type="String" />
                <asp:Parameter Name="Original_D_NO" Type="String" />
            </UpdateParameters>
            <InsertParameters>
                <asp:Parameter Name="D_NO" Type="String" />
                <asp:Parameter Name="D_NAME" Type="String" />
                <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                <asp:Parameter Name="KEY_MAN" Type="String" />
                <asp:Parameter Name="OLD_DEPT" Type="String" />
                <asp:Parameter Name="ADATE" Type="DateTime" />
                <asp:Parameter Name="DDATE" Type="DateTime" />
                <asp:Parameter Name="DEPT_GROUP" Type="String" />
                <asp:Parameter Name="DEPT_CATE" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
        <asp:SqlDataSource ID="DeptA_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:TMTHRConnectionString %>"
            SelectCommand="SELECT D_NO, D_NAME FROM DEPTA WHERE (GETDATE() BETWEEN ADATE AND DDATE)">
        </asp:SqlDataSource>
    </fieldset>
    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataKeyNames="yy,seq,nobr,templetID"
        OnDataBound="GridView7_DataBound" OnRowDataBound="GridView7_RowDataBound" ShowFooter="false">
        <Columns>
            <asp:TemplateField ShowHeader="False" Visible="False">
                <ItemTemplate>
                    <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/MANG/EFF004.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                        Target="_blank">績效考核表</asp:HyperLink><br />
                    <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/MANG/PrintEffs.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                        Target="_blank">列印</asp:HyperLink>
                    <asp:LinkButton ID="LinkButton1" runat="server" CommandName="appoint" Visible="False">評核者設定</asp:LinkButton>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="jobl" />
            <asp:BoundField DataField="effbaseID" HeaderText="effbaseID" ReadOnly="True" SortExpression="effbaseID"
                Visible="False" />
            <asp:BoundField DataField="templetName" HeaderText="樣板" SortExpression="templetName"
                Visible="False" />
            <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID"
                Visible="False" />
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
            <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
            <asp:BoundField DataField="DEPTSNAME" HeaderText="成本中心" SortExpression="DEPTSNAME"
                Visible="False" />
            <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
            <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" Visible="False" />
            <asp:BoundField DataField="effsgroupname" HeaderText="群組" SortExpression="effsgroupname"
                Visible="False" />
            <asp:TemplateField HeaderText="自評績效" Visible="False">
                <FooterTemplate>
                    <asp:Label ID="effs_a1_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_a1" runat="server" Text='<%# Eval("effs_a1") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="自評態度" Visible="False">
                <FooterTemplate>
                    <asp:Label ID="effs_b1_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_b1" runat="server" Text='<%# Eval("effs_b1") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="自評分數" Visible="False">
                <FooterTemplate>
                    <asp:Label ID="effs_c1_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_c1" runat="server" Text='<%# Eval("effs_c1") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="自評評等" Visible="False">
                <FooterTemplate>
                    <asp:Label ID="effs_d1_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_d1" runat="server" Text='<%# Eval("effs_d1") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="績效">
                <FooterTemplate>
                    <asp:Label ID="effs_a_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="_nobr" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label>
                    <asp:Label ID="effs_a" runat="server" Text='<%# Eval("effs_a") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="態度">
                <FooterTemplate>
                    <asp:Label ID="effs_b_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_b" runat="server" Text='<%# Eval("effs_b") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="合計">
                <FooterTemplate>
                    <asp:Label ID="effs_c_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_c" runat="server" Text='<%# Eval("effs_c") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="評等">
                <FooterTemplate>
                    <asp:Label ID="effs_d_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_d" runat="server" Text='<%# Eval("effs_d") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="調整後分數">
                <FooterTemplate>
                    <asp:Label ID="effs_f_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
                <ItemTemplate>
                    <asp:Label ID="effs_f" runat="server" Text='<%# Eval("effs_f") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="調整後評等">
                <FooterTemplate>
                    <asp:Label ID="effs_g_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
                <ItemTemplate>
                    <asp:Label ID="effs_g" runat="server" Text='<%# Eval("effs_g") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="排名">
                <ItemStyle HorizontalAlign="Center" Width="30px" />
                <ItemTemplate>
                    <asp:Label ID="effs_e" runat="server" Text='<%# Eval("effs_e") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:BoundField DataField="templetID" HeaderText="templetID" Visible="False" />
            <asp:TemplateField HeaderText="總經理調整後分數">
                <FooterTemplate>
                    <asp:Label ID="effs_x_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
                <ItemTemplate>
                    <asp:Label ID="effs_x" runat="server" Text='<%# Eval("effs_f") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
            <asp:TemplateField HeaderText="總經理調整後評等">
                <FooterTemplate>
                    <asp:Label ID="effs_y_f" runat="server"></asp:Label>
                </FooterTemplate>
                <ItemStyle HorizontalAlign="Center" Width="50px" />
                <ItemTemplate>
                    <asp:Label ID="effs_y" runat="server" Text='<%# Eval("effs_g") %>'></asp:Label>
                </ItemTemplate>
                <FooterStyle HorizontalAlign="Center" />
            </asp:TemplateField>
        </Columns>
        
    </asp:GridView>
    <asp:DataList ID="DataList2" runat="server" OnItemDataBound="DataList2_ItemDataBound">
        <ItemTemplate>
            <fieldset>
                <legend>
                    <asp:Label ID="name" runat="server" Text='<%# Eval("name") %>'></asp:Label></legend>
                <asp:Label ID="groupid" runat="server" Text='<%# Eval("id") %>' Visible="False"></asp:Label>
                &nbsp;
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" 
                    OnRowDataBound="GridView3_RowDataBound1" OnRowCommand="GridView3_RowCommand">
                    <Columns>
                        <asp:TemplateField ShowHeader="False" Visible="False">
                            <ItemTemplate>
                                <asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/emp/PrintEffst.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                                    Target="_blank">績效考核表</asp:HyperLink><br />
                                <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/MANG/PrintEffs.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID") %>'
                                    Target="_blank" Visible="false">列印</asp:HyperLink>
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
                        <asp:TemplateField HeaderText="自評目標">
                            <ItemTemplate>
                                <asp:Label ID="sf_app" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="自評考核">
                            <ItemTemplate>
                                <asp:Label ID="sf_cate" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="自評總合">
                            <ItemTemplate>
                                <asp:Label ID="sf_t" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="主管目標">
                            <ItemTemplate>
                                <asp:Label ID="m_app" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="主管考核">
                            <ItemTemplate>
                                <asp:Label ID="m_cate" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="主管總合">
                            <ItemTemplate>
                                <asp:Label ID="m_t" runat="server"></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="評分" Visible="False">
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
                        <asp:TemplateField HeaderText="評分調整">
                            <ItemTemplate>
                                <asp:TextBox ID="m_num" runat="server" AutoPostBack="True" CssClass="Text_int" Font-Bold="True"
                                    ForeColor="Red" ValidationGroup='<%# Eval("nobr") %>'
                                    Width="59px" OnTextChanged="m_num_TextChanged">0</asp:TextBox><br />
                                <asp:TextBox ID="tb_o1" runat="server" AutoPostBack="True"
                                    TextMode="MultiLine" ValidationGroup='<%# Eval("nobr") %>' Visible="False"></asp:TextBox>
                            </ItemTemplate>
                            <HeaderTemplate>
                                <asp:Button ID="Button6" runat="server" CommandName="eff_num_header" OnClick="Button6_Click1"
                                    Text="讀取最後評分" />
                            </HeaderTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="f_mang_ef" HeaderText="排名" Visible="False" />
                        <asp:TemplateField HeaderText="評等">
                            <EditItemTemplate>
                                <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:TextBox ID="tb_f" runat="server" Width="40px" AutoPostBack="True" OnTextChanged="tb_f_TextChanged" ValidationGroup='<%# Eval("nobr") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="備註">
                            <ItemTemplate>
                                <asp:TextBox ID="TextBox2" runat="server" Height="38px" TextMode="MultiLine" Width="220px" AutoPostBack="True" OnTextChanged="TextBox2_TextChanged" ValidationGroup='<%# Eval("nobr") %>'></asp:TextBox>
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
            </fieldset>
        </ItemTemplate>
    </asp:DataList>
</asp:Content>

