<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Rep004.aspx.cs" Inherits="Reports_Rep004" Title="Untitled Page" %>
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
        OnDataBound="GridView7_DataBound" OnRowDataBound="GridView7_RowDataBound" ShowFooter="True" BorderColor="Black" BorderStyle="Double" BorderWidth="2px">
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
                    <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoKey"
                        DataSourceID="SelectEduObjectDataSource" SkinID="gridviewprint">
                        <Columns>
                            <asp:BoundField DataField="AutoKey" HeaderText="AutoKey" ReadOnly="True" SortExpression="AutoKey"
                                Visible="False" />
                            <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" />
                            <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" />
                            <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                            <asp:BoundField DataField="eduCateID" HeaderText="eduCateID" SortExpression="eduCateID"
                                Visible="False" />
                            <asp:BoundField DataField="eduCateItemID" HeaderText="eduCateItemID" SortExpression="eduCateItemID"
                                Visible="False" />
                            <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                                Visible="False" />
                            <asp:BoundField DataField="cateName" HeaderText="訓練類別" SortExpression="cateName" />
                            <asp:BoundField DataField="CateItemName" HeaderText="訓練項目" SortExpression="CateItemName" />
                            <asp:BoundField DataField="other" HeaderText="員工意見" HtmlEncode="False" SortExpression="other" />
                            <asp:TemplateField Visible="False">
                                <ItemTemplate>
                                    <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                        OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <HeaderStyle BackColor="White" ForeColor="Black" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="SelectEduObjectDataSource" runat="server" DeleteMethod="Delete"
                        OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySeleView"
                        TypeName="EFFDSTableAdapters.EFFS_SELFEDUTableAdapter">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                        </DeleteParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="tb_year" Name="yy" PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="tb_seq" Name="seq" PropertyName="Text" Type="Int32" />
                            <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" Type="String" />
                        </SelectParameters>
                    </asp:ObjectDataSource>
                    <asp:Label ID="_temp" runat="server" Text='<%# Bind("templetID") %>' Visible="False"></asp:Label>
                    <asp:Label ID="_nobr" runat="server" Text='<%# Eval("NOBR") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:GridView ID="GridView31" runat="server" AutoGenerateColumns="False" DataKeyNames="AuotKey"
                        DataSourceID="ObjectDataSource21">
                        <Columns>
                            <asp:BoundField DataField="AuotKey" HeaderText="AuotKey" InsertVisible="False" ReadOnly="True"
                                SortExpression="AuotKey" Visible="False" />
                            <asp:BoundField DataField="yy" HeaderText="yy" SortExpression="yy" Visible="False" />
                            <asp:BoundField DataField="seq" HeaderText="seq" SortExpression="seq" Visible="False" />
                            <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                            <asp:BoundField DataField="mangname" SortExpression="mangname" />
                            <asp:BoundField DataField="mangdept" HeaderText="mangdept" SortExpression="mangdept"
                                Visible="False" />
                            <asp:BoundField DataField="mangjob" HeaderText="mangjob" SortExpression="mangjob"
                                Visible="False" />
                            <asp:BoundField DataField="note2" HeaderText="主管意見" HtmlEncode="False" SortExpression="note2">
                                <ItemStyle Width="500px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="note2" HeaderText="note2" SortExpression="note2" Visible="False" />
                            <asp:BoundField DataField="note3" HeaderText="note3" SortExpression="note3" Visible="False" />
                            <asp:BoundField DataField="note4" HeaderText="note4" SortExpression="note4" Visible="False" />
                            <asp:BoundField DataField="note5" HeaderText="note5" SortExpression="note5" Visible="False" />
                        </Columns>
                        <HeaderStyle BackColor="White" ForeColor="Black" />
                    </asp:GridView>
                    <asp:ObjectDataSource ID="ObjectDataSource21" runat="server" DeleteMethod="Delete"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBynote2"
                        TypeName="EFFMANGDSTableAdapters.EFFS_MANGLEARNPLANTableAdapter" UpdateMethod="Update">
                        <DeleteParameters>
                            <asp:Parameter Name="Original_AuotKey" Type="Int32" />
                        </DeleteParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="mangnobr" Type="String" />
                            <asp:Parameter Name="mangdept" Type="String" />
                            <asp:Parameter Name="mangjob" Type="String" />
                            <asp:Parameter Name="note1" Type="String" />
                            <asp:Parameter Name="note2" Type="String" />
                            <asp:Parameter Name="note3" Type="String" />
                            <asp:Parameter Name="note4" Type="String" />
                            <asp:Parameter Name="note5" Type="String" />
                            <asp:Parameter Name="Original_AuotKey" Type="Int32" />
                        </UpdateParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="tb_year" DefaultValue="2007" Name="yy" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="tb_seq" DefaultValue="3" Name="seq" PropertyName="Text"
                                Type="Int32" />
                            <asp:ControlParameter ControlID="__nobr" DefaultValue="&quot;&quot;" Name="nobr" PropertyName="Text"
                                Type="String" />
                            <asp:Parameter DefaultValue="99" Name="cateorder" Type="Int32" />
                            <asp:Parameter DefaultValue="&quot;&quot;" Name="mangnobr" Type="String" />
                        </SelectParameters>
                        <InsertParameters>
                            <asp:Parameter Name="yy" Type="Int32" />
                            <asp:Parameter Name="seq" Type="Int32" />
                            <asp:Parameter Name="nobr" Type="String" />
                            <asp:Parameter Name="mangnobr" Type="String" />
                            <asp:Parameter Name="mangdept" Type="String" />
                            <asp:Parameter Name="mangjob" Type="String" />
                            <asp:Parameter Name="note1" Type="String" />
                            <asp:Parameter Name="note2" Type="String" />
                            <asp:Parameter Name="note3" Type="String" />
                            <asp:Parameter Name="note4" Type="String" />
                            <asp:Parameter Name="note5" Type="String" />
                        </InsertParameters>
                    </asp:ObjectDataSource>
                    <asp:Label ID="__nobr" runat="server" Text='<%# Eval("NOBR") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
        </Columns>
        <RowStyle BorderColor="Black" BorderStyle="Double" BorderWidth="3px" />
     
    </asp:GridView>
</asp:Content>

