<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyFrame.aspx.cs" Inherits="MyFrame" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>eLearning</title>
</head>
<body scroll="no">
    <form id="form1" runat="server">
    <div>
<iframe frameborder="0" width="100%" height="100%" src='<%= Request["url"] + "&TypeCode=" + Request["TypeCode"]  + "&Nobr=" + Request["Nobr"]  + "&PW=" + Request["PW"] %>' style="background-color:White"></iframe>	
    </div>
    </form>
</body>
</html>
