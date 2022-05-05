<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF008.aspx.cs" Inherits="HR_EFF008" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal">
        <Items>
            <asp:MenuItem Text="考核面談資料設定" Value="新增項目" Selected="true"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <h5>考核面談資料設定</h5>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <fieldset>
                <legend>考核面談資料</legend>&nbsp;
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="ID"
                    DataSourceID="ObjectDataSource1">
                    <Columns>
                     <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="ID" HeaderText="代碼" ReadOnly="True" SortExpression="ID"  />
                        <asp:BoundField DataField="interview" HeaderText="面談內容" SortExpression="interview" />
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
                    TypeName="EFFDSTableAdapters.EFFS_INTERVIEWTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_ID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID" Type="String" />
                        <asp:Parameter Name="interview" Type="String" />
                        <asp:Parameter Name="Original_ID" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ID" Type="String" />
                        <asp:Parameter Name="interview" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="ID" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated">
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
                        <asp:Label ID="IDLabel1" runat="server" Text='<%# Bind("ID") %>' ></asp:Label><br />V
                        面談內容：
                        <asp:TextBox ID="interviewTextBox" runat="server" Text='<%# Bind("interview") %>'>
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
                        <asp:TextBox ID="IDTextBox" runat="server" Text='<%# Bind("ID") %>' >
                        </asp:TextBox><br />
                        面談內容：
                        <asp:TextBox ID="interviewTextBox" runat="server" Text='<%# Bind("interview") %>'>
                        </asp:TextBox><br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="插入">
                        </asp:LinkButton>
                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="取消">
                        </asp:LinkButton>
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
                        <asp:Label ID="IDLabel" runat="server" Text='<%# Eval("ID") %>'></asp:Label><br />
                        面談內容：
                        <asp:Label ID="interviewLabel" runat="server" Text='<%# Bind("interview") %>'></asp:Label><br />
                      
                    </ItemTemplate>
                     <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_INTERVIEWTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_ID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="ID" Type="String" />
                        <asp:Parameter Name="interview" Type="String" />
                        <asp:Parameter Name="Original_ID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                            Type="String" DefaultValue="0" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="ID" Type="String" />
                        <asp:Parameter Name="interview" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
             <fieldset>
                 &nbsp; &nbsp;
                
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
