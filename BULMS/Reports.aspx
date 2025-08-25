<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Reports.aspx.cs" Inherits="BULMS.Reports" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Reports - BULMS</title>
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
            color: #38bdf8;
            text-align: center;
            margin-bottom: 2.5rem;
            letter-spacing: 1px;
        }
        .card {
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(56,189,248,0.10);
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
            background: linear-gradient(90deg, #38bdf8 0%, #2ec4e6 100%) !important;
            color: #fff;
        }
        .form-label {
            font-weight: 500;
            color: #38bdf8;
        }
        .btn-primary {
            background: linear-gradient(90deg, #38bdf8 0%, #2ec4e6 100%);
            border: none;
        }
        .btn-primary:hover {
            background: linear-gradient(90deg, #2ec4e6 0%, #38bdf8 100%);
        }
        .btn-secondary {
            background: #eaf3fa;
            color: #38bdf8;
            border: none;
        }
        .btn-secondary:hover {
            background: #d1e7f7;
            color: #38bdf8;
        }
        .table {
            border-radius: 1rem;
            overflow: hidden;
            background: #fff;
        }
        .table th {
            background: #e0f7fa;
            color: #38bdf8;
            font-weight: 600;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .fa-file-alt, .fa-chart-bar, .fa-money-check-dollar, .fa-list {
            color: #38bdf8;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <div class="admin-title">
                <i class="fa-solid fa-file-alt"></i> Admin Reports
            </div>
            <div class="card mb-4">
                <div class="card-header">
                    <i class="fa-solid fa-list"></i> Select Report
                </div>
                <div class="card-body">
                    <div class="mb-3">
                        <asp:DropDownList ID="ddlReportType" runat="server" AutoPostBack="true" CssClass="form-select" OnSelectedIndexChanged="ddlReportType_SelectedIndexChanged">
                            <asp:ListItem Text="Select Report" Value="" />
                            <asp:ListItem Text="Fee Report" Value="Fee" />
                            <asp:ListItem Text="Course Registration Stats" Value="CourseReg" />
                            <asp:ListItem Text="Student Course List" Value="StudentCourses" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-select" Visible="false" />
                    </div>
                    <div class="mb-3">
                        <asp:DropDownList ID="ddlStudent" runat="server" CssClass="form-select" Visible="false" />
                    </div>
                    <asp:Button ID="btnViewReport" runat="server" Text="View Report" CssClass="btn btn-primary mb-3" OnClick="btnViewReport_Click" Visible="false" />
                </div>
            </div>
            <div class="card">
                <div class="card-header">
                    <i class="fa-solid fa-chart-bar"></i> Report Results
                </div>
                <div class="card-body">
                    <asp:GridView ID="gvReport" runat="server" AutoGenerateColumns="true" CssClass="table table-bordered" />
                </div>
            </div>
            <a href="AdminDashboard.aspx" class="btn btn-secondary mt-3">Back to Dashboard</a>
        </div>
    </form>
</body>
</html>