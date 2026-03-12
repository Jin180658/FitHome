using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI;

namespace FitHome
{
    public partial class CommunityBoard : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadTopics();
            }
        }

        private void LoadTopics()
        {
            // SQL Query: Joins with Users table to get profile pictures and 
            // uses a subquery to count total replies for each topic.
            string query = @"
                SELECT 
                    t.TopicID, 
                    t.Title, 
                    t.CreatedAt, 
                    u.Username, 
                    u.ProfilePic,
                    (SELECT COUNT(*) FROM ForumReplies r WHERE r.TopicID = t.TopicID) AS ReplyCount
                FROM ForumTopics t
                INNER JOIN Users u ON t.UserID = u.UserID
                ORDER BY t.CreatedAt DESC";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        // Bind the retrieved data to the Repeater control on the frontend
                        rptTopics.DataSource = dt;
                        rptTopics.DataBind();
                    }
                }
            }
        }

        protected void btnStartDiscussion_Click(object sender, EventArgs e)
        {
            // [Authentication Guard] If user is not logged in, show alert and redirect
            if (Session["UserID"] == null)
            {
                // Register a JavaScript alert; redirects to Login page after user clicks OK
                string script = "alert('Please log in to start a new discussion.'); window.location.href='Login.aspx';";
                ScriptManager.RegisterStartupScript(this, GetType(), "LoginRedirect", script, true);
            }
            else
            {
                // If authenticated, redirect to the topic creation page
                Response.Redirect("CreateTopic.aspx");
            }
        }
    }
}