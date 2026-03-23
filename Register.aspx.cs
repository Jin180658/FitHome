using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace FitHome
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
           
            // 1. Get values from the form
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();
            string email = txtEmail.Text.Trim();

            // 2. Logic for Confirm Password
            if (password != confirmPass)
            {
                Response.Write("<script>alert('Passwords do not match!');</script>");
                return;
            }

            string connStr = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                conn.Open(); 

                string checkSql = "SELECT COUNT(*) FROM Users WHERE Username = @checkUser OR Email = @checkEmail";
                SqlCommand checkCmd = new SqlCommand(checkSql, conn);
                checkCmd.Parameters.AddWithValue("@checkUser", username);
                checkCmd.Parameters.AddWithValue("@checkEmail", email);

                int userExists = (int)checkCmd.ExecuteScalar();

                if (userExists > 0)
                {
                    Response.Write("<script>alert('Error: Username or Email already exists! Please try another.');</script>");
                    return; 
                }

                string sql = "INSERT INTO Users (Username, Password, Email, Weight, Height) VALUES (@user, @pass, @email, @weight, @height)";
                SqlCommand cmd = new SqlCommand(sql, conn);

                cmd.Parameters.AddWithValue("@user", username);
                cmd.Parameters.AddWithValue("@pass", password);
                cmd.Parameters.AddWithValue("@email", email);

                if (string.IsNullOrEmpty(txtWeight.Text))
                    cmd.Parameters.AddWithValue("@weight", DBNull.Value);
                else
                    cmd.Parameters.AddWithValue("@weight", Convert.ToDecimal(txtWeight.Text));

                if (string.IsNullOrEmpty(txtHeight.Text))
                    cmd.Parameters.AddWithValue("@height", DBNull.Value);
                else
                    cmd.Parameters.AddWithValue("@height", Convert.ToDecimal(txtHeight.Text));

                try
                {
                    int result = cmd.ExecuteNonQuery();

                    if (result > 0)
                    {
                        Response.Write("<script>alert('Registration Successful!'); window.location='Login.aspx';</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Database Error: " + ex.Message.Replace("'", "") + "');</script>");
                }
            }
        }

    }
}