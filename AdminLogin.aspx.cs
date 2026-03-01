using System;
using System.Data.SqlClient; // Introduce the toolbox for connecting to SQL databases
using System.Configuration;  // Introduce the toolbox for reading Web.config

namespace FitHome
{
    public partial class AdminLogin : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            //Runs when the last page loads. If it's the first time opening the page, it does nothing.
        }

        // This is the "secret weapon" to solve your error! When the button is clicked, run the code here.
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            // 1. Get the text from the input box (remove leading and trailing spaces)
            string username = txtUsername.Text.Trim();
            string password = txtPassword.Text.Trim();

            // 2. Basic validation: Check if it is empty
            if (string.IsNullOrEmpty(username) || string.IsNullOrEmpty(password))
            {
                lblError.Text = "Username and password cannot be empty.";
                lblError.Visible = true; // Make the red error message appear
                return; // Stop running
            }

            // 3. Connect to the database and verify the account and password

           // Retrieve data from Web.config
            string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                // Write an SQL query: Find the number of rows in the Admins table where the name and password match.
                string sql = "SELECT COUNT(1) FROM Admins WHERE Name = @Name AND Password = @Password";

                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    // Insert user input into the SQL statement (to prevent SQL injection attacks by hackers)
                    cmd.Parameters.AddWithValue("@Name", username);
                    cmd.Parameters.AddWithValue("@Password", password);

                    // Open database connection
                    conn.Open();
                    // Execute the SQL and retrieve the results (number of matched rows)
                    int count = Convert.ToInt32(cmd.ExecuteScalar());

                    // 4. Judgment Result
                    if (count == 1)
                    {
                        // Login successful! A "session" has been sent to the administrator.
                        Session["AdminName"] = username;

                        // Redirecting to the backend homepage (we'll create this page later)
                        Response.Redirect("AdminDashboard.aspx");
                    }
                    else
                    {
                        //Login failed: Incorrect username or password
                        lblError.Text = "Invalid username or password.";
                        lblError.Visible = true;
                    }
                }
            }
        }
    }
}