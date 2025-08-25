<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ViewGrades.aspx.cs" Inherits="BULMS.ViewGrades" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>View Grades - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .grades-container {
            max-width: 950px;
            margin: 3rem auto;
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(0,0,0,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
        }
        .grades-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .grades-header .fa-clipboard-list {
            font-size: 2.2rem;
            color: #2563eb;
        }
        .grades-header h3 {
            font-weight: 700;
            margin: 0;
            color: #22223b;
            letter-spacing: 1px;
        }
        .dropdown-row {
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
            color: #2563eb;
            font-weight: 600;
            border-top: none;
        }
        .table td, .table th {
            vertical-align: middle;
        }
        @media (max-width: 900px) {
            .grades-container {
                padding: 1.2rem 0.5rem;
            }
            .grades-header h3 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="grades-container">
            <div class="grades-header">
                <i class="fa-solid fa-clipboard-list"></i>
                <h3>Assignments & Grades</h3>
            </div>
            <div class="dropdown-row row mb-3">
                <div class="col-md-4 mb-2">
                    <label class="fw-semibold" style="color:#2563eb;"><i class="fa-solid fa-calendar-days"></i> Semester:</label>
                    <asp:DropDownList ID="ddlSemester" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlSemester_SelectedIndexChanged">
                        <asp:ListItem Text="Spring-2025" Value="Spring-2025" />
                    </asp:DropDownList>
                </div>
                <div class="col-md-4 mb-2">
                    <label class="fw-semibold" style="color:#2563eb;"><i class="fa-solid fa-book-open"></i> Course:</label>
                    <asp:DropDownList ID="ddlCourses" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlCourses_SelectedIndexChanged" />
                </div>
            </div>
            <asp:GridView ID="gvGrades" runat="server" AutoGenerateColumns="False" CssClass="table table-bordered table-hover align-middle mt-3" HeaderStyle-CssClass="table-light" GridLines="None">
                <Columns>
                    <asp:BoundField DataField="AssignmentNo" HeaderText="Assign. No." />
                    <asp:BoundField DataField="AssignmentTitle" HeaderText="Title" />
                    <asp:TemplateField HeaderText="Assignment (Solution File)">
                        <ItemTemplate>
                            <a href='<%# ResolveUrl(Eval("FilePath").ToString()) %>' download='<%# Eval("FileName") %>' class="btn btn-sm btn-info" target="_blank"><i class="fa-solid fa-download"></i> Download</a>
                        </ItemTemplate>
                    </asp:TemplateField>
                    <asp:BoundField DataField="Remarks" HeaderText="Remarks" />
                    <asp:BoundField DataField="SubmissionDate" HeaderText="Added Submission" DataFormatString="{0:yyyy-MM-dd HH:mm}" />
                    <asp:BoundField DataField="Grade" HeaderText="Marks Obtained" />
                    <asp:BoundField DataField="Comments" HeaderText="Returned Submission (Comments)" />
                    <asp:BoundField DataField="Deadline" HeaderText="Deadline" DataFormatString="{0:yyyy-MM-dd}" />
                </Columns>
            </asp:GridView>
            <a href="StudentDashboard.aspx" class="btn btn-back mt-3"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </form>
</body>
</html> 