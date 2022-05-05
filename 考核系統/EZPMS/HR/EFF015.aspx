<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF015.aspx.cs" Inherits="HR_EFF015" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h5>
        考核管理者設定</h5>
        
        <FIELDSET><LEGEND>管理者資料</LEGEND><asp:GridView id="GridView1" runat="server" DataSourceID="ObjectDataSource1" DataKeyNames="auto_key" AutoGenerateColumns="False" AllowSorting="True" AllowPaging="True">
                    <Columns>
                     <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="auto_key" HeaderText="auto_key" InsertVisible="False"
                            ReadOnly="True" SortExpression="auto_key" Visible="False" />
                        <asp:BoundField DataField="nobr" HeaderText="管理者工號" SortExpression="nobr" />
                          <asp:BoundField DataField="NAME_C" HeaderText="管理者" SortExpression="NAME_C" />
                        <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView> <asp:ObjectDataSource id="ObjectDataSource1" runat="server" UpdateMethod="Update" TypeName="EFF_EXDSTableAdapters.EFFS_AdminTableAdapter" SelectMethod="GetDataByAllName" OldValuesParameterFormatString="original_{0}" InsertMethod="Insert" DeleteMethod="Delete">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_auto_key" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="Original_auto_key" Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="nobr" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource> </FIELDSET>
    <fieldset>
        <legend>管理者維護</legend>&nbsp;
        <asp:FormView ID="FormView1" runat="server" DataKeyNames="auto_key" DataSourceID="ObjectDataSource2"
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
               
                <asp:Label ID="auto_keyLabel1" runat="server" Text='<%# Eval("auto_key") %>' Visible="false"></asp:Label><br />
                管理者工號:
                <asp:TextBox ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>'>
                </asp:TextBox><asp:Label ID="Label1" runat="server" Text='<%# Eval("NAME_C") %>' ></asp:Label><br />
                <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" CommandName="Update"
                    Text="更新">
                </asp:LinkButton>
                <asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                    Text="取消">
                </asp:LinkButton>
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
                管理者工號:
                <asp:TextBox ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>'></asp:TextBox><br />
                &nbsp;
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
                
                <asp:Label ID="auto_keyLabel" runat="server" Text='<%# Eval("auto_key") %>' Visible="false"></asp:Label><br />
              管理者工號:
                <asp:Label ID="nobrLabel" runat="server" Text='<%# Bind("nobr") %>'></asp:Label><br />
              管理者姓名:
                <asp:Label ID="Label1" runat="server" Text='<%# Eval("NAME_C") %>' ></asp:Label><br />
                &nbsp;&nbsp;
            </ItemTemplate>
            <EmptyDataTemplate>
                <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                    Text="新增資料" />
            </EmptyDataTemplate>
        </asp:FormView>
        <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
            InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByName"
            TypeName="EFF_EXDSTableAdapters.EFFS_AdminTableAdapter" UpdateMethod="Update">
            <DeleteParameters>
                <asp:Parameter Name="Original_auto_key" Type="Int32" />
            </DeleteParameters>
            <UpdateParameters>
                <asp:Parameter Name="nobr" Type="String" />
                <asp:Parameter Name="Original_auto_key" Type="Int32" />
            </UpdateParameters>
            <SelectParameters>
                <asp:ControlParameter ControlID="GridView1" DefaultValue="9999" Name="auto_key" PropertyName="SelectedValue"
                    Type="Int32" />
            </SelectParameters>
            <InsertParameters>
                <asp:Parameter Name="nobr" Type="String" />
            </InsertParameters>
        </asp:ObjectDataSource>
    </fieldset>
</asp:Content>

