<%@ Page Language="C#" AutoEventWireup="true" CodeFile="MyFrame.aspx.cs" Inherits="Abs_MyFrame" %>


<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>對話盒</title>
</head>
<body scroll=no>	
<iframe frameborder=0 width=100% height=100% src='<%= Request["url"] + "&date=" +  Request["date"] + "&id=" +  Request["id"]%>' style="background-color:White"></iframe>	
</body>
</html>
