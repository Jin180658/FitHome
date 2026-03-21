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
                // 3. SQL Insert (UserID is excluded because it's usually Auto-Increment)
                string sql = "INSERT INTO Users (Username, Password, Email, Weight, Height) VALUES (@user, @pass, @email, @weight, @height)";

                SqlCommand cmd = new SqlCommand(sql, conn);

                // 4. Add Parameters
                cmd.Parameters.AddWithValue("@user", username);
                cmd.Parameters.AddWithValue("@pass", password);
                cmd.Parameters.AddWithValue("@email", email);

                // Handle optional Weight/Height
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
                    // 5. THE MISSING KEYS: You MUST open and execute!
                    conn.Open(); 
                    int result = cmd.ExecuteNonQuery(); 

                    if (result > 0)
                    {
                        Response.Write("<script>alert('Success!'); window.location='Login.aspx';</script>");
                    }
                }
                catch (Exception ex)
                {
                    Response.Write("<script>alert('Error: " + ex.Message.Replace("'", "") + "');</script>");
                }
            }
        }

    }
}