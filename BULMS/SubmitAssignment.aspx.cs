using System;
using System.Configuration;
using System.IO;
using System.Linq;

namespace BULMS
{
    public partial class SubmitAssignment : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["RoleID"] == null || Session["RoleID"].ToString() != "1")
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
                int userId = Convert.ToInt32(Session["UserID"]);
                var registeredCourses = (from cr in db.CourseRegistrations
                                         join c in db.Courses on cr.CourseID equals c.CourseID
                                         where cr.UserID == userId
                                         select new { c.CourseID, c.CourseName })
                                         .Distinct()
                                         .ToList();

                ddlCourses.DataSource = registeredCourses;
                ddlCourses.DataTextField = "CourseName";
                ddlCourses.DataValueField = "CourseID";
                ddlCourses.DataBind();

                ddlCourses.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select Course--", ""));
            }
        }

        protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlAssignments.Items.Clear();
            if (ddlCourses.SelectedIndex > 0)
            {
                int courseId = Convert.ToInt32(ddlCourses.SelectedValue);
                string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
                using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
                {
                    var assignments = db.Assignments.Where(a => a.CourseID == courseId).ToList();
                    ddlAssignments.DataSource = assignments;
                    ddlAssignments.DataTextField = "Title";
                    ddlAssignments.DataValueField = "AssignmentID";
                    ddlAssignments.DataBind();
                    ddlAssignments.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select Assignment--", ""));
                }
            }
        }

        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (ddlCourses.SelectedIndex == 0 || ddlAssignments.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a course and assignment.";
                return;
            }
            if (!fileUpload.HasFile)
            {
                lblMessage.Text = "Please select a file to upload.";
                return;
            }

            // --- Add validation here ---
            string[] allowedExtensions = { ".pdf", ".doc", ".docx", ".txt", ".zip", ".rar" };
            string fileExt = Path.GetExtension(fileUpload.FileName).ToLower();
            if (!allowedExtensions.Contains(fileExt))
            {
                lblMessage.Text = "File type not allowed. Allowed: " + string.Join(", ", allowedExtensions);
                return;
            }

            if (fileUpload.PostedFile.ContentLength > 20971520)
            {
                lblMessage.Text = "File is too large. Maximum allowed size is 20 MB.";
                return;
            }
            // --- End validation ---

            int userId = Convert.ToInt32(Session["UserID"]);
            int assignmentId = Convert.ToInt32(ddlAssignments.SelectedValue);

            // Save file to App_Data/Assignments (create folder if not exists)
            string folderPath = Server.MapPath("~/Assignments/");
            if (!Directory.Exists(folderPath))
                Directory.CreateDirectory(folderPath);

            string fileName = userId + "_" + assignmentId + "_" + Path.GetFileName(fileUpload.FileName);
            string filePath = folderPath + fileName;
            fileUpload.SaveAs(filePath);

            // Save the path as "~/Assignments/" + fileName in the database

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                // Check if already submitted
                var existing = db.Submissions.FirstOrDefault(s => s.AssignmentID == assignmentId && s.UserID == userId);
                if (existing != null)
                {
                    lblMessage.Text = "You have already submitted this assignment.";
                    return;
                }

                Submission sub = new Submission
                {
                    AssignmentID = assignmentId,
                    UserID = userId,
                    FilePath = "~/Assignments/" + fileName,
                    SubmissionDate = DateTime.Now,
                    Grade = null
                };
                db.Submissions.InsertOnSubmit(sub);
                db.SubmitChanges();
                lblMessage.Text = "Assignment submitted successfully!";
            }
        }
    }
}