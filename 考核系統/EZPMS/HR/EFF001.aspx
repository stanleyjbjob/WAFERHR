<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true"
    CodeFile="EFF001.aspx.cs" Inherits="HR_EFF001" Title="績效考核系統" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal">
        <Items>
            <asp:MenuItem Text="考核評估種類維護" Value="新增項目" Selected="true"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h5>考核評估種類資料設定</h5>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <fieldset>
                <legend>考核評估種類</legend>
                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="type" DataSourceID="ObjectDataSource1">
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="type" HeaderText="代碼" ReadOnly="True" SortExpression="type" />
                        <asp:BoundField DataField="typeName" HeaderText="種類名稱" SortExpression="typeName" />
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
                    TypeName="EFFDSTableAdapters.EFFS_TYPETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_type" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="type" Type="String" />
                        <asp:Parameter Name="typeName" Type="String" />
                        <asp:Parameter Name="Original_type" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="type" Type="String" />
                        <asp:Parameter Name="typeName" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
             <fieldset>
                <legend>考核評估種類維護</legend>
                 <asp:FormView ID="FormView1" runat="server" DataKeyNames="type" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated">
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
                         <asp:Label ID="typeLabel1" runat="server" Text='<%# Bind("type") %>'></asp:Label><br />
                         種類名稱：
                         <asp:TextBox ID="typeNameTextBox" runat="server" Text='<%# Bind("typeName") %>'></asp:TextBox>
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
                         <asp:TextBox ID="typeTextBox" runat="server" Text='<%# Bind("type") %>'></asp:TextBox><br />
                         儲存資料：
                         <asp:TextBox ID="typeNameTextBox" runat="server" Text='<%# Bind("typeName") %>'></asp:TextBox>
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
                         <asp:Label ID="typeLabel" runat="server" Text='<%# Eval("type") %>'></asp:Label><br />
                         種類名稱：
                         <asp:Label ID="typeNameLabel" runat="server" Text='<%# Bind("typeName") %>'></asp:Label><br />
                         &nbsp;&nbsp;
                     </ItemTemplate>
                 </asp:FormView>
                 <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                     InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                     TypeName="EFFDSTableAdapters.EFFS_TYPETableAdapter" UpdateMethod="Update">
                     <DeleteParameters>
                         <asp:Parameter Name="Original_type" Type="String" />
                     </DeleteParameters>
                     <UpdateParameters>
                         <asp:Parameter Name="type" Type="String" />
                         <asp:Parameter Name="typeName" Type="String" />
                         <asp:Parameter Name="Original_type" Type="String" />
                     </UpdateParameters>
                     <SelectParameters>
                         <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                             Type="String" DefaultValue="&quot;&quot;" />
                     </SelectParameters>
                     <InsertParameters>
                         <asp:Parameter Name="type" Type="String" />
                         <asp:Parameter Name="typeName" Type="String" />
                     </InsertParameters>
                 </asp:ObjectDataSource>
                 &nbsp;
                
                </fieldset>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <fieldset>
                <legend>xxx</legend>
                contet
            </fieldset>
        </asp:View>
    </asp:MultiView>
</asp:Content>
