<%@ Page Language="C#" MasterPageFile="~/JBRF_MasterPage.master" AutoEventWireup="true"
    CodeFile="Default2.aspx.cs" Inherits="Default2" Title="合晶科技績效考核系統（Web版）v1.0" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
<div id="breadcrumbfull">
    <div id="breadcrumb">
        <asp:ScriptManager ID="ScriptManager1" runat="server">
        </asp:ScriptManager>
    </div>
    <div id="projectadministration">
        <fieldset>
            <h2 class="none">
                Time Sheet for:</h2>
            <legend>Time Sheet For:</legend>
            <center>
                <asp:TextBox ID="TextBox2" runat="server"></asp:TextBox>&nbsp; You do not have any
                projects assigned to you.</center>
            <center>
                <asp:Label ID="Label2" runat="server" Font-Size="X-Large" ForeColor="Red" Text="0"></asp:Label></center>
        </fieldset>
        Calendar Demonstration<br />
        <b>Default calendar: 
    
        </b>
        <br />
        <asp:TextBox ID="Date1" runat="server" autocomplete="off"></asp:TextBox><br />
        <ajaxToolkit:CalendarExtender ID="defaultCalendarExtender" runat="server" TargetControlID="Date1">
        </ajaxToolkit:CalendarExtender>
        <div style="font-size: 90%">
            <em>(Set the focus to the textbox to show the calendar)</em></div>
        <br />
        <br />
        <b>Calendar with a custom style and formatted date:</b><br />
        <asp:TextBox ID="Date2" runat="server" autocomplete="off"></asp:TextBox><br />
        <ajaxToolkit:CalendarExtender ID="customCalendarExtender" runat="server" CssClass="MyCalendar"
            Format="MMMM d, yyyy" TargetControlID="Date2">
        </ajaxToolkit:CalendarExtender>
        <div style="font-size: 90%">
            <em>(Set the focus to the textbox to show the calendar)</em></div>
        <br />
        <br />
        <b>Calendar with an associated button:</b><br />
        <asp:TextBox ID="Date5" runat="server"></asp:TextBox>
        <asp:ImageButton ID="Image1" runat="Server" AlternateText="Click to show calendar"
            ImageUrl="~/images/Calendar_scheduleHS.png" OnClick="Image1_Click" /><br />
        <ajaxToolkit:CalendarExtender ID="calendarButtonExtender" runat="server" PopupButtonID="Image1"
            TargetControlID="Date5">
        </ajaxToolkit:CalendarExtender>
    </div>
    <asp:Menu ID="Menu1" runat="server" Orientation="Horizontal">
        <Items>
            <asp:MenuItem Text="新增項目" Value="新增項目">
                <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
                <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
                <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
            </asp:MenuItem>
            <asp:MenuItem Text="新增項目" Value="新增項目">
                <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
                <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
            </asp:MenuItem>
            <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
            <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
            <asp:MenuItem Text="新增項目" Value="新增項目">
                <asp:MenuItem Text="新增項目" Value="新增項目">
                    <asp:MenuItem Text="新增項目" Value="新增項目">
                        <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
                    </asp:MenuItem>
                </asp:MenuItem>
            </asp:MenuItem>
            <asp:MenuItem Text="新增項目" Value="新增項目"></asp:MenuItem>
        </Items>
    </asp:Menu>
    <asp:Button ID="Button1" runat="server" Text="Button" />
    <asp:TextBox ID="TextBox1" runat="server"></asp:TextBox>
    <asp:LinkButton ID="LinkButton1" runat="server">LinkButton</asp:LinkButton>
    <asp:Label ID="Label1" runat="server" Text="Label"></asp:Label>
</div>
</asp:Content>
