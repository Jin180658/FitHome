using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class EditProfile : System.Web.UI.Page
    {
        // This grabs the connection string from your Web.config file
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDBConnectionString"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // TODO: 1. Check if user is logged in using Session["UserID"]
                // TODO: 2. Write a SELECT SQL query to fetch their current Weight, Height, and Email
                // TODO: 3. Populate txtEditWeight, txtEditHeight, and txtEmail

                // For testing front-end without DB:
                txtEditWeight.Text = "70";
                txtEditHeight.Text = "165";
                txtEmail.Text = "member@fithome.com";
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                // In a real scenario, you get the UserID from the active login session
                int currentUserId = 1; // Hardcoded for testing. Replace with: Convert.ToInt32(Session["UserID"]);

                decimal newWeight = Convert.ToDecimal(txtEditWeight.Text);
                decimal newHeight = Convert.ToDecimal(txtEditHeight.Text);
                string newPassword = txtNewPassword.Text.Trim();

                // Build the SQL UPDATE command
                string query = "UPDATE Users SET Weight = @Weight, Height = @Height";

                // Only update the password if they typed a new one
                if (!string.IsNullOrEmpty(newPassword))
                {
                    query += ", Password = @Password";
                }

                query += " WHERE UserID = @UserID";

                // Execute the SQL Query
                /* UNCOMMENT THIS WHEN READY TO CONNECT TO DATABASE
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    SqlCommand cmd = new SqlCommand(query, conn);
                    cmd.Parameters.AddWithValue("@Weight", newWeight);
                    cmd.Parameters.AddWithValue("@Height", newHeight);
                    cmd.Parameters.AddWithValue("@UserID", currentUserId);
                    
                    if (!string.IsNullOrEmpty(newPassword))
                    {
                        cmd.Parameters.AddWithValue("@Password", newPassword);
                    }

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
                */

                // Show success message
                lblStatus.Text = "✅ Profile updated successfully!";
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-success";
            }
            catch (Exception ex)
            {
                lblStatus.Text = "❌ Error updating profile: " + ex.Message;
                lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-danger";
            }
        }
    }
}