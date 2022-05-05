<!-- #INCLUDE FILE="arbhr.INC" -->
<%

'*****建立變數。
	Dim conn,nobr,name_c,H_Code,SqlStr, _
		BDATE,EDATE,BTIME,ETIME,YYMM
	Dim AllErrStr,success
	
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
	m34=Chr(34)
	m13=Chr(13)
%>
<html>

<head>
<meta http-equiv="Content-Language" content="zh-tw">
<meta http-equiv="Content-Type" content="text/html; charset=big5">
<title>公出資料核准</title>
<style>
<!--
table        { background-color: #000099; border: 0 }
td			 { background-color: #FFFFFF ; font-family: 細明體; font-size: 10pt; height: 30}
.td2		 { background-color: #CCCCFF ; font-family: 細明體; font-size: 10pt; height: 30;text-align:"center";}
.form_title	 { background-color: #000099 ; font-family: 細明體; font-size: 12pt; height: 32 ;
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
	'*******公出資料核可儲存	
	If Len(Trim(request.form("OT_count")))>0 Then
		M_OT_count=CInt(Trim(request.form("OT_count")))
		M_MANG_NOBR=Trim(request.form("MANG_NOBR"))
		TMP_MANG_NOBR=M_MANG_NOBR
		TMP_MANG_NAME_C=trim(request.form("MANG_NAME_C"))
	
	
	
		If M_OT_count>0 Then
			I=0
			Do While I < M_OT_count 
				I=I+1
					TMP_NOBR=trim(request.form("NOBR"& CStr(I)))
					
					BDATE=Trim(request.form("BDATE" & CStr(I))) 					
					TMP_BDATE=CDate(BDATE)
					TMP_BTIME=Trim(request.form("BTIME" & CStr(I)))
					TMP_ETIME=Trim(request.form("ETIME" & CStr(I)))
					
					TMP_MANG_SIGN=trim(request.form("MANG_SIGN"& CStr(I)))
					if TMP_MANG_SIGN="" then
						TMP_MANG_SIGN="0"
					Else
						TMP_MANG_SIGN="1"
					End If
					
					update_ABS1 TMP_NOBR ,TMP_MANG_NAME_C ,TMP_MANG_NOBR ,TMP_BDATE ,TMP_BTIME ,TMP_ETIME,TMP_MANG_SIGN
			LOOP
		End If
	End If
	'***更新公出資料核可(ABS1)
						
	Function update_ABS1(A_NOBR ,A_MANG_NAME_C ,A_MANG_NOBR ,A_BDATE ,A_BTIME ,A_ETIME,A_MANG_SIGN)
		Dim SqlStr						
		SQLSTR = "UPDATE ABS1 "& _
					" SET KEY_MAN='" & A_MANG_NAME_C & "',"& _
					" KEY_DATE='" & DATE() & "',"& _
					" MANG_SIGN='" & A_MANG_SIGN & "'" & _
				" WHERE NOBR='" & A_NOBR & "'" & _
					" AND H_CODE='O'" & _
					" AND MANG_SIGN='0'" & _
					" AND MANG_NOBR='" & A_MANG_NOBR & "'" & _
					" AND BDATE='" & A_BDATE & "'" & _
					" AND BTIME='" & A_BTIME & "'" & _
					" AND ETIME='" & A_ETIME & "'"
		'response.write SqlStr
		'response.End
		conn.Execute SqlStr
		response.write A_NOBR &" 公出資料更新 " & A_BDATE &"<br>"
	End Function
%>
<p align="center"><A TARGET="MAIN" a href="P705.asp">回公出資料核准</a></P>
</body>
</html>
<%
	conn.Close
	Set	conn = Nothing
response.end

response.End	'避免程式執行副程式

'***以下為程式引用的副程式***************

'******* 隱藏輸入欄位(欄位名稱，初值)
Function OUT_STR2(GET_NAME,GET_VALUE)
	OUT_STR2="<input type="&m34&"HIDDEN"&m34&" name="&m34& GET_NAME &m34&"  value="&m34& GET_VALUE &m34&">"
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