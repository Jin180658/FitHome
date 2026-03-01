using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class Login : System.Web.UI.Page
    {
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // Select UserID along with the record to use it for Session
                string sql = "SELECT UserID FROM Users WHERE Username = @user AND Password = @pass";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@user", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@pass", txtPassword.Text.Trim());

                
                    conn.Open();
                    object result = cmd.ExecuteScalar(); // ExecuteScalar returns the first column (UserID)

                    if (result != null)
                    {
                        // 1. Login Success! Store UserID in Session
                        Session["UserID"] = result.ToString();
                        Session["UserName"] = txtUsername.Text.Trim();

                        // 2. Redirect to User Dashboard (Member C's page)
                        Response.Redirect("UserDashboard.aspx");
                    }
                    else
                    {
                        lblMessage.Text = "Invalid username or password.";
                    }
                
                
            }
        }
    }
}