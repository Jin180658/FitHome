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
        // Grabs the connection string from your Web.config file using your leader's exact name
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Simulate User Session (Hardcoded for testing. Switch to Session["UserID"] later)
                int currentUserId = 1;

                // SQL Query to fetch the user's current profile data when the page loads
                string query = "SELECT Email, Weight, Height FROM Users WHERE UserID = @UserID";

                try
                {
                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", currentUserId);
                            conn.Open();

                            using (SqlDataReader reader = cmd.ExecuteReader())
                            {
                                if (reader.Read())
                                {
                                    // Populate the textboxes with the real database values
                                    txtEmail.Text = reader["Email"].ToString();
                                    txtEditWeight.Text = reader["Weight"].ToString();
                                    txtEditHeight.Text = reader["Height"].ToString();
                                }
                            }
                        }
                    }
                }
                catch (Exception ex)
                {
                    lblStatus.Text = "❌ Error loading profile data: " + ex.Message;
                    lblStatus.CssClass = "fw-bold d-block mb-3 text-center text-danger";
                }
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            try
            {
                // Simulate User Session
                int currentUserId = 1;

                decimal newWeight = Convert.ToDecimal(txtEditWeight.Text);
                decimal newHeight = Convert.ToDecimal(txtEditHeight.Text);
                string newPassword = txtNewPassword.Text.Trim();

                // Build the SQL UPDATE command
                string query = "UPDATE Users SET Weight = @Weight, Height = @Height";

                // Only update the password if they actually typed a new one
                if (!string.IsNullOrEmpty(newPassword))
                {
                    query += ", Password = @Password";
                }

                query += " WHERE UserID = @UserID";

                // Execute the SQL UPDATE Query
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