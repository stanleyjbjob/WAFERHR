<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Rep001.aspx.cs" ValidateRequest="false" Inherits="Reports_Rep001" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<fieldset><legend>查詢條件</legend>
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
    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="DeptA_SqlDataSource"
        DataTextField="D_NAME" DataValueField="D_NO">
    </asp:DropDownList>&nbsp;&nbsp;<asp:Button ID="Button1" runat="server" OnClick="Button1_Click"
        Text="查詢" />&nbsp;
    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" Text="匯出Excel" />
    <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="發激催通知" /><br />
    <asp:Label ID="Label4" runat="server" Text="工號："></asp:Label>
    <asp:TextBox ID="tb_nobr" runat="server" Width="76px"></asp:TextBox>
    <fieldset>
        <asp:CheckBox ID="CheckBox1" runat="server" Text="自評" />
        <asp:CheckBox ID="CheckBox2" runat="server" Text="第一階主管" />
        <asp:CheckBox ID="CheckBox3" runat="server" Text="第二階主管" />
        <asp:CheckBox ID="CheckBox4" runat="server" Text="第三階主管" />
        <asp:TextBox ID="tb_days" runat="server" Visible="False" Width="47px"></asp:TextBox><br />
        主旨：<asp:TextBox ID="TextBox1" runat="server" Width="374px"></asp:TextBox><br />
        內容：<asp:TextBox ID="TextBox2" runat="server" Height="68px" TextMode="MultiLine" Width="512px"></asp:TextBox><br />
        <asp:Button ID="Button5" runat="server" OnClick="Button5_Click" Text="測試發信內容" />
        測試工號：<asp:TextBox ID="tb_mail" runat="server"></asp:TextBox></fieldset>
    <br />
    <br />
    <asp:SqlDataSource ID="DeptA_SqlDataSource" runat="server" ConnectionString="<%$ ConnectionStrings:TMTHRConnectionString %>"
        SelectCommand="SELECT D_NO, D_NAME FROM DEPTA WHERE (GETDATE() BETWEEN ADATE AND DDATE)">
    </asp:SqlDataSource>
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
    <asp:GridView ID="GridView8" runat="server" AutoGenerateColumns="False" OnRowDataBound="GridView8_RowDataBound">
        <Columns>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="_nobr" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label>
                    <asp:CheckBox ID="cb_mail" runat="server" Checked="True" Visible="False" />
                    <asp:DataList
                        ID="DataList1" runat="server" OnItemDataBound="DataList1_ItemDataBound" RepeatDirection="Horizontal">
                        <ItemTemplate>
                            <table id="TABLE1" runat="server" cellpadding="0" cellspacing="0">
                                <tr>
                                    <td align="left" valign="top" style="height: 60px">
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
                                    <td valign="top" style="height: 60px">
                                        <table border="1" bordercolor="#eeeeee" style="border-collapse: collapse">
                                            <tr height="25">
                                                <td align="center" style="width: 100px; color: #000000">
                                                    <asp:Label ID="YYMMLabel" runat="server" Height="16px" Text='<%# DataBinder.Eval(Container.DataItem,"name") %>'></asp:Label>&nbsp;
                                                </td>
                                            </tr>
                                            <tr bgcolor="lemonchiffon" height="25">
                                                <td align="center" style="width: 100px; height: 25px;">
                                                    &nbsp;<asp:Label ID="EFFVARLabel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"adate") %>'></asp:Label></td>
                                            </tr>
                                            <tr bgcolor="lemonchiffon" height="25">
                                                <td align="center" style="width: 100px">
                                                    <asp:Label ID="EFFLVLLabel" runat="server" Text='<%# DataBinder.Eval(Container.DataItem,"type") %>'></asp:Label></td>
                                            </tr>
                                        </table>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Eval("nobr") %>' Visible="False"></asp:Label>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Eval("_nobr") %>' Visible="False"></asp:Label><asp:Button
                                            ID="Button3" runat="server" CommandArgument='<%# Eval("_nobr")+","+Eval("nobr") %>'
                                            OnClick="Button3_Click" OnClientClick="return confirm('確定要解除鎖定？');" Text="解除鎖定" />
                                        </td>
                                </tr>
                            </table>
                        </ItemTemplate>
                    </asp:DataList>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
</asp:Content>

