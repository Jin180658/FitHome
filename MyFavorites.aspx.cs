using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class MyFavorites : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        int userId;

        protected void Page_Load(object sender, EventArgs e)
        {
            userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                LoadFavorites();
            }
        }

        void LoadFavorites()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT c.CourseID, c.Title, c.Description, c.Category, c.Thumbnail
                    FROM Favorites f
                    INNER JOIN Courses c ON f.CourseID = c.CourseID
                    WHERE f.UserID = @uid
                    ORDER BY f.DateAdded DESC";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@uid", userId);

                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();

                if (dr.HasRows)
                {
                    rptFavorites.DataSource = dr;
                    rptFavorites.DataBind();
                    lblNoFavorites.Visible = false;
                }
                else
                {
                    rptFavorites.DataSource = null;
                    rptFavorites.DataBind();
                    lblNoFavorites.Visible = true;
                }
            }
        }
    }
}