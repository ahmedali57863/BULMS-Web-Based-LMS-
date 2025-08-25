using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class FacultyAnnouncements : System.Web.UI.Page
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

        protected void btnSend_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (ddlCourses.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a course.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtAnnouncement.Text))
            {
                lblMessage.Text = "Please enter an announcement.";
                return;
            }

            int courseId = Convert.ToInt32(ddlCourses.SelectedValue);
            int facultyId = Convert.ToInt32(Session["UserID"]);
            string message = txtAnnouncement.Text.Trim();

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                Announcement announcement = new Announcement
                {
                    CourseID = courseId,
                    FacultyID = facultyId,
                    Message = message,
                    DatePosted = DateTime.Now
                };
                db.Announcements.InsertOnSubmit(announcement);
                db.SubmitChanges();
                lblMessage.Text = "Announcement sent successfully!";
                txtAnnouncement.Text = "";
                ddlCourses.SelectedIndex = 0;
            }
        }
    }
}