<HTML>
<HEAD>
<TITLE></TITLE><style>
<!--
table        { background-color: #ffffff; border: 0 }
td			 { background-color: #006699 ; font-family: �ө���; font-size: 10pt; color: #cccccc; height: 26;text-align:"center";}
.td2		 { background-color: #CCccff ; font-family: �ө���; font-size: 10pt; height: 26;text-align:"center";}
.form_title	 { background-color: #696969 ; font-family: �ө���; font-size: 12pt; height: 28 ;
			   font-weight: bold ; color: #fefeda ;text-align:"center"}
.form_foot	 { background-color: #696969 ; font-size: 1pt; color: #696969 ; height: 1}
a:active { color: #000099;font-size: 10pt;text-decoration: none;}
a:link { color: #003366; font-size: 10pt; text-decoration: none;}
a:visited { color: #003366;font-size: 10pt; text-decoration: none;}
a:hover { color: #990000; font-size: 10pt; text-decoration: underline;}
-->
</style>
<base target="MAIN">
</HEAD>

<body bgcolor="#CCCCCC" text="#99CCFF" background="images/bg2.gif">
<table width="100%"   cellspacing="1" cellpadding="0">
<tr><td><center><FONT COLOR="#FFFFFF">�n����</FONT></center></td></tr>
<tr><td><center><FONT COLOR="#FFCC00"><%response.write SESSION("NAME_C")%></FONT></center></td></tr>
</table>

<br>
<p align="center"><A TARGET="MAIN" HREF="TAC01.ASP">�X�Ը��<br>�d��</A></P>

<%
'response.write SESSION("MANG")

	m34=Chr(34)
'IF SESSION("MANG")="True" THEN
		'response.write "<p align="&mm&"center"&mm&">" & _
		'"<a target="&m34&"MAIN"&m34&" href="&m34&"p705.asp"&m34&">���X���<br>ñ��</a></p>"
'End If
%>
<!--<p align="center"><a target="MAIN" HREF="P704.ASP">���X���<br>�s�W</A></p>

<p align="center"><A TARGET="MAIN" HREF="P706.asp">���X���<br>�s��</A></P>
-->
<p align="center"><A TARGET="_parent" a href="default.asp">���s�n�J</a></P>
</BODY>
</HTML>