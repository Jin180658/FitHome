using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class UserDashboard : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                // Here you would normally load the username from the Session
                // e.g., lblUsername.Text = Session["Username"].ToString();
            }
        }

        protected void btnCalculateBMI_Click(object sender, EventArgs e)
        {
            try
            {
                // 1. Get values from the textboxes
                decimal weight = Convert.ToDecimal(txtWeight.Text);
                decimal heightInCm = Convert.ToDecimal(txtHeight.Text);

                // 2. Convert height to meters for the formula
                decimal heightInMeters = heightInCm / 100;

                // 3. Calculate BMI: Weight / (Height * Height)
                decimal bmi = weight / (heightInMeters * heightInMeters);

                // 4. Determine BMI Category for visual feedback
                string category = "";
                string cssClass = "";

                if (bmi < 18.5m)
                {
                    category = "Underweight";
                    cssClass = "text-warning"; // Yellow text
                }
                else if (bmi >= 18.5m && bmi < 24.9m)
                {
                    category = "Normal weight";
                    cssClass = "text-success"; // Green text
                }
                else if (bmi >= 25m && bmi < 29.9m)
                {
                    category = "Overweight";
                    cssClass = "text-warning"; // Yellow text
                }
                else
                {
                    category = "Obese";
                    cssClass = "text-danger"; // Red text
                }

                // 5. Display the result beautifully
                lblBMIResult.CssClass = $"fs-4 fw-bold {cssClass}";
                lblBMIResult.Text = $"Your BMI is {Math.Round(bmi, 2)} ({category})";
            }
            catch (Exception)
            {
                lblBMIResult.CssClass = "fs-5 text-danger";
                lblBMIResult.Text = "Please enter valid numbers for weight and height.";
            }
        }
    }
}