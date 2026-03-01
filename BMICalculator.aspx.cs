using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class BMICalculator : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnCalculateBMI_Click(object sender, EventArgs e)
        {
            try
            {
                decimal weight = Convert.ToDecimal(txtWeight.Text);
                decimal heightInCm = Convert.ToDecimal(txtHeight.Text);
                decimal heightInMeters = heightInCm / 100;

                decimal bmi = weight / (heightInMeters * heightInMeters);

                string category = "";
                string cssClass = "";

                if (bmi < 18.5m)
                {
                    category = "Underweight";
                    cssClass = "text-warning";
                }
                else if (bmi >= 18.5m && bmi < 24.9m)
                {
                    category = "Normal weight";
                    cssClass = "text-success";
                }
                else if (bmi >= 25m && bmi < 29.9m)
                {
                    category = "Overweight";
                    cssClass = "text-warning";
                }
                else
                {
                    category = "Obese";
                    cssClass = "text-danger";
                }

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