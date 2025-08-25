using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class ViewGrades : System.Web.UI.Page
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
                var courses = (from cr in db.CourseRegistrations
                               join c in db.Courses on cr.CourseID equals c.CourseID
                               where cr.UserID == userId
                               select new { c.CourseID, c.CourseName }).Distinct().ToList();

                ddlCourses.DataSource = courses;
                ddlCourses.DataTextField = "CourseName";
                ddlCourses.DataValueField = "CourseID";
                ddlCourses.DataBind();
                ddlCourses.Items.Insert(0, new System.Web.UI.WebControls.ListItem("Select Course", ""));
            }
        }

        protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadGrades();
        }

        private void LoadGrades()
        {
            if (ddlCourses.SelectedIndex <= 0)
            {
                gvGrades.DataSource = null;
                gvGrades.DataBind();
                return;
            }

            int userId = Convert.ToInt32(Session["UserID"]);
            int courseId = Convert.ToInt32(ddlCourses.SelectedValue);
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var grades = from s in db.Submissions
                             join a in db.Assignments on s.AssignmentID equals a.AssignmentID
                             where s.UserID == userId && a.CourseID == courseId
                             select new
                             {
                                 AssignmentNo = a.AssignmentID,
                                 AssignmentTitle = a.Title,
                                 FilePath = s.FilePath,
                                 FileName = System.IO.Path.GetFileName(s.FilePath),
                                 Remarks = a.Description,
                                 SubmissionDate = s.SubmissionDate,
                                 Grade = s.Grade ?? "Not Graded",
                                 Comments = "", // You can add a comments field in your DB if needed
                                 Deadline = a.DueDate
                             };

                gvGrades.DataSource = grades.ToList();
                gvGrades.DataBind();
            }
        }

        protected void ddlSemester_SelectedIndexChanged(object sender, EventArgs e)
        {
            // If you want to filter by semester, add logic here
        }
    }
}