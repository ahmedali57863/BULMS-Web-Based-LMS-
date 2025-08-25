<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="BULMS.Logout" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Logging Out...</title>
    <link href="https://fonts.googleapis.com/css?family=Montserrat:400,700&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            min-height: 100vh;
            margin: 0;
            font-family: 'Montserrat', Arial, sans-serif;
            background: linear-gradient(120deg, #f8fafc 0%, #a1c4fd 100%);
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .logout-container {
            background: rgba(255,255,255,0.88);
            border-radius: 1.5rem;
            box-shadow: 0 8px 40px rgba(0,0,0,0.13);
            padding: 2.5rem 2.5rem 2rem 2.5rem;
            text-align: center;
            max-width: 350px;
            animation: fadeIn 1s;
        }
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(30px);}
            to { opacity: 1; transform: none;}
        }
        .checkmark {
            font-size: 3.5rem;
            color: #4ea8de;
            margin-bottom: 1rem;
            animation: pop 0.7s;
        }
        @keyframes pop {
            0% { transform: scale(0.5);}
            70% { transform: scale(1.2);}
            100% { transform: scale(1);}
        }
        .logout-title {
            font-size: 1.6rem;
            font-weight: 700;
            color: #2779bd;
            margin-bottom: 0.5rem;
        }
        .logout-msg {
            color: #22223b;
            font-size: 1.08rem;
            margin-bottom: 2rem;
        }
        .btn-login-again {
            background: linear-gradient(90deg, #4ea8de 0%, #a1c4fd 100%);
            color: #fff;
            border: none;
            border-radius: 2rem;
            padding: 0.7rem 2.2rem;
            font-size: 1.1rem;
            font-weight: 700;
            box-shadow: 0 2px 12px #4ea8de33;
            transition: background 0.2s, box-shadow 0.2s, transform 0.15s;
            text-decoration: none;
            display: inline-block;
        }
        .btn-login-again:hover {
            background: linear-gradient(90deg, #2779bd 0%, #4ea8de 100%);
            box-shadow: 0 4px 24px #2779bd33;
            transform: translateY(-2px) scale(1.04);
            color: #fff;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="logout-container">
            <div class="checkmark">
                <i class="fa-solid fa-circle-check"></i>
            </div>
            <div class="logout-title">You have been logged out</div>
            <div class="logout-msg">Thank you for using the Smart Campus Portal.<br />We hope to see you again soon!</div>
            <a href="Login.aspx" class="btn-login-again"><i class="fa-solid fa-arrow-right-to-bracket"></i> Login Again</a>
        </div>
    </form>
</body>
</html>