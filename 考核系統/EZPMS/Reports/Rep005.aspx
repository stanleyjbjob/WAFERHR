<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Rep005.aspx.cs" Inherits="Reports_Rep005" Title="Untitled Page" %>
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
                    <asp:GridView ID="leanplanGridView" runat="server" AutoGenerateColumns="False" DataSourceID="leanplanSqlDataSource1"
                        OnRowDataBound="leanplanGridView_RowDataBound" Width="100%">
                        <Columns>
                            <asp:BoundField DataField="note" HeaderText="發展計劃" SortExpression="note">
                                <ItemStyle Width="330px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID"
                                Visible="False" />
                            <asp:BoundField DataField="learnplanID" HeaderText="learnplanID" SortExpression="learnplanID"
                                Visible="False" />
                            <asp:TemplateField HeaderText="員工意見">
                                <ItemTemplate>
                                    &nbsp;<asp:Label ID="PlanText" runat="server"></asp:Label>
                                    <asp:Label ID="planID" runat="server" Text='<%# Eval("learnplanID") %>' Visible="False"></asp:Label>
                                    <asp:Label ID="Label4" runat="server" Text='<%# Eval("nobr") %>' Visible="False"></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>
                    <asp:SqlDataSource ID="leanplanSqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
                        SelectCommand="SELECT EFFS_LEARNPLAN.note, EFFS_TEMPLETLEARNPLAN.templetID, EFFS_TEMPLETLEARNPLAN.learnplanID, EFFS_SELFLEARNPLAN.nobr FROM EFFS_TEMPLETLEARNPLAN INNER JOIN EFFS_LEARNPLAN ON EFFS_TEMPLETLEARNPLAN.learnplanID = EFFS_LEARNPLAN.ID LEFT OUTER JOIN EFFS_SELFLEARNPLAN ON EFFS_LEARNPLAN.ID = EFFS_SELFLEARNPLAN.learnplanID WHERE (EFFS_TEMPLETLEARNPLAN.templetID = @templetID) AND (EFFS_SELFLEARNPLAN.yy = @yy) AND (EFFS_SELFLEARNPLAN.seq = @seq) AND (EFFS_SELFLEARNPLAN.nobr = @nobr) ORDER BY EFFS_TEMPLETLEARNPLAN.[order]">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="_temp" DefaultValue="&quot;&quot;" Name="templetID"
                                PropertyName="Text" />
                            <asp:ControlParameter ControlID="tb_year" DefaultValue="" Name="yy" PropertyName="Text" />
                            <asp:ControlParameter ControlID="tb_seq" Name="seq" PropertyName="Text" />
                            <asp:ControlParameter ControlID="_nobr" Name="nobr" PropertyName="Text" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:Label ID="_temp" runat="server" Text='<%# Bind("templetID") %>' Visible="False"></asp:Label>
                    <asp:Label ID="_nobr" runat="server" Text='<%# Eval("NOBR") %>' Visible="False"></asp:Label>
                </ItemTemplate>
            </asp:TemplateField>
            <asp:TemplateField>
                <ItemTemplate>
                    <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="AuotKey"
                        DataSourceID="ObjectDataSource2">
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
                            <asp:BoundField DataField="note1" HeaderText="主管意見" HtmlEncode="False" SortExpression="note1">
                                <ItemStyle Width="500px" />
                            </asp:BoundField>
                            <asp:BoundField DataField="note2" HeaderText="note2" SortExpression="note2" Visible="False" />
                            <asp:BoundField DataField="note3" HeaderText="note3" SortExpression="note3" Visible="False" />
                            <asp:BoundField DataField="note4" HeaderText="note4" SortExpression="note4" Visible="False" />
                            <asp:BoundField DataField="note5" HeaderText="note5" SortExpression="note5" Visible="False" />
                        </Columns>
                    </asp:GridView>
                    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByNote1"
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
                            <asp:ControlParameter ControlID="__nobr" DefaultValue="&quot;&quot;" Name="nobr"
                                PropertyName="Text" Type="String" />
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
    </asp:GridView>
</asp:Content>

