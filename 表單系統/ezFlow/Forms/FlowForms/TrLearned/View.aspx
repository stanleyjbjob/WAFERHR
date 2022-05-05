<%@ Page Language="C#" AutoEventWireup="true" CodeFile="View.aspx.cs" Inherits="TrLearned_View" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="AjaxControlToolkit" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>未命名頁面</title>
    <link href="../css/general.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div>
        <asp:ScriptManager ID="sm" runat="server">
        </asp:ScriptManager>
        <asp:UpdateProgress ID="up" runat="server">
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
                                                <img id="IMG1" alt="" height="32" src="../images/loading.gif" width="32" /><strong>請稍後～<br />
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
                <table id="tb" border="0" cellpadding="0" cellspacing="0" width="100%">
                    <tr>
                        <td nowrap="noWrap">
                            搜尋條件：<asp:DropDownList ID="ddlSrhItm" runat="server" AutoPostBack="True" OnSelectedIndexChanged="ddlSrhItm_SelectedIndexChanged"
                                Width="142px">
                                <asp:ListItem Value="ALL">全部</asp:ListItem>
                                <asp:ListItem Value="sNobr">工號</asp:ListItem>
                                <asp:ListItem Value="sApplyNo">課程編號</asp:ListItem>
                                <asp:ListItem Value="sName">姓名</asp:ListItem>
                            </asp:DropDownList><asp:TextBox ID="txtSrhText" runat="server" Enabled="False"></asp:TextBox><asp:Button ID="btnSearch" runat="server" OnClick="btnSearch_Click" Text="搜尋" />&nbsp;
                            <asp:CheckBox ID="cbDateRange" runat="server" AutoPostBack="True" OnCheckedChanged="cbDateRange_CheckedChanged" />日期區間：<asp:TextBox
                                ID="txtDateB" runat="server" CssClass="txtBoxLine" Style="left: 0px" ToolTip="yyyy/MM/dd"
                                Width="95px"></asp:TextBox>
                            <asp:ImageButton ID="ibtnDateB" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />
                            到
                            <asp:TextBox ID="txtDateE" runat="server" CssClass="txtBoxLine" meta:resourcekey="txtNameResource1"
                                Style="left: 0px" ToolTip="yyyy/MM/dd" Width="95px"></asp:TextBox><asp:ImageButton
                                    ID="ibtnDateE" runat="server" CausesValidation="False" ImageUrl="~/images/Calendar_scheduleHS.png" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <asp:Menu ID="mu" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2"
                                Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" Orientation="Horizontal"
                                StaticSubMenuIndent="10px" OnMenuItemClick="mu_MenuItemClick">
                                <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                                <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
                                <DynamicMenuStyle BackColor="#B5C7DE" />
                                <StaticSelectedStyle BackColor="#507CD1" />
                                <DynamicSelectedStyle BackColor="#507CD1" />
                                <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                                <Items>
                                    <asp:MenuItem Selected="True" Text="全部" Value="ALL"></asp:MenuItem>
                                    <asp:MenuItem Text="簽核中" Value="1"></asp:MenuItem>
                                    <asp:MenuItem Text="已駁回" Value="2"></asp:MenuItem>
                                    <asp:MenuItem Text="簽核完成" Value="3"></asp:MenuItem>
                                    <asp:MenuItem Text="已刪除" Value="4"></asp:MenuItem>
                                    <asp:MenuItem Text="服務開始" Value="5"></asp:MenuItem>
                                    <asp:MenuItem Text="服務完成" Value="6"></asp:MenuItem>
                                </Items>
                                <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                            </asp:Menu>
                            <asp:GridView ID="gvS" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                                CellPadding="4" DataKeyNames="idProcess" DataSourceID="sdsS" ForeColor="#333333"
                                GridLines="None"
                                OnRowCommand="gvS_RowCommand" PageSize="20" Width="100%" OnDataBound="gvS_DataBound">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" HorizontalAlign="Center" Wrap="True" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="lbtnServices" runat="server" CausesValidation="False" CommandArgument='<%# Eval("idProcess") %>'
                                                CommandName="Services" OnClientClick="return confirm('您確定要呼叫服務嗎？');" Text="叫用"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("idProcess") %>'
                                                CommandName="Restart" OnClientClick="return confirm('您確定要重送嗎？');" Text="重送"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sProcessID") %>'
                                                CommandName="Del" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                                            <asp:LinkButton ID="LinkButton3" runat="server" CausesValidation="False" CommandArgument='<%# Eval("idProcess") %>'
                                                CommandName="Print" Text="列印"></asp:LinkButton>
                                        </ItemTemplate>
                                        <ItemStyle Width="1%" Wrap="False" />
                                    </asp:TemplateField>
                                    <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                        ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                                    <asp:BoundField DataField="sProcessID" HeaderText="流程序" SortExpression="sProcessID" />
                                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr" />
                                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName" />
                                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName" />
                                    <asp:BoundField DataField="sJobName" HeaderText="職稱" SortExpression="sJobName" />
                                    <asp:BoundField DataField="sCourseName" HeaderText="課程名稱" SortExpression="sCourseName" />
                                    <asp:BoundField DataField="sApplyNo" HeaderText="課程編號" SortExpression="sApplyNo" />
                                    <asp:BoundField DataField="dDateB" HeaderText="起始時間" SortExpression="dDateB" />
                                    <asp:BoundField DataField="dDateE" HeaderText="結束時間" SortExpression="dDateE" />
                                </Columns>
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <EmptyDataTemplate>
                                    查無相關的心得報告資料。
                                </EmptyDataTemplate>
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" HorizontalAlign="Center"
                                    Wrap="True" />
                                <EditRowStyle BackColor="#2461BF" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <asp:SqlDataSource ID="sdsS" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                                SelectCommand="SELECT * FROM [wfTrLearnedAppM]&#13;&#10;where (sState=@sState or @sState='ALL') and ((dDateB between @DateB and @DateE) or (@ChkDate=0))">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="mu" Name="sState" PropertyName="SelectedValue" />
                                    <asp:ControlParameter ControlID="txtDateB" Name="DateB" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="txtDateE" Name="DateE" PropertyName="Text" />
                                    <asp:ControlParameter ControlID="cbDateRange" Name="ChkDate" PropertyName="Checked" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                        </td>
                    </tr>
                </table>
                <AjaxControlToolkit:MaskedEditExtender ID="meeDateB" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999/99/99" MaskType="Date" TargetControlID="txtDateB">
                </AjaxControlToolkit:MaskedEditExtender>
                <AjaxControlToolkit:MaskedEditExtender ID="meeDateE" runat="server" AcceptNegative="Left"
                    DisplayMoney="Left" Mask="9999/99/99" MaskType="Date" TargetControlID="txtDateE">
                </AjaxControlToolkit:MaskedEditExtender>
                <AjaxControlToolkit:CalendarExtender ID="ceDateB" runat="server" Format="yyyy/MM/dd"
                    PopupButtonID="ibtnDateB" TargetControlID="txtDateB">
                </AjaxControlToolkit:CalendarExtender>
                <AjaxControlToolkit:CalendarExtender ID="ceDateE" runat="server" Format="yyyy/MM/dd"
                    PopupButtonID="ibtnDateE" TargetControlID="txtDateE">
                </AjaxControlToolkit:CalendarExtender>
            </ContentTemplate>
        </asp:UpdatePanel>
    
    </div>
    </form>
</body>
</html>
