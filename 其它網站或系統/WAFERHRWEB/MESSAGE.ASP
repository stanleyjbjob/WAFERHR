<HTML>
<HEAD>
<TITLE></TITLE>

<style>
<!--
table        { background-color: #663333; border: 0 }
td			 { background-color: #ffffff ; font-family: 細明體; font-size: 12pt; color: #000000; height: 35;text-align:"center";}
.td2		 { background-color: #ffcccc ; font-family: 細明體; font-size: 10pt; height: 26;text-align:"center";}
.form_title	 { background-color: #663333 ; font-family: 細明體; font-size: 14pt; height: 28 ;
			   font-weight: bold ; color: #fefeda ;text-align:"center"}
.form_foot	 { background-color: #663333 ; font-size: 1pt; color: #696969 ; height: 1}
a:active { color: #cccc99;font-size: 10pt;text-decoration: none;}
a:link { color: #cccc99; font-size: 10pt; text-decoration: none;}
a:visited { color: #cccc99;font-size: 10pt; text-decoration: none;}
a:hover { color: #663333; font-size: 12pt; text-decoration: underline;}
-->
</style>
</HEAD>
<BODY  bgColor="#fefeda">
<CENTER>
<br>
<br>
<br>
<br>
<TABLE WIDTH="60%" cellspacing="1" cellpadding="0">
	<tr><td  class="form_title">■ 系 統 提 示 訊 息 ■</td></tr>
	<TR><TD><br><br><%=SESSION("MESSAGE")%><br><br><br></TD></TR>
	<tr><td class="form_foot">.</td></tr>
</TABLE><P><P>
<INPUT TYPE="button" VALUE="繼續輸入" onclick="window.history.back(5)">
</CENTER>
</BODY>
</HTML>
 