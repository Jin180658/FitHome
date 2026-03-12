using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class CreateTopic : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Security check: Prevent users from accessing this page directly without logging in
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }
            }
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string content = txtContent.Text.Trim();

            // 1. Basic form validation to prevent empty posts
            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(content))
            {
                lblMessage.Text = "❌ Title and Details cannot be empty.";
                lblMessage.CssClass = "fw-bold d-block mb-3 text-start text-danger";
                return;
            }

            string userId = Session["UserID"].ToString();

            // 2. Insert the new topic into the database (GETDATE() stores the current timestamp)
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string query = "INSERT INTO ForumTopics (UserID, Title, Content, CreatedAt) VALUES (@UserID, @Title, @Content, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Content", content);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // 3. After successful posting, redirect the user back to the community board
            Response.Redirect("CommunityBoard.aspx");
        }
    }
}