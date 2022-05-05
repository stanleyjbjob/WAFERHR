<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Rep008.aspx.cs" Inherits="Reports_Rep008" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>查詢條件</legend>
        <asp:DropDownList ID="dll_attend" runat="server" DataSourceID="SqlDataSource1" DataTextField="Desc"
            DataValueField="keyValue">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT CONVERT (char(4), yy) + ',' + CONVERT (char(2), seq) AS keyValue, [Desc] FROM EFFS_ATTEND ORDER BY yy desc, seq desc">
        </asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Text="年度：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_year" runat="server" Width="53px" Visible="False"></asp:TextBox>
        <asp:Label ID="Label2" runat="server" Text="期數：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_seq" runat="server" Width="42px" Visible="False"></asp:TextBox>&nbsp;
        <asp:Label ID="Label3" runat="server" Text="部門："></asp:Label>
        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DeptMDataSource1"
            DataTextField="D_NAME" DataValueField="D_NO" OnDataBound="DropDownList1_DataBound">
        </asp:DropDownList>
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="匯出Excel" />
        <br />
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
       
    </fieldset>
    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataKeyNames="yy,seq,nobr,templetID"
        OnDataBound="GridView7_DataBound" OnRowDataBound="GridView7_RowDataBound" >
        <Columns>
            <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="jobl" />
            <asp:BoundField DataField="effbaseID" HeaderText="effbaseID" ReadOnly="True" SortExpression="effbaseID"
                Visible="False" />
            <asp:BoundField DataField="templetName" HeaderText="樣板" SortExpression="templetName"
                Visible="False" />
            <asp:TemplateField HeaderText="templetID" SortExpression="templetID" Visible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("templetID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("templetID") %>'></asp:Label>
                </ItemTemplate>
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
            <asp:BoundField DataField="templetID" HeaderText="templetID" Visible="False" />
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="_nobr" runat="server" Text='<%# Eval("NOBR") %>' Visible="False"></asp:Label><asp:GridView
                        ID="GridView1" runat="server"  AutoGenerateColumns="False"
                        DataKeyNames="autoKey" DataSourceID="ObjectDataSource2" OnRowDataBound="GridView1_RowDataBound"
                        PageSize="5" Width="100%">
                        <Columns>
                            <asp:TemplateField ShowHeader="False" Visible="False">
                                <ItemStyle Width="30px" />
                                <ItemTemplate>
                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                        Text="選取" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                                SortExpression="autoKey" Visible="False" />
                            <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                            <asp:BoundField DataField="yy" HeaderText="年度" SortExpression="yy" Visible="False" />
                            <asp:TemplateField Visible="False">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("seq") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="DropDownList1" runat="server" Enabled="False" SelectedValue='<%# Bind("seq") %>'>
                                        <asp:ListItem Value="0"> </asp:ListItem>
                                        <asp:ListItem Selected="True" Value="1">上半年度</asp:ListItem>
                                        <asp:ListItem Value="2">下半年度</asp:ListItem>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="works" HeaderText="工作目標" HtmlEncode="False" SortExpression="works" />
                            <asp:BoundField DataField="standard" HeaderText="衡量準標" SortExpression="standard"
                                Visible="False" />
                            <asp:BoundField DataField="rate" DataFormatString="{0:0.0}%" HeaderText="比重" SortExpression="rate">
                                <ItemStyle HorizontalAlign="Center" Width="50px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="appr" HeaderText="執行之質與量的綜合成果" HtmlEncode="False" SortExpression="appr" />
                            <asp:BoundField DataField="bespeak" HeaderText="bespeak" SortExpression="bespeak"
                                Visible="False" />
                            <asp:BoundField DataField="reality" HeaderText="reality" SortExpression="reality"
                                Visible="False" />
                            <asp:TemplateField HeaderText="主管確認" SortExpression="mangCheck">
                                <ItemStyle HorizontalAlign="Center" Width="40px" />
                                <ItemTemplate>
                                    
                                    <asp:Label ID="Label2" runat="server" Text='<%# Bind("mangname") %>'></asp:Label>
                                    <asp:Label ID="chdate" runat="server" Text='<%# Bind("mangcheckDate") %>' Visible="False"
                                        Width="50px"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="納入考核" SortExpression="included" Visible="False">
                                <ItemTemplate>
                                    <asp:CheckBox ID="cb_included" runat="server" Checked='<%# Bind("included") %>' Enabled="false" />
                                    <asp:Label ID="lb_yy" runat="server" Text='<%# Bind("yy") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="lb_seq" runat="server" Text='<%# Bind("seq") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="Label1" runat="server" Text='<%# Eval("rate") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="LB_show" runat="server"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="key_date" DataFormatString="{0:yyyy/MM/dd}" HeaderText="輸人日期"
                                HtmlEncode="False" SortExpression="key_date" Visible="False" />
                            <asp:TemplateField Visible="False">
                                <ItemStyle Width="20px" />
                                <ItemTemplate>
                                    <asp:Button ID="delBtn" runat="server" CausesValidation="False" CommandName="Delete"
                                        OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                                    <asp:Label ID="autoKey" runat="server" Text='<%# Eval("autoKey") %>' Visible="False"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
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
                            <asp:ControlParameter ControlID="_nobr" DefaultValue="uu" Name="nobr" PropertyName="Text"
                                Type="String" />
                            <asp:ControlParameter ControlID="tb_year" DefaultValue="2007" Name="yy" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="tb_seq" DefaultValue="3" Name="seq" PropertyName="Text"
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
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

