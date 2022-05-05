<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFFS007.aspx.cs" Inherits="EMP_EFFS007" Title="合晶科技績效考核系統（Web版）v1.0" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>
    非直線員工評核</h5>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
        DataSourceID="AttendDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                        Text="選取" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="yy" HeaderText="考核年度" ItemStyle-HorizontalAlign="Center"
                SortExpression="yy" />
            <asp:BoundField DataField="seq" HeaderText="考核次數" ItemStyle-HorizontalAlign="Center"
                SortExpression="seq" />
            <asp:BoundField DataField="Desc" HeaderText="說明" SortExpression="Desc" />
            <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                Visible="False" />
            <asp:BoundField DataField="StdDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="開始日期"
                HtmlEncode="False" SortExpression="StdDate" />
            <asp:BoundField DataField="EndDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="結束日期"
                HtmlEncode="false" SortExpression="EndDate" />
            <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                SortExpression="autoKey" Visible="False" />
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AttendDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter"></asp:ObjectDataSource>
    <fieldset id="f_panel" runat="server" visible="false">
        <legend>
            <asp:Label ID="Label1" runat="server" ForeColor="Blue" Text="非直線人員考核名單"></asp:Label></legend>
        <asp:GridView ID="GridView5" runat="server"   AutoGenerateColumns="False"
            DataKeyNames="yy,seq,nobr,templetID" OnRowCommand="GridView3_RowCommand" OnRowDataBound="GridView5_RowDataBound1"
            OnSelectedIndexChanged="GridView3_SelectedIndexChanged">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        &nbsp;<asp:HyperLink ID="HyperLink1" runat="server" NavigateUrl='<%# "~/MANG/EFF004.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID")+"&Appoint=True" %>'
                            Target="_blank">績效考核表</asp:HyperLink>
                            <br />
                                                      <asp:HyperLink ID="HyperLink2" runat="server" NavigateUrl='<%# "~/MANG/PrintEffs.aspx?yy=" + Eval("yy") + "&seq=" + Eval("seq") + "&nobr=" + Eval("nobr")+"&tempID="+Eval("templetID")+"&Appoint=True" %>'
                                                    Target="_blank">列印</asp:HyperLink>
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
                <asp:BoundField DataField="effsgroupname" HeaderText="群組" SortExpression="effsgroupname"
                    Visible="False" />
                <asp:BoundField DataField="templetID" HeaderText="templetID" Visible="False" />
                <asp:BoundField DataField="mangname" HeaderText="指派主管" />
                <asp:BoundField DataField="mangdname" HeaderText="部門" Visible="False" />
                <asp:BoundField DataField="mangjobname" HeaderText="職稱" Visible="False" />
                <asp:TemplateField HeaderText="員工自評">
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="_nobr" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label><asp:Label
                            ID="effs" runat="server"  ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="自評評等">
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="effs1" runat="server"  ></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="主管評分">
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="mangeffs" runat="server" ForeColor="Blue"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:TemplateField HeaderText="主管評等">
                    <ItemStyle HorizontalAlign="Center" />
                    <ItemTemplate>
                        <asp:Label ID="mangeffs1" runat="server" ForeColor="Blue"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
        <asp:Label ID="lb_yy" runat="server" Visible="False"></asp:Label><asp:Label ID="lb_seq"
            runat="server" Visible="False"></asp:Label>
        <asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label></fieldset>
        </ContentTemplate>
    </asp:UpdatePanel>
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
    &nbsp;&nbsp;
</asp:Content>

