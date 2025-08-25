using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class AddUser : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] == null || Session["RoleID"] == null || Session["RoleID"].ToString() != "3")
            {
                Response.Redirect("Login.aspx");
                return;
            }
        }

        protected void btnAddUser_Click(object sender, EventArgs e)
        {
            lblMessage.Text = "";
            if (ddlRole.SelectedIndex == 0)
            {
                lblMessage.Text = "Please select a role.";
                return;
            }
            if (string.IsNullOrWhiteSpace(txtUsername.Text) ||
                string.IsNullOrWhiteSpace(txtPassword.Text) ||
                string.IsNullOrWhiteSpace(txtFullName.Text) ||
                string.IsNullOrWhiteSpace(txtEmail.Text))
            {
                lblMessage.Text = "All fields are required.";
                return;
            }

            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string fullName = txtFullName.Text.Trim();
            string email = txtEmail.Text.Trim();
            int roleId = Convert.ToInt32(ddlRole.SelectedValue);

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                if (db.Users.Any(u => u.Username == username))
                {
                    lblMessage.Text = "Username already exists.";
                    return;
                }

                User user = new User
                {
                    Username = username,
                    PasswordHash = password,
                    FullName = fullName,
                    Email = email,
                    RoleID = roleId
                };
                db.Users.InsertOnSubmit(user);
                db.SubmitChanges();
                lblMessage.Text = "User added successfully!";
                txtUsername.Text = "";
                txtPassword.Text = "";
                txtFullName.Text = "";
                txtEmail.Text = "";
                ddlRole.SelectedIndex = 0;
            }
        }

        protected void btnRemoveUser_Click(object sender, EventArgs e)
        {
            lblRemoveMessage.Text = "";
            string username = txtRemoveUsername.Text.Trim();
            if (string.IsNullOrWhiteSpace(username))
            {
                lblRemoveMessage.Text = "Please enter a username to remove.";
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var user = db.Users.FirstOrDefault(u => u.Username == username);
                if (user == null)
                {
                    lblRemoveMessage.Text = "User not found.";
                    return;
                }
                db.Users.DeleteOnSubmit(user);
                db.SubmitChanges();
                lblRemoveMessage.Text = "User removed successfully!";
                txtRemoveUsername.Text = "";
            }
        }
    }
}