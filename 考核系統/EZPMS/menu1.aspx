<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true"
    CodeFile="menu1.aspx.cs" Inherits="menu1" Title="績效考核系統（Web版）v1.0" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <fieldset>
        <legend>系統基本設定</legend>
        <table width="100%">
            <tr width="50%">
                <td valign="top">
                    <fieldset>
                       
                        <table width="100%">
                            <tr>
                                <td align="center"><asp:ImageButton ID="ImageButton9" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton9_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton1" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton1_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton2_Click"
                                          /></td>
                                <td align="center">
                                    <asp:ImageButton ID="ImageButton4" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton4_Click"
                                          /></td>
                            </tr>
                            <tr>
                                <td align="center">
                                    考核評估種類資料設定</td>
                                <td align="center">
                                    考核評項目設定
                                </td>
                                <td align="center">
                                    考核評量抬頭設定</td>
                                <td align="center">
                                    考核面談資料設定</td>
                            </tr>
                        </table>
                        <hr>
                        <table width="100%">
                            <tr>
                                <td align="center"><asp:ImageButton ID="ImageButton3" runat="server" ImageUrl="~/images/org.bmp" OnClick="ImageButton3_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton5" runat="server" ImageUrl="~/images/btn_iis-app-pool_bg.gif" OnClick="ImageButton5_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton6" runat="server" ImageUrl="~/images/btn_iis-app-pool_bg.gif" OnClick="ImageButton6_Click"
                                          /></td>
                            </tr>
                            <tr>
                                <td align="center"style="height: 30px">
                                    人事組織設定</td>
                                <td align="center" style="height: 30px">
                                    考核群組及簽核權限設定</td>
                                <td align="center" style="height: 30px">
                                    考核評等資料及強迫分配設定</td>
                            </tr>
                        </table>
                        <table width="100%">
                            <tr>
                                <td align="center">
                                    <asp:ImageButton ID="ImageButton23" runat="server" ImageUrl="~/images/btn_iis-app-pool_bg.gif" OnClick="ImageButton23_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton24" runat="server" ImageUrl="~/images/btn_iis-app-pool_bg.gif" OnClick="ImageButton24_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton25" runat="server" ImageUrl="~/images/btn_iis-app-pool_bg.gif" OnClick="ImageButton25_Click"
                                          /></td>
                            </tr>
                            <tr>
                                <td align="center"style="height: 30px">
                                    管理者設定</td>
                                <td align="center" style="height: 30px">
                                    工作目標時間設定</td>
                                <td align="center" style="height: 30px">
                                    HR監看</td>
                            </tr>
                        </table>
                    </fieldset>
                </td>
                <td valign="top">
                    <fieldset>
                                               <table width="100%">
                            <tr>
                                <td align="center"><asp:ImageButton ID="ImageButton7" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton7_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton8" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton8_Click"
                                          /></td>
                                <td align="center">
                                    </td>
                                <td align="center"><asp:ImageButton ID="ImageButton22" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton22_Click"
                                          /></td>
                                <td align="center"><asp:ImageButton ID="ImageButton21" runat="server" ImageUrl="~/images/btn_file-manager_bg.gif" OnClick="ImageButton21_Click"
                                          /></td>
                                <td align="center" style="width: 92px">
                                    <asp:ImageButton ID="ImageButton18" runat="server" ImageUrl="~/images/btn_tts-tickets-all_bg.gif" OnClick="ImageButton18_Click"
                                          /></td>
                            </tr>
                            <tr>
                                <td align="center" style="width: 92px; height: 30px">
                                    發展計劃設定</td>
                                <td align="center" style="width: 92px; height: 30px">
                                    個人訓練需求資料設定</td>
                                <td align="center" style="width: 92px; height: 30px">
                                </td>
                                <td align="center" style="width: 92px; height: 30px">
                                    工作目上傳</td>
                                <td align="center" style="width: 92px; height: 30px">
                                    個人工作目標維護</td>
                                <td align="center" style="width: 92px; height: 30px">
                                    程式說明設定</td>
                            </tr>
                        </table>
                        <hr>
                        <table width="100%">
                            <tbody>
                                <tr>
                                    <td align="center"><asp:ImageButton ID="ImageButton10" runat="server" ImageUrl="~/images/btn_cs-maps_bg.gif" OnClick="ImageButton10_Click"
                                          /></td>
                                    <td align="center"><asp:ImageButton ID="ImageButton11" runat="server" ImageUrl="~/images/btn_crontab-win_bg1.gif" OnClick="ImageButton11_Click"
                                          /></td>
                                    <td align="center"><asp:ImageButton ID="ImageButton12" runat="server" ImageUrl="~/images/btn_cl_tmpl-add_bg.gif" OnClick="ImageButton12_Click"
                                          /></td>
                                    <td style="width: 92px" align="center">
                                        </td>
                                </tr>
                                <tr>
                                    <td style="height: 30px; color: #ff0033;" align="center">
                                        考核樣板設定</td>
                                    <td style="height: 30px; color: #ff0033;" align="center">
                                        考核時間設定</td>
                                    <td style="height: 30px; color: #ff0033;" align="center">
                                        產生考核資料</td>
                                    <td style="width: 92px; height: 30px" align="center">
                                    </td>
                                </tr>
                            </tbody>
                        </table>
                    </fieldset>
                </td>
            </tr>
        </table>
    </fieldset>
    <fieldset>
        <legend>考核報表</legend>
        <table width="600">
            <tr>
                <td align="center">
                    <asp:ImageButton ID="ImageButton17" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton17_Click"
                       /></td>
                <td align="center">
                    <asp:ImageButton ID="ImageButton26" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton26_Click"
                       /></td>
                <td align="center">
                    <asp:ImageButton ID="ImageButton13" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton13_Click"
                       /></td>
                <td align="center">
                    <asp:ImageButton ID="ImageButton20" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton20_Click"
                       /></td>
                <td align="center"><asp:ImageButton ID="ImageButton27" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton27_Click"
                       /></td>
                <td align="center" style="width: 94px"><asp:ImageButton ID="ImageButton28" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton28_Click"
                       /></td>
            </tr>
            <tr>
                <td align="center" style="height: 48px">
                    考核簽核時間報表</td>
                <td align="center" style="height: 48px">
                    考核部門評核表</td>
                <td align="center" style="height: 48px">
                    績效面談報表</td>
                <td align="center" style="height: 48px">
                    員工工作目標報表</td>
                <td align="center" style="height: 48px">
                    員工確定報表</td>
                <td align="center" style="height: 48px; width: 94px;">
                    考核項目報表</td>
            </tr>
        </table>
        <table width="600">
            <tr>
                <td align="center">
                    &nbsp;<asp:ImageButton ID="ImageButton19" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton19_Click"
                       /></td>
                <td align="center">
                    <asp:ImageButton ID="ImageButton14" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton14_Click"
                       /></td>
                <td align="center">
                    <asp:ImageButton ID="ImageButton15" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton15_Click"
                       /></td>
                <td align="center">
                    <asp:ImageButton ID="ImageButton16" runat="server" ImageUrl="~/images/btn_report_bg.gif" OnClick="ImageButton16_Click"
                       /></td>
                <td align="center">
                </td>
                <td align="center" style="width: 92px">
                </td>
            </tr>
            <tr>
                <td align="center" style="height: 48px">
                    訓練需報表</td>
                <td align="center" style="height: 48px">
                    發展計畫報表查詢</td>
                <td align="center" style="height: 48px">
                    主管總結意見</td>
                <td align="center" style="height: 48px">
                    考核晉升報表</td>
                <td align="center" style="height: 48px">
                </td>
                <td align="center" style="height: 48px">
                </td>
            </tr>
        </table>
    </fieldset>
</asp:Content>
