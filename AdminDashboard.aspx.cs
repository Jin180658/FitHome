using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;

namespace FitHome
{
    public partial class AdminDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // Security check to prevent unauthorized access
            if (Session["AdminName"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                // Display admin name dynamically
                lblAdminName.Text = Session["AdminName"].ToString();

                // Load all dashboard dynamic data
                LoadDashboardStats();
                LoadRecentUsers();
            }
        }

        // ==========================================
        // FEATURE 1: Load Top Metrics & Generate Chart
        // ==========================================
        private void LoadDashboardStats()
        {
            string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                conn.Open();

                // --- 1. Load Total Metrics ---
                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Courses", conn))
                {
                    lblTotalCourses.Text = Convert.ToInt32(cmd.ExecuteScalar()).ToString();
                }

                using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM Users", conn))
                {
                    lblTotalUsers.Text = Convert.ToInt32(cmd.ExecuteScalar()).ToString();
                }

                // --- 2. Generate Data for Chart.js (Course Categories) ---
                string sqlChart = "SELECT Category, COUNT(*) as CatCount FROM Courses GROUP BY Category";
                using (SqlCommand cmdChart = new SqlCommand(sqlChart, conn))
                {
                    using (SqlDataReader reader = cmdChart.ExecuteReader())
                    {
                        StringBuilder labels = new StringBuilder();
                        StringBuilder data = new StringBuilder();

                        while (reader.Read())
                        {
                            labels.AppendFormat("'{0}',", reader["Category"].ToString());
                            data.AppendFormat("{0},", reader["CatCount"].ToString());
                        }

                        if (labels.Length > 0)
                        {
                            labels.Length--;
                            data.Length--;
                        }

                        // Generate Javascript dynamically
                        string script = $@"
                        <script>
                            document.addEventListener('DOMContentLoaded', function() {{
                                var ctx = document.getElementById('categoryChart').getContext('2d');
                                var myChart = new Chart(ctx, {{
                                    type: 'doughnut',
                                    data: {{
                                        labels: [{labels.ToString()}],
                                        datasets: [{{
                                            data: [{data.ToString()}],
                                            backgroundColor: [
                                                '#002d5a', /* Navy */
                                                '#ff9d00', /* Orange */
                                                '#17a2b8', /* Info Blue */
                                                '#28a745', /* Success Green */
                                                '#e83e8c'  /* Pink */
                                            ],
                                            borderWidth: 2,
                                            hoverOffset: 5
                                        }}]
                                    }},
                                    options: {{
                                        responsive: true,
                                        maintainAspectRatio: false,
                                        plugins: {{
                                            legend: {{ position: 'right' }}
                                        }},
                                        cutout: '65%'
                                    }}
                                }});
                            }});
                        </script>";

                        litChartScript.Text = script;
                    }
                }
            }
        }

        // ==========================================
        // FEATURE 2: Load Top 3 Newest Registered Users
        // ==========================================
        private void LoadRecentUsers()
        {
            string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Get the top 3 most recently created user accounts
                string sql = "SELECT TOP 3 Username, Email FROM Users ORDER BY UserID DESC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt); // Fill data into a virtual table

                        // If we have users, bind them to the Repeater. Otherwise, show fallback message.
                        if (dt.Rows.Count > 0)
                        {
                            rptRecentUsers.DataSource = dt;
                            rptRecentUsers.DataBind();
                        }
                        else
                        {
                            phNoUsers.Visible = true;
                        }
                    }
                }
            }
        }
    }
}