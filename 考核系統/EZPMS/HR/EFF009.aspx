<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF009.aspx.cs" Inherits="HR_EFF009" Title="績效考核系統（Web版）v1.0" %>

<%@ Register Assembly="RadCalendar.Net2" Namespace="Telerik.WebControls" TagPrefix="radCln" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:Menu ID="Menu1" runat="server" Orientation="Horizontal">
        <Items>
            <asp:MenuItem Text="考核時間設定" Value="0" Selected="true"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
        DataSourceID="Effs_AttendDataSource">
        <Columns>
         <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>  
            <asp:BoundField DataField="yy" HeaderText="考核年度" ReadOnly="True" SortExpression="yy" />
            <asp:BoundField DataField="seq" HeaderText="考核次數" ReadOnly="True" SortExpression="seq" />
            <asp:BoundField DataField="Desc" HeaderText="說明" SortExpression="Desc" />
            <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate" Visible="False" />
            <asp:BoundField DataField="StdDate" HeaderText="開始時間" SortExpression="StdDate" DataFormatString="{0:yyyy/MM/dd}" HtmlEncode="False"  />
            <asp:BoundField DataField="EndDate" HeaderText="結束時間" SortExpression="EndDate" DataFormatString="{0:yyyy/MM/dd}" HtmlEncode="False" />
            <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>   
        </Columns>
    </asp:GridView>
    <asp:ObjectDataSource ID="Effs_AttendDataSource" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByAll"
        TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter">
        <DeleteParameters>
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </DeleteParameters>
    </asp:ObjectDataSource>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="autoKey" DataSourceID="ObjectDataSource1" OnItemInserted="FormView1_ItemInserted" OnItemInserting="FormView1_ItemInserting" OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating" OnDataBinding="FormView1_DataBinding" OnDataBound="FormView1_DataBound">
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
            <asp:Label ID="Label1" runat="server" Text='<%# Eval("autoKey") %>' ></asp:Label><br /> 
            考核年度:
            <asp:Label ID="yyLabel1" runat="server" Text='<%# Bind("yy") %>'></asp:Label><br />
            考核次數:
            <asp:Label ID="seqLabel1" runat="server" Text='<%# Bind("seq") %>'></asp:Label><br />
            說明:
            <asp:TextBox ID="DescTextBox" runat="server" Text='<%# Bind("Desc") %>'>
            </asp:TextBox><br />
            開始時間:
            <radCln:RadDatePicker ID="RadDatePicker1" runat="server" Culture="Chinese (Taiwan)"
                SelectedDate='<%# Bind("StdDate") %>'>
                <DateInput Skin="">
                </DateInput>
            </radCln:RadDatePicker>
          <br />
            結束時間:
             <radCln:RadDatePicker ID="RadDatePicker2" runat="server" Culture="Chinese (Taiwan)"
                SelectedDate='<%# Bind("EndDate") %>'>
                <DateInput Skin="">
                </DateInput>
            </radCln:RadDatePicker>
            <br />
            <br />
            本次工作目標年度:
            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("s_yy") %>'></asp:TextBox><br />
            本次工作目標次數:
            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("s_seq") %>'></asp:TextBox><br />
            <br />
            下次工作目標年度:
            <asp:TextBox ID="Label2" runat="server" Text='<%# Bind("n_yy") %>'></asp:TextBox><br />
            下次工作目標次數:
            <asp:TextBox ID="Label3" runat="server" Text='<%# Bind("n_seq") %>'></asp:TextBox><br />
            <br />
            <br />
           <br>
              考核類別:
               <asp:RadioButtonList ID="efftype" runat="server">
               <asp:ListItem Text="年度考核" Value="A001"></asp:ListItem>
               <asp:ListItem Text="其他考核" Value="S001"></asp:ListItem>
            </asp:RadioButtonList>
            <asp:Label ID="lb_efftype" runat="server" Text='<%# Bind("type") %>' Visible="false"></asp:Label><br />
          
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
            考核年度:
            <asp:TextBox ID="yyTextBox" runat="server" Text='<%# Bind("yy") %>'>
            </asp:TextBox><br />
            考核次數:
            <asp:TextBox ID="seqTextBox" runat="server" Text='<%# Bind("seq") %>'>
            </asp:TextBox><br />
            
            開始時間:
             <radCln:RadDatePicker ID="RadDatePicker1" runat="server" Culture="Chinese (Taiwan)"
                SelectedDate='<%# Bind("StdDate") %>'>
                <DateInput Skin="">
                </DateInput>
            </radCln:RadDatePicker>
            <br />
            結束時間:
             <radCln:RadDatePicker ID="RadDatePicker3" runat="server" Culture="Chinese (Taiwan)"
                SelectedDate='<%# Bind("EndDate") %>'>
                <DateInput Skin="">
                </DateInput>
            </radCln:RadDatePicker>
          <br>
            <br />
            本次工作目標年度:
            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("s_yy") %>'></asp:TextBox><br />
            本次工作目標次數:
            <asp:TextBox ID="TextBox4" runat="server" Text='<%# Bind("s_seq") %>'></asp:TextBox><br />
            <br />
            <br />
              下次工作目標年度:
           <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("n_yy") %>'>
            </asp:TextBox><br />
            下次工作目標次數:
              <asp:TextBox ID="TextBox2" runat="server" Text='<%# Bind("n_seq") %>'>
            </asp:TextBox><br />
            說明:
            <asp:TextBox ID="DescTextBox" runat="server" Text='<%# Bind("Desc") %>'>
            </asp:TextBox><br />
              考核類別:
               <asp:RadioButtonList ID="efftype" runat="server">
               <asp:ListItem Text="年度考核" Value="A001"></asp:ListItem>
               <asp:ListItem Text="其他考核" Value="S001"></asp:ListItem>
            </asp:RadioButtonList>
            <asp:Label ID="lb_efftype" runat="server" Text='<%# Bind("type") %>' Visible="false"></asp:Label><br />
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
            考核年度:
            <asp:Label ID="yyLabel" runat="server" Text='<%# Eval("yy") %>'></asp:Label><br />
            考核次數:
            <asp:Label ID="seqLabel" runat="server" Text='<%# Eval("seq") %>'></asp:Label><br />
            說明:
            <asp:Label ID="DescLabel" runat="server" Text='<%# Bind("Desc") %>'></asp:Label><br />
            <br />
            本次工作目標年度:
            <asp:Label ID="Label4" runat="server" Text='<%# Bind("s_yy") %>'></asp:Label><br />
            本次工作目標次數:
            <asp:Label ID="Label5" runat="server" Text='<%# Bind("s_seq") %>'></asp:Label><br />
            <br />
            <br />
              下次工作目標年度:
           <asp:Label ID="TextBox1" runat="server" Text='<%# Bind("n_yy") %>'>
            </asp:Label><br />
            下次工作目標次數:
              <asp:Label ID="TextBox2" runat="server" Text='<%# Bind("n_seq") %>'>
            </asp:Label><br />
           
            開始時間:
            <asp:Label ID="StdDateLabel" runat="server" Text='<%# Bind("StdDate") %>'></asp:Label><br />
            結束時間:
            <asp:Label ID="EndDateLabel" runat="server" Text='<%# Bind("EndDate") %>'></asp:Label><br />
             輸入時間:
            <asp:Label ID="keydateLabel" runat="server" Text='<%# Bind("keydate") %>'></asp:Label><br />
               考核類別:
               <asp:RadioButtonList ID="efftype" runat="server">
               <asp:ListItem Text="年度考核" Value="A001"></asp:ListItem>
               <asp:ListItem Text="其他考核" Value="S001"></asp:ListItem>
            </asp:RadioButtonList>
            <asp:Label ID="lb_efftype" runat="server" Text='<%# Bind("type") %>' Visible="false"></asp:Label><br />
           
        </ItemTemplate>
         <EmptyDataTemplate>
                         <asp:Button ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                             Text="新增資料" />
                     </EmptyDataTemplate>
    </asp:FormView>
    <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
        InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
        TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter" UpdateMethod="Update">
        <DeleteParameters>
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="yy" Type="Int32" />
            <asp:Parameter Name="seq" Type="Int32" />
            <asp:Parameter Name="Desc" Type="String" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="StdDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="n_yy" Type="Int32" />
            <asp:Parameter Name="n_seq" Type="Int32" />
            <asp:Parameter Name="Original_autoKey" Type="Int32" />
        </UpdateParameters>
        <SelectParameters>
            <asp:ControlParameter ControlID="GridView1" Name="ID" PropertyName="SelectedValue"
                Type="Int32" />
        </SelectParameters>
        <InsertParameters>
            <asp:Parameter Name="yy" Type="Int32" />
            <asp:Parameter Name="seq" Type="Int32" />
            <asp:Parameter Name="Desc" Type="String" />
            <asp:Parameter Name="keydate" Type="DateTime" />
            <asp:Parameter Name="StdDate" Type="DateTime" />
            <asp:Parameter Name="EndDate" Type="DateTime" />
            <asp:Parameter Name="type" Type="String" />
            <asp:Parameter Name="n_yy" Type="Int32" />
            <asp:Parameter Name="n_seq" Type="Int32" />
        </InsertParameters>
    </asp:ObjectDataSource>
</asp:Content>

