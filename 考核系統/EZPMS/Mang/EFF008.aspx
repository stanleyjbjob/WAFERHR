<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF008.aspx.cs" Inherits="Mang_EFF008" Title="Untitled Page" %>
<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:loading id="Loading1" runat="server"></uc1:loading>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="Label1" runat="server" Text="年度：" Visible="False"></asp:Label><asp:TextBox ID="tb_year"
        runat="server" Width="53px" Visible="False"></asp:TextBox><asp:Label ID="Label2" runat="server" Text="期數：" Visible="False"></asp:Label><asp:TextBox
            ID="tb_seq" runat="server" Width="42px" Visible="False"></asp:TextBox>
    <asp:DropDownList ID="dll_attend" runat="server" DataSourceID="SqlDataSource1" DataTextField="Desc"
        DataValueField="keyValue">
    </asp:DropDownList><asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
        SelectCommand="SELECT CONVERT (char(4), yy) + ',' + CONVERT (char(2), seq) AS keyValue, [Desc] FROM EFFS_ATTEND ORDER BY yy, seq">
    </asp:SqlDataSource>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="績效考核表" ToolTip='<%# Eval("NOBR") %>' />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="NOBR" HeaderText="工號" />
            <asp:BoundField DataField="NAME_C" HeaderText="姓名" />
            <asp:BoundField DataField="DEPTNAME" HeaderText="部門" />
            <asp:BoundField DataField="JOBNAME" HeaderText="職稱" />
            <asp:BoundField DataField="INDT" DataFormatString="{0:yyyy/MM/dd}" HeaderText="到職日" HtmlEncode="False" />
        </Columns>
    </asp:GridView>
</asp:Content>

