<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Default4" Title="�X������Z�ĦҮ֨t�Ρ]Web���^v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset id="FIELDSET1" runat="server">
    <legend>���u�Ү֥\��ﶵ</legend>
   
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
                �����Z�İO�n</td>
            <td align="center" style="height: 48px">
                �~���Z�ĦҮ�</td>
            <td align="center" style="height: 48px">
                �D���u�H���ҵ�</td>
            <td align="center" style="height: 48px">
                �u�@�ؼг]�w</td>
            <td align="center" style="height: 48px">
                </td>
            <td align="center" style="width: 94px; height: 48px">
                ���֪̬d��</td>
        </tr>
    </table>
     </fieldset>
     <fieldset id="mang_menu" runat="server">
        <legend>�D�޵��֥\��ﶵ</legend><table width="100%">
            <tr>
                <td align="center">
                <fieldset>
                <legend>���֭��u�\��</legend>
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
                     ���u�����Z�İO�n</td>
                 <td align="center" style="height: 48px">
                     ���u�~���Z�ĦҮ�</td>
                 <td align="center" style="height: 48px">
                     ���u�u�@�ؼ�</td>
             </tr>
         </table>
         </fieldset>
                </td>
                <td align="center">
                <fieldset>
                <legend>���u�Үֳ]�w�ƶ�</legend>
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
                     ���֪̳]�w</td>
                 <td align="center" style="height: 48px">
                     </td>
                 <td align="center" style="height: 48px">
                     </td>
                 <td align="center" style="height: 48px">
                     ���u���~�Үָ�Ƭd��</td>
             </tr>
         </table>
         </fieldset>
                </td>
            </tr>
        </table>
        <fieldset>
        <legend>�Үֳ���</legend>
       
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
                     �Үֳ������֪�</td>
                 <td align="center" style="height: 48px">
                     �Z�ĭ��ͳ���</td>
                 <td align="center" style="height: 48px">
                     �V�m�ݨD����</td>
                 <td align="center" style="height: 48px">
                     �o�i�p�e����</td>
                 <td align="center" style="height: 48px">
                     �Ү֮ʤɳ���</td>
                 <td align="center" style="width: 94px; height: 48px">
                 </td>
             </tr>
         </table>
          </fieldset>
     </fieldset>
   <fieldset>
       <asp:Label ID="app_note" runat="server"></asp:Label></fieldset>
</asp:Content>

