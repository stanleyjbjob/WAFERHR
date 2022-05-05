<%@ Page Language="C#" MasterPageFile="~/MasterPageTemplet.master" AutoEventWireup="true" CodeFile="EFFS015.aspx.cs" Inherits="HR_EFFS015" Title="Untitled Page" ValidateRequest="false" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <fieldset>
        <legend>工作目樣匯入程式</legend>
        <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="0" BackColor="#EFF3FB" BorderColor="#B5C7DE"
            BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" OnFinishButtonClick="Wizard1_FinishButtonClick"
            Width="100%">
            <StepStyle Font-Size="0.8em" ForeColor="#333333" />
            <WizardSteps>
                <asp:WizardStep ID="WizardStep1" runat="server" Title="1.上傳Excel">
                    <asp:FileUpload ID="txtUpload" runat="server" />
                    <asp:Button ID="RolloverButton2" runat="server" OnClick="RolloverButton2_Click" Text="上傳" />
                    <asp:Button ID="Button2" runat="server" OnClick="Button2_Click" OnClientClick="return confirm('確認?')"
                        Text="初始化工作目標MangCheckOK" />
                    <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" OnClientClick="return confirm('確認?')"
                        Text="初始化工作目標MangCheckNotOK" />
                    <br />
                    <asp:Label ID="Label1" runat="server" ForeColor="Red" Text="※如果上傳Excel有錯誤，請先把Excel開啟，執行另存新檔，在把新的Excel上傳！"></asp:Label>
                    &nbsp;<br />
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep2" runat="server" Title="2.設定匯入Excel欄位">
                    <table>
                        <tr>
                            <td>
                                <table>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label6" runat="server">年度：</asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DDL1" runat="server">
                                            </asp:DropDownList>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:Label ID="Label2" runat="server">期別：</asp:Label>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="DDL2" runat="server">
                                            </asp:DropDownList>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            <asp:Label ID="Label3" runat="server">員工工號：</asp:Label>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:DropDownList ID="DDL3" runat="server">
                                            </asp:DropDownList>
                                            &nbsp;
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            <asp:Label ID="Label7" runat="server">工作目標類型</asp:Label>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:DropDownList ID="DDL5" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            <asp:Label ID="Label13" runat="server">工作目標</asp:Label>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:DropDownList ID="DDL6" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            <asp:Label ID="Label14" runat="server">比重：</asp:Label>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:DropDownList ID="DDL7" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            <asp:Label ID="Label15" runat="server">執行之質與量的綜合成果</asp:Label>
                                        </td>
                                        <td style="height: 9px">
                                            <asp:DropDownList ID="DDL8" runat="server">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                    </tr>
                                    <tr>
                                        <td style="height: 9px">
                                            &nbsp;</td>
                                        <td style="height: 9px">
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal">
                                    <DynamicHoverStyle CssClass="menuPopupItem" />
                                    <DynamicMenuItemStyle CssClass="menuPopupItem" Font-Strikeout="False" />
                                    <DynamicMenuStyle CssClass="menuPopup" />
                                    <StaticHoverStyle CssClass="menuItemHover" />
                                    <StaticMenuItemStyle CssClass="menuItem" />
                                    <StaticMenuStyle CssClass="menu" />
                                    <StaticSelectedStyle CssClass="menuSelectedItem" />
                                </asp:Menu>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:GridView ID="GridView1" runat="server" AllowPaging="True" CellPadding="4" ForeColor="#333333"
                                    GridLines="None" PageSize="20">
                                    <AlternatingRowStyle BackColor="White" />
                                    <EditRowStyle BackColor="#2461BF" />
                                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                    <RowStyle BackColor="#EFF3FB" />
                                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                </asp:GridView>
                            </td>
                        </tr>
                    </table>
                </asp:WizardStep>
                <asp:WizardStep ID="WizardStep3" runat="server" Title="3.匯入">
                    <table width="100%">
                        <tr>
                            <td>
                                <asp:Button ID="ExportButton" runat="server" OnClick="ExportButton_Click" OnClientClick="return confirm('確認匯入否?')"
                                    Text="開始匯入" />
                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" OnClientClick="return confirm('確認刪除?')"
                                    Text="刪除" />
                                <br />
                                <asp:Label ID="Label33" runat="server" ForeColor="Red" Text="※匯入前請先確認'設定匯入欄位'是否點選正確！"></asp:Label>
                            </td>
                        </tr>
                        <tr>
                            <td>
                                <asp:TextBox ID="TextBox1" runat="server" ReadOnly="True" Rows="30" TextMode="MultiLine"
                                    Width="100%"></asp:TextBox>
                            </td>
                        </tr>
                        <tr>
                            <td>
                            </td>
                        </tr>
                    </table>
                </asp:WizardStep>
            </WizardSteps>
            <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
            <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
            <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" />
            <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
                Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
        </asp:Wizard>
        <asp:Label ID="showMsg" runat="server"></asp:Label></fieldset>
</asp:Content>

