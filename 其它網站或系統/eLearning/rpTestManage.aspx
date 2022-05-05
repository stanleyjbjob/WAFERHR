<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true" CodeFile="rpTestManage.aspx.cs" Inherits="rpTestManage" Title="未命名頁面" %>

<%@ Register Assembly="Microsoft.ReportViewer.WebForms, Version=9.0.0.0, Culture=neutral, PublicKeyToken=b03f5f7f11d50a3a"
    Namespace="Microsoft.Reporting.WebForms" TagPrefix="rsweb" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
<asp:Label ID="Label1" runat="server" Text="考試日期"></asp:Label>
    <asp:TextBox ID="txtDate" runat="server"  Width="75px"></asp:TextBox><br />
    <asp:Label ID="Label2" runat="server" Text="查詢日期"></asp:Label>
    <asp:TextBox ID="txtDateB" runat="server"  Width="75px"></asp:TextBox>
    <asp:Label ID="Label3" runat="server" Text="至"></asp:Label>
    <asp:TextBox ID="txtDateE" runat="server"  Width="75px"></asp:TextBox><br />
    <asp:Label ID="Label4" runat="server" Text="依部門"></asp:Label>   
    <asp:DropDownList ID="ddlDept" runat="server" AppendDataBoundItems="True" DataSourceID="odsDept"   DataTextField="sDeptName" DataValueField="sDeptCode">
    <asp:ListItem Value="0">全部</asp:ListItem>   </asp:DropDownList>
    <asp:ObjectDataSource ID="odsDept" runat="server" OldValuesParameterFormatString="original_{0}"
                      SelectMethod="GetData" TypeName="SysDSTableAdapters.DeptTableAdapter"></asp:ObjectDataSource>  <br />
                                                                    <asp:CheckBox ID="ckM" runat="server" Text="儲存格合併" />
                                                                <br />
    <asp:Label ID="Label5" runat="server" Text="依工號查詢"></asp:Label>
    <asp:TextBox ID="txtNobr" runat="server"  Width="80px"></asp:TextBox><br />
     <asp:Button ID="Create_Report" runat="server" Text="查詢" 
        onclick="Create_Report_Click" />
        <br />        
        <br />
     <rsweb:ReportViewer ID="ReportViewer1" runat="server" Visible="False" Width="1000px" DocumentMapWidth="50%">
    </rsweb:ReportViewer>
     <br />        
        <br />
        
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphR" Runat="Server">
   


   

</asp:Content>

