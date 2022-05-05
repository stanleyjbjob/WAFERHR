<%@ Page Language="C#" AutoEventWireup="true" CodeFile="CosDataEdit.aspx.cs" Inherits="TrainIn_CosDataEdit"  validateRequest="false"%>
<%@ Register Assembly="FredCK.FCKeditorV2" Namespace="FredCK.FCKeditorV2" TagPrefix="FCKeditorV2" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>內訓課程資料</title>
     <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
            <asp:View ID="View0" runat="server">
                <table cellpadding="0" cellspacing="0" class="WebPanel2ctl">
                    <tr>
                        <td class="UltraWebGrid1-hc">
                            課程大綱</td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-ic">
                            <asp:Label ID="lblCOSINTRO" runat="server"></asp:Label><br />
                            <asp:Button ID="btnEdit1" runat="server" CommandName="COSINTRO" CssClass="UltraWebGrid1-hc"
                                OnCommand="btnEdit_Command" Text="編輯" /></td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-hc">
                            訓練對象</td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-ic">
                            <asp:Label ID="lblTR_PERSON" runat="server"></asp:Label><br />
                            <asp:Button ID="btnEdit3" runat="server" CommandName="TR_PERSON" CssClass="UltraWebGrid1-hc"
                                OnCommand="btnEdit_Command" Text="編輯" /></td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-hc">
                            備註說明</td>
                    </tr>
                    <tr>
                        <td class="UltraWebGrid1-ic">
                            <asp:Label ID="lblMENO" runat="server"></asp:Label><br />
                            <asp:Button ID="btnEdit4" runat="server" CommandName="MENO" CssClass="UltraWebGrid1-hc"
                                OnCommand="btnEdit_Command" Text="編輯" /></td>
                    </tr>
                </table>
            </asp:View>
            <asp:View ID="View1" runat="server">
                <fckeditorv2:fckeditor id="txt" runat="server" basepath="../FCKeditor/" height="500px"
                    toolbarset="Ming" value='<%# Bind("sStdNote") %>' width="100%">&nbsp;</fckeditorv2:fckeditor>
                <asp:Button ID="btnUpdate" runat="server" CssClass="UltraWebGrid1-hc" OnClientClick="return confirm('您確定要修改嗎？');"
                    OnCommand="btnUpdate_Command" Text="儲存" />
                <asp:Button ID="btnCancel" runat="server" CssClass="UltraWebGrid1-hc" OnClick="btnCancel_Click"
                    Text="不儲存" /></asp:View>
        </asp:MultiView></div>
        <asp:Label ID="lblMsg" runat="server" ForeColor="Red"></asp:Label>
    </form>
</body>
</html>
