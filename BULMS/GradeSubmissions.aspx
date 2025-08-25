<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GradeSubmissions.aspx.cs" Inherits="BULMS.GradeSubmissions" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Grade Submissions - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body>
    <form id="form1" runat="server" class="container mt-5">
        <div class="card">
            <div class="card-header bg-primary text-white">
                <h3>Grade Student Submissions</h3>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                <asp:GridView ID="gvSubmissions" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered mt-3" OnRowCommand="gvSubmissions_RowCommand">
                    <Columns>
                        <asp:BoundField DataField="CourseName" HeaderText="Course" />
                        <asp:BoundField DataField="AssignmentTitle" HeaderText="Assignment" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student" />
                        <asp:BoundField DataField="SubmissionDate" HeaderText="Submitted On" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                        <asp:TemplateField HeaderText="File">
                            <ItemTemplate>
                               <a href='<%# ResolveUrl(Eval("FilePath").ToString()) %>' download='<%# Eval("FileName") %>' class="btn btn-sm btn-info" target="_blank">Download</a>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Grade">
                            <ItemTemplate>
                                <asp:TextBox ID="txtGrade" runat="server" Text='<%# Eval("Grade") %>' CssClass="form-control" Width="80px" />
                                <asp:Button ID="btnSave" runat="server" Text="Save" CommandName="SaveGrade" CommandArgument='<%# Eval("SubmissionID") %>' CssClass="btn btn-success btn-sm mt-1" />
                            </ItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                </asp:GridView>
                <a href="FacultyDashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
            </div>
        </div>
    </form>
</body>
</html>