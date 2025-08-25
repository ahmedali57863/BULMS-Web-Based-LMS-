<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentDashboard.aspx.cs" Inherits="BULMS.StudentDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Dashboard - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .dashboard-container {
            max-width: 900px;
            margin: 3rem auto;
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(0,0,0,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
        }
        .dashboard-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2.5rem;
        }
        .welcome-section {
            background: linear-gradient(90deg, #4ea8de 0%, #a5b4fc 100%);
            color: #fff;
            border-radius: 1rem;
            padding: 2rem 2rem 1.5rem 2rem;
            margin-bottom: 2.5rem;
            box-shadow: 0 2px 12px rgba(78,168,222,0.08);
        }
        .welcome-section h2 {
            font-weight: 700;
            font-size: 2.2rem;
            margin-bottom: 0.5rem;
        }
        .welcome-section .fa-user-graduate {
            font-size: 2.5rem;
            margin-right: 1rem;
            vertical-align: middle;
        }
        .nav-cards {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            justify-content: center;
        }
        .nav-card {
            flex: 1 1 220px;
            min-width: 200px;
            max-width: 240px;
            background: #f1f5f9;
            border-radius: 1rem;
            padding: 1.5rem 1rem;
            text-align: center;
            text-decoration: none;
            color: #22223b;
            font-size: 1.1rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(78,168,222,0.06);
            transition: transform 0.15s, box-shadow 0.15s, background 0.15s;
            position: relative;
        }
        .nav-card i {
            font-size: 2rem;
            margin-bottom: 0.7rem;
            color: #4ea8de;
            display: block;
        }
        .nav-card:hover {
            background: #e0e7ff;
            transform: translateY(-6px) scale(1.03);
            box-shadow: 0 6px 24px rgba(78,168,222,0.13);
            color: #2779bd;
        }
        .logout-btn {
            background: #ef4444;
            color: #fff;
            border: none;
            border-radius: 2rem;
            padding: 0.6rem 1.5rem;
            font-size: 1.1rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(239,68,68,0.08);
            transition: background 0.2s;
        }
        .logout-btn:hover {
            background: #b91c1c;
            color: #fff;
        }
        @media (max-width: 700px) {
            .dashboard-container {
                padding: 1rem 0.5rem;
            }
            .nav-cards {
                flex-direction: column;
                gap: 1rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="dashboard-container">
            <!-- Header with Logout -->
            <div class="dashboard-header">
                <div style="font-size:1.5rem; font-weight:700; color:#4ea8de;">
                    <i class="fa-solid fa-graduation-cap"></i> BULMS Student Portal
                </div>
                <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="logout-btn">Logout <i class="fa-solid fa-right-from-bracket"></i></asp:LinkButton>
            </div>
            <!-- Welcome Section -->
            <div class="welcome-section d-flex align-items-center">
                <i class="fa-solid fa-user-graduate"></i>
                <div>
                    <h2>Welcome, Student!</h2>
                    <asp:Label ID="lblStudent" runat="server" Text="" />
                </div>
            </div>
            <!-- Navigation Cards -->
            <div class="nav-cards">
                <a href="StudentProfile.aspx" class="nav-card">
                    <i class="fa-solid fa-id-card"></i>
                    View Profile
                </a>
                <a href="CourseRegistration.aspx" class="nav-card">
                    <i class="fa-solid fa-book-open"></i>
                    Register for Courses
                </a>
                <a href="SubmitAssignment.aspx" class="nav-card">
                    <i class="fa-solid fa-upload"></i>
                    Submit Assignments
                </a>
                <a href="ViewGrades.aspx" class="nav-card">
                    <i class="fa-solid fa-chart-bar"></i>
                    View Grades
                </a>
                <a href="ViewAnnouncements.aspx" class="nav-card">
                    <i class="fa-solid fa-bullhorn"></i>
                    View Announcements
                </a>
                <a href="ViewFees.aspx" class="nav-card">
                    <i class="fa-solid fa-money-check-dollar"></i>
                    View Fees
                </a>
            </div>
        </div>
    </form>
</body>
</html> 