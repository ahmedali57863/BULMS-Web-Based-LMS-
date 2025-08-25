<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="StudentProfile.aspx.cs" Inherits="BULMS.StudentProfile" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Student Profile - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .profile-container {
            max-width: 500px;
            margin: 3rem auto;
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(0,0,0,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
        }
        .profile-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .profile-header .fa-user-circle {
            font-size: 3rem;
            color: #4ea8de;
        }
        .profile-header h3 {
            font-weight: 700;
            margin: 0;
            color: #22223b;
        }
        .profile-table {
            width: 100%;
            margin-bottom: 1.5rem;
        }
        .profile-table th, .profile-table td {
            border: none;
            padding: 0.7rem 0.5rem;
            font-size: 1.08rem;
        }
        .profile-table th {
            color: #4ea8de;
            font-weight: 600;
            width: 40%;
            background: none;
        }
        .profile-table td {
            color: #22223b;
            background: none;
        }
        .profile-table i {
            margin-right: 0.5rem;
            color: #a5b4fc;
        }
        .btn-back {
            background: #4ea8de;
            color: #fff;
            border: none;
            border-radius: 2rem;
            padding: 0.6rem 1.5rem;
            font-size: 1.08rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(78,168,222,0.08);
            transition: background 0.2s;
            text-decoration: none;
        }
        .btn-back:hover {
            background: #2779bd;
            color: #fff;
        }
        @media (max-width: 600px) {
            .profile-container {
                padding: 1.2rem 0.5rem;
            }
            .profile-header h3 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="profile-container">
            <div class="profile-header">
                <i class="fa-solid fa-user-circle"></i>
                <h3>Student Profile</h3>
            </div>
            <asp:Label ID="lblWelcome" runat="server" CssClass="h5 mb-3 d-block" />
            <table class="profile-table">
                <tr>
                    <th><i class="fa-solid fa-user"></i>Full Name</th>
                    <td><asp:Label ID="lblFullName" runat="server" /></td>
                </tr>
                <tr>
                    <th><i class="fa-solid fa-user-tag"></i>Username</th>
                    <td><asp:Label ID="lblUsername" runat="server" /></td>
                </tr>
                <tr>
                    <th><i class="fa-solid fa-envelope"></i>Email</th>
                    <td><asp:Label ID="lblEmail" runat="server" /></td>
                </tr>
            </table>
            <a href="StudentDashboard.aspx" class="btn btn-back mt-2"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </form>
</body>
</html>