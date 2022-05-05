<%
'一些常用的東東...

'***若連結失敗則重新連結
'Public Function chkSession(DATA)	'Session驗證
'    If typename(Session(DATA))<>"Connection" Then
'    	frmRefrish("連結失敗Session("&DATA&")")
'    End if
'End Function

Public Function chkSession(DATA)	'Session驗證
    If typename(Session(DATA))<>"Connection" then
    	chkSession="NONE"
    	'frmRefrish("連結失敗Session("&DATA&")")
    ELSE
    	chkSession="Connection"
    End if
End Function

Public Sub chkobject(DATA)	'object驗證
    If isobject(DATA)=false then
    	frmRefrish("無法連結物件"&DATA)
    End if
End Sub

'***錯誤訊息&重新連結
Public Sub frmRefrish(data1)
	Dim showStr
	showStr="因為" & data1
	showStr=showStr+"<br><br>請按<a href="&chr(34)&"JavaScript:top.location.reload()"&chr(34)
	showStr=showStr+" &nbsp; target="&chr(34)&"_top"&chr(34)&">重新整理</a> "
	showStr=showStr+"<br><br>重新登入"
	response.write showStr
	response.End
End Sub
'***'錯誤訊息&重回上一頁
Public Sub ErrTURN(DATA)	
	Dim showStr
    showStr="<br><br>你要面臨的問題如下<br> &nbsp;[&nbsp; " & DATA& "&nbsp;] "
    showStr=showStr+ "<br><br>請按<a href="&chr(34)&"javascript:%20history.go(-1)"&chr(34)&">回上一頁</a> "
    showStr=showStr+ "<br><br>重新輸入"
	response.write showStr
    response.End
End Sub
response.End

'***錯誤訊息
Public Sub ErrMsg(DATA)	'錯誤訊息
     DATA="<br><br>你要面臨的問題是 &nbsp; " &chr(34)& DATA& chr(34)& " &nbsp; ,著手解決吧!! "
     response.write DATA
     response.End
End Sub


response.End

'***選單的內容(開始數值,結束數值,抓取長度,預設字串)
Public Function SelectLoop (BData,EData,SLong,DStr,DStr2)	
	If Trim(BData)="" OR Trim(EData)="" OR Trim(SLong)="" OR Trim(DStr)="" Then
		ErrMsg("SelectLoop傳入數值錯誤(" & BData & "," & EData & "," & SLong & "," & DStr & ")")
	End if
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
		End if
	Next
	SelectLoop="<select	name="&m34& DStr2 &m34&" size="&m34&"1"&m34&">" & uu & SelectLoop & "</select>"
End Function



'***取月份最後一日(計算日期,移動月份)	"移動月份"為0,代表當月;為1,代表次月
Public Function LastDateOfMonth(InputDate,AddMonth)
    Dim Date1st
    Date1st = DateAdd("d", Day(InputDate) * -1 + 1, InputDate)
    LastDateOfMonth = DateAdd("d", -1, (DateAdd("m", AddMonth + 1, Date1st)))
End Function
'範例...
'LastDateOfMonth(2001/1/12,0)	=> LastDateOfMonth 的值為 2001/1/31
'LastDateOfMonth(2001/1/12,1)	=> LastDateOfMonth 的值為 2001/2/28
'LastDateOfMonth(2001/1/12,1)	=> LastDateOfMonth 的值為 2001/3/31
'LastDateOfMonth(2001/1/12,-1)	=> LastDateOfMonth 的值為 2000/12/31

response.End


'***驗證日期
Public Function MoveDate(InputData)
    If IsNull(InputData) Or Trim(InputData) = "" Then
        MoveDate = Null
        Exit Function
    End If
    If IsDate(InputData) = False Then
        MoveDate = Null
        Exit Function
    End If
    MoveDate = CDate(InputData)
End Function

'***驗證文字輸入
Function IfcNull(InputData)
    If IsNull(InputData) Or Trim(InputData) = "" Then
        IfcNull = " "
    Else
        IfcNull = InputData
    End If
End Function

'轉民國年
Function Txt2MK(DateIs)
    If IsEmpty(DateIs) OR IsNull(DateIs) Then
        Txt2MK = "00/00/00"
        Exit Function
    End If
    DateIs = Trim(DateIs)
    Dim i, j, k, Start_Pos, yy, mm, dd
    k = Len(DateIs)
    If k = 0 Then
        Txt2MK = "00/00/00"
        Exit Function
    End If
    i = InStr(DateIs, "/")
    If i = 0 Then
        Select Case k
        Case 8 Or k > 8
            yy = Mid(DateIs, 1, 4)
            mm = Mid(DateIs, 5, 2)
            dd = Mid(DateIs, 7, 2)
        Case  7
            yy = Mid(DateIs, 1, 3)
            mm = Mid(DateIs, 4, 2)
            dd = Mid(DateIs, 6, 2)
        Case  6
            yy = Mid(DateIs, 1, 2)
            mm = Mid(DateIs, 3, 2)
            dd = Mid(DateIs, 5, 2)
        Case Else
            yy = "00"
            mm = "00"
            dd = "00"
        End Select
    Else
        Start_Pos = 0
        j = 1   'slash count
        For i = 1 To k
            X = Mid(DateIs, i, 1)
            If X = "/" Then
                If Start_Pos > 0 Then
                    If j = 1 Then
                        yy = Mid(DateIs, Start_Pos, i - Start_Pos)
                    Else
                        If j = 2 Then
                            mm = Mid(DateIs, Start_Pos, i - Start_Pos)
                        Else
                            dd = Mid(DateIs, Start_Pos, i - Start_Pos)
                        End If
                    End If
                End If
                j = j + 1
                Start_Pos = 0
            Else
                If Start_Pos = 0 Then
                    Start_Pos = i
                End If
            End If
        Next 
        If Start_Pos > 0 Then
            dd = Mid(DateIs, Start_Pos, k - Start_Pos + 1)
        End If
    End If
    If Len(yy) = 4 Then
        yy = Trim(Str(Val(yy) - 1911))
    Else
        yy = Trim(Str(Val(yy) - 11))
    End If
    mm = Trim(Str(Val(mm)))
    dd = Trim(Str(Val(dd)))
    Txt2MK = yy + "/" + mm + "/" + dd
End Function

'由民國轉西元年
Function Txt2Date(DateIs)
    If IsNull(DateIs) Or DateIs = "" Then
        Txt2Date = ""
        Exit Function
    End If
    Dim i, j, k, Start_Pos, yy, mm, dd
    k = Len(DateIs)
    If k = 0 Then
        Txt2Date = "00/00/00"
        Exit Function
    End If
    i = InStr(DateIs, "/")
    If i = 0 Then
        Select Case k
        Case  8 Or k > 8
            yy = Mid(DateIs, 1, 4)
            mm = Mid(DateIs, 5, 2)
            dd = Mid(DateIs, 7, 2)
        Case  7
            yy = Mid(DateIs, 1, 3)
            mm = Mid(DateIs, 4, 2)
            dd = Mid(DateIs, 6, 2)
        Case  6
            yy = Mid(DateIs, 1, 2)
            mm = Mid(DateIs, 3, 2)
            dd = Mid(DateIs, 5, 2)
        Case Else
            yy = "00"
            mm = "00"
            dd = "00"
        End Select
    Else
        Start_Pos = 0
        j = 1   'slash count
        For i = 1 To k
            X = Mid(DateIs, i, 1)
            If X = "/" Then
                If Start_Pos > 0 Then
                    If j = 1 Then
                        yy = Mid(DateIs, Start_Pos, i - Start_Pos)
                    Else
                        If j = 2 Then
                            mm = Mid(DateIs, Start_Pos, i - Start_Pos)
                        Else
                            dd = Mid(DateIs, Start_Pos, i - Start_Pos)
                        End If
                    End If
                End If
                j = j + 1
                Start_Pos = 0
            Else
                If Start_Pos = 0 Then
                    Start_Pos = i
                End If
            End If
        Next 
        If Start_Pos > 0 Then
            dd = Mid(DateIs, Start_Pos, k - Start_Pos + 1)
        End If
    End If
    If Len(yy) = 4 Then
        yy = Trim(Str(Val(yy) + 11))
    Else
        yy = Trim(Str(Val(yy) + 1911))
    End If
    mm = Trim(Str(Val(mm)))
    dd = Trim(Str(Val(dd)))
    Txt2Date = yy + "/" + mm + "/" + dd
End Function

'***西元日期轉民國年月
Public Function Date2MkYM(InputData)
	If not IsNull(InputData) Then
    	Date2MkYM =  Right("00" & cstr(Year(InputData) - 1911),3)  + Right("00" & cstr(Month(InputData)),2)
    Else
    	Date2MkYM=""
    End if
End Function

'***西元日期轉民國日期
Function Date2MK(InputDate)
    Date2MK = Txt2MK(Str(InputDate))
End Function

'***關閉DATA物件
Public Function CloseObj(InputData)
	InputData.CLOSE
	Set	InputData = Nothing
End Function
%>