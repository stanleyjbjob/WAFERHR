<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Manage.aspx.cs" Inherits="Manage" MasterPageFile="~/MasterPage_WithSubMenu.master" Title="問卷管理" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:MultiView ID="mv" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
            如果您要先測試信件是否發送正確，請填入您的信箱<asp:TextBox ID="txtMail" runat="server"></asp:TextBox><br />
    <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" DataKeyNames="sCode"
        DataSourceID="sdsGV" AllowPaging="True" AllowSorting="True" OnRowDeleting="gv_RowDeleting" OnSelectedIndexChanged="gv_SelectedIndexChanged" Width="100%" OnRowCommand="gv_RowCommand" OnRowDataBound="gv_RowDataBound">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                        CommandName="Select" Text="選取"></asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                        CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                    <asp:LinkButton ID="lbtnSendmail" runat="server" CommandArgument='<%# Eval("sCode") %>'
                        CommandName="Sendmail" OnClientClick="return confirm('您確定要發信通知此問卷所有學員來填寫問卷嗎？');">通知</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" CommandArgument='<%# Eval("sCode") %>'
                        CommandName="Sendmail1" OnClientClick="return confirm('您確定要發信提醒此問卷的學員趕快交卷？');">提醒</asp:LinkButton>
                </ItemTemplate>
                <ItemStyle Width="1%" Wrap="False" />
            </asp:TemplateField>
            <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
            <asp:BoundField DataField="sCode" HeaderText="分類代碼" SortExpression="sCode" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="sName" HeaderText="分類名稱" SortExpression="sName" />
            <asp:BoundField DataField="sQuestionaryCode" HeaderText="問卷代碼" SortExpression="sQuestionaryCode" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="sQuestionaryName" HeaderText="問卷名稱" SortExpression="sQuestionaryName" />
            <asp:BoundField DataField="dDateB" HeaderText="填表生效日" SortExpression="dDateB" DataFormatString="{0:d}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="dDateE" HeaderText="填表失效日" SortExpression="dDateE" DataFormatString="{0:d}" HtmlEncode="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="iTotalFraction" HeaderText="問卷平均分" SortExpression="iTotalFraction" Visible="False" >
                <ItemStyle HorizontalAlign="Center" />
            </asp:BoundField>
            <asp:BoundField DataField="sKeyMan" HeaderText="sKeyMan" SortExpression="sKeyMan" Visible="False" />
            <asp:BoundField DataField="dKeyDate" HeaderText="dKeyDate" SortExpression="dKeyDate" Visible="False" />
        </Columns>
        <EmptyDataTemplate>
            目前沒有任何問卷。
        </EmptyDataTemplate>
    </asp:GridView>
    <asp:SqlDataSource ID="sdsGV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
        SelectCommand="SELECT * FROM [qType]" DeleteCommand="DELETE FROM [qType] WHERE [iAutoKey] = @iAutoKey">
        <DeleteParameters>
            <asp:Parameter Name="iAutoKey" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="View2" runat="server">
            <asp:Button ID="btnBack" runat="server" OnClick="btnBack_Click" Text="回問卷管理" />
            <asp:Button ID="btnExportXLS" runat="server" OnClick="btnExportXLS_Click" Text="匯出" />
            <asp:Label ID="lblCount" runat="server"></asp:Label><br />
            <asp:GridView ID="gvBase" runat="server" AllowPaging="True" AllowSorting="True" AutoGenerateColumns="False"
                DataKeyNames="sCode,sTypeCode,sNobr" DataSourceID="sdsBaseGV" OnRowDeleting="gvBase_RowDeleting" PageSize="30" Width="100%" OnRowCommand="gvBase_RowCommand" OnRowDataBound="gv_RowDataBound">
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                CommandName="Select" Text="問卷"></asp:LinkButton>
                            <asp:LinkButton ID="LinkButton2" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                CommandName="Delete" OnClientClick="return confirm('您確定要刪除嗎？');" Text="刪除"></asp:LinkButton>
                            <asp:LinkButton ID="lbtnSendmail" runat="server" CausesValidation="False" CommandArgument='<%# Eval("sCode") %>'
                                CommandName="Sendmail" OnClientClick="return confirm('您確定要通知嗎？');" Text="通知"></asp:LinkButton>
                        </ItemTemplate>
                        <ItemStyle Width="1%" Wrap="False" />
                    </asp:TemplateField>
                    <asp:BoundField DataField="iAutoKey" HeaderText="iAutoKey" InsertVisible="False"
                        ReadOnly="True" SortExpression="iAutoKey" Visible="False" />
                    <asp:BoundField DataField="sCode" HeaderText="sCode" SortExpression="sCode" Visible="False" />
                    <asp:BoundField DataField="sTypeCode" HeaderText="sTypeCode" SortExpression="sTypeCode"
                        Visible="False" />
                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sDeptCode" HeaderText="sDeptCode" SortExpression="sDeptCode"
                        Visible="False" />
                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dAmountDate" HeaderText="dAmountDate" SortExpression="dAmountDate"
                        Visible="False" />
                    <asp:BoundField DataField="dWriteDate" DataFormatString="{0:d}" HeaderText="填表日"
                        HtmlEncode="False" SortExpression="dWriteDate">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dSchoolDateB" HeaderText="上課開始時間" SortExpression="dSchoolDateB" />
                    <asp:BoundField DataField="dSchoolDateE" HeaderText="上課結束時間" SortExpression="dSchoolDateE" />
                    <asp:BoundField DataField="sYYMM" HeaderText="開課年月" SortExpression="sYYMM">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sSer" HeaderText="期別" SortExpression="sSer">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sCourseCode" HeaderText="課程代碼" SortExpression="sCourseCode">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sCourseName" HeaderText="課程名稱" SortExpression="sCourseName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sNatureCode" HeaderText="sNatureCode" SortExpression="sNatureCode"
                        Visible="False" />
                    <asp:BoundField DataField="sNatureName" HeaderText="sNatureName" SortExpression="sNatureName"
                        Visible="False" />
                    <asp:BoundField DataField="sDocentCode" HeaderText="sDocentCode" SortExpression="sDocentCode"
                        Visible="False" />
                    <asp:BoundField DataField="sDocentName" HeaderText="講師姓名" SortExpression="sDocentName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="iTotalFraction" HeaderText="平均分數" SortExpression="iTotalFraction">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                </Columns>
                <EmptyDataTemplate>
                    沒有任何資料。
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsBaseGV" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                DeleteCommand="DELETE FROM [qBaseM] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT * FROM [qBaseM] WHERE ([sTypeCode] = @sTypeCode)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gv" Name="sTypeCode" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="iAutoKey" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource><asp:GridView ID="gvExcel" runat="server" AutoGenerateColumns="False"
                DataKeyNames="sCode,sTypeCode,sNobr" DataSourceID="sdsExcel" OnRowDeleting="gvBase_RowDeleting" Width="100%" OnRowCommand="gvBase_RowCommand" OnRowDataBound="gv_RowDataBound" Visible="False">
                <Columns>
                    <asp:BoundField DataField="sNobr" HeaderText="工號" SortExpression="sNobr">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sName" HeaderText="姓名" SortExpression="sName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sDeptName" HeaderText="部門名稱" SortExpression="sDeptName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dWriteDate" DataFormatString="{0:d}" HeaderText="填表日"
                        HtmlEncode="False" SortExpression="dWriteDate">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="dSchoolDateB" HeaderText="上課開始時間" SortExpression="dSchoolDateB" />
                    <asp:BoundField DataField="dSchoolDateE" HeaderText="上課結束時間" SortExpression="dSchoolDateE" />
                    <asp:BoundField DataField="sYYMM" HeaderText="開課年月" SortExpression="sYYMM">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sSer" HeaderText="期別" SortExpression="sSer">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sCourseCode" HeaderText="課程代碼" SortExpression="sCourseCode">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sCourseName" HeaderText="課程名稱" SortExpression="sCourseName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="sDocentName" HeaderText="講師姓名" SortExpression="sDocentName">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="iTotalFraction" HeaderText="平均分數" SortExpression="iTotalFraction">
                        <ItemStyle HorizontalAlign="Center" />
                    </asp:BoundField>
                    <asp:BoundField DataField="ASKDESCRC" HeaderText="題目" SortExpression="ASKDESCRC" />
                    <asp:BoundField DataField="iFraction" HeaderText="分數" SortExpression="iFraction" />
                    <asp:BoundField DataField="sFraction" HeaderText="內容" SortExpression="sFraction" />
                </Columns>
                <EmptyDataTemplate>
                    沒有任何資料。
                </EmptyDataTemplate>
            </asp:GridView>
            <asp:SqlDataSource ID="sdsExcel" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                DeleteCommand="DELETE FROM [qBaseM] WHERE [iAutoKey] = @iAutoKey" SelectCommand="SELECT qBaseM.iAutoKey, qBaseM.sCode, qBaseM.sTypeCode, qBaseM.sNobr, qBaseM.sPW, qBaseM.sName, qBaseM.sDeptCode, qBaseM.sDeptName, qBaseM.dAmountDate, qBaseM.dWriteDate, qBaseM.dSchoolDateB, qBaseM.dSchoolDateE, qBaseM.sYYMM, qBaseM.sSer, qBaseM.sCourseCode, qBaseM.sCourseName, qBaseM.sNatureCode, qBaseM.sNatureName, qBaseM.sDocentCode, qBaseM.sDocentName, qBaseM.iTotalFraction, TRASKCD.ASKDESCRC, qBaseS.iFraction, qBaseS.sFraction FROM TRASKCD RIGHT OUTER JOIN qBaseS ON TRASKCD.ASKCODE = qBaseS.sThemeCode RIGHT OUTER JOIN qBaseM ON qBaseS.sBaseCode = qBaseM.sCode WHERE (qBaseM.sTypeCode = @sTypeCode)">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gv" Name="sTypeCode" PropertyName="SelectedValue"
                        Type="String" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="iAutoKey" Type="Int32" />
                </DeleteParameters>
            </asp:SqlDataSource>
        </asp:View>
    </asp:MultiView>
    <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label>
</asp:Content>
