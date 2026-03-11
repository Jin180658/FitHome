using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class AdminManageQuiz : System.Web.UI.Page
    {
        // Connection string
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Optional: Check if user is Admin here to prevent unauthorized access
                LoadCourses();
            }
        }

        // Load all available courses into the DropDownList
        private void LoadCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT CourseID, Title FROM Courses ORDER BY Title";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    con.Open();
                    SqlDataReader reader = cmd.ExecuteReader();

                    ddlCourses.DataSource = reader;
                    ddlCourses.DataTextField = "Title";
                    ddlCourses.DataValueField = "CourseID";
                    ddlCourses.DataBind();

                    // Add a default placeholder item at the top
                    ddlCourses.Items.Insert(0, new ListItem("-- Select a Course --", "0"));
                }
            }
        }

        // Triggered when admin selects a course from the dropdown
        protected void ddlCourses_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (ddlCourses.SelectedValue != "0")
            {
                // Show the form and grid, then load existing questions
                pnlManageQuiz.Visible = true;
                LoadQuestions(Convert.ToInt32(ddlCourses.SelectedValue));
                lblMessage.Visible = false; // Clear any previous messages
            }
            else
            {
                // Hide the form if no course is selected
                pnlManageQuiz.Visible = false;
            }
        }

        // Load existing questions for the selected course into the GridView
        private void LoadQuestions(int courseId)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT QuestionID, QuestionText, CorrectAnswer FROM QuizQuestions WHERE CourseID = @CourseID ORDER BY QuestionID ASC";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvQuestions.DataSource = dt;
                        gvQuestions.DataBind();
                    }
                }
            }
        }

        // Save the new question to the database
        protected void btnAddQuestion_Click(object sender, EventArgs e)
        {
            // Validate inputs
            if (string.IsNullOrWhiteSpace(txtQuestion.Text) || string.IsNullOrWhiteSpace(txtOptionA.Text) ||
                string.IsNullOrWhiteSpace(txtOptionB.Text) || string.IsNullOrWhiteSpace(txtOptionC.Text) ||
                string.IsNullOrWhiteSpace(txtOptionD.Text))
            {
                ShowMessage("Please fill in all fields before adding the question.", false);
                return;
            }

            int courseId = Convert.ToInt32(ddlCourses.SelectedValue);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"INSERT INTO QuizQuestions 
                                 (CourseID, QuestionText, OptionA, OptionB, OptionC, OptionD, CorrectAnswer) 
                                 VALUES (@CourseID, @QuestionText, @OptionA, @OptionB, @OptionC, @OptionD, @CorrectAnswer)";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    cmd.Parameters.AddWithValue("@QuestionText", txtQuestion.Text.Trim());
                    cmd.Parameters.AddWithValue("@OptionA", txtOptionA.Text.Trim());
                    cmd.Parameters.AddWithValue("@OptionB", txtOptionB.Text.Trim());
                    cmd.Parameters.AddWithValue("@OptionC", txtOptionC.Text.Trim());
                    cmd.Parameters.AddWithValue("@OptionD", txtOptionD.Text.Trim());
                    cmd.Parameters.AddWithValue("@CorrectAnswer", ddlCorrectAnswer.SelectedValue);

                    con.Open();
                    int rowsAffected = cmd.ExecuteNonQuery();

                    if (rowsAffected > 0)
                    {
                        ShowMessage("Question added successfully!", true);
                        ClearForm();
                        LoadQuestions(courseId); // Refresh the grid
                    }
                    else
                    {
                        ShowMessage("Failed to add question. Please try again.", false);
                    }
                }
            }
        }

        // Delete a question when the admin clicks the trash icon
        protected void gvQuestions_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int questionId = Convert.ToInt32(gvQuestions.DataKeys[e.RowIndex].Value);
            int courseId = Convert.ToInt32(ddlCourses.SelectedValue);

            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "DELETE FROM QuizQuestions WHERE QuestionID = @QuestionID";
                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    cmd.Parameters.AddWithValue("@QuestionID", questionId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            ShowMessage("Question deleted.", true);
            LoadQuestions(courseId); // Refresh the grid after deletion
        }

        // Helper method to clear the form after adding a question
        private void ClearForm()
        {
            txtQuestion.Text = "";
            txtOptionA.Text = "";
            txtOptionB.Text = "";
            txtOptionC.Text = "";
            txtOptionD.Text = "";
            ddlCorrectAnswer.SelectedIndex = 0;
        }

        // Helper method to display success or error messages
        private void ShowMessage(string msg, bool isSuccess)
        {
            lblMessage.Text = msg;
            lblMessage.Visible = true;
            lblMessage.CssClass = isSuccess ? "fw-bold mt-2 text-success" : "fw-bold mt-2 text-danger";
        }
    }
}