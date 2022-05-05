<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF016.aspx.cs" Inherits="HR_EFF016" Title="績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <h5>
        工作目標時間設定</h5>
        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
        DataSourceID="ObjectDataSource1">
        <Columns>
         <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>       
            <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                SortExpression="autoKey" Visible="False" />
            <asp:BoundField DataField="yy" HeaderText="年度" SortExpression="yy" />
            <asp:BoundField DataField="seq" HeaderText="期數" SortExpression="seq" />
            <asp:BoundField DataField="name" HeaderText="說明" SortExpression="name" />
            <asp:CheckBoxField DataField="isOpen" HeaderText="是否可編輯" SortExpression="isOpen" />
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
        TypeName="EFF_EXDSTableAdapters.Effs_WorkSetTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="yy" Type="String" />
            <asp:Parameter Name="seq" Type="String" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="isOpen" Type="Boolean" />
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="yy" Type="String" />
            <asp:Parameter Name="seq" Type="String" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="isOpen" Type="Boolean" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <fieldset>
                <legend>工作目標時間編輯</legend>
        <asp:FormView ID="FormView2" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource2" OnItemInserted="FormView2_ItemInserted" OnItemUpdated="FormView2_ItemUpdated" Width="70%">
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
                
                <asp:Label  ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                年度:
                <asp:TextBox ID="yyTextBox" runat="server" Text='<%# Bind("yy") %>'>
                </asp:TextBox><br />
                期數:
                <asp:TextBox ID="seqTextBox" runat="server" Text='<%# Bind("seq") %>'>
                </asp:TextBox><br />
                說明:
                <asp:TextBox ID="nameTextBox" runat="server" Width="300px" Text='<%# Bind("name") %>'>
                </asp:TextBox><br />
                是否可編輯:
                <asp:CheckBox ID="isOpenCheckBox" runat="server" Checked='<%# Bind("isOpen") %>' /><br />
                
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
                年度:
                <asp:TextBox ID="yyTextBox" runat="server" Text='<%# Bind("yy") %>'>
                </asp:TextBox><br />
                期別:
                <asp:TextBox ID="seqTextBox" runat="server" Text='<%# Bind("seq") %>'>
                </asp:TextBox><br />
                說明:
                <asp:TextBox ID="nameTextBox" runat="server" Width="300px" Text='<%# Bind("name") %>'>
                </asp:TextBox><br />
                是否可編輯:
                <asp:CheckBox ID="isOpenCheckBox" runat="server" Checked='<%# Bind("isOpen") %>' /><br />
              
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
                <asp:Label ID="autoKeyLabel" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                年度:
                <asp:Label ID="yyLabel" runat="server" Text='<%# Bind("yy") %>'></asp:Label><br />
                期別:
                <asp:Label ID="seqLabel" runat="server" Text='<%# Bind("seq") %>'></asp:Label><br />
                說明:
                <asp:Label ID="nameLabel" runat="server" Text='<%# Bind("name") %>'></asp:Label><br />
                是否可編輯:
                <asp:CheckBox ID="isOpenCheckBox" runat="server" Checked='<%# Bind("isOpen") %>'
                    Enabled="false" /><br />
                
            </ItemTemplate>
        </asp:FormView>
                
                
                
                </fieldset>
    &nbsp;&nbsp;
    <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
        TypeName="EFF_EXDSTableAdapters.Effs_WorkSetTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="yy" Type="String" />
            <asp:Parameter Name="seq" Type="String" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="isOpen" Type="Boolean" />
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="yy" Type="String" />
            <asp:Parameter Name="seq" Type="String" />
            <asp:Parameter Name="name" Type="String" />
            <asp:Parameter Name="isOpen" Type="Boolean" />
        </InsertParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" DefaultValue="999999999" Name="ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
    </asp:ObjectDataSource>
</asp:Content>

