<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewFees.aspx.cs" Inherits="BULMS.ViewFees" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Fees - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .fees-container {
            max-width: 600px;
            margin: 3rem auto;
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(0,0,0,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
        }
        .fees-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .fees-header .fa-money-check-dollar {
            font-size: 2.2rem;
            color: #0dcaf0;
        }
        .fees-header h3 {
            font-weight: 700;
            margin: 0;
            color: #22223b;
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
        .table thead th {
            background: #e0e7ff;
            color: #0dcaf0;
            font-weight: 600;
            border-top: none;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        @media (max-width: 700px) {
            .fees-container {
                padding: 1.2rem 0.5rem;
            }
            .fees-header h3 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="fees-container">
            <div class="fees-header">
                <i class="fa-solid fa-money-check-dollar"></i>
                <h3>Fee Details</h3>
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger" />
            <asp:GridView ID="gvFees" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover align-middle mt-3" HeaderStyle-CssClass="table-light" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="Amount" HeaderText="Amount" DataFormatString="{0:C}" />
                    <asp:BoundField DataField="Status" HeaderText="Status" />
                    <asp:BoundField DataField="DueDate" HeaderText="Due Date" DataFormatString="{0:yyyy-MM-dd}" />
                </Columns>
            </asp:GridView>
            <a href="StudentDashboard.aspx" class="btn btn-back mt-3"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </form>
</body>
</html>