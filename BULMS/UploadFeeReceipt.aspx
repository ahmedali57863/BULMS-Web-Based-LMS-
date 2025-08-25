<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="UploadFeeReceipt.aspx.cs" Inherits="BULMS.UploadFeeReceipt" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Upload Fee Receipt</title>
</head>
<body>
    <form id="form1" runat="server">
        <h2>Upload Fee Receipt</h2>
        <asp:Label ID="lblMessage" runat="server" ForeColor="Red" />
        <br /><br />
        <table>
            <tr>
                <td>Student:</td>
                <td>
                    <asp:DropDownList ID="ddlStudents" runat="server" />
                </td>
            </tr>
            <tr>
                <td>Amount:</td>
                <td>
                    <asp:TextBox ID="txtAmount" runat="server" />
                </td>
            </tr>
            <tr>
                <td>Receipt File:</td>
                <td>
                    <asp:FileUpload ID="fuReceipt" runat="server" />
                </td>
            </tr>
            <tr>
                <td>Status:</td>
                <td>
                    <asp:DropDownList ID="ddlStatus" runat="server">
                        <asp:ListItem>Paid</asp:ListItem>
                        <asp:ListItem>Unpaid</asp:ListItem>
                    </asp:DropDownList>
                </td>
            </tr>
            <tr>
                <td colspan="2">
                    <asp:Button ID="btnUpload" runat="server" Text="Upload Receipt" OnClick="btnUpload_Click" />
                </td>
            </tr>
        </table>
        <br />
        <h3>All Fee Receipts</h3>
        <asp:GridView ID="gvReceipts" runat="server" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="ReceiptID" HeaderText="Receipt ID" />
                <asp:BoundField DataField="StudentName" HeaderText="Student" />
                <asp:BoundField DataField="Amount" HeaderText="Amount" />
                <asp:BoundField DataField="Status" HeaderText="Status" />
                <asp:BoundField DataField="DateUploaded" HeaderText="Date Uploaded" />
                <asp:TemplateField HeaderText="Receipt">
                    <ItemTemplate>
                        <asp:HyperLink ID="hlReceipt" runat="server"
                            NavigateUrl='<%# Eval("ReceiptPath") != null ? Eval("ReceiptPath") : "" %>'
                            Text='<%# Eval("ReceiptPath") != null ? "Download" : "Not Uploaded" %>'
                            Target="_blank" />
                    </ItemTemplate>
                </asp:TemplateField>
            </Columns>
        </asp:GridView>
    </form>
</body>
</html>