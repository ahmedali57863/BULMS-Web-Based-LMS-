using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class StudentProfile : System.Web.UI.Page
    {
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
                string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
                using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
                {
                    int userId = Convert.ToInt32(Session["UserID"]);
                    var user = db.Users.FirstOrDefault(u => u.UserID == userId);
                    if (user != null)
                    {
                        lblWelcome.Text = "Welcome, " + user.FullName + "!";
                        lblFullName.Text = user.FullName;
                        lblUsername.Text = user.Username;
                        lblEmail.Text = user.Email;
                    }
                }
            }
        }
    }
}