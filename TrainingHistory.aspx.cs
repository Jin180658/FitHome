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

            string query = @"SELECT up.ProgressID, c.CourseID, c.Title, c.Category, up.DateCompleted,
                                    (SELECT MAX(Score) FROM QuizResults qr WHERE qr.ProgressID = up.ProgressID) AS BestScore,
                                    (SELECT COUNT(*) FROM QuizQuestions qq WHERE qq.CourseID = up.CourseID) AS QuizQuestionCount
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
                int progressId = Convert.ToInt32(gvTrainingHistory.DataKeys[e.RowIndex].Value);
                string currentUserId = Session["UserID"].ToString();

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    string deleteQuizQuery = "DELETE FROM QuizResults WHERE ProgressID = @ProgressID";
                    using (SqlCommand cmdQuiz = new SqlCommand(deleteQuizQuery, conn))
                    {
                        cmdQuiz.Parameters.AddWithValue("@ProgressID", progressId);
                        cmdQuiz.ExecuteNonQuery();
                    }

                    string deleteProgressQuery = "DELETE FROM UserProgress WHERE ProgressID = @ProgressID AND UserID = @UserID";
                    using (SqlCommand cmdProg = new SqlCommand(deleteProgressQuery, conn))
                    {
                        cmdProg.Parameters.AddWithValue("@ProgressID", progressId);
                        cmdProg.Parameters.AddWithValue("@UserID", currentUserId);
                        cmdProg.ExecuteNonQuery();
                    }
                }

                lblStatus.Text = "Workout record and associated quiz results removed successfully.";
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-success";
                BindGrid();
            }
            catch (Exception ex)
            {
                lblStatus.Text = "Error removing record.";
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-danger";
            }
        }

        // --- NEW FEATURE: Dynamic HTML generator for Assessment Score ---
        // --- Dynamic HTML generator for Assessment Score ---
        protected string GetScoreHtml(object bestScoreObj, object totalQsObj, object courseIdObj, object progressIdObj)
        {
            // Define base CSS classes for consistent visual appearance (pill shape, padding, fixed minimum width)
            string baseCss = "badge rounded-pill px-3 py-2 text-decoration-none d-inline-block";
            string style = "min-width: 105px; font-size: 0.85rem;";

            // Parse the total number of questions for the course
            int totalQs = totalQsObj != DBNull.Value ? Convert.ToInt32(totalQsObj) : 0;

            // Case 1: No quiz questions exist for this course
            if (totalQs == 0)
            {
                // Render N/A badge: Light gray background, gray text, dash icon
                return $"<span class=\"{baseCss} bg-secondary bg-opacity-10 text-secondary\" style=\"{style}\">" +
                       $"<i class=\"bi bi-dash-circle me-1\"></i> N/A</span>";
            }

            // Case 2: Quiz exists, but the user has not attempted it yet
            if (bestScoreObj == DBNull.Value || bestScoreObj == null)
            {
                int courseId = Convert.ToInt32(courseIdObj);
                int progressId = Convert.ToInt32(progressIdObj);

                // Render Take Quiz CTA: Light blue background, blue text, pencil icon
                string url = $"TakeQuiz.aspx?courseId={courseId}&progressId={progressId}";
                return $"<a href=\"{url}\" class=\"{baseCss} bg-primary bg-opacity-10 text-primary\" style=\"{style}\">" +
                       $"<i class=\"bi bi-pencil-square me-1\"></i> Take Quiz</a>";
            }

            // Case 3: User has attempted the quiz, parse and evaluate their best score
            int score = Convert.ToInt32(bestScoreObj);

            // Determine if the user passed (score >= 50%) to dynamically apply green or red color themes
            string colorClass = (score >= totalQs / 2.0) ? "bg-success bg-opacity-10 text-success" : "bg-danger bg-opacity-10 text-danger";

            // Render Score badge: Green/Red background based on result, trophy icon
            return $"<span class=\"{baseCss} {colorClass}\" style=\"{style}\">" +
                   $"<i class=\"bi bi-trophy me-1\"></i> {score} / {totalQs}</span>";
        }
    }
}