
<HTML>

<HEAD>
<META HTTP-EQUIV="CONTENT-TYPE" CONTENT="TEXT/HTML; CHARSET=BIG5">
<META NAME="GENERATOR" CONTENT="Microsoft FrontPage 6.0">
<LINK HREF="MAIN.CSS" REL=STYLESHEET TYPE=TEXT/CSS>
<TITLE>�d�ߵ��G</TITLE>
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
      <td colspan="5" class="form_title">�� �� �� �� �� ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="66">���u�m�W</TD>
    <TD class="td2" WIDTH="76">���O</TD>
    <TD class="td2" WIDTH="90">�а�����_</TD>
    <TD class="td2" WIDTH="69">�а��ɼ�</TD>
    <TD class="td2" WIDTH="124">���u�N��</TD>
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
				RESPONSE.WRITE "�L���"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "�L�k�s����Ʈw"
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
      <td colspan="9" class="form_title">�� �X �� �� �� ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="73" HEIGHT="15">���u�m�W</TD>
    <TD class="td2" WIDTH="81" HEIGHT="15">�X�Ԥ��</TD>
    <TD class="td2" WIDTH="68" HEIGHT="15">�Z�O</TD>
    <TD class="td2" WIDTH="77" HEIGHT="15">�W�Z�ɶ�</TD>
    <TD class="td2" WIDTH="77" HEIGHT="15">�U�Z�ɶ�</TD>
    <TD class="td2" WIDTH="77" HEIGHT="15">���(��)</TD>
    <TD class="td2" WIDTH="70" HEIGHT="15">���h(��)</TD>
    <TD class="td2" WIDTH="44" HEIGHT="15">�m¾</TD>
    <TD class="td2" WIDTH="105" HEIGHT="15">���u�N��</TD>
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
	RESPONSE.WRITE "�O"
ELSE
	RESPONSE.WRITE "�_"
END IF%>
</TD>
    <TD WIDTH="105" HEIGHT="16"><%=RS1.FIELDS("NOBR")%>
</TD>
  </TR>
<%RS1.MOVENEXT
		LOOP%>
</TABLE>

<P><%			ELSE
				RESPONSE.WRITE "�L���"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "�L�k�s����Ʈw"
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
      <td colspan="7" class="form_title">�� �[ �Z �� �� ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="112">���u�m�W</TD>
    <TD class="td2" WIDTH="119">�[�Z���</TD>
    <TD class="td2" WIDTH="106">�[�Z�ɼ�</TD>
    <TD class="td2" WIDTH="114">���u�N��</TD>
    <TD class="td2" WIDTH="135">(�o)�ɥ�ɼ�</TD>
    <TD class="td2" WIDTH="126">�p�~�~��</TD>
    <TD class="td2" WIDTH="189">�Ƶ�</TD>
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
				RESPONSE.WRITE "�L���"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "�L�k�s����Ʈw"
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
      <td colspan="4" class="form_title">�� �� �d �� �� ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="73">���u�m�W</TD>
    <TD class="td2" WIDTH="77">��d���</TD>
    <TD class="td2" WIDTH="65">��d�ɶ�</TD>
    <TD class="td2" WIDTH="65">���u�N��</TD>
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
				RESPONSE.WRITE "�L���"
				RESPONSE.END
			END IF
		ELSE
			RESPONSE.WRITE "�L�k�s����Ʈw"
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
    <td colspan="10" class="form_title">�� �~ �� �� �� ��</td>
  </tr>
  <TR> 
    <TD class="td2" WIDTH="78" HEIGHT="15">���u�m�W</TD>
    <TD class="td2" WIDTH="63">���u�N��</TD>
    <TD class="td2" WIDTH="59">��¾��</TD>
    <TD class="td2" WIDTH="76" HEIGHT="15">�t�Ԥ��</TD>
    <TD class="td2" WIDTH="74" HEIGHT="15">���O�W��</TD>
    <TD class="td2" WIDTH="74" HEIGHT="15">�o�� <P>�Ѽ�</TD>
    <TD class="td2" WIDTH="61" HEIGHT="15">�֭p <P>�Ѽ�</TD>
    <TD class="td2" WIDTH="67" HEIGHT="15">�а� <P>�Ѽ�</TD>
    <TD class="td2" WIDTH="47" HEIGHT="15">�֭p <P>�Ѽ�</TD>
    <TD class="td2" WIDTH="59" HEIGHT="15">�|�l <P>�Ѽ�</TD>
  </TR>
  <%DO WHILE NOT RS1.EOF%>
  <TR> 
    <TD WIDTH="78" HEIGHT="16"><%=RS1.FIELDS("NAME_C")%> </TD><!--�m�W-->
    <TD WIDTH="63"><%=RS1.FIELDS("NOBR")%> </TD><!--���u�N��-->
    <TD WIDTH="59"><%=RS1.FIELDS("INDT")%></TD><!--��¾��-->
    <TD WIDTH="76" HEIGHT="16"><%=RS1.FIELDS("BDATE")%> </TD><!--�t�Ԥ��-->
    <TD WIDTH="74" HEIGHT="16"><%=RS1.FIELDS("H_NAME")%> </TD><!--���O�W��-->
    <TD WIDTH="74" HEIGHT="16"> <!--�o���ɼ�-->
      <%
	  i_year = (year(RS1.FIELDS("BDATE"))-year(RS1.FIELDS("INDT")))*365
	  'RESPONSE.write "�h�֦~=="& i_year&"   ==" 
	
	 if  cdate(RS1.FIELDS("BDATE")) >= cdate(RS1.FIELDS("INDT")) and  cdate(RS1.FIELDS("BDATE")) < dateAdd("y",1,cdate(RS1.FIELDS("INDT")) ) then
	 	WW1 =RS1.FIELDS("TOL_HOURS") 
				
	 elseif   cdate(RS1.FIELDS("BDATE")) >=  dateAdd("y",i_year,cdate(RS1.FIELDS("INDT")) )  and cdate(RS1.FIELDS("BDATE")) <  dateAdd("y",i_year+365,cdate(RS1.FIELDS("INDT")) ) and  RS1.FIELDS("YEAR_REST")="1" then
		MTOL_HOURS1 = 0 
		MTOL_HOURS2 = 0 
		WW1 = RS1.FIELDS("TOL_HOURS")
	else 
		WW1 =RS1.FIELDS("TOL_HOURS")
	end if   	  
	  

IF RS1.FIELDS("UNIT")="��" THEN
	WW1=WW1*8
END IF      
IF RS1.FIELDS("YEAR_REST")="2" THEN       
	WW1=0       
END IF       
RESPONSE.WRITE WW1%>
    </TD>
    <TD WIDTH="61" HEIGHT="16"> <!--�֭p �ɼ�-->
      <%IF RS1.FIELDS("YEAR_REST")="1" THEN       
	AA1=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA1=0       
END IF       
IF RS1.FIELDS("UNIT")="��" THEN
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
IF RS1.FIELDS("UNIT")="��" THEN
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
IF RS1.FIELDS("UNIT")="��" THEN
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
IF RS1.FIELDS("UNIT")="��" THEN
	AA1=AA1*8
END IF      
MTOL_HOURS1=MTOL_HOURS1+CDBL(CSTR(AA1))       

IF RS1.FIELDS("YEAR_REST")="2" THEN       
	AA2=RS1.FIELDS("TOL_HOURS")       
ELSE       
	AA2=0       
END IF       
IF RS1.FIELDS("UNIT")="��" THEN
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
		

				RESPONSE.WRITE "�A�Ҭd�ߪ�����S����ơA�A�ثe�S��Ѿl<font color=#FF0000>"+CSTR(d)+"</font>��"
				RESPONSE.END       
			END IF       
		ELSE       
			RESPONSE.WRITE "�L�k�s����Ʈw"       
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
      <td colspan="10" class="form_title">�� �� �� �� �� ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="79" HEIGHT="15">���u�m�W</TD>       
    <TD class="td2" WIDTH="88">���u�N��</TD>       
    <TD class="td2" WIDTH="87" HEIGHT="15">�t�Ԥ��</TD> 
    <TD class="td2" WIDTH="87" HEIGHT="15">�ɥ𥢮Ĥ�</TD> 
    <TD class="td2" WIDTH="102" HEIGHT="15">�ɥ�W��</TD>       
    <TD class="td2" WIDTH="75" HEIGHT="15">�o��<P>�ɼ�</TD>       
    <TD class="td2" WIDTH="62" HEIGHT="15">�֭p<P>�ɼ�</TD>       
    <TD class="td2" WIDTH="39" HEIGHT="15">�ɥ�<P>�ɼ�</TD>       
    <TD class="td2" WIDTH="50" HEIGHT="15">�֭p<P>�ɼ�</TD>       
    <TD class="td2" WIDTH="56" HEIGHT="15">�|�l<P>�ɼ�</TD>       
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

				RESPONSE.WRITE "�A�Ҭd�ߪ�����S����ơA�A�ثe�ɥ�Ѿl<font color=#FF0000>"+CSTR(cc)+"</font>�p��"       
				RESPONSE.END       
			END IF       
		ELSE       
			RESPONSE.WRITE "�L�k�s����Ʈw"       
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
      <td colspan="13" class="form_title">�� �� �g �� �� ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="279" HEIGHT="15">���u�m�W</TD>       
    <TD class="td2" WIDTH="77">���u�N��</TD>       
    <TD class="td2" WIDTH="90" HEIGHT="15">���g���</TD>       
    <TD class="td2" WIDTH="139" HEIGHT="15">���g��]</TD>       
    <TD class="td2" WIDTH="50" HEIGHT="15">�j�\</TD>             
    <TD class="td2" WIDTH="50" HEIGHT="15">�p�\</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">�ż�</TD>            
    <TD class="td2" WIDTH="86" HEIGHT="15">����</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">�ʯ�</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">�j�L</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">�p�L</TD>            
    <TD class="td2" WIDTH="50" HEIGHT="15">�ӻ|</TD>             
    <TD class="td2" WIDTH="339" HEIGHT="15">��]</TD>     
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
					RESPONSE.WRITE "��"   
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
				RESPONSE.WRITE "�L���"       
				RESPONSE.END       
			END IF       
		ELSE       
			RESPONSE.WRITE "�L�k�s����Ʈw"       
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
      <td colspan="6" class="form_title">�� �� �| �V �m �� �� ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="8%">���V�ҵ{�W��</TD>   
    <TD class="td2" WIDTH="6%">�W�Ҥ��</TD>   
    <TD class="td2" WIDTH="7%">���u�O��</TD>   
    <TD class="td2" WIDTH="7%">���Z</TD>   
    <TD class="td2" WIDTH="8%">�а��ɼ�</TD>   
    <TD class="td2" WIDTH="8%">���V</TD>   
  </TR>   
<%DO WHILE NOT RS1.EOF%>        
  <TR>   
    <TD WIDTH="8%"><%RESPONSE.WRITE RS1.FIELDS("DESCR")%>   
    </TD>   
    <TD WIDTH="6%"><%RESPONSE.WRITE CSTR(RS1.FIELDS("COSDATEB"))+" "+RS1.FIELDS("COSTIMEB")+"��"+CSTR(RS1.FIELDS("COSDATEE"))+" "+RS1.FIELDS("COSTIMEE")%>   
    </TD>   
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("FEE")%>   
    </TD>   
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("SCORE")%>   
    </TD>   
    <TD WIDTH="8%"><%RESPONSE.WRITE RS1.FIELDS("ABSHRS")%>   
    </TD>   
    <TD WIDTH="8%"><%IF RS1.FIELDS("COSCLOSE") THEN   
	RESPONSE.WRITE "�O"   
ELSE   
	RESPONSE.WRITE "�_"   
END IF   
      %>   
    </TD>   
  </TR>   
<%RS1.MOVENEXT        
		LOOP%>        
</TABLE>   
<%			ELSE      
				RESPONSE.WRITE "�L���V���"      
			END IF      
		ELSE      
			RESPONSE.WRITE "�L�k�s����Ʈw"      
		END IF%> 
 
       
<P>�@</P> 
 
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
    <TD WIDTH="11%">�~�V�ҵ{�W��</TD> 
    <TD WIDTH="11%">�W�Ҥ��</TD> 
    <TD WIDTH="11%">�W�Үɼ�</TD> 
    <TD WIDTH="11%">�W�ҶO��</TD> 
    <TD WIDTH="11%">�V�m���</TD> 
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
				RESPONSE.WRITE "�L�~�V���"      
				RESPONSE.END      
			END IF      
		ELSE      
			RESPONSE.WRITE "�L�k�s����Ʈw"      
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
      <td colspan="6" class="form_title">�� �w �w �n �W �� �� �{ ��</td>
    </tr>
  <TR>
    <TD class="td2" WIDTH="7%">�ҵ{�W��</TD>  
    <TD class="td2" WIDTH="7%">�W�Ҥ��</TD>  
    <TD class="td2" WIDTH="7%">���u�O��</TD>  
    <TD class="td2" WIDTH="7%">���Z</TD>  
    <TD class="td2" WIDTH="8%">�а��ɼ�</TD>  
    <TD class="td2" WIDTH="8%">���V</TD>  
  </TR>  
<%DO WHILE NOT RS1.EOF%>       
  <TR>  
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("DESCR")%>  
    </TD>  
    <TD WIDTH="7%"><%RESPONSE.WRITE CSTR(RS1.FIELDS("COSDATEB"))+" "+RS1.FIELDS("COSTIMEB")+"��"+CSTR(RS1.FIELDS("COSDATEE"))+" "+RS1.FIELDS("COSTIMEE")%>  
    </TD>  
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("FEE")%>  
    </TD>  
    <TD WIDTH="7%"><%RESPONSE.WRITE RS1.FIELDS("SCORE")%>  
    </TD>  
    <TD WIDTH="8%"><%RESPONSE.WRITE RS1.FIELDS("ABSHRS")%>  
    </TD>  
    <TD WIDTH="8%"><%IF RS1.FIELDS("COSCLOSE") THEN  
	RESPONSE.WRITE "�O"  
ELSE  
	RESPONSE.WRITE "�_"  
END IF  
      %>  
    </TD>  
  </TR>  
<%RS1.MOVENEXT       
		LOOP%>       
</TABLE>  
  
  
  
<P>�@</P> 
  
  
  
<%			ELSE      
				RESPONSE.WRITE "�L���"      
				RESPONSE.END      
			END IF      
		ELSE      
			RESPONSE.WRITE "�L�k�s����Ʈw"      
		END IF      
		SET HRCON=NOTHING  
END SELECT%>      
</BODY>      
</HTML>      
  
  