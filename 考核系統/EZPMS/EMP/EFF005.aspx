<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF005.aspx.cs" Inherits="EMP_EFF005" Title="合晶科技績效考核系統（Web版）v1.0" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>評核者查詢</h5>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <asp:Label ID="_yy" runat="server" Visible="False"></asp:Label><asp:Label ID="_seq"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label ID="_dept" runat="server" Visible="False"></asp:Label>
    <asp:MultiView ID="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                DataSourceID="AttendDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                Text="選取" />
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="yy" HeaderText="考核年度" SortExpression="yy" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="seq" HeaderText="考核次數" SortExpression="seq" ItemStyle-HorizontalAlign="Center" />
                    <asp:BoundField DataField="Desc" HeaderText="說明" SortExpression="Desc" />
                    <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                        Visible="False" />
                    <asp:BoundField DataField="StdDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="開始日期"
                        HtmlEncode="False" SortExpression="StdDate" />
                    <asp:BoundField DataField="EndDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="結束日期"
                       HtmlEncode="false"  SortExpression="EndDate" />
                    <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                        SortExpression="autoKey" Visible="False" />
                </Columns>
            </asp:GridView>
            <fieldset id="FIELDSET1" runat="server" visible="false"><legend>直線主管評核</legend>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="NAME_C" HeaderText="主管姓名" SortExpression="NAME_C" />
                    <asp:BoundField DataField="D_NAME" HeaderText="部門" SortExpression="D_NAME" />
                    <asp:BoundField DataField="JOB_NAME" HeaderText="職稱" SortExpression="JOB_NAME" />
                </Columns>
            </asp:GridView>
            </fieldset>
             <fieldset id="FIELDSET2" runat="server" visible="false"><legend>非直線主管評核</legend>
            <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False">
                <Columns>
                    <asp:BoundField DataField="yy" HeaderText="年度"  Visible= "false"/>
                    <asp:BoundField DataField="seq" HeaderText="頻率" Visible= "false"/>
                    <asp:BoundField DataField="assignname" HeaderText="主管姓名" />
                    <asp:BoundField DataField="assigndept" HeaderText="部門"  />
                    <asp:BoundField DataField="assignjob" HeaderText="職稱"  />
                    <asp:BoundField DataField="_mangname" HeaderText="指派者" />
                    <asp:BoundField DataField="_mangdept" HeaderText="部門" Visible= "false" />
                    <asp:BoundField DataField="_mangjob" HeaderText="職稱" Visible= "false" />
                
                </Columns>
            </asp:GridView>
            </fieldset>
            <asp:ObjectDataSource ID="AttendDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter"></asp:ObjectDataSource>
        </asp:View>
        
    </asp:MultiView>
        </ContentTemplate>
    </asp:UpdatePanel>
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
</asp:Content>

