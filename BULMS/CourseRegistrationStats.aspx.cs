using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class CourseRegistrationStats : System.Web.UI.Page
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
                LoadStats();
            }
        }

        private void LoadStats()
        {
            lblMessage.Text = "";
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var stats = from cr in db.CourseRegistrations
                            join c in db.Courses on cr.CourseID equals c.CourseID
                            group cr by c.CourseName into g
                            select new
                            {
                                CourseName = g.Key,
                                TotalRegistrations = g.Count()
                            };

                var statsList = stats.OrderBy(s => s.CourseName).ToList();

                if (statsList.Count == 0)
                {
                    lblMessage.Text = "No course registrations found.";
                }

                gvStats.DataSource = statsList;
                gvStats.DataBind();
            }
        }
    }
}