
<html>

<head>
<meta HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=BIG5">
<meta NAME="GENERATOR" CONTENT="Microsoft FrontPage 6.0">
<link HREF="MAIN.CSS" REL="STYLESHEET" TYPE="TEXT/CSS">
<title>�d�߱���</title>
<style>
<!--
table        { background-color: #CCCCCC; border: 0 }
td			 { background-color: #FFFFFF ; font-family: �ө���; font-size: 10pt; height: 30;text-align:"center";}
.td2		 { background-color: #808080 ; font-family: �ө���; font-size: 10pt; height: 30;text-align:"center"; color: #FFFFFF;}
.form_title	 { background-color: #006699 ; font-family: �ө���; font-size: 12pt; height: 32 ;
			   font-weight: bold ; color: #FFFFFF ;text-align:"center"}
.form_foot	 { background-color: #C0C0C0 ; font-size: 1pt; color: #663300 ; height: 1}
-->
</style>
</head>

<body bgcolor="#EFEFEF" background="images/bg.gif">
<%'IF TYPENAME(SESSION("HRCON"))<>"CONNECTION" THEN
	'RESPONSE.REDIRECT "DEFAULT.ASP"
'END IF
SET HRCON=SESSION("HRCON")
MYEAR=YEAR(DATE())
MMONTH=MONTH(DATE())
MDAY=DAY(DATE())
IF MMONTH<=9 THEN
	MMONTH="0"&MMONTH
END IF
IF MDAY<=9 THEN
	MDAY="0"&MDAY
END IF
MDEPT=REQUEST.QUERYSTRING("MDEPT")
IF ISOBJECT(HRCON) THEN
	SQLSTR="SELECT A.NOBR,A.NAME_C,A.PASSWORD,B.MANG,B.DEPT AS DEPT,D.DEPT_TREE,D.D_NAME" & _
			" FROM BASE A,BASETTS B,TTSCODE C,DEPT D" & _
			" WHERE GETDATE() BETWEEN B.ADATE AND B.DDATE" & _
			" AND A.NOBR=B.NOBR" & _
			" AND B.TTSCODE=C.TTSCODE" & _
			" AND B.TTSCODE IN('1','4','6')" & _
			" AND B.DEPT=D.D_NO" & _
			" AND D.DEPT_TREE BETWEEN '"& MDEPT &"'"+" AND '"+MDEPT+"Z'" & _
			" ORDER BY D.DEPT_TREE"
	'RESPONSE.WRITE SQLSTR
	SET RS1=HRCON.EXECUTE(SQLSTR)
ELSE
	RESPONSE.WRITE "�L�k�s����Ʈw"
END IF
%>

<form METHOD="POST" ACTION="TAC02.ASP" ONSUBMIT NAME="FRONTPAGE_FORM1">
  <p><font size="2">�п�ܭn�d�ߪ����:</font><select SIZE="1" NAME="DATATYPE">
    <option SELECTED VALUE="ATTEND">�X�Ը��</option>
    <option VALUE="ABS">�а����</option>
    <option VALUE="OT">�[�Z���</option>
    <option VALUE="YEAR_ABS">�~����</option>
    <option VALUE="OT_ABS">�ɥ���</option>
    <option VALUE="AWARD">���g���</option>
    <option VALUE="CARD">��d���</option>
    <!--option VALUE="TRAIN">�Ш|�V�m���</option>
    <option VALUE="TRATT">�w�w�n�W���ҵ{</option-->
  </select></p>
  <p><font size="2">�d�ߤ���G</font>
  
  <%	response.write SelectLoop(Year(Now)-2,Year(Now)+2,4,Year(Now),"MYEARB") &"�~"
		response.write SelectLoop(1,12,2,Month(Now),"MMONTHB") &"��"
		response.write SelectLoop(1,31,2,Day(Now),"MDAYB") &"�� �� "
		response.write SelectLoop(Year(Now)-2,Year(Now)+2,4,Year(Now),"MYEARE") &"�~"
		response.write SelectLoop(1,12,2,Month(Now),"MMONTHE") &"��"
		response.write SelectLoop(1,31,2,Day(Now),"MDAYE") &"��"
  %></p>
  <table BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="480" HEIGHT="37">
    <tr>
      <td colspan="4" class="form_title">�� �п�ܤH�� (���� <% RESPONSE.WRITE Trim(RS1.FIELDS("DEPT"))%>) ��</td>
    </tr>
    <tr>
      <td class="td2" WIDTH="74" HEIGHT="16">���u�N��</td>
      <td class="td2" WIDTH="120">����m�W</td>
      <td class="td2" WIDTH="100" HEIGHT="16"><font SIZE="2">�����N��</font></td>
      <td class="td2" WIDTH="307" HEIGHT="16"><font SIZE="2">�����W��</font></td>
    </tr>
<%DO WHILE NOT RS1.EOF%>
    <tr>
      <td WIDTH="74" HEIGHT="9"><center><%C=CHR(34)        
RESPONSE.WRITE "<INPUT TYPE="&C&"SUBMIT"&C &" VALUE=" &C& RS1.FIELDS("NOBR")&C &"NAME=" &C&"MNOBR"&C&">"
%></center></td>
      <td WIDTH="120">�@<%
      RESPONSE.WRITE RS1.FIELDS("NAME_C")
      %>
</td>
      <td WIDTH="100" HEIGHT="9"><font SIZE="2">�@<%
	RESPONSE.WRITE RS1.FIELDS("DEPT")          
                  
%> </font></td>
      <td WIDTH="307" HEIGHT="9"><font SIZE="2">�@<%
	RESPONSE.WRITE RS1.FIELDS("D_NAME")               
%> </font></td>
    </tr>
<%RS1.MOVENEXT        
		LOOP%>
  </table>
</form>
</body>
</html>

<%
response.End

'***��檺���e(�}�l�ƭ�,�����ƭ�,�������,�w�]�r��)
Public Function SelectLoop (BData,EData,SLong,DStr,DStr2)	
	If Trim(BData)="" OR Trim(EData)="" OR Trim(SLong)="" OR Trim(DStr)="" Then
		ErrMsg("SelectLoop�ǤJ�ƭȿ��~(" & BData & "," & EData & "," & SLong & "," & DStr & ")")
	End If
	Dim uu,i
	uu=Chr(10)+space(7)+Chr(9)+Chr(9)+Chr(9) '����l�ɦn���I���F�F...
	SelectLoop=""
	BData=CInt(BData)
	EData=CInt(EData)
	For i=BData to EData
		SelectLoop=SelectLoop+"<option value= "& chr(34)& Right("00" & cstr(i),SLong)& chr(34)
		If CInt(DStr)=i Then 	
			SelectLoop=SelectLoop+" selected >"+ Right("00" & cstr(DStr),SLong)+"</option>"+uu
		Else
			SelectLoop=SelectLoop+" >" + Right("00" & cstr(i),SLong)+"</option>"+uu
		End If
	Next
	SelectLoop="<select	name="&m34& DStr2 &m34&" size="&m34&"1"&m34&">" & uu & SelectLoop & "</select>"
End Function
%>