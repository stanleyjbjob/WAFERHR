<%@ Control Language="C#" AutoEventWireup="true" CodeFile="edu.ascx.cs" Inherits="UC_edu" %>
<fieldset>
	
	 <legend>訓練資料：</legend><br />
	 

	<asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" Visible="False">
		<RowStyle HorizontalAlign="Center" />
	</asp:GridView>
	<asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
		SelectCommand="SELECT course AS 課程名稱, tr_comp AS 上課地點, tr_hrs AS 上課時數, date_b AS 上課日期, date_e AS 結束日期, close_ AS 結業 FROM trcosf WHERE (idno = @nobr) AND (date_b BETWEEN @adate AND @ddate) ORDER BY date_b">
		<SelectParameters>
			<asp:SessionParameter Name="nobr" SessionField="s_nobr" />
			<asp:SessionParameter Name="adate" SessionField="s_adate" />
			<asp:SessionParameter Name="ddate" SessionField="s_ddate" />
		</SelectParameters>
	</asp:SqlDataSource>
	
</fieldset>
