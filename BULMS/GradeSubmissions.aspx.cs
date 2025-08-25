using System;
using System.Configuration;
using System.IO;
using System.Linq;
using System.Web.UI.WebControls;

namespace BULMS
{
    public partial class GradeSubmissions : System.Web.UI.Page
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
                LoadSubmissions();
            }
        }

        private void LoadSubmissions()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                int facultyId = Convert.ToInt32(Session["UserID"]);
                var submissions = from s in db.Submissions
                                  join a in db.Assignments on s.AssignmentID equals a.AssignmentID
                                  join c in db.Courses on a.CourseID equals c.CourseID
                                  join u in db.Users on s.UserID equals u.UserID
                                  where c.FacultyID == facultyId
                                  select new
                                  {
                                      s.SubmissionID,
                                      CourseName = c.CourseName,
                                      AssignmentTitle = a.Title,
                                      StudentName = u.FullName,
                                      SubmissionDate = s.SubmissionDate,
                                      FilePath = s.FilePath,
                                      FileName = Path.GetFileName(s.FilePath),
                                      Grade = s.Grade ?? ""
                                  };

                gvSubmissions.DataSource = submissions.ToList();
                gvSubmissions.DataBind();
            }
        }

        protected void gvSubmissions_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "SaveGrade")
            {
                int submissionId = Convert.ToInt32(e.CommandArgument);
                GridViewRow row = ((Button)e.CommandSource).NamingContainer as GridViewRow;
                TextBox txtGrade = (TextBox)row.FindControl("txtGrade");
                string grade = txtGrade.Text.Trim();

                string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
                using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
                {
                    var submission = db.Submissions.FirstOrDefault(s => s.SubmissionID == submissionId);
                    if (submission != null)
                    {
                        submission.Grade = grade;
                        db.SubmitChanges();
                        lblMessage.Text = "Grade saved!";
                    }
                }
                LoadSubmissions();
            }
        }
    }
}