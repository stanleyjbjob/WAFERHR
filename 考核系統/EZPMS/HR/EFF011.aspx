<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF011.aspx.cs" Inherits="HR_EFF011" Title="合晶科技績效考核系統（Web版）v1.0" %>

<%@ Register Namespace="Safi.UI" TagPrefix="SafiUI" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Menu ID="Menu1" runat="server" OnMenuItemClick="Menu1_MenuItemClick" Orientation="Horizontal">
        <Items>
            <asp:MenuItem Selected="True" Text="考核部門設定" Value="2"></asp:MenuItem>
            <asp:MenuItem Text="考核部門類別設定" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="2">
        <asp:View ID="View1" runat="server" OnDataBinding="View1_DataBinding">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="D_NO"
                DataSourceID="ObjectDataSource1" Visible="False">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                Text="選取" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="D_NO" HeaderText="代碼" ReadOnly="True" SortExpression="D_NO" />
                    <asp:BoundField DataField="D_NAME" HeaderText="部門名稱" SortExpression="D_NAME" />
                    <asp:BoundField DataField="KEY_DATE" HeaderText="KEY_DATE" SortExpression="KEY_DATE" Visible="False" />
                    <asp:BoundField DataField="KEY_MAN" HeaderText="KEY_MAN" SortExpression="KEY_MAN" Visible="False" />
                    <asp:BoundField DataField="OLD_DEPT" HeaderText="OLD_DEPT" SortExpression="OLD_DEPT" Visible="False" />
                    <asp:BoundField DataField="ADATE" HeaderText="生效日" ReadOnly="True" SortExpression="ADATE" DataFormatString="{0:yyyy/MM/dd}" HtmlEncode="False" />
                    <asp:BoundField DataField="DDATE" HeaderText="失效日" SortExpression="DDATE" DataFormatString="{0:yyyy/MM/dd}" HtmlEncode="False" />
                    <asp:TemplateField HeaderText="部門群組" SortExpression="DEPT_GROUP">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("DEPT_GROUP") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <SafiUI:ExtendedDropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="D_NAME" DataValueField="D_NO" Enabled="False" OnDataBinding="DropDownList1_DataBinding"
                                OnDataBound="DropDownList1_DataBound" SelectedValue='<%# Bind("DEPT_GROUP") %>'>
                            </SafiUI:ExtendedDropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="部門類別" SortExpression="DEPT_CATE">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("DEPT_CATE") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <SafiUI:ExtendedDropDownList ID="DropDownList2" runat="server" DataSourceID="CateObjectDataSource3"
                                DataTextField="dept_cate_desc" DataValueField="dept_cate_id" Enabled="False"
                                OnDataBinding="DropDownList2_DataBinding" OnDataBound="DropDownList2_DataBound"
                                SelectedValue='<%# Bind("DEPT_CATE") %>'>
                                <asp:ListItem Text="True" Value="  "> </asp:ListItem>

                            </SafiUI:ExtendedDropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>

            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
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
            &nbsp; &nbsp; &nbsp;
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="dept_cate_id"
                DataSourceID="CateObjectDataSource3">
                <Columns>
                    <asp:BoundField DataField="dept_cate_id" HeaderText="代碼" ReadOnly="True" SortExpression="dept_cate_id" />
                    <asp:BoundField DataField="dept_cate_desc" HeaderText="名稱" SortExpression="dept_cate_desc" />
                    <asp:BoundField DataField="cate_order" HeaderText="權限" SortExpression="cate_order" />
                    <asp:BoundField DataField="key_date" HeaderText="key_date" SortExpression="key_date"
                        Visible="False" />
                    <asp:BoundField DataField="key_man" HeaderText="key_man" SortExpression="key_man"
                        Visible="False" />
                    <asp:BoundField DataField="adate" HeaderText="adate" SortExpression="adate" Visible="False" />
                    <asp:BoundField DataField="ddate" HeaderText="ddate" SortExpression="ddate" Visible="False" />
                </Columns>
            </asp:GridView>
        </asp:View>
        <asp:View ID="View3" runat="server">
            <table width="100%">
                <tr>
                    <td style="width: 20%; height: 281px;" align="left" valign="top">
                        <fieldset>
                            &nbsp;<asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="重新整理" />
                            <br />
                            <asp:RadioButton ID="RB_DEPT" runat="server" AutoPostBack="True" Checked="True" GroupName="DEPT"
                                OnCheckedChanged="RB_DEPT_CheckedChanged" Text="編制部門" />
                            <br />
                            <asp:RadioButton ID="RB_DEPTM" runat="server" AutoPostBack="True" GroupName="DEPT"
                                OnCheckedChanged="RB_DEPT_CheckedChanged" Text="簽核部門" />
                            <asp:TreeView ID="TreeView1" runat="server" ExpandDepth="3">
                            </asp:TreeView>
                            <asp:Label ID="lb_adate" runat="server"></asp:Label>
                        </fieldset>
                    </td>
                    <td align="left" valign="top" style="width: 808px; height: 281px;">
                        <fieldset>
                            <legend>部門資料</legend>
                            <asp:FormView ID="FormView1" runat="server" DataKeyNames="D_NO" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemInserting="FormView1_ItemInserting" OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating">
                                <EditItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td align="left" style="width: 50%; height: 23px">&nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Update"
                                                Text="儲存資料" /></td>
                                            <td align="right" style="width: 50%; height: 23px">
                                                <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                                    Text="取消" />
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    代碼:
                    <asp:Label ID="D_NOLabel1" runat="server" Text='<%# Bind("D_NO") %>'></asp:Label><br />
                                    部門名稱:
                    <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
                    </asp:TextBox><br />
                                    部門樹：<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DEPT_TREE") %>'></asp:TextBox><br />
                                    生效日:
                    <asp:TextBox ID="ADATETextBox" runat="server" Text='<%# Bind("ADATE", "{0:yyyy/MM/dd}") %>'></asp:TextBox><br />
                                    失效日:
                    <asp:TextBox ID="DDATETextBox" runat="server" Text='<%# Bind("DDATE", "{0:yyyy/MM/dd}") %>'></asp:TextBox><br />
                                    部門群組:
                    <SafiUI:ExtendedDropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                        DataTextField="D_NAME" DataValueField="D_NO" OnDataBinding="DropDownList1_DataBinding"
                        OnDataBound="DropDownList1_DataBound" SelectedValue='<%# Bind("DEPT_GROUP") %>'>
                    </SafiUI:ExtendedDropDownList><br />
                                    部門類別:
                    <SafiUI:ExtendedDropDownList ID="DropDownList2" runat="server" DataSourceID="CateObjectDataSource3"
                        DataTextField="dept_cate_desc" DataValueField="dept_cate_id" OnDataBinding="DropDownList2_DataBinding"
                        OnDataBound="DropDownList2_DataBound" SelectedValue='<%# Bind("DEPT_CATE") %>'>
                    </SafiUI:ExtendedDropDownList><br />

                                </EditItemTemplate>
                                <InsertItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td align="left" style="width: 50%; height: 23px">&nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Insert"
                                                Text="儲存資料" /></td>
                                            <td align="right" style="width: 50%; height: 23px">
                                                <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                                    Text="取消" />
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    代碼:
                    <asp:TextBox ID="D_NOTextBox" runat="server" Text='<%# Bind("D_NO") %>'>
                    </asp:TextBox><br />
                                    部門名稱:
                    <asp:TextBox ID="D_NAMETextBox" runat="server" Text='<%# Bind("D_NAME") %>'>
                    </asp:TextBox><br />
                                    部門樹：<asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DEPT_TREE") %>'></asp:TextBox><br />
                                    生效日:
                    <asp:TextBox ID="ADATETextBox" runat="server" Text='<%# Bind("ADATE") %>'>
                    </asp:TextBox><br />
                                    失效日:
                    <asp:TextBox ID="DDATETextBox" runat="server" Text='<%# Bind("DDATE") %>'>
                    </asp:TextBox><br />
                                    部門群組:
                    <SafiUI:ExtendedDropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                        DataTextField="D_NAME" DataValueField="D_NO" OnDataBinding="DropDownList1_DataBinding"
                        OnDataBound="DropDownList1_DataBound" SelectedValue='<%# Bind("DEPT_GROUP") %>'>
                    </SafiUI:ExtendedDropDownList><br />
                                    部門類別:
                    <SafiUI:ExtendedDropDownList ID="DropDownList2" runat="server" DataSourceID="CateObjectDataSource3"
                        DataTextField="dept_cate_desc" DataValueField="dept_cate_id" OnDataBinding="DropDownList2_DataBinding"
                        OnDataBound="DropDownList2_DataBound" SelectedValue='<%# Bind("DEPT_CATE") %>'>
                    </SafiUI:ExtendedDropDownList><br />

                                </InsertItemTemplate>
                                <ItemTemplate>
                                    <table style="width: 100%">
                                        <tr>
                                            <td align="left" style="width: 50%; height: 23px">
                                                <asp:Button ID="LinkButton4" runat="server" CausesValidation="False" CommandName="Edit"
                                                    Text="編輯資料" /></td>
                                            <td align="right" style="width: 50%; height: 23px">
                                                <asp:Button ID="LinkButton5" runat="server" CausesValidation="False" CommandName="New"
                                                    Text="新增資料" />
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    代碼:
                    <asp:Label ID="D_NOLabel" runat="server" Text='<%# Eval("D_NO") %>'></asp:Label><br />
                                    部門名稱:
                    <asp:Label ID="D_NAMELabel" runat="server" Text='<%# Bind("D_NAME") %>'></asp:Label><br />
                                    生效日:
                    <asp:Label ID="ADATELabel" runat="server" Text='<%# Eval("ADATE", "{0:yyyy/MM/dd}") %>'></asp:Label><br />
                                    失效日:
                    <asp:Label ID="DDATELabel" runat="server" Text='<%# Bind("DDATE", "{0:yyyy/MM/dd}") %>'></asp:Label><br />
                                    部門群組:&nbsp;
                    <SafiUI:ExtendedDropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                        DataTextField="D_NAME" DataValueField="D_NO" OnDataBinding="DropDownList1_DataBinding"
                        OnDataBound="DropDownList1_DataBound" SelectedValue='<%# Bind("DEPT_GROUP") %>' Enabled="False">
                    </SafiUI:ExtendedDropDownList><br />
                                    部門類別:&nbsp;
                    <SafiUI:ExtendedDropDownList ID="DropDownList2" runat="server" DataSourceID="CateObjectDataSource3"
                        DataTextField="dept_cate_desc" DataValueField="dept_cate_id" OnDataBinding="DropDownList2_DataBinding"
                        OnDataBound="DropDownList2_DataBound" SelectedValue='<%# Bind("DEPT_CATE") %>' Enabled="False">
                    </SafiUI:ExtendedDropDownList><br />

                                </ItemTemplate>
                                <EmptyDataTemplate>
                                    <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                                        Text="新增資料" />
                                </EmptyDataTemplate>
                            </asp:FormView>
                            <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                                TypeName="EFFDSTableAdapters.DEPTATableAdapter" UpdateMethod="Update">
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_D_NO" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="D_NAME" Type="String" />
                                    <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                    <asp:Parameter Name="KEY_MAN" Type="String" />
                                    <asp:Parameter Name="OLD_DEPT" Type="String" />
                                    <asp:Parameter Name="DEPT_GROUP" Type="String" />
                                    <asp:Parameter Name="DEPT_TREE" Type="String" />
                                    <asp:Parameter Name="DEPT_CATE" Type="String" />
                                    <asp:Parameter Name="ADATE" Type="DateTime" />
                                    <asp:Parameter Name="DDATE" Type="DateTime" />
                                    <asp:Parameter Name="Original_D_NO" Type="String" />
                                </UpdateParameters>
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="TreeView1" DefaultValue="ttttttttttt" Name="ID"
                                        PropertyName="SelectedValue" Type="String" />
                                </SelectParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="D_NO" Type="String" />
                                    <asp:Parameter Name="D_NAME" Type="String" />
                                    <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                                    <asp:Parameter Name="KEY_MAN" Type="String" />
                                    <asp:Parameter Name="OLD_DEPT" Type="String" />
                                    <asp:Parameter Name="DEPT_GROUP" Type="String" />
                                    <asp:Parameter Name="DEPT_TREE" Type="String" />
                                    <asp:Parameter Name="DEPT_CATE" Type="String" />
                                    <asp:Parameter Name="ADATE" Type="DateTime" />
                                    <asp:Parameter Name="DDATE" Type="DateTime" />
                                </InsertParameters>
                            </asp:ObjectDataSource>
                            <asp:ObjectDataSource ID="CateObjectDataSource3" runat="server" DeleteMethod="Delete"
                                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                TypeName="EFFDSTableAdapters.dept_cateTableAdapter" UpdateMethod="Update">
                                <DeleteParameters>
                                    <asp:Parameter Name="Original_dept_cate_id" Type="String" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:Parameter Name="dept_cate_id" Type="String" />
                                    <asp:Parameter Name="dept_cate_desc" Type="String" />
                                    <asp:Parameter Name="cate_order" Type="Int32" />
                                    <asp:Parameter Name="key_date" Type="DateTime" />
                                    <asp:Parameter Name="key_man" Type="String" />
                                    <asp:Parameter Name="adate" Type="DateTime" />
                                    <asp:Parameter Name="ddate" Type="DateTime" />
                                    <asp:Parameter Name="Original_dept_cate_id" Type="String" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:Parameter Name="dept_cate_id" Type="String" />
                                    <asp:Parameter Name="dept_cate_desc" Type="String" />
                                    <asp:Parameter Name="cate_order" Type="Int32" />
                                    <asp:Parameter Name="key_date" Type="DateTime" />
                                    <asp:Parameter Name="key_man" Type="String" />
                                    <asp:Parameter Name="adate" Type="DateTime" />
                                    <asp:Parameter Name="ddate" Type="DateTime" />
                                </InsertParameters>
                            </asp:ObjectDataSource>
                        </fieldset>
                        <fieldset>
                            <legend>員工資料</legend>

                            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" PageSize="20">
                                <Columns>
                                    <asp:BoundField DataField="NOBR" HeaderText="工號" SortExpression="NOBR" />
                                    <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                                    <asp:BoundField DataField="INDT" DataFormatString="{0:yyyy/MM/dd}" HeaderText="到職日"
                                        HtmlEncode="False" SortExpression="INDT" />
                                    <asp:BoundField DataField="TTSCODE" HeaderText="TTSCODE" SortExpression="TTSCODE"
                                        Visible="False" />
                                    <asp:BoundField DataField="DEPT" HeaderText="DEPT" SortExpression="DEPT" Visible="False" />
                                    <asp:BoundField DataField="DEPTS" HeaderText="DEPTS" SortExpression="DEPTS" Visible="False" />
                                    <asp:CheckBoxField DataField="MANG" HeaderText="主管職" SortExpression="MANG" />
                                    <asp:CheckBoxField DataField="MANGE" HeaderText="MANGE" SortExpression="MANGE" Visible="False" />
                                    <asp:BoundField DataField="JOB" HeaderText="JOB" SortExpression="JOB" Visible="False" />
                                    <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />

                                    <asp:BoundField DataField="JOBS" HeaderText="JOBS" SortExpression="JOBS" Visible="False" />
                                    <asp:BoundField DataField="JOBSNAME" HeaderText="職系" SortExpression="JOBSNAME" />
                                    <asp:BoundField DataField="JOBL" HeaderText="JOBL" SortExpression="JOBL" Visible="False" />
                                    <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" />
                                    <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
                                    <asp:BoundField DataField="DEPTSNAME" HeaderText="DEPTSNAME" SortExpression="DEPTSNAME"
                                        Visible="False" />
                                    <asp:BoundField DataField="DEPTM" HeaderText="考核部門" SortExpression="DEPTM" Visible="False" />
                                    <asp:BoundField DataField="cate_order" HeaderText="cate_order" SortExpression="cate_order"
                                        Visible="False" />
                                    <asp:BoundField DataField="PASSWORD" HeaderText="PASSWORD" SortExpression="PASSWORD"
                                        Visible="False" />
                                    <asp:BoundField DataField="EMAIL" HeaderText="EMAIL" SortExpression="EMAIL" Visible="False" />
                                    <asp:BoundField DataField="BIRDT" HeaderText="BIRDT" SortExpression="BIRDT" Visible="False" />
                                    <asp:BoundField DataField="DI" HeaderText="直間接" SortExpression="DI" />
                                </Columns>
                                <EmptyDataTemplate>
                                    <span style="color: #ff0033">※無相關員工資料！</span>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </fieldset>
                        <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetDataByDeptMNowDate" TypeName="EFFDSTableAdapters.EMPINFOTableAdapter">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="TreeView1" DefaultValue=" " Name="depta" PropertyName="SelectedValue"
                                    Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                        <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" OldValuesParameterFormatString="original_{0}"
                            SelectMethod="GetDataByDept" TypeName="EFFDSTableAdapters.EMPINFOTableAdapter">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lb_adate" Name="adate" PropertyName="Text" Type="String" />
                                <asp:ControlParameter ControlID="TreeView1" Name="dept" PropertyName="SelectedValue"
                                    Type="String" />
                            </SelectParameters>
                        </asp:ObjectDataSource>
                    </td>
                </tr>
            </table>
        </asp:View>
    </asp:MultiView>
</asp:Content>
