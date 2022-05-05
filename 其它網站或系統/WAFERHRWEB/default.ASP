<%RESPONSE.EXPIRES=True%>
<HTML>
<HEAD><META HTTP-EQUIV="REFRESH" CONTENT="180;URL=http://www.waferworks.com/">
<TITLE>合晶科技出勤查詢網頁</TITLE>
<style>
<!--
.td3			 { background-color: #fefeda ; font-family: 細明體; font-size: 10pt; color: #000000; height: 35;text-align:"center";}

table        { background-color: #CCCCCC; border: 0 }
td			 { background-color: #FFFFFF ; font-family: 細明體; font-size: 10pt; height: 30;text-align:"center";}
.td2		 { background-color: #808080 ; font-family: 細明體; font-size: 10pt; height: 30;text-align:"center"; color: #FFFFFF;}
.form_title	 { background-color: #006699 ; font-family: 細明體; font-size: 12pt; height: 32 ;
			   font-weight: bold ; color: #FFFFFF ;text-align:"center"}
.form_foot	 { background-color: #C0C0C0 ; font-size: 1pt; color: #663300 ; height: 1}

a:active { color: #000099;font-size: 10pt;text-decoration: none;}
a:link { color: #003366; font-size: 10pt; text-decoration: none;}
a:visited { color: #003366;font-size: 10pt; text-decoration: none;}
a:hover { color: #990000; font-size: 10pt; text-decoration: underline;}
-->
</style>
</HEAD>  
<body bgColor="#EFEFEF" text="#000000" topmargin="0" leftmargin="0" background="images/bg.gif">
<CENTER>
<br>
<FORM METHOD="POST" ACTION="MENU.ASP">
<table width="60%"   cellspacing="1" cellpadding="0">
	<tr><td colspan=2 class="form_title">◆ 合 晶 科 技 出 勤 系 統 登 入 ◆</td></tr>
<TR><TD class="td2">員工編號</TD>
	<TD><INPUT TYPE="TEXT" NAME="NOBR" SIZE="10" MAXLENGTH="10"></TD>
	</TR>
<TR><TD class="td2">密碼</TD>
	<TD><INPUT TYPE="password" NAME="PASSWD" SIZE="10" MAXLENGTH="8"></TD></TR>
<TR>
<TD colspan=2 ><INPUT TYPE="SUBMIT" VALUE="登入" NAME="LOGON">
    <INPUT TYPE="RESET"  VALUE="取消" NAME="RESET"></TD></TR>
	<tr><td class="form_foot">.</td></tr>
</TABLE>
<P>
<A HREF="http://www.waferworks.com/" onclick="window.close()">回公司首頁</A> 
</FORM>
</CENTER>
<P><P>
<DL>
 <DT>
 <UL>
 <LI><B><font size="2" COLOR="#006699">說明:</font></B><font size="2" color="#006699">
	</font>
    <UL>
    <LI><font size="2" COLOR="#006699">密碼可英文字母,數字混合,大小寫不拘. </font>
    <LI><font size="2" COLOR="#006699">未登錄時,本畫面將在</font><FONT COLOR="#FF0000" size="2">30</FONT><FONT COLOR="#006699" size="2">秒後自動切換到公司首頁. </FONT>
    </UL>
 </UL>
</DL>           
</BODY>
</HTML>


