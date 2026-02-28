using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // check if admin is logged in. if no session, kick them back to login page
            // this protects the dashboard from direct URL access by outsiders
            if (Session["AdminName"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            // only load data the first time the page loads, not on every button click
            if (!IsPostBack)
            {
                // show the admin's name from session
                lblAdminName.Text = Session["AdminName"].ToString();

                // call my function to load the stats
                LoadDashboardStats();
            }
        }

        private void LoadDashboardStats()
        {
            // get the db connection line from web.config
            string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // --- 1. Count how many courses in database ---
                string sqlCourses = "SELECT COUNT(*) FROM Courses";
                using (SqlCommand cmdCourses = new SqlCommand(sqlCourses, conn))
                {
                    // run the query and save the number to the label
                    int courseCount = Convert.ToInt32(cmdCourses.ExecuteScalar());
                    lblTotalCourses.Text = courseCount.ToString();
                }

                // --- 2. Count how many users registered ---
                string sqlUsers = "SELECT COUNT(*) FROM Users";
                using (SqlCommand cmdUsers = new SqlCommand(sqlUsers, conn))
                {
                    // run the query and save the number to the label
                    int userCount = Convert.ToInt32(cmdUsers.ExecuteScalar());
                    lblTotalUsers.Text = userCount.ToString();
                }
            }
        }
    }
}