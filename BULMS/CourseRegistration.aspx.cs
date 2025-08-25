using System;
using System.Linq;
using System.Web.UI.WebControls;
using System.Configuration;

namespace BULMS
{
    public partial class CourseRegistration : System.Web.UI.Page
    {
        private string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Only allow logged-in students
            if (Session["UserID"] == null || Session["RoleID"] == null || Session["RoleID"].ToString() != "1")
            {
                Response.Redirect("Login.aspx");
                return;
            }

            if (!IsPostBack)
            {
                LoadSemesters();
                gvOfferedCourses.DataSource = null;
                gvOfferedCourses.DataBind();
            }
        }

        private void LoadSemesters()
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

        protected void ddlSemester_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadOfferedCourses();
        }

        private void LoadOfferedCourses()
        {
            if (ddlSemester.SelectedIndex == 0)
            {
                gvOfferedCourses.DataSource = null;
                gvOfferedCourses.DataBind();
                return;
            }

            int selectedSemesterId = Convert.ToInt32(ddlSemester.SelectedValue);

            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                var courses = from co in db.CourseOfferings
                              join c in db.Courses on co.CourseID equals c.CourseID
                              join f in db.Users on co.FacultyID equals f.UserID
                              where co.SemesterID == selectedSemesterId
                              select new
                              {
                                  co.OfferingID,
                                  c.CourseName,
                                  FacultyName = f.FullName
                              };

                gvOfferedCourses.DataSource = courses.ToList();
                gvOfferedCourses.DataBind();
            }
        }

        protected void gvOfferedCourses_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Register")
            {
                int rowIndex = Convert.ToInt32(e.CommandArgument);
                int offeringId = Convert.ToInt32(gvOfferedCourses.DataKeys[rowIndex].Value);
                int userId = Convert.ToInt32(Session["UserID"]);

                using (var db = new BULMSDataClassesDataContext(connStr))
                {
                    var offering = db.CourseOfferings.FirstOrDefault(o => o.OfferingID == offeringId);
                    if (offering == null)
                        return;

                    // Prevent duplicate registration
                    bool alreadyRegistered = db.CourseRegistrations.Any(r => r.UserID == userId && r.CourseID == offering.CourseID && r.SemesterID == offering.SemesterID);
                    if (alreadyRegistered)
                    {
                        // Optionally show a message
                        return;
                    }

                    // Register the student
                    CourseRegistration reg = new CourseRegistration
                    {
                        UserID = userId,
                        CourseID = offering.CourseID,
                        SemesterID = offering.SemesterID
                    };
                    db.CourseRegistrations.InsertOnSubmit(reg);
                    db.SubmitChanges();

                    // Optionally show a success message

                    // Refresh courses after registration
                    LoadOfferedCourses();
                }
            }
        }
    }
}