using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class MyFavorites : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;
        int userId;

        //Load Page
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserID"] != null)
                userId = Convert.ToInt32(Session["UserID"]);

            if (!IsPostBack)
            {
                LoadFavorites();
            }

            if (Request["__EVENTTARGET"] == "RefreshFavorites") //auto refresh when the favorites list change
            {
                LoadFavorites();
            }
        }

        //Load Favorites List
        void LoadFavorites()
        {
            string selectedCategory = ddlCategoryFilter.SelectedValue;
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = @"
                    SELECT c.CourseID, c.Title, c.Description, c.Category, c.Thumbnail
                    FROM Favorites f
                    INNER JOIN Courses c ON f.CourseID = c.CourseID
                    WHERE f.UserID = @uid";
                if (!string.IsNullOrEmpty(selectedCategory))
                    query += " AND c.Category=@category";
                query += " ORDER BY c.Title";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@uid", userId);
                if (!string.IsNullOrEmpty(selectedCategory))
                    cmd.Parameters.AddWithValue("@category", selectedCategory);

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

        // Remove Favorite
        protected void rptFavorites_ItemCommand(object source, System.Web.UI.WebControls.RepeaterCommandEventArgs e)
        {
            if (e.CommandName == "Remove")
            {
                int courseId = Convert.ToInt32(e.CommandArgument);
                using (SqlConnection con = new SqlConnection(cs))
                {
                    string query = "DELETE FROM Favorites WHERE UserID=@uid AND CourseID=@cid";
                    SqlCommand cmd = new SqlCommand(query, con);
                    cmd.Parameters.AddWithValue("@uid", userId);
                    cmd.Parameters.AddWithValue("@cid", courseId);
                    con.Open();
                    cmd.ExecuteNonQuery();
                }
                LoadFavorites();
            }
        }

        // Filter
        protected void ddlCategoryFilter_SelectedIndexChanged(object sender, EventArgs e)
        {
            LoadFavorites();
        }
    }
}