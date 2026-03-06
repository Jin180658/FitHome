using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        // Get the connection string from Web.config
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Check if user is logged in; if not, redirect to Login page
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Set a motivational quote and display user information
                lblQuote.Text = "\"Physical fitness is not only one of the most important keys to a healthy body, it is the basis of dynamic and creative intellectual activity.\" – John F. Kennedy";

                string userId = Session["UserID"].ToString();
                string username = Session["UserName"].ToString();

                lblUsername.Text = username;
                lblCardName.Text = username;

                // Load user profile data and recent activity from the database
                LoadUserData(userId);
                LoadUserProgress(userId);
            }
        }

        // Fetch user profile details and calculate the profile completion percentage
        private void LoadUserData(string userId)
        {
            string query = "SELECT Email, Height, Weight, ProfilePic FROM Users WHERE UserID = @UserID";
            int completedFields = 1; // Start at 1 for the username
            int totalFields = 4;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            // Display the profile picture or use the default if it's missing
                            string pic = reader["ProfilePic"].ToString();
                            if (!string.IsNullOrEmpty(pic))
                            {
                                imgProfileLarge.ImageUrl = "~/assets/img/profiles/" + pic;
                            }
                            else
                            {
                                imgProfileLarge.ImageUrl = "~/assets/img/profiles/defaultUser.png";
                            }

                            // Load user info and increment counter for the progress bar
                            if (!string.IsNullOrEmpty(reader["Email"].ToString()))
                            {
                                lblEmail.Text = reader["Email"].ToString();
                                completedFields++;
                            }

                            if (reader["Height"] != DBNull.Value && reader["Height"].ToString() != "0")
                            {
                                lblHeight.Text = reader["Height"].ToString() + " cm";
                                completedFields++;
                            }

                            if (reader["Weight"] != DBNull.Value && reader["Weight"].ToString() != "0")
                            {
                                lblWeight.Text = reader["Weight"].ToString() + " kg";
                                completedFields++;
                            }
                        }
                    }
                }
            }

            // Calculate and display the profile completion progress
            int percentage = (int)Math.Round((double)completedFields / totalFields * 100);
            lblProgressText.Text = percentage + "%";
            divProgressBar.Style.Add("width", percentage + "%");
        }

        // Retrieve the most recent course completed by the user
        private void LoadUserProgress(string userId)
        {
            string query = @"SELECT TOP 1 c.Title 
                             FROM UserProgress up 
                             INNER JOIN Courses c ON up.CourseID = c.CourseID 
                             WHERE up.UserID = @UserID 
                             ORDER BY up.DateCompleted DESC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    conn.Open();
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        lblRecentProgress.Text = $"Great job! You recently completed <strong>{result.ToString()}</strong>.";
                    }
                    else
                    {
                        lblRecentProgress.Text = "No workouts recorded yet. Start your journey today!";
                    }
                }
            }
        }

        // Handle logout by clearing the session and redirecting to the Login page
        protected void btnLogout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.Abandon();
            Response.Redirect("Login.aspx");
        }
    }
}