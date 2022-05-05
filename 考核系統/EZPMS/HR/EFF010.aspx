<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF010.aspx.cs" Inherits="HR_EFF010" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem Selected="true" Text="個人訓練需求類別資料維護" Value="0"></asp:MenuItem>
            <asp:MenuItem  Text="個人訓練需求資料維護" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>訓練需求類別</legend>
        <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
            AutoGenerateColumns="False" DataKeyNames="eduCateID" DataSourceID="ObjectDataSource1"
            PageSize="5">
            <Columns>
                <asp:TemplateField ShowHeader="False">
                    <ItemTemplate>
                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                            Text="選取" />
                    </ItemTemplate>
                </asp:TemplateField>
                <asp:BoundField DataField="eduCateID" HeaderText="代碼" ReadOnly="True" SortExpression="eduCateID" />
                <asp:BoundField DataField="cateName" HeaderText="類別名稱" SortExpression="cateName" />
                <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
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
            TypeName="EFFDSTableAdapters.EFFS_EDUCATETableAdapter">
            <DeleteParameters>
                <asp:Parameter Name="Original_eduCateID" Type="String" />
            </DeleteParameters>
            <InsertParameters>
                <asp:Parameter Name="eduCateID" Type="String" />
                <asp:Parameter Name="cateName" Type="String" />
                <asp:Parameter Name="Order" Type="Int32" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </fieldset>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <fieldset>
                <legend>訓練需求類別維護</legend>
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="eduCateID" DataSourceID="ObjectDataSource2"
                    OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated">
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
                        <asp:Label ID="typeLabel1" runat="server" Text='<%# Bind("eduCateID") %>'></asp:Label><br />
                        類別名稱：
                        <asp:TextBox ID="typeNameTextBox" runat="server" Text='<%# Bind("cateName") %>'></asp:TextBox>
                          排序：
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("order") %>'></asp:TextBox>
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
                        <asp:TextBox ID="typeTextBox" runat="server" Text='<%# Bind("eduCateID") %>'></asp:TextBox><br />
                        類別名稱：
                        <asp:TextBox ID="typeNameTextBox" runat="server" Text='<%# Bind("cateName") %>'></asp:TextBox>
                        <br />
                          排序：
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("order") %>'></asp:TextBox>
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
                        <asp:Label ID="typeLabel" runat="server" Text='<%# Eval("eduCateID") %>'></asp:Label><br />
                        類別名稱：
                        <asp:Label ID="typeNameLabel" runat="server" Text='<%# Bind("cateName") %>'></asp:Label><br />
                        排序：
                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("order") %>'></asp:Label><br />
                    </ItemTemplate>
                     <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_EDUCATETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_eduCateID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="eduCateID" Type="String" />
                        <asp:Parameter Name="cateName" Type="String" />
                        <asp:Parameter Name="Order" Type="Int32" />
                        <asp:Parameter Name="Original_eduCateID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="&quot;&quot;" Name="ID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="eduCateID" Type="String" />
                        <asp:Parameter Name="cateName" Type="String" />
                        <asp:Parameter Name="Order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                &nbsp;
            </fieldset>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="eduCateItemID"
                DataSourceID="ObjectDataSource3">
                
                <Columns>
                                <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                    <asp:BoundField DataField="eduCateItemID" HeaderText="代碼" ReadOnly="True"
                        SortExpression="eduCateItemID" />
                    <asp:BoundField DataField="eduCateID" HeaderText="eduCateID" SortExpression="eduCateID" Visible="False" />
                    <asp:BoundField DataField="CateItemName" HeaderText="訓練項目" SortExpression="eduCateItemID" />
                     <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" DeleteMethod="Delete"
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                TypeName="EFFDSTableAdapters.EFFS_EDUCATEITEMTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="eduCateItemID" Type="String" />
                    <asp:Parameter Name="eduCateID" Type="String" />
                    <asp:Parameter Name="CateItemName" Type="String" />
                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" DefaultValue="''" Name="cateID" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="eduCateItemID" Type="String" />
                    <asp:Parameter Name="eduCateID" Type="String" />
                    <asp:Parameter Name="CateItemName" Type="String" />
                </InsertParameters>
            </asp:ObjectDataSource>
            <asp:FormView ID="FormView2" runat="server" DataKeyNames="eduCateItemID" DataSourceID="ObjectDataSource4" OnItemInserted="FormView2_ItemInserted" OnItemUpdated="FormView2_ItemUpdated">
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
                    <asp:Label ID="eduCateItemIDLabel1" runat="server" Text='<%# Eval("eduCateItemID") %>'></asp:Label><br />
                    類別：
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                        DataTextField="cateName" DataValueField="eduCateID" SelectedValue='<%# Bind("eduCateID") %>'>
                    </asp:DropDownList><br />
                    訓練項目：
                    <asp:TextBox ID="CateItemNameTextBox" runat="server" Text='<%# Bind("CateItemName") %>'></asp:TextBox><br />
                
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
                    <asp:TextBox ID="eduCateItemIDTextBox" runat="server" Text='<%# Bind("eduCateItemID") %>'></asp:TextBox><br />
                    類別：
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                        DataTextField="cateName" DataValueField="eduCateID" SelectedValue='<%# Bind("eduCateID") %>'>
                    </asp:DropDownList><br />
                    訓練項目：
                    <asp:TextBox ID="CateItemNameTextBox" runat="server" Text='<%# Bind("CateItemName") %>'></asp:TextBox><br />
                    
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
                    <asp:Label ID="eduCateItemIDLabel" runat="server" Text='<%# Eval("eduCateItemID") %>'></asp:Label><br />
                    類別: &nbsp;
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                        DataTextField="cateName" DataValueField="eduCateID" SelectedValue='<%# Bind("eduCateID") %>'>
                    </asp:DropDownList><br />
                    訓練項目名稱:
                    <asp:Label ID="CateItemNameLabel" runat="server" Text='<%# Bind("CateItemName") %>'></asp:Label><br />
                  
                </ItemTemplate>
                 <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
            </asp:FormView>
            <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" DeleteMethod="Delete"
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                TypeName="EFFDSTableAdapters.EFFS_EDUCATEITEMTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="eduCateItemID" Type="String" />
                    <asp:Parameter Name="eduCateID" Type="String" />
                    <asp:Parameter Name="CateItemName" Type="String" />
                    <asp:Parameter Name="Original_eduCateItemID" Type="String" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView2" DefaultValue="''" Name="ID" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="eduCateItemID" Type="String" />
                    <asp:Parameter Name="eduCateID" Type="String" />
                    <asp:Parameter Name="CateItemName" Type="String" />
                </InsertParameters>
            </asp:ObjectDataSource>
        </asp:View>
    </asp:MultiView>
</asp:Content>

