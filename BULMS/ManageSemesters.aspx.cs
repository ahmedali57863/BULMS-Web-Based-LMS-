using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class ManageSemesters : System.Web.UI.Page
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
                LoadSemesters();
            }
        }

        private void LoadSemesters()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var semesters = db.Semesters.ToList();
                gvSemesters.DataSource = semesters;
                gvSemesters.DataBind();
            }
        }

        protected void btnAddSemester_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            string semesterName = txtSemesterName.Text.Trim();
            if (string.IsNullOrWhiteSpace(semesterName))
            {
                lblMessage.Text = "Please enter a semester name.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                if (db.Semesters.Any(s => s.SemesterName == semesterName))
                {
                    lblMessage.Text = "Semester already exists.";
                    return;
                }

                Semester semester = new Semester
                {
                    SemesterName = semesterName
                };
                db.Semesters.InsertOnSubmit(semester);
                db.SubmitChanges();
                lblMessage.Text = "Semester added successfully!";
                txtSemesterName.Text = "";
                LoadSemesters();
            }
        }
    }
}