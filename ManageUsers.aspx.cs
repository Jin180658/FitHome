using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class ManageUsers : System.Web.UI.Page
    {
        // my database connection line
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // security check: kick unauthorized people back to login page
            if (Session["AdminName"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            // only load the user list when page first opens
            if (!IsPostBack)
            {
                LoadUsersGrid();
            }
        }

        // ==========================================
        // FEATURE 1: READ (Load users into GridView)
        // ==========================================
        private void LoadUsersGrid()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                // get all normal users, show newest first
                string sql = "SELECT UserID, Username, Email, Weight, Height FROM Users ORDER BY UserID DESC";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt); // fill virtual table

                        gvUsers.DataSource = dt;
                        gvUsers.DataBind(); // stick it to the UI
                    }
                }
            }
        }

        // ==========================================
        // FEATURE 2: DELETE (Kick a bad user)
        // ==========================================
        protected void gvUsers_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            // find out which user ID the admin wants to delete
            int userID = Convert.ToInt32(gvUsers.DataKeys[e.RowIndex].Value);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // SQL to delete user
                string sql = "DELETE FROM Users WHERE UserID=@ID";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", userID);
                    conn.Open();
                    cmd.ExecuteNonQuery(); // execute the kick
                }
            }

            // refresh the table to show updated list
            LoadUsersGrid();
        }
    }
}