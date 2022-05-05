<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default4" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset id="FIELDSET1" runat="server">
    <legend>員工考核功能選項</legend>
   
    <table width="900">
        <tr>
            <td align="center">
                <asp:ImageButton ID="ImageButton17" runat="server" ImageUrl="~/images/btn_dom_tmpl-add_bg.gif" OnClick="ImageButton17_Click"
                   /></td>
            <td align="center">
                <asp:ImageButton ID="ImageButton26" runat="server" ImageUrl="~/images/btn_edit_bg2.gif" OnClick="ImageButton26_Click"
                   /></td>
            <td align="center">
                <asp:ImageButton ID="ImageButton13" runat="server" ImageUrl="~/images/btn_edit-user_bg.gif" OnClick="ImageButton13_Click"
                    /></td>
            <td align="center">
                    <asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton1_Click"
                   /></td>
            <td align="center">
                    <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/btn_custom-buttons_bg.gif" OnClick="ImageButton2_Click" Visible="False"
                     /></td>
            <td align="center" style="width: 94px">
                    <asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton3_Click"
                     /></td>
        </tr>
        <tr>
            <td align="center" style="height: 48px">
                平日績效記要</td>
            <td align="center" style="height: 48px">
                年度績效考核</td>
            <td align="center" style="height: 48px">
                非直線人員考評</td>
            <td align="center" style="height: 48px">
                工作目標設定</td>
            <td align="center" style="height: 48px">
                </td>
            <td align="center" style="width: 94px; height: 48px">
                評核者查詢</td>
        </tr>
    </table>
     </fieldset>
     <fieldset id="mang_menu" runat="server">
        <legend>主管評核功能選項</legend><table width="100%">
            <tr>
                <td align="center">
                <fieldset>
                <legend>評核員工功能</legend>
         <table width="100%">
             <tr>
                 <td align="center"><asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/btn_domain-templates_bg.gif" OnClick="ImageButton4_Click"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/btn_edit_bg.gif" OnClick="ImageButton5_Click"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/images/btn_domain-user_bg.gif" OnClick="ImageButton6_Click"
                   /></td>
             </tr>
             <tr>
                 <td align="center" style="height: 48px">
                     員工平日績效記要</td>
                 <td align="center" style="height: 48px">
                     員工年度績效考核</td>
                 <td align="center" style="height: 48px">
                     員工工作目標</td>
             </tr>
         </table>
         </fieldset>
                </td>
                <td align="center">
                <fieldset>
                <legend>員工考核設定事項</legend>
         <table width="100%">
             <tr>
                 <td align="center"><asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/images/btn_mail-groups_bg.gif" OnClick="ImageButton7_Click"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/images/btn_custom-buttons_bg.gif" OnClick="ImageButton8_Click" Visible="False"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton9" runat="server" ImageUrl="~/images/btn_custom-buttons_bg.gif" OnClick="ImageButton9_Click" Visible="False"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton10" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton10_Click"
                   /></td>
             </tr>
             <tr>
                 <td align="center" style="height: 48px">
                     評核者設定</td>
                 <td align="center" style="height: 48px">
                     </td>
                 <td align="center" style="height: 48px">
                     </td>
                 <td align="center" style="height: 48px">
                     員工歷年考核資料查詢</td>
             </tr>
         </table>
         </fieldset>
                </td>
            </tr>
        </table>
        <fieldset>
        <legend>考核報表</legend>
       
         <table width="900">
             <tr>
                 <td align="center"><asp:ImageButton ID="ImageButton11" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton11_Click"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton12" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton12_Click"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton14" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton14_Click"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton15" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton15_Click"
                   /></td>
                 <td align="center"><asp:ImageButton ID="ImageButton16" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton16_Click"
                   /></td>
                 <td align="center" style="width: 94px">
                 </td>
             </tr>
             <tr>
                 <td align="center" style="height: 48px">
                     考核部門評核表</td>
                 <td align="center" style="height: 48px">
                     績效面談報表</td>
                 <td align="center" style="height: 48px">
                     訓練需求報表</td>
                 <td align="center" style="height: 48px">
                     發展計畫報表</td>
                 <td align="center" style="height: 48px">
                     考核晉升報表</td>
                 <td align="center" style="width: 94px; height: 48px">
                 </td>
             </tr>
         </table>
          </fieldset>
     </fieldset>
   <fieldset>
       <asp:Label ID="app_note" runat="server"></asp:Label></fieldset>
</asp:Content>

