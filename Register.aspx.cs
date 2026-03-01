using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class Register : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            string connStr = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                // 1. Updated SQL to include Weight and Height
                string sql = "INSERT INTO Users (Username, Password, Email, Weight, Height) VALUES (@user, @pass, @email, @weight, @height)";

                SqlCommand cmd = new SqlCommand(sql, conn);

                // 2. Standard parameters
                cmd.Parameters.AddWithValue("@user", txtUsername.Text.Trim());
                cmd.Parameters.AddWithValue("@pass", txtPassword.Text.Trim());
                cmd.Parameters.AddWithValue("@email", txtEmail.Text.Trim());

                // 3. Handle Weight (Check if empty)
                if (string.IsNullOrEmpty(txtWeight.Text))
                    cmd.Parameters.AddWithValue("@weight", DBNull.Value);
                else
                    cmd.Parameters.AddWithValue("@weight", Convert.ToDecimal(txtWeight.Text));

                // 4. Handle Height (Check if empty)
                if (string.IsNullOrEmpty(txtHeight.Text))
                    cmd.Parameters.AddWithValue("@height", DBNull.Value);
                else
                    cmd.Parameters.AddWithValue("@height", Convert.ToDecimal(txtHeight.Text));

                
                
            }
        }
    }
}