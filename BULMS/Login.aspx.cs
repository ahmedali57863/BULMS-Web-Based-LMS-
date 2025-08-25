using System;
using System.Linq;
using System.Configuration;

namespace BULMS
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Clear any previous session
            Session.Clear();
        }

        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // Get the connection string from Web.config
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;

            // Pass the connection string to the DataContext constructor
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                // For demo: password is plain text. For real apps, use hashing!
                var user = db.Users.FirstOrDefault(u => u.Username == txtUsername.Text && u.PasswordHash == txtPassword.Text);
                if (user != null)
                {
                    // Get role name from database
                    var role = db.Roles.FirstOrDefault(r => r.RoleID == user.RoleID);
                    if (role != null)
                    {
                        // Get selected role from dropdown
                        string selectedRole = ddlRole.SelectedValue; // Make sure your dropdown's ID is ddlRole

                        if (role.RoleName.Equals(selectedRole, StringComparison.OrdinalIgnoreCase))
                        {
                            // Store user info in session
                            Session["UserID"] = user.UserID;
                            Session["RoleID"] = user.RoleID;
                            Session["Username"] = user.Username;

                            // Redirect based on role
                            if (role.RoleName == "Student")
                                Response.Redirect("StudentDashboard.aspx");
                            else if (role.RoleName == "Faculty")
                                Response.Redirect("FacultyDashboard.aspx");
                            else if (role.RoleName == "Admin")
                                Response.Redirect("AdminDashboard.aspx");
                            else
                                lblMessage.Text = "Unknown role.";
                        }
                        else
                        {
                            lblMessage.Text = "Selected role does not match your account role.";
                        }
                    }
                    else
                    {
                        lblMessage.Text = "Role not found.";
                    }
                }
                else
                {
                    lblMessage.Text = "Invalid username or password.";
                }
            }
        }
    }
}


