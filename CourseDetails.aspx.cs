using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Text.RegularExpressions; // Required for URL parsing

namespace FitHome
{
    public partial class CourseDetails : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;
        int courseId;
        int userId;

        // Page Load event handler
        protected void Page_Load(object sender, EventArgs e)
        {
            // Redirect to catalog if the course ID is invalid or missing
            if (!int.TryParse(Request.QueryString["id"], out courseId))
                Response.Redirect("CourseCatalog.aspx");

            // Retrieve the user ID from the session; default to 0 if the user is a guest
            userId = Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0;

            if (!IsPostBack)
            {
                LoadCourse();
                SetupInitialUI();
                RestoreTrainingState();

                // --- NEW FEATURE: Check if there's a quiz for this course ---
                CheckCourseAssessment();
            }
        }

        // Load Course details from Database
        void LoadCourse()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Retrieve the title, description, and video link based on the Course ID
                string q = "SELECT Title, Description, VideoLink FROM Courses WHERE CourseID=@id";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@id", courseId);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                if (dr.Read())
                {
                    lblTitle.Text = dr["Title"].ToString();
                    lblDescription.Text = dr["Description"].ToString();

                    string video = dr["VideoLink"].ToString();
                    if (!string.IsNullOrEmpty(video))
                    {
                        // Check if the video is from YouTube (matches either 'youtube' or 'youtu.be')
                        if (video.ToLower().Contains("youtube") || video.ToLower().Contains("youtu.be"))
                        {
                            // Automatically convert the URL to the Embed format required for iframes
                            string embedUrl = GetYouTubeEmbedUrl(video);
                            litVideo.Text = $"<iframe src='{embedUrl}' frameborder='0' allow='accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture' allowfullscreen></iframe>";
                        }
                        else
                        {
                            // Render HTML5 video player if it is a locally uploaded video file
                            litVideo.Text = $"<video controls><source src='assets/videos/{video}' type='video/mp4'></video>";
                        }
                    }
                }
            }
        }

        // Helper Method: Extract the YouTube Video ID and generate an Embed URL
        private string GetYouTubeEmbedUrl(string url)
        {
            // Use Regular Expression (Regex) to match and extract the 11-character YouTube Video ID
            string pattern = @"(?:youtube\.com\/(?:[^\/]+\/.+\/|(?:v|e(?:mbed)?)\/|.*[?&]v=)|youtu\.be\/)([^""&?\/\s]{11})";
            Match match = Regex.Match(url, pattern);

            if (match.Success)
            {
                // Extract the specific ID (e.g., J212vz33gU4) and format it as an embed link
                string videoId = match.Groups[1].Value;
                return $"https://www.youtube.com/embed/{videoId}";
            }

            // If the regex match fails, return the original URL to prevent application crashes
            return url;
        }

        // Setup the initial UI visibility for the Favorite Button
        void SetupInitialUI()
        {
            // Only display the favorite button if the user is logged in
            pnlFavorite.Visible = userId != 0;
            if (userId != 0) CheckFavoriteStatus();
        }

        // Handle the Start Training button click event
        protected void btnStart_Click(object sender, EventArgs e)
        {
            if (userId == 0)
            {
                // If not logged in, redirect the user to the login page and set the return URL
                Response.Redirect("Login.aspx?returnUrl=CourseDetails.aspx?id=" + courseId);
                return;
            }

            // Mark the course as started in the user's current session
            Session[$"TRAINING_{userId}_{courseId}"] = true;
            pnlVideo.Visible = true;
            btnStart.Visible = false;
            btnComplete.Visible = true;
        }

        // Handle the Add/Remove Favorite button toggle event
        protected void btnFavorite_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Check if the record already exists in the Favorites table
                string check = "SELECT COUNT(*) FROM Favorites WHERE UserID=@u AND CourseID=@c";
                SqlCommand cmd = new SqlCommand(check, con);
                cmd.Parameters.AddWithValue("@u", userId);
                cmd.Parameters.AddWithValue("@c", courseId);
                con.Open();
                int count = (int)cmd.ExecuteScalar();

                // If count is 0, insert a new record; otherwise, delete the existing record
                string sql = count == 0
                    ? "INSERT INTO Favorites (UserID, CourseID, DateAdded) VALUES (@u,@c,GETDATE())"
                    : "DELETE FROM Favorites WHERE UserID=@u AND CourseID=@c";

                SqlCommand act = new SqlCommand(sql, con);
                act.Parameters.AddWithValue("@u", userId);
                act.Parameters.AddWithValue("@c", courseId);
                act.ExecuteNonQuery();
            }
            // Refresh the UI to reflect the latest favorite status
            CheckFavoriteStatus();
        }

        // Check if the current course is already favorited by the logged-in user
        void CheckFavoriteStatus()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = "SELECT COUNT(*) FROM Favorites WHERE UserID=@u AND CourseID=@c";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@u", userId);
                cmd.Parameters.AddWithValue("@c", courseId);
                con.Open();
                int count = (int)cmd.ExecuteScalar();

                // Update the button text and icon based on the database result
                favoriteStar.InnerText = count > 0 ? "★" : "☆";
                lblFavoriteText.Text = count > 0 ? "Favorited" : "Add to Favorites";
            }
        }

        // Restore the UI state based on whether the user is training, logged in, or browsing as a guest
        void RestoreTrainingState()
        {
            // If the user is a guest, change the action button text to prompt login
            if (userId == 0)
            {
                btnStart.Text = "Login to Start Training";
                pnlVideo.Visible = false;
                btnComplete.Visible = false;
                return;
            }

            // Standard UI behavior for authenticated users
            bool started = Session[$"TRAINING_{userId}_{courseId}"] != null;
            pnlVideo.Visible = started;
            btnStart.Visible = !started;
            btnStart.Text = "Start Training"; // Reset text to normal state
            btnComplete.Visible = started;
        }

        // Handle the Complete Course event and insert the progress record into the database
        protected void btnComplete_Click(object sender, EventArgs e)
        {
            string key = $"TRAINING_{userId}_{courseId}";
            if (Session[key] == null) return;

            using (SqlConnection con = new SqlConnection(cs))
            {
                string q = @"INSERT INTO UserProgress (UserID, CourseID, DateCompleted) VALUES (@u,@c,GETDATE())";
                SqlCommand cmd = new SqlCommand(q, con);
                cmd.Parameters.AddWithValue("@u", userId);
                cmd.Parameters.AddWithValue("@c", courseId);
                con.Open();
                cmd.ExecuteNonQuery();
            }

            // Remove the active training session flag and disable the button
            Session.Remove(key);
            btnComplete.Text = "Completed";
            btnComplete.Enabled = false;
        }

        // --- NEW FEATURE: Method to check if the current course has a quiz ---
        private void CheckCourseAssessment()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Query the database to see if the Admin has added any questions for this specific course
                string quizQuery = "SELECT COUNT(*) FROM QuizQuestions WHERE CourseID = @CourseID";
                using (SqlCommand cmd = new SqlCommand(quizQuery, con))
                {
                    cmd.Parameters.AddWithValue("@CourseID", courseId);
                    con.Open();
                    int questionCount = Convert.ToInt32(cmd.ExecuteScalar());

                    // If questions exist, show the assessment CTA panel and set the navigation URL
                    if (questionCount > 0)
                    {
                        pnlAssessment.Visible = true;
                        // Dynamically append the course ID so TakeQuiz.aspx knows which quiz to load
                        hlTakeQuiz.NavigateUrl = "~/TakeQuiz.aspx?courseId=" + courseId;
                    }
                    else
                    {
                        // If no questions have been added by the admin, hide the assessment panel completely
                        pnlAssessment.Visible = false;
                    }
                }
            }
        }
    }
}