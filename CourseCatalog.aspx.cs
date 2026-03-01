using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class CourseCatalog : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadFeaturedCourses();
                LoadCourses();
            }
        }

        // Featured Courses (first 3 courses become Featured Flag)
        void LoadFeaturedCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT TOP 3 * FROM Courses ORDER BY CourseID ASC";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                rptFeatured.DataSource = cmd.ExecuteReader();
                rptFeatured.DataBind();
            }
        }

        // All Courses with optional filter
        void LoadCourses(string keyword = "", string category = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Courses WHERE Title LIKE @title";

                if (!string.IsNullOrEmpty(category))
                    query += " AND Category = @category";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@title", "%" + keyword + "%");

                if (!string.IsNullOrEmpty(category))
                    cmd.Parameters.AddWithValue("@category", category);

                con.Open();
                rptCourses.DataSource = cmd.ExecuteReader();
                rptCourses.DataBind();
            }
        }

        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadCourses(txtSearch.Text, ddlCategory.SelectedValue);
        }
    }
}