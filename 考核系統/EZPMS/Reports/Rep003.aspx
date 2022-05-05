<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Rep003.aspx.cs" Inherits="Reports_Rep003" Title="Untitled Page" %>
<%@ Register Assembly="FreeTextBox" Namespace="FreeTextBoxControls" TagPrefix="FTB" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>查詢條件</legend>
        <asp:DropDownList ID="dll_attend" runat="server" DataSourceID="SqlDataSource1" DataTextField="Desc"
            DataValueField="keyValue">
        </asp:DropDownList>
        <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
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
        &nbsp;
    </fieldset>
    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataKeyNames="yy,seq,nobr,templetID"
        OnDataBound="GridView7_DataBound" OnRowDataBound="GridView7_RowDataBound" ShowFooter="True">
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
    <asp:GridView ID="GridViewInterView" runat="server" AutoGenerateColumns="False" DataKeyNames="ID" OnDataBound="GridViewInterView_DataBound"
        OnRowDataBound="GridViewInterView_RowDataBound" Width="100%">
        <Columns>
            <asp:BoundField DataField="ID" HeaderText="ID" ReadOnly="True" SortExpression="ID"
                Visible="False" />
            <asp:BoundField DataField="interview" HeaderText="討論內容" SortExpression="interview" />
            <asp:TemplateField HeaderText="員工意見">
                <ItemTemplate>
                    <asp:Label ID="lb_ID" runat="server" Text='<%# Eval("ID") %>' Visible="False"></asp:Label>
                    <asp:Label ID="FreeTextBox1" runat="server"></asp:Label>&nbsp;
                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("nobr") %>' Visible="False"></asp:Label>
                    <asp:Label ID="Label5" runat="server" Text='<%# Eval("note") %>'></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="mang1" Visible="False" HtmlEncode="False" />
            <asp:BoundField DataField="mang2" Visible="False" HtmlEncode="False" />
            <asp:BoundField DataField="mang3" Visible="False" HtmlEncode="False" />
            <asp:BoundField DataField="mang4" Visible="False" HtmlEncode="False" />
            <asp:BoundField DataField="mang5"  Visible="False" HtmlEncode="False" />  <asp:BoundField DataField="mang6"  Visible="False" HtmlEncode="False" />
            <asp:TemplateField HeaderText="主管竟見與回饋" Visible="False">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Visible="false"></asp:TextBox>
                </EditItemTemplate>
                <ItemStyle Width="30%" />
                <ItemTemplate>
                    <ftb:freetextbox id="FreeTextBox2" runat="server" breakmode="LineBreak" enablehtmlmode="False"
                        enabletoolbars="False" height="100px" width="100%" Visible = "false">
                                        </ftb:freetextbox>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource_INTERVIEW" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
        SelectCommand="SELECT EFFS_INTERVIEW.ID, EFFS_INTERVIEW.interview, EFFS_SELFINTERVIEW.nobr, EFFS_SELFINTERVIEW.note FROM EFFS_TEMPLETINTERVIEW INNER JOIN EFFS_INTERVIEW ON EFFS_TEMPLETINTERVIEW.interviewID = EFFS_INTERVIEW.ID LEFT OUTER JOIN EFFS_SELFINTERVIEW ON EFFS_INTERVIEW.ID = EFFS_SELFINTERVIEW.INTERID WHERE (EFFS_TEMPLETINTERVIEW.templetID = @templetID) AND (EFFS_SELFINTERVIEW.nobr = @nobr) AND (EFFS_SELFINTERVIEW.yy = @yy) AND (EFFS_SELFINTERVIEW.seq = @seq) ORDER BY EFFS_TEMPLETINTERVIEW.[order]">
        <SelectParameters>
            <asp:ControlParameter ControlID="_temp" Name="templetID" PropertyName="Text" />
            <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" />
            <asp:ControlParameter ControlID="tb_year" Name="yy" PropertyName="Text" />
            <asp:ControlParameter ControlID="tb_seq" Name="seq" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
        <asp:Label ID="_nobr" runat="server" Text='<%# Eval("NOBR") %>' Visible="False"></asp:Label>
        <asp:Label ID="_temp" runat="server" Text='<%# Bind("templetID") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    &nbsp;&nbsp;
    <asp:Label ID="_nobr_" runat="server"></asp:Label>
</asp:Content>

