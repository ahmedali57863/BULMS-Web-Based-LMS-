using System;
using System.Configuration;
using System.Linq;

namespace BULMS
{
    public partial class FeeReport : System.Web.UI.Page
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
                LoadFeeReport();
            }
        }

        private void LoadFeeReport()
        {
            lblMessage.Text = "";
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var report = from f in db.Fees
                             join u in db.Users on f.UserID equals u.UserID
                             select new
                             {
                                 StudentName = u.FullName,
                                 f.Amount,
                                 f.Status,
                                 f.DueDate
                             };

                var reportList = report.OrderBy(r => r.StudentName).ToList();

                if (reportList.Count == 0)
                {
                    lblMessage.Text = "No fee records found.";
                }

                gvFeeReport.DataSource = reportList;
                gvFeeReport.DataBind();
            }
        }
    }
}