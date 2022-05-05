<%@ Page Title="" Language="C#" MasterPageFile="~/mpMT20140325.master" ValidateRequest="false"
    AutoEventWireup="true" CodeFile="EditMail.aspx.cs" Inherits="MT_EditMail" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:Panel ID="plEditMail" runat="server" ToolTip="EditMail">
        <table width="100%">
            <tr>
                <td align="center">
                    主旨
                </td>
            </tr>
            <tr>
                <td>
                    <telerik:RadEditor runat="server" ID="txtSubject" SkinID="BasicSetOfTools" ContentAreaMode="Div"
                        OnClientCommandExecuting="OnClientCommandExecuting" Width="100%" Height="80px"
                        ContentFilters="MakeUrlsAbsolute,FixEnclosingP" EditModes="Design" NewLineBr="true">
                        <Tools>
                            <telerik:EditorToolGroup>
                                <telerik:EditorTool Name="Cut"></telerik:EditorTool>
                                <telerik:EditorTool Name="Copy"></telerik:EditorTool>
                                <telerik:EditorTool Name="Paste"></telerik:EditorTool>
                                <telerik:EditorTool Name="Undo"></telerik:EditorTool>
                                <telerik:EditorTool Name="Redo"></telerik:EditorTool>
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content>
                        </Content>
                    </telerik:RadEditor>
                </td>
            </tr>
            <tr>
                <td align="center" style="text-align: left">
                    ※主旨內容請不要斷行</td>
            </tr>
            <tr>
                <td align="center">
                    內文 
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <telerik:RadEditor runat="server" ID="txtBody" SkinID="BasicSetOfTools" OnClientCommandExecuting="OnClientCommandExecuting"
                        Width="100%" Height="250px" ContentAreaMode="Div" ContentFilters="MakeUrlsAbsolute,FixEnclosingP">
                        <Tools>
                            <telerik:EditorToolGroup>
                                <telerik:EditorTool Name="Cut"></telerik:EditorTool>
                                <telerik:EditorTool Name="Copy"></telerik:EditorTool>
                                <telerik:EditorTool Name="Paste"></telerik:EditorTool>
                                <telerik:EditorTool Name="Undo"></telerik:EditorTool>
                                <telerik:EditorTool Name="Redo"></telerik:EditorTool>
                            </telerik:EditorToolGroup>
                            <telerik:EditorToolGroup>
                                <telerik:EditorTool Name="Bold" />
                                <telerik:EditorTool Name="Italic" />
                                <telerik:EditorTool Name="Underline" />
                                <telerik:EditorTool Name="BackColor" />
                                <telerik:EditorTool Name="ForeColor" />
                                <telerik:EditorTool Name="FontSize" />
                                <telerik:EditorTool Name="FontName" />
                                <telerik:EditorTool Name="InsertTable" />
                            </telerik:EditorToolGroup>
                        </Tools>
                        <Content>
                        
                        </Content>
                    </telerik:RadEditor>
                    <script type="text/javascript">
            //<![CDATA[
                        function OnClientCommandExecuting(editor, args) {
                            var name = args.get_name(); //The command name
                            var val = args.get_value(); //The tool that initiated the command
                            if (name == "Emoticons" || name == "Emoticons2") {
                                //Set the background image to the head of the tool depending on the selected toolstrip item
                                var tool = args.get_tool();
                                var span = tool.get_element().getElementsByTagName("SPAN")[0];
                                span.style.backgroundImage = "url(" + val + ")";
                                //Paste the selected in the dropdown emoticon    
                                editor.pasteHtml("<img src='" + val + "'>");
                                //Cancel the further execution of the command
                                args.set_cancel(true);
                            }

                            var elem = editor.getSelectedElement(); //Get a reference to the selected element                
                            if (elem && (name == "OrderedListType" || name == "UnorderedListType")) {
                                if (elem.tagName != "OL" && elem.tagName != "UL") {
                                    while (elem != null) {
                                        if (elem && elem.tagName == "OL" || elem.tagName == "UL") break;
                                        elem = elem.parentNode;
                                    }

                                    if (elem) elem.style.listStyleType = val; //apply the selected item shape
                                    else alert("No ordered list selected! Please select a list to modify");
                                }
                                args.set_cancel(true);
                            }

                            if (name == "DynamicDropdown" || name == "DynamicSplitButton") {
                                editor.pasteHtml("<div style='width:100px;background-color:#fafafa;border:1px dashed #aaaaaa;'>" + val + "</div>");
                                //Cancel the further execution of the command
                                args.set_cancel(true);
                            }

                            if (name == "Columns") {
                                editor.pasteHtml("<span style='display:inline-block;'>{" + val + "}</span>");
                                //Cancel the further execution of the command
                                args.set_cancel(true);
                            }
                        }
            //]]>
                    </script>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <telerik:RadButton ID="btnSave" runat="server" OnClick="btnSave_Click" Text="儲存">
                    </telerik:RadButton>
                    <telerik:RadButton ID="btnClose" runat="server" OnClientClicking="CancelEdit" Text="close">
                    </telerik:RadButton>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <asp:Label ID="lblNobrM" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblNobrS" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblFormCode" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblKey1" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblKey2" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblProcessID" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblStd" runat="server" Visible="False"></asp:Label>
                    <asp:Label ID="lblBody" runat="server" Visible="False"></asp:Label>
                </td>
            </tr>
            <tr>
                <td style="text-align: left">
                    <asp:Label ID="lblFileMsg" runat="server"></asp:Label>
                </td>
            </tr>
        </table>
    </asp:Panel>
    <table width="100%">
        <tr>
            <td>
                &nbsp;
            </td>
        </tr>
    </table>
</asp:Content>
