using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        // Get connection string from Web.config
        string connStr = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void btnVerifyEmail_Click(object sender, EventArgs e)
        {
            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Check if the email exists in your Users table
                string sql = "SELECT COUNT(*) FROM Users WHERE Email = @email";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());

                conn.Open();
                int userExists = (int)cmd.ExecuteScalar();

                if (userExists > 0)
                {
                    // Success: Switch to Password Reset Panel
                    pnlStep1.Visible = false;
                    pnlStep2.Visible = true;
                    lblMsg.Text = "";
                    // Store the email in ViewState so we know which user to update in the next step
                    ViewState["TargetEmail"] = txtEmail.Text.Trim();
                }
                else
                {
                    lblMsg.Text = "No account found with this email.";
                    lblMsg.ForeColor = System.Drawing.Color.Red;
                }
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            if (ViewState["TargetEmail"] == null) return;

            string email = ViewState["TargetEmail"].ToString();

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Update the password for the verified email
                string sql = "UPDATE Users SET Password = @newPass WHERE Email = @email";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@newPass", txtNewPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@email", email);

                conn.Open();
                cmd.ExecuteNonQuery();

                lblMsg.Text = "Password updated successfully! Redirecting...";
                lblMsg.ForeColor = System.Drawing.Color.Green;
                pnlStep2.Visible = false;

                // Redirect back to login after 2 seconds
                Response.AddHeader("REFRESH", "2;URL=Login.aspx");
            }
        }
    }
}