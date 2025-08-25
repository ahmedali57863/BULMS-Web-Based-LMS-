using System;
using System.IO;
using System.Linq;
using System.Configuration;

namespace BULMS
{
    public partial class UploadFeeReceipt : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadStudents();
                LoadReceipts();
            }
        }

        private void LoadStudents()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var students = db.Users.Where(u => u.RoleID == 1) // 1 = Student
                    .Select(u => new { u.UserID, u.Username }).ToList();
                ddlStudents.DataSource = students;
                ddlStudents.DataTextField = "Username";
                ddlStudents.DataValueField = "UserID";
                ddlStudents.DataBind();
            }
        }

        private void LoadReceipts()
        {
            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var receipts = from r in db.FeeReceipts
                               join s in db.Users on r.StudentID equals s.UserID
                               select new
                               {
                                   r.ReceiptID,
                                   StudentName = s.Username,
                                   r.Amount,
                                   r.Status,
                                   r.DateUploaded,
                                   r.ReceiptPath
                               };
                gvReceipts.DataSource = receipts.ToList();
                gvReceipts.DataBind();
            }
        }

        protected void btnUpload_Click(object sender, EventArgs e)
        {
            if (ddlStudents.SelectedValue == "" || txtAmount.Text == "" || ddlStatus.SelectedValue == "")
            {
                lblMessage.Text = "Please fill all fields.";
                return;
            }

            string filePath = null;
            if (fuReceipt.HasFile)
            {
                string folder = Server.MapPath("~/FeeReceipts/");
                if (!Directory.Exists(folder))
                    Directory.CreateDirectory(folder);

                string fileName = Guid.NewGuid().ToString() + Path.GetExtension(fuReceipt.FileName);
                filePath = "FeeReceipts/" + fileName;
                fuReceipt.SaveAs(Path.Combine(folder, fileName));
            }

            string connStr = ConfigurationManager.ConnectionStrings["BULMSConnectionString"].ConnectionString;
            using (BULMSDataClassesDataContext db = new BULMSDataClassesDataContext(connStr))
            {
                var receipt = new FeeReceipt
                {
                    StudentID = int.Parse(ddlStudents.SelectedValue),
                    Amount = decimal.Parse(txtAmount.Text),
                    ReceiptPath = filePath,
                    Status = ddlStatus.SelectedValue,
                    DateUploaded = DateTime.Now
                };
                db.FeeReceipts.InsertOnSubmit(receipt);
                db.SubmitChanges();
            }

            lblMessage.Text = "Receipt uploaded successfully!";
            txtAmount.Text = "";
            LoadReceipts();
        }
    }
}