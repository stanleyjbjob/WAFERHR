<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF005.aspx.cs" Inherits="HR_EFF005" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem Text="考核群組及簽核權限設定" Value="0" Selected="true"></asp:MenuItem>
            <asp:MenuItem Text="考核群組及簽核權限明細設定" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>考核群組及簽核權限設定</h5>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="effsgroupID,type"
        DataSourceID="ObjectDataSource1" AllowPaging="True" PageSize="5">
        <Columns>
         <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>     
            <asp:BoundField DataField="effsgroupID" HeaderText="代碼" ReadOnly="True"
                SortExpression="effsgroupID" />
            <asp:BoundField DataField="effsgroupname" HeaderText="代碼名稱" SortExpression="effsgroupname" />
            <asp:BoundField DataField="effsgroup" HeaderText="effsgroup" SortExpression="effsgroup" Visible="False"/>
            <asp:CheckBoxField DataField="ismangRate" HeaderText="ismangRate" SortExpression="ismangRate" Visible="False" />
            <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
            <asp:TemplateField HeaderText="類別" SortExpression="type">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("type") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    <asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("type") %>' Enabled="False">
                        <asp:ListItem Value="jobl">職等</asp:ListItem>
                        <asp:ListItem Value="jobs">職系</asp:ListItem>
                    </asp:DropDownList>
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
    <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.JOBLTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.JOBSTableAdapter"></asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="EFFDSTableAdapters.EFFS_GROUPTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_effsgroupID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="effsgroupID" Type="String" />
            <asp:Parameter Name="effsgroupname" Type="String" />
            <asp:Parameter Name="effsgroup" Type="String" />
            <asp:Parameter Name="ismangRate" Type="Boolean" />
            <asp:Parameter Name="order" Type="Int32" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="Original_effsgroupID" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="effsgroupID" Type="String" />
            <asp:Parameter Name="effsgroupname" Type="String" />
            <asp:Parameter Name="effsgroup" Type="String" />
            <asp:Parameter Name="ismangRate" Type="Boolean" />
            <asp:Parameter Name="order" Type="Int32" />
            <asp:Parameter Name="type" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
<asp:MultiView id="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <fieldset>
                <legend>考核群組及簽核權限設定</legend>&nbsp;
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="effsgroupID" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated">
                    <EditItemTemplate>
                     <table style="width: 100%">
                             <tr>
                                 <td align="left" style="width: 50%; height: 23px">
                                     &nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Update"
                                         Text="儲存資料" /></td>
                                 <td align="right" style="width: 50%; height: 23px">
                                     <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                         Text="取消" />
                                 </td>
                             </tr>
                         </table>
                         <hr />       
                        代碼：
                        <asp:Label ID="effsgroupIDLabel1" runat="server" Text='<%# Bind("effsgroupID") %>'>
                        </asp:Label><br />
                        名稱：
                        <asp:TextBox ID="effsgroupnameTextBox" runat="server" Text='<%# Bind("effsgroupname") %>'>
                        </asp:TextBox><br />
                        <asp:TextBox ID="effsgroupTextBox" runat="server" Text='<%# Bind("effsgroup") %>' Visible="false">
                        </asp:TextBox>
                        
                        <asp:CheckBox ID="ismangRateCheckBox" runat="server" Checked='<%# Bind("ismangRate") %>' Visible="false" />
                        排序：
                        <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
                        </asp:TextBox><br />
                        類別：<asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("type") %>'>
                            <asp:ListItem Value="jobl">職等</asp:ListItem>
                            <asp:ListItem Value="jobs">職系</asp:ListItem>
                        </asp:DropDownList><br />
                    
                    </EditItemTemplate>
                    <InsertItemTemplate>
                      <table style="width: 100%">
                             <tr>
                                 <td align="left" style="width: 50%; height: 23px">
                                     &nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Insert"
                                         Text="儲存資料" /></td>
                                 <td align="right" style="width: 50%; height: 23px">
                                     <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                         Text="取消" />
                                 </td>
                             </tr>
                         </table>
                         <hr />     
                         代碼：
                        <asp:TextBox ID="effsgroupIDTextBox" runat="server" Text='<%# Bind("effsgroupID") %>'>
                        </asp:TextBox><br />
                        名稱：
                        <asp:TextBox ID="effsgroupnameTextBox" runat="server" Text='<%# Bind("effsgroupname") %>'>
                        </asp:TextBox><br />
                        <asp:TextBox ID="effsgroupTextBox" runat="server" Text='<%# Bind("effsgroup") %>' Visible="false">
                        </asp:TextBox>
                        
                        <asp:CheckBox ID="ismangRateCheckBox" runat="server" Checked='<%# Bind("ismangRate") %>' Visible="false" />
                        排序：
                        <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
                        </asp:TextBox><br />
                        類別：<asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("type") %>'>
                            <asp:ListItem Value="jobl">職等</asp:ListItem>
                            <asp:ListItem Value="jobs">職系</asp:ListItem>
                        </asp:DropDownList><br />
                    </InsertItemTemplate>
                     <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
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
                        代碼：
                        <asp:Label ID="effsgroupIDLabel" runat="server" Text='<%# Eval("effsgroupID") %>'>
                        </asp:Label><br />
                        名稱：
                        <asp:Label ID="effsgroupnameLabel" runat="server" Text='<%# Bind("effsgroupname") %>'>
                        </asp:Label><br />
                       
                        排序：
                        <asp:Label ID="orderLabel" runat="server" Text='<%# Bind("order") %>'></asp:Label><br />
                        類別：&nbsp;<asp:DropDownList ID="DropDownList1" runat="server" SelectedValue='<%# Bind("type") %>' Enabled="False">
                            <asp:ListItem Value="jobl">職等</asp:ListItem>
                            <asp:ListItem Value="jobs">職系</asp:ListItem>
                        </asp:DropDownList><br />
                        
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_GROUPTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effsgroupID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="effsgroupname" Type="String" />
                        <asp:Parameter Name="effsgroup" Type="String" />
                        <asp:Parameter Name="ismangRate" Type="Boolean" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="type" Type="String" />
                        <asp:Parameter Name="Original_effsgroupID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="0" Name="id" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="effsgroupname" Type="String" />
                        <asp:Parameter Name="effsgroup" Type="String" />
                        <asp:Parameter Name="ismangRate" Type="Boolean" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="type" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <fieldset>
                <legend>考核群組及簽核權限明細設定</legend>&nbsp;
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                    DataSourceID="ObjectDataSource3">
                    <Columns>
                    <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                        <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                            SortExpression="autoKey" Visible="False" />
                        <asp:BoundField DataField="effsgroupID" SortExpression="effsgroupID" Visible="False" />
                        <asp:BoundField DataField="jobl" HeaderText="群組明細名稱" SortExpression="jobl" />
                        <asp:BoundField DataField="DeptOrder" HeaderText="權限" SortExpression="DeptOrder" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCate"
                    TypeName="EFFDSTableAdapters.EFFS_GROUPITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="DeptOrder" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="0" Name="Cate" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="DeptOrder" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView2" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource4" OnDataBinding="FormView2_DataBinding" OnItemInserted="FormView2_ItemInserted" OnItemUpdated="FormView2_ItemUpdated">
                    <EditItemTemplate>
                    <table style="width: 100%">
                             <tr>
                                 <td align="left" style="width: 50%; height: 23px">
                                     &nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Update"
                                         Text="儲存資料" /></td>
                                 <td align="right" style="width: 50%; height: 23px">
                                     <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                         Text="取消" />
                                 </td>
                             </tr>
                         </table>
                         <hr />       
                      
                        <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>' Visible="false"></asp:Label>
                        群組：
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="effsgroupname" DataValueField="effsgroupID" SelectedValue='<%# Bind("effsgroupID") %>'>
                        </asp:DropDownList><br />
                        群組明細名稱：
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("jobl") %>' Width="83px"></asp:TextBox><br />
                        權限：
                        <asp:TextBox ID="DeptOrderTextBox" runat="server" Text='<%# Bind("DeptOrder") %>'>
                        </asp:TextBox><br />
                     
                    </EditItemTemplate>
                    <InsertItemTemplate>
                       <table style="width: 100%">
                             <tr>
                                 <td align="left" style="width: 50%; height: 23px">
                                     &nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Insert"
                                         Text="儲存資料" /></td>
                                 <td align="right" style="width: 50%; height: 23px">
                                     <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                         Text="取消" />
                                 </td>
                             </tr>
                         </table>
                         <hr />    
                         群組：
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="effsgroupname" DataValueField="effsgroupID" SelectedValue='<%# Bind("effsgroupID") %>'>
                        </asp:DropDownList><br />
                          群組明細名稱：
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("jobl") %>' Width="83px"></asp:TextBox><br />
                      權限：
                        <asp:TextBox ID="DeptOrderTextBox" runat="server" Text='<%# Bind("DeptOrder") %>'>
                        </asp:TextBox><br />
                       
                    </InsertItemTemplate>
                     <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
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
                       
                        群組：&nbsp;<asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="effsgroupname" DataValueField="effsgroupID" SelectedValue='<%# Bind("effsgroupID") %>' Enabled="false">
                        </asp:DropDownList><br />
                        群組明細名稱：&nbsp;
                        <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("jobl") %>' Width="83px"></asp:TextBox><br />
                        權限：
                        <asp:Label ID="DeptOrderLabel" runat="server" Text='<%# Bind("DeptOrder") %>'></asp:Label><br />
                       
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_GROUPITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="DeptOrder" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView2" DefaultValue="0" Name="ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="DeptOrder" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
    </asp:MultiView>
</asp:Content>

