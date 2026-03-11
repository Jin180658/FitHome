using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Verify if the user is logged in by checking session variables
                if (Session["UserName"] != null && Session["UserID"] != null)
                {
                    // User is logged in: toggle visibility of navigation panels
                    pnlGuest.Visible = false;
                    pnlLoggedIn.Visible = true;

                    // --- NEW: Show "My Favorites" in the navigation bar for logged-in users ---
                    navFavorites.Visible = true;

                    // Update the UI with the current user's name
                    lblUserName.InnerText = Session["UserName"].ToString();

                    // Retrieve the user's profile picture from the database
                    string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;
                    string userId = Session["UserID"].ToString();

                    using (SqlConnection conn = new SqlConnection(connString))
                    {
                        string query = "SELECT ProfilePic FROM Users WHERE UserID = @UserID";
                        using (SqlCommand cmd = new SqlCommand(query, conn))
                        {
                            cmd.Parameters.AddWithValue("@UserID", userId);
                            try
                            {
                                conn.Open();
                                object result = cmd.ExecuteScalar();

                                // Check if a profile picture exists in the database
                                if (result != null && result != DBNull.Value && !string.IsNullOrEmpty(result.ToString()))
                                {
                                    string profilePic = result.ToString();
                                    // Set the image source to the user's custom picture
                                    imgProfilePic.Src = "assets/img/profiles/" + profilePic;
                                }
                                else
                                {
                                    // Fallback to the default image if the database record is empty
                                    imgProfilePic.Src = "assets/img/profiles/defaultUser.png";
                                }
                            }
                            catch
                            {
                                // Error handling: provide a default image to prevent UI breakage if the query fails
                                imgProfilePic.Src = "assets/img/profiles/defaultUser.png";
                            }
                        }
                    }
                }
                else
                {
                    // User is a guest: show login/register options and hide profile info
                    pnlGuest.Visible = true;
                    pnlLoggedIn.Visible = false;

                    // --- NEW: Hide "My Favorites" in the navigation bar for guests ---
                    navFavorites.Visible = false;
                }
            }
        }
    }
}