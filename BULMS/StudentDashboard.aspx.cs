using System;

namespace BULMS
{
    public partial class StudentDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect if not logged in or not a student
            if (Session["RoleID"] == null || Session["RoleID"].ToString() != "1") // 1 = Student RoleID
            {
                Response.Redirect("Login.aspx");
            }
        }
        protected void lnkLogout_Click(object sender, EventArgs e)
        {
            Response.Redirect("Logout.aspx");
        }
    }
}