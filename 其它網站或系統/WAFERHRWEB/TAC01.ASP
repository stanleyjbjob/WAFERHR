<html>

<head>
<meta HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=BIG5">
<meta NAME="GENERATOR" CONTENT="Microsoft FrontPage 6.0">
<link HREF="MAIN.CSS" REL="STYLESHEET" TYPE="TEXT/CSS">
<title>查詢條件</title>
<style>
<!--
table        { background-color: #CCCCCC; border: 0 }
td			 { background-color: #FFFFFF ; font-family: 細明體; font-size: 10pt; height: 30;text-align:"center";}
.td2		 { background-color: #808080 ; font-family: 細明體; font-size: 10pt; height: 30;text-align:"center"; color: #FFFFFF;}
.form_title	 { background-color: #006699 ; font-family: 細明體; font-size: 12pt; height: 32 ;
			   font-weight: bold ; color: #FFFFFF ;text-align:"center"}
.form_foot	 { background-color: #C0C0C0 ; font-size: 1pt; color: #663300 ; height: 1}
-->
</style>
<base target="MAIN">
</head>

<body bgcolor="#EBEBEB" background="images/bg.gif">
<%
m34=CHR(34)

'If TYPENAME(SESSION("HRCON"))<>"CONNECTION" Then
	'RESPONSE.REDIRECT "DEFAULT.ASP"
'END If
SET HRCON=SESSION("HRCON")
MYEAR=YEAR(DATE())
MMONTH=MONTH(DATE())
MDAY=DAY(DATE())
If MMONTH<=9 Then
	MMONTH="0"&MMONTH
END If
If MDAY<=9 Then
	MDAY="0"&MDAY
End If
'MNOBR=REQUEST.FORM("MNOBR")
'MPASSWORD=REQUEST.FORM("MPASSWORD")
MNOBR=session("NOBR")
MPASSWORD=session("PASSWORD")

SQLSTR="SELECT NOBR,NAME_C FROM BASE WHERE NOBR='"+MNOBR+"'"
SET RS1=HRCON.EXECUTE(SQLSTR)
MNOBR=RS1("NOBR")
MNAME_C=RS1("NAME_C")
M34=CHR(34)
SESSION("NOBR")=MNOBR
SESSION("NAME_C")=MNAME_C

If ISOBJECT(HRCON) Then
	SQLSTR = "SELECT A.NOBR,A.NAME_C,A.PASSWORD,B.MANG,B.DEPT AS DEPT,D.DEPT_TREE" & _
			" FROM BASE A,BASETTS B,TTSCODE C,DEPT D" & _
			" WHERE GETDATE() BETWEEN B.ADATE AND B.DDATE" & _
			" AND A.NOBR=B.NOBR" & _
			" AND B.TTSCODE=C.TTSCODE" & _
			" AND B.TTSCODE IN('1','4','6')" & _
			" AND B.DEPT=D.D_NO" & _
	" AND A.NOBR='"&MNOBR&"'"
	If MPASSWORD="!@#$%" Then
	Else
		SQLSTR=SQLSTR+" AND A.PASSWORD='"&MPASSWORD&"'"
	End If
	SET RS1=HRCON.EXECUTE(SQLSTR)
	
	If NOT RS1.EOF Then
		SESSION("MANG")=RS1.FIELDS("MANG")
		SESSION("DEPT")=RS1.FIELDS("DEPT")
		If RS1.FIELDS("MANG") Then
			If RS1.FIELDS("DEPT_TREE")=SPACE(7) Then
				RESPONSE.WRITE "部門樹未建立,無法查看資料"
			Else
				MDEPT=RS1.FIELDS("DEPT")
				MDEPT_TREE=RS1.FIELDS("DEPT_TREE")
				SESSION("DEPT_TREE")=MDEPT_TREE
				SQLSTR="SELECT DEPT_TREE FROM DEPT WHERE D_NO='"&MDEPT&"'"
				SET RS2=HRCON.EXECUTE(SQLSTR)
				If RS2.EOF Then
					RESPONSE.WRITE "部門樹未建立,無法查看資料"	
					RESPONSE.End	
				Else
					MDEPT_TREE=RS2.FIELDS("DEPT_TREE")
					MDEPT_TREEB=TRIM(MDEPT_TREE)
					MDEPT_TREEE=TRIM(MDEPT_TREE)+"ZZZZZZZZZ"
					SQLSTR = "SELECT A.NOBR,A.NAME_C,A.PASSWORD,B.MANG,B.DEPT AS DEPT,D.DEPT_TREE,D.D_NAME" & _
							" FROM BASE A,BASETTS B,TTSCODE C,DEPT D" & _
							" WHERE GETDATE() BETWEEN B.ADATE AND B.DDATE" & _
							" AND A.NOBR=B.NOBR" & _
							" AND B.TTSCODE=C.TTSCODE" & _
							" AND B.TTSCODE IN('1','4','6')" & _
							" AND B.DEPT=D.D_NO AND B.MANG=1" & _
							" AND D.DEPT_TREE BETWEEN '"+MDEPT_TREEB+"'"+" AND '"+MDEPT_TREEE+"'" & _
							" ORDER BY D.DEPT_TREE"
					'RESPONSE.WRITE SQLSTR
					SET RS1=HRCON.EXECUTE(SQLSTR)
					If RS1.EOF Then
						RESPONSE.WRITE "經過部門樹無資料"	
					End If
				End If
			End If
		End If
	Else
		RESPONSE.WRITE "無資料,請檢查密碼是否正確"
		RESPONSE.End
	End If
Else
	RESPONSE.WRITE "無法連結資料庫"
End If
%>

<form METHOD="POST" ACTION="TAC02.ASP" ONSUBMIT NAME="FRONTPAGE_FORM1">
  <p><font SIZE="2">請選擇要查詢的資料:<select SIZE="1" NAME="DATATYPE">
    <option SELECTED VALUE="ATTEND">出勤資料</option>
    <option VALUE="ABS">請假資料</option>
    <option VALUE="OT">加班資料</option>
    <option VALUE="YEAR_ABS">年休資料</option>
    <option VALUE="OT_ABS">補休資料</option>
    <option VALUE="AWARD">獎懲資料</option>
    <option VALUE="CARD">刷卡資料</option>
    <!--option VALUE="TRAIN">教育訓練資料</option-->
    <!--option VALUE="TRATT">預定要上的課程</option-->
  </select></font></p>
  <p><font SIZE="2">查詢日期：
  <%	response.write SelectLoop(Year(Now)-2,Year(Now)+2,4,Year(Now),"MYEARB") &"年"
		response.write SelectLoop(1,12,2,Month(Now),"MMONTHB") &"月"
		response.write SelectLoop(1,31,2,Day(Now),"MDAYB") &"日 至 "
		response.write SelectLoop(Year(Now)-2,Year(Now)+2,4,Year(Now),"MYEARE") &"年"
		response.write SelectLoop(1,12,2,Month(Now),"MMONTHE") &"月"
		response.write SelectLoop(1,31,2,Day(Now),"MDAYE") &"日"
  %>
	</font></p>
  <table WIDTH="498" HEIGHT="37" BORDER="0" cellspacing="1" cellpadding="0" align="center">
    <tr>
      <td colspan="5" class="form_title">◆ 請選擇欲查詢人員 ◆</td>
    </tr>
    <tr>
      <td class="td2" WIDTH="95" HEIGHT="16"><font SIZE="2">員工代號</font></td>
      <td class="td2" WIDTH="98"><font SIZE="2">中文姓名</font></td>
      <td class="td2" WIDTH="81" HEIGHT="16"><font SIZE="2">部門樹</font></td>
      <td class="td2" WIDTH="100" HEIGHT="16"><font SIZE="2">部門代號</font></td>
      <td class="td2" WIDTH="307" HEIGHT="16"><font SIZE="2">部門名稱</font></td>
    </tr>
<%DO WHILE NOT RS1.EOF%>
    <tr>
      <td WIDTH="95" HEIGHT="9"><font SIZE="2"><%
RESPONSE.WRITE "<INPUT TYPE="&m34&"SUBMIT"&m34&" VALUE=" &m34& Trim(RS1.FIELDS("NOBR"))&m34&" NAME=" &m34&"MNOBR"&m34&">"
%></font></td>
      <td WIDTH="98"><font SIZE="2"><%=RS1.FIELDS("NAME_C")%> </font></td>
      <td WIDTH="81" HEIGHT="9"><font SIZE="2"><%        
      If RS1.FIELDS("MANG") Then                  
	RESPONSE.WRITE "<A HREF="&m34&"TAC03.ASP"+"?MDEPT="+RS1.FIELDS("DEPT_TREE")&m34&">"+RS1.FIELDS("DEPT_TREE")+" </A>"        
End If%> </font></td>
      <td WIDTH="100" HEIGHT="9"><font SIZE="2"><%If RS1.FIELDS("MANG") Then                  
	RESPONSE.WRITE RS1.FIELDS("DEPT")                  
End If                  
                  
%> </font></td>
      <td WIDTH="307" HEIGHT="9"><font SIZE="2"><%If RS1.FIELDS("MANG") Then                  
	RESPONSE.WRITE RS1.FIELDS("D_NAME")                  
End If                  
%> </font></td>
    </tr>
<%RS1.MOVENEXT                  
		LOOP%>
  </table>
  <p>　</p>
</form>
</body>
</html>
<%
response.End

'***選單的內容(開始數值,結束數值,抓取長度,預設字串)
Public Function SelectLoop (BData,EData,SLong,DStr,DStr2)	
	If Trim(BData)="" OR Trim(EData)="" OR Trim(SLong)="" OR Trim(DStr)="" Then
		ErrMsg("SelectLoop傳入數值錯誤(" & BData & "," & EData & "," & SLong & "," & DStr & ")")
	End If
	Dim uu,i
	uu=Chr(10)+space(7)+Chr(9)+Chr(9)+Chr(9) '讓原始檔好看點的東東...
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