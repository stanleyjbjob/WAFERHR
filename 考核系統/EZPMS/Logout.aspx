<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true" CodeFile="Logout.aspx.cs" Inherits="Logout" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<table border="0" cellspacing="0" cellpadding="1" align="center" bgcolor="#00B000"><tr><td>
			<table width="672" border="0" cellspacing="0" cellpadding="0" bgcolor="#A4E8A4">
				<tr> 
					<td colspan="2" bgcolor="#3FB923" height="30" align="center"> <b>績效考核自動登出提醒</b></td>
				</tr>
				<tr> 
					<td width = "20%" bgcolor="#FFF8DD">&nbsp;</td>
					<td bgcolor="#FFF8DD">
  	  		  			<br>
                        很抱歉！因您在績效考核系統已閒置超過30分鐘，為了安全性的考量，系統<br>
						已自動將您登出！！ <br><br>
						
  	  		  			◎&nbsp;&nbsp;若您要繼續使用績效考核系統，麻煩您再重新登入<br>
						◎&nbsp;&nbsp;若您有重要資料要保留，請您點選「回上頁功能」，將資料另行複製。<br><br>
								  
   		  			</td>                  			
				</tr> 
				<tr>
					<td colspan="2" bgcolor="#FFF8DD" align="center">謝謝您<br><br>
						<a href="javascript:history.back()"> <b>回上一頁</b> </a> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
						<a href="login.aspx">
						
						<b>重新登入績效考核系統</b> </a>
						<br><br>	
					</td> 
				</tr>					
			</table>        
		</td></tr></table>
</asp:Content>

