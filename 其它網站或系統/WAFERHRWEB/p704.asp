<!-- #INCLUDE FILE="arbhr.INC" -->
<%

'*****建立變數。
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
	
'*****參數定義
	mnobr=session("NOBR")
	mNAME_C=session("NAME_C")
	m34=Chr(34)
	m13=Chr(13)
	
	'M_NOBR=UCase(Trim(request.form("mnobr")))
	'name_c=UCase(Trim(request.form("mNAME_C")))
	M_NOBR=Trim(session("NOBR"))
	mNAME_C=Trim(session("NAME_C"))
	
'【】＃○●△◎☆★◇◆□■▽▼⊕⊙※＊§《》┌┐└┘├┴┬┼│─┤═║╔╗╚╝╙╜╓╖
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
<title>公出資料新增</title>
<style>
<!--
table        { background-color: #CCCCCC; border: 0 }
td			 { background-color: #FFFFFF ; font-family: 細明體; font-size: 10pt; height: 30;text-align:"center";}
.td2		 { background-color: #808080 ; font-family: 細明體; font-size: 10pt; height: 30;text-align:"center"; color: #FFFFFF;}
.form_title	 { background-color: #006699 ; font-family: 細明體; font-size: 12pt; height: 32 ;
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

	'****基本資料查驗****
	If IsDate(BDATE)=False Then
		MsgBox "請假日期起輸入錯誤!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.BDATE_DAY.focus
	ElseIf IsDate(EDATE)=False Then
		MsgBox "請假日期迄輸入錯誤!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.EDATE_DAY.focus
	ElseIf form1.BDATE_year.value<>form1.EDATE_year.value Then
		MsgBox "不可跨年!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.EDATE_year.focus
	ElseIf form1.BDATE_MON.value<>form1.EDATE_MON.value Then
		MsgBox "不可跨月!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.EDATE_MON.focus
	ElseIf CDate(BDATE)>CDate(EDATE) Then
		MsgBox "請假日期迄應大於請假日期起!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.EDATE_DAY.focus
	ElseIf CDate(BDATE)=CDate(EDATE) and CDate(BTIME)>CDate(ETIME) Then
		MsgBox "請假時間迄應大於請假時間起!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.ETIME_HOUR.focus
	ElseIf CDate(BDATE)=CDate(EDATE) and CDate(BTIME)=CDate(ETIME) Then
		MsgBox "請假起迄日期及請假起迄時間不應相同!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.ETIME_HOUR.focus
	ElseIf Len(Trim(form1.NOTE.value))=0 Then
		MsgBox "出差事由不可為空值!! 請重新輸入.",,"輸入錯誤"
		CHK_DATA_OK=False
		form1.NOTE.focus
	End If

	'****儲存確定****

	If CHK_DATA_OK=True Then
		Dim MyVar,MSG_STR
		MSG_STR="┌──────────────────┐" & M13 & _
				"│　　　　　　是否確定儲存？　　　　　│" & M13 & _
				"└──────────────────┘" & M13 & M13 & _
				"　【請假日期起】" & BDATE & M13 & _
				"　【請假時間起】" & BTIME & M13 & _
				"　──────────────────　" & M13 & _
				"　【請假日期迄】" & EDATE & M13 & _
				"　【請假時間迄】" & ETIME & M13 & _
				"　──────────────────　" & M13 & _
				"　【出差　事由】" & Trim(form1.NOTE.value) & M13 & M13 & _
				"┌──────────────────┐" & M13 & _
				"│　資料儲存後，無法線上修改或刪除，　│" & M13 & _
				"│　　　　　　　　　　　　　　　　　　│" & M13 & _
				"│　　　　　　請謹慎檢查。　　　　　　│" & M13 & _
				"└──────────────────┘"
				MyVar = MsgBox(MSG_STR,vbOKCancel,"儲存確定")
		If MyVar=1 Then
			form1.submit
		Else
			form1.NOTE.focus()
		End If
	End If
End	Sub
--></script>
<%

'公出資料輸入
	'資料驗證
	If Len(mnobr)=0 Then
		response.write "<b><A TARGET="& M34 &"_parent"& M34 &" a href="& M34 &"default.asp"& M34 &">等待時間過長，請重新登入</a></b><br><br>"
		response.end
	'ElseIf Len(mIDNO)=0 Then
	'		response.write "<b>身份證號不可空白</b><br><br>"&m13
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
		response.write "查無資料，請重新登入。"
		%>
		<br>
		<A TARGET="_parent" a href="default.asp">重新登入</a>
		<%
		response.end
	End If
	
	'產生主管資料
	
'		'藉由部門樹產生主管姓名及工號
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


		'擷取直接部門主管及間接部門主管
		SqlStr= " SELECT A.NOBR, A.NAME_C" & _
				" FROM BASE A,DEPT B" & _
				" WHERE B.D_NO='" & Trim(session("DEPT_NO")) & "'" & _
				" AND (B.D_NA=A.NOBR OR B.I_NA=A.NOBR)"
				
		'response.write SqlStr
		'response.end
		
	Set	ans1=conn.execute(SqlStr)
	
	BDate=cstr(date())
	B_YYMM=Date2MkYM(date())
	
	'*****以下依此員工編號,產生上下班時間
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
			AllErrStr=AllErrStr& "找無關於員工"& mnobr &"班別檔資料.無法新增請假資料!!"
			If AllErrStr<>"" Then  ErrTURN(AllErrStr)	'若有錯誤,終止執行
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
	<tr><td colspan="4" class="form_title">◆ 公 出 資 料 新 增 ◆</td></tr>
	<tr>
		<td width="90" class="td2">請假日期起</td>
		<%
		response.write OUT_STR2("mIDNO",mIDNO)
		response.write OUT_STR2("mnobr",mnobr)
		response.write "<td>　" & _
					   SelectLoop(Year(Now)-1,Year(Now)+1,4,sBDATE_year,"BDATE_year") &"年"
		response.write SelectLoop(1,12,2,sBDATE_MON,"BDATE_MON") &"月"
		response.write SelectLoop(1,31,2,sBDATE_DAY,"BDATE_DAY") &"日</td>"
		%>
		<td width="90" class="td2">請假日期迄</td>
		<%
		response.write "<td>　" & _
					   SelectLoop(Year(Now)-1,Year(Now)+1,4,sEDATE_year,"EDATE_year") &"年"
		response.write SelectLoop(1,12,2,sEDATE_MON,"EDATE_MON") &"月"
		response.write SelectLoop(1,31,2,sEDATE_DAY,"EDATE_DAY") &"日</td>"
		%>
		</tr>
	<tr>
 		<td width="90" class="td2">請起時間</td>
 		<%
		response.write "<td>　" & SelectLoop(00,23,2,sBTIME_HOUR,"BTIME_HOUR") & "時"
		response.write SelectLoop(00,59,2,sBTIME_SEC,"BTIME_SEC") &"分</td>"
		%>
		<td width="90" class="td2">請迄時間</td>
 		<%
		response.write "<td>　" & SelectLoop(00,23,2,sETIME_HOUR,"ETIME_HOUR") & "時"
		response.write SelectLoop(00,59,2,sETIME_SEC,"ETIME_SEC") &"分</td>"
		%>
		</tr>
	<tr>
		<td width="90" class="td2">出差事由</td>
		<%
		response.write "<td colspan="&m34&"3"&m34&">　" & inputSTR2 ("text","NOTE" ,35,sNOTE,10) & "<td>"
		%>
		</tr>
	<%
	If NOT ans1.EOF Then
	%>
	<tr>
		<td width="90" class="td2">核可主管</td>
		<%
			response.write "<td colspan="&m34&"3"&m34&">　" & SelectMANG("","MANG_NOBR") & "<td>"
		%>
		</tr>
	<%
	Else
		response.write OUT_STR2("MANG_NOBR","")
	End If %>
	<tr>
		<td colspan="4"><br><center>
		<input type="button" value="　儲　　存　" name="B1" onclick="datacheck"></center><br></td>
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
'*******公出資料儲存	

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
	
		M_H_CODE= "O"	'假別代號
		BDATE	= CStr(MBDATE)
		EDATE	= CStr(MEDATE)
		BTIME	= CStr(MBTIME)
		ETIME	= CStr(METIME)
		M_YYMM	= Date2MkYM(MBDATE)
		success = True
		AllErrStr=""
		'response.write "開始日期" & BDATE & "<BR>"
		'response.write "結束日期" & EDATE & "<BR>"
		'response.write "開始時間" & BTIME & "<BR>"
		'response.write "結束時間" & ETIME & "<BR>"
		'response.write "請假原因" & MNOTE & "<BR>"
		'response.write "請假年月" & M_YYMM & "<BR>"	
		BDATE	= MoveDate(MBDATE)
		EDATE	= MoveDate(MEDATE)
		
		'*****以下為輸入驗證_ok
		If BDATE = False Then AllErrStr = AllErrStr&"[開始日期輸入錯誤]<br>"
		If EDATE = False Then AllErrStr = AllErrStr&"[結束日期輸入錯誤]<br>"
		If EDATE < BDATE Then AllErrStr = AllErrStr&"[請假日期迄應大於請假日期起]<br>"
		If M_YYMM<>Date2MkYM(EDATE) Then AllErrStr = AllErrStr&"[不可跨月]<br>"
		If AllErrStr<>"" Then  ErrTURN(AllErrStr)	'若有錯誤,終止執行
	
		'*****定義常數DAYS與變數
		DAYS=CInt(DateDiff("d", BDATE, EDATE))
		ReDim saveAbs(DAYS,17)
		ABS_TOL_HOURS=0
	
		'*****產生每日請假資料
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
				AllErrStr=AllErrStr&"員工編號 " & M_NOBR & _
					" 已有[" & CStr(Run_DATE) & "]" & _
					" ["&RQ_ABS("BTIME")&"]" & _
					" ["&RQ_ABS("ETIME")&"]的公出"
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
					ErrTURN("此員工無"& Run_DATE &"出勤資料與" & M_YYMM & "班表資料.")
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
				AllErrStr=AllErrStr& "找無關於員工"& mnobr &"班別檔資料.無法新增"+cstr(Run_DATE)+"請假資料!! <BR>"
			End If
			
	
			If AllErrStr<>"" Then  ErrTURN(AllErrStr)	'若有錯誤,終止執行
	
			If ROTE="00" Then
				saveAbs(HHH,0)="NoData"
			Else  	
				M_UNIT="小時"
				MAX_NUM=0
				If Run_DATE=BDATE Then RUN_BTIME=BTIME Else RUN_BTIME=RV_ROTE("ON_TIME")
				If Run_DATE=EDATE Then RUN_ETIME=ETIME Else RUN_ETIME=RV_ROTE("OFF_TIME")
				'get Hours '計算請假時數
				Sub_HOURS=GetHouseSub(RUN_BTIME,RUN_ETIME,RV_ROTE("ON_TIME"),RV_ROTE("OFF_TIME"), _
						  RV_ROTE("WK_HRS"),RV_ROTE("RES_B_TIME"),RV_ROTE("RES_E_TIME"),"小時",1)
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
		
				'****計算總請假數
					ABS_TOL_HOURS=ABS_TOL_HOURS+Sub_HOURS
				'******
			End If
		Next		
		response.write "總請假天數為 "  & K & "天<br>"
		response.write "總請假時數為 " & ABS_TOL_HOURS & "小時<BR><BR>"
	
		If Err.Number<>0 then 
			ErrMsg(Err.Number)
			response.end
		Else
		
		End If
		
		'***儲存
		If AllErrStr<>"" Then
			ErrTURN(AllErrStr)	'若有錯誤,終止執行
		Else
			'***新增
			Dim Rs_ADD
			Set Rs_ADD = Server.CreateObject("ADODB.Recordset")
			SqlStr="SELECT * FROM ABS1 "
			Rs_ADD.cursorlocation=3
			Rs_ADD.CURSORTYPE=1
			Rs_ADD.LOCKTYPE=4
			Rs_ADD.OPEN SqlStr,conn,,,1
			For HHH=0 TO DAYS	'新增請假
				If saveAbs(HHH,0)<> "NoData" Then
					Add_Abs saveAbs(HHH,0),saveAbs(HHH,1),saveAbs(HHH,2),saveAbs(HHH,3),saveAbs(HHH,4), _
							saveAbs(HHH,5),saveAbs(HHH,6),saveAbs(HHH,7),saveAbs(HHH,8),saveAbs(HHH,9), _
							saveAbs(HHH,10),saveAbs(HHH,11),saveAbs(HHH,12),saveAbs(HHH,13)
				End If
			Next
			CloseObj(Rs_ADD)
		End If
	
		showStr= "執行次數為 "  & CStr(DAYS+1)& "次<br>"
	    showStr=showStr+ "<br>新增成功"
		response.write showStr		
	End If


	conn.Close
	Set	conn = Nothing

response.End	'避免程式執行副程式

'***以下為程式引用的副程式***************

'******* 下拉式選項【部門主管】*******
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
	'SelectMANG="<option	value="&m34&"NONE"&m34&">請選擇</option>" & SelectMANG
	SelectMANG="<select	name="&m34& DStr2 &m34&" size="&m34&"1"&m34&">" & uu & SelectMANG & "</select>"+uu
End Function

'***新增請假

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
			response.write "新增公出請假" & A_4 & " 共" & A_8 &"時<br>"
		End With
	End Function

'***計算請假數量
	'This Function=VFP THISFORM.GET_HRS(Run_DATE,Run_DATE,M_BTIME,M_ETIME)
	'請確定輸入資料為同一天
	
	Function GetHouseSub(RUN_BTIME,RUN_ETIME,ON_TIME,OFF_TIME, _
			     WK_HRS, RES_B1,RES_E1,UNIT,MIN_UNIT)
	
	
'	response.write "請假開始時間" & RUN_BTIME & "<BR>"
'	response.write "請假結束時間" & RUN_ETIME & "<BR>"	
'	response.write "開始休息時間" & ON_TIME & "<BR>"
'	response.write "結束休息時間" & OFF_TIME & "<BR>"	
'	response.write "系統開始時間" & RES_B1 & "<BR>"
'	response.write "系統結束時間" & RES_E1 & "<BR>"	
'	response.write "系統工時" & WK_HRS & "<BR>"
'	response.write "計算單位" & UNIT & "<BR>"	
'	response.write "最小數量" & MIN_UNIT & "<BR>"	
			     
	
		If RUN_BTIME=ON_TIME AND RUN_ETIME=OFF_TIME Then	'&&全天
			Select Case UNIT
				Case "分鐘"
					GetHouseSub=Round(WK_HRS*60)
				Case "小時"
					GetHouseSub=Round(WK_HRS)
				Case "天"
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
				Case "分鐘"
					UNIT_MIN=MIN_UNIT
					UNIT_HRS=MIN_UNIT
				Case "小時"
					UNIT_MIN=MIN_UNIT*60
					UNIT_HRS=MIN_UNIT
				Case "天"
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
		
'***計算小時數
	Function CAL_HRS(TIMEB,TIMEE,MINS,BD,ED)	'接收參數 [ 開始時間 , 結束時間 , 計算單位(秒) , 加減開始日期 , 加減結束日期 ]
		Dim LNMINS
		If BD="+" Then TIMEB=CStr(CInt(TIMEB)+2400)
		If BD="-" Then TIMEE=CStr(CInt(TIMEE)+2400)
		If ED="+" Then TIMEE=CStr(CInt(TIMEE)+2400)
		If ED="-" Then TIMEB=CStr(CInt(TIMEB)+2400)
		LNMINS=S_HR2MINS(TIMEE)-S_HR2MINS(TIMEB)
		CAL_HRS=LNMINS/MINS
	End Function

'***小時轉分鐘
	Function S_HR2MINS(lcTime)
		Dim lnMinute1,lnMinute2
		If InStr(cstr(lcTime),":") Then  	'&&若分大於零
			lcTime=Left(lcTime,2)+Right(lcTime,2)
		End If
		lnMinute1=CInt(Left(lcTime,2))*60
		lnMinute2=CInt(Right(lcTime,2))
		S_HR2MINS= lnMinute1+lnMinute2
	End Function
	
'******* 輸入欄位2(欄位型態，欄位名稱，欄位長度，初值，最大字元長度)
Function inputSTR2 (I_type,I_name,I_size,I_value,I_maxlength)
	inputSTR2= "<input type="&m34& I_type &m34& _
				" name="&m34& I_name &m34& _
				" size="&m34& I_size &m34& _
				" value="&m34& I_value &m34& _
				" maxlength="&m34& I_maxlength &m34&">"
End	Function

'******* 隱藏輸入欄位2(欄位名稱，初值)
Function OUT_STR2(GET_NAME,GET_VALUE)
	OUT_STR2="<input  type=" & m34 & "HIDDEN" & m34 &_
					" name=" & m34 & GET_NAME & m34 &_
					" value="& m34 & GET_VALUE & m34 &">"
End	Function

Public Sub ErrMsg(DATA)
	if Err.Number<>0 then
		response.write "<br><br>程式發生錯誤,請將下面的錯誤框起來.傳給相關人員處理.<br><br>"

		response.write "<table border='1'>"
	Response.Write "<tr><td><br>&nbsp; 產生錯誤的原始碼: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	&Err.Source	& "&nbsp;</td></tr>	 "
	Response.Write "<tr><td><br>&nbsp; COM標準錯誤碼: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Number & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; 程式檔案名稱: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.File & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; 錯誤程式碼的行數: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Line & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; 錯誤的來源: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Category & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; 錯誤原因簡介: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.Description & "&nbsp;</td></tr>  "
	Response.Write "<tr><td><br>&nbsp; 詳細錯誤原因: &nbsp;<br><br></td>"
	Response.Write	   "<td>&nbsp;"	& Err.ASPDescription &"&nbsp;</td></tr> <table>"
		'response.write	"  錯誤碼為[ " & CStr(Err.Number) &	"]<br><br>	" &	Err.Description	& "<br><br>	 "&	Err.Source
	Err.Clear
	end	if
End	Sub

%><!-- #INCLUDE FILE="SIECS-ULT.INC" -->