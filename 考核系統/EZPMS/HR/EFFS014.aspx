<%@ Page Language="C#" MasterPageFile="~/MasterPageTemplet.master" AutoEventWireup="true" CodeFile="EFFS014.aspx.cs" Inherits="HR_EFFS014" Title="Untitled Page" %>

<%@ Register Src="../EMP/EFF004.ascx" TagName="EFF004" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:EFF004 ID="EFF004_1" runat="server" />
</asp:Content>

