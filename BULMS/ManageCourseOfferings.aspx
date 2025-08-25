<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageCourseOfferings.aspx.cs" Inherits="BULMS.ManageCourseOfferings" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Course Offerings - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #eaf3fa 0%, #cbeafe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .admin-container {
            max-width: 700px;
            margin: 3rem auto;
        }
        .admin-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #6366f1;
            text-align: center;
            margin-bottom: 2.5rem;
            letter-spacing: 1px;
        }
        .card {
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(99,102,241,0.10);
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
            background: linear-gradient(90deg, #6366f1 0%, #60a5fa 100%) !important;
            color: #fff;
        }
        .form-label {
            font-weight: 500;
            color: #6366f1;
        }
        .btn-primary {
            background: linear-gradient(90deg, #6366f1 0%, #60a5fa 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #60a5fa 0%, #6366f1 100%);
        }
        .btn-secondary {
            background: #eaf3fa;
            color: #6366f1;
            border: none;
        }
        .btn-secondary:hover {
            background: #d1e7f7;
            color: #6366f1;
        }
        .table {
            border-radius: 1rem;
            overflow: hidden;
            background: #fff;
        }
        .table th {
            background: #e0e7ff;
            color: #6366f1;
            font-weight: 600;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .fa-layer-group, .fa-plus {
            color: #6366f1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <div class="admin-title">
                <i class="fa-solid fa-layer-group"></i> Manage Course Offerings
            </div>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fa-solid fa-plus"></i> Add Course Offering
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    <div class="row mb-3">
                        <div class="col-md-4">
                            <asp:Label ID="lblSemester" runat="server" Text="Semester:" CssClass="form-label" />
                            <asp:DropDownList ID="ddlSemester" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlSemester_SelectedIndexChanged" />
                        </div>
                        <div class="col-md-4">
                            <asp:Label ID="lblCourse" runat="server" Text="Course:" CssClass="form-label" />
                            <asp:DropDownList ID="ddlCourse" runat="server" CssClass="form-select" />
                        </div>
                        <div class="col-md-4">
                            <asp:Label ID="lblFaculty" runat="server" Text="Faculty:" CssClass="form-label" />
                            <asp:DropDownList ID="ddlFaculty" runat="server" CssClass="form-select" />
                        </div>
                    </div>
                    <asp:Button ID="btnAddOffering" runat="server" Text="Add Course Offering" CssClass="btn btn-primary" OnClick="btnAddOffering_Click" />
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-layer-group"></i> Current Offerings
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvOfferings" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered" DataKeyNames="OfferingID" OnRowDeleting="gvOfferings_RowDeleting">
                        <Columns>
                            <asp:BoundField DataField="SemesterName" HeaderText="Semester" />
                            <asp:BoundField DataField="CourseName" HeaderText="Course" />
                            <asp:BoundField DataField="FacultyName" HeaderText="Faculty" />
                            <asp:CommandField ShowDeleteButton="True" />
                        </Columns>
                    </asp:GridView>
                    <a href="AdminDashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>