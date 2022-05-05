<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF006.aspx.cs" Inherits="Mang_EFF006" Title="合晶科技績效考核系統（Web版）v1.0" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <asp:Label ID="_yy" runat="server" Visible="False"></asp:Label><asp:Label ID="_seq"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label
            ID="_dept" runat="server" Visible="False"></asp:Label><asp:GridView ID="GridView1"
                runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey" DataSourceID="AttendDataSource1"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                Text="選取" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="yy" HeaderText="考核年度" SortExpression="yy"  ItemStyle-HorizontalAlign="Center"/>
                    <asp:BoundField DataField="seq" HeaderText="考核次數" SortExpression="seq" ItemStyle-HorizontalAlign="Center" />
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click1" Text="儲存修改比重資料" CommandName="Select" /><asp:GridView
        ID="GridView7" runat="server" AutoGenerateColumns="False"
        DataKeyNames="yy,seq,nobr,templetID" OnRowDataBound="GridView7_RowDataBound" OnSelectedIndexChanged="GridView7_SelectedIndexChanged" OnSelectedIndexChanging="GridView7_SelectedIndexChanging">
        <Columns>
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
            <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
            <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" Visible="False" />
            <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
            <asp:TemplateField HeaderText="工作目標比重">
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("templetID") %>' Visible="False"></asp:Label>
                    <asp:Label ID="_effbaseID" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label>
                    &nbsp;
                    <asp:TextBox ID="catea" runat="server" Width="50px"></asp:TextBox>
                    <asp:Label ID="_templetID" runat="server" Text='<%# Bind("templetID") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField HeaderText="行為態度比重">
                <ItemTemplate>
                    <asp:TextBox ID="cateb" runat="server" Width="50px"></asp:TextBox>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField></asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AttendDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter"></asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
</asp:Content>

