<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true"
    CodeFile="EFF007.aspx.cs" Inherits="Mang_EFF007" Title="合晶科技績效考核系統（Web版）v1.0" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h5>
        評核者設定</h5>
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
                            <asp:BoundField DataField="yy" HeaderText="考核年度" SortExpression="yy" ItemStyle-HorizontalAlign="Center" />
                            <asp:BoundField DataField="seq" HeaderText="考核次數" SortExpression="seq" ItemStyle-HorizontalAlign="Center" />
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
        </ContentTemplate>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <table width="100%">
                <tr>
                    <td valign="top" width="60%">
                        <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataKeyNames="yy,seq,nobr,templetID"
                            OnRowDataBound="GridView7_RowDataBound" OnSelectedIndexChanged="GridView7_SelectedIndexChanged"
                            OnSelectedIndexChanging="GridView7_SelectedIndexChanging" Width="100%">
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Select"
                                            Text="設定評核者" />
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
                                <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                                <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" Visible="False" />
                                <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
                                <asp:BoundField DataField="mangname" HeaderText="直線主管" />
                                <asp:BoundField DataField="mangjob" HeaderText="職等" />
                            </Columns>
                        </asp:GridView>
                    </td>
                    <td valign="top" align="left">
                        <asp:Panel ID="Panel1" runat="server" Height="50px" Visible="False" Width="100%">
                            <fieldset>
                                <legend>
                                    <asp:Label ID="Label2" runat="server" ForeColor="Blue" Text="非直線主管評核"></asp:Label></legend>
                                <asp:Label ID="app_yy" runat="server" Visible="False"></asp:Label><asp:Label ID="app_seq"
                                    runat="server" Visible="False"></asp:Label><asp:Label ID="app_nobr" runat="server"
                                        Visible="False"></asp:Label><asp:Label ID="mangnobr" runat="server" Visible="False"></asp:Label>
                                <fieldset>
                                    <asp:Label ID="Label3" runat="server" ForeColor="Blue" Text="主管姓名："></asp:Label>
                                    <asp:TextBox ID="txt_nobr" runat="server" Width="113px"></asp:TextBox>
                                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="新增" />
                                    <br />
                                    &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
                                    <asp:Label ID="Label1" runat="server" Text="(輸入工號或姓名)" ForeColor="Red"></asp:Label>
                                </fieldset>
                                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" OnRowCommand="GridView4_RowCommand"
                                    DataKeyNames="AutoKey" OnRowDeleted="GridView4_RowDeleted" OnRowDeleting="GridView4_RowDeleting">
                                    <Columns>
                                        <asp:BoundField DataField="yy" HeaderText="年度" Visible="False" />
                                        <asp:BoundField DataField="seq" HeaderText="頻率" Visible="False" />
                                        <asp:BoundField DataField="nobr" HeaderText="工號" Visible="False" />
                                        <asp:BoundField DataField="assignname" HeaderText="主管姓名" />
                                        <asp:BoundField DataField="assigndept" HeaderText="部門" />
                                        <asp:BoundField DataField="assignjob" HeaderText="職稱" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:TEMPLATEFIELD>
                                                    <itemtemplate></itemtemplate>
                                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandArgument='<%# Bind("AutoKey") %>'
                                                        OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" OnClick="Button1_Click" />
                                                    <asp:Label id="_AutoKey" runat="server" Text='<%# Bind("AutoKey") %>' Visible="False">
                                                    </asp:Label>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </fieldset>
                        </asp:Panel>
                    </td>
                    <td valign="top" >
                    </td>
                </tr>
                <tr>
                    <td colspan="3">
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
                    </td>
                </tr>
            </table>
            <asp:ObjectDataSource ID="AttendDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter"></asp:ObjectDataSource>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
