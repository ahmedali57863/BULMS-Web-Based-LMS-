using System;

namespace BULMS
{
    public partial class FacultyDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect if not logged in or not a faculty
            if (Session["RoleID"] == null || Session["RoleID"].ToString() != "2") // 2 = Faculty RoleID
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