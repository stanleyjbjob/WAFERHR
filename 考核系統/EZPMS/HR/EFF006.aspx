<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF006.aspx.cs" Inherits="HR_EFF006" Title="績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem Text="考核樣板設定" Value="0" Selected="True"></asp:MenuItem>
            
            <asp:MenuItem Text="功能設定" Value="6"></asp:MenuItem>
            <asp:MenuItem Text="考核項目設定" Value="1"></asp:MenuItem>
              <asp:MenuItem Text="考核項目明細設定" Value="2"></asp:MenuItem>
                 <asp:MenuItem Text="面談資料設定" Value="3"></asp:MenuItem>
                    <asp:MenuItem Text="類別資料設定" Value="4"></asp:MenuItem>
                    <asp:MenuItem Text="發展計劃設定" Value="5"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>考核樣板設定</h5>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="templetID"
        DataSourceID="ObjectDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
         <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>      
            <asp:BoundField DataField="templetID" HeaderText="代碼" ReadOnly="True" SortExpression="templetID" />
            <asp:BoundField DataField="templetName" HeaderText="樣版名稱" SortExpression="templetName" />
            <asp:CheckBoxField DataField="isTitle" HeaderText="是否用考核抬頭" SortExpression="isTitle" />
            <asp:TemplateField HeaderText="考核抬頭" SortExpression="考核抬頭">
                <EditItemTemplate>
                    <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("titleID") %>'></asp:TextBox>
                </EditItemTemplate>
                <ItemTemplate>
                    &nbsp;<asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="TitleDataSource"
                        DataTextField="titleDesc" DataValueField="titleID" SelectedValue='<%# Bind("titleID") %>'>
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
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="EFFDSTableAdapters.EFFS_TEMPLETTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_templetID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="templetID" Type="String" />
            <asp:Parameter Name="templetName" Type="String" />
            <asp:Parameter Name="isTitle" Type="Boolean" />
            <asp:Parameter Name="titleID" Type="String" />
            <asp:Parameter Name="Original_templetID" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="templetID" Type="String" />
            <asp:Parameter Name="templetName" Type="String" />
            <asp:Parameter Name="isTitle" Type="Boolean" />
            <asp:Parameter Name="titleID" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="CateDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_CATETableAdapter"
        UpdateMethod="Update">
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
    <asp:ObjectDataSource ID="cateItemDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_CATEITEMTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_effsID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="effcateID" Type="String" />
            <asp:Parameter Name="effsName" Type="String" />
            <asp:Parameter Name="Original_effsID" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="effsID" Type="String" />
            <asp:Parameter Name="effcateID" Type="String" />
            <asp:Parameter Name="effsName" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="ObjectDataSource13" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetDataByCate" TypeName="EFFDSTableAdapters.EFFS_CATEITEMTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_effsID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="effcateID" Type="String" />
            <asp:Parameter Name="effsName" Type="String" />
            <asp:Parameter Name="Original_effsID" Type="String" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="lb_cate_id" DefaultValue="&quot;&quot;" Name="cate"
                PropertyName="Text" Type="String" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="effsID" Type="String" />
            <asp:Parameter Name="effcateID" Type="String" />
            <asp:Parameter Name="effsName" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource><asp:ObjectDataSource ID="InterViewDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_INTERVIEWTableAdapter" DeleteMethod="Delete" InsertMethod="Insert" UpdateMethod="Update">
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
    <asp:ObjectDataSource ID="TypeDataSource" runat="server" DeleteMethod="Delete" InsertMethod="Insert"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_TYPETableAdapter"
        UpdateMethod="Update">
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
    </asp:ObjectDataSource><asp:ObjectDataSource ID="TitleDataSource" runat="server"
        OldValuesParameterFormatString="original_{0}" SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_TITLETableAdapter">
    </asp:ObjectDataSource>
    <asp:ObjectDataSource ID="LeanPlanDataSource13" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
        TypeName="EFFDSTableAdapters.EFFS_LEARNPLANTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_ID" Type="String" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="ID" Type="String" />
            <asp:Parameter Name="note" Type="String" />
            <asp:Parameter Name="Original_ID" Type="String" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="ID" Type="String" />
            <asp:Parameter Name="note" Type="String" />
        </InsertParameters>
    </asp:ObjectDataSource>
    &nbsp; &nbsp;
    &nbsp; &nbsp;
    &nbsp;&nbsp;
<asp:MultiView id="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <fieldset>
                <legend>考核樣板設定</legend>
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="templetID" DataSourceID="ObjectDataSource2" OnItemInserted="FormView1_ItemInserted" OnItemUpdated="FormView1_ItemUpdated">
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
                        <asp:Label ID="templetIDLabel1" runat="server" Text='<%# Bind("templetID") %>'></asp:Label><br />
                        樣版名稱:
                        <asp:TextBox ID="templetNameTextBox" runat="server" Text='<%# Bind("templetName") %>'>
                        </asp:TextBox><br />
                        是否用抬頭:
                        <asp:CheckBox ID="isTitleCheckBox" runat="server" Checked='<%# Bind("isTitle") %>' /><br />
                        考核抬頭:
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="TitleDataSource"
                            DataTextField="titleDesc" DataValueField="titleID" SelectedValue='<%# Bind("titleID") %>'>
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
                        代碼:
                         <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("templetID") %>'>
                        </asp:TextBox>
                        <br />
                        樣板名稱:
                        <asp:TextBox ID="templetNameTextBox" runat="server" Text='<%# Bind("templetName") %>'>
                        </asp:TextBox><br />
                        是否用抬頭:
                        <asp:CheckBox ID="isTitleCheckBox" runat="server" Checked='<%# Bind("isTitle") %>' /><br />
                        考核抬頭:
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="TitleDataSource"
                            DataTextField="titleDesc" DataValueField="titleID" SelectedValue='<%# Bind("titleID") %>'>
                        </asp:DropDownList><br />
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
                        代碼:
                        <asp:Label ID="templetIDLabel" runat="server" Text='<%# Bind("templetID") %>'></asp:Label><br />
                        樣版名稱:
                        <asp:Label ID="templetNameLabel" runat="server" Text='<%# Bind("templetName") %>'>
                        </asp:Label><br />
                        是否用抬頭:
                        <asp:CheckBox ID="isTitleCheckBox" runat="server" Checked='<%# Bind("isTitle") %>'
                            Enabled="false" /><br />
                        考核抬頭:
                        <asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="TitleDataSource"
                            DataTextField="titleDesc" DataValueField="titleID" SelectedValue='<%# Bind("titleID") %>'>
                        </asp:DropDownList><br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                            Text="編輯">
                        </asp:LinkButton>
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                            Text="刪除">
                        </asp:LinkButton>
                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                            Text="新增">
                        </asp:LinkButton>
                    </ItemTemplate>
                     <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_templetID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="templetName" Type="String" />
                        <asp:Parameter Name="isTitle" Type="Boolean" />
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="Original_templetID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="0" Name="ID" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="templetName" Type="String" />
                        <asp:Parameter Name="isTitle" Type="Boolean" />
                        <asp:Parameter Name="titleID" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <fieldset>
                <legend>考核樣板設定-考核項目設定</legend>&nbsp;
                <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                    DataSourceID="ObjectDataSource3" OnSelectedIndexChanged="GridView2_SelectedIndexChanged">
                    <Columns>
                     <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>      
                        <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                            SortExpression="autoKey" Visible="False" />
                        <asp:TemplateField HeaderText="templetID" SortExpression="templetID" Visible="False">
                            <EditItemTemplate>
                                  <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                &nbsp;<asp:DropDownList ID="DropDownList1templetName" runat="server" DataSourceID="ObjectDataSource1"
                                    DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="考核項目" SortExpression="effcateID">
                            <EditItemTemplate>
                                 <asp:DropDownList ID="DropDownList1effcateName" runat="server" DataSourceID="CateDataSource"
                                    DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownList1effcateName" runat="server" DataSourceID="CateDataSource"
                                    DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>' Enabled="False">
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
                        
 <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                    </Columns>
                </asp:GridView>
                <asp:Label ID="lb_cate_id" runat="server" Visible="False"></asp:Label>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCate"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETCATETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" DefaultValue="0" Name="Cate" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView2" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource7" OnItemInserted="FormView2_ItemInserted" OnItemUpdated="FormView2_ItemUpdated">
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
                        <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                        樣板:
                         <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        考核項目:
                         <asp:DropDownList ID="DropDownList1effcateName" runat="server" DataSourceID="CateDataSource"
                                    DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>'>
                                </asp:DropDownList><br />
                        排序:
                        <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
                        </asp:TextBox><br />
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
                         <hr />     樣板:
                          <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        考核項目:
                          <asp:DropDownList ID="DropDownList1effcateName" runat="server" DataSourceID="CateDataSource"
                                    DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>'>
                                </asp:DropDownList><br />
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
                        
                        <asp:Label ID="autoKeyLabel" runat="server" Text='<%# Eval("autoKey") %>' Visible="False"></asp:Label><br />
                        樣板:
                          <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        考核項目:
                        <asp:DropDownList ID="DropDownList1effcateName" runat="server" DataSourceID="CateDataSource"
                                    DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>'>
                                </asp:DropDownList><br />
                        排序:
                        <asp:Label ID="orderLabel" runat="server" Text='<%# Bind("order") %>'></asp:Label><br />
                      
                    </ItemTemplate>
                     <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource7" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETCATETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView2" DefaultValue="0" Name="ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="effcateID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
    <asp:View ID="View3" runat="server">
        <fieldset>
            <legend>考核樣板設定-考核項目明細設定</legend>&nbsp;
            <table>
                <tr>
                    <td><asp:GridView ID="GridView7" runat="server" AutoGenerateColumns="False" DataKeyNames="effcateID"
                    DataSourceID="ObjectDataSource3" OnSelectedIndexChanged="GridView7_SelectedIndexChanged">
                        <Columns>
                            <asp:TemplateField ShowHeader="False">
                                <ItemTemplate>
                                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                            SortExpression="autoKey" Visible="False" />
                            <asp:TemplateField HeaderText="templetID" SortExpression="templetID" Visible="False">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    &nbsp;<asp:DropDownList ID="DropDownList1templetName" runat="server" DataSourceID="ObjectDataSource1"
                                    DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="考核項目" SortExpression="effcateID">
                                <EditItemTemplate>
                                    <asp:DropDownList ID="DropDownList1effcateName" runat="server" DataSourceID="CateDataSource"
                                    DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>'>
                                    </asp:DropDownList>
                                </EditItemTemplate>
                                <ItemTemplate>
                                    <asp:DropDownList ID="DropDownList1effcateName" runat="server" DataSourceID="CateDataSource"
                                    DataTextField="effcateName" DataValueField="effcateID" SelectedValue='<%# Bind("effcateID") %>' Enabled="False">
                                    </asp:DropDownList>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
                        </Columns>
                    </asp:GridView>
                    </td>
                    <td valign="top">
            
            <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                DataSourceID="ObjectDataSource4">
                <Columns>
                 <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>      
                    <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                        SortExpression="autoKey" Visible="False" />
                    <asp:TemplateField HeaderText="templetID" SortExpression="templetID" Visible="False">
                        <EditItemTemplate>
                            <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            &nbsp;<asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="考核細目" SortExpression="effsID">
                        <EditItemTemplate>
                           <asp:DropDownList ID="DropDownList1effsID" runat="server" DataSourceID="cateItemDataSource"
                                DataTextField="effsName" DataValueField="effsID" SelectedValue='<%# Bind("effsID") %>'>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemTemplate>
                            &nbsp;<asp:DropDownList ID="DropDownList1effsID" runat="server" DataSourceID="cateItemDataSource"
                                DataTextField="effsName" DataValueField="effsID" SelectedValue='<%# Bind("effsID") %>'>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
                    <asp:BoundField DataField="effsMinNum" HeaderText="最小分數" SortExpression="effsMinNum" />
                    <asp:BoundField DataField="effsMaxNum" HeaderText="最大分數" SortExpression="effsMaxNum" />
                    <asp:BoundField DataField="rate" HeaderText="權重" SortExpression="rate" />
                    
 <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                </Columns>
            </asp:GridView>
            </td>
                </tr>
            </table>
            <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" DeleteMethod="Delete"
                OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByTempIDAndCateID" TypeName="EFFDSTableAdapters.EFFS_TEMPLETCATEITEMTableAdapter" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" Name="templetID" PropertyName="SelectedValue"
                        Type="String" />
                    <asp:ControlParameter ControlID="GridView7" Name="cateid" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="effsID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                    <asp:Parameter Name="effsMinNum" Type="Decimal" />
                    <asp:Parameter Name="effsMaxNum" Type="Decimal" />
                    <asp:Parameter Name="rate" Type="Decimal" />
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="effsID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                    <asp:Parameter Name="effsMinNum" Type="Decimal" />
                    <asp:Parameter Name="effsMaxNum" Type="Decimal" />
                    <asp:Parameter Name="rate" Type="Decimal" />
                </InsertParameters>
            </asp:ObjectDataSource>
            <asp:FormView ID="FormView3" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataTempleCateItems" OnItemInserted="FormView3_ItemInserted" OnItemUpdated="FormView3_ItemUpdated" OnItemInserting="FormView3_ItemInserting" OnItemUpdating="FormView3_ItemUpdating" Width="70%">
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
                   <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                    項目明細:
                   <asp:DropDownList ID="DropDownList1effsID" runat="server" DataSourceID="ObjectDataSource13"
                                DataTextField="effsName" DataValueField="effsID" SelectedValue='<%# Bind("effsID") %>'>
                            </asp:DropDownList><br />
                    排序:
                    <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'></asp:TextBox><br />
                    最小分數:
                    <asp:TextBox ID="effsMinNumTextBox" runat="server" Text='<%# Bind("effsMinNum") %>'></asp:TextBox><br />
                    最大分數:
                    <asp:TextBox ID="effsMaxNumTextBox" runat="server" Text='<%# Bind("effsMaxNum") %>'></asp:TextBox><br />
                    權重:
                    <asp:TextBox ID="rateTextBox" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox><br />
                  
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
                         <hr /> <br />
                    項目明細:
                   <asp:DropDownList ID="DropDownList1effsID" runat="server" DataSourceID="ObjectDataSource13"
                                DataTextField="effsName" DataValueField="effsID" SelectedValue='<%# Bind("effsID") %>'>
                            </asp:DropDownList><br />
                    排序:
                    <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
                    </asp:TextBox><br />
                    最小分數:
                    <asp:TextBox ID="effsMinNumTextBox" runat="server" Text='<%# Bind("effsMinNum") %>'>
                    </asp:TextBox><br />
                    最大分數:
                    <asp:TextBox ID="effsMaxNumTextBox" runat="server" Text='<%# Bind("effsMaxNum") %>'>
                    </asp:TextBox><br />
                    權重:
                    <asp:TextBox ID="rateTextBox" runat="server" Text='<%# Bind("rate") %>'>
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
                    <asp:Label ID="autoKeyLabel" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                    項目明細:
                    <asp:DropDownList ID="DropDownList1effsID" runat="server" DataSourceID="cateItemDataSource"
                                DataTextField="effsName" DataValueField="effsID" SelectedValue='<%# Bind("effsID") %>' Enabled="False">
                            </asp:DropDownList><br />
                    排序:
                    <asp:Label ID="orderLabel" runat="server" Text='<%# Bind("order") %>'></asp:Label><br />
                    最小分數:
                    <asp:Label ID="effsMinNumLabel" runat="server" Text='<%# Bind("effsMinNum") %>'>
                    </asp:Label><br />
                    最大分數:
                    <asp:Label ID="effsMaxNumLabel" runat="server" Text='<%# Bind("effsMaxNum") %>'>
                    </asp:Label><br />
                    權重:
                    <asp:Label ID="rateLabel" runat="server" Text='<%# Bind("rate") %>'></asp:Label><br />
                  
                </ItemTemplate>
            </asp:FormView>
            &nbsp;
            <asp:ObjectDataSource ID="ObjectDataTempleCateItems" runat="server" DeleteMethod="Delete"
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                TypeName="EFFDSTableAdapters.EFFS_TEMPLETCATEITEMTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="effsID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                    <asp:Parameter Name="effsMinNum" Type="Decimal" />
                    <asp:Parameter Name="effsMaxNum" Type="Decimal" />
                    <asp:Parameter Name="rate" Type="Decimal" />
                    <asp:Parameter Name="typeID" Type="String" />
                    <asp:Parameter Name="effsCateID" Type="String" />
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView3" Name="ID" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="effsID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                    <asp:Parameter Name="effsMinNum" Type="Decimal" />
                    <asp:Parameter Name="effsMaxNum" Type="Decimal" />
                    <asp:Parameter Name="rate" Type="Decimal" />
                    <asp:Parameter Name="typeID" Type="String" />
                    <asp:Parameter Name="effsCateID" Type="String" />
                </InsertParameters>
            </asp:ObjectDataSource>
            &nbsp;
            </fieldset>
        </asp:View><asp:View ID="View4" runat="server">
            <fieldset>
                <legend>考核樣板設定-面談資料設定</legend>&nbsp; &nbsp;
                <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                    DataSourceID="ObjectDataSource5">
                    <Columns>
                      <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>      
                        <asp:BoundField DataField="autoKey" HeaderText="autoKey" ReadOnly="True" SortExpression="autoKey" Visible="False" />
                        <asp:TemplateField HeaderText="templetID" SortExpression="templetID" Visible="False">
                            <EditItemTemplate>
                                 <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                &nbsp;<asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="面談資料" SortExpression="interviewID">
                            <EditItemTemplate>
                                <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="InterViewDataSource"
                                    DataTextField="interview" DataValueField="ID" SelectedValue='<%# Bind("interviewID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                &nbsp;<asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="InterViewDataSource"
                                    DataTextField="interview" DataValueField="ID" SelectedValue='<%# Bind("interviewID") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
                        
 <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource5" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCate"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETINTERVIEWTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="autoKey" Type="Int32" />
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="interviewID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="Cate" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="autoKey" Type="Int32" />
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="interviewID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView4" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource9" OnItemInserted="FormView4_ItemInserted" OnItemUpdated="FormView4_ItemUpdated">
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
                        <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                        樣版:
                         <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        面談資料:
                       <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="InterViewDataSource"
                                    DataTextField="interview" DataValueField="ID" SelectedValue='<%# Bind("interviewID") %>'>
                                </asp:DropDownList><br />
                        排序:
                        <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
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
                           樣版:
                         <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        面談資料:
                       <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="InterViewDataSource"
                                    DataTextField="interview" DataValueField="ID" SelectedValue='<%# Bind("interviewID") %>'>
                                </asp:DropDownList><br />
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
                        <asp:Label ID="autoKeyLabel" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                        樣版:
                          <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        面談資料:
                        <asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="InterViewDataSource"
                                    DataTextField="interview" DataValueField="ID" SelectedValue='<%# Bind("interviewID") %>'>
                                </asp:DropDownList><br />
                        排序:
                        <asp:Label ID="orderLabel" runat="server" Text='<%# Bind("order") %>'></asp:Label>
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource9" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETINTERVIEWTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="interviewID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView4" Name="ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="interviewID" Type="String" />
                        <asp:Parameter Name="order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View><asp:View ID="View5" runat="server">
            <fieldset>
                <legend>考核樣板設定-類別資料設定</legend>&nbsp; &nbsp;
                <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                    DataSourceID="ObjectDataSource6">
                    <Columns>
                      <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>      
                        <asp:BoundField DataField="autoKey" HeaderText="autoKey" ReadOnly="True" SortExpression="autoKey" Visible="False" />
                        <asp:TemplateField HeaderText="templetID" SortExpression="templetID" Visible="False">
                            <EditItemTemplate>
                                 <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="考核類別" SortExpression="type">
                            <EditItemTemplate>
                               <asp:DropDownList ID="DropDownLitempletNamedit" runat="server" DataSourceID="TypeDataSource"
                                DataTextField="typeName" DataValueField="type" SelectedValue='<%# Bind("type") %>'></asp:DropDownList>
                            </EditItemTemplate>
                            <ItemTemplate>
                                &nbsp;<asp:DropDownList ID="DropDownLitempletNameitem" runat="server" DataSourceID="TypeDataSource"
                                DataTextField="typeName" DataValueField="type" SelectedValue='<%# Bind("type") %>'>
                                </asp:DropDownList>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="rate" HeaderText="權重" SortExpression="rate" />
                        <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
                        
 <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource6" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByCate"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETTYPETableAdapter">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView1" Name="Cate" PropertyName="SelectedValue"
                            Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView5" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource10" OnItemInserted="FormView5_ItemInserted" OnItemUpdated="FormView5_ItemUpdated">
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
                        <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                        樣板:
                          <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        類別:
                       <asp:DropDownList ID="DropDownList1typeName" runat="server" DataSourceID="TypeDataSource"
                                DataTextField="typeName" DataValueField="type" SelectedValue='<%# Bind("type") %>'></asp:DropDownList><br />
                        權重:
                        <asp:TextBox ID="rateTextBox" runat="server" Text='<%# Bind("rate") %>'>
                        </asp:TextBox><br />
                        排序:
                        <asp:TextBox ID="orderTextBox" runat="server" Text='<%# Bind("order") %>'>
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
                        樣板:
                         <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        類別:
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="TypeDataSource"
                                DataTextField="typeName" DataValueField="type" SelectedValue='<%# Bind("type") %>'></asp:DropDownList><br />
                        權重:
                        <asp:TextBox ID="rateTextBox" runat="server" Text='<%# Bind("rate") %>'>
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
                   
                        <asp:Label ID="autoKeyLabel" runat="server" Text='<%# Bind("autoKey") %>'></asp:Label><br />
                        樣板:
                          <asp:DropDownList ID="DropDownLitempletName" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                        類別:
                        <asp:DropDownList ID="DropDownList5" runat="server" DataSourceID="TypeDataSource"
                                DataTextField="typeName" DataValueField="type" SelectedValue='<%# Bind("type") %>'></asp:DropDownList><br />
                        權重:
                        <asp:Label ID="rateLabel" runat="server" Text='<%# Bind("rate") %>'></asp:Label><br />
                        排序:
                        <asp:Label ID="orderLabel" runat="server" Text='<%# Bind("order") %>'></asp:Label><br />
                        
                    </ItemTemplate>
                    <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="ObjectDataSource10" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETTYPETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="type" Type="String" />
                        <asp:Parameter Name="rate" Type="Decimal" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="Original_autoKey" Type="Int32" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView5" DefaultValue="0" Name="ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="type" Type="String" />
                        <asp:Parameter Name="rate" Type="Decimal" />
                        <asp:Parameter Name="order" Type="Int32" />
                    </InsertParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
    <asp:View ID="View6" runat="server">
        <fieldset>
            <legend>考核樣板設定-發展計劃設定</legend>&nbsp; &nbsp;
            <asp:GridView ID="GridView6" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                    DataSourceID="ObjectDataSource11">
                <Columns>
                 <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>   
                    <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                        SortExpression="autoKey" Visible="False" />
                    <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID"
                        Visible="False" />
                    <asp:TemplateField HeaderText="發展計劃" SortExpression="learnplanID">
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("learnplanID") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="LeanPlanDataSource13"
                                DataTextField="note" DataValueField="ID" Enabled="False" SelectedValue='<%# Bind("learnplanID") %>'>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="order" HeaderText="排序" SortExpression="order" />
                     <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField> 
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource11" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataTempletID"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETLEARNPLANTableAdapter" InsertMethod="Insert" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="learnplanID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" DefaultValue="&quot;&quot;" Name="TempletID"
                        PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="learnplanID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                </InsertParameters>
            </asp:ObjectDataSource>
            <asp:FormView ID="FormView6" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource12" OnItemInserted="FormView6_ItemInserted" OnItemUpdated="FormView6_ItemUpdated">
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
                    autoKey:
                    <asp:Label ID="autoKeyLabel1" runat="server" Text='<%# Eval("autoKey") %>'></asp:Label><br />
                    <asp:TextBox ID="templetIDTextBox" runat="server" Text='<%# Bind("templetID") %>' Visible="false">
                    </asp:TextBox><br />
                     樣板:
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                    發展計劃:
                     <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="LeanPlanDataSource13"
                        DataTextField="note" DataValueField="ID" SelectedValue='<%# Bind("learnplanID") %>'>
                    </asp:DropDownList><br />
                    排序:
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
                   樣板:
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                    發展計劃:
                     <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="LeanPlanDataSource13"
                        DataTextField="note" DataValueField="ID" SelectedValue='<%# Bind("learnplanID") %>'>
                    </asp:DropDownList><br />
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
                       
                   樣板:
                    <asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="ObjectDataSource1"
                                DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                                </asp:DropDownList><br />
                    發展計劃:
                    <asp:DropDownList ID="DropDownList6" runat="server" DataSourceID="LeanPlanDataSource13"
                        DataTextField="note" DataValueField="ID" SelectedValue='<%# Bind("learnplanID") %>'>
                    </asp:DropDownList><br />
                    排序:
                    <asp:Label ID="orderLabel" runat="server" Text='<%# Bind("order") %>'></asp:Label><br />
                 </ItemTemplate>
                 
            </asp:FormView>
            &nbsp;
            <asp:ObjectDataSource ID="ObjectDataSource12" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETLEARNPLANTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="learnplanID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView6" DefaultValue="0" Name="ID" PropertyName="SelectedValue"
                            Type="Int32" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="learnplanID" Type="String" />
                    <asp:Parameter Name="order" Type="Int32" />
                </InsertParameters>
            </asp:ObjectDataSource>
        </fieldset>
    </asp:View>
        <asp:View ID="View7" runat="server">
        <fieldset>
            <legend>考核樣板設定-功能設定</legend>&nbsp; &nbsp;&nbsp;
            <asp:FormView ID="FormView7" runat="server" DataKeyNames="auto_key" DataSourceID="ObjectDataSource14" OnItemInserting="FormView7_ItemInserting" OnItemUpdating="FormView7_ItemUpdating">
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
                   
                    <asp:Label Visible="false" ID="auto_keyLabel1" runat="server" Text='<%# Eval("auto_key") %>'></asp:Label><br />
                   
                    <asp:TextBox Visible="false" ID="templetIDTextBox" runat="server" Text='<%# Bind("templetID") %>'>
                    </asp:TextBox><br />
                                            <asp:CheckBox Visible="false" ID="CheckBox1" runat="server" Checked='<%# Bind("selfcheck") %>' Text="員工自評" />
                    
                    
                    工作目標:
                    <asp:CheckBox ID="fun1CheckBox" runat="server" Checked='<%# Bind("fun1") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun1_nameTextBox" runat="server" Text='<%# Bind("fun1_name") %>'>
                    </asp:TextBox><br />
                    下期工作目標設定:
                    <asp:CheckBox ID="fun2CheckBox" runat="server" Checked='<%# Bind("fun2") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun2_nameTextBox" runat="server" Text='<%# Bind("fun2_name") %>'>
                    </asp:TextBox><br />
                    考核項目:
                    <asp:CheckBox ID="fun3CheckBox" runat="server" Checked='<%# Bind("fun3") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun3_nameTextBox" runat="server" Text='<%# Bind("fun3_name") %>'>
                    </asp:TextBox><br />
                    考核面談設定:
                    <asp:CheckBox ID="fun4CheckBox" runat="server" Checked='<%# Bind("fun4") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun4_nameTextBox" runat="server" Text='<%# Bind("fun4_name") %>'>
                    </asp:TextBox><br />
                    訓練需求設定:
                    <asp:CheckBox ID="fun5CheckBox" runat="server" Checked='<%# Bind("fun5") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun5_nameTextBox" runat="server" Text='<%# Bind("fun5_name") %>'>
                    </asp:TextBox><br />
                    發展計劃設定:
                    <asp:CheckBox ID="fun6CheckBox" runat="server" Checked='<%# Bind("fun6") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun6_nameTextBox" runat="server" Text='<%# Bind("fun6_name") %>'>
                    </asp:TextBox><br />
                    上傳參考資料設定:
                    <asp:CheckBox ID="fun7CheckBox" runat="server" Checked='<%# Bind("fun7") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun7_nameTextBox" runat="server" Text='<%# Bind("fun7_name") %>'>
                    </asp:TextBox><br />
                    員工基本資料:
                    <asp:CheckBox ID="fun8CheckBox" runat="server" Checked='<%# Bind("fun8") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun8_nameTextBox" runat="server" Text='<%# Bind("fun8_name") %>'>
                    </asp:TextBox><br />
                    完成:
                    <asp:CheckBox ID="fun9CheckBox" runat="server" Checked='<%# Bind("fun9") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun9_nameTextBox" runat="server" Text='<%# Bind("fun9_name") %>'>
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
                        
                        <asp:CheckBox Visible="false" ID="CheckBox1" runat="server" Checked='<%# Bind("selfcheck") %>' Text="員工自評" />
                   
                    
                    工作目標:
                    <asp:CheckBox ID="fun1CheckBox" runat="server" Checked='<%# Bind("fun1") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun1_nameTextBox" runat="server" Text='<%# Bind("fun1_name") %>'>
                    </asp:TextBox><br />
                    下期工作目標設定:
                    <asp:CheckBox ID="fun2CheckBox" runat="server" Checked='<%# Bind("fun2") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun2_nameTextBox" runat="server" Text='<%# Bind("fun2_name") %>'>
                    </asp:TextBox><br />
                    考核項目:
                    <asp:CheckBox ID="fun3CheckBox" runat="server" Checked='<%# Bind("fun3") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun3_nameTextBox" runat="server" Text='<%# Bind("fun3_name") %>'>
                    </asp:TextBox><br />
                    考核面談設定:
                    <asp:CheckBox ID="fun4CheckBox" runat="server" Checked='<%# Bind("fun4") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun4_nameTextBox" runat="server" Text='<%# Bind("fun4_name") %>'>
                    </asp:TextBox><br />
                    訓練需求設定:
                    <asp:CheckBox ID="fun5CheckBox" runat="server" Checked='<%# Bind("fun5") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun5_nameTextBox" runat="server" Text='<%# Bind("fun5_name") %>'>
                    </asp:TextBox><br />
                    發展計劃設定:
                    <asp:CheckBox ID="fun6CheckBox" runat="server" Checked='<%# Bind("fun6") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun6_nameTextBox" runat="server" Text='<%# Bind("fun6_name") %>'>
                    </asp:TextBox><br />
                    上傳參考資料設定:
                    <asp:CheckBox ID="fun7CheckBox" runat="server" Checked='<%# Bind("fun7") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun7_nameTextBox" runat="server" Text='<%# Bind("fun7_name") %>'>
                    </asp:TextBox><br />
                    員工基本資料:
                    <asp:CheckBox ID="fun8CheckBox" runat="server" Checked='<%# Bind("fun8") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun8_nameTextBox" runat="server" Text='<%# Bind("fun8_name") %>'>
                    </asp:TextBox><br />
                    完成:
                    <asp:CheckBox ID="fun9CheckBox" runat="server" Checked='<%# Bind("fun9") %>' /><br />
                    顯示名稱:
                    <asp:TextBox ID="fun9_nameTextBox" runat="server" Text='<%# Bind("fun9_name") %>'>
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
                        
                        <asp:CheckBox Visible="false" Enabled ="false" ID="CheckBox1" runat="server" Checked='<%# Bind("selfcheck") %>' Text="員工自評" />
                    
                    
                    工作目標:
                    <asp:CheckBox Enabled ="false"  ID="fun1CheckBox" runat="server" Checked='<%# Bind("fun1") %>' /><br />
                    顯示名稱:
                    <asp:TextBox Enabled ="false" ID="fun1_nameTextBox" runat="server" Text='<%# Bind("fun1_name") %>'>
                    </asp:TextBox><br />
                    下期工作目標設定:
                    <asp:CheckBox Enabled ="false"  ID="fun2CheckBox" runat="server" Checked='<%# Bind("fun2") %>' /><br />
                    顯示名稱:
                    <asp:TextBox  Enabled ="false" ID="fun2_nameTextBox" runat="server" Text='<%# Bind("fun2_name") %>'>
                    </asp:TextBox><br />
                    考核項目:
                    <asp:CheckBox Enabled ="false"  ID="fun3CheckBox" runat="server" Checked='<%# Bind("fun3") %>' /><br />
                    顯示名稱:
                    <asp:TextBox  Enabled ="false" ID="fun3_nameTextBox" runat="server" Text='<%# Bind("fun3_name") %>'>
                    </asp:TextBox><br />
                    考核面談設定:
                    <asp:CheckBox  Enabled ="false" ID="fun4CheckBox" runat="server" Checked='<%# Bind("fun4") %>' /><br />
                    顯示名稱:
                    <asp:TextBox   Enabled ="false" ID="fun4_nameTextBox" runat="server" Text='<%# Bind("fun4_name") %>'>
                    </asp:TextBox><br />
                    訓練需求設定:
                    <asp:CheckBox  Enabled ="false" ID="fun5CheckBox" runat="server" Checked='<%# Bind("fun5") %>' /><br />
                    顯示名稱:
                    <asp:TextBox  Enabled ="false" ID="fun5_nameTextBox" runat="server" Text='<%# Bind("fun5_name") %>'>
                    </asp:TextBox><br />
                    發展計劃設定:
                    <asp:CheckBox Enabled ="false"  ID="fun6CheckBox" runat="server" Checked='<%# Bind("fun6") %>' /><br />
                    顯示名稱:
                    <asp:TextBox  Enabled ="false" ID="fun6_nameTextBox" runat="server" Text='<%# Bind("fun6_name") %>'>
                    </asp:TextBox><br />
                    上傳參考資料設定:
                    <asp:CheckBox Enabled ="false"  ID="fun7CheckBox" runat="server" Checked='<%# Bind("fun7") %>' /><br />
                    顯示名稱:
                    <asp:TextBox  Enabled ="false" ID="fun7_nameTextBox" runat="server" Text='<%# Bind("fun7_name") %>'>
                    </asp:TextBox><br />
                    員工基本資料:
                    <asp:CheckBox Enabled ="false"  ID="fun8CheckBox" runat="server" Checked='<%# Bind("fun8") %>' /><br />
                    顯示名稱:
                    <asp:TextBox  Enabled ="false" ID="fun8_nameTextBox" runat="server" Text='<%# Bind("fun8_name") %>'>
                    </asp:TextBox><br />
                    完成:
                    <asp:CheckBox Enabled ="false"  ID="fun9CheckBox" runat="server" Checked='<%# Bind("fun9") %>' /><br />
                    顯示名稱:
                    <asp:TextBox   Enabled ="false" ID="fun9_nameTextBox" runat="server" Text='<%# Bind("fun9_name") %>'>
                    </asp:TextBox><br />                  
                </ItemTemplate>
                <EmptyDataTemplate>
                    <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                </EmptyDataTemplate>
            </asp:FormView>
            <asp:ObjectDataSource ID="ObjectDataSource14" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBy"
                    TypeName="EFF_EXDSTableAdapters.EFFS_FunTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_auto_key" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="fun1" Type="Boolean" />
                    <asp:Parameter Name="fun1_name" Type="String" />
                    <asp:Parameter Name="fun2" Type="Boolean" />
                    <asp:Parameter Name="fun2_name" Type="String" />
                    <asp:Parameter Name="fun3" Type="Boolean" />
                    <asp:Parameter Name="fun3_name" Type="String" />
                    <asp:Parameter Name="fun4" Type="Boolean" />
                    <asp:Parameter Name="fun4_name" Type="String" />
                    <asp:Parameter Name="fun5" Type="Boolean" />
                    <asp:Parameter Name="fun5_name" Type="String" />
                    <asp:Parameter Name="fun6" Type="Boolean" />
                    <asp:Parameter Name="fun6_name" Type="String" />
                    <asp:Parameter Name="fun7" Type="Boolean" />
                    <asp:Parameter Name="fun7_name" Type="String" />
                    <asp:Parameter Name="fun8" Type="Boolean" />
                    <asp:Parameter Name="fun8_name" Type="String" />
                    <asp:Parameter Name="fun9" Type="Boolean" />
                    <asp:Parameter Name="fun9_name" Type="String" />
                    <asp:Parameter Name="selfcheck" Type="Boolean" />
                    <asp:Parameter Name="Original_auto_key" Type="Int32" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="GridView1" DefaultValue="zzzz" Name="templetid"
                        PropertyName="SelectedValue" Type="String" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="templetID" Type="String" />
                    <asp:Parameter Name="fun1" Type="Boolean" />
                    <asp:Parameter Name="fun1_name" Type="String" />
                    <asp:Parameter Name="fun2" Type="Boolean" />
                    <asp:Parameter Name="fun2_name" Type="String" />
                    <asp:Parameter Name="fun3" Type="Boolean" />
                    <asp:Parameter Name="fun3_name" Type="String" />
                    <asp:Parameter Name="fun4" Type="Boolean" />
                    <asp:Parameter Name="fun4_name" Type="String" />
                    <asp:Parameter Name="fun5" Type="Boolean" />
                    <asp:Parameter Name="fun5_name" Type="String" />
                    <asp:Parameter Name="fun6" Type="Boolean" />
                    <asp:Parameter Name="fun6_name" Type="String" />
                    <asp:Parameter Name="fun7" Type="Boolean" />
                    <asp:Parameter Name="fun7_name" Type="String" />
                    <asp:Parameter Name="fun8" Type="Boolean" />
                    <asp:Parameter Name="fun8_name" Type="String" />
                    <asp:Parameter Name="fun9" Type="Boolean" />
                    <asp:Parameter Name="fun9_name" Type="String" />
                    <asp:Parameter Name="selfcheck" Type="Boolean" />
                </InsertParameters>
            </asp:ObjectDataSource>
            
            
            
            
            
            
            
            </fieldset>
            </asp:View>
    </asp:MultiView>
</asp:Content>

