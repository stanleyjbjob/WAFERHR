<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF005.aspx.cs" Inherits="Mang_EFF005" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="_yy" runat="server" Visible="False"></asp:Label><asp:Label ID="_seq"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label
            ID="_dept" runat="server" Visible="False"></asp:Label><asp:GridView ID="GridView1" runat="server"
                AutoGenerateColumns="False" DataKeyNames="autoKey" DataSourceID="AttendDataSource1"
                OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
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
    <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="儲存修改比重資料" />
    <asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False"
        DataKeyNames="yy,seq,nobr,templetID" OnRowDataBound="GridView7_RowDataBound"
        ShowFooter="True">
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
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:Label ID="Label1" runat="server" Text='<%# Bind("templetID") %>' Visible="False"></asp:Label>
                    <asp:Label ID="_effbaseID" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label>
                    <asp:SqlDataSource
                        ID="dataViewDs" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                        SelectCommand="SELECT EFFS_CATE.effcateName, EFFS_CATEITEM.effsID, EFFS_CATEITEM.effsName, EFFS_TEMPLETCATEITEM.rate FROM EFFS_TEMPLETCATEITEM INNER JOIN EFFS_CATEITEM ON EFFS_TEMPLETCATEITEM.effsID = EFFS_CATEITEM.effsID INNER JOIN EFFS_CATE ON EFFS_CATEITEM.effcateID = EFFS_CATE.effcateID WHERE (EFFS_TEMPLETCATEITEM.templetID = @TempID) ORDER BY EFFS_TEMPLETCATEITEM.[order]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="Label1" DefaultValue="A001" Name="TempID" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="dataViewDs"
                        meta:resourceKey="GridView5Resource1" OnDataBound="GridView5_DataBound" OnRowDataBound="GridView5_RowDataBound" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="effsID" meta:resourceKey="BoundFieldResource17" SortExpression="effsID"
                                Visible="False" />
                            <asp:BoundField DataField="effcateName" HeaderText="考核項目" SortExpression="effcateName">
                                <ItemStyle Width="15%" />
                            </asp:BoundField>
                            <asp:BoundField DataField="effsName" HeaderText="考核細目" meta:resourceKey="BoundFieldResource18"
                                SortExpression="effsName">
                                <ItemStyle Width="50%" />
                            </asp:BoundField>
                            <asp:TemplateField HeaderText="比重" SortExpression="effsNum">
                                <EditItemTemplate>
                                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                                </EditItemTemplate>
                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                <ItemTemplate>
                                    &nbsp;<asp:TextBox ID="rate" runat="server" Width="53px" Text='<%# Bind("rate") %>'></asp:TextBox>
                                    <asp:Label ID="lb_effsID" runat="server" Text='<%# Bind("effsID") %>' Visible="False"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="AttendDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter"></asp:ObjectDataSource>
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
</asp:Content>

