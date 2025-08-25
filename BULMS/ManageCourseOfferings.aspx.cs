using System;
using System.Linq;
using System.Web.UI.WebControls;
using System.Configuration;

namespace BULMS
{
    public partial class ManageCourseOfferings : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadSemesters();
                LoadCourses();
                LoadFaculty();
                gvOfferings.DataSource = null;
                gvOfferings.DataBind();
            }
        }

        void LoadSemesters()
        {
            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                ddlSemester.DataSource = db.Semesters.ToList();
                ddlSemester.DataTextField = "SemesterName";
                ddlSemester.DataValueField = "SemesterID";
                ddlSemester.DataBind();
                ddlSemester.Items.Insert(0, new ListItem("Select Semester", "0"));
            }
        }

        void LoadCourses()
        {
            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                ddlCourse.DataSource = db.Courses.ToList();
                ddlCourse.DataTextField = "CourseName";
                ddlCourse.DataValueField = "CourseID";
                ddlCourse.DataBind();
                ddlCourse.Items.Insert(0, new ListItem("Select Course", "0"));
            }
        }

        void LoadFaculty()
        {
            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                // Assuming RoleID for Faculty is 2 (change if different)
                ddlFaculty.DataSource = db.Users.Where(u => u.RoleID == 2).ToList();
                ddlFaculty.DataTextField = "FullName";
                ddlFaculty.DataValueField = "UserID";
                ddlFaculty.DataBind();
                ddlFaculty.Items.Insert(0, new ListItem("Select Faculty", "0"));
            }
        }

        protected void ddlSemester_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadOfferings();
        }

        protected void btnAddOffering_Click(object sender, EventArgs e)
        {
            int semesterId = int.Parse(ddlSemester.SelectedValue);
            int courseId = int.Parse(ddlCourse.SelectedValue);
            int facultyId = int.Parse(ddlFaculty.SelectedValue);

            if (semesterId == 0 || courseId == 0 || facultyId == 0)
            {
                // Optionally show a message to select all fields
                return;
            }

            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                // Prevent duplicate offering
                var exists = db.CourseOfferings.Any(o => o.SemesterID == semesterId && o.CourseID == courseId);
                if (!exists)
                {
                    var offering = new CourseOffering
                    {
                        SemesterID = semesterId,
                        CourseID = courseId,
                        FacultyID = facultyId
                    };
                    db.CourseOfferings.InsertOnSubmit(offering);
                    db.SubmitChanges();
                    LoadOfferings();
                }
                else
                {
                    // Optionally show a message: already offered
                }
            }
        }

        void LoadOfferings()
        {
            int semesterId = int.Parse(ddlSemester.SelectedValue);
            if (semesterId == 0)
            {
                gvOfferings.DataSource = null;
                gvOfferings.DataBind();
                return;
            }

            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                var data = from o in db.CourseOfferings
                           join c in db.Courses on o.CourseID equals c.CourseID
                           join s in db.Semesters on o.SemesterID equals s.SemesterID
                           join f in db.Users on o.FacultyID equals f.UserID
                           where o.SemesterID == semesterId
                           select new
                           {
                               o.OfferingID,
                               s.SemesterName,
                               c.CourseName,
                               FacultyName = f.FullName
                           };
                gvOfferings.DataSource = data.ToList();
                gvOfferings.DataBind();
            }
        }

        protected void gvOfferings_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int offeringId = (int)gvOfferings.DataKeys[e.RowIndex].Value;
            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                var offering = db.CourseOfferings.SingleOrDefault(o => o.OfferingID == offeringId);
                if (offering != null)
                {
                    db.CourseOfferings.DeleteOnSubmit(offering);
                    db.SubmitChanges();
                    LoadOfferings();
                }
            }
        }
    }
}