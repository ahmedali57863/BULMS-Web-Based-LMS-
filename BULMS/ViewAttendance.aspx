<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewAttendance.aspx.cs" Inherits="BULMS.ViewAttendance" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Attendance Reports - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(120deg, #a1c4fd, #c2e9fb, #fbc2eb, #f7971e, #43e97b, #38f9d7);
            background-size: 400% 400%;
            animation: gradientBG 18s ease infinite;
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        @keyframes gradientBG {
            0% {background-position: 0% 50%;}
            50% {background-position: 100% 50%;}
            100% {background-position: 0% 50%;}
        }
        .main-card {
            background: rgba(255,255,255,0.96);
            border-radius: 0;
            box-shadow: 0 8px 32px rgba(60,80,180,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
            max-width: 800px;
            margin: 3rem auto;
        }
        .card-header {
            border-radius: 0;
            background: none !important;
            color: #22223b !important;
            border-bottom: 4px solid #fbbf24;
        }
        .card-header h3 {
            color: #22223b !important;
            font-weight: 700;
        }
        .table thead th {
            background: #e0e7ff;
            color: #f59e42;
            font-weight: 600;
            border-top: none;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        .btn-back {
            background: #4ea8de;
            color: #fff;
            border: none;
            border-radius: 2rem;
            padding: 0.6rem 1.5rem;
            font-size: 1.08rem;
            font-weight: 600;
            box-shadow: 0 2px 8px #4ea8de33;
            transition: background 0.2s;
            text-decoration: none;
        }
        .btn-back:hover {
            background: #2779bd;
            color: #fff;
        }
        @media (max-width: 900px) {
            .main-card {
                padding: 1.2rem 0.5rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-card">
            <div class="card-header">
                <h3>Attendance Reports</h3>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                <asp:GridView ID="gvAttendance" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered mt-3">
                    <Columns>
                        <asp:BoundField DataField="CourseName" HeaderText="Course" />
                        <asp:BoundField DataField="StudentName" HeaderText="Student" />
                        <asp:BoundField DataField="Date" HeaderText="Date" DataFormatString="{0:yyyy-MM-dd}" />
                        <asp:BoundField DataField="Status" HeaderText="Status" />
                    </Columns>
                </asp:GridView>
                <a href="FacultyDashboard.aspx" class="btn btn-back mt-3">Back to Dashboard</a>
            </div>
        </div>
    </form>
</body>
</html>