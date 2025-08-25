<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FacultyAnnouncements.aspx.cs" Inherits="BULMS.FacultyAnnouncements" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Send Announcement - BULMS</title>
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
            max-width: 600px;
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
        .form-label {
            font-weight: 600;
            color: #f59e42;
        }
        .btn-send {
            background: #fbbf24;
            color: #22223b;
            border: none;
            border-radius: 2rem;
            padding: 0.6rem 1.5rem;
            font-size: 1.08rem;
            font-weight: 600;
            box-shadow: 0 2px 8px #fbbf2433;
            transition: background 0.2s;
        }
        .btn-send:hover {
            background: #f59e42;
            color: #fff;
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
        @media (max-width: 700px) {
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
                <h3>Send Announcement</h3>
            </div>
            <div class="card-body">
                <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                <div class="mb-3">
                    <asp:Label ID="lblCourse" runat="server" Text="Select Course:" CssClass="form-label" />
                    <asp:DropDownList ID="ddlCourses" runat="server" CssClass="form-select" />
                </div>
                <div class="mb-3">
                    <asp:Label ID="lblAnnouncement" runat="server" Text="Announcement:" CssClass="form-label" />
                    <asp:TextBox ID="txtAnnouncement" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" />
                </div>
                <asp:Button ID="btnSend" runat="server" Text="Send Announcement" CssClass="btn btn-send" OnClick="btnSend_Click" />
                <a href="FacultyDashboard.aspx" class="btn btn-back ms-2">Back to Dashboard</a>
            </div>
        </div>
    </form>
</body>
</html>