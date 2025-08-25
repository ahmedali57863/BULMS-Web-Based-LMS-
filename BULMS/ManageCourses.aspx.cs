using System;
using System.Configuration;
using System.Linq;
using System.Web.UI.WebControls;

namespace BULMS
{
    public partial class ManageCourses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["RoleID"] == null || Session["RoleID"].ToString() != "3")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadFaculty();
                LoadPrerequisites();
                LoadCourses();
            }
        }

        private void LoadFaculty()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var faculty = db.Users.Where(u => u.RoleID == 2)
                    .Select(u => new { u.UserID, u.FullName }).ToList();
                ddlFaculty.DataSource = faculty;
                ddlFaculty.DataTextField = "FullName";
                ddlFaculty.DataValueField = "UserID";
                ddlFaculty.DataBind();
                ddlFaculty.Items.Insert(0, new ListItem("Select Faculty", ""));
            }
        }

        private void LoadPrerequisites()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var courses = db.Courses.Select(c => new { c.CourseID, c.CourseName }).ToList();
                ddlPrerequisite.DataSource = courses;
                ddlPrerequisite.DataTextField = "CourseName";
                ddlPrerequisite.DataValueField = "CourseID";
                ddlPrerequisite.DataBind();
                ddlPrerequisite.Items.Insert(0, new ListItem("None", ""));
            }
        }

        private void LoadCourses()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var courses = from c in db.Courses
                              join f in db.Users on c.FacultyID equals f.UserID into facultyJoin
                              from f in facultyJoin.DefaultIfEmpty()
                              join p in db.Courses on c.PrerequisiteID equals p.CourseID into prereqJoin
                              from p in prereqJoin.DefaultIfEmpty()
                              select new
                              {
                                  c.CourseID,
                                  c.CourseName,
                                  c.FacultyID,
                                  c.PrerequisiteID,
                                  FacultyName = f != null ? f.FullName : "Not Assigned",
                                  PrerequisiteName = p != null ? p.CourseName : "None"
                              };
                gvCourses.DataSource = courses.ToList();
                gvCourses.DataBind();
            }
        }

        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (string.IsNullOrWhiteSpace(txtCourseName.Text) || ddlFaculty.SelectedIndex == 0)
            {
                lblMessage.Text = "Please enter course name and select faculty.";
                return;
            }

            string courseName = txtCourseName.Text.Trim();
            int facultyId = Convert.ToInt32(ddlFaculty.SelectedValue);
            int? prereqId = ddlPrerequisite.SelectedIndex > 0 ? (int?)Convert.ToInt32(ddlPrerequisite.SelectedValue) : null;

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                Course course = new Course
                {
                    CourseName = courseName,
                    FacultyID = facultyId,
                    PrerequisiteID = prereqId
                };
                db.Courses.InsertOnSubmit(course);
                db.SubmitChanges();
                lblMessage.Text = "Course added successfully!";
                txtCourseName.Text = "";
                ddlFaculty.SelectedIndex = 0;
                ddlPrerequisite.SelectedIndex = 0;
                LoadCourses();
                LoadPrerequisites();
            }
        }

        protected void gvCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;
            LoadCourses();
        }

        protected void gvCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;
            LoadCourses();
        }

        protected void gvCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);
            string courseName = ((TextBox)gvCourses.Rows[e.RowIndex].Cells[1].Controls[0]).Text;

            TextBox txtEditFaculty = (TextBox)gvCourses.Rows[e.RowIndex].FindControl("txtEditFaculty");
            TextBox txtEditPrerequisite = (TextBox)gvCourses.Rows[e.RowIndex].FindControl("txtEditPrerequisite");

            string facultyName = txtEditFaculty.Text.Trim();
            string prereqName = txtEditPrerequisite.Text.Trim();

            int? facultyId = null;
            int? prereqId = null;

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                // Look up faculty by name
                var faculty = db.Users.FirstOrDefault(u => u.FullName == facultyName && u.RoleID == 2);
                if (faculty != null)
                    facultyId = faculty.UserID;
                else
                {
                    lblMessage.Text = "Faculty not found.";
                    return;
                }

                // Look up prerequisite course by name
                if (!string.IsNullOrWhiteSpace(prereqName) && prereqName.ToLower() != "none")
                {
                    var prereq = db.Courses.FirstOrDefault(c => c.CourseName == prereqName);
                    if (prereq != null)
                        prereqId = prereq.CourseID;
                    else
                    {
                        lblMessage.Text = "Prerequisite course not found.";
                        return;
                    }
                }

                var course = db.Courses.FirstOrDefault(c => c.CourseID == courseId);
                if (course != null)
                {
                    course.CourseName = courseName;
                    course.FacultyID = facultyId;
                    course.PrerequisiteID = prereqId;
                    db.SubmitChanges();
                }
            }
            gvCourses.EditIndex = -1;
            LoadCourses();
        }

        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseId = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                // Prevent deletion if course is in use
                bool hasRegistrations = db.CourseRegistrations.Any(cr => cr.CourseID == courseId);
                bool hasAssignments = db.Assignments.Any(a => a.CourseID == courseId);

                if (hasRegistrations || hasAssignments)
                {
                    lblMessage.Text = "Cannot delete this course. There are students registered or assignments exist for this course.";
                    return;
                }

                var course = db.Courses.FirstOrDefault(c => c.CourseID == courseId);
                if (course != null)
                {
                    db.Courses.DeleteOnSubmit(course);
                    db.SubmitChanges();
                }
            }
            LoadCourses();
            LoadPrerequisites();
        }
    }
}