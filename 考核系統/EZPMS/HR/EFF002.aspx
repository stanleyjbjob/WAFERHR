<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF002.aspx.cs" Inherits="HR_EFF002" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem Text="考核項目" Value="0" Selected="true"></asp:MenuItem>
            <asp:MenuItem Text="考核項目明細" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>考核項目資料設定</h5>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="effcateID" DataSourceID="ObjectDataSource1" PageSize="5">
                    <Columns>
                          <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        
                        <asp:BoundField DataField="effcateID" HeaderText="代碼" ReadOnly="True" SortExpression="effcateID" />
                        <asp:BoundField DataField="effcateName" HeaderText="名稱" SortExpression="effcateName" />
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
                    TypeName="EFFDSTableAdapters.EFFS_CATETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effcateID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effcateName" Type="String" />
                        <asp:Parameter Name="Original_effcateID" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effcateName" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
<asp:MultiView id="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
                <fieldset>
                <legend>考核項目資料維護</legend>
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="effcateID" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated">
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
                        代碼:
                        <asp:Label ID="effcateIDLabel1" runat="server" Text='<%# Bind("effcateID") %>'></asp:Label><br />
                        名稱:
                        <asp:TextBox ID="effcateNameTextBox" runat="server" Text='<%# Bind("effcateName") %>'>
                        </asp:TextBox>
                      
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
                        代碼:
                        <asp:TextBox ID="effcateIDTextBox" runat="server" Text='<%# Bind("effcateID") %>'>
                        </asp:TextBox><br />
                        名稱:
                        <asp:TextBox ID="effcateNameTextBox" runat="server" Text='<%# Bind("effcateName") %>'>
                        </asp:TextBox>
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
                        <asp:Label ID="effcateIDLabel" runat="server" Text='<%# Eval("effcateID") %>'></asp:Label><br />
                        名稱:
                        <asp:Label ID="effcateNameLabel" runat="server" Text='<%# Bind("effcateName") %>'>
                        </asp:Label>
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_CATETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effcateID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effcateName" Type="String" />
                        <asp:Parameter Name="Original_effcateID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                            Type="String" DefaultValue="&quot;&quot;" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effcateName" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                </fieldset>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <fieldset>
                <legend>考核項目明細維護</legend>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="effsID"
                    DataSourceID="ObjectDataSource4">
                    <Columns>
                     <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="effsID" HeaderText="代碼" ReadOnly="True" SortExpression="effsID" />
                        <asp:BoundField DataField="effcateID" HeaderText="effcateID" SortExpression="effcateID"
                            Visible="False" />
                        <asp:BoundField DataField="effsName" HeaderText="細目名稱" SortExpression="effsName" />
                            <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCate"
                    TypeName="EFFDSTableAdapters.EFFS_CATEITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effsID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effsID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effsName" Type="String" />
                        <asp:Parameter Name="Original_effsID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="cate" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effsID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effsName" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView2" runat="server" DataKeyNames="effsID" DataSourceID="ObjectDataSource5" OnItemInserted="FormView2_ItemInserted" OnItemUpdated="FormView2_ItemUpdated">
                                         <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
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
                        <asp:Label ID="effsIDLabel1" runat="server" Text='<%# Bind("effsID") %>'></asp:Label><br />
                        類別：
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>'>
                        </asp:DropDownList><br />
                        細目名稱：
                        <asp:TextBox ID="effsNameTextBox" runat="server" Text='<%# Bind("effsName") %>' Rows="3" TextMode="MultiLine" Width="500px"></asp:TextBox><br />
                     
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
                        代碼；:
                        <asp:TextBox ID="effsIDTextBox" runat="server" Text='<%# Bind("effsID") %>'>
                        </asp:TextBox><br />
                        類別：
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>'>
                        </asp:DropDownList><br />
                        細目名稱：
                        <asp:TextBox ID="effsNameTextBox" runat="server" Rows="3" Text='<%# Bind("effsName") %>'
                            TextMode="MultiLine" Width="500px"></asp:TextBox><br />
                       
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
                        <asp:Label ID="effsIDLabel" runat="server" Text='<%# Eval("effsID") %>'></asp:Label><br />
                        類別：
                        <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>' Enabled="False">
                        </asp:DropDownList><br />
                        細目名稱：
                        <asp:Label ID="effsNameLabel" runat="server" Text='<%# Bind("effsName") %>'></asp:Label><br />
                     
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBy"
                    TypeName="EFFDSTableAdapters.EFFS_CATEITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effsID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effsID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effsName" Type="String" />
                        <asp:Parameter Name="Original_effsID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView3" DefaultValue="&quot;&quot;" Name="ID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effsID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="effsName" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
    </asp:MultiView>
</asp:Content>

