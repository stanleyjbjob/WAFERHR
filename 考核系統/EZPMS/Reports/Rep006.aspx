<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Rep006.aspx.cs" Inherits="Reports_Rep006" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>查詢條件</legend>
        <asp:DropDownList ID="dll_attend" runat="server" DataSourceID="SqlDataSource2" DataTextField="Desc"
            DataValueField="keyValue">
        </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT CONVERT (char(4), yy) + ',' + CONVERT (char(2), seq) AS keyValue, [Desc] FROM EFFS_ATTEND ORDER BY yy desc, seq desc">
        </asp:SqlDataSource>
        <asp:Label ID="Label1" runat="server" Text="年度：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_year" runat="server" Width="53px" Visible="False"></asp:TextBox>
        <asp:Label ID="Label2" runat="server" Text="期數：" Visible="False"></asp:Label>
        <asp:TextBox ID="tb_seq" runat="server" Width="42px" Visible="False"></asp:TextBox>
        &nbsp;&nbsp;
        <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="查詢" />
        <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="匯出Excel" />&nbsp;<br />
        &nbsp;
    </fieldset>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataSourceID="SqlDataSource1">
        <Columns>
            <asp:BoundField DataField="NAME_C" HeaderText="主管姓名" SortExpression="NAME_C" />
            <asp:BoundField DataField="JOB_NAME" HeaderText="職稱" SortExpression="JOB_NAME" />
            <asp:BoundField DataField="D_NAME" HeaderText="部門" SortExpression="D_NAME" />
            <asp:BoundField DataField="note" HeaderText="主管總結意見" HtmlEncode="False" SortExpression="note" />
            <asp:BoundField DataField="keydate" HeaderText="確認時間" />
        </Columns>
    </asp:GridView>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
        SelectCommand="SELECT BASE.NAME_C, JOB.JOB_NAME, DEPTA.D_NAME, EFFS_MANGFINISHNOTE.note, EFFS_MANGFINISHNOTE.keydate FROM EFFS_MANGFINISHNOTE LEFT OUTER JOIN BASE ON EFFS_MANGFINISHNOTE.nobr = BASE.NOBR LEFT OUTER JOIN DEPTA ON EFFS_MANGFINISHNOTE.dept = DEPTA.D_NO LEFT OUTER JOIN JOB ON EFFS_MANGFINISHNOTE.job = JOB.JOB WHERE (EFFS_MANGFINISHNOTE.yy = @yy) AND (EFFS_MANGFINISHNOTE.seq = @seq)">
        <SelectParameters>
            <asp:ControlParameter ControlID="tb_year" DefaultValue="9999" Name="yy" PropertyName="Text" />
            <asp:ControlParameter ControlID="tb_seq" DefaultValue="0" Name="seq" PropertyName="Text" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>

