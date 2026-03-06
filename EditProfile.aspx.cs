using System;
using System.IO;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class EditProfile : System.Web.UI.Page
    {
        // Connection string from Web.config
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // Enable multipart/form-data to allow file uploads when using a Master Page
            Page.Form.Attributes.Add("enctype", "multipart/form-data");

            if (!IsPostBack)
            {
                // Check if the user is authenticated; if not, redirect to login
                if (Session["UserID"] == null)
                {
                    Response.Redirect("Login.aspx");
                    return;
                }

                // Populate the form with existing user data
                LoadUserProfile();
            }
        }

        // Fetch current user details from the database
        private void LoadUserProfile()
        {
            string query = "SELECT Username, Email, Weight, Height, ProfilePic FROM Users WHERE UserID = @UserID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", Session["UserID"]);
                    conn.Open();
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        if (reader.Read())
                        {
                            txtUsername.Text = reader["Username"].ToString();
                            txtEmail.Text = reader["Email"].ToString();
                            txtWeight.Text = reader["Weight"].ToString();
                            txtHeight.Text = reader["Height"].ToString();

                            // Load profile picture if it exists in the database
                            string pic = reader["ProfilePic"].ToString();
                            if (!string.IsNullOrEmpty(pic))
                            {
                                imgProfile.ImageUrl = "~/assets/img/profiles/" + pic;
                            }
                        }
                    }
                }
            }
        }

        protected void btnSaveChanges_Click(object sender, EventArgs e)
        {
            string userId = Session["UserID"].ToString();
            string finalPicName = null;

            // 1. Handle File Upload (includes 2MB size limit and unique naming)
            if (fileProfilePic.HasFile)
            {
                if (fileProfilePic.PostedFile.ContentLength > 2097152) // 2MB Limit
                {
                    lblMessage.Text = "❌ Image must be smaller than 2MB.";
                    lblMessage.CssClass = "text-danger fw-bold";
                    return;
                }

                // Ensure the directory exists
                string folderPath = Server.MapPath("~/assets/img/profiles/");
                if (!Directory.Exists(folderPath)) Directory.CreateDirectory(folderPath);

                // Generate a unique filename using a timestamp to prevent overwriting
                finalPicName = $"user_{userId}_{DateTime.Now.Ticks}{Path.GetExtension(fileProfilePic.FileName)}";
                fileProfilePic.SaveAs(Path.Combine(folderPath, finalPicName));
            }

            // 2. Database Update Logic
            string pass = txtNewPassword.Text.Trim();

            // Build the query dynamically: only update the picture or password if they were changed
            string sql = "UPDATE Users SET Username=@Username, Weight=@Weight, Height=@Height"
                         + (finalPicName != null ? ", ProfilePic=@Pic" : "")
                         + (!string.IsNullOrEmpty(pass) ? ", Password=@Pass" : "")
                         + " WHERE UserID=@UID";

            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Username", txtUsername.Text.Trim());
                    cmd.Parameters.AddWithValue("@Weight", txtWeight.Text.Trim());
                    cmd.Parameters.AddWithValue("@Height", txtHeight.Text.Trim());
                    cmd.Parameters.AddWithValue("@UID", userId);

                    // Only add parameters if the fields are actually being updated
                    if (finalPicName != null) cmd.Parameters.AddWithValue("@Pic", finalPicName);
                    if (!string.IsNullOrEmpty(pass)) cmd.Parameters.AddWithValue("@Pass", pass);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            // Update session and display success message
            Session["UserName"] = txtUsername.Text.Trim();
            lblMessage.Text = "✅ Profile updated successfully!";
            lblMessage.CssClass = "text-success fw-bold";
        }
    }
}