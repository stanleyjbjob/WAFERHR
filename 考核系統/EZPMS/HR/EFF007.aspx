<%@ Page Language="C#" MasterPageFile="~/JBR_MasterPage.master" AutoEventWireup="true" CodeFile="EFF007.aspx.cs" Inherits="HR_EFF007" Title="合晶科技績效考核系統（Web版）v1.0" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" Runat="Server">
<asp:Menu ID="Menu1" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu1_MenuItemClick">
        <Items>
            <asp:MenuItem Text="產生考核資料" Value="0" Selected="true"></asp:MenuItem>
            <asp:MenuItem Text="考核名單維護" Value="1"></asp:MenuItem>
        </Items>
    </asp:Menu>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

<asp:MultiView id="MultiView1" runat="server" ActiveViewIndex="0">
        <asp:View ID="View1" runat="server">
        <h5>產生考核資料</h5>
            <fieldset>
                <legend>設定考核時間及樣板</legend>
                <table width="100%">
                    <tr>
                        <td colspan="3" style="height: 118px" valign="top">
                            <asp:Wizard ID="Wizard1" runat="server" ActiveStepIndex="0" BackColor="#EFF3FB" BorderColor="#B5C7DE"
                                BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" OnNextButtonClick="Wizard1_NextButtonClick"
                                OnSideBarButtonClick="Wizard1_SideBarButtonClick" Width="100%" OnFinishButtonClick="Wizard1_FinishButtonClick">
                                <StepStyle Font-Size="0.8em" ForeColor="#333333" />
                                <SideBarStyle BackColor="#507CD1" Font-Size="0.9em" VerticalAlign="Top" Width="150px" />
                                <NavigationButtonStyle BackColor="White" BorderColor="#507CD1" BorderStyle="Solid"
                                    BorderWidth="1px" Font-Names="Verdana" Font-Size="0.8em" ForeColor="#284E98" />
                                <WizardSteps>
                                    <asp:WizardStep runat="server" Title="1.考核時間設定">
                                        <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False" DataKeyNames="autoKey"
                                            DataSourceID="Effs_AttendDataSource" Width="100%">
                                            <Columns>
                                                <asp:TemplateField ShowHeader="False">
                                                    <ItemTemplate>
                                                        <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                                            Text="選取" />
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                                <asp:BoundField DataField="yy" HeaderText="考核年度" ReadOnly="True" SortExpression="yy" />
                                                <asp:BoundField DataField="seq" HeaderText="考核次數" ReadOnly="True" SortExpression="seq" />
                                                <asp:BoundField DataField="Desc" HeaderText="說明" SortExpression="Desc" />
                                                <asp:BoundField DataField="keydate" HeaderText="keydate" SortExpression="keydate"
                                                    Visible="False" />
                                                <asp:BoundField DataField="StdDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="開始時間"
                                                    HtmlEncode="False" SortExpression="StdDate" />
                                                <asp:BoundField DataField="EndDate" DataFormatString="{0:yyyy/MM/dd}" HeaderText="結束時間"
                                                    HtmlEncode="False" SortExpression="EndDate" />
                                            </Columns>
                                        </asp:GridView>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" Title="2.考核樣板">
                            <fieldset>
                                <asp:Label ID="Label5" runat="server" Text="樣版名稱："></asp:Label><br />
                                <asp:DropDownList ID="ddlTmp" runat="server" DataSourceID="TempletDataSource" DataTextField="templetName"
                                    DataValueField="templetID">
                                </asp:DropDownList><asp:ObjectDataSource ID="TempletDataSource" runat="server" OldValuesParameterFormatString="original_{0}"
                                    SelectMethod="GetData" TypeName="EFFDSTableAdapters.EFFS_TEMPLETTableAdapter"></asp:ObjectDataSource>
                            </fieldset>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" Title="3.設定產生名單條件">
                                        <asp:Menu ID="Menu2" runat="server" Orientation="Horizontal" OnMenuItemClick="Menu2_MenuItemClick">
                                            <Items>
                                                <asp:MenuItem Selected="True" Text="批次產生考核名單" Value="0"></asp:MenuItem>
                                                <asp:MenuItem Text="單筆產生考核名單" Value="1"></asp:MenuItem>
                                            </Items>
                                        </asp:Menu>
                                        <asp:MultiView ID="MultiView2" runat="server" ActiveViewIndex="0">
                                            <asp:View ID="View3" runat="server">
                                            
                                                <fieldset>
                                                  <legend>產生條件</legend>       
                                                    <fieldset>
                                                  <legend><asp:CheckBox ID="cb_indate" runat="server" Text="到職日條件" /></legend>                          
                                                到職滿<asp:TextBox ID="TextBox1" runat="server" Width="59px"></asp:TextBox>
                                                        月以上,日期<asp:TextBox ID="checkDate" runat="server" Width="86px"></asp:TextBox>
                                                    </fieldset>
                                                     <fieldset>
                                                        <legend><asp:CheckBox ID="cb_mang" runat="server" Text="主管職條件" />
                                                        </legend>
                                                         <asp:RadioButtonList ID="RBL_Mang" runat="server">
                                                             <asp:ListItem>主管職</asp:ListItem>
                                                             <asp:ListItem>非主管職</asp:ListItem>
                                                         </asp:RadioButtonList>
                                                    </fieldset>
                                                     <fieldset>
                                                        <legend><asp:CheckBox ID="cb_di" runat="server" Text="直間接條件" />
                                                        </legend>
                                                         <asp:RadioButtonList ID="RBL_DI" runat="server">
                                                             <asp:ListItem>間接人員</asp:ListItem>
                                                             <asp:ListItem>直接人員</asp:ListItem>
                                                         </asp:RadioButtonList>
                                                    </fieldset>
                                                    
                                                    <fieldset>
                                                        <legend><asp:CheckBox ID="cb_job" runat="server" Text="職稱條件" />
                                                        </legend>
                                                        <asp:CheckBoxList ID="cbl_job" runat="server" DataSourceID="SqlDataSource_job" DataTextField="JOB_NAME"
                                                            DataValueField="JOB" RepeatColumns="10" RepeatDirection="Horizontal">
                                                        </asp:CheckBoxList>
                                                        <asp:SqlDataSource ID="SqlDataSource_job" runat="server" ConnectionString="<%$ ConnectionStrings:TMTHRConnectionString %>"
                                                            SelectCommand="SELECT [JOB], [JOB_NAME] FROM [JOB] ORDER BY [JOB]"></asp:SqlDataSource>
                                                    </fieldset>
                                                   
                                                <fieldset>
                                                  <legend>
                                                      <asp:CheckBox ID="cb_jobl" runat="server" Text="職等條件" /></legend> 
                                                <asp:CheckBoxList ID="cbl_jobl" runat="server" DataSourceID="joblDataSource1"
                                                    DataTextField="JOB_NAME" DataValueField="JOBL" RepeatColumns="10" RepeatDirection="Horizontal">
                                                </asp:CheckBoxList>
                                                </fieldset>
                                                <asp:ObjectDataSource ID="joblDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                                    SelectMethod="GetData" TypeName="EFFDSTableAdapters.JOBLTableAdapter"></asp:ObjectDataSource>
                                                    <fieldset>
                                                  <legend><asp:CheckBox ID="cb_jobs" runat="server" Text="職系條件" /></legend> 
                                                <asp:CheckBoxList ID="CheckBoxList2" runat="server" DataSourceID="josDataSource1"
                                                    DataTextField="JOB_NAME" DataValueField="JOBS" RepeatColumns="8" RepeatDirection="Horizontal">
                                                </asp:CheckBoxList>
                                                </fieldset>
                                                <asp:ObjectDataSource ID="josDataSource1" runat="server" OldValuesParameterFormatString="original_{0}"
                                                    SelectMethod="GetData" TypeName="EFFDSTableAdapters.JOBSTableAdapter"></asp:ObjectDataSource><fieldset>
                                                        <legend>
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Text="新人考核" />
                                                        </legend>
                                                        <asp:TextBox ID="t_yy" runat="server" Width="53px"></asp:TextBox>
                                                        年<asp:TextBox ID="t_mm" runat="server" Width="38px"></asp:TextBox>
                                                        月份到職員工</fieldset>
                                                    </fieldset>
                                            </asp:View>
                                            <asp:View ID="View4" runat="server"><fieldset>
                                                <legend></legend>員工工號：<asp:TextBox ID="tbnobr" runat="server" Width="79px"></asp:TextBox>
                                                <asp:Button ID="Button1" runat="server" OnClick="Button1_Click" Text="新增" />
                                                <asp:ListBox ID="lbnobr" runat="server" Width="150px"></asp:ListBox>
                                                <asp:Button ID="Button3" runat="server" OnClick="Button3_Click" Text="刪除選取資料" />
                                            </fieldset>
                                            </asp:View>
                                        </asp:MultiView>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" Title="4.選取考核群組">
                                        <asp:GridView ID="GridView4" runat="server" AutoGenerateColumns="False" DataKeyNames="effsgroupID"
                                            DataSourceID="ObjectDataSource4">
                                            <Columns>
                                                <asp:CommandField ButtonType="Button" ShowSelectButton="True" />
                                                <asp:BoundField DataField="effsgroupID" HeaderText="群組代碼" ReadOnly="True" SortExpression="effsgroupID" />
                                                <asp:BoundField DataField="effsgroupname" HeaderText="群組名稱" SortExpression="effsgroupname" />
                                                <asp:BoundField DataField="effsgroup" HeaderText="effsgroup" SortExpression="effsgroup"
                                                    Visible="False" />
                                                <asp:CheckBoxField DataField="ismangRate" HeaderText="ismangRate" SortExpression="ismangRate"
                                                    Visible="False" />
                                                <asp:BoundField DataField="order" HeaderText="order" SortExpression="order" Visible="False" />
                                                <asp:BoundField DataField="type" HeaderText="type" SortExpression="type" Visible="False" />
                                            </Columns>
                                        </asp:GridView>
                                        <asp:ObjectDataSource ID="ObjectDataSource4" runat="server" DeleteMethod="Delete"
                                            InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                                            TypeName="EFFDSTableAdapters.EFFS_GROUPTableAdapter" UpdateMethod="Update">
                                            <DeleteParameters>
                                                <asp:Parameter Name="Original_effsgroupID" Type="String" />
                                            </DeleteParameters>
                                            <InsertParameters>
                                                <asp:Parameter Name="effsgroupID" Type="String" />
                                                <asp:Parameter Name="effsgroupname" Type="String" />
                                                <asp:Parameter Name="effsgroup" Type="String" />
                                                <asp:Parameter Name="ismangRate" Type="Boolean" />
                                                <asp:Parameter Name="order" Type="Int32" />
                                                <asp:Parameter Name="type" Type="String" />
                                            </InsertParameters>
                                            <UpdateParameters>
                                                <asp:Parameter Name="effsgroupname" Type="String" />
                                                <asp:Parameter Name="effsgroup" Type="String" />
                                                <asp:Parameter Name="ismangRate" Type="Boolean" />
                                                <asp:Parameter Name="order" Type="Int32" />
                                                <asp:Parameter Name="type" Type="String" />
                                                <asp:Parameter Name="Original_effsgroupID" Type="String" />
                                            </UpdateParameters>
                                        </asp:ObjectDataSource>
                                    </asp:WizardStep>
                                    <asp:WizardStep runat="server" Title="5.產生資料">
                                        <asp:GridView ID="gb_error" runat="server">
                                        </asp:GridView>
                                        <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="False">
                                            <Columns>
                                                <asp:BoundField DataField="NOBR" HeaderText="工號" SortExpression="NOBR" />
                                                <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                                                <asp:BoundField DataField="INDT" DataFormatString="{0:yyyy/MM/dd}" HeaderText="到職日"
                                                    HtmlEncode="False" SortExpression="INDT" />
                                                <asp:BoundField DataField="TTSCODE" HeaderText="TTSCODE" SortExpression="TTSCODE"
                                                    Visible="False" />
                                                <asp:BoundField DataField="DEPT" HeaderText="DEPT" SortExpression="DEPT" Visible="False" />
                                                <asp:BoundField DataField="DEPTS" HeaderText="DEPTS" SortExpression="DEPTS" Visible="False" />
                                                <asp:CheckBoxField DataField="MANG" HeaderText="MANG" SortExpression="MANG" Visible="False" />
                                                <asp:CheckBoxField DataField="MANGE" HeaderText="MANGE" SortExpression="MANGE" Visible="False" />
                                                <asp:BoundField DataField="JOB" HeaderText="JOB" SortExpression="JOB" Visible="False" />
                                                <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
                                                <asp:BoundField DataField="DI" HeaderText="直接間" SortExpression="DI" Visible="False" />
                                                <asp:BoundField DataField="JOBS" HeaderText="JOBS" SortExpression="JOBS" Visible="False" />
                                                <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" />
                                                <asp:BoundField DataField="JOBSNAME" HeaderText="職系" SortExpression="JOBSNAME" />
                                                <asp:BoundField DataField="JOBL" HeaderText="JOBL" SortExpression="JOBL" Visible="False" />
                                                <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
                                                <asp:BoundField DataField="DEPTSNAME" HeaderText="成本中心" SortExpression="DEPTSNAME" />
                                            </Columns>
                                        </asp:GridView>
                                        <asp:Label ID="Label1" runat="server" Text="產生人數："></asp:Label>
                                        <asp:Label ID="lbCount" runat="server" ForeColor="Red" Text="0"></asp:Label>
                                        人</asp:WizardStep>
                                </WizardSteps>
                                <SideBarButtonStyle BackColor="#507CD1" Font-Names="Verdana" ForeColor="White" />
                                <HeaderStyle BackColor="#284E98" BorderColor="#EFF3FB" BorderStyle="Solid" BorderWidth="2px"
                                    Font-Bold="True" Font-Size="0.9em" ForeColor="White" HorizontalAlign="Center" />
                                <FinishNavigationTemplate>
                                    <asp:Button ID="FinishPreviousButton" runat="server" CausesValidation="False" CommandName="MovePrevious"
                                        Text="上一頁" />
                                    <asp:Button ID="FinishButton" runat="server" CommandName="MoveComplete" Text="完成" />
                                </FinishNavigationTemplate>
                            </asp:Wizard>
                        </td>
                    </tr>
                </table>
            </fieldset>
            <asp:ObjectDataSource ID="Effs_AttendDataSource" runat="server" DeleteMethod="Delete"
                InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByAll"
                TypeName="EFFDSTableAdapters.EFFS_ATTENDTableAdapter" UpdateMethod="Update">
                <DeleteParameters>
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="yy" Type="Int32" />
                    <asp:Parameter Name="seq" Type="Int32" />
                    <asp:Parameter Name="Desc" Type="String" />
                    <asp:Parameter Name="keydate" Type="DateTime" />
                    <asp:Parameter Name="StdDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                    <asp:Parameter Name="Original_autoKey" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:Parameter Name="yy" Type="Int32" />
                    <asp:Parameter Name="seq" Type="Int32" />
                    <asp:Parameter Name="Desc" Type="String" />
                    <asp:Parameter Name="keydate" Type="DateTime" />
                    <asp:Parameter Name="StdDate" Type="DateTime" />
                    <asp:Parameter Name="EndDate" Type="DateTime" />
                </InsertParameters>
            </asp:ObjectDataSource>
        </asp:View>
        <asp:View ID="View2" runat="server">
        <h5>考核名單維護</h5>
            <fieldset>
                <legend>查詢</legend>考核時間：<asp:DropDownList ID="DropDownList1" runat="server" DataSourceID="Effs_AttendDataSource"
                    DataTextField="Desc" DataValueField="autoKey">
                </asp:DropDownList>
                名工工號：<asp:TextBox ID="tb_nobr" runat="server" Width="88px"></asp:TextBox>
                <asp:Button ID="Button4" runat="server" OnClick="Button4_Click" Text="查詢" />
                <asp:Label ID="lb_yy" runat="server" Visible="False"></asp:Label>
                <asp:Label ID="lb_seq" runat="server" Visible="False"></asp:Label>
                <asp:GridView ID="GridView3" runat="server" AutoGenerateColumns="False" DataKeyNames="effbaseID"
                    DataSourceID="ObjectDataSource1" AllowPaging="True" AllowSorting="True">
                    <Columns>
                     <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:Button ID="Button2" runat="server" CausesValidation="False" CommandName="Select"
                                    Text="選取" />
                            </ItemTemplate>
                        </asp:TemplateField>  
                        <asp:BoundField DataField="effbaseID" HeaderText="effbaseID" ReadOnly="True" SortExpression="effbaseID" Visible="False" />
                        <asp:BoundField DataField="templetName" HeaderText="樣板" SortExpression="templetName" />
                        <asp:BoundField DataField="yy" HeaderText="年度" SortExpression="yy" />
                        <asp:BoundField DataField="seq" HeaderText="頻率" SortExpression="seq" />
                        <asp:BoundField DataField="templetID" HeaderText="templetID" SortExpression="templetID" Visible="False" />
                        <asp:BoundField DataField="nobr" HeaderText="工號" SortExpression="nobr" />
                        <asp:BoundField DataField="dept" HeaderText="dept" SortExpression="dept" Visible="False" />
                        <asp:BoundField DataField="depts" HeaderText="depts" SortExpression="depts" Visible="False" />
                        <asp:BoundField DataField="JOB" HeaderText="JOB" SortExpression="JOB" Visible="False" />
                        <asp:BoundField DataField="jobl" HeaderText="jobl" SortExpression="jobl" Visible="False" />
                        <asp:BoundField DataField="stddate" HeaderText="stddate" SortExpression="stddate" Visible="False" />
                        <asp:BoundField DataField="enddate" HeaderText="enddate" SortExpression="enddate" Visible="False" />
                        <asp:BoundField DataField="firstdate" HeaderText="firstdate" SortExpression="firstdate" Visible="False" />
                        <asp:BoundField DataField="deptorder" HeaderText="deptorder" SortExpression="deptorder" Visible="False" />
                        <asp:BoundField DataField="jobplan" HeaderText="jobplan" SortExpression="jobplan" Visible="False" />
                        <asp:CheckBoxField DataField="mangfinish" HeaderText="mangfinish" SortExpression="mangfinish" Visible="False" />
                        <asp:CheckBoxField DataField="isdeff" HeaderText="isdeff" SortExpression="isdeff" Visible="False" />
                        <asp:BoundField DataField="effsfinally" HeaderText="effsfinally" SortExpression="effsfinally" Visible="False" />
                        <asp:BoundField DataField="effsgroupID" HeaderText="effsgroupID" SortExpression="effsgroupID" Visible="False" />
                        <asp:BoundField DataField="NAME_C" HeaderText="姓名" SortExpression="NAME_C" />
                        <asp:BoundField DataField="DEPTNAME" HeaderText="部門" SortExpression="DEPTNAME" />
                        <asp:BoundField DataField="DEPTSNAME" HeaderText="成本中心" SortExpression="DEPTSNAME" />
                        <asp:BoundField DataField="JOBNAME" HeaderText="職稱" SortExpression="JOBNAME" />
                        <asp:BoundField DataField="JOBLNAME" HeaderText="職等" SortExpression="JOBLNAME" />
                        <asp:BoundField DataField="effsgroupname" HeaderText="群組" SortExpression="effsgroupname" />
                        
 <asp:TemplateField>
                            <ItemTemplate>
                                <asp:Button ID="Button1" runat="server" CausesValidation="False" CommandName="Delete"
                                    OnClientClick="return confirm('確定要刪除資料？');" Text="刪除" />
                            </ItemTemplate>
                        </asp:TemplateField>  
                    </Columns>
                </asp:GridView>
                <asp:ObjectDataSource ID="ObjectDataSource1" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySelect"
                    TypeName="EFFDSTableAdapters.EFFS_BASETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effbaseID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effbaseID" Type="String" />
                        <asp:Parameter Name="yy" Type="String" />
                        <asp:Parameter Name="seq" Type="String" />
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="dept" Type="String" />
                        <asp:Parameter Name="depts" Type="String" />
                        <asp:Parameter Name="JOB" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="stddate" Type="DateTime" />
                        <asp:Parameter Name="enddate" Type="DateTime" />
                        <asp:Parameter Name="firstdate" Type="DateTime" />
                        <asp:Parameter Name="deptorder" Type="String" />
                        <asp:Parameter Name="jobplan" Type="String" />
                        <asp:Parameter Name="mangfinish" Type="Boolean" />
                        <asp:Parameter Name="isdeff" Type="Boolean" />
                        <asp:Parameter Name="effsfinally" Type="String" />
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="Original_effbaseID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lb_yy" Name="yy" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="lb_seq" Name="seq" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effbaseID" Type="String" />
                        <asp:Parameter Name="yy" Type="String" />
                        <asp:Parameter Name="seq" Type="String" />
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="dept" Type="String" />
                        <asp:Parameter Name="depts" Type="String" />
                        <asp:Parameter Name="JOB" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="stddate" Type="DateTime" />
                        <asp:Parameter Name="enddate" Type="DateTime" />
                        <asp:Parameter Name="firstdate" Type="DateTime" />
                        <asp:Parameter Name="deptorder" Type="String" />
                        <asp:Parameter Name="jobplan" Type="String" />
                        <asp:Parameter Name="mangfinish" Type="Boolean" />
                        <asp:Parameter Name="isdeff" Type="Boolean" />
                        <asp:Parameter Name="effsfinally" Type="String" />
                        <asp:Parameter Name="effsgroupID" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource2" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataBySelectNobr"
                    TypeName="EFFDSTableAdapters.EFFS_BASETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effbaseID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effbaseID" Type="String" />
                        <asp:Parameter Name="yy" Type="String" />
                        <asp:Parameter Name="seq" Type="String" />
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="dept" Type="String" />
                        <asp:Parameter Name="depts" Type="String" />
                        <asp:Parameter Name="JOB" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="stddate" Type="DateTime" />
                        <asp:Parameter Name="enddate" Type="DateTime" />
                        <asp:Parameter Name="firstdate" Type="DateTime" />
                        <asp:Parameter Name="deptorder" Type="String" />
                        <asp:Parameter Name="jobplan" Type="String" />
                        <asp:Parameter Name="mangfinish" Type="Boolean" />
                        <asp:Parameter Name="isdeff" Type="Boolean" />
                        <asp:Parameter Name="effsfinally" Type="String" />
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="Original_effbaseID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="lb_yy" Name="yy" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="lb_seq" Name="seq" PropertyName="Text" Type="String" />
                        <asp:ControlParameter ControlID="tb_nobr" Name="nobr" PropertyName="Text" Type="String" />
                    </SelectParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effbaseID" Type="String" />
                        <asp:Parameter Name="yy" Type="String" />
                        <asp:Parameter Name="seq" Type="String" />
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="dept" Type="String" />
                        <asp:Parameter Name="depts" Type="String" />
                        <asp:Parameter Name="JOB" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="stddate" Type="DateTime" />
                        <asp:Parameter Name="enddate" Type="DateTime" />
                        <asp:Parameter Name="firstdate" Type="DateTime" />
                        <asp:Parameter Name="deptorder" Type="String" />
                        <asp:Parameter Name="jobplan" Type="String" />
                        <asp:Parameter Name="mangfinish" Type="Boolean" />
                        <asp:Parameter Name="isdeff" Type="Boolean" />
                        <asp:Parameter Name="effsfinally" Type="String" />
                        <asp:Parameter Name="effsgroupID" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:FormView ID="FormView1" runat="server" DataKeyNames="effbaseID" DataSourceID="ObjectDataSource3"
                    DefaultMode="Edit" OnItemUpdated="FormView1_ItemUpdated" OnItemUpdating="FormView1_ItemUpdating">
                    <EditItemTemplate>
                     <table style="width: 100%">
                             <tr>
                                 <td align="left" style="width: 50%; height: 23px">
                                     &nbsp;<asp:Button ID="LinkButton6" runat="server" CausesValidation="True" CommandName="Update"
                                         Text="儲存資料" /></td>
                                 <td align="right" style="width: 50%; height: 23px">
                                     <asp:Button ID="LinkButton7" runat="server" CausesValidation="False" CommandName="Cancel"
                                         Text="取消" />
                                 </td>
                             </tr>
                         </table>
                         <hr />       
                        <asp:Label ID="effbaseIDLabel1" runat="server" Text='<%# Bind("effbaseID") %>' Visible="False"></asp:Label><br />
                        工號：<asp:Label ID="Label2" runat="server" Text='<%# Bind("nobr") %>'></asp:Label>
                        <br />
                        樣板：<asp:DropDownList ID="DropDownList2" runat="server" DataSourceID="templeDataSource1"
                            DataTextField="templetName" DataValueField="templetID" SelectedValue='<%# Bind("templetID") %>'>
                        </asp:DropDownList><br />
                        部門：<asp:DropDownList ID="DropDownList3" runat="server" DataSourceID="deptDataSource1"
                            DataTextField="D_NAME" DataValueField="D_NO" SelectedValue='<%# Bind("dept") %>'>
                        </asp:DropDownList>
                        <br />
                        考核群組：
                        <asp:DropDownList ID="DropDownList4" runat="server" DataSourceID="GroupDataSource1"
                            DataTextField="effsgroupname" DataValueField="effsgroupID" SelectedValue='<%# Bind("effsgroupID") %>'>
                        </asp:DropDownList>
                        <asp:Label ID="yyLabel" runat="server" Text='<%# Bind("yy") %>' Visible="false"></asp:Label>

                        <asp:Label ID="seqLabel" runat="server" Text='<%# Bind("seq") %>' Visible="false"></asp:Label>
                        <asp:Label ID="deptsLabel" runat="server" Text='<%# Bind("depts") %>' Visible="false"></asp:Label>

                        <asp:Label ID="JOBLabel" runat="server" Text='<%# Bind("JOB") %>' Visible="false"></asp:Label>

                        <asp:Label ID="joblLabel" runat="server" Text='<%# Bind("jobl") %>' Visible="false"></asp:Label>

                        <asp:Label ID="stddateLabel" runat="server" Text='<%# Bind("stddate") %>' Visible="false"></asp:Label>

                        <asp:Label ID="enddateLabel" runat="server" Text='<%# Bind("enddate") %>' Visible="false"></asp:Label>

                        <asp:Label ID="firstdateLabel" runat="server" Text='<%# Bind("firstdate") %>' Visible="false"></asp:Label>

                        <asp:Label ID="deptorderLabel" runat="server" Text='<%# Bind("deptorder") %>' Visible="false"></asp:Label>

                        <asp:Label ID="jobplanLabel" runat="server" Text='<%# Bind("jobplan") %>' Visible="false"></asp:Label>
                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("depta") %>' Visible="False"></asp:Label>
                        <asp:CheckBox ID="mangfinishCheckBox" runat="server" Checked='<%# Bind("mangfinish")   %>' Visible="false"
                            Enabled="false" />
                        <asp:CheckBox ID="isdeffCheckBox" runat="server" Checked='<%# Bind("isdeff") %>' Visible="false"
                            Enabled="false" />

                        <asp:Label ID="effsfinallyLabel" runat="server" Text='<%# Bind("effsfinally") %>' Visible="false"> </asp:Label>
                       
                       
                       
                       
                    </EditItemTemplate>
                    <InsertItemTemplate>
                        effbaseID:
                        <asp:TextBox ID="effbaseIDTextBox" runat="server" Text='<%# Bind("effbaseID") %>'>
                        </asp:TextBox><br />
                        yy:
                        <asp:TextBox ID="yyTextBox" runat="server" Text='<%# Bind("yy") %>'>
                        </asp:TextBox><br />
                        seq:
                        <asp:TextBox ID="seqTextBox" runat="server" Text='<%# Bind("seq") %>'>
                        </asp:TextBox><br />
                        templetID:
                        <asp:TextBox ID="templetIDTextBox" runat="server" Text='<%# Bind("templetID") %>'>
                        </asp:TextBox><br />
                        nobr:
                        <asp:TextBox ID="nobrTextBox" runat="server" Text='<%# Bind("nobr") %>'>
                        </asp:TextBox><br />
                        dept:
                        <asp:TextBox ID="deptTextBox" runat="server" Text='<%# Bind("dept") %>'>
                        </asp:TextBox><br />
                        depts:
                        <asp:TextBox ID="deptsTextBox" runat="server" Text='<%# Bind("depts") %>'>
                        </asp:TextBox><br />
                        JOB:
                        <asp:TextBox ID="JOBTextBox" runat="server" Text='<%# Bind("JOB") %>'>
                        </asp:TextBox><br />
                        jobl:
                        <asp:TextBox ID="joblTextBox" runat="server" Text='<%# Bind("jobl") %>'>
                        </asp:TextBox><br />
                        stddate:
                        <asp:TextBox ID="stddateTextBox" runat="server" Text='<%# Bind("stddate") %>'>
                        </asp:TextBox><br />
                        enddate:
                        <asp:TextBox ID="enddateTextBox" runat="server" Text='<%# Bind("enddate") %>'>
                        </asp:TextBox><br />
                        firstdate:
                        <asp:TextBox ID="firstdateTextBox" runat="server" Text='<%# Bind("firstdate") %>'>
                        </asp:TextBox><br />
                        deptorder:
                        <asp:TextBox ID="deptorderTextBox" runat="server" Text='<%# Bind("deptorder") %>'>
                        </asp:TextBox><br />
                        jobplan:
                        <asp:TextBox ID="jobplanTextBox" runat="server" Text='<%# Bind("jobplan") %>'>
                        </asp:TextBox><br />
                        mangfinish:
                        <asp:CheckBox ID="mangfinishCheckBox" runat="server" Checked='<%# Bind("mangfinish") %>' /><br />
                        isdeff:
                        <asp:CheckBox ID="isdeffCheckBox" runat="server" Checked='<%# Bind("isdeff") %>' /><br />
                        effsfinally:
                        <asp:TextBox ID="effsfinallyTextBox" runat="server" Text='<%# Bind("effsfinally") %>'>
                        </asp:TextBox><br />
                        effsgroupID:
                        <asp:TextBox ID="effsgroupIDTextBox" runat="server" Text='<%# Bind("effsgroupID") %>'>
                        </asp:TextBox><br />
                        <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" CommandName="Insert"
                            Text="插入">
                        </asp:LinkButton>
                        <asp:LinkButton ID="InsertCancelButton" runat="server" CausesValidation="False" CommandName="Cancel"
                            Text="取消">
                        </asp:LinkButton>
                    </InsertItemTemplate>
                    <ItemTemplate>
                        effbaseID:
                        <asp:Label ID="effbaseIDLabel" runat="server" Text='<%# Eval("effbaseID") %>'></asp:Label><br />
                        yy:
                        <asp:Label ID="yyLabel" runat="server" Text='<%# Bind("yy") %>'></asp:Label><br />
                        seq:
                        <asp:Label ID="seqLabel" runat="server" Text='<%# Bind("seq") %>'></asp:Label><br />
                        templetID:
                        <asp:Label ID="templetIDLabel" runat="server" Text='<%# Bind("templetID") %>'></asp:Label><br />
                        nobr:
                        <asp:Label ID="nobrLabel" runat="server" Text='<%# Bind("nobr") %>'></asp:Label><br />
                        dept:
                        <asp:Label ID="deptLabel" runat="server" Text='<%# Bind("dept") %>'></asp:Label><br />
                        depts:
                        <asp:Label ID="deptsLabel" runat="server" Text='<%# Bind("depts") %>'></asp:Label><br />
                        JOB:
                        <asp:Label ID="JOBLabel" runat="server" Text='<%# Bind("JOB") %>'></asp:Label><br />
                        jobl:
                        <asp:Label ID="joblLabel" runat="server" Text='<%# Bind("jobl") %>'></asp:Label><br />
                        stddate:
                        <asp:Label ID="stddateLabel" runat="server" Text='<%# Bind("stddate") %>'></asp:Label><br />
                        enddate:
                        <asp:Label ID="enddateLabel" runat="server" Text='<%# Bind("enddate") %>'></asp:Label><br />
                        firstdate:
                        <asp:Label ID="firstdateLabel" runat="server" Text='<%# Bind("firstdate") %>'></asp:Label><br />
                        deptorder:
                        <asp:Label ID="deptorderLabel" runat="server" Text='<%# Bind("deptorder") %>'></asp:Label><br />
                        jobplan:
                        <asp:Label ID="jobplanLabel" runat="server" Text='<%# Bind("jobplan") %>'></asp:Label><br />
                        mangfinish:
                        <asp:CheckBox ID="mangfinishCheckBox" runat="server" Checked='<%# Bind("mangfinish") %>'
                            Enabled="false" /><br />
                        isdeff:
                        <asp:CheckBox ID="isdeffCheckBox" runat="server" Checked='<%# Bind("isdeff") %>'
                            Enabled="false" /><br />
                        effsfinally:
                        <asp:Label ID="effsfinallyLabel" runat="server" Text='<%# Bind("effsfinally") %>'></asp:Label><br />
                        effsgroupID:
                        <asp:Label ID="effsgroupIDLabel" runat="server" Text='<%# Bind("effsgroupID") %>'></asp:Label><br />
                        <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" CommandName="Edit"
                            Text="編輯"></asp:LinkButton>
                        <asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" CommandName="Delete"
                            Text="刪除"></asp:LinkButton>
                        <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" CommandName="New"
                            Text="新增"></asp:LinkButton>
                    </ItemTemplate>
                </asp:FormView>
                <asp:ObjectDataSource ID="GroupDataSource1" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                    TypeName="EFFDSTableAdapters.EFFS_GROUPTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effsgroupID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="effsgroupname" Type="String" />
                        <asp:Parameter Name="effsgroup" Type="String" />
                        <asp:Parameter Name="ismangRate" Type="Boolean" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="type" Type="String" />
                        <asp:Parameter Name="Original_effsgroupID" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="effsgroupname" Type="String" />
                        <asp:Parameter Name="effsgroup" Type="String" />
                        <asp:Parameter Name="ismangRate" Type="Boolean" />
                        <asp:Parameter Name="order" Type="Int32" />
                        <asp:Parameter Name="type" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="deptDataSource1" runat="server" InsertMethod="Insert" OldValuesParameterFormatString="original_{0}"
                    SelectMethod="GetData" TypeName="EFFDSTableAdapters.DEPTTableAdapter">
                    <InsertParameters>
                        <asp:Parameter Name="D_NO" Type="String" />
                        <asp:Parameter Name="D_NAME" Type="String" />
                        <asp:Parameter Name="PNS" Type="Double" />
                        <asp:Parameter Name="DEPT_TREE" Type="String" />
                        <asp:Parameter Name="KEY_DATE" Type="DateTime" />
                        <asp:Parameter Name="KEY_MAN" Type="String" />
                        <asp:Parameter Name="OLD_DEPT" Type="String" />
                        <asp:Parameter Name="NEW_DEPT" Type="String" />
                        <asp:Parameter Name="ADATE" Type="DateTime" />
                        <asp:Parameter Name="DDATE" Type="DateTime" />
                        <asp:Parameter Name="DEPT_GROUP" Type="String" />
                        <asp:Parameter Name="DEPT_CATE" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="templeDataSource1" runat="server" DeleteMethod="Delete"
                    InsertMethod="Insert" OldValuesParameterFormatString="original_{0}" SelectMethod="GetData"
                    TypeName="EFFDSTableAdapters.EFFS_TEMPLETTableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_templetID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="templetName" Type="String" />
                        <asp:Parameter Name="isTitle" Type="Boolean" />
                        <asp:Parameter Name="titleID" Type="String" />
                        <asp:Parameter Name="Original_templetID" Type="String" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="templetName" Type="String" />
                        <asp:Parameter Name="isTitle" Type="Boolean" />
                        <asp:Parameter Name="titleID" Type="String" />
                    </InsertParameters>
                </asp:ObjectDataSource>
                <asp:ObjectDataSource ID="ObjectDataSource3" runat="server" DeleteMethod="Delete" OldValuesParameterFormatString="original_{0}" SelectMethod="GetDataByID"
                    TypeName="EFFDSTableAdapters.EFFS_BASETableAdapter" UpdateMethod="Update">
                    <DeleteParameters>
                        <asp:Parameter Name="Original_effbaseID" Type="String" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="effbaseID" Type="String" />
                        <asp:Parameter Name="yy" Type="String" />
                        <asp:Parameter Name="seq" Type="String" />
                        <asp:Parameter Name="templetID" Type="String" />
                        <asp:Parameter Name="nobr" Type="String" />
                        <asp:Parameter Name="dept" Type="String" />
                        <asp:Parameter Name="depts" Type="String" />
                        <asp:Parameter Name="JOB" Type="String" />
                        <asp:Parameter Name="jobl" Type="String" />
                        <asp:Parameter Name="stddate" Type="DateTime" />
                        <asp:Parameter Name="enddate" Type="DateTime" />
                        <asp:Parameter Name="firstdate" Type="DateTime" />
                        <asp:Parameter Name="deptorder" Type="String" />
                        <asp:Parameter Name="jobplan" Type="String" />
                        <asp:Parameter Name="mangfinish" Type="Boolean" />
                        <asp:Parameter Name="isdeff" Type="Boolean" />
                        <asp:Parameter Name="effsfinally" Type="String" />
                        <asp:Parameter Name="effsgroupID" Type="String" />
                        <asp:Parameter Name="depta" Type="String" />
                        <asp:Parameter Name="Original_effbaseID" Type="String" />
                    </UpdateParameters>
                    <SelectParameters>
                        <asp:ControlParameter ControlID="GridView3" DefaultValue="&quot;&quot;" Name="effbaseID"
                            PropertyName="SelectedValue" Type="String" />
                    </SelectParameters>
                </asp:ObjectDataSource>
            </fieldset>
        </asp:View>
    </asp:MultiView>
</asp:Content>

