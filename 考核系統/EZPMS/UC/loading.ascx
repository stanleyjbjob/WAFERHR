<%@ Control Language="C#" AutoEventWireup="true" CodeFile="loading.ascx.cs" Inherits="UC_loading" %>
<asp:UpdateProgress ID="UpdateProgress1" runat="server">
    <ProgressTemplate>
        &nbsp;<table id="loaderContainer" border="0" cellpadding="0" cellspacing="0" onclick="return false;">
            <tr>
                <td id="loaderContainerWH">
                    <div id="loader">
                        <table border="0" cellpadding="0" cellspacing="0" width="100%">
                            <tr>
                                <td>
                                    <p>
                                        <img alt="" height="32" src="../images/loading.gif" width="32" /><strong>請稍後～<br />
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
