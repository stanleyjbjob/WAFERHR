<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF004.aspx.cs" Inherits="HR_EFF004" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem Text="考核評等資料及強迫分配設定" Value="0" Selected="true"></asp:MenuItem>
            <asp:MenuItem Text="考核評等資料及強迫分配明細設定" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>考核評等資料及強迫分配設定</h5>
    <asp:GridView ID="GridView1" runat="server" AllowPaging="True" AllowSorting="True"
        AutoGenerateColumns="False" DataKeyNames="numID" DataSourceID="ObjectDataSource1">
        <Columns>
        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField> 
            <asp:BoundField DataField="numID" HeaderText="代碼" ReadOnly="True" SortExpression="numID" />
            <asp:BoundField DataField="numDesc" HeaderText="名稱" SortExpression="numDesc" />
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
        TypeName="EFFDSTableAdapters.EFFS_NUMTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_numID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="numID" Type="String" />
            <asp:Parameter Name="numDesc" Type="String" />
            <asp:Parameter Name="Original_numID" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="numID" Type="String" />
            <asp:Parameter Name="numDesc" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
<asp:MultiView id="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <fieldset>
                <legend>考核評等資料及強迫分配設定</legend>
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="numID" DataSourceID="ObjectDataSource2"
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
                        <asp:Label ID="numIDLabel1" runat="server" Text='<%# Bind("numID") %>'></asp:Label><br />
                        名稱：
                        <asp:TextBox ID="numDescTextBox" runat="server" Text='<%# Bind("numDesc") %>'>
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
                        代碼：
                        <asp:TextBox ID="numIDTextBox" runat="server" Text='<%# Bind("numID") %>'>
                        </asp:TextBox><br />
                        名稱：
                        <asp:TextBox ID="numDescTextBox" runat="server" Text='<%# Bind("numDesc") %>'>
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
                        代碼：
                        <asp:Label ID="numIDLabel" runat="server" Text='<%# Eval("numID") %>'></asp:Label><br />
                        名稱：
                        <asp:Label ID="numDescLabel" runat="server" Text='<%# Bind("numDesc") %>'></asp:Label><br />
                        
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_NUMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_numID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="numID" Type="String" />
                        <asp:Parameter Name="numDesc" Type="String" />
                        <asp:Parameter Name="Original_numID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="&quot;&quot;" Name="ID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="numID" Type="String" />
                        <asp:Parameter Name="numDesc" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <fieldset>
                <legend>考核評等資料及強迫分配明細設定</legend>
                <asp:GridView ID="GridView2" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="autoKey" DataSourceID="ObjectDataSource3">
                    <Columns>
                  <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField> 
                        <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                            SortExpression="autoKey" Visible="false" />
                        <asp:BoundField DataField="numID" HeaderText="numID" SortExpression="numID" Visible="false" />
                        <asp:BoundField DataField="numName" HeaderText="名稱" SortExpression="numName" />
                        <asp:BoundField DataField="minNum" HeaderText="最低分" SortExpression="minNum" />
                        <asp:BoundField DataField="maxNum" HeaderText="最高分" SortExpression="maxNum" />
                        <asp:BoundField DataField="minRate" HeaderText="最低％" SortExpression="minRate" />
                        <asp:BoundField DataField="maxRate" HeaderText="最高％" SortExpression="maxRate" />
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
                    TypeName="EFFDSTableAdapters.EFFS_NUMITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="numID" Type="String" />
                        <asp:Parameter Name="numName" Type="String" />
                        <asp:Parameter Name="minNum" Type="Decimal" />
                        <asp:Parameter Name="maxNum" Type="Decimal" />
                        <asp:Parameter Name="minRate" Type="Decimal" />
                        <asp:Parameter Name="maxRate" Type="Decimal" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="&quot;&quot;" Name="Cate"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="numID" Type="String" />
                        <asp:Parameter Name="numName" Type="String" />
                        <asp:Parameter Name="minNum" Type="Decimal" />
                        <asp:Parameter Name="maxNum" Type="Decimal" />
                        <asp:Parameter Name="minRate" Type="Decimal" />
                        <asp:Parameter Name="maxRate" Type="Decimal" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView2" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource4"
                    OnItemInserted="FormView2_ItemInserted" OnItemUpdated="FormView2_ItemUpdated">
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
                        類別：<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="numDesc" DataValueField="numID" SelectedValue='<%# Bind("numID") %>'>
                            </asp:DropDownList>
                   　　　<br />
                        名稱：
                        <asp:TextBox ID="numNameTextBox" runat="server" Text='<%# Bind("numName") %>'>
                        </asp:TextBox><br />
                        最低分：
                        <asp:TextBox ID="minNumTextBox" runat="server" Text='<%# Bind("minNum") %>'>
                        </asp:TextBox><br />
                        最高分：
                        <asp:TextBox ID="maxNumTextBox" runat="server" Text='<%# Bind("maxNum") %>'>
                        </asp:TextBox><br />
                        最低％：
                        <asp:TextBox ID="minRateTextBox" runat="server" Text='<%# Bind("minRate") %>'>
                        </asp:TextBox><br />
                        最高％：
                        <asp:TextBox ID="maxRateTextBox" runat="server" Text='<%# Bind("maxRate") %>'>
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
                       類別：<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="numDesc" DataValueField="numID" SelectedValue='<%# Bind("numID") %>'>
                            </asp:DropDownList>
                   　　　<br />
                        名稱：
                        <asp:TextBox ID="numNameTextBox" runat="server" Text='<%# Bind("numName") %>'>
                        </asp:TextBox><br />
                        最低分：
                        <asp:TextBox ID="minNumTextBox" runat="server" Text='<%# Bind("minNum") %>'>
                        </asp:TextBox><br />
                        最高分：
                        <asp:TextBox ID="maxNumTextBox" runat="server" Text='<%# Bind("maxNum") %>'>
                        </asp:TextBox><br />
                        最低％：
                        <asp:TextBox ID="minRateTextBox" runat="server" Text='<%# Bind("minRate") %>'>
                        </asp:TextBox><br />
                        最高％：
                        <asp:TextBox ID="maxRateTextBox" runat="server" Text='<%# Bind("maxRate") %>'>
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
                        
                        <asp:Label ID="autoKeyLabel" runat="server" Text='<%# Eval("autoKey") %>' Visible="false"></asp:Label><br />
                         類別：<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                            DataTextField="numDesc" DataValueField="numID" SelectedValue='<%# Bind("numID") %>' Enabled="false">
                            </asp:DropDownList><br />
                        名稱：
                        <asp:Label ID="numNameLabel" runat="server" Text='<%# Bind("numName") %>'></asp:Label><br />
                        最低分：
                        <asp:Label ID="minNumLabel" runat="server" Text='<%# Bind("minNum") %>'></asp:Label><br />
                        最高分：
                        <asp:Label ID="maxNumLabel" runat="server" Text='<%# Bind("maxNum") %>'></asp:Label><br />
                        最低％：
                        <asp:Label ID="minRateLabel" runat="server" Text='<%# Bind("minRate") %>'></asp:Label><br />
                        最高％：
                        <asp:Label ID="maxRateLabel" runat="server" Text='<%# Bind("maxRate") %>'></asp:Label><br />
                      
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_NUMITEMTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="numID" Type="String" />
                        <asp:Parameter Name="numName" Type="String" />
                        <asp:Parameter Name="minNum" Type="Decimal" />
                        <asp:Parameter Name="maxNum" Type="Decimal" />
                        <asp:Parameter Name="minRate" Type="Decimal" />
                        <asp:Parameter Name="maxRate" Type="Decimal" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView2" Name="ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="numID" Type="String" />
                        <asp:Parameter Name="numName" Type="String" />
                        <asp:Parameter Name="minNum" Type="Decimal" />
                        <asp:Parameter Name="maxNum" Type="Decimal" />
                        <asp:Parameter Name="minRate" Type="Decimal" />
                        <asp:Parameter Name="maxRate" Type="Decimal" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
    </asp:MultiView>
</asp:Content>

