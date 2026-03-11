using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.UI.WebControls;
using System.Data;

namespace FitHome
{
    public partial class TakeQuiz : System.Web.UI.Page
    {
        // Connection string
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // 1. Ensure user is logged in
            if (Session["UserID"] == null)
            {
                Response.Redirect("Login.aspx");
            }

            if (!IsPostBack)
            {
                // 2. Get the CourseID from the URL (e.g., TakeQuiz.aspx?courseId=1)
                if (Request.QueryString["courseId"] != null)
                {
                    int courseId = Convert.ToInt32(Request.QueryString["courseId"]);
                    LoadCourseInfo(courseId);
                    LoadQuestions(courseId);
                }
                else
                {
                    // Redirect back to catalog if no course ID is provided
                    Response.Redirect("CourseCatalog.aspx");
                }
            }
        }

        // Fetch course title to display in the header
        private void LoadCourseInfo(int courseId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT Title FROM Courses WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    con.Open();
                    object result = cmd.ExecuteScalar();
                    if (result != null)
                    {
                        lblCourseTitle.InnerText = "Quiz for: " + result.ToString();
                    }
                }
            }
        }

        // Fetch questions for this course
        private void LoadQuestions(int courseId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM QuizQuestions WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        // If there are no questions, hide the submit button
                        if (dt.Rows.Count == 0)
                        {
                            btnSubmit.Visible = false;
                            lblCourseTitle.InnerText = "No assessment available for this course yet.";
                        }
                        else
                        {
                            rptQuestions.DataSource = dt;
                            rptQuestions.DataBind();
                        }
                    }
                }
            }
        }

        // Safely bind the option texts (A, B, C, D) to the radio buttons during data binding
        protected void rptQuestions_ItemDataBound(object sender, RepeaterItemEventArgs e)
        {
            if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
            {
                // Get the data row for the current question
                DataRowView drv = (DataRowView)e.Item.DataItem;

                // Find the RadioButtonList control
                RadioButtonList rblOptions = (RadioButtonList)e.Item.FindControl("rblOptions");

                if (rblOptions != null)
                {
                    rblOptions.Items[0].Text = " " + drv["OptionA"].ToString();
                    rblOptions.Items[1].Text = " " + drv["OptionB"].ToString();
                    rblOptions.Items[2].Text = " " + drv["OptionC"].ToString();
                    rblOptions.Items[3].Text = " " + drv["OptionD"].ToString();
                }
            }
        }

        // Calculate score and save to database
        protected void btnSubmit_Click(object sender, EventArgs e)
        {
            int score = 0;
            int totalQuestions = rptQuestions.Items.Count;

            // Iterate through each question in the repeater to check answers
            foreach (RepeaterItem item in rptQuestions.Items)
            {
                RadioButtonList rblOptions = (RadioButtonList)item.FindControl("rblOptions");
                HiddenField hfCorrectAnswer = (HiddenField)item.FindControl("hfCorrectAnswer");

                if (rblOptions != null && hfCorrectAnswer != null)
                {
                    // Check if the user selected an option AND it matches the correct answer
                    if (rblOptions.SelectedValue != "" && rblOptions.SelectedValue == hfCorrectAnswer.Value)
                    {
                        score++;
                    }
                }
            }

            // Save the result to the QuizResults table
            SaveResultToDatabase(score, totalQuestions);

            // Hide the quiz panel and show the result panel
            pnlQuiz.Visible = false;
            pnlResult.Visible = true;

            // Display the final score
            lblScore.InnerText = $"{score} / {totalQuestions}";
        }

        // Insert the score into the QuizResults table
        private void SaveResultToDatabase(int score, int totalQuestions)
        {
            int courseId = Convert.ToInt32(Request.QueryString["courseId"]);
            int userId = Convert.ToInt32(Session["UserID"]);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO QuizResults (UserID, CourseID, Score, TotalQuestions, AttemptDate) 
                                 VALUES (@UserID, @CourseID, @Score, @TotalQuestions, GETDATE())";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    cmd.Parameters.AddWithValue("@Score", score);
                    cmd.Parameters.AddWithValue("@TotalQuestions", totalQuestions);

                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }
        }
    }
}