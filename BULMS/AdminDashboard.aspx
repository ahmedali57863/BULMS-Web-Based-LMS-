<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="BULMS.AdminDashboard" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Admin Dashboard - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: #eaf3fa;
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
            margin: 0;
        }
        .admin-sidebar {
            width: 240px;
            min-height: 100vh;
            background: linear-gradient(160deg, #1e90b8 0%, #2ec4e6 100%);
            color: #fff;
            position: fixed;
            top: 0; left: 0;
            z-index: 100;
            display: flex;
            flex-direction: column;
            box-shadow: 2px 0 16px rgba(30,144,184,0.10);
            border-top-left-radius: 24px;
            border-bottom-left-radius: 24px;
        }
        .sidebar-header {
            font-size: 1.7rem;
            font-weight: 800;
            letter-spacing: 2px;
            padding: 2rem 1.5rem 1.2rem 1.5rem;
            color: #fff;
            display: flex;
            align-items: center;
            gap: 0.7rem;
        }
        .sidebar-header i {
            font-size: 2rem;
        }
        .sidebar-nav {
            flex: 1;
            padding: 0;
            margin: 0;
            list-style: none;
        }
        .sidebar-nav li {
            border-bottom: 1px solid rgba(255,255,255,0.08);
        }
        .sidebar-nav a, .sidebar-nav .aspnet-linkbutton {
            display: flex;
            align-items: center;
            color: #eaf3fa;
            text-decoration: none;
            padding: 1rem 1.5rem;
            font-size: 1.08rem;
            font-weight: 500;
            transition: background 0.15s, color 0.15s;
            border: none;
            background: none;
            text-align: left;
            width: 100%;
            outline: none;
            position: relative;
            border-radius: 8px;
            margin: 0.2rem 0;
        }
        .sidebar-nav a.active, .sidebar-nav a:hover, .sidebar-nav .aspnet-linkbutton:hover {
            background: rgba(255,255,255,0.13);
            color: #fff;
        }
        .sidebar-nav a i, .sidebar-nav .aspnet-linkbutton i {
            margin-right: 1rem;
            font-size: 1.2rem;
            opacity: 0.9;
        }
        .main-content {
            margin-left: 260px;
            padding: 2.5rem 2rem 2rem 2rem;
            background: #eaf3fa;
            min-height: 100vh;
        }
        .topbar {
            display: flex;
            justify-content: flex-end;
            align-items: center;
            margin-bottom: 2rem;
        }
        .topbar .profile-pic {
            width: 40px;
            height: 40px;
            border-radius: 50%;
            background: #fff;
            border: 2px solid #2ec4e6;
            object-fit: cover;
            cursor: pointer;
            transition: box-shadow 0.2s;
        }
        .topbar .profile-pic:hover {
            box-shadow: 0 0 0 4px #2ec4e6;
        }
        .admin-card {
            background: #fff;
            border-radius: 18px;
            box-shadow: 0 8px 32px rgba(30,144,184,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
            max-width: 950px;
            margin: 0 auto;
            color: #22223b;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
        }
        .admin-card .card-header {
            background: none;
            color: #1e90b8;
            border-radius: 0;
            border-bottom: 2px solid #2ec4e6;
            margin-bottom: 2rem;
            width: 100%;
            text-align: center;
        }
        .admin-card .card-header h3 {
            color: #1e90b8;
            font-weight: 700;
            letter-spacing: 1px;
            margin: 0;
        }
        /* Modal styles */
        .modal {
            display: none;
            position: fixed;
            z-index: 9999;
            left: 0; top: 0;
            width: 100%; height: 100%;
            overflow: auto;
            background: rgba(0,0,0,0.7);
        }
        .modal-content {
            margin: 5% auto;
            display: block;
            max-width: 400px;
            border-radius: 20px;
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.2);
        }
        .close {
            position: absolute;
            top: 40px;
            right: 60px;
            color: #fff;
            font-size: 2.5rem;
            font-weight: bold;
            cursor: pointer;
            z-index: 10001;
        }
        @media (max-width: 900px) {
            .admin-sidebar {
                width: 100vw;
                min-height: auto;
                position: static;
                flex-direction: row;
                box-shadow: none;
                border-radius: 0;
            }
            .sidebar-header {
                font-size: 1.1rem;
                padding: 1rem 1rem 0.5rem 1rem;
            }
            .sidebar-nav {
                display: flex;
                flex-direction: row;
                overflow-x: auto;
            }
            .sidebar-nav li {
                border-bottom: none;
                border-right: 1px solid #2ec4e6;
            }
            .sidebar-nav a, .sidebar-nav .aspnet-linkbutton {
                padding: 0.8rem 1rem;
                font-size: 1rem;
            }
            .main-content {
                margin-left: 0;
                padding: 1.5rem 0.5rem;
            }
            .admin-card {
                padding: 1.2rem 0.5rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <!-- Sidebar -->
        <div class="admin-sidebar">
            <div class="sidebar-header">
                <i class="fa-solid fa-building-columns"></i> BULMS Admin
            </div>
            <ul class="sidebar-nav">
                <li><a href="AddUser.aspx"><i class="fa-solid fa-user-plus"></i> Add/Remove User</a></li>
                <li><a href="ManageCourses.aspx"><i class="fa-solid fa-book"></i> Manage Courses</a></li>
                <li><a href="Reports.aspx"><i class="fa-solid fa-file-alt"></i> Reports</a></li>
                <li><a href="ManageSemesters.aspx"><i class="fa-solid fa-calendar-days"></i> Manage Semesters</a></li>
                <li><a href="ManageCourseOfferings.aspx"><i class="fa-solid fa-layer-group"></i> Manage Course Offerings</a></li>
                <li><a href="FeeReport.aspx"><i class="fa-solid fa-file-invoice-dollar"></i> Fee Report</a></li>
                <li><a href="CourseRegistrationStats.aspx"><i class="fa-solid fa-chart-bar"></i> Course Registration Stats</a></li>
                <li>
                    <asp:LinkButton ID="lnkLogout" runat="server" OnClick="lnkLogout_Click" CssClass="sidebar-nav admin-btn-danger" style="text-align:left;">
                        <i class="fa-solid fa-right-from-bracket"></i>Logout
                    </asp:LinkButton>
                </li>
            </ul>
        </div>
        <!-- Main Content -->
        <div class="main-content">
            <div class="topbar">
                <img src="12.jpeg" alt="Profile" class="profile-pic" id="profilePic" />
            </div>
            <div class="admin-card">
                <div class="card-header">
                    <h3>Admin Dashboard</h3>
                </div>
            </div>
        </div>
        <!-- Modal for enlarged profile picture -->
        <div id="profileModal" class="modal">
            <span class="close" id="closeModal">&times;</span>
            <img class="modal-content" id="modalImg" src="12.jpeg" alt="Profile Large" />
        </div>
    </form>
    <script>
        // Modal logic
        var modal = document.getElementById("profileModal");
        var img = document.getElementById("profilePic");
        var modalImg = document.getElementById("modalImg");
        var closeBtn = document.getElementById("closeModal");

        img.onclick = function () {
            modal.style.display = "block";
        }
        closeBtn.onclick = function () {
            modal.style.display = "none";
        }
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>
</html>