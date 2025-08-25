<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ManageSemesters.aspx.cs" Inherits="BULMS.ManageSemesters" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Manage Semesters - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #eaf3fa 0%, #cbeafe 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .admin-container {
            max-width: 600px;
            margin: 3rem auto;
        }
        .admin-title {
            font-size: 2.2rem;
            font-weight: 700;
            color: #1e90b8;
            text-align: center;
            margin-bottom: 2.5rem;
            letter-spacing: 1px;
        }
        .card {
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(30,144,184,0.10);
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
            background: linear-gradient(90deg, #1e90b8 0%, #2ec4e6 100%) !important;
            color: #fff;
        }
        .form-label {
            font-weight: 500;
            color: #1e90b8;
        }
        .btn-primary {
            background: linear-gradient(90deg, #1e90b8 0%, #2ec4e6 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #2ec4e6 0%, #1e90b8 100%);
        }
        .btn-secondary {
            background: #eaf3fa;
            color: #1e90b8;
            border: none;
        }
        .btn-secondary:hover {
            background: #d1e7f7;
            color: #1e90b8;
        }
        .table {
            border-radius: 1rem;
            overflow: hidden;
            background: #fff;
        }
        .table th {
            background: #e0f7fa;
            color: #1e90b8;
            font-weight: 600;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .fa-calendar-days, .fa-plus {
            color: #1e90b8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <div class="admin-title">
                <i class="fa-solid fa-calendar-days"></i> Manage Semesters
            </div>
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-plus"></i> Add New Semester
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    <div class="mb-3">
                        <asp:Label ID="lblSemesterName" runat="server" Text="Semester Name:" CssClass="form-label" />
                        <asp:TextBox ID="txtSemesterName" runat="server" CssClass="form-control" />
                    </div>
                    <asp:Button ID="btnAddSemester" runat="server" Text="Add Semester" CssClass="btn btn-primary" OnClick="btnAddSemester_Click" />
                    <hr />
                    <asp:GridView ID="gvSemesters" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered mt-3" DataKeyNames="SemesterID">
                        <Columns>
                            <asp:BoundField DataField="SemesterID" HeaderText="ID" ReadOnly="True" />
                            <asp:BoundField DataField="SemesterName" HeaderText="Semester Name" />
                        </Columns>
                    </asp:GridView>
                    <a href="AdminDashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>