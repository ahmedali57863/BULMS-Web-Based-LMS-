<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="BULMS.ManageCourses" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Courses - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #eaf3fa 0%, #cbeafe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .admin-container {
            max-width: 900px;
            margin: 3rem auto;
        }
        .admin-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #22c55e;
            text-align: center;
            margin-bottom: 2.5rem;
            letter-spacing: 1px;
        }
        .card {
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(34,197,94,0.10);
            border: none;
        }
        .card-header {
            border-radius: 1.5rem 1.5rem 0 0;
            font-size: 1.3rem;
            font-weight: 600;
            letter-spacing: 1px;
            display: flex;
            align-items: center;
            gap: 0.7rem;
        }
        .card-header.bg-success {
            background: linear-gradient(90deg, #22c55e 0%, #4ade80 100%) !important;
        }
        .form-label {
            font-weight: 500;
            color: #22c55e;
        }
        .btn-success {
            background: linear-gradient(90deg, #22c55e 0%, #4ade80 100%);
            border: none;
        }
        .btn-success:hover {
            background: linear-gradient(90deg, #4ade80 0%, #22c55e 100%);
        }
        .btn-secondary {
            background: #eaf3fa;
            color: #22c55e;
            border: none;
        }
        .btn-secondary:hover {
            background: #d1e7f7;
            color: #22c55e;
        }
        .table {
            border-radius: 1rem;
            overflow: hidden;
            background: #fff;
        }
        .table th {
            background: #e0fce9;
            color: #22c55e;
            font-weight: 600;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .fa-book, .fa-plus, .fa-edit, .fa-trash, .fa-user, .fa-link {
            color: #22c55e;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <div class="admin-title">
                <i class="fa-solid fa-book"></i> Manage Courses
            </div>
            <div class="card mb-4">
                <div class="card-header bg-success text-white">
                    <i class="fa-solid fa-plus"></i> Add New Course
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <asp:Label ID="lblCourseName" runat="server" Text="Course Name:" CssClass="form-label" />
                            <asp:TextBox ID="txtCourseName" runat="server" CssClass="form-control" />
                        </div>
                        <div class="col-md-4">
                            <asp:Label ID="lblFaculty" runat="server" Text="Assign Faculty:" CssClass="form-label" />
                            <asp:DropDownList ID="ddlFaculty" runat="server" CssClass="form-select" />
                        </div>
                        <div class="col-md-4">
                            <asp:Label ID="lblPrerequisite" runat="server" Text="Prerequisite:" CssClass="form-label" />
                            <asp:DropDownList ID="ddlPrerequisite" runat="server" CssClass="form-select" />
                        </div>
                    </div>
                    <asp:Button ID="btnAddCourse" runat="server" Text="Add Course" CssClass="btn btn-success" OnClick="btnAddCourse_Click" />
                </div>
            </div>
            <div class="card">
                <div class="card-header bg-success text-white">
                    <i class="fa-solid fa-book"></i> Courses List
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvCourses" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered mt-3"
                        DataKeyNames="CourseID"
                        OnRowEditing="gvCourses_RowEditing"
                        OnRowCancelingEdit="gvCourses_RowCancelingEdit"
                        OnRowUpdating="gvCourses_RowUpdating"
                        OnRowDeleting="gvCourses_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="CourseID" HeaderText="ID" ReadOnly="True" />
                            <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                            <asp:TemplateField HeaderText="Faculty">
                                <ItemTemplate>
                                    <i class="fa-solid fa-user"></i> <%# Eval("FacultyName") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditFaculty" runat="server" Text='<%# Eval("FacultyName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Prerequisite">
                                <ItemTemplate>
                                    <i class="fa-solid fa-link"></i> <%# Eval("PrerequisiteName") %>
                                </ItemTemplate>
                                <EditItemTemplate>
                                    <asp:TextBox ID="txtEditPrerequisite" runat="server" Text='<%# Eval("PrerequisiteName") %>' CssClass="form-control" />
                                </EditItemTemplate>
                            </asp:TemplateField>
                            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" EditText="<i class='fa-solid fa-edit'></i> Edit" DeleteText="<i class='fa-solid fa-trash'></i> Delete" />
                        </Columns>
                    </asp:GridView>
                    <a href="AdminDashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>