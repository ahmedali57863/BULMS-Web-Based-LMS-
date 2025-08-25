<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubmitAssignment.aspx.cs" Inherits="BULMS.SubmitAssignment" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Submit Assignment - BULMS</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.2/css/all.min.css" rel="stylesheet" />
    <style>
        body {
            background: linear-gradient(135deg, #e0e7ff 0%, #f8fafc 100%);
            min-height: 100vh;
            font-family: 'Segoe UI', Arial, sans-serif;
        }
        .submit-container {
            max-width: 500px;
            margin: 3rem auto;
            background: #fff;
            border-radius: 1.5rem;
            box-shadow: 0 6px 32px rgba(0,0,0,0.10);
            padding: 2.5rem 2rem 2rem 2rem;
        }
        .submit-header {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.5rem;
        }
        .submit-header .fa-upload {
            font-size: 2.2rem;
            color: #fbbf24;
        }
        .submit-header h3 {
            font-weight: 700;
            margin: 0;
            color: #22223b;
        }
        .form-label {
            font-weight: 500;
            color: #22223b;
        }
        .btn-submit {
            background: #fbbf24;
            color: #22223b;
            border: none;
            border-radius: 2rem;
            padding: 0.6rem 1.5rem;
            font-size: 1.08rem;
            font-weight: 600;
            box-shadow: 0 2px 8px rgba(251,191,36,0.08);
            transition: background 0.2s;
        }
        .btn-submit:hover {
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
            box-shadow: 0 2px 8px rgba(78,168,222,0.08);
            transition: background 0.2s;
            text-decoration: none;
        }
        .btn-back:hover {
            background: #2779bd;
            color: #fff;
        }
        @media (max-width: 600px) {
            .submit-container {
                padding: 1.2rem 0.5rem;
            }
            .submit-header h3 {
                font-size: 1.3rem;
            }
        }
    </style>
</head>
<body>
    <form id="form1" runat="server" enctype="multipart/form-data">
        <div class="submit-container">
            <div class="submit-header">
                <i class="fa-solid fa-upload"></i>
                <h3>Submit Assignment</h3>
            </div>
            <asp:Label ID="lblMessage" runat="server" CssClass="text-danger mb-2 d-block" />
            <div class="mb-3">
                <asp:Label ID="lblCourse" runat="server" Text="Select Course:" CssClass="form-label" />
                <asp:DropDownList ID="ddlCourses" runat="server" CssClass="form-select" AutoPostBack="true" OnSelectedIndexChanged="ddlCourses_SelectedIndexChanged" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblAssignment" runat="server" Text="Select Assignment:" CssClass="form-label" />
                <asp:DropDownList ID="ddlAssignments" runat="server" CssClass="form-select" />
            </div>
            <div class="mb-3">
                <asp:Label ID="lblFile" runat="server" Text="Upload File:" CssClass="form-label" />
                <asp:FileUpload ID="fileUpload" runat="server" CssClass="form-control" />
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit Assignment" CssClass="btn btn-submit" OnClick="btnSubmit_Click" />
            <a href="StudentDashboard.aspx" class="btn btn-back ms-2"><i class="fa-solid fa-arrow-left"></i> Back to Dashboard</a>
        </div>
    </form>
    <script>
        document.getElementById('<%= btnSubmit.ClientID %>').onclick = function (e) {
            var fileInput = document.getElementById('<%= fileUpload.ClientID %>');
        var lblMessage = document.getElementById('<%= lblMessage.ClientID %>');
            lblMessage.innerText = "";

            if (!fileInput.value) {
                lblMessage.innerText = "Please select a file to upload.";
                e.preventDefault();
                return false;
            }

            // Allowed extensions
            var allowedExtensions = [".pdf", ".doc", ".docx", ".txt", ".zip", ".rar"];
            var fileName = fileInput.value.toLowerCase();
            var validExt = allowedExtensions.some(function (ext) { return fileName.endsWith(ext); });
            if (!validExt) {
                lblMessage.innerText = "File type not allowed. Allowed: " + allowedExtensions.join(", ");
                e.preventDefault();
                return false;
            }

            // File size (in bytes): 20MB = 20*1024*1024 = 20971520
            if (fileInput.files[0].size > 20971520) {
                lblMessage.innerText = "File is too large. Maximum allowed size is 20 MB.";
                e.preventDefault();
                return false;
            }
        };
    </script>
</body>
</html> 