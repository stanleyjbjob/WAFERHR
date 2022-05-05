<%@ Page Language="C#" AutoEventWireup="true" CodeFile="SignState.aspx.cs" Inherits="Abs_SignState" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>請假單---進行中流程</title>
        <link href="../css/general.css" rel="stylesheet" type="text/css">
</head>
<body bottommargin="0" leftmargin="0" rightmargin="0" topmargin="0">
    <form id="form1" runat="server">
    <div>
        <table border="0" cellpadding="0" cellspacing="0" style="width: 100%">
            <tr>
                <td class="UltraWebGrid1-hc" style="text-align: center">
                    加班進行中流程</td>
            </tr>
            <tr>
                <td>
                    <asp:Menu ID="mu" runat="server" BackColor="#B5C7DE" DynamicHorizontalOffset="2"
                        Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" Orientation="Horizontal"
                        StaticSubMenuIndent="10px">
                        <StaticSelectedStyle BackColor="#507CD1" />
                        <StaticMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                        <DynamicHoverStyle BackColor="#284E98" ForeColor="White" />
                        <DynamicMenuStyle BackColor="#B5C7DE" />
                        <DynamicSelectedStyle BackColor="#507CD1" />
                        <DynamicMenuItemStyle HorizontalPadding="5px" VerticalPadding="2px" />
                        <StaticHoverStyle BackColor="#284E98" ForeColor="White" />
                        <Items>
                            <asp:MenuItem Selected="True" Text="簽核中" Value="1"></asp:MenuItem>
                            <asp:MenuItem Text="已駁回" Value="2"></asp:MenuItem>
                            <asp:MenuItem Text="簽核完成" Value="3"></asp:MenuItem>
                        </Items>
                    </asp:Menu>
                    <asp:Label ID="lblEmpID" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td>
                    <asp:GridView ID="gvSignState" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                        CellPadding="4" DataKeyNames="idProcess" DataSourceID="sdsSignState" ForeColor="#333333"
                        GridLines="None" Width="100%">
                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                        <Columns>
                            <asp:TemplateField HeaderText="簽核者" Visible="False">
                                <ItemTemplate>
                                    <asp:LinkButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select">選取</asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                            <asp:BoundField DataField="sProcessID" HeaderText="sProcessID" SortExpression="sProcessID"
                                Visible="False" />
                            <asp:BoundField DataField="idProcess" HeaderText="流程序" SortExpression="idProcess" />
                            <asp:BoundField DataField="sJob" HeaderText="sJob" SortExpression="sJob" Visible="False" />
                            <asp:BoundField DataField="sJobName" HeaderText="sJobName" SortExpression="sJobName"
                                Visible="False" />
                            <asp:BoundField DataField="sJobl" HeaderText="sJobl" SortExpression="sJobl" Visible="False" />
                            <asp:BoundField DataField="sJoblName" HeaderText="sJoblName" SortExpression="sJoblName"
                                Visible="False" />
                            <asp:BoundField DataField="sEmpcd" HeaderText="sEmpcd" SortExpression="sEmpcd" Visible="False" />
                            <asp:BoundField DataField="sEmpcdName" HeaderText="sEmpcdName" SortExpression="sEmpcdName"
                                Visible="False" />
                            <asp:BoundField DataField="dStrDateTime" HeaderText="dStrDateTime" SortExpression="dStrDateTime"
                                Visible="False" />
                            <asp:BoundField DataField="dEndDateTime" HeaderText="dEndDateTime" SortExpression="dEndDateTime"
                                Visible="False" />
                            <asp:BoundField DataField="dStrDate" DataFormatString="{0:d}" HeaderText="加班日期" HtmlEncode="False"
                                SortExpression="dStrDate" />
                            <asp:BoundField DataField="dEndDate" HeaderText="dEndDate" SortExpression="dEndDate"
                                Visible="False" />
                            <asp:BoundField DataField="sStrTime" HeaderText="時間起" SortExpression="sStrTime" />
                            <asp:BoundField DataField="sEndTime" HeaderText="時間迄" SortExpression="sEndTime" />
                            <asp:BoundField DataField="sOtcatCode" HeaderText="sOtcatCode" SortExpression="sOtcatCode"
                                Visible="False" />
                            <asp:BoundField DataField="sOtcatName" HeaderText="加班/補休" SortExpression="sOtcatName" />
                            <asp:BoundField DataField="iTotalHour" HeaderText="加班時數" SortExpression="iTotalHour" />
                            <asp:BoundField DataField="sOtrcdCode" HeaderText="sOtrcdCode" SortExpression="sOtrcdCode"
                                Visible="False" />
                            <asp:BoundField DataField="sOtrcdName" HeaderText="加班原因" SortExpression="sOtrcdName" />
                            <asp:BoundField DataField="sRoteName" HeaderText="加班班別" SortExpression="sRoteName" />
                            <asp:BoundField DataField="sReserve1" HeaderText="sReserve1" SortExpression="sReserve1"
                                Visible="False" />
                            <asp:BoundField DataField="sReserve2" HeaderText="sReserve2" SortExpression="sReserve2"
                                Visible="False" />
                            <asp:BoundField DataField="sReserve3" HeaderText="sReserve3" SortExpression="sReserve3"
                                Visible="False" />
                            <asp:BoundField DataField="sSalYYMM" HeaderText="sSalYYMM" SortExpression="sSalYYMM"
                                Visible="False" />
                            <asp:CheckBoxField DataField="bSign" HeaderText="bSign" SortExpression="bSign" Visible="False" />
                            <asp:BoundField DataField="sState" HeaderText="sState" SortExpression="sState" Visible="False" />
                            <asp:CheckBoxField DataField="bAuth" HeaderText="bAuth" SortExpression="bAuth" Visible="False" />
                            <asp:BoundField DataField="sNote" HeaderText="備註" SortExpression="sNote" />
                            <asp:BoundField DataField="dKeyDate" HeaderText="申請時間" SortExpression="dKeyDate" />
                        </Columns>
                        <RowStyle BackColor="#EFF3FB" Wrap="True" HorizontalAlign="Center" />
                        <EmptyDataTemplate>
                            目前沒有人加班。
                        </EmptyDataTemplate>
                        <EditRowStyle BackColor="#2461BF" />
                        <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                        <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                        <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" Wrap="True" HorizontalAlign="Center" />
                        <AlternatingRowStyle BackColor="White" />
                    </asp:GridView>
                    <asp:SqlDataSource ID="sdsSignState" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                        SelectCommand="SELECT * FROM wfOtAppS WHERE (sNobr = @sNobr) AND (idProcess <> 0) AND (@sState = 'a' OR sState = @sState)">
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" />
                            <asp:ControlParameter ControlID="mu" Name="sState" PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    被申請人工號：<asp:Label ID="lblNobr" runat="server" Text="000000"></asp:Label><asp:DropDownList
                        ID="ddlName" runat="server" AutoPostBack="True" DataSourceID="sdsName" DataTextField="name"
                        DataValueField="Emp_id" OnDataBound="ddlName_DataBound" OnSelectedIndexChanged="ddlName_SelectedIndexChanged">
                    </asp:DropDownList>,<asp:TextBox ID="txtName" runat="server" AutoPostBack="True"
                        CssClass="txtBoxLine" OnTextChanged="txtName_TextChanged" Width="70px"></asp:TextBox><asp:SqlDataSource
                            ID="sdsName" runat="server" ConnectionString="<%$ ConnectionStrings:flow %>"
                            SelectCommand="SELECT Emp.id AS Emp_id, Emp.name FROM Emp INNER JOIN Role ON Emp.id = Role.Emp_id WHERE (Role.Dept_id IN (SELECT sSubDept FROM SubWork WHERE (sNobr = @Emp_id))) UNION SELECT Role_2.Emp_id, Emp_2.name FROM Role AS Role_2 INNER JOIN Dept ON Role_2.Dept_id = Dept.id INNER JOIN Emp AS Emp_2 ON Role_2.Emp_id = Emp_2.id WHERE (Dept.path LIKE (SELECT Dept_1.path FROM Role AS Role_1 LEFT OUTER JOIN Dept AS Dept_1 ON Role_1.Dept_id = Dept_1.id LEFT OUTER JOIN Emp AS Emp_1 ON Role_1.Emp_id = Emp_1.id WHERE (Emp_1.id = @Emp_id) AND (Role_1.Dept_id NOT IN (SELECT sSubDept FROM SubWork AS SubWork_1 WHERE (sNobr = Role_1.Emp_id)))) + '%') AND (GETDATE() BETWEEN Role_2.dateB AND Role_2.dateE)">
                            <SelectParameters>
                                <asp:ControlParameter ControlID="lblEmpID" Name="Emp_id" PropertyName="Text" />
                            </SelectParameters>
                        </asp:SqlDataSource>
                </td>
            </tr>
        </table>
    
    </div>
    </form>
</body>
</html>
