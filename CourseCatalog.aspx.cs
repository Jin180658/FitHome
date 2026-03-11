using System;
using System.Configuration;
using System.Data.SqlClient;

namespace FitHome
{
    public partial class CourseCatalog : System.Web.UI.Page
    {
        // Connection string retrieved from Web.config
        string cs = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        // Page Load event
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Display favorites panel only if the user is currently logged in
                LoadFeaturedCourses();
                LoadCourses();
            }
        }

        // Method to fetch and display the Featured Courses
        void LoadFeaturedCourses()
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Query to get the latest 3 courses based on their ID
                string query = "SELECT TOP 3 * FROM Courses ORDER BY CourseID DESC";
                SqlCommand cmd = new SqlCommand(query, con);
                con.Open();
                rptFeatured.DataSource = cmd.ExecuteReader();
                rptFeatured.DataBind();
            }
        }

        // Method to load all courses, handling optional search and category filters
        void LoadCourses(string keyword = "", string category = "")
        {
            using (SqlConnection con = new SqlConnection(cs))
            {
                // Base query with LIKE operator for partial matching on title
                string query = "SELECT * FROM Courses WHERE Title LIKE @title";

                // Append category filter if the user selected one
                if (!string.IsNullOrEmpty(category))
                    query += " AND Category=@category";

                query += " ORDER BY Title";

                SqlCommand cmd = new SqlCommand(query, con);

                // Using parameters to prevent SQL injection vulnerabilities
                cmd.Parameters.AddWithValue("@title", "%" + keyword + "%");
                if (!string.IsNullOrEmpty(category))
                    cmd.Parameters.AddWithValue("@category", category);

                con.Open();

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    if (reader.HasRows)
                    {
                        // Data exists: Bind the data to the repeater
                        rptCourses.DataSource = reader;
                        rptCourses.DataBind();

                        // Show the course list and hide the "no results" panel
                        rptCourses.Visible = true;
                        pnlNoResults.Visible = false;
                    }
                    else
                    {
                        // No data found: Hide the course list and show the empty state message
                        rptCourses.Visible = false;
                        pnlNoResults.Visible = true;
                    }
                }
            }

            // --- UX Optimization: Adjust UI elements based on search activity ---
            // Determine if the user has entered a search keyword or selected a category
            bool isSearching = !string.IsNullOrEmpty(keyword) || !string.IsNullOrEmpty(category);

            if (isSearching)
            {
                // When searching: Hide the Featured section to save space, and update the main heading
                pnlFeatured.Visible = false;
                lblAllCoursesTitle.InnerText = "Search Results";
            }
            else
            {
                // When not searching (default view): Show the Featured section and reset the heading
                pnlFeatured.Visible = true;
                lblAllCoursesTitle.InnerText = "All Courses";
            }
        }

        // Event handler for the Search button
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            // Pass the user inputs into the load method to refresh the list
            LoadCourses(txtSearch.Text, ddlCategory.SelectedValue);
        }

        // Helper method to generate the URL for the course details page
        protected string GetCourseLink(object courseId)
        {
            // Appends the course ID to the query string
            return "CourseDetails.aspx?id=" + courseId;
        }
    }
}