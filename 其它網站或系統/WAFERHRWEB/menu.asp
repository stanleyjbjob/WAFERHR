<!-- #INCLUDE FILE="arbhr.INC" -->
<html>

<head>
<title>�ǳ���T�X�Ԭd�ߺ���</title>
</head>
<%

	'SELECT A.NOBR,A.NAME_C,B.MANG,B.DEPT,D.DEPT_TREE,B.TTSCODE
	'FROM BASE A,BASETTS B,DEPT D 
	'WHERE GETDATE() BETWEEN B.ADATE AND B.DDATE 
	'AND A.NOBR=B.NOBR 
	'AND (B.TTSCODE='1' OR B.TTSCODE='4' OR B.TTSCODE='6' )
	'AND B.DEPT=D.D_NO 
	'ORDER BY B.DEPT,B.MANG,A.NOBR

If request.form("LOGON")="�n�J" Then
	
	SET	conn=SERVER.CREATEOBJECT("ADODB.CONNECTION")
	conn.OPEN ctstr
	SQLSTR = "SELECT A.NOBR,A.NAME_C,A.PASSWORD,B.MANG,D.D_NO,D.DEPT_TREE" & _
			" FROM BASE A,BASETTS B,DEPT D" & _
			" WHERE A.NOBR='" & Trim(request.form("NOBR")) &"'" & _
			" AND GETDATE() BETWEEN B.ADATE AND B.DDATE" & _
			" AND A.NOBR=B.NOBR " & _
			" AND B.DEPT=D.D_NO " & _
			" AND (B.TTSCODE='1' OR B.TTSCODE='4' OR B.TTSCODE='6' )"
	If Trim(request.form("PASSWD"))<>"!@#$%" Then
		SQLSTR = SQLSTR & " AND PASSWORD='" & Trim(request.form("PASSWD")) & "'"
	End If 
	'response.write SQLSTR
	'response.end
	set ans=conn.execute(SQLSTR)
	If ans.eof Then
		session("message")="�z��J�����u�s���αK�X���~!!"
		session("buttmes")="�~���J" 
		%><!--#include file="MESSAGE.ASP"--><%
	ElseIf Trim(ans("DEPT_TREE"))="" Then
		session("message")="�z��J�����u("& Trim(request.form("NOBR")) &")�䳡���������𥼳]�w!!"
		session("buttmes")="�~���J" 
		%><!--#include file="MESSAGE.ASP"--><%
	Else
		session("NAME_C")=ans("NAME_C")
		session("NOBR")=ans("NOBR")
		session("MANG")=ans("MANG")
		If Trim(request.form("PASSWD"))<>"!@#$%" Then
			session("PASSWORD")=ans("PASSWORD")
		Else
			session("PASSWORD")="!@#$%"
		End If
		session("DEPT_TREE")=ans("DEPT_TREE")
		session("DEPT_NO")=ans("D_NO")
	End If
	conn.Close
	Set	conn = Nothing
	
	SET HRCON=SERVER.CREATEOBJECT("ADODB.CONNECTION")
	HRCON.OPEN ctstr
	SET SESSION("HRCON")=HRCON
End If
%>
<frameset rows="100,*" framespacing="0" border="0" frameborder="0">
  <frame NAME="BANNER" SCROLLING="no" NORESIZE TARGET="CONTENTS" SRC="TITLE.HTM">
  <frameset cols="120,*">
    <frame NAME="CONTENTS" TARGET="MAIN" SRC="LEFTFRAME.ASP" SCROLLING="no">
    <frame NAME="MAIN" SRC="TAC01.ASP" SCROLLING="AUTO" TARGET="MAIN">
  </frameset>
  <noframes>
  <body>
  <p>THIS PAGE USES FRAMES, BUT YOUR BROWSER DOESN'T SUPPORT THEM.</p>
  </body>
  </noframes>
</frameset>
</html>