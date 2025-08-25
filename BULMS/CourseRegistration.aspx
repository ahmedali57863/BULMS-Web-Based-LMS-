<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="CourseRegistration.aspx.cs" Inherits="BULMS.CourseRegistration" %>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Course Registration</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .registration-container {
            max-width: 700px;
            margin: 3rem auto;
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(0,0,0,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
        }
        .registration-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 2rem;
        }
        .registration-header .fa-book-open {
            font-size: 2.2rem;
            color: #4ea8de;
        }
        .registration-header h2 {
            font-weight: 700;
            margin: 0;
            color: #22223b;
        }
        .semester-row {
            margin-bottom: 1.5rem;
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
            color: #4ea8de;
            font-weight: 600;
            border-top: none;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        @media (max-width: 700px) {
            .registration-container {
                padding: 1.2rem 0.5rem;
            }
            .registration-header h2 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="registration-container">
            <div class="registration-header">
                <i class="fa-solid fa-book-open"></i>
                <h2>Course Registration</h2>
            </div>
            <div class="semester-row row align-items-center mb-3">
                <div class="col-auto fw-semibold" style="color:#4ea8de;">
                    <i class="fa-solid fa-calendar-days"></i> Semester:
                </div>
                <div class="col">
                    <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlSemester_SelectedIndexChanged" />
                </div>
            </div>
            <asp:GridView ID="gvOfferedCourses" runat="server" AutoGenerateColumns="False" DataKeyNames="OfferingID" OnRowCommand="gvOfferedCourses_RowCommand"
                CssClass="table table-bordered table-hover align-middle" HeaderStyle-CssClass="table-light" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="CourseName" HeaderText="Course" />
                    <asp:BoundField DataField="FacultyName" HeaderText="Faculty" />
                    <asp:ButtonField ButtonType="Button" CommandName="Register" Text="Register" />
                </Columns>
            </asp:GridView>
            <a href="StudentDashboard.aspx" class="btn btn-back mt-3"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </form>
</body>
</html> 