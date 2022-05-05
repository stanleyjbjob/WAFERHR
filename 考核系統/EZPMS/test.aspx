<%@ Page Language="C#" AutoEventWireup="true" CodeFile="test.aspx.cs" Inherits="test" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>GridView折疊發開-Demo</title>

    <script type="text/javascript">
        function toggleDetailsZone(sender)
        {
        //debugger;
            var currRow = sender.parentNode.parentNode; 
            var nextRow = currRow.nextSibling;
            if(nextRow.style.display == "none") 
            {
                nextRow.style.display = "";
                sender.innerHTML = "-";
                sender.title = "折叠";
            } 
            else 
            {
                nextRow.style.display = "none";
                sender.innerHTML = "+";
                sender.title = "展开";
            } 
        }
    </script>

</head>
<body>
    <form id="form1" runat="server">
        <div>
            <input type="button" id="Button1" value="Rebind" onclick="location.href=location.href;" />
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false" OnRowDataBound="GridView1_RowDataBound">
                <Columns>
                    <asp:BoundField DataField="ProductID" HeaderText="ProductID" />
                    <asp:TemplateField HeaderText="ProductName">
                        <ItemTemplate>
                            <%# Eval("ProductName") %>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="UnitPrice" HeaderText="UnitPrice" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <span title="展开" style="cursor: pointer; font-weight: bold" onclick="toggleDetailsZone(this)">
                                +</span></ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>
            <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False" DataKeyNames="AutoKey"
                DataSourceID="ObjectDataSource1" PageSize="5">
                <Columns>
                    <asp:BoundField DataField="AutoKey" HeaderText="AutoKey" InsertVisible="False" ReadOnly="True"
                        SortExpression="AutoKey" Visible="False" />
                    <asp:BoundField DataField="adate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="日期"
                        HtmlEncode="False" SortExpression="adate" />
                    <asp:BoundField DataField="nobr" HeaderText="nobr" SortExpression="nobr" Visible="False" />
                    <asp:TemplateField HeaderText="關連項目" SortExpression="effscate">
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownListcate" runat="server" DataSourceID="ObjectDataSource3"
                                DataTextField="effcateName" DataValueField="effcateID" Enabled="False" SelectedValue='<%# Bind("effscate") %>'>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="類別" SortExpression="type">
                        <ItemTemplate>
                            <asp:DropDownList ID="DropDownListtype" runat="server" Enabled="False" SelectedValue='<%# Bind("type") %>'>
                                <asp:ListItem Selected="True" Value="A001">優良事蹟</asp:ListItem>
                                <asp:ListItem Value="B001">待改進事項</asp:ListItem>
                            </asp:DropDownList>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="record" HeaderText="記要" SortExpression="record">
                        <ItemStyle Width="200px" />
                    </asp:BoundField>
                    <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                        Visible="False" />
                </Columns>
            </asp:GridView>
            <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByNobr"
                TypeName="EFFDSTableAdapters.EFFS_RECORDTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="nobr" Type="String" />
                    <asp:Parameter Name="type" Type="String" />
                    <asp:Parameter Name="record" Type="String" />
                    <asp:Parameter Name="adate" Type="DateTime" />
                    <asp:Parameter Name="keydate" Type="DateTime" />
                    <asp:Parameter Name="effscate" Type="String" />
                    <asp:Parameter Name="Original_AutoKey" Type="Int32" />
                </UpdateParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="lb_nobr" Name="nobr" PropertyName="Text" Type="String" />
                </SelectParameters>
                <InsertParameters>
                    <asp:Parameter Name="nobr" Type="String" />
                    <asp:Parameter Name="type" Type="String" />
                    <asp:Parameter Name="record" Type="String" />
                    <asp:Parameter Name="adate" Type="DateTime" />
                    <asp:Parameter Name="keydate" Type="DateTime" />
                    <asp:Parameter Name="effscate" Type="String" />
                </InsertParameters>
            </asp:ObjectDataSource>
        </div>
    </form>
</body>
</html>
