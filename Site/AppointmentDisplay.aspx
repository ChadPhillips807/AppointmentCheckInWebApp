<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AppointmentDisplay.aspx.cs" Inherits="AppointmentDisplay" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Appointments</title>
    <link type="text/css" rel="stylesheet" href="Styles/styles.css"/>
</head>
<body>
    <form id="form1" runat="server">
        <div id="table_container">
            <div class="header">
                <h3><% =DateTime.Now.ToShortDateString() %></h3>
                <h2>Today's Appointments</h2>
            </div>

            <asp:GridView ID="AppointmentsGridView" runat="server" OnRowCommand="AppointmentsGridView_RowCommand">
                <Columns>
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton ID="CheckInLinkButton" runat="server">Check In</asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

                    <br />
            <h2>Checked In</h2>
            <asp:GridView ID="CheckedInGridView" runat="server">
            </asp:GridView>

            <br />   
            <asp:Button ID="ResetValuesButton" runat="server" Text="Reset Values" OnClick="ResetValuesButton_Click" />
        </div><%--End table_container--%>
    

    
    </form>
</body>
</html>
