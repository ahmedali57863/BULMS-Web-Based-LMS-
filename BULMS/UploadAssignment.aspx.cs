using System;
using System.Configuration;
using System.IO;
using System.Linq;

namespace BULMS
{
    public partial class UploadAssignment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["RoleID"] == null || Session["RoleID"].ToString() != "2")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadCourses();
            }
        }

        private void LoadCourses()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                int facultyId = Convert.ToInt32(Session["UserID"]);
                var courses = db.Courses.Where(c => c.FacultyID == facultyId)
                    .Select(c => new { c.CourseID, c.CourseName }).ToList();

                ddlCourses.DataSource = courses;
                ddlCourses.DataTextField = "CourseName";
                ddlCourses.DataValueField = "CourseID";
                ddlCourses.DataBind();
                ddlCourses.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Course", ""));
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (ddlCourses.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a course.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtTitle.Text))
            {
                lblMessage.Text = "Please enter an assignment title.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtDueDate.Text))
            {
                lblMessage.Text = "Please select a due date.";
                return;
            }
            if (!fileUpload.HasFile)
            {
                lblMessage.Text = "Please select a file to upload.";
                return;
            }

            // Allowed extensions
            string[] allowedExtensions = { ".pdf", ".doc", ".docx", ".txt", ".zip", ".rar" };
            string fileExt = Path.GetExtension(fileUpload.FileName).ToLower();
            if (!allowedExtensions.Contains(fileExt))
            {
                lblMessage.Text = "File type not allowed. Allowed: " + string.Join(", ", allowedExtensions);
                return;
            }

            // File size check (20 MB = 20*1024*1024)
            if (fileUpload.PostedFile.ContentLength > 20971520)
            {
                lblMessage.Text = "File is too large. Maximum allowed size is 20 MB.";
                return;
            }

            int courseId = Convert.ToInt32(ddlCourses.SelectedValue);
            string title = txtTitle.Text.Trim();
            string description = txtDescription.Text.Trim();
            DateTime dueDate;
            if (!DateTime.TryParse(txtDueDate.Text, out dueDate))
            {
                lblMessage.Text = "Invalid due date.";
                return;
            }

            // Save file to Assignments folder
            string folderPath = Server.MapPath("~/Assignments/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string fileName = courseId + "_" + DateTime.Now.Ticks + "_" + Path.GetFileName(fileUpload.FileName);
            string filePath = folderPath + fileName;
            fileUpload.SaveAs(filePath);

            string dbFilePath = "~/Assignments/" + fileName;

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                Assignment assignment = new Assignment
                {
                    CourseID = courseId,
                    Title = title,
                    Description = description,
                    DueDate = dueDate,
                    FilePath = dbFilePath
                };
                db.Assignments.InsertOnSubmit(assignment);
                db.SubmitChanges();
                lblMessage.Text = "Assignment uploaded successfully!";
                txtTitle.Text = "";
                txtDescription.Text = "";
                txtDueDate.Text = "";
                ddlCourses.SelectedIndex = 0;
            }
        }
    }
}


