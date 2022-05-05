<%@ Page Title="" Language="C#" MasterPageFile="~/mpDialog20140102.master" AutoEventWireup="true"
    CodeFile="Upload.aspx.cs" Inherits="MT_Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="plUpload" runat="server" ToolTip="Upload">
        <table style="padding: 30px;" width="100%">
            <tr>
                <td>
                    <table>
                        <tr>
                            <td width="250px">
                                <telerik:RadAsyncUpload ID="fu" runat="server" CssClass="formItem" 
                                    MultipleFileSelection="Automatic" Width="150px"  />
                            </td>
                            <td>
                                <telerik:RadButton ID="btnUpload" runat="server" OnClick="btnUpload_Click" 
                                    Text="上傳">
                                </telerik:RadButton>
                            </td>
                        </tr>
                    </table>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <telerik:RadTextBox ID="txtDescription" runat="server" Visible="False">
                    </telerik:RadTextBox>
                    <asp:Label ID="lblNobrM" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblNobrS" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblKey1" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label>
                     <asp:Label ID="lblStd" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <asp:Label ID="lblFileMsg" runat="server"></asp:Label>
                </td>
            </tr>
            </table>
                </asp:Panel>
             <table style="padding: 30px;" width="100%">
            <tr>
                <td>
                    <telerik:RadGrid ID="gvFiles" runat="server" CellSpacing="0" Culture="zh-TW" GridLines="None"
                        DataSourceID="sdsFiles" OnItemCommand="gvFiles_ItemCommand" OnItemDataBound="gvFiles_ItemDataBound">
                        <MasterTableView AutoGenerateColumns="False" DataKeyNames="iAutoKey" DataSourceID="sdsFiles">
                            <CommandItemSettings ExportToPdfText="Export to PDF" />
                            <RowIndicatorColumn FilterControlAltText="Filter RowIndicator column" Visible="True">
                            </RowIndicatorColumn>
                            <ExpandCollapseColumn FilterControlAltText="Filter ExpandColumn column" Visible="True">
                            </ExpandCollapseColumn>
                            <Columns>
                                <telerik:GridTemplateColumn FilterControlAltText="Filter TemplateColumn column" UniqueName="TemplateColumn">
                                    <ItemTemplate>
                                        <telerik:RadButton ID="btnDownload" runat="server" CommandName="Download" Text="下載"
                                            CommandArgument='<%# Eval("iAutoKey") %>'>
                                        </telerik:RadButton>
                                        <telerik:RadButton ID="btnDelete" runat="server" CommandName="Del" Text="刪除"
                                            CommandArgument='<%# Eval("iAutoKey") %>'>
                                        </telerik:RadButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn DataField="sUpName" FilterControlAltText="Filter sUpName column"
                                    HeaderText="檔名" SortExpression="sUpName" UniqueName="sUpName">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridBoundColumn>

                                <telerik:GridBoundColumn DataField="iSize" DataType="System.Int32" FilterControlAltText="Filter iSize column"
                                    HeaderText="大小" SortExpression="iSize" UniqueName="iSize">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="dKeyDate" DataType="System.DateTime" FilterControlAltText="Filter dKeyDate column"
                                    HeaderText="日期" SortExpression="dKeyDate" UniqueName="dKeyDate">
                                    <HeaderStyle HorizontalAlign="Center" />
                                    <ItemStyle HorizontalAlign="Center" />
                                </telerik:GridBoundColumn>
                            </Columns>
                            <EditFormSettings>
                                <EditColumn FilterControlAltText="Filter EditCommandColumn column">
                                </EditColumn>
                            </EditFormSettings>
                        </MasterTableView>
                        <FilterMenu EnableImageSprites="False">
                        </FilterMenu>
                    </telerik:RadGrid>
                    <asp:SqlDataSource ID="sdsFiles" runat="server" ConnectionString="<%$ ConnectionStrings:Flow %>"
                        DeleteCommand="DELETE FROM [wfFormUploadFile] WHERE [iAutoKey] = @iAutoKey" InsertCommand="INSERT INTO [wfFormUploadFile] ([sFormCode], [sFormName], [sProcessID], [idProcess], [sNobr], [sKey], [sUpName], [sServerName], [sDescription], [sType], [iSize], [dKeyDate]) VALUES (@sFormCode, @sFormName, @sProcessID, @idProcess, @sNobr, @sKey, @sUpName, @sServerName, @sDescription, @sType, @iSize, @dKeyDate)"
                        SelectCommand="SELECT * FROM wfFormUploadFile WHERE (sKey = @sKey)" UpdateCommand="UPDATE [wfFormUploadFile] SET [sFormCode] = @sFormCode, [sFormName] = @sFormName, [sProcessID] = @sProcessID, [idProcess] = @idProcess, [sNobr] = @sNobr, [sKey] = @sKey, [sUpName] = @sUpName, [sServerName] = @sServerName, [sDescription] = @sDescription, [sType] = @sType, [iSize] = @iSize, [dKeyDate] = @dKeyDate WHERE [iAutoKey] = @iAutoKey">
                        <DeleteParameters>
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </DeleteParameters>
                        <InsertParameters>
                            <asp:Parameter Name="sFormCode" Type="String" />
                            <asp:Parameter Name="sFormName" Type="String" />
                            <asp:Parameter Name="sProcessID" Type="String" />
                            <asp:Parameter Name="idProcess" Type="Int32" />
                            <asp:Parameter Name="sNobr" Type="String" />
                            <asp:Parameter Name="sKey" Type="String" />
                            <asp:Parameter Name="sUpName" Type="String" />
                            <asp:Parameter Name="sServerName" Type="String" />
                            <asp:Parameter Name="sDescription" Type="String" />
                            <asp:Parameter Name="sType" Type="String" />
                            <asp:Parameter Name="iSize" Type="Int32" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                        </InsertParameters>
                        <SelectParameters>
                            <asp:ControlParameter ControlID="lblKey1" Name="sKey" PropertyName="Text" Type="String" />
                        </SelectParameters>
                        <UpdateParameters>
                            <asp:Parameter Name="sFormCode" Type="String" />
                            <asp:Parameter Name="sFormName" Type="String" />
                            <asp:Parameter Name="sProcessID" Type="String" />
                            <asp:Parameter Name="idProcess" Type="Int32" />
                            <asp:Parameter Name="sNobr" Type="String" />
                            <asp:Parameter Name="sKey" Type="String" />
                            <asp:Parameter Name="sUpName" Type="String" />
                            <asp:Parameter Name="sServerName" Type="String" />
                            <asp:Parameter Name="sDescription" Type="String" />
                            <asp:Parameter Name="sType" Type="String" />
                            <asp:Parameter Name="iSize" Type="Int32" />
                            <asp:Parameter Name="dKeyDate" Type="DateTime" />
                            <asp:Parameter Name="iAutoKey" Type="Int32" />
                        </UpdateParameters>
                    </asp:SqlDataSource>
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadButton ID="btnClose" runat="server" OnClientClicking="CancelEdit" Text="關閉">
                    </telerik:RadButton>
                </td>
            </tr>
        </table>

</asp:Content>
