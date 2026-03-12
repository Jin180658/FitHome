using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class ForumThread : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                string topicId = Request.QueryString["id"];
                if (string.IsNullOrEmpty(topicId)) { Response.Redirect("CommunityBoard.aspx"); return; }

                // Check user authentication status to toggle UI panels
                if (Session["UserID"] == null)
                {
                    pnlReplyForm.Visible = false;
                    pnlLoginPrompt.Visible = true;
                }
                else
                {
                    pnlReplyForm.Visible = true;
                    pnlLoginPrompt.Visible = false;
                }

                // CRITICAL: Ensure these two methods are called to populate the page with data
                LoadThreadDetails(topicId);
                LoadReplies(topicId);
            }
        }

        private void LoadThreadDetails(string topicId)
        {
            string query = @"
                SELECT t.Title, t.Content, t.CreatedAt, u.Username, u.ProfilePic 
                FROM ForumTopics t
                INNER JOIN Users u ON t.UserID = u.UserID
                WHERE t.TopicID = @TopicID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TopicID", topicId);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            lblTopicTitle.Text = reader["Title"].ToString();
                            lblTopicContent.Text = reader["Content"].ToString().TrimStart();
                            lblAuthorName.Text = reader["Username"].ToString();

                            // Format the date for a professional look
                            DateTime createdDate = Convert.ToDateTime(reader["CreatedAt"]);
                            lblPostDate.Text = createdDate.ToString("MMM dd, yyyy • HH:mm");

                            // Load the author's profile picture
                            string pic = reader["ProfilePic"].ToString();
                            imgAuthorPic.ImageUrl = string.IsNullOrEmpty(pic) ? "~/assets/img/profiles/defaultUser.png" : "~/assets/img/profiles/" + pic;
                        }
                        else
                        {
                            // If the topic cannot be found (e.g., deleted), redirect back to the board
                            Response.Redirect("CommunityBoard.aspx");
                        }
                    }
                }
            }
        }

        private void LoadReplies(string topicIdStr)
        {
            int topicId = Convert.ToInt32(topicIdStr);
            string query = @"
                SELECT r.ReplyContent, r.CreatedAt, u.Username, u.ProfilePic 
                FROM ForumReplies r
                LEFT JOIN Users u ON r.UserID = u.UserID
                WHERE r.TopicID = @TopicID
                ORDER BY r.CreatedAt ASC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@TopicID", topicId);
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        rptReplies.DataSource = dt;
                        rptReplies.DataBind();
                    }
                }
            }
        }

        protected void btnSubmitReply_Click(object sender, EventArgs e)
        {
            // 1. Retrieve input content and TopicID from QueryString
            string replyText = txtReplyContent.Text.Trim();
            string urlTopicId = Request.QueryString["id"];

            // 2. Validate that the input is not empty
            if (string.IsNullOrEmpty(replyText))
            {
                lblReplyError.Text = "❌ Please write something before posting.";
                return;
            }

            // 3. Ensure the user is logged in and the TopicID is valid
            if (Session["UserID"] != null && !string.IsNullOrEmpty(urlTopicId))
            {
                string currentUserId = Session["UserID"].ToString();

                // 4. Prepare the SQL command to save the reply
                string query = "INSERT INTO ForumReplies (TopicID, UserID, ReplyContent, CreatedAt) VALUES (@TopicID, @UserID, @ReplyContent, GETDATE())";

                using (SqlConnection conn = new SqlConnection(connString))
                {
                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@TopicID", urlTopicId);
                        cmd.Parameters.AddWithValue("@UserID", currentUserId);
                        cmd.Parameters.AddWithValue("@ReplyContent", replyText);

                        conn.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                // 5. Success: Refresh the current page to display the new reply
                Response.Redirect("ForumThread.aspx?id=" + urlTopicId);
            }
        }
    }
}