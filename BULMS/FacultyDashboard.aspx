<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FacultyDashboard.aspx.cs" Inherits="BULMS.FacultyDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Faculty Dashboard - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
            background: linear-gradient(120deg, #a1c4fd, #c2e9fb, #fbc2eb, #f7971e, #43e97b, #38f9d7);
            background-size: 400% 400%;
            animation: gradientBG 18s ease infinite;
        }
        @keyframes gradientBG {
            0% {background-position: 0% 50%;}
            50% {background-position: 100% 50%;}
            100% {background-position: 0% 50%;}
        }
        .sidebar {
            width: 240px;
            min-height: 100vh;
            background: rgba(60, 80, 180, 0.75);
            color: #fff;
            position: fixed;
            top: 0; left: 0;
            z-index: 100;
            display: flex;
            flex-direction: column;
            box-shadow: 4px 0 32px 0 rgba(60,80,180,0.10);
            backdrop-filter: blur(8px);
            border-right: 1.5px solid rgba(255,255,255,0.08);
        }
        .sidebar-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 2rem 1.5rem 1.2rem 1.5rem;
        }
        .sidebar-logo {
            background: linear-gradient(135deg, #43e97b 0%, #38f9d7 100%);
            color: #fff;
            border-radius: 50%;
            width: 48px;
            height: 48px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.7rem;
            box-shadow: 0 2px 8px #38f9d755;
        }
        .sidebar-title {
            font-size: 1.35rem;
            font-weight: 800;
            letter-spacing: 1px;
            text-shadow: 0 2px 8px #38f9d733;
        }
        .sidebar-nav {
            flex: 1;
            padding: 0;
            margin: 0;
            list-style: none;
        }
        .sidebar-nav li {
            border-bottom: 1px solid rgba(255,255,255,0.07);
        }
        .sidebar-nav a, .sidebar-nav .aspnet-linkbutton {
            display: block;
            color: #fff;
            text-decoration: none;
            padding: 1rem 1.5rem;
            font-size: 1.08rem;
            font-weight: 500;
            transition: background 0.18s, color 0.18s, transform 0.18s;
            border: none;
            background: none;
            text-align: left;
            width: 100%;
            outline: none;
        }
        .sidebar-nav a:hover, .sidebar-nav .aspnet-linkbutton:hover, .sidebar-nav a.active {
            background: rgba(67,233,123,0.13);
            color: #43e97b;
            transform: scale(1.04) translateX(4px);
        }
        .main-content {
            margin-left: 240px;
            padding: 3.5rem 2rem 2rem 2rem;
        }
        .main-card {
            background: rgba(255,255,255,0.92);
            border-radius: 0;
            box-shadow: 0 8px 32px rgba(60,80,180,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
            max-width: 700px;
            margin: 0 auto;
        }
        @media (max-width: 900px) {
            .sidebar {
                width: 100vw;
                min-height: auto;
                position: static;
                flex-direction: row;
                box-shadow: none;
                border-right: none;
            }
            .sidebar-header {
                padding: 1rem 1rem 0.5rem 1rem;
            }
            .sidebar-nav {
                display: flex;
                flex-direction: row;
                overflow-x: auto;
            }
            .sidebar-nav li {
                border-bottom: none;
                border-right: 1px solid rgba(255,255,255,0.08);
            }
            .sidebar-nav a, .sidebar-nav .aspnet-linkbutton {
                padding: 0.8rem 1rem;
                font-size: 1rem;
            }
            .main-content {
                margin-left: 0;
                padding: 1.5rem 0.5rem;
            }
            .main-card {
                padding: 1.2rem 0.5rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="sidebar">
            <div class="sidebar-header">
                <div class="sidebar-logo">
                    <i class="fa-solid fa-user-tie"></i>
                </div>
                <span class="sidebar-title">Faculty Portal</span>
            </div>
            <ul class="sidebar-nav">
                <li>
                    <a href="GradeSubmissions.aspx">
                        Grade Submissions
                    </a>
                </li>
                <li>
                    <a href="UploadAssignment.aspx">
                        Upload Assignment
                    </a>
                </li>
                <li>
                    <a href="FacultyAnnouncements.aspx">
                        Send Announcement
                    </a>
                </li>
                <li>
                    <a href="ViewAttendance.aspx">
                        View Attendance
                    </a>
                </li>
                <li>
                    <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="aspnet-linkbutton">
                        Logout
                    </asp:LinkButton>
                </li>
            </ul>
        </div>
        <!-- Main Content -->
        <div class="main-content">
            <div class="main-card">
                <h2 style="font-weight:700; color:#4f8cff;">Welcome, Faculty!</h2>
                <asp:Label ID="lblFaculty" runat="server" Text="Empowering your teaching journey" />
            </div>
        </div>
    </form>
</body>
</html>