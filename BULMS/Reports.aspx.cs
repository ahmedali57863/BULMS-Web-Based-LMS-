using System;
using System.Linq;

namespace BULMS
{
    public partial class Reports : System.Web.UI.Page
    {
        private string connStr = System.Configuration.ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                ddlSemester.Visible = false;
                ddlStudent.Visible = false;
                btnViewReport.Visible = false;
                LoadSemesters();
                LoadStudents();
            }
        }

        protected void ddlReportType_SelectedIndexChanged(object sender, EventArgs e)
        {
            ddlSemester.Visible = false;
            ddlStudent.Visible = false;
            btnViewReport.Visible = false;

            if (ddlReportType.SelectedValue == "Fee" || ddlReportType.SelectedValue == "CourseReg")
            {
                ddlSemester.Visible = true;
                btnViewReport.Visible = true;
            }
            else if (ddlReportType.SelectedValue == "StudentCourses")
            {
                ddlSemester.Visible = true;
                ddlStudent.Visible = true;
                btnViewReport.Visible = true;
            }
        }

        protected void btnViewReport_Click(object sender, EventArgs e)
        {
            gvReport.DataSource = null;
            gvReport.DataBind();

            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                if (ddlReportType.SelectedValue == "Fee")
                {
                    int semesterId = int.Parse(ddlSemester.SelectedValue);
                    var data = from f in db.Fees
                               join u in db.Users on f.UserID equals u.UserID
                               where f.SemesterID == semesterId
                               select new
                               {
                                   u.FullName,
                                   u.Username,
                                   f.Amount,
                                   f.Status,
                                   f.DueDate
                               };
                    gvReport.DataSource = data.ToList();
                }
                else if (ddlReportType.SelectedValue == "CourseReg")
                {
                    int semesterId = int.Parse(ddlSemester.SelectedValue);
                    var data = from cr in db.CourseRegistrations
                               join c in db.Courses on cr.CourseID equals c.CourseID
                               where cr.SemesterID == semesterId
                               group cr by c.CourseName into g
                               select new
                               {
                                   Course = g.Key,
                                   RegistrationCount = g.Count()
                               };
                    gvReport.DataSource = data.ToList();
                }
                else if (ddlReportType.SelectedValue == "StudentCourses")
                {
                    int semesterId = int.Parse(ddlSemester.SelectedValue);
                    int studentId = int.Parse(ddlStudent.SelectedValue);
                    var data = from cr in db.CourseRegistrations
                               join c in db.Courses on cr.CourseID equals c.CourseID
                               where cr.SemesterID == semesterId && cr.UserID == studentId
                               select new
                               {
                                   c.CourseName
                               };
                    gvReport.DataSource = data.ToList();
                }
                gvReport.DataBind();
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
                ddlSemester.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select Semester--", "0"));
            }
        }

        private void LoadStudents()
        {
            using (var db = new BULMSDataClassesDataContext(connStr))
            {
                ddlStudent.DataSource = db.Users.Where(u => u.RoleID == 1).ToList();
                ddlStudent.DataTextField = "FullName";
                ddlStudent.DataValueField = "UserID";
                ddlStudent.DataBind();
                ddlStudent.Items.Insert(0, new System.Web.UI.WebControls.ListItem("--Select Student--", "0"));
            }
        }
    }
}