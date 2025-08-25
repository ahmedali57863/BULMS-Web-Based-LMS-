<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseRegistrationStats.aspx.cs" Inherits="BULMS.CourseRegistrationStats" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Registration Statistics - BULMS</title>
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
        .fa-chart-bar {
            color: #6366f1;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <div class="admin-title">
                <i class="fa-solid fa-chart-bar"></i> Course Registration Statistics
            </div>
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-chart-bar"></i> Course Registration Statistics
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    <asp:GridView ID="gvStats" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered mt-3">
                        <Columns>
                            <asp:BoundField DataField="CourseName" HeaderText="Course Name" />
                            <asp:BoundField DataField="TotalRegistrations" HeaderText="Total Registrations" />
                        </Columns>
                    </asp:GridView>
                    <a href="AdminDashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
                </div>
            </div>
        </div>
    </form>
</body>
</html>