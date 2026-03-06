using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class TrainingHistory : System.Web.UI.Page
    {
        // Retrieve connection string from Web.config
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is authenticated; if not, redirect to Login page
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Load the workout history grid on first page load
                BindGrid();
            }
        }

        // Fetch workout records and bind them to the GridView
        private void BindGrid()
        {
            // Use the current authenticated UserID from the session
            string currentUserId = Session["UserID"].ToString();

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

                        // Bind the data to the GridView control
                        gvTrainingHistory.DataSource = dt;
                        gvTrainingHistory.DataBind();

                        // Calculate and display the total number of workouts in the stats card
                        lblTotalWorkouts.Text = dt.Rows.Count.ToString();
                    }
                }
            }
        }

        // Handle the deletion of a specific workout record
        protected void gvTrainingHistory_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            try
            {
                // Retrieve the unique ID of the record to be deleted
                int progressId = Convert.ToInt32(gvTrainingHistory.DataKeys[e.RowIndex].Value);
                string currentUserId = Session["UserID"].ToString();

                // Ensure the user can only delete their own records for security
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

                // Update UI feedback for a successful deletion
                lblStatus.Text = "Workout record removed successfully.";
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-success";

                // Refresh the grid and stats to reflect the changes
                BindGrid();
            }
            catch (Exception ex)
            {
                // Display error message if the deletion fails
                lblStatus.Text = "Error removing record.";
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-danger";
            }
        }
    }
}