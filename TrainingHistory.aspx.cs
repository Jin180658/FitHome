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
        // Grabs the connection string from your Web.config file
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDBConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                BindGrid();
            }
        }

        private void BindGrid()
        {
            // Simulate User Session
            int currentUserId = 1; // Replace with: Convert.ToInt32(Session["UserID"]);

            /* --- UNCOMMENT THIS WHEN DATABASE IS CONNECTED ---
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
            */

            // --- TEMPORARY DUMMY DATA FOR TESTING THE UI ---
            // Delete this block once your database is connected
            DataTable dummyData = new DataTable();
            dummyData.Columns.Add("ProgressID");
            dummyData.Columns.Add("Title");
            dummyData.Columns.Add("Category");
            dummyData.Columns.Add("DateCompleted", typeof(DateTime));
            dummyData.Rows.Add(1, "15-Minute Morning Yoga", "Yoga", DateTime.Now.AddDays(-1));
            dummyData.Rows.Add(2, "Full Body HIIT", "Cardio", DateTime.Now.AddDays(-3));
            dummyData.Rows.Add(3, "Core Strength Basics", "Strength", DateTime.Now.AddDays(-5));

            gvTrainingHistory.DataSource = dummyData;
            gvTrainingHistory.DataBind();
        }

        protected void gvTrainingHistory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Get the ProgressID of the row that was clicked
                int progressId = Convert.ToInt32(gvTrainingHistory.DataKeys[e.RowIndex].Value);
                int currentUserId = 1; // Replace with session ID

                /* --- UNCOMMENT THIS WHEN DATABASE IS CONNECTED ---
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
                */

                lblStatus.Text = "✅ Workout record deleted successfully!";
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-success";

                // Refresh the grid to show the updated list
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