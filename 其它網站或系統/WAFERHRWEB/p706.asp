<!-- #INCLUDE FILE="arbhr.INC" -->
<%

'*****�إ��ܼơC
	Dim Rs_saveAbs,Rs_saveAbsMain
	Dim showStr
	Dim conn,nobr,name_c,H_Code,SqlStr, _
		BYear,BMonth,BDay,BHus,BScl, _
		EYear,EMonth,EDay,EHus,EScl, _
		BDATE,EDATE,BTIME,ETIME,YYMM,_
		M_NOBR,M_H_CODE,M_YYMM,DAYS,HHH,_
		M_DAY,M_ROTE,M_UNIT,MAX_NUM
	Dim saveAbsMain(10)
	Dim saveAbs()
	Dim ABS_TOL_HOURS
	Dim HCODEOUT_Count
	Dim UpAbsMain()
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
	mnobr=session("NOBR")
	m34=Chr(34)
	m13=Chr(13)
%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���X��Ʒs�W</title>
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
<%

	If Len(mnobr)=0 Then
		response.write session("NOBR")
		'response.write "<b>�Э��slogin</b><br><br>"&m13
		response.write "<b><A TARGET="& M34 &"_parent"& M34 &" a href="& M34 &"default.asp"& M34 &">���ݮɶ��L���A�Э��s�n�J</a></b><br><br>"

		response.end
	End If

	SQLSTR="SELECT A.NOBR,A.NAME_C" & _
		" FROM BASE A,BASETTS B" & _
		" WHERE a.NOBR='" & mnobr & "'" & _
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
	SQLSTR="SELECT BDATE,BTIME,ETIME,TOL_HOURS,NOTE FROM ABS1" & _
				" WHERE NOBR='" & MNOBR & "'" & _
				" AND H_CODE='O'" & _
				" AND MANG_SIGN='0'" & _
				" AND BDATE > DATEADD (mm,-3,GETDATE())" & _
				" ORDER BY BDATE DESC"

	'RESPONSE.WRITE SQLSTR
	'RESPONSE.END
	SET RS2=CONN.EXECUTE(SQLSTR)
	SQLSTR="SELECT BDATE,BTIME,ETIME,TOL_HOURS,NOTE FROM ABS1" & _
				" WHERE NOBR='" & MNOBR & "'" & _
				" AND H_CODE='O'" & _
				" AND MANG_SIGN='1'" & _
				" AND BDATE > DATEADD (mm,-3,GETDATE())" & _
				" ORDER BY BDATE DESC"

	'response.write SQLSTR
	'response.end
	Set Rs3=conn.execute(sqlstr)
	response.write "<table width="&m34&"100%"&m34& _
					" cellspacing="&m34&"1"&m34& _
					" cellpadding="&m34&"0"&m34& _
					" align="&m34&"center"&m34&">"
	response.write "<tr><td width="&m34&"100%"&m34& _
						" colspan="&m34&"5"&m34& _
						" class="&m34&"form_title"&m34&">�� �� �X �� �� ��</td></tr>"
	response.write "<tr><td colspan="&m34&"5"&m34&">"
	response.write "<table width="&m34&"70%"&m34& _
					" cellspacing="&m34&"0"&m34& _
					" cellpadding="&m34&"0"&m34& _
					" align="&m34&"center"&m34&">"
	response.write "<tr><td>���u�s���G" & Rs1.fields("NOBR") & "</td>"
	response.write "<td>���u�m�W�G" & Rs1.fields("NAME_C") & "</td>"
	'response.write OUT_STR2("mNAME_C",Trim(Rs1.fields("NAME_C")))

	response.write "<td>���O�W�١G���X</td></tr>"
	response.write "</table></td></tr>"
	response.write "<tr>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "<td width="&m34&"50%"&m34&" class="&m34&"form_foot"&m34&">.</td>"
    response.write "</tr>"
	If not Rs2.eof Then
		response.write "<tr>"
	    response.write "<td colspan="&m34&"5"&m34&"><B>�@���֭㤧����</B></td>"
	    response.write "</tr>"
		response.write "<tr><td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а����</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а_�ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�Ш��ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а��ɼ�</td>"
		response.write "<td width="&m34&"50%"&m34&" class="&m34&"td2"&m34&">�X�t�ƥ�</td></tr>"
		Do While Not RS2.EOF
			response.write "<tr>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("BDATE")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("BTIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("ETIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs2.fields("TOL_HOURS")& "�p��</td>"
		    response.write "<td width="&m34&"50%"&m34&">�@"& rs2.fields("NOTE")& "</td>"
		    response.write "</tr>"
			RS2.MOVENEXT
		LOOP
		response.write "<tr>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"50%"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "</tr>"
    End If
	If not Rs3.eof Then
		response.write "<tr>"
	    response.write "<td colspan="&m34&"5"&m34&"><B>�@�w�֭㤧����</B></td>"
	    response.write "</tr>"
		response.write "<tr><td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а����</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а_�ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�Ш��ɶ�</td>"
		response.write "<td width="&m34&"90"&m34&" class="&m34&"td2"&m34&">�а��ɼ�</td>"
		response.write "<td width="&m34&"50%"&m34&" class="&m34&"td2"&m34&">�X�t�ƥ�</td></tr>"
		Do While Not RS3.EOF
			response.write "<tr>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("BDATE")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("BTIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("ETIME")& "</td>"
		    response.write "<td width="&m34&"90"&m34&">�@" & rs3.fields("TOL_HOURS")& "�p��</td>"
		    response.write "<td width="&m34&"50%"&m34&">�@"& rs3.fields("NOTE")& "</td>"
		    response.write "</tr>"
			RS3.MOVENEXT
		LOOP
		response.write "<tr>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"90"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "<td width="&m34&"50%"&m34&" class="&m34&"form_foot"&m34&">.</td>"
	    response.write "</tr>"
	End If
	response.write "</table><br><br><br>"
%>

</body>
</html>
<%
	conn.Close
	Set	conn = Nothing
response.end

response.End	'�קK�{������Ƶ{��

'***�H�U���{���ޥΪ��Ƶ{��***************

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