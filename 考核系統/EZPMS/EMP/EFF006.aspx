<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF006.aspx.cs" Inherits="EMP_EFF006" Title="合晶科技績效考核系統（Web版）v1.0" %>

<%@ Register Src="../UC/loading.ascx" TagName="loading" TagPrefix="uc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<script language="javascript" type="text/javascript">
<!--

function FIELDSET1_onclick() {

}

// -->
</script>

    <asp:ScriptManager ID="ScriptManager1" runat="server">
    </asp:ScriptManager>
    <uc1:loading ID="Loading1" runat="server" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<h5>工作目標與行為態度比重查詢</h5>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
    <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
        DataSourceID="AttendDataSource1" OnSelectedIndexChanged="GridView1_SelectedIndexChanged">
        <Columns>
            <asp:TemplateField ShowHeader="False">
                <ItemTemplate>
                    <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                        Text="選取" />
                </ItemTemplate>
            </asp:TemplateField>
            <asp:BoundField DataField="yy" HeaderText="考核年度" SortExpression="yy" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="seq" HeaderText="考核次數" SortExpression="seq" ItemStyle-HorizontalAlign="Center" />
            <asp:BoundField DataField="Desc" HeaderText="說明" SortExpression="Desc" />
            <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                Visible="False" />
            <asp:BoundField DataField="StdDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="開始日期"
                HtmlEncode="False" SortExpression="StdDate" />
            <asp:BoundField DataField="EndDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="結束日期"
                SortExpression="EndDate" HtmlEncode="false" />
            <asp:BoundField DataField="autoKey" HeaderText="autoKey" InsertVisible="False" ReadOnly="True"
                SortExpression="autoKey" Visible="False" />
        </Columns>
    </asp:GridView>
    <asp:Label ID="_effbaseID" runat="server" Text='<%# Bind("nobr") %>' Visible="False"></asp:Label>
    <asp:Label ID="_templetID" runat="server" Visible="False"></asp:Label>
            <asp:Panel ID="Panel1" runat="server" Width="100%" Visible="False">
    <fieldset>
    <legend>考核類別比重</legend>
        <asp:Label ID="Label1" runat="server" Text="工作目標比重：" Font-Size="Small"></asp:Label><asp:Label ID="_catea"
            runat="server" Text="0" Font-Size="Small" ForeColor="Red"></asp:Label><br>
        <asp:Label ID="Label2" runat="server" Text="行為態度比重：" Font-Size="Small"></asp:Label><asp:Label ID="_cateb"
            runat="server" Text="0" Font-Size="Small" ForeColor="Red"></asp:Label>
    </fieldset>
    <fieldset id="FIELDSET1" language="javascript" onclick="return FIELDSET1_onclick()">
        <legend>行為態度比重</legend>
        <asp:SqlDataSource ID="dataViewDs" runat="server" ConnectionString="<%$ ConnectionStrings:syanghrConnectionString %>"
            SelectCommand="SELECT EFFS_CATE.effcateName, EFFS_CATEITEM.effsID, EFFS_CATEITEM.effsName, EFFS_TEMPLETCATEITEM.rate FROM EFFS_TEMPLETCATEITEM INNER JOIN EFFS_CATEITEM ON EFFS_TEMPLETCATEITEM.effsID = EFFS_CATEITEM.effsID INNER JOIN EFFS_CATE ON EFFS_CATEITEM.effcateID = EFFS_CATE.effcateID WHERE (EFFS_TEMPLETCATEITEM.templetID = @TempID) ORDER BY EFFS_TEMPLETCATEITEM.[order]">
            <SelectParameters>
                <asp:ControlParameter ControlID="_templetID" DefaultValue="A001" Name="TempID" PropertyName="Text" />
            </SelectParameters>
        </asp:SqlDataSource>
        <asp:GridView ID="GridView5" runat="server" AutoGenerateColumns="False" DataSourceID="dataViewDs"
            meta:resourceKey="GridView5Resource1" OnDataBound="GridView5_DataBound" OnRowDataBound="GridView5_RowDataBound"
            Width="100%">
            <Columns>
                <asp:BoundField DataField="effsID" meta:resourceKey="BoundFieldResource17" SortExpression="effsID"
                    Visible="False" />
                <asp:BoundField DataField="effcateName" HeaderText="考核項目" SortExpression="effcateName">
                    <ItemStyle Width="15%" />
                </asp:BoundField>
                <asp:BoundField DataField="effsName" HeaderText="考核細目" meta:resourceKey="BoundFieldResource18"
                    SortExpression="effsName">
                    <ItemStyle Width="50%" />
                </asp:BoundField>
                <asp:TemplateField HeaderText="比重" SortExpression="effsNum">
                    <EditItemTemplate>
                        <asp:TextBox ID="TextBox1" runat="server" Text='<%# Bind("rate") %>'></asp:TextBox>
                    </EditItemTemplate>
                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                    <ItemTemplate>
                        &nbsp;<asp:TextBox ID="rate" runat="server" Text='<%# Bind("rate") %>' Width="50px" ForeColor="Red" CssClass="Text_int"></asp:TextBox>
                        <asp:Label ID="lb_effsID" runat="server" Text='<%# Bind("effsID") %>' Visible="False"></asp:Label>
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    <asp:ObjectDataSource ID="AttendDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
        SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter"></asp:ObjectDataSource>
    <asp:Label ID="_yy" runat="server" Visible="False"></asp:Label><asp:Label ID="_seq"
        runat="server" Visible="False"></asp:Label><asp:Label ID="_nobr" runat="server" Visible="False"></asp:Label><asp:Label
            ID="_dept" runat="server" Visible="False"></asp:Label></fieldset>
            </asp:Panel>
            &nbsp; &nbsp;
        </ContentTemplate>
    </asp:UpdatePanel>
    &nbsp; &nbsp; &nbsp; &nbsp;&nbsp;
    <fieldset>
        <legend>說明</legend>
        <asp:Label ID="note" runat="server"></asp:Label>
    </fieldset>
    <br>
</asp:Content>

