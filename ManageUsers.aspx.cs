using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Security Check
            if (Session["AdminName"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                LoadUsersGrid(); // Load all users by default
            }
        }

        // ==========================================
        // FEATURE 1: READ (Load users with optional Search)
        // ==========================================
        private void LoadUsersGrid(string searchQuery = "")
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // ✨ Upgraded SQL: Use ISNULL to ensure we always have at least 'default.png' string returned
                string sql = "SELECT UserID, Username, Email, Weight, Height, ISNULL(ProfilePic, 'default.png') as ProfilePic FROM Users";

                // If admin typed something in the search box, add a WHERE clause
                if (!string.IsNullOrEmpty(searchQuery))
                {
                    sql += " WHERE Username LIKE @Search OR Email LIKE @Search";
                }

                sql += " ORDER BY UserID DESC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    if (!string.IsNullOrEmpty(searchQuery))
                    {
                        // Add wildcards % for partial matching (e.g., search 'tom' finds 'tommy')
                        cmd.Parameters.AddWithValue("@Search", "%" + searchQuery + "%");
                    }

                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);

                        gvUsers.DataSource = dt;
                        gvUsers.DataBind();

                        // Update the small badge showing total results found
                        lblUserCount.Text = $"Total Users: {dt.Rows.Count}";
                    }
                }
            }
        }

        // ==========================================
        // FEATURE 2: SEARCH BUTTONS
        // ==========================================
        protected void btnSearch_Click(object sender, EventArgs e)
        {
            string keyword = txtSearch.Text.Trim();
            LoadUsersGrid(keyword); // Reload grid with the search keyword
        }

        protected void btnClear_Click(object sender, EventArgs e)
        {
            txtSearch.Text = ""; // Clear the input box
            LoadUsersGrid();     // Reload grid with ALL users
        }

        // ==========================================
        // FEATURE 3: DELETE (Kick/Ban User)
        // ==========================================
        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int userID = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "DELETE FROM Users WHERE UserID=@ID";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", userID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Reload the grid, maintaining the search state if there is one
            LoadUsersGrid(txtSearch.Text.Trim());
        }
    }
}