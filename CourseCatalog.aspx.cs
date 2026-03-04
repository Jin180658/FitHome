using System;
using System.Configuration;
using System.Data.SqlClient;

namespace FitHome
{
    public partial class CourseCatalog : System.Web.UI.Page
    {
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        //Load Page
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                pnlMyFavorites.Visible = Session["UserID"] != null; //display favorites course if login
                LoadFeaturedCourses();
                LoadCourses();
            }
        }

        //Load Featured Courses
        void LoadFeaturedCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT TOP 3 * FROM Courses ORDER BY CourseID DESC"; // display top3 course
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                rptFeatured.DataSource = cmd.ExecuteReader();
                rptFeatured.DataBind();
            }
        }

        //Load All Courses
        void LoadCourses(string keyword = "", string category = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                string query = "SELECT * FROM Courses WHERE Title LIKE @title";
                if (!string.IsNullOrEmpty(category))
                    query += " AND Category=@category";
                query += " ORDER BY Title";

                SqlCommand cmd = new SqlCommand(query, con);
                cmd.Parameters.AddWithValue("@title", "%" + keyword + "%");
                if (!string.IsNullOrEmpty(category))
                    cmd.Parameters.AddWithValue("@category", category);

                con.Open();
                rptCourses.DataSource = cmd.ExecuteReader();
                rptCourses.DataBind();
            }
        }

        //Search and filter
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            LoadCourses(txtSearch.Text, ddlCategory.SelectedValue);
        }

        //View Details
        protected string GetCourseLink(object courseId)
        {
            return "CourseDetails.aspx?id=" + courseId;
        }
    }
}