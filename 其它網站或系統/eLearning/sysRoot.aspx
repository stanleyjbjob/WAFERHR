<%@ Page Language="C#" MasterPageFile="~/mpSystem.master" AutoEventWireup="true" CodeFile="sysRoot.aspx.cs" Inherits="sysRoot" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="cph" Runat="Server">
    請點選左邊的類別。
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <img src="Files/eLearning.JPG" />
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

