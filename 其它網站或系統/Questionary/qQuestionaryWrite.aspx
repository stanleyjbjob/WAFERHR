<%@ Page Language="C#" MasterPageFile="~/MasterPage_OnlyContent.master" AutoEventWireup="true" CodeFile="qQuestionaryWrite.aspx.cs" Inherits="qQuestionaryWrite" Title="Untitled Page" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    &nbsp;<asp:UpdatePanel ID="upl" runat="server">
        <ContentTemplate>
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td width="100%">
                        <table cellpadding="0" cellspacing="0">
                            <tr>
                                <td>
                                    <asp:Label ID="lblNobr" runat="server" Visible="False"></asp:Label>
                                    <asp:Label ID="lblName" runat="server"></asp:Label>您好！</td>
                            </tr>
                            <tr>
                                <td>
                                    <asp:GridView ID="gv" runat="server" AutoGenerateColumns="False" DataSourceID="sdsBase"
                                        OnRowCommand="gv_RowCommand">
                                        <Columns>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:LinkButton ID="LinkButton1" runat="server" CausesValidation="False" CommandArgument='<%# Bind("sQuestionaryCode") %>'
                                                        CommandName="Write" Text="填寫"></asp:LinkButton>
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="sQuestionaryName" HeaderText="問卷名稱" SortExpression="sQuestionaryName" />
                                            <asp:BoundField DataField="dDateB" DataFormatString="{0:d}" HeaderText="開始填表日(生效)"
                                                HtmlEncode="False" SortExpression="dDateB" />
                                            <asp:BoundField DataField="dDateE" DataFormatString="{0:d}" HeaderText="結束填表日(失效)"
                                                HtmlEncode="False" SortExpression="dDateE" />
                                            <asp:BoundField DataField="dSchoolDate" DataFormatString="{0:d}" HeaderText="上課時間"
                                                HtmlEncode="False" SortExpression="dSchoolDate" />
                                            <asp:BoundField DataField="sCourseName" HeaderText="課程名稱" SortExpression="sCourseName" />
                                            <asp:BoundField DataField="sNatureName" HeaderText="性質" SortExpression="sNatureName" />
                                            <asp:BoundField DataField="sDocentName" HeaderText="講師代碼" SortExpression="sDocentName" />
                                            <asp:BoundField DataField="iTotalFraction" HeaderText="分數" SortExpression="iTotalFraction" />
                                            <asp:BoundField DataField="dWriteDate" DataFormatString="{0:d}" HeaderText="填表日"
                                                HtmlEncode="False" SortExpression="dWriteDate" />
                                        </Columns>
                                    </asp:GridView>
                                    <asp:SqlDataSource ID="sdsBase" runat="server" ConnectionString="<%$ ConnectionStrings:hr %>"
                                        SelectCommand="SELECT qBaseM.sCode AS sBaseCode, qBaseM.sNobr, qBaseM.sPW, qBaseM.sDeptCode, qBaseM.sDeptName, qBaseM.dAmountDate, qBaseM.dWriteDate, qBaseM.dSchoolDate, qBaseM.sYYMM, qBaseM.sSer, qBaseM.sCourseCode, qBaseM.sCourseName, qBaseM.sNatureCode, qBaseM.sNatureName, qBaseM.sDocentCode, qBaseM.sDocentName, qBaseM.iTotalFraction, qBaseM.sTypeCode, qType.sName AS sTypeName, qType.sQuestionaryCode, qType.sQuestionaryName, qType.dDateB, qType.dDateE FROM qBaseM INNER JOIN qType ON qBaseM.sTypeCode = qType.sCode WHERE (qBaseM.sNobr = @sNobr)">
                                        <SelectParameters>
                                            <asp:ControlParameter ControlID="lblNobr" Name="sNobr" PropertyName="Text" />
                                        </SelectParameters>
                                    </asp:SqlDataSource>
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
                <tr>
                    <td width="100%">
                        <asp:Label ID="lblMsg" runat="server" Font-Bold="True" ForeColor="Red"></asp:Label></td>
                </tr>
            </table>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>

