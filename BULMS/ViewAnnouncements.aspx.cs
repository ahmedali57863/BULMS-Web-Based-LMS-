using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class ViewAnnouncements : System.Web.UI.Page
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
            LoadAnnouncements();
        }

        private void LoadAnnouncements()
        {
            if (ddlCourses.SelectedIndex <= 0)
            {
                gvAnnouncements.DataSource = null;
                gvAnnouncements.DataBind();
                return;
            }

            int courseId = Convert.ToInt32(ddlCourses.SelectedValue);
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var announcements = from a in db.Announcements
                                    join f in db.Users on a.FacultyID equals f.UserID
                                    where a.CourseID == courseId
                                    orderby a.DatePosted descending
                                    select new
                                    {
                                        a.Message,
                                        FacultyName = f.FullName,
                                        a.DatePosted
                                    };

                gvAnnouncements.DataSource = announcements.ToList();
                gvAnnouncements.DataBind();
            }
        }
    }
}