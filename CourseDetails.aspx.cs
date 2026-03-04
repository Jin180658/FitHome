using System;
using System.Configuration;
using System.Data.SqlClient;

namespace FitHome
{
    public partial class CourseDetails : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;
        int courseId;
        int userId;

        //Load Page
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!int.TryParse(Request.QueryString["id"], out courseId))
                Response.Redirect("CourseCatalog.aspx");

            userId = Session["UserID"] != null ? Convert.ToInt32(Session["UserID"]) : 0; //get userId

            if (!IsPostBack)
            {
                LoadCourse();
                SetupInitialUI();
                RestoreTrainingState();
            }
        }

        //Load Course details
        void LoadCourse()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
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
                        litVideo.Text = video.Contains("youtube")
                            ? $"<iframe src='{video}' frameborder='0' allowfullscreen></iframe>"
                            : $"<video controls><source src='assets/videos/{video}' type='video/mp4'></video>";
                    }
                }
            }
        }

        //show favoritebtn if login
        void SetupInitialUI()
        {
            pnlFavorite.Visible = userId != 0;
            if (userId != 0) CheckFavoriteStatus();
        }

        //startbtn
        protected void btnStart_Click(object sender, EventArgs e)
        {
            if (userId == 0)
            {
                Response.Redirect("Login.aspx?returnUrl=CourseDetails.aspx?id=" + courseId); //if no login, direct to login
                return;
            }
            Session[$"TRAINING_{userId}_{courseId}"] = true;
            pnlVideo.Visible = true;
            btnStart.Visible = false;
            btnComplete.Visible = true;
        }

        //favoritebtn
        protected void btnFavorite_Click(object sender, EventArgs e)
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string check = "SELECT COUNT(*) FROM Favorites WHERE UserID=@u AND CourseID=@c";
                SqlCommand cmd = new SqlCommand(check, con);
                cmd.Parameters.AddWithValue("@u", userId);
                cmd.Parameters.AddWithValue("@c", courseId);
                con.Open();
                int count = (int)cmd.ExecuteScalar();

                string sql = count == 0
                    ? "INSERT INTO Favorites (UserID, CourseID, DateAdded) VALUES (@u,@c,GETDATE())"
                    : "DELETE FROM Favorites WHERE UserID=@u AND CourseID=@c";

                SqlCommand act = new SqlCommand(sql, con);
                act.Parameters.AddWithValue("@u", userId);
                act.Parameters.AddWithValue("@c", courseId);
                act.ExecuteNonQuery();
            }
            CheckFavoriteStatus();
        }

        //check favorite status from sql
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
                favoriteStar.InnerText = count > 0 ? "★" : "☆";
                lblFavoriteText.Text = count > 0 ? "Favorited" : "Add to Favorites";
            }
        }

        //store training state
        void RestoreTrainingState()
        {
            if (userId == 0) return;
            bool started = Session[$"TRAINING_{userId}_{courseId}"] != null;
            pnlVideo.Visible = started;
            btnStart.Visible = !started;
            btnComplete.Visible = started;
        }

        //completebtn
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
            Session.Remove(key);
            btnComplete.Text = "Completed ✅";
            btnComplete.Enabled = false;
        }
    }
}