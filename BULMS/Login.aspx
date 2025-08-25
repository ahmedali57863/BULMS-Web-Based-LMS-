<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="BULMS.Login" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>BULMS Login</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700|Pacifico&display=swap" rel="stylesheet" />
    <style>
        body {
            min-height: 100vh;
            margin: 0;
            font-family: 'Montserrat', Arial, sans-serif;
            background: linear-gradient(120deg, #a1c4fd 0%, #c2e9fb 100%);
            position: relative;
            overflow-x: hidden;
        }
        body::before {
            content: '';
            position: fixed;
            top: 0; left: 0; right: 0; bottom: 0;
            background: url('https://www.transparenttextures.com/patterns/diamond-upholstery.png');
            opacity: 0.12;
            z-index: 0;
        }
        .main-container {
            display: flex;
            min-height: 100vh;
            position: relative;
            z-index: 1;
        }
        .left-panel {
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: flex-end;
            padding: 0 5vw;
        }
        .form-box {
            width: 100%;
            max-width: 410px;
            background: rgba(255,255,255,0.75);
            border-radius: 2rem;
            box-shadow: 0 8px 40px rgba(0,0,0,0.13), 0 0 0 2px #a1c4fd;
            backdrop-filter: blur(8px);
            border: 1.5px solid rgba(160,200,255,0.25);
            padding: 2.5rem 2rem 2rem 2rem;
            position: relative;
            transition: box-shadow 0.2s;
        }
        .form-box:hover {
            box-shadow: 0 12px 48px rgba(0,0,0,0.18), 0 0 0 3px #4ea8de;
        }
        .form-title {
            font-family: 'Pacifico', cursive;
            font-size: 2.3rem;
            font-weight: 700;
            color: #2779bd;
            letter-spacing: 1px;
            margin-bottom: 0.3rem;
            text-shadow: 0 2px 8px rgba(160,200,255,0.13);
        }
        .form-subtitle {
            color: #4ea8de;
            margin-bottom: 2rem;
            font-size: 1.1rem;
            font-weight: 500;
            letter-spacing: 0.5px;
        }
        .form-label {
            font-weight: 600;
            color: #22223b;
            margin-bottom: 0.2rem;
        }
        .form-control, .form-select {
            border: none;
            border-bottom: 2px solid #b5c7f7;
            border-radius: 0;
            box-shadow: none;
            font-size: 1rem;
            margin-bottom: 1.2rem;
            background: transparent;
            transition: border-color 0.2s;
        }
        .form-control:focus, .form-select:focus {
            border-bottom: 2.5px solid #2779bd;
            outline: none;
            box-shadow: 0 2px 8px #a1c4fd33;
        }
        .btn-login {
            background: linear-gradient(90deg, #4ea8de 0%, #a1c4fd 100%);
            color: #fff;
            border: none;
            border-radius: 2rem;
            padding: 0.7rem 0;
            font-size: 1.15rem;
            font-weight: 700;
            width: 100%;
            margin-top: 1.2rem;
            box-shadow: 0 2px 12px #4ea8de33;
            transition: background 0.2s, box-shadow 0.2s;
            letter-spacing: 0.5px;
        }
        .btn-login:hover {
            background: linear-gradient(90deg, #2779bd 0%, #4ea8de 100%);
            box-shadow: 0 4px 24px #2779bd33;
        }
        .message-label {
            color: #e63946;
            text-align: center;
            margin-top: 1rem;
            font-size: 1rem;
        }
        .right-panel {
            flex: 1;
            display: flex;
            align-items: center;
            justify-content: center;
            background: none;
        }
        .illustration-img {
            max-width: 90%;
            height: auto;
            filter: drop-shadow(0 8px 32px #4ea8de33);
            transition: transform 0.3s;
        }
        .illustration-img:hover {
            transform: scale(1.04) rotate(-2deg);
        }
        @media (max-width: 900px) {
            .main-container {
                flex-direction: column;
            }
            .left-panel, .right-panel {
                flex: none;
                width: 100%;
                padding: 2rem 1rem;
                justify-content: center;
                align-items: center;
            }
            .form-box {
                max-width: 100%;
            }
            .illustration-img {
                max-width: 60vw;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="main-container">
            <!-- Left: Login Form -->
            <div class="left-panel">
                <div class="form-box">
                    <div class="form-title">Bahria University</div>
                    <div class="form-subtitle">
                        Welcome! Please log in to your Smart Campus Portal.
                    </div>
                    <div class="mb-3">
                        <label for="ddlRole" class="form-label">Role</label>
                        <asp:DropDownList ID="ddlRole" runat="server" CssClass="form-select" AutoPostBack="false">
                            <asp:ListItem Text="Select Role" Value="" />
                            <asp:ListItem Text="Student" Value="Student" />
                            <asp:ListItem Text="Faculty" Value="Faculty" />
                            <asp:ListItem Text="Admin" Value="Admin" />
                        </asp:DropDownList>
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblUsername" runat="server" Text="Username" CssClass="form-label" AssociatedControlID="txtUsername" />
                        <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="Enter username" />
                    </div>
                    <div class="mb-3">
                        <asp:Label ID="lblPassword" runat="server" Text="Password" CssClass="form-label" AssociatedControlID="txtPassword" />
                        <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-control" placeholder="Enter password" />
                    </div>
                    <div class="mb-3" style="display:none;">
                        <label for="ddlPlaceholder" class="form-label">&nbsp;</label>
                        <asp:DropDownList ID="ddlPlaceholder" runat="server" CssClass="form-select">
                            <asp:ListItem Text="" Value="" />
                        </asp:DropDownList>
                    </div>
                    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn btn-login" OnClick="btnLogin_Click" />
                    <asp:Label ID="lblMessage" runat="server" CssClass="message-label" />
                </div>
            </div>
            <!-- Right: Illustration -->
            <div class="right-panel">
                <img src="22.png" alt="Reading Illustration" class="illustration-img" />
            </div>
        </div>
    </form>
</body>
</html>