<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddUser.aspx.cs" Inherits="BULMS.AddUser" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Add/Remove User - BULMS</title>
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
        }
        .card-header.bg-primary {
            background: linear-gradient(90deg, #1e90b8 0%, #2ec4e6 100%) !important;
        }
        .card-header.bg-danger {
            background: linear-gradient(90deg, #ef4444 0%, #b91c1c 100%) !important;
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
        .btn-danger {
            background: linear-gradient(90deg, #ef4444 0%, #b91c1c 100%);
            border: none;
        }
        .btn-danger:hover {
            background: linear-gradient(90deg, #b91c1c 0%, #ef4444 100%);
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
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="admin-container">
            <div class="admin-title">
                <i class="fa-solid fa-user-gear"></i> Add / Remove User
            </div>
            <div class="card mb-4">
                <div class="card-header bg-primary text-white">
                    <i class="fa-solid fa-user-plus"></i> Add New User
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
                    <div class="mb-3">
                        <asp:Label ID="lblRole" runat="server" Text="Role:" CssClass="form-label" />
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Select Role" Value="" />
                            <asp:ListItem Text="Student" Value="1" />
                            <asp:ListItem Text="Faculty" Value="2" />
                            <asp:ListItem Text="Admin" Value="3" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblUsername" runat="server" Text="Username:" CssClass="form-label" />
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblPassword" runat="server" Text="Password:" CssClass="form-label" />
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" />
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblFullName" runat="server" Text="Full Name:" CssClass="form-label" />
                        <asp:TextBox ID="txtFullName" runat="server" CssClass="form-control" />
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblEmail" runat="server" Text="Email:" CssClass="form-label" />
                        <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" />
                    </div>
                    <asp:Button ID="btnAddUser" runat="server" Text="Add User" CssClass="btn btn-primary" OnClick="btnAddUser_Click" />
                    <a href="AdminDashboard.aspx" class="btn btn-secondary ms-2">Back to Dashboard</a>
                </div>
            </div>
            <div class="card">
                <div class="card-header bg-danger text-white">
                    <i class="fa-solid fa-user-minus"></i> Remove User
                </div>
                <div class="card-body">
                    <asp:Label ID="lblRemoveMessage" runat="server" CssClass="text-danger" />
                    <div class="mb-3">
                        <asp:Label ID="lblRemoveUsername" runat="server" Text="Username:" CssClass="form-label" />
                        <asp:TextBox ID="txtRemoveUsername" runat="server" CssClass="form-control" />
                    </div>
                    <asp:Button ID="btnRemoveUser" runat="server" Text="Remove User" CssClass="btn btn-danger" OnClick="btnRemoveUser_Click" />
                </div>
            </div>
        </div>
    </form>
</body>
</html>