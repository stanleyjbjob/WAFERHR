<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF003.aspx.cs" Inherits="HR_EFF003" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem Text="評量抬頭" Value="0" Selected="true"></asp:MenuItem>
            <asp:MenuItem Text="評量抬頭明細" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>考核評量抬頭設定</h5>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="titleID"
        DataSourceID="ObjectDataSource1">
        <Columns>
         <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>       
            <asp:BoundField DataField="titleID" HeaderText="代碼" ReadOnly="True" SortExpression="titleID" />
            <asp:BoundField DataField="titleDesc" HeaderText="名稱" SortExpression="titleDesc" />
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
        TypeName="EFFDSTableAdapters.EFFS_TITLETableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_titleID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="titleID" Type="String" />
            <asp:Parameter Name="titleDesc" Type="String" />
            <asp:Parameter Name="Original_titleID" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="titleID" Type="String" />
            <asp:Parameter Name="titleDesc" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
<asp:MultiView id="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <fieldset>
                <legend>考核評量抬頭設定</legend>
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="titleID" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemInserting="FormView1_ItemInserting" OnItemUpdated="FormView1_ItemUpdated">
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
                        <asp:Label ID="titleIDLabel1" runat="server" Text='<%# Bind("titleID") %>'></asp:Label><br />
                        名稱：
                        <asp:TextBox ID="titleDescTextBox" runat="server" Text='<%# Bind("titleDesc") %>'>
                        </asp:TextBox><br />
                   
                    </EditItemTemplate>
                                         <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
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
                        <asp:TextBox ID="titleIDTextBox" runat="server" Text='<%# Bind("titleID") %>'>
                        </asp:TextBox><br />
                        名稱：
                        <asp:TextBox ID="titleDescTextBox" runat="server" Text='<%# Bind("titleDesc") %>'>
                        </asp:TextBox><br />
                      
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
                        代碼：
                        <asp:Label ID="titleIDLabel" runat="server" Text='<%# Eval("titleID") %>'></asp:Label><br />
                        名稱：
                        <asp:Label ID="titleDescLabel" runat="server" Text='<%# Bind("titleDesc") %>'></asp:Label><br />
                     
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_TITLETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_titleID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="titleDesc" Type="String" />
                        <asp:Parameter Name="Original_titleID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="&quot;&quot;" Name="ID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="titleDesc" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <fieldset>
                <legend>考核評量抬頭明細設定</legend>
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
                            SortExpression="autoKey"  Visible ="false"/>
                        <asp:BoundField DataField="titleID" HeaderText="titleID" SortExpression="titleID" Visible="false" />
                        <asp:BoundField DataField="title" HeaderText="名稱" SortExpression="title" />
                        <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
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
                    TypeName="EFFDSTableAdapters.EFFS_TITLEITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="title" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="&quot;&quot;" Name="cate"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="title" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView2" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource4" OnItemInserted="FormView2_ItemInserted" OnItemUpdated="FormView2_ItemUpdated">
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
                    
                        <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>' Visible="false"></asp:Label><br />
                        類別：
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="titleDesc" DataValueField="titleID" SelectedValue='<%# Bind("titleID") %>'>
                        </asp:DropDownList><br />
                        名稱：
                        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>'>
                        </asp:TextBox><br />
                        排序：
                        <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
                        </asp:TextBox><br />
                   
                    </EditItemTemplate>
                                         <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
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
                        類別:
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="titleDesc" DataValueField="titleID" SelectedValue='<%# Bind("titleID") %>'>
                        </asp:DropDownList><br />
                        名稱:
                        <asp:TextBox ID="titleTextBox" runat="server" Text='<%# Bind("title") %>'>
                        </asp:TextBox><br />
                        排序:
                        <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
                        </asp:TextBox><br />
                      
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
                       
                        <asp:Label ID="autoKeyLabel" runat="server" Text='<%# Eval("autoKey") %>'　Visible="false"></asp:Label><br />
                        類別：
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="titleDesc" DataValueField="titleID" Enabled="False" SelectedValue='<%# Bind("titleID") %>'>
                        </asp:DropDownList><br />
                        名稱：
                        <asp:Label ID="titleLabel" runat="server" Text='<%# Bind("title") %>'></asp:Label><br />
                        排序：
                        <asp:Label ID="orderLabel" runat="server" Text='<%# Bind("order") %>'></asp:Label><br />
                      
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_TITLEITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="title" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView2" DefaultValue="0" Name="ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="title" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
    </asp:MultiView>
</asp:Content>

