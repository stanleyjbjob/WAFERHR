<!-- #INCLUDE FILE="arbhr.INC" -->
<%

'*****�إ��ܼơC
	Dim conn,nobr,name_c,H_Code,SqlStr, _
		BDATE,EDATE,BTIME,ETIME,YYMM
	Dim AllErrStr,success
	
'�i�j����������������������������󡰡����m�n�z�{�|�}�u�r�s�q�x�w�t��������������������
'Response.Expires = -1
'Response.AddHeader "Pragma", "no-cache"
'Response.AddHeader "cache-control",	"no-store"
uu=Chr(10)+space(7)+Chr(9)+Chr(9)+Chr(9)
'****
'On Error Resume Next
		SET	conn=SERVER.CREATEOBJECT("ADODB.CONNECTION")
		conn.OPEN ctstr
		
'***Init UID&PWD
	mMANG_NOBR=Trim(session("NOBR"))
	mMANG_NAME_C=Trim(SESSION("NAME_C"))
	m34=Chr(34)
	m13=Chr(13)
%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���X��Ʈ֭�</title>
<style>
<!--
table        { background-color: #000099; border: 0 }
td			 { background-color: #FFFFFF ; font-family: �ө���; font-size: 10pt; height: 30}
.td2		 { background-color: #CCCCFF ; font-family: �ө���; font-size: 10pt; height: 30;text-align:"center";}
.form_title	 { background-color: #000099 ; font-family: �ө���; font-size: 12pt; height: 32 ;
			   font-weight: bold ; color: #EFEFEF ;text-align:"center"}
.form_foot	 { background-color: #000099 ; font-size: 1pt; color: #663300 ; height: 1}
a:link { color: #003366; font-size: 10pt; text-decoration: none;}
a:visited { color: #003366;font-size: 10pt; text-decoration: none;}
a:hover { color: #990000; font-size: 11pt; text-decoration: underline;}
-->
</style>
</head>

<body bgcolor="#EFEFEF" background="images/bg.gif">

<script language="vbscript">
<!--
Sub	datacheck()
	Dim CHK_DATA_OK
	CHK_DATA_OK=True
	m13=chr(13)
	'****�x�s�T�w****

	If CHK_DATA_OK=True Then
		Dim MyVar,MSG_STR
		MSG_STR="�z�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�{" & M13 & _
				"�x�@�@�@�@�@�@�O�_�T�w�x�s�H�@�@�@�@�@�x" & M13 & _
				"�u�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�t" & M13 & _
				"�x�@����x�s��A�L�k�u�W�ק�ΧR���A�@�x" & M13 & _
				"�x�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�x" & M13 & _
				"�x�@�@�@�@�@�@���ԷV�ˬd�C�@�@�@�@�@�@�x" & M13 & _
				"�|�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�}"
				MyVar = MsgBox(MSG_STR,vbOKCancel,"�x�s�T�w")
		If MyVar=1 Then
			form1.submit
		End If
	End If
End	Sub
--></script>

<%

	If Len(mMANG_NOBR)=0 Then
		response.write session("NOBR")
		'response.write "<b>�Э��slogin</b><br><br>"
		response.write "<b><A TARGET="& M34 &"_parent"& M34 &" a href="& M34 &"default.asp"& M34 &">���ݮɶ��L���A�Э��s�n�J</a></b><br><br>"
		response.end
	End If

	SQLSTR="SELECT A.NOBR,A.NAME_C" & _
		" FROM BASE A,BASETTS B" & _
		" WHERE A.NOBR='" & MMANG_NOBR & "'" & _
			" AND A.NOBR = B.NOBR" & _
			" AND GETDATE() BETWEEN B.ADATE  AND B.DDATE" & _
		" ORDER BY A.NOBR"
	Set Rs1=conn.execute(sqlstr)
	If Rs1.eof Then
		response.write "�d�L��ơA�Э��s�n�J�C"
		%>
		<br>
		<A TARGET="_parent" a href="default.asp">���s�n�J</a>
		<%
		response.end
	End If
	
	
	BDate=cstr(date())
	B_YYMM=Date2MkYM(date())
	

	'*******���X����s��
	SQLSTR="SELECT B.NAME_C,A.NOBR,A.BDATE,A.BTIME,A.ETIME,A.TOL_HOURS,A.NOTE" & _
			" FROM ABS1 A,BASE B " & _
				" WHERE A.H_CODE='O'" & _
				" AND A.MANG_SIGN='0'" & _
				" AND A.NOBR=B.NOBR" & _
				" AND A.MANG_NOBR='" & MMANG_NOBR & "'"  & _
				" AND A.BDATE > DATEADD (mm,-3,GETDATE())" & _
				" ORDER BY A.BDATE DESC"

	'response.write SQLSTR
	'response.end
	Set Rs2=conn.execute(sqlstr)
	
	SQLSTR="SELECT B.NAME_C,A.NOBR,A.BDATE,A.BTIME,A.ETIME,A.TOL_HOURS,A.NOTE" & _
			" FROM ABS1 A,BASE B " & _
				" WHERE A.H_CODE='O'" & _
				" AND A.MANG_SIGN='1'" & _
				" AND A.NOBR=B.NOBR" & _
				" AND A.MANG_NOBR='" & MMANG_NOBR & "'"  & _
				" AND A.BDATE > DATEADD (mm,-3,GETDATE())" & _
				" ORDER BY A.BDATE DESC"

	'response.write SQLSTR
	'response.end
	Set Rs3=conn.execute(sqlstr)
	
	response.write "<form method="&m34&"POST"&m34&" action="&m34&"P705_SAVE.asp"&m34&" name="&m34&"form1"&m34&">"
	response.write "<table width="&m34&"100%"&m34& _
					" cellspacing="&m34&"1"&m34& _
					" cellpadding="&m34&"0"&m34& _
					" align="&m34&"center"&m34&">"
	response.write "<tr><td width="&m34&"100%"&m34& _
						" colspan="&m34&"8"&m34& _
						" class="&m34&"form_title"&m34&">�� �� �X �� �� ñ �� ��</td></tr>"
	response.write "<tr><td colspan="&m34&"8"&m34&">"
	response.write "<table width="&m34&"70%"&m34& _
					" cellspacing="&m34&"0"&m34& _
					" cellpadding="&m34&"0"&m34& _
					" align="&m34&"center"&m34&">"
	response.write "<tr><td>���u�s���G" & Rs1.fields("NOBR") & "</td>"
	response.write "<td>�D�ީm�W�G" & Rs1.fields("NAME_C") & "</td>"


	response.write "<td>���O�W�١G���X</td></tr>"
	response.write "</table></td></tr>"
	response.write "<tr>"
    response.write "<td width="&m34&"40"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"35%"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "</tr>"
	If not Rs2.eof Then
		response.write "<tr>"
	    response.write "<td colspan="&m34&"8"&m34&"><B>�@��ñ�֤�����@�@</B>" & _
	    		"<input type="&m34&"button"&m34& _
	    		" value="&m34&"�@�x�s�֭�@"&m34& _
	    		" name="&m34&"B1"&m34& _
	    		" onclick="&m34&"datacheck"&m34&"></td>"
	    response.write "</tr>"
		response.write "<tr>"
		response.write "<td width="&m34&"40"&m34&" class="&m34&"td2"&m34&">ñ��</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">���u�m�W</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">���u�s��</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а����</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а_�ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�Ш��ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а��ɼ�</td>"
		response.write "<td width="&m34&"35%"&m34&" class="&m34&"td2"&m34&">�X�t�ƥ�</td></tr>"
		Data_Count=0
		Do While Not RS2.EOF
			Data_Count=Data_Count+1
			response.write "<tr>"
		    response.write "<td width="&m34&"40"&m34&"><center>"		    
			response.write "<input type="&m34&"checkbox"&m34& _
								 " name="&m34&"MANG_SIGN"& Data_Count &m34& _
								 " value="&m34&"1"&m34&"></center></td>"&UU
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("NAME_C")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & Trim(rs2.fields("NOBR"))& "</td>"
		    response.write "<td width="&m34&"90"&m34&"><center>" & rs2.fields("BDATE")& "</center></td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("BTIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("ETIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("TOL_HOURS")& "�p��</td>"
		    response.write "<td width="&m34&"35%"&m34&">�@"& Trim(rs2.fields("NOTE"))& "</td>"
		    response.write OUT_STR2("NOBR"& Data_Count,Trim(rs2.fields("NOBR")))
		    response.write OUT_STR2("BDATE"& Data_Count,rs2.fields("BDATE"))
		    response.write OUT_STR2("BTIME"& Data_Count,rs2.fields("BTIME"))
		    response.write OUT_STR2("ETIME"& Data_Count,rs2.fields("ETIME"))
		    response.write "</tr>"
			RS2.MOVENEXT
		LOOP
		response.write OUT_STR2("OT_count",Data_Count)
		response.write OUT_STR2("MANG_NOBR",mMANG_NOBR)
		response.write OUT_STR2("MANG_NAME_C",mMANG_NAME_C)
		response.write "<tr>"
	    response.write "<td width="&m34&"40"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"35%"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "</tr>"
    End If
    %>
  <p></p>
</form>
<%
	If not Rs3.eof Then
		response.write "<tr>"
	    response.write "<td colspan="&m34&"8"&m34&"><B>�@�wñ�֤�����</B></td>"
	    response.write "</tr>"
		response.write "<tr>"
		response.write "<td width="&m34&"40"&m34&" class="&m34&"td2"&m34&">ñ��</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">���u�m�W</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">���u�s��</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а����</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а_�ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�Ш��ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а��ɼ�</td>"
		response.write "<td width="&m34&"35%"&m34&" class="&m34&"td2"&m34&">�X�t�ƥ�</td></tr>"
		Do While Not RS3.EOF
			response.write "<tr>"
		    response.write "<td width="&m34&"40"&m34&"><center><img border="&m34&"0"&m34&" SRC="&m34&"MANG_SIGN.BMP"&m34&"></center></td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("NAME_C")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("NOBR")& "</td>"
		    response.write "<td width="&m34&"90"&m34&"><center>" & rs3.fields("BDATE")& "</center></td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("BTIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("ETIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("TOL_HOURS")& "�p��</td>"
		    response.write "<td width="&m34&"35%"&m34&">�@"& Trim(rs3.fields("NOTE"))& "</td>"
		    response.write "</tr>"
			RS3.MOVENEXT
		LOOP
		response.write "<tr>"
	    response.write "<td width="&m34&"40"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"30%"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "</tr>"
	End If
	response.write "</table><br><br><br>"
	
	
	'*******���X��Ʈ֥i�x�s	
'	If Len(Trim(request.form("OT_count")))>0 Then
'		M_OT_count=CInt(Trim(request.form("OT_count")))
'		M_MANG_NOBR=Trim(request.form("MANG_NOBR"))
'		TMP_MANG_NOBR=M_MANG_NOBR
'		TMP_MANG_NAME_C=trim(request.form("MANG_NAME_C"))
'	
'	
'	
'		If M_OT_count>0 Then
'			I=0
'			Do While I < M_OT_count 
'				I=I+1
'					TMP_NOBR=trim(request.form("NOBR"& CStr(I)))
'					
'					BDATE=Trim(request.form("BDATE" & CStr(I))) 					
'					TMP_BDATE=CDate(BDATE)
'					TMP_BTIME=Trim(request.form("BTIME" & CStr(I)))
'					TMP_ETIME=Trim(request.form("ETIME" & CStr(I)))
'					
'					TMP_ok=trim(request.form("MANG_SIGN"& CStr(I)))
'					if TMP_ok="" then
'						TMP_ok=0
'					Else
'						TMP_ok=1
'					End If
'					
'					update_ABS1 TMP_NOBR ,TMP_MANG_NAME_C ,TMP_MANG_NOBR ,TMP_BDATE ,TMP_BTIME ,TMP_ETIME,TMP_MANG_SIGN
'			LOOP
'		End If
'	End If
'	'***��s���X��Ʈ֥i(ABS1)
'						
'	Function update_ABS1(A_NOBR ,A_MANG_NAME_C ,A_MANG_NOBR ,A_BDATE ,A_BTIME ,A_ETIME,A_MANG_SIGN)
'		Dim SqlStr						
'		SQLSTR = "UPDATE ABS1 SET KEY_MAN='" & A_MANG_NAME_C & "', KEY_DATE='" & DATE() & _
'					"', MANG_SIGN='" & A_MANG_SIGN & "'" & _
'				" WHERE NOBR='" & A_NOBR & "'" & _
'					" AND H_CODE='O'" & _
'					" AND MANG_SIGN='0'" & _
'					" AND MANG_NOBR='" & A_MANG_NOBR & "'" & _
'					" AND BDATE='" & A_BDATE & "'" & _
'					" AND BTIME='" & A_BTIME & "'" & _
'					" AND ETIME='" & A_ETIME & "'"
'			response.write SqlStr
'			response.End
'		conn.Execute SqlStr
'		response.write A_NOBR &" ���X��Ƨ�s " & A_BDATE &"<br>"
'	End Function
	
	
	
%>

</body>
</html>
<%
	conn.Close
	Set	conn = Nothing
response.end

response.End	'�קK�{������Ƶ{��

'***�H�U���{���ޥΪ��Ƶ{��***************

'******* ���ÿ�J���(���W�١A���)
Function OUT_STR2(GET_NAME,GET_VALUE)
	OUT_STR2="<input type="&m34&"HIDDEN"&m34&" name="&m34& GET_NAME &m34&"  value="&m34& GET_VALUE &m34&">"
End	Function

Public Sub ErrMsg(DATA)
	if Err.Number<>0 then
		response.write "<br><br>�{���o�Ϳ��~,�бN�U�������~�ذ_��.�ǵ������H���B�z.<br><br>"

		response.write "<table border='1'>"
	Response.Write "<tr><td><br>&nbsp; ���Ϳ��~����l�X: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	&Err.Source	& "&nbsp;</td></tr>	 "
	Response.Write "<tr><td><br>&nbsp; COM�зǿ��~�X: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Number & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; �{���ɮצW��: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.File & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; ���~�{���X�����: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Line & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; ���~���ӷ�: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Category & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; ���~��]²��: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Description & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; �Բӿ��~��]: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.ASPDescription &"&nbsp;</td></tr> <table>"
		'response.write	"  ���~�X��[ " & CStr(Err.Number) &	"]<br><br>	" &	Err.Description	& "<br><br>	 "&	Err.Source
	Err.Clear
	end	if
End	Sub

%><!-- #INCLUDE FILE="SIECS-ULT.INC" -->