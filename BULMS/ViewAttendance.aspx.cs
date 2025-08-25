using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class ViewAttendance : System.Web.UI.Page
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
                LoadAttendance();
            }
        }

        private void LoadAttendance()
        {
            lblMessage.Text = "";
            int facultyId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                // Get courses taught by this faculty
                var facultyCourses = db.Courses.Where(c => c.FacultyID == facultyId).Select(c => c.CourseID).ToList();

                var attendance = from a in db.Attendances
                                 join c in db.Courses on a.CourseID equals c.CourseID
                                 join s in db.Users on a.StudentID equals s.UserID
                                 where facultyCourses.Contains(a.CourseID)
                                 select new
                                 {
                                     CourseName = c.CourseName,
                                     StudentName = s.FullName,
                                     a.Date,
                                     a.Status
                                 };

                var attendanceList = attendance.OrderBy(a => a.CourseName).ThenBy(a => a.StudentName).ThenBy(a => a.Date).ToList();

                if (attendanceList.Count == 0)
                {
                    lblMessage.Text = "No attendance records found for your courses.";
                }

                gvAttendance.DataSource = attendanceList;
                gvAttendance.DataBind();
            }
        }
    }
}