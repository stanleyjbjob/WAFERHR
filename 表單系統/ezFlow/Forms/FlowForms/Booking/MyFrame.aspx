﻿<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyFrame.aspx.cs" Inherits="Booking_MyFrame" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>對話盒</title>
</head>
<body scroll=no>
<iframe frameborder='0' width='100%' height='100%' scrolling=yes src='<%= Request["url"]%>' style="background-color:White"></iframe>
</body>
</html>
