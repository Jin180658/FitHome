using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.HtmlControls;

namespace FitHome
{
    public partial class CourseDetails : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        int courseId;
        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            courseId = Convert.ToInt32(Request.QueryString["id"]);

            if (Session["UserID"] != null)
                userId = Convert.ToInt32(Session["UserID"]);
            else
                userId = 1;

            if (!IsPostBack)
            {
                LoadCourse();
                btnComplete.Visible = false;
                UpdateFavoriteUI(false); 
            }
        }

        // ===== Load Course Info =====
        void LoadCourse()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Courses WHERE CourseID = @id";
                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@id", courseId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.Read())
                {
                    lblTitle.Text = dr["Title"].ToString();
                    lblDescription.Text = dr["Description"].ToString();

                    litVideo.Text =
                        $"<iframe width='100%' height='400' src='{dr["VideoLink"]}' frameborder='0' allowfullscreen></iframe>";
                }
            }
        }

        // ===== Favorite Logic =====
        protected void btnFavorite_Click(object sender, EventArgs e)
        {
            bool isFavorited = favoriteStar.InnerText == "★"; 
            UpdateFavoriteUI(!isFavorited); 
        }

        void UpdateFavoriteUI(bool favorited)
        {
            if (favorited)
            {
                favoriteStar.InnerText = "★";
                lblFavoriteText.Text = "Favorited";
                btnFavorite.Attributes["class"] = "btn btn-warning btn-lg mb-3 w-100 d-flex align-items-center justify-content-center";
            }
            else
            {
                favoriteStar.InnerText = "☆";
                lblFavoriteText.Text = "Add to Favorites";
                btnFavorite.Attributes["class"] = "btn btn-outline-warning btn-lg mb-3 w-100 d-flex align-items-center justify-content-center";
            }
        }

        // ===== Training Buttons =====
        protected void btnStart_Click(object sender, EventArgs e)
        {
            btnStart.Visible = false;
            btnComplete.Visible = true;
        }

        protected void btnComplete_Click(object sender, EventArgs e)
        {
            btnComplete.Text = "Completed ✅";
            btnComplete.Enabled = false;
        }
    }
}