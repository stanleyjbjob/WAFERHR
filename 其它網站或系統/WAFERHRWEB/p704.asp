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
	
'*****�ѼƩw�q
	mnobr=session("NOBR")
	mNAME_C=session("NAME_C")
	m34=Chr(34)
	m13=Chr(13)
	
	'M_NOBR=UCase(Trim(request.form("mnobr")))
	'name_c=UCase(Trim(request.form("mNAME_C")))
	M_NOBR=Trim(session("NOBR"))
	mNAME_C=Trim(session("NAME_C"))
	
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
'	mIDNO=UCase(Trim(request.form("mIDNO")))
'	mnobr=UCase(Trim(request.form("mnobr")))
%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>���X��Ʒs�W</title>
<style>
<!--
table        { background-color: #CCCCCC; border: 0 }
td			 { background-color: #FFFFFF ; font-family: �ө���; font-size: 10pt; height: 30;text-align:"center";}
.td2		 { background-color: #808080 ; font-family: �ө���; font-size: 10pt; height: 30;text-align:"center"; color: #FFFFFF;}
.form_title	 { background-color: #006699 ; font-family: �ө���; font-size: 12pt; height: 32 ;
			   font-weight: bold ; color: #FFFFFF ;text-align:"center"}
.form_foot	 { background-color: #C0C0C0 ; font-size: 1pt; color: #663300 ; height: 1}
a:link { color: #003366; font-size: 10pt; text-decoration: none;}
a:visited { color: #003366;font-size: 10pt; text-decoration: none;}
a:hover { color: #990000; font-size: 11pt; text-decoration: underline;}

-->
</style>
</head>

<body bgcolor="#EFEFEF" background="images/bg.gif"><script language="vbscript">
<!--
Sub	datacheck()
	Dim CHK_DATA_OK
	CHK_DATA_OK=True
	DIM BDATE,EDATE
	m34=chr(34)
	m13=chr(13)

	BDATE=form1.BDATE_year.value &"/"& form1.BDATE_MON.value &"/"& form1.BDATE_DAY.value
	EDATE=form1.EDATE_year.value &"/"& form1.EDATE_MON.value &"/"& form1.EDATE_DAY.value
	BTIME=form1.BTIME_HOUR.value & form1.BTIME_SEC.value
	ETIME=form1.ETIME_HOUR.value & form1.ETIME_SEC.value

	'****�򥻸�Ƭd��****
	If IsDate(BDATE)=False Then
		MsgBox "�а�����_��J���~!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.BDATE_DAY.focus
	ElseIf IsDate(EDATE)=False Then
		MsgBox "�а��������J���~!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.EDATE_DAY.focus
	ElseIf form1.BDATE_year.value<>form1.EDATE_year.value Then
		MsgBox "���i��~!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.EDATE_year.focus
	ElseIf form1.BDATE_MON.value<>form1.EDATE_MON.value Then
		MsgBox "���i���!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.EDATE_MON.focus
	ElseIf CDate(BDATE)>CDate(EDATE) Then
		MsgBox "�а���������j��а�����_!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.EDATE_DAY.focus
	ElseIf CDate(BDATE)=CDate(EDATE) and CDate(BTIME)>CDate(ETIME) Then
		MsgBox "�а��ɶ������j��а��ɶ��_!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.ETIME_HOUR.focus
	ElseIf CDate(BDATE)=CDate(EDATE) and CDate(BTIME)=CDate(ETIME) Then
		MsgBox "�а��_������νа��_���ɶ������ۦP!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.ETIME_HOUR.focus
	ElseIf Len(Trim(form1.NOTE.value))=0 Then
		MsgBox "�X�t�ƥѤ��i���ŭ�!! �Э��s��J.",,"��J���~"
		CHK_DATA_OK=False
		form1.NOTE.focus
	End If

	'****�x�s�T�w****

	If CHK_DATA_OK=True Then
		Dim MyVar,MSG_STR
		MSG_STR="�z�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�{" & M13 & _
				"�x�@�@�@�@�@�@�O�_�T�w�x�s�H�@�@�@�@�@�x" & M13 & _
				"�|�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�}" & M13 & M13 & _
				"�@�i�а�����_�j" & BDATE & M13 & _
				"�@�i�а��ɶ��_�j" & BTIME & M13 & _
				"�@�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�@" & M13 & _
				"�@�i�а�������j" & EDATE & M13 & _
				"�@�i�а��ɶ����j" & ETIME & M13 & _
				"�@�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�@" & M13 & _
				"�@�i�X�t�@�ƥѡj" & Trim(form1.NOTE.value) & M13 & M13 & _
				"�z�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�{" & M13 & _
				"�x�@����x�s��A�L�k�u�W�ק�ΧR���A�@�x" & M13 & _
				"�x�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�@�x" & M13 & _
				"�x�@�@�@�@�@�@���ԷV�ˬd�C�@�@�@�@�@�@�x" & M13 & _
				"�|�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�w�}"
				MyVar = MsgBox(MSG_STR,vbOKCancel,"�x�s�T�w")
		If MyVar=1 Then
			form1.submit
		Else
			form1.NOTE.focus()
		End If
	End If
End	Sub
--></script>
<%

'���X��ƿ�J
	'�������
	If Len(mnobr)=0 Then
		response.write "<b><A TARGET="& M34 &"_parent"& M34 &" a href="& M34 &"default.asp"& M34 &">���ݮɶ��L���A�Э��s�n�J</a></b><br><br>"
		response.end
	'ElseIf Len(mIDNO)=0 Then
	'		response.write "<b>�����Ҹ����i�ť�</b><br><br>"&m13
	'		response.end
	End If

	SQLSTR="SELECT A.NOBR,A.NAME_C" & _
		" FROM BASE A,BASETTS B" & _
		" WHERE A.NOBR='" & MNOBR & "'" & _
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
	
	'���ͥD�޸��
	
'		'�ǥѳ����𲣥ͥD�ީm�W�Τu��
'		mDEPT_TREE=Trim(session("DEPT_TREE"))
'		lDEPT_TREE=Left(mDEPT_TREE,Len(mDEPT_TREE)-1)
'		
'		SqlStr= " SELECT A.NOBR,A.NAME_C" & _
'				" FROM BASE A,BASETTS B,DEPT D " & _
'				" WHERE GETDATE() BETWEEN B.ADATE AND B.DDATE " & _
'					" AND A.NOBR=B.NOBR " & _
'					" AND (B.TTSCODE='1' OR B.TTSCODE='4' OR B.TTSCODE='6' )" & _
'					" AND B.DEPT=D.D_NO" & _
'					" AND B.MANG=1" & _
'					" AND DEPT_TREE BETWEEN '" & lDEPT_TREE & "' AND '" & mDEPT_TREE & "'" & _
'				" ORDER BY B.DEPT,B.MANG,A.NOBR"


		'�^�����������D�ޤζ��������D��
		SqlStr= " SELECT A.NOBR, A.NAME_C" & _
				" FROM BASE A,DEPT B" & _
				" WHERE B.D_NO='" & Trim(session("DEPT_NO")) & "'" & _
				" AND (B.D_NA=A.NOBR OR B.I_NA=A.NOBR)"
				
		'response.write SqlStr
		'response.end
		
	Set	ans1=conn.execute(SqlStr)
	
	BDate=cstr(date())
	B_YYMM=Date2MkYM(date())
	
	'*****�H�U�̦����u�s��,���ͤW�U�Z�ɶ�
	Dim RV_ROTE

	sql_str="SELECT A.*,B.*,C.DEPTS"& _
			" FROM ATTEND A,ROTE B,BASETTS C"& _
			" WHERE A.ROTE=B.ROTE"& _
			" AND A.NOBR='" & mnobr & "'"& _
			" AND A.ADATE='" & BDate & "'"& _
			" AND '" & BDate & "' BETWEEN C.ADATE AND C.DDATE"& _
			" AND A.NOBR = C.NOBR"
	Set RV_ROTE=conn.execute(sql_str)
	If RV_ROTE.eof  Then
		sql_str="SELECT A.ROTE,A.DEPTS,B.*"& _
				" FROM BASETTS A,ROTE B"& _
				" WHERE A.NOBR='" & mnobr& "'"& _
				" AND '" & BDate & "' BETWEEN A.ADATE AND A.DDATE"& _
				" AND A.ROTE=B.ROTE"
				
		'response.write sql_str
		'response.end
		
		Set RV_ROTE=conn.execute(sql_str)
		If RV_ROTE.eof  Then
			CloseObj(RV_ROTE)
			AllErrStr=AllErrStr& "��L������u"& mnobr &"�Z�O�ɸ��.�L�k�s�W�а����!!"
			If AllErrStr<>"" Then  ErrTURN(AllErrStr)	'�Y�����~,�פ����
		End If
	End If			


	If RV_ROTE("ROTE")="00" Then
		BT1="00"
		BT2="00"
		ET1="00"
		ET2="00"
	Else
		ON_TIME=RV_ROTE("ON_TIME")
		BT1=Left(RV_ROTE("ON_TIME"),2)
		BT2=Right(RV_ROTE("ON_TIME"),2)
		ET1=Left(RV_ROTE("OFF_TIME"),2)
		ET2=Right(RV_ROTE("OFF_TIME"),2)
		CloseObj(RV_ROTE)
	End If
	

	sBDATE_year=Trim(request.form("BDATE_YEAR"))
	If Len(sBDATE_year)<=0 Then
		sBDATE_year=Year(Now)
	End If
	
	sBDATE_MON=Trim(request.form("BDATE_MON")) 
	If Len(sBDATE_MON)<=0 Then
		sBDATE_MON=Month(Now)
	End If
	sBDATE_DAY=Trim(request.form("BDATE_DAY"))
	If Len(sBDATE_DAY)<=0 Then
		sBDATE_DAY=Day(Now)
	End If
	sEDATE_year=Trim(request.form("EDATE_YEAR"))
	If Len(sEDATE_year)<=0 Then
		sEDATE_year=Year(Now)
	End If
	sEDATE_MON=Trim(request.form("EDATE_MON"))
	If Len(sEDATE_MON)<=0 Then
		sEDATE_MON=Month(Now)
	End If
	sEDATE_DAY=Trim(request.form("EDATE_DAY"))
	If Len(sEDATE_DAY)<=0 Then
		sEDATE_DAY=Day(Now)
	End If
	sBTIME_HOUR=Trim(request.form("BTIME_HOUR")) 
	If Len(sBTIME_HOUR)<=0 Then
		sBTIME_HOUR=BT1
	End If
	sBTIME_SEC= Trim(request.form("BTIME_SEC"))
	If Len(sBTIME_SEC)<=0 Then
		sBTIME_SEC=BT2
	End If
	sETIME_HOUR=Trim(request.form("ETIME_HOUR")) 
	If Len(sETIME_HOUR)<=0 Then
		sETIME_HOUR=ET1
	End If
	sETIME_SEC=Trim(request.form("ETIME_SEC"))
	If Len(sETIME_SEC)<=0 Then
		sETIME_SEC=ET2
	End If
	sNOTE=Trim(request.form("NOTE"))	
	If Len(sNOTE)<=0 Then
		sNOTE=""
	End If
	

%>
<form method="POST"	action="P704.asp" name="form1" >

<!--table width="600" cellspacing="1" cellpadding="0" align="center"-->
<table width="100%" cellspacing="1" cellpadding="0" align="center">
	<tr><td colspan="4" class="form_title">�� �� �X �� �� �s �W ��</td></tr>
	<tr>
		<td width="90" class="td2">�а�����_</td>
		<%
		response.write OUT_STR2("mIDNO",mIDNO)
		response.write OUT_STR2("mnobr",mnobr)
		response.write "<td>�@" & _
					   SelectLoop(Year(Now)-1,Year(Now)+1,4,sBDATE_year,"BDATE_year") &"�~"
		response.write SelectLoop(1,12,2,sBDATE_MON,"BDATE_MON") &"��"
		response.write SelectLoop(1,31,2,sBDATE_DAY,"BDATE_DAY") &"��</td>"
		%>
		<td width="90" class="td2">�а������</td>
		<%
		response.write "<td>�@" & _
					   SelectLoop(Year(Now)-1,Year(Now)+1,4,sEDATE_year,"EDATE_year") &"�~"
		response.write SelectLoop(1,12,2,sEDATE_MON,"EDATE_MON") &"��"
		response.write SelectLoop(1,31,2,sEDATE_DAY,"EDATE_DAY") &"��</td>"
		%>
		</tr>
	<tr>
 		<td width="90" class="td2">�а_�ɶ�</td>
 		<%
		response.write "<td>�@" & SelectLoop(00,23,2,sBTIME_HOUR,"BTIME_HOUR") & "��"
		response.write SelectLoop(00,59,2,sBTIME_SEC,"BTIME_SEC") &"��</td>"
		%>
		<td width="90" class="td2">�Ш��ɶ�</td>
 		<%
		response.write "<td>�@" & SelectLoop(00,23,2,sETIME_HOUR,"ETIME_HOUR") & "��"
		response.write SelectLoop(00,59,2,sETIME_SEC,"ETIME_SEC") &"��</td>"
		%>
		</tr>
	<tr>
		<td width="90" class="td2">�X�t�ƥ�</td>
		<%
		response.write "<td colspan="&m34&"3"&m34&">�@" & inputSTR2 ("text","NOTE" ,35,sNOTE,10) & "<td>"
		%>
		</tr>
	<%
	If NOT ans1.EOF Then
	%>
	<tr>
		<td width="90" class="td2">�֥i�D��</td>
		<%
			response.write "<td colspan="&m34&"3"&m34&">�@" & SelectMANG("","MANG_NOBR") & "<td>"
		%>
		</tr>
	<%
	Else
		response.write OUT_STR2("MANG_NOBR","")
	End If %>
	<tr>
		<td colspan="4"><br><center>
		<input type="button" value="�@�x�@�@�s�@" name="B1" onclick="datacheck"></center><br></td>
		</tr>
	<tr><td class="form_foot">.</td>
	<td class="form_foot">.</td>
	<td class="form_foot">.</td>
	<td class="form_foot">.</td></tr>
	</table>
<br>
<br>
</body>
</html>
<%
'*******���X����x�s	

	MBDATE=Trim(request.form("BDATE_YEAR")) &"/"& _
			Trim(request.form("BDATE_MON")) &"/"& _
			Trim(request.form("BDATE_DAY"))
	MEDATE=Trim(request.form("EDATE_YEAR")) &"/"& _
			Trim(request.form("EDATE_MON")) &"/"& _
			Trim(request.form("EDATE_DAY"))
	MBTIME=Trim(request.form("BTIME_HOUR")) & Trim(request.form("BTIME_SEC"))
	METIME=Trim(request.form("ETIME_HOUR")) & Trim(request.form("ETIME_SEC"))
	MNOTE=Trim(request.form("NOTE"))	
	M_MANG_NOBR=Trim(request.form("MANG_NOBR"))
'	M_H_CODE= request.form("h_code")	
	
	If Len(MNOTE)>0 Then
	
		M_H_CODE= "O"	'���O�N��
		BDATE	= CStr(MBDATE)
		EDATE	= CStr(MEDATE)
		BTIME	= CStr(MBTIME)
		ETIME	= CStr(METIME)
		M_YYMM	= Date2MkYM(MBDATE)
		success = True
		AllErrStr=""
		'response.write "�}�l���" & BDATE & "<BR>"
		'response.write "�������" & EDATE & "<BR>"
		'response.write "�}�l�ɶ�" & BTIME & "<BR>"
		'response.write "�����ɶ�" & ETIME & "<BR>"
		'response.write "�а���]" & MNOTE & "<BR>"
		'response.write "�а��~��" & M_YYMM & "<BR>"	
		BDATE	= MoveDate(MBDATE)
		EDATE	= MoveDate(MEDATE)
		
		'*****�H�U����J����_ok
		If BDATE = False Then AllErrStr = AllErrStr&"[�}�l�����J���~]<br>"
		If EDATE = False Then AllErrStr = AllErrStr&"[���������J���~]<br>"
		If EDATE < BDATE Then AllErrStr = AllErrStr&"[�а���������j��а�����_]<br>"
		If M_YYMM<>Date2MkYM(EDATE) Then AllErrStr = AllErrStr&"[���i���]<br>"
		If AllErrStr<>"" Then  ErrTURN(AllErrStr)	'�Y�����~,�פ����
	
		'*****�w�q�`��DAYS�P�ܼ�
		DAYS=CInt(DateDiff("d", BDATE, EDATE))
		ReDim saveAbs(DAYS,17)
		ABS_TOL_HOURS=0
	
		'*****���ͨC��а����
		Dim Run_DATE,RUN_BTIME,RUN_ETIME,Sub_HOURS
		Dim M_TOL_HOURS,M_ABS_HOURS,K
			K=0
		For HHH=0 TO DAYS
			Run_DATE = DateAdd("d", HHH, BDATE)
			Dim RQ_ABS
			SqlStr="SELECT A.BTIME ,A.ETIME FROM ABS1 A" & _
				" WHERE A.NOBR='" & M_NOBR & _
				"' AND A.BDATE='" & Run_DATE & _
				"' AND A.H_CODE='" & M_H_CODE & "'"
			Set	 RQ_ABS=conn.execute(SqlStr)
			If NOT RQ_ABS.eof Then
				AllErrStr=AllErrStr&"���u�s�� " & M_NOBR & _
					" �w��[" & CStr(Run_DATE) & "]" & _
					" ["&RQ_ABS("BTIME")&"]" & _
					" ["&RQ_ABS("ETIME")&"]�����X"
			End If
			CloseObj(RQ_ABS)
			
			dim ATTEND,RQ_TMTABLE,dd,rote
			
			SqlStr="SELECT ROTE FROM ATTEND "
			SqlStr=SqlStr &	" WHERE	NOBR='" & mnobr
			SqlStr=SqlStr &	"' AND ADATE=" & Run_DATE
	'		Response.Write SqlStr & "<br><br>"
			
			Set	ATTEND=conn.execute(SqlStr)
			IF not ATTEND.eof Then
				ROTE=ATTEND("ROTE")
			else
				SqlStr="SELECT * FROM TMTABLE "
				SqlStr=SqlStr &	" WHERE	NOBR='"& mnobr
				SqlStr=SqlStr &	"' AND YYMM='" & M_YYMM & "'"
				
	'			Response.Write SqlStr & "<br><br>"
				
				Set	RQ_TMTABLE=conn.execute(SqlStr)
				'ErrTURN(SqlStr)
				If RQ_TMTABLE.eof Then
					ErrTURN("�����u�L"& Run_DATE &"�X�Ը�ƻP" & M_YYMM & "�Z����.")
				else
					DD="d"&  CStr(Day(Run_DATE))
					ROTE=RQ_TMTABLE(DD)
				End	If
				CloseObj(RQ_TMTABLE)
			END	IF
			CloseObj(ATTEND)
			
			sql_str="SELECT B.*"& _
					" FROM ROTE B"& _
					" WHERE B.ROTE='" & ROTE & "'"
			Set RV_ROTE=conn.execute(sql_str)
			If RV_ROTE.eof  Then
				CloseObj(RV_ROTE)
				AllErrStr=AllErrStr& "��L������u"& mnobr &"�Z�O�ɸ��.�L�k�s�W"+cstr(Run_DATE)+"�а����!! <BR>"
			End If
			
	
			If AllErrStr<>"" Then  ErrTURN(AllErrStr)	'�Y�����~,�פ����
	
			If ROTE="00" Then
				saveAbs(HHH,0)="NoData"
			Else  	
				M_UNIT="�p��"
				MAX_NUM=0
				If Run_DATE=BDATE Then RUN_BTIME=BTIME Else RUN_BTIME=RV_ROTE("ON_TIME")
				If Run_DATE=EDATE Then RUN_ETIME=ETIME Else RUN_ETIME=RV_ROTE("OFF_TIME")
				'get Hours '�p��а��ɼ�
				Sub_HOURS=GetHouseSub(RUN_BTIME,RUN_ETIME,RV_ROTE("ON_TIME"),RV_ROTE("OFF_TIME"), _
						  RV_ROTE("WK_HRS"),RV_ROTE("RES_B_TIME"),RV_ROTE("RES_E_TIME"),"�p��",1)
				If Sub_HOURS=0 Then 
					saveAbs(HHH,0)="NoData"
				Else
					K=K+1
					saveAbs(HHH,0)=M_YYMM
					saveAbs(HHH,1)=M_NOBR
					saveAbs(HHH,2)=M_H_CODE
					saveAbs(HHH,3)=M_UNIT
					saveAbs(HHH,4)=Run_DATE
					'saveAbs(HHH,5)=LastDateOfMonth(Run_DATE,1)
					saveAbs(HHH,5)=Run_DATE
					saveAbs(HHH,6)=mNAME_C
					saveAbs(HHH,7)=FormatDateTime(Now,2)
					M_TOL_HOURS=Sub_HOURS
					M_ABS_HOURS=Sub_HOURS
					saveAbs(HHH,8)=M_TOL_HOURS
					saveAbs(HHH,9)=M_ABS_HOURS
					saveAbs(HHH,10)=RUN_BTIME
					saveAbs(HHH,11)=RUN_ETIME
					saveAbs(HHH,12)=MNOTE
					saveAbs(HHH,13)=M_MANG_NOBR
				End If
		
				'****�p���`�а���
					ABS_TOL_HOURS=ABS_TOL_HOURS+Sub_HOURS
				'******
			End If
		Next		
		response.write "�`�а��ѼƬ� "  & K & "��<br>"
		response.write "�`�а��ɼƬ� " & ABS_TOL_HOURS & "�p��<BR><BR>"
	
		If Err.Number<>0 then 
			ErrMsg(Err.Number)
			response.end
		Else
		
		End If
		
		'***�x�s
		If AllErrStr<>"" Then
			ErrTURN(AllErrStr)	'�Y�����~,�פ����
		Else
			'***�s�W
			Dim Rs_ADD
			Set Rs_ADD = Server.CreateObject("ADODB.Recordset")
			SqlStr="SELECT * FROM ABS1 "
			Rs_ADD.cursorlocation=3
			Rs_ADD.CURSORTYPE=1
			Rs_ADD.LOCKTYPE=4
			Rs_ADD.OPEN SqlStr,conn,,,1
			For HHH=0 TO DAYS	'�s�W�а�
				If saveAbs(HHH,0)<> "NoData" Then
					Add_Abs saveAbs(HHH,0),saveAbs(HHH,1),saveAbs(HHH,2),saveAbs(HHH,3),saveAbs(HHH,4), _
							saveAbs(HHH,5),saveAbs(HHH,6),saveAbs(HHH,7),saveAbs(HHH,8),saveAbs(HHH,9), _
							saveAbs(HHH,10),saveAbs(HHH,11),saveAbs(HHH,12),saveAbs(HHH,13)
				End If
			Next
			CloseObj(Rs_ADD)
		End If
	
		showStr= "���榸�Ƭ� "  & CStr(DAYS+1)& "��<br>"
	    showStr=showStr+ "<br>�s�W���\"
		response.write showStr		
	End If


	conn.Close
	Set	conn = Nothing

response.End	'�קK�{������Ƶ{��

'***�H�U���{���ޥΪ��Ƶ{��***************

'******* �U�Ԧ��ﶵ�i�����D�ޡj*******
Function SelectMANG(DStr,DStr2)
	Dim uu,C_Str
	uu=Chr(10)+space(7)+Chr(9)+Chr(9)+Chr(9)
	If NOT ans1.EOF Then
		ans1.movefirst
		do while not ans1.eof
			SelectMANG=SelectMANG+"<option value=" & Trim(ans1("NOBR"))
			SelectMANG=SelectMANG + ">" & Trim(ans1("NAME_C")) & "</option>"+uu
			ans1.movenext
		loop
	End If
	'SelectMANG="<option	value="&m34&"NONE"&m34&">�п��</option>" & SelectMANG
	SelectMANG="<select	name="&m34& DStr2 &m34&" size="&m34&"1"&m34&">" & uu & SelectMANG & "</select>"+uu
End Function

'***�s�W�а�

'	Function Add_Abs(A_YYMM,A_NOBR,A_H_CODE,A_UNIT,A_BDATE, _
'					A_EDATE,A_KEY_MAN,A_KEY_DATE,A_TOL_HOURS,A_ABS_HOURS, _
'					A_BTIME,A_ETIME,A_NOTE,A_MANG_NOBR)
	Function Add_Abs(A_0,A_1,A_2,A_3,A_4, _
					 A_5, A_6,A_7,A_8,A_9, _
					 A_10,A_11,A_12,A_13)
		Dim FieldName,I
		With Rs_ADD
			.addnew
			For i=0 to .fields.count-1
				FieldName=.fields(i).name
				Select CASE .fields(fieldname).TYPE
 				Case 129
		  			.fields(fieldname)=""
 				Case 5
		 		 	.fields(fieldname)=0
 				Case 135
				  	.fields(fieldname)=cdate(0)
 				Case 131
				  	.fields(fieldname)=0
				Case 11
				  	.fields(fieldname)=0
 				End Select
			Next
			Rs_ADD("YYMM")=A_0
			Rs_ADD("NOBR")=A_1
			Rs_ADD("H_CODE")=A_2
			'Rs_ADD("UNIT")=A_3
			Rs_ADD("BDATE")=A_4
			Rs_ADD("EDATE")=A_5
			Rs_ADD("KEY_MAN")=A_6
			Rs_ADD("KEY_DATE")=A_7
			Rs_ADD("TOL_HOURS")=A_8
			'Rs_ADD("ABS_HOURS")=A_9
			Rs_ADD("BTIME")=A_10
			Rs_ADD("ETIME")=A_11
			Rs_ADD("NOTE")=A_12
			Rs_ADD("MANG_NOBR")=A_13
			Rs_ADD("MANG_SIGN")="0"
			.UpdateBatch
			response.write "�s�W���X�а�" & A_4 & " �@" & A_8 &"��<br>"
		End With
	End Function

'***�p��а��ƶq
	'This Function=VFP THISFORM.GET_HRS(Run_DATE,Run_DATE,M_BTIME,M_ETIME)
	'�нT�w��J��Ƭ��P�@��
	
	Function GetHouseSub(RUN_BTIME,RUN_ETIME,ON_TIME,OFF_TIME, _
			     WK_HRS, RES_B1,RES_E1,UNIT,MIN_UNIT)
	
	
'	response.write "�а��}�l�ɶ�" & RUN_BTIME & "<BR>"
'	response.write "�а������ɶ�" & RUN_ETIME & "<BR>"	
'	response.write "�}�l�𮧮ɶ�" & ON_TIME & "<BR>"
'	response.write "�����𮧮ɶ�" & OFF_TIME & "<BR>"	
'	response.write "�t�ζ}�l�ɶ�" & RES_B1 & "<BR>"
'	response.write "�t�ε����ɶ�" & RES_E1 & "<BR>"	
'	response.write "�t�Τu��" & WK_HRS & "<BR>"
'	response.write "�p����" & UNIT & "<BR>"	
'	response.write "�̤p�ƶq" & MIN_UNIT & "<BR>"	
			     
	
		If RUN_BTIME=ON_TIME AND RUN_ETIME=OFF_TIME Then	'&&����
			Select Case UNIT
				Case "����"
					GetHouseSub=Round(WK_HRS*60)
				Case "�p��"
					GetHouseSub=Round(WK_HRS)
				Case "��"
					GetHouseSub=1
			End Select
		Else
			Dim RES_TIME,RBT,RET
			If  RES_B1>=RUN_BTIME AND RES_E1<=RUN_ETIME Then
				RBT=IfcNull(RES_B1)
				RET=IfcNull(RES_E1)
				RES_TIME=CInt(CAL_HRS(RBT,RET,MIN_UNIT,"",""))
			Else 
				RES_TIME=0
			End If
			Dim UNIT_MIN,UNIT_HRS
			UNIT_MIN=0
			UNIT_HRS=0
			Select Case UNIT
				Case "����"
					UNIT_MIN=MIN_UNIT
					UNIT_HRS=MIN_UNIT
				Case "�p��"
					UNIT_MIN=MIN_UNIT*60
					UNIT_HRS=MIN_UNIT
				Case "��"
					UNIT_MIN=MIN_UNIT*60*8
					UNIT_HRS=MIN_UNIT
			End Select
			If UNIT_MIN=0 Then
				GetHouseSub=0
			Else
				GetHouseSub=CInt((CAL_HRS(RUN_BTIME,RUN_ETIME,1,"","")-RES_TIME)/UNIT_MIN)*UNIT_HRS
			End If
		End If
	End Function
		
'***�p��p�ɼ�
	Function CAL_HRS(TIMEB,TIMEE,MINS,BD,ED)	'�����Ѽ� [ �}�l�ɶ� , �����ɶ� , �p����(��) , �[��}�l��� , �[������ ]
		Dim LNMINS
		If BD="+" Then TIMEB=CStr(CInt(TIMEB)+2400)
		If BD="-" Then TIMEE=CStr(CInt(TIMEE)+2400)
		If ED="+" Then TIMEE=CStr(CInt(TIMEE)+2400)
		If ED="-" Then TIMEB=CStr(CInt(TIMEB)+2400)
		LNMINS=S_HR2MINS(TIMEE)-S_HR2MINS(TIMEB)
		CAL_HRS=LNMINS/MINS
	End Function

'***�p�������
	Function S_HR2MINS(lcTime)
		Dim lnMinute1,lnMinute2
		If InStr(cstr(lcTime),":") Then  	'&&�Y���j��s
			lcTime=Left(lcTime,2)+Right(lcTime,2)
		End If
		lnMinute1=CInt(Left(lcTime,2))*60
		lnMinute2=CInt(Right(lcTime,2))
		S_HR2MINS= lnMinute1+lnMinute2
	End Function
	
'******* ��J���2(��쫬�A�A���W�١A�����סA��ȡA�̤j�r������)
Function inputSTR2 (I_type,I_name,I_size,I_value,I_maxlength)
	inputSTR2= "<input type="&m34& I_type &m34& _
				" name="&m34& I_name &m34& _
				" size="&m34& I_size &m34& _
				" value="&m34& I_value &m34& _
				" maxlength="&m34& I_maxlength &m34&">"
End	Function

'******* ���ÿ�J���2(���W�١A���)
Function OUT_STR2(GET_NAME,GET_VALUE)
	OUT_STR2="<input  type=" & m34 & "HIDDEN" & m34 &_
					" name=" & m34 & GET_NAME & m34 &_
					" value="& m34 & GET_VALUE & m34 &">"
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