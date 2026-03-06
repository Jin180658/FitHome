using System;
using System.Data.SqlClient;
using System.Configuration;

namespace FitHome
{
    public partial class BMICalculator : System.Web.UI.Page
    {
        // Get database connection string from configuration
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"]?.ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Auto-fill form data if the user is currently logged in
                if (Session["UserID"] != null)
                {
                    LoadUserData(Session["UserID"].ToString());
                }
            }
        }

        /// <summary>
        /// Fetches existing weight and height from the user profile to improve user experience.
        /// </summary>
        private void LoadUserData(string userId)
        {
            string query = "SELECT Weight, Height FROM Users WHERE UserID = @UserID";
            using (SqlConnection conn = new SqlConnection(connString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@UserID", userId);
                    try
                    {
                        conn.Open();
                        using (SqlDataReader reader = cmd.ExecuteReader())
                        {
                            if (reader.Read())
                            {
                                string weight = reader["Weight"].ToString();
                                string height = reader["Height"].ToString();

                                // Only populate the fields if actual values exist in the database
                                if (!string.IsNullOrEmpty(weight) && weight != "0")
                                    txtWeight.Text = weight;

                                if (!string.IsNullOrEmpty(height) && height != "0")
                                    txtHeight.Text = height;
                            }
                        }
                    }
                    catch
                    {
                        // Silently fail to allow the user to input data manually if database access fails
                    }
                }
            }
        }

        protected void btnCalculateBMI_Click(object sender, EventArgs e)
        {
            try
            {
                // Convert input strings to decimal for precise calculation
                decimal weight = Convert.ToDecimal(txtWeight.Text);
                decimal heightInCm = Convert.ToDecimal(txtHeight.Text);
                decimal heightInMeters = heightInCm / 100;

                // Formula: BMI = weight (kg) / [height (m)]^2
                decimal bmi = weight / (heightInMeters * heightInMeters);

                string category = "";
                string cssClass = "";

                // Define CSS classes for the category guide list (Inactive vs. Active)
                string defaultLiClass = "list-group-item bg-transparent px-2 d-flex justify-content-between border-0 py-2 text-muted rounded-3 transition-all";
                string activeLiClass = "list-group-item px-3 d-flex justify-content-between border-0 py-2 text-dark fw-bold bg-white shadow-sm rounded-3 transition-all scale-up";

                // Reset all category list items to default styling before highlighting the result
                liUnderweight.Attributes["class"] = defaultLiClass;
                liNormal.Attributes["class"] = defaultLiClass;
                liOverweight.Attributes["class"] = defaultLiClass;
                liObese.Attributes["class"] = defaultLiClass;

                // Determine the BMI category and highlight the corresponding UI element
                if (bmi < 18.5m)
                {
                    category = "Underweight";
                    cssClass = "text-secondary";
                    liUnderweight.Attributes["class"] = activeLiClass;
                }
                else if (bmi >= 18.5m && bmi < 24.9m)
                {
                    category = "Normal";
                    cssClass = "text-success";
                    liNormal.Attributes["class"] = activeLiClass;
                }
                else if (bmi >= 25m && bmi < 29.9m)
                {
                    category = "Overweight";
                    cssClass = "text-warning";
                    liOverweight.Attributes["class"] = activeLiClass;
                }
                else
                {
                    category = "Obese";
                    cssClass = "text-danger";
                    liObese.Attributes["class"] = activeLiClass;
                }

                // Render the results into the UI card
                lblBMIResult.CssClass = $"fs-5 d-block mt-3 p-3 rounded-3 bg-white border border-light shadow-sm";
                lblBMIResult.Text = $"Your BMI: <strong class='fs-3 {cssClass}'>{Math.Round(bmi, 1)}</strong><br/><span class='text-muted small'>Category: {category}</span>";
            }
            catch (Exception)
            {
                // Handle non-numeric input errors
                lblBMIResult.CssClass = "fs-6 text-danger d-block mt-3";
                lblBMIResult.Text = "Please enter valid numbers for weight and height.";
            }
        }
    }
}