using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class ViewFees : System.Web.UI.Page
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
                LoadFees();
            }
        }

        private void LoadFees()
        {
            lblMessage.Text = "";

            int userId = Convert.ToInt32(Session["UserID"]);
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var fees = db.Fees
                    .Where(f => f.UserID == userId)
                    .Select(f => new
                    {
                        f.Amount,
                        f.Status,
                        f.DueDate
                    }).ToList();

                if (fees.Count == 0)
                {
                    lblMessage.Text = "No fee records found.";
                }

                gvFees.DataSource = fees;
                gvFees.DataBind();
            }
        }
    }
}