
<HTML>

<HEAD>
<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=BIG5">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 6.0">
<LINK HREF="MAIN.CSS" REL=STYLESHEET TYPE=TEXT/CSS>
<TITLE>查詢結果</TITLE>
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
<META NAME="MICROSOFT BORDER" CONTENT="NONE">
</HEAD>

<BODY bgcolor="#EFEFEF" background="images/bg.gif">

<P><%
SET HRCON=SESSION("HRCON")
MDATE_B=REQUEST.FORM("MYEARB")&REQUEST.FORM("MMONTHB")&REQUEST.FORM("MDAYB")
MDATE_B_1=REQUEST.FORM("MYEARB")&"-"&REQUEST.FORM("MMONTHB")&"-"&REQUEST.FORM("MDAYB")
MDATE_E=REQUEST.FORM("MYEARE")&REQUEST.FORM("MMONTHE")&REQUEST.FORM("MDAYE")
MDATATYPE=REQUEST.FORM("DATATYPE")
MNOBR=REQUEST.FORM("MNOBR")
MDEPT=REQUEST.FORM("MDEPT")

Select CASE MDATATYPE
CASE "ABS"
		IF ISOBJECT(HRCON) THEN
			SQLSTR="SELECT A.*,B.NAME_C,C.H_NAME" & _
			" FROM ABS A,BASE B,HCODE C" & _
			" WHERE A.NOBR='"& MNOBR&"'" & _
			" AND A.NOBR=B.NOBR" & _
			" AND A.H_CODE=C.H_CODE" & _
			" AND (C.YEAR_REST <>'1' AND C.YEAR_REST <>'3' AND C.YEAR_REST <>'5')" & _
			" AND CONVERT(CHAR,A.BDATE,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'" & _
			" ORDER BY A.NOBR,BDATE DESC"
			SET RS1=HRCON.EXECUTE(SQLSTR)
			IF NOT RS1.EOF THEN
%></P>

<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="563">
    <tr>
      <td colspan="5" class="form_title">◆ 請 假 資 料 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="66">員工姓名</TD>
    <TD class="td2" WIDTH="76">假別</TD>
    <TD class="td2" WIDTH="90">請假日期起</TD>
    <TD class="td2" WIDTH="69">請假時數</TD>
    <TD class="td2" WIDTH="124">員工代號</TD>
  </TR>
<%DO WHILE NOT RS1.EOF%>
  <TR>
    <TD WIDTH="66"><%=RS1.FIELDS("NAME_C")%>
</TD>
    <TD WIDTH="76"><%=RS1.FIELDS("H_NAME")%>
</TD>
    <TD WIDTH="90"><%=RS1.FIELDS("BDATE")%>
</TD>
    <TD WIDTH="69"><%=RS1.FIELDS("TOL_HOURS")%>
</TD>
    <TD WIDTH="124"><%=RS1.FIELDS("NOBR")%>
</TD>
  </TR>
<%RS1.MOVENEXT
		LOOP%>
</TABLE>

<P><%			ELSE
				RESPONSE.WRITE "無資料"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "無法連結資料庫"
		END IF
		SET HRCON=NOTHING
CASE "ATTEND"

		IF ISOBJECT(HRCON) Then
			SQLSTR="SELECT A.*,B.NAME_C,C.LATE_MINS,C.E_MINS,C.ABS,D.ROTENAME" & _
			" FROM ATTCARD A,BASE B,ATTEND C,ROTE D" & _
			" WHERE A.NOBR='"& MNOBR&"'" & _
			" AND A.NOBR=B.NOBR" & _
			" AND C.ROTE=D.ROTE" & _
			" AND A.ADATE=C.ADATE" & _
			" AND A.NOBR=C.NOBR " & _
			" AND CONVERT(CHAR,A.ADATE,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'" & _
			" ORDER BY A.NOBR,A.ADATE,A.T1"
			
			
		'RESPONSE.WRITE SQLSTR
		'RESPONSE.End
		
			SET RS1=HRCON.EXECUTE(SQLSTR)
			IF NOT RS1.EOF THEN
%></P>

<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="642" HEIGHT="43">
    <tr>
      <td colspan="9" class="form_title">◆ 出 勤 資 料 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="73" HEIGHT="15">員工姓名</TD>
    <TD class="td2" WIDTH="81" HEIGHT="15">出勤日期</TD>
    <TD class="td2" WIDTH="68" HEIGHT="15">班別</TD>
    <TD class="td2" WIDTH="77" HEIGHT="15">上班時間</TD>
    <TD class="td2" WIDTH="77" HEIGHT="15">下班時間</TD>
    <TD class="td2" WIDTH="77" HEIGHT="15">遲到(分)</TD>
    <TD class="td2" WIDTH="70" HEIGHT="15">早退(分)</TD>
    <TD class="td2" WIDTH="44" HEIGHT="15">曠職</TD>
    <TD class="td2" WIDTH="105" HEIGHT="15">員工代號</TD>
  </TR>
<%DO WHILE NOT RS1.EOF%>
  <TR>
    <TD WIDTH="73" HEIGHT="16"><%=RS1.FIELDS("NAME_C")%>
</TD>
    <TD WIDTH="81" HEIGHT="16"><%=RS1.FIELDS("ADATE")%>
</TD>
    <TD WIDTH="68" HEIGHT="16"><%=RS1.FIELDS("ROTENAME")%>
</TD>
    <TD WIDTH="77" HEIGHT="16"><%=RS1.FIELDS("T1")%>
</TD>
    <TD WIDTH="77" HEIGHT="16">
<%=RS1.FIELDS("T2")%>
</TD>
    <TD WIDTH="77" HEIGHT="16"><%=RS1.FIELDS("LATE_MINS")%>
</TD>
    <TD WIDTH="70" HEIGHT="16"><%=RS1.FIELDS("E_MINS")%>
</TD>
    <TD WIDTH="44" HEIGHT="16"><%IF RS1.FIELDS("ABS") THEN
	RESPONSE.WRITE "是"
ELSE
	RESPONSE.WRITE "否"
END IF%>
</TD>
    <TD WIDTH="105" HEIGHT="16"><%=RS1.FIELDS("NOBR")%>
</TD>
  </TR>
<%RS1.MOVENEXT
		LOOP%>
</TABLE>

<P><%			ELSE
				RESPONSE.WRITE "無資料"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "無法連結資料庫"
		END IF
		SET HRCON=NOTHING
CASE "OT"
		IF ISOBJECT(HRCON) THEN
			SQLSTR="SELECT A.*,B.NAME_C FROM OT A,BASE B WHERE A.NOBR='"& MNOBR&"'"
			SQLSTR=SQLSTR &" AND A.NOBR=B.NOBR"
			SQLSTR=SQLSTR &" AND CONVERT(CHAR,A.BDATE,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'"
			SQLSTR=SQLSTR &" ORDER BY A.NOBR,BDATE DESC"
			SET RS1=HRCON.EXECUTE(SQLSTR)
			IF NOT RS1.EOF THEN
%></P>

<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="632">
    <tr>
      <td colspan="7" class="form_title">◆ 加 班 資 料 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="112">員工姓名</TD>
    <TD class="td2" WIDTH="119">加班日期</TD>
    <TD class="td2" WIDTH="106">加班時數</TD>
    <TD class="td2" WIDTH="114">員工代號</TD>
    <TD class="td2" WIDTH="135">(得)補休時數</TD>
    <TD class="td2" WIDTH="126">計薪年月</TD>
    <TD class="td2" WIDTH="189">備註</TD>
  </TR>
<%DO WHILE NOT RS1.EOF%>
  <TR>
    <TD WIDTH="112"><%=RS1.FIELDS("NAME_C")%>
</TD>
    <TD WIDTH="119"><%=RS1.FIELDS("BDATE")%>
</TD>
    <TD WIDTH="106"><%=RS1.FIELDS("OT_HRS")%>
</TD>
    <TD WIDTH="114"><%=RS1.FIELDS("NOBR")%>
</TD>
    <TD WIDTH="135"><%=RS1.FIELDS("REST_HRS")%>
</TD>
    <TD WIDTH="126"><%=RS1.FIELDS("YYMM")%>
</TD>
    <TD WIDTH="189"><%=RS1.FIELDS("NOTE")%>
</TD>
  </TR>
<%RS1.MOVENEXT
		LOOP%>
</TABLE>

<P><%			ELSE
				RESPONSE.WRITE "無資料"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "無法連結資料庫"
		END IF
		SET HRCON=NOTHING
CASE "CARD"
		IF ISOBJECT(HRCON) THEN
			SQLSTR="SELECT A.*,B.NAME_C FROM CARD A,BASE B WHERE A.NOBR='"& MNOBR&"'"
			SQLSTR=SQLSTR &" AND A.NOBR=B.NOBR"
			SQLSTR=SQLSTR &" AND CONVERT(CHAR,A.ADATE,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'"
			SQLSTR=SQLSTR &" ORDER BY A.NOBR,ADATE DESC,ONTIME DESC"
			SET RS1=HRCON.EXECUTE(SQLSTR)
			IF NOT RS1.EOF THEN
%></P>

<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="620">
    <tr>
      <td colspan="4" class="form_title">◆ 刷 卡 資 料 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="73">員工姓名</TD>
    <TD class="td2" WIDTH="77">刷卡日期</TD>
    <TD class="td2" WIDTH="65">刷卡時間</TD>
    <TD class="td2" WIDTH="65">員工代號</TD>
  </TR>
<%DO WHILE NOT RS1.EOF%>
  <TR>
    <TD WIDTH="73"><%=RS1.FIELDS("NAME_C")%>
</TD>
    <TD WIDTH="77"><%=RS1.FIELDS("ADATE")%>
</TD>
    <TD WIDTH="65"><%=RS1.FIELDS("ONTIME")%>
</TD>
    <TD WIDTH="65"><%=RS1.FIELDS("NOBR")%>
</TD>
  </TR>
<%RS1.MOVENEXT
		LOOP%>
</TABLE>

<P ALIGN="LEFT"><%			ELSE
				RESPONSE.WRITE "無資料"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "無法連結資料庫"
		END IF
		SET HRCON=NOTHING

CASE "YEAR_ABS"       
		MTOL_HOURS1=0       
		MTOL_HOURS2=0       
		IF ISOBJECT(HRCON) THEN       
			SQLSTR="SELECT DISTINCT  A.*,B.NAME_C,C.H_NAME,C.YEAR_REST,C.UNIT,D.INDT FROM ABS A,BASE B,HCODE C,BASETTS D WHERE A.NOBR=B.NOBR AND A.NOBR='"+MNOBR+"'"       
			SQLSTR=SQLSTR+" AND A.H_CODE=C.H_CODE AND B.NOBR = D.NOBR"       
			SQLSTR=SQLSTR+" AND YEAR_REST IN('1','2')"       
			SQLSTR=SQLSTR &" AND CONVERT(CHAR,A.BDATE,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'"       
			SQLSTR=SQLSTR+" ORDER BY A.NOBR,A.BDATE,A.H_CODE"       
			SET RS1=HRCON.EXECUTE(SQLSTR)       
			'RESPONSE.WRITE SQLSTR

			IF NOT RS1.EOF THEN       
%></P>       
       
<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="669" HEIGHT="43">
  <tr> 
    <td colspan="10" class="form_title">◆ 年 休 資 料 ◆</td>
  </tr>
  <TR> 
    <TD class="td2" WIDTH="78" HEIGHT="15">員工姓名</TD>
    <TD class="td2" WIDTH="63">員工代號</TD>
    <TD class="td2" WIDTH="59">到職日</TD>
    <TD class="td2" WIDTH="76" HEIGHT="15">差勤日期</TD>
    <TD class="td2" WIDTH="74" HEIGHT="15">假別名稱</TD>
    <TD class="td2" WIDTH="74" HEIGHT="15">得假 <P>天數</TD>
    <TD class="td2" WIDTH="61" HEIGHT="15">累計 <P>天數</TD>
    <TD class="td2" WIDTH="67" HEIGHT="15">請假 <P>天數</TD>
    <TD class="td2" WIDTH="47" HEIGHT="15">累計 <P>天數</TD>
    <TD class="td2" WIDTH="59" HEIGHT="15">尚餘 <P>天數</TD>
  </TR>
  <%DO WHILE NOT RS1.EOF%>
  <TR> 
    <TD WIDTH="78" HEIGHT="16"><%=RS1.FIELDS("NAME_C")%> </TD><!--姓名-->
    <TD WIDTH="63"><%=RS1.FIELDS("NOBR")%> </TD><!--員工代號-->
    <TD WIDTH="59"><%=RS1.FIELDS("INDT")%></TD><!--到職日-->
    <TD WIDTH="76" HEIGHT="16"><%=RS1.FIELDS("BDATE")%> </TD><!--差勤日期-->
    <TD WIDTH="74" HEIGHT="16"><%=RS1.FIELDS("H_NAME")%> </TD><!--假別名稱-->
    <TD WIDTH="74" HEIGHT="16"> <!--得假時數-->
      <%
	  i_year = (year(RS1.FIELDS("BDATE"))-year(RS1.FIELDS("INDT")))*365
	  'RESPONSE.write "多少年=="& i_year&"   ==" 
	
	 if  cdate(RS1.FIELDS("BDATE")) >= cdate(RS1.FIELDS("INDT")) and  cdate(RS1.FIELDS("BDATE")) < dateAdd("y",1,cdate(RS1.FIELDS("INDT")) ) then
	 	WW1 =RS1.FIELDS("TOL_HOURS") 
				
	 elseif   cdate(RS1.FIELDS("BDATE")) >=  dateAdd("y",i_year,cdate(RS1.FIELDS("INDT")) )  and cdate(RS1.FIELDS("BDATE")) <  dateAdd("y",i_year+365,cdate(RS1.FIELDS("INDT")) ) and  RS1.FIELDS("YEAR_REST")="1" then
		MTOL_HOURS1 = 0 
		MTOL_HOURS2 = 0 
		WW1 = RS1.FIELDS("TOL_HOURS")
	else 
		WW1 =RS1.FIELDS("TOL_HOURS")
	end if   	  
	  

IF RS1.FIELDS("UNIT")="天" THEN
	WW1=WW1*8
END IF      
IF RS1.FIELDS("YEAR_REST")="2" THEN       
	WW1=0       
END IF       
RESPONSE.WRITE WW1%>
    </TD>
    <TD WIDTH="61" HEIGHT="16"> <!--累計 時數-->
      <%IF RS1.FIELDS("YEAR_REST")="1" THEN       
	AA1=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA1=0       
END IF       
IF RS1.FIELDS("UNIT")="天" THEN
	AA1=AA1*8
END IF      
MTOL_HOURS1=MTOL_HOURS1+CDBL(CSTR(AA1))       
RESPONSE.WRITE MTOL_HOURS1-MTOL_HOURS2        
       
%>
    </TD>
    <TD WIDTH="67" HEIGHT="16"> 
      <%WW2=RS1.FIELDS("TOL_HOURS")       
IF RS1.FIELDS("YEAR_REST")="1" THEN       
	WW2=0       
END IF       
IF RS1.FIELDS("UNIT")="天" THEN
	WW2=WW2*8
END IF      
RESPONSE.WRITE WW2       
%>
    </TD>
    <TD WIDTH="47" HEIGHT="16"> 
      <%IF RS1.FIELDS("YEAR_REST")="2" THEN       
	AA2=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA2=0       
END IF       
IF RS1.FIELDS("UNIT")="天" THEN
	AA2=AA2*8
END IF      
MTOL_HOURS2=MTOL_HOURS2+CDBL(CSTR(AA2))       
RESPONSE.WRITE MTOL_HOURS2       
       
%>
    </TD>
    <TD WIDTH="59" HEIGHT="16"> 
      <%CC=MTOL_HOURS1-MTOL_HOURS2       
RESPONSE.WRITE CC       
       
%>
    </TD>
  </TR>
  <%RS1.MOVENEXT       
		LOOP%>
</TABLE>       
       
<P><%			ELSE       

		MTOL_HOURS1=0       
		MTOL_HOURS2=0       
			SQLSTR="SELECT DISTINCT  A.*,B.NAME_C,C.H_NAME,C.YEAR_REST,C.UNIT,D.INDT FROM ABS A,BASE B,HCODE C,BASETTS D WHERE A.NOBR=B.NOBR AND A.NOBR='"+MNOBR+"'"       
			SQLSTR=SQLSTR+" AND A.H_CODE=C.H_CODE AND B.NOBR = D.NOBR"       
			SQLSTR=SQLSTR+" AND YEAR_REST IN('1','2')"       
			SQLSTR=SQLSTR &" AND A.BDATE BETWEEN '"& dateAdd("y",-365,cdate(date()) )&"'"&" AND '"&cdate(date())&"'"       
			SQLSTR=SQLSTR+" ORDER BY A.NOBR,A.BDATE,A.H_CODE"       
			SET RS1=HRCON.EXECUTE(SQLSTR)       
			IF NOT RS1.EOF THEN  
			DO WHILE NOT RS1.EOF     

	i_year = (year(dateAdd("y",-365,cdate(now) ))-year(RS1.FIELDS("INDT")))*365
	if  cdate(dateAdd("y",-365,cdate(now) )) >= cdate(RS1.FIELDS("INDT")) and  cdate(dateAdd("y",-365,cdate(now) )) < dateAdd("y",1,cdate(RS1.FIELDS("INDT")) ) then
	 	WW1 =RS1.FIELDS("TOL_HOURS") 
				
	elseif   cdate(dateAdd("y",-365,cdate(now) )) >=  dateAdd("y",i_year,cdate(RS1.FIELDS("INDT")) )  and cdate(dateAdd("y",-365,cdate(now) )) <  dateAdd("y",i_year+365,cdate(RS1.FIELDS("INDT")) ) and  RS1.FIELDS("YEAR_REST")="1" then
		MTOL_HOURS1 = 0 
		MTOL_HOURS2 = 0 
		WW1 = RS1.FIELDS("TOL_HOURS")
	else 
		WW1 =RS1.FIELDS("TOL_HOURS")
	end if   	  
	
	
IF RS1.FIELDS("YEAR_REST")="1" THEN       
	AA1=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA1=0       
END IF       
IF RS1.FIELDS("UNIT")="天" THEN
	AA1=AA1*8
END IF      
MTOL_HOURS1=MTOL_HOURS1+CDBL(CSTR(AA1))       

IF RS1.FIELDS("YEAR_REST")="2" THEN       
	AA2=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA2=0       
END IF       
IF RS1.FIELDS("UNIT")="天" THEN
	AA2=AA2*8
END IF      
MTOL_HOURS2=MTOL_HOURS2+CDBL(CSTR(AA2))       

	



			RS1.MOVENEXT
			 LOOP
			end if
				c= 0
				d = 0
			
				c = Int(( MTOL_HOURS1-MTOL_HOURS2)/8)
				'd = (MTOL_HOURS1-MTOL_HOURS2)
			if MTOL_HOURS1 > MTOL_HOURS2 then
				d = (MTOL_HOURS1-MTOL_HOURS2)
			else 
				d = (MTOL_HOURS2-MTOL_HOURS1)
			end if 	
		

				RESPONSE.WRITE "你所查詢的日期沒有資料，你目前特休剩餘<font color=#FF0000>"+CSTR(d)+"</font>天"
				RESPONSE.END       
			END IF       
		ELSE       
			RESPONSE.WRITE "無法連結資料庫"       
		END IF       
		SET HRCON=NOTHING   
CASE "OT_ABS"       
		MTOL_HOURS1=0       
		MTOL_HOURS2=0       
		IF ISOBJECT(HRCON) THEN       
			SQLSTR="SELECT A.*,B.NAME_C,C.H_NAME,C.YEAR_REST FROM ABS A,BASE B,HCODE C WHERE A.NOBR=B.NOBR AND A.NOBR='"+MNOBR+"'"       
			SQLSTR=SQLSTR+" AND A.H_CODE=C.H_CODE"       
			SQLSTR=SQLSTR+" AND YEAR_REST IN ('3','4')"       
			SQLSTR=SQLSTR &" AND CONVERT(CHAR,A.BDATE,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'"       
			SQLSTR=SQLSTR+" ORDER BY A.NOBR,A.BDATE,A.H_CODE"    
			    
			StdDate = cStr(dateAdd("d",-1, cdate(MDATE_B_1)))
			SET RS1=HRCON.EXECUTE(SQLSTR)  
			
			if Month(StdDate) < 10 then
			mm = "0" & Month(StdDate)
			else 
			mm = Month(StdDate)
			end if
			     

			SQLSTR1= "SELECT         SUM(A.TOL_HOURS) AS TOL_HOURS1 "
            SQLSTR1=SQLSTR1+" FROM             ABS A INNER JOIN "
            SQLSTR1=SQLSTR1+" BASE B ON A.NOBR = B.NOBR INNER JOIN "
			SQLSTR1=SQLSTR1+" HCODE C ON A.H_CODE = C.H_CODE "
            SQLSTR1=SQLSTR1+ " WHERE         (A.NOBR = '"+MNOBR+"') AND (C.YEAR_REST IN ('3')) AND (CONVERT(CHAR,A.BDATE,112) BETWEEN '19000101' AND '"&Year(StdDate)&mm&Day(StdDate) &"')"
			SQLSTR2= "SELECT         SUM(A.TOL_HOURS) AS TOL_HOURS1 "
            SQLSTR2=SQLSTR2+" FROM             ABS A INNER JOIN "
            SQLSTR2=SQLSTR2+" BASE B ON A.NOBR = B.NOBR INNER JOIN "
			SQLSTR2=SQLSTR2+" HCODE C ON A.H_CODE = C.H_CODE "
            SQLSTR2=SQLSTR2+ " WHERE         (A.NOBR = '"+MNOBR+"') AND (C.YEAR_REST IN ('4')) AND (CONVERT(CHAR,A.BDATE,112) BETWEEN '19000101' AND '"&Year(StdDate)&mm&Day(StdDate)&"')"

			 SET RS2 = HRCON.EXECUTE(SQLSTR1) 
			 SET RS3 = HRCON.EXECUTE(SQLSTR2) 
			 a= 0 
			 b = 0
			 if RS2.FIELDS("TOL_HOURS1") <> "" then
					a =CDBL(CSTR(RS2.FIELDS("TOL_HOURS1")))
			end if 
			if RS3.FIELDS("TOL_HOURS1") <> "" then
					b =CDBL(CSTR(RS3.FIELDS("TOL_HOURS1"))) 
			end if 

			MTOL_HOURS1  = a- b
			
			IF NOT RS1.EOF THEN          
%></P>       
       
<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="669" HEIGHT="43">   
    <tr>
      <td colspan="10" class="form_title">◆ 補 休 資 料 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="79" HEIGHT="15">員工姓名</TD>       
    <TD class="td2" WIDTH="88">員工代號</TD>       
    <TD class="td2" WIDTH="87" HEIGHT="15">差勤日期</TD> 
    <TD class="td2" WIDTH="87" HEIGHT="15">補休失效日</TD> 
    <TD class="td2" WIDTH="102" HEIGHT="15">補休名稱</TD>       
    <TD class="td2" WIDTH="75" HEIGHT="15">得休<P>時數</TD>       
    <TD class="td2" WIDTH="62" HEIGHT="15">累計<P>時數</TD>       
    <TD class="td2" WIDTH="39" HEIGHT="15">補休<P>時數</TD>       
    <TD class="td2" WIDTH="50" HEIGHT="15">累計<P>時數</TD>       
    <TD class="td2" WIDTH="56" HEIGHT="15">尚餘<P>時數</TD>       
  </TR>       
<%DO WHILE NOT RS1.EOF%>       
  <TR>       
    <TD WIDTH="79" HEIGHT="16"><%=RS1.FIELDS("NAME_C")%>       
</TD>       
    <TD WIDTH="88"><%=RS1.FIELDS("NOBR")%>       
</TD>       
    <TD WIDTH="87" HEIGHT="16"><%=RS1.FIELDS("BDATE")%>       
</TD>       
    <TD WIDTH="87" HEIGHT="16"><%=RS1.FIELDS("EDATE")%>       
</TD>       
    <TD WIDTH="102" HEIGHT="16"><%=RS1.FIELDS("H_NAME")%>       
</TD>       
    <TD WIDTH="75" HEIGHT="16"><%WW1=RS1.FIELDS("TOL_HOURS")       
IF RS1.FIELDS("YEAR_REST")="4" THEN       
	WW1=0       
END IF       
RESPONSE.WRITE WW1%>       
</TD>       
    <TD WIDTH="62" HEIGHT="16"><%IF RS1.FIELDS("YEAR_REST")="3" THEN       
	AA1=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA1=0       
END IF       
MTOL_HOURS1=MTOL_HOURS1+CDBL(CSTR(AA1))       
RESPONSE.WRITE MTOL_HOURS1       
       
%>       
</TD>       
    <TD WIDTH="72" HEIGHT="16"><%WW2=RS1.FIELDS("TOL_HOURS")       
IF RS1.FIELDS("YEAR_REST")="3" THEN       
	WW2=0       
END IF       
RESPONSE.WRITE WW2       
%>       
</TD>       
    <TD WIDTH="46" HEIGHT="16"><%IF RS1.FIELDS("YEAR_REST")="4" THEN       
	AA2=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA2=0       
END IF       
MTOL_HOURS2=MTOL_HOURS2+CDBL(CSTR(AA2))       
RESPONSE.WRITE MTOL_HOURS2       
       
%>       
</TD>       
    <TD WIDTH="52" HEIGHT="16"><%CC=MTOL_HOURS1-MTOL_HOURS2       
RESPONSE.WRITE CC       
       
%>       
</TD>       
  </TR>       
<%RS1.MOVENEXT       
		LOOP%>       
</TABLE>       
       
<P><%			ELSE       
				s = "SELECT         SUM(A.TOL_HOURS) AS TOL_HOURS1 "
                s = s +"  FROM             ABS A INNER JOIN "
                s = s +"      BASE B ON A.NOBR = B.NOBR INNER JOIN "
                s = s +"         HCODE C ON A.H_CODE = C.H_CODE "
				s =	s +"WHERE         (A.NOBR = '"+MNOBR+"') AND (C.YEAR_REST IN ('3'))"
				s1 = "SELECT         SUM(A.TOL_HOURS) AS TOL_HOURS1 "
                s1 = s1 +"  FROM             ABS A INNER JOIN "
                s1 = s1 +"      BASE B ON A.NOBR = B.NOBR INNER JOIN "
                s1 = s1 +"         HCODE C ON A.H_CODE = C.H_CODE "
				s1 = s1 +"WHERE         (A.NOBR = '"+MNOBR+"') AND (C.YEAR_REST IN ('4'))"
			 SET RS_1 = HRCON.EXECUTE(s) 
			 SET RS_2 = HRCON.EXECUTE(s1) 
			 a= 0 
			 b = 0
			 if RS_1.FIELDS("TOL_HOURS1") <> "" then
					a =CDBL(CSTR(RS_1.FIELDS("TOL_HOURS1")))
			end if 
			if RS_2.FIELDS("TOL_HOURS1") <> "" then
					b =CDBL(CSTR(RS_2.FIELDS("TOL_HOURS1"))) 
			end if 
			
			if a > b then
				cc=a-b
			else 
				cc=b-a
			end if 

				RESPONSE.WRITE "你所查詢的日期沒有資料，你目前補休剩餘<font color=#FF0000>"+CSTR(cc)+"</font>小時"       
				RESPONSE.END       
			END IF       
		ELSE       
			RESPONSE.WRITE "無法連結資料庫"       
		END IF       
		SET HRCON=NOTHING      
CASE "AWARD"       
		MTOL_HOURS1=0       
		MTOL_HOURS2=0       
		IF ISOBJECT(HRCON) THEN       
			SQLSTR="SELECT A.*,B.NAME_C,C.DESCR FROM AWARD A,BASE B,AWARDCD C WHERE A.NOBR=B.NOBR AND A.NOBR='"+MNOBR+"'"       
			SQLSTR=SQLSTR+" AND A.AWARD_CODE=C.AWARD_CODE"       
			SQLSTR=SQLSTR &" AND CONVERT(CHAR,A.ADATE,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'"       
			SQLSTR=SQLSTR+" ORDER BY A.NOBR,A.ADATE"       
			SET RS1=HRCON.EXECUTE(SQLSTR)       
			IF NOT RS1.EOF THEN       
%></P>       
       
<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="501">
    <tr>
      <td colspan="13" class="form_title">◆ 獎 懲 資 料 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="279" HEIGHT="15">員工姓名</TD>       
    <TD class="td2" WIDTH="77">員工代號</TD>       
    <TD class="td2" WIDTH="90" HEIGHT="15">獎懲日期</TD>       
    <TD class="td2" WIDTH="139" HEIGHT="15">獎懲原因</TD>       
    <TD class="td2" WIDTH="50" HEIGHT="15">大功</TD>             
    <TD class="td2" WIDTH="50" HEIGHT="15">小功</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">嘉獎</TD>            
    <TD class="td2" WIDTH="86" HEIGHT="15">獎金</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">晉級</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">大過</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">小過</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">申誡</TD>             
    <TD class="td2" WIDTH="339" HEIGHT="15">原因</TD>     
  </TR>       
<%DO WHILE NOT RS1.EOF%>       
  <TR>       
    <TD WIDTH="279" HEIGHT="16"><%=RS1.FIELDS("NAME_C")%>    </TD>       
    <TD WIDTH="77"><%=RS1.FIELDS("NOBR")%>       </TD>       
    <TD WIDTH="90" HEIGHT="16"><%=RS1.FIELDS("ADATE")%>       </TD>       
    <TD WIDTH="139" HEIGHT="16"><%=RS1.FIELDS("DESCR")%>       </TD>        
    <TD WIDTH="50" HEIGHT="16"><%=RS1.FIELDS("AWARD1")%>       </TD>          
    <TD WIDTH="50" HEIGHT="16"><%=RS1.FIELDS("AWARD2")%>       </TD>          
    <TD WIDTH="50" HEIGHT="16"><%=RS1.FIELDS("AWARD3")%>       </TD>          
    <TD WIDTH="86" HEIGHT="16"><%=RS1.FIELDS("AWARD4")%>       </TD>          
    <TD WIDTH="50" HEIGHT="16"><%IF RS1.FIELDS("AWARD5") THEN   
					RESPONSE.WRITE "Ｏ"   
				ELSE   
					RESPONSE.WRITE " "   
				END IF  %>       </TD>          
    <TD WIDTH="50" HEIGHT="16"><%=RS1.FIELDS("FAULT1")%>       </TD>         
    <TD WIDTH="50" HEIGHT="16"><%=RS1.FIELDS("FAULT2")%>       </TD>         
    <TD WIDTH="50" HEIGHT="16"><%=RS1.FIELDS("FAULT3")%>       </TD>         
    <TD WIDTH="339" HEIGHT="16"><%=RS1.FIELDS("NOTE")%>       </TD>       
  </TR>       
<%RS1.MOVENEXT       
		LOOP%>       
</TABLE>       
       
<P><%			ELSE       
				RESPONSE.WRITE "無資料"       
				RESPONSE.END       
			END IF       
		ELSE       
			RESPONSE.WRITE "無法連結資料庫"       
		END IF       
		SET HRCON=NOTHING   
	CASE "TRAIN"    
		IF ISOBJECT(HRCON) THEN         
			SQLSTR="SELECT A.*,B.* FROM TRATT A,TRCOS B WHERE A.COSCODE=B.COSCODE AND A.IDNO='"+MNOBR+"'"         
			SQLSTR=SQLSTR &" AND CONVERT(CHAR,B.COSDATEB,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'"         
			SQLSTR=SQLSTR+" AND B.COSDATEB<GETDATE()"    
			SQLSTR=SQLSTR+" ORDER BY A.IDNO,B.COSDATEB"    
			SET RS1=HRCON.EXECUTE(SQLSTR)         
			IF NOT RS1.EOF THEN      
%></P>         
<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="100%"> 
    <tr>
      <td colspan="6" class="form_title">◆ 教 育 訓 練 資 料 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="8%">內訓課程名稱</TD>   
    <TD class="td2" WIDTH="6%">上課日期</TD>   
    <TD class="td2" WIDTH="7%">分攤費用</TD>   
    <TD class="td2" WIDTH="7%">成績</TD>   
    <TD class="td2" WIDTH="8%">請假時數</TD>   
    <TD class="td2" WIDTH="8%">結訓</TD>   
  </TR>   
<%DO WHILE NOT RS1.EOF%>        
  <TR>   
    <TD WIDTH="8%"><%RESPONSE.WRITE RS1.FIELDS("DESCR")%>   
    </TD>   
    <TD WIDTH="6%"><%RESPONSE.WRITE CSTR(RS1.FIELDS("COSDATEB"))+" "+RS1.FIELDS("COSTIMEB")+"至"+CSTR(RS1.FIELDS("COSDATEE"))+" "+RS1.FIELDS("COSTIMEE")%>   
    </TD>   
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("FEE")%>   
    </TD>   
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("SCORE")%>   
    </TD>   
    <TD WIDTH="8%"><%RESPONSE.WRITE RS1.FIELDS("ABSHRS")%>   
    </TD>   
    <TD WIDTH="8%"><%IF RS1.FIELDS("COSCLOSE") THEN   
	RESPONSE.WRITE "是"   
ELSE   
	RESPONSE.WRITE "否"   
END IF   
      %>   
    </TD>   
  </TR>   
<%RS1.MOVENEXT        
		LOOP%>        
</TABLE>   
<%			ELSE      
				RESPONSE.WRITE "無內訓資料"      
			END IF      
		ELSE      
			RESPONSE.WRITE "無法連結資料庫"      
		END IF%> 
 
       
<P>　</P> 
 
<% 
		IF ISOBJECT(HRCON) THEN        
			SQLSTR="SELECT A.* FROM TRCOSF A WHERE A.IDNO='"+MNOBR+"'"        
			SQLSTR=SQLSTR &" AND CONVERT(CHAR,A.DATE_B,112) BETWEEN '"&MDATE_B&"'"&" AND '"&MDATE_E&"'"        
			SQLSTR=SQLSTR+" AND A.DATE_B<GETDATE()"   
			SQLSTR=SQLSTR+" ORDER BY A.IDNO,A.DATE_B"   
			SET RS1=HRCON.EXECUTE(SQLSTR)        
			IF NOT RS1.EOF THEN    %> 
  
       
<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="100%"> 
  <TR> 
    <TD WIDTH="11%">外訓課程名稱</TD> 
    <TD WIDTH="11%">上課日期</TD> 
    <TD WIDTH="11%">上課時數</TD> 
    <TD WIDTH="11%">上課費用</TD> 
    <TD WIDTH="11%">訓練單位</TD> 
  </TR> 
<%DO WHILE NOT RS1.EOF%>        
  
  <TR> 
    <TD WIDTH="11%"><%RESPONSE.WRITE RS1.FIELDS("COURSE")%>  
    </TD> 
    <TD WIDTH="11%"><%RESPONSE.WRITE RS1.FIELDS("DATE_B")%></TD> 
    <TD WIDTH="11%"><%RESPONSE.WRITE RS1.FIELDS("TR_HRS")%></TD> 
    <TD WIDTH="11%"><%RESPONSE.WRITE RS1.FIELDS("COS_FEE")%></TD> 
    <TD WIDTH="11%"><%RESPONSE.WRITE RS1.FIELDS("TR_COMP")%></TD> 
  </TR> 
<%RS1.MOVENEXT        
		LOOP%>        
</TABLE> 
      
<P><%			ELSE      
				RESPONSE.WRITE "無外訓資料"      
				RESPONSE.END      
			END IF      
		ELSE      
			RESPONSE.WRITE "無法連結資料庫"      
		END IF      
	CASE "TRATT"    
		IF ISOBJECT(HRCON) THEN       
			SQLSTR="SELECT A.*,B.* FROM TRATT A,TRCOS B WHERE A.COSCODE=B.COSCODE AND A.IDNO='"+MNOBR+"'"       
			SQLSTR=SQLSTR+" AND B.COSDATEB>GETDATE()"  
			SQLSTR=SQLSTR+" ORDER BY A.IDNO,B.COSDATEB"  
			'RESPONSE.WRITE SQLSTR    
			SET RS1=HRCON.EXECUTE(SQLSTR)       
			IF NOT RS1.EOF THEN%>      
  
<TABLE BORDER="0" cellspacing="1" cellpadding="0" align="center" WIDTH="100%"> 
    <tr>
      <td colspan="6" class="form_title">◆ 預 定 要 上 的 課 程 ◆</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="7%">課程名稱</TD>  
    <TD class="td2" WIDTH="7%">上課日期</TD>  
    <TD class="td2" WIDTH="7%">分攤費用</TD>  
    <TD class="td2" WIDTH="7%">成績</TD>  
    <TD class="td2" WIDTH="8%">請假時數</TD>  
    <TD class="td2" WIDTH="8%">結訓</TD>  
  </TR>  
<%DO WHILE NOT RS1.EOF%>       
  <TR>  
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("DESCR")%>  
    </TD>  
    <TD WIDTH="7%"><%RESPONSE.WRITE CSTR(RS1.FIELDS("COSDATEB"))+" "+RS1.FIELDS("COSTIMEB")+"至"+CSTR(RS1.FIELDS("COSDATEE"))+" "+RS1.FIELDS("COSTIMEE")%>  
    </TD>  
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("FEE")%>  
    </TD>  
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("SCORE")%>  
    </TD>  
    <TD WIDTH="8%"><%RESPONSE.WRITE RS1.FIELDS("ABSHRS")%>  
    </TD>  
    <TD WIDTH="8%"><%IF RS1.FIELDS("COSCLOSE") THEN  
	RESPONSE.WRITE "是"  
ELSE  
	RESPONSE.WRITE "否"  
END IF  
      %>  
    </TD>  
  </TR>  
<%RS1.MOVENEXT       
		LOOP%>       
</TABLE>  
  
  
  
<P>　</P> 
  
  
  
<%			ELSE      
				RESPONSE.WRITE "無資料"      
				RESPONSE.END      
			END IF      
		ELSE      
			RESPONSE.WRITE "無法連結資料庫"      
		END IF      
		SET HRCON=NOTHING  
END SELECT%>      
</BODY>      
</HTML>      
  
  