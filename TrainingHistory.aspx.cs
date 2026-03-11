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
        protected string GetScoreHtml(object bestScoreObj, object quizQuestionCountObj, object courseIdObj, object progressIdObj)
        {
            int questionCount = Convert.ToInt32(quizQuestionCountObj);
            if (questionCount == 0) return "<span class='text-muted small'>N/A</span>";

            if (bestScoreObj == DBNull.Value || bestScoreObj == null)
            {
                // Pass both CourseID and ProgressID to TakeQuiz.aspx
                return $"<a href='TakeQuiz.aspx?courseId={courseIdObj}&progressId={progressIdObj}' class='btn btn-sm btn-warning text-dark fw-bold rounded-pill px-3 py-1 shadow-sm' style='font-size:0.75rem;'><i class='bi bi-patch-exclamation me-1'></i>Take Quiz</a>";
            }

            int bestScore = Convert.ToInt32(bestScoreObj);
            double percentage = (double)bestScore / questionCount;
            string colorClass = percentage >= 0.5 ? "text-success bg-success border-success" : "text-danger bg-danger border-danger";

            return $"<span class='badge {colorClass} bg-opacity-10 border px-3 py-2 rounded-pill fw-bold' style='font-size:0.85rem;'><i class='bi bi-trophy-fill text-warning me-1'></i> {bestScore} / {questionCount}</span>";
        }
    }
}