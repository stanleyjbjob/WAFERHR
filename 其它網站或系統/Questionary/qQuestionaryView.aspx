<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qQuestionaryView.aspx.cs" Inherits="qQuestionaryView" %>

<html xmlns="http://www.w3.org/1999/xhtml" >
<head id="Head1" runat="server">
    <title>預覽問卷</title>
    <link href="./css/general.css" rel="stylesheet" type="text/css">
</head>
<body class="ThisIsForm">
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server">
            <ProgressTemplate>
                <table id="loaderContainer" border="0" cellpadding="0" cellspacing="0" height="600"
                    onclick="return false;" width="800">
                    <tr>
                        <td id="loaderContainerWH">
                            <div id="loader">
                                <table border="0" cellpadding="0" cellspacing="0" width="100%">
                                    <tr>
                                        <td>
                                            <p>
                                                <img id="IMG1" alt="" height="32" src="./images/loading.gif" width="32" /><strong>請稍後～<br />
                                                    資料連接中............</strong></p>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </td>
                    </tr>
                </table>
            </ProgressTemplate>
        </asp:UpdateProgress>
        <asp:UpdatePanel ID="upl" runat="server">
            <ContentTemplate>
                <h4 class="mainheader">
                    <asp:Label ID="lblHeader" runat="server"></asp:Label></h4>
                <div class="ThisIsForm_all">
                    <div class="UserData">
                    </div>
                    <div>
                        <asp:Label ID="lblTitle" runat="server"></asp:Label><asp:DataList ID="dlQuestionary"
                            runat="server" DataSourceID="sdsQuestionary" OnItemDataBound="dlQuestionary_ItemDataBound"
                            Width="100%">
                            <ItemTemplate>
                                <asp:Label ID="lblCastContent" runat="server" CssClass="qheader" Text='<%# Eval("VALNAME") %>'></asp:Label><br />
                                <asp:DataList ID="dlCast" runat="server" DataSourceID="sdsCast" OnItemDataBound="dlCast_ItemDataBound">
                                    <ItemTemplate>
                                    <table border="0" width="760" cellspacing="0" cellpadding="0" id="table1">
	<tr onmouseover="this.style.backgroundColor='#FFC0FF'" onclick="this.style.backgroundColor='#FF9933'" onmouseout="this.style.backgroundColor='White'">
		<td nowrap="nowrap" width="400"><asp:Label ID="lblThemeContent" runat="server" Text='<%# Eval("ASKDESCRC") %>'></asp:Label></td>
		<td align="right">
		<table border="0" cellspacing="0" width="100%" cellpadding="0" id="table2">
			<tr>
				<td width="20%"><asp:RadioButton ID="rbFraction5" runat="server" GroupName="Fraction" Text='<%# Eval("L5CAP") %>' /></td>
				<td width="20%"><asp:RadioButton ID="rbFraction4" runat="server" GroupName="Fraction" Text='<%# Eval("L4CAP") %>' /></td>
				<td width="20%"><asp:RadioButton ID="rbFraction3" runat="server" GroupName="Fraction" Text='<%# Eval("L3CAP") %>' /></td>
				<td width="20%"><asp:RadioButton ID="rbFraction2" runat="server" GroupName="Fraction" Text='<%# Eval("L2CAP") %>' /></td>
				<td width="20%"><asp:RadioButton ID="rbFraction1" runat="server" GroupName="Fraction" Text='<%# Eval("L1CAP") %>' /></td>
			</tr>
		</table>
		</td>
	</tr>
</table>
                                        
                                        <asp:Label ID="lblThemeCode" runat="server" Text='<%# Eval("ASKCODE") %>' Visible="False"></asp:Label><asp:Label
                                            ID="lblTitleCode" runat="server" Text='<%# Eval("TRVALCDVALCODE") %>' Visible="False"></asp:Label><asp:Label
                                                ID="lblCastCode" runat="server" Text='<%# Eval("TRVALGDGVALCODE") %>' Visible="False"></asp:Label>
                                    </ItemTemplate>
                                </asp:DataList><asp:SqlDataSource ID="sdsCast" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                    SelectCommand="SELECT TRVALGDG.VALCODE AS TRVALGDGVALCODE, TRVALGDG.ASKCODE, TRVALGDG.SORT, TRASKCD.ASKDESCRC, TRVALCD.VALCODE AS TRVALCDVALCODE, TRVALCD.L1CAP, TRVALCD.L2CAP, TRVALCD.L3CAP, TRVALCD.L4CAP, TRVALCD.L5CAP FROM TRVALGDG LEFT OUTER JOIN TRASKCD ON TRVALGDG.ASKCODE = TRASKCD.ASKCODE LEFT OUTER JOIN TRVALCD ON TRASKCD.VALCODE = TRVALCD.VALCODE WHERE (TRVALGDG.VALCODE = @VALCODE) ORDER BY TRVALGDG.SORT">
                                    <SelectParameters>
                                        <asp:ControlParameter ControlID="lblCastCode" Name="VALCODE" PropertyName="Text" />
                                    </SelectParameters>
                                </asp:SqlDataSource>
                                <asp:RadioButtonList ID="rblCate" runat="server" RepeatDirection="Horizontal" RepeatLayout="Flow">
                                    <asp:ListItem Value="1">是</asp:ListItem>
                                    <asp:ListItem Value="0">否</asp:ListItem>
                                </asp:RadioButtonList>
                                <asp:TextBox ID="txtCate" runat="server" CssClass="txtBoxLine" Width="90%" TextMode="MultiLine"></asp:TextBox><br />
                                <asp:Label ID="lblCastCate" runat="server" Text='<%# Eval("CATE") %>' Visible="False"></asp:Label><asp:Label
                                    ID="lblCastCode" runat="server" Text='<%# Eval("VALCODE") %>' Visible="False"></asp:Label>
                            </ItemTemplate>
                        </asp:DataList><asp:SqlDataSource ID="sdsQuestionary" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                            SelectCommand="SELECT TRQG.AUTOKEY, TRQG.TRQCODE, TRQG.VALCODE, TRQG.SORT, TRVALGD.VALNAME, TRVALGD.CATE, TRVALGD.KEY_MAN, TRVALGD.KEY_DATE FROM TRQG LEFT OUTER JOIN TRVALGD ON TRQG.VALCODE = TRVALGD.VALCODE WHERE (TRQG.TRQCODE = @TRQCODE) ORDER BY TRQG.SORT">
                            <SelectParameters>
                                <asp:QueryStringParameter Name="TRQCODE" QueryStringField="Code" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></div>
                </div>
                <h4 class="mainfooter">
                    <asp:Label ID="lblFooter" runat="server"></asp:Label></h4>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>