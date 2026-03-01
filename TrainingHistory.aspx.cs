using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class TrainingHistory : System.Web.UI.Page
    {
        // Grabs the connection string from your Web.config file using your leader's exact name
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            // Simulate User Session (Hardcoded for now, switch to Session["UserID"] later)
            int currentUserId = 1;

            // SQL Query to get the user's completed courses
            string query = @"SELECT up.ProgressID, c.Title, c.Category, up.DateCompleted 
                             FROM UserProgress up 
                             INNER JOIN Courses c ON up.CourseID = c.CourseID 
                             WHERE up.UserID = @UserID 
                             ORDER BY up.DateCompleted DESC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", currentUserId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvTrainingHistory.DataSource = dt;
                        gvTrainingHistory.DataBind();
                    }
                }
            }
        }

        protected void gvTrainingHistory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Get the ProgressID of the row that was clicked
                int progressId = Convert.ToInt32(gvTrainingHistory.DataKeys[e.RowIndex].Value);
                int currentUserId = 1; // Replace with session ID later

                // SQL Query to delete the specific training record
                string query = "DELETE FROM UserProgress WHERE ProgressID = @ProgressID AND UserID = @UserID";

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@ProgressID", progressId);
                        cmd.Parameters.AddWithValue("@UserID", currentUserId);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblStatus.Text = "✅ Workout record deleted successfully!";
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-success";

                // Refresh the grid to show the updated list after deletion
                BindGrid();
            }
            catch (Exception ex)
            {
                lblStatus.Text = "❌ Error deleting record: " + ex.Message;
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-danger";
            }
        }
    }
}