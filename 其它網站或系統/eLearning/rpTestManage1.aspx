<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true" CodeFile="rpTestManage1.aspx.cs" Inherits="rpTestManage1" Title="未命名頁面" %>

<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="CR" %>


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
    <asp:Label ID="Label5" runat="server" Text="依工號查詢"></asp:Label>
    <asp:TextBox ID="txtNobr" runat="server"  Width="80px"></asp:TextBox><br />
     <asp:Button ID="Create_Report" runat="server" Text="查詢" 
        onclick="Create_Report_Click" />
        <br />        
        <br />
    <CR:CrystalReportViewer ID="CrystalReportViewer1" PrintMode="ActiveX" DisplayGroupTree="False" HasToggleGroupTreeButton="False" HasCrystalLogo="False" 
     Width="250px" Height="50px"  runat="server" OnUnload="CrystalReportViewer1_Unload" EnableParameterPrompt="False"  AutoDataBind="true" Visible="false" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="cphR" Runat="Server">
</asp:Content>

