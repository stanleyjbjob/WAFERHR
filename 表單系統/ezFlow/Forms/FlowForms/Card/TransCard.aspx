<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TransCard.aspx.cs" Inherits="Card_TransCard" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>刷卡轉出勤</title>
</head>
<body>
    <form id="form1" runat="server">
    <div>
        工號：<asp:TextBox ID="txtNobr" runat="server">900581</asp:TextBox><br />
        日期：<asp:TextBox ID="txtDate" runat="server">2008/6/25</asp:TextBox>
        <br />
        時間：<asp:Label ID="lblTime" runat="server"></asp:Label><br />
        <asp:Button ID="btnTest" runat="server" OnClick="btnTest_Click" Text="呼叫" /></div>
    </form>
</body>
</html>
