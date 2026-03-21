using System;
using System.Data.SqlClient;
using System.Configuration;
using System.Net;
using System.Net.Mail;

namespace FitHome 
{
    public partial class ForgotPassword : System.Web.UI.Page
    {
        string connStr = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnSendOTP_Click(object sender, EventArgs e)
        {
            string email = txtEmail.Text.Trim();
            if (string.IsNullOrEmpty(email)) return;

            using (SqlConnection conn = new SqlConnection(connStr))
            {
                string sql = "SELECT COUNT(*) FROM Users WHERE Email = @email";
                SqlCommand cmd = new SqlCommand(sql, conn);
                cmd.Parameters.AddWithValue("@email", email);

                conn.Open();
                int count = (int)cmd.ExecuteScalar();

                if (count > 0)
                {
                    Random rand = new Random();
                    string otp = rand.Next(100000, 999999).ToString();

                    Session["OTP"] = otp;
                    Session["ResetEmail"] = email;

                    if (SendEmail(email, otp))
                    {
                        PanelEmail.Visible = false;
                        PanelOTP.Visible = true;
                        Response.Write("<script>alert('Verification code sent to your email!');</script>");
                    }
                    else
                    {
                        Response.Write("<script>alert('Failed to send email. Check SMTP settings.');</script>");
                    }
                }
                else
                {
                    Response.Write("<script>alert('Email not found in our system.');</script>");
                }
            }
        }

        protected void btnVerifyOTP_Click(object sender, EventArgs e)
        {
            string inputOTP = txtOTP.Text.Trim();

            if (Session["OTP"] != null && inputOTP == Session["OTP"].ToString())
            {
                PanelOTP.Visible = false;
                PanelReset.Visible = true;
            }
            else
            {
                Response.Write("<script>alert('Invalid verification code!');</script>");
            }
        }

        protected void btnResetPassword_Click(object sender, EventArgs e)
        {
            string newPass = txtNewPassword.Text.Trim();
            string confirmPass = txtConfirmPassword.Text.Trim();

            if (newPass != confirmPass)
            {
                Response.Write("<script>alert('Passwords do not match!');</script>");
                return;
            }

            if (Session["ResetEmail"] != null)
            {
                string email = Session["ResetEmail"].ToString();

                using (SqlConnection conn = new SqlConnection(connStr))
                {
                    string sql = "UPDATE Users SET Password = @pass WHERE Email = @email";
                    SqlCommand cmd = new SqlCommand(sql, conn);
                    cmd.Parameters.AddWithValue("@pass", newPass);
                    cmd.Parameters.AddWithValue("@email", email);

                    conn.Open();
                    int rows = cmd.ExecuteNonQuery();

                    if (rows > 0)
                    {
                        Session["OTP"] = null;
                        Session["ResetEmail"] = null;

                        Response.Write("<script>alert('Password reset successful!'); window.location='Login.aspx';</script>");
                    }
                }
            }
        }


        private bool SendEmail(string toEmail, string otp)
        {
            try
            {
                string fromEmail = "wu33158@gmail.com";
                string appPassword = "cywz xhxz ynem cola";

                MailMessage mail = new MailMessage();
                mail.From = new MailAddress(fromEmail, "FitHome Support");
                mail.To.Add(toEmail);
                mail.Subject = "FitHome Password Reset Code";
                mail.Body = $"<h2>Password Reset Request</h2><p>Your 6-digit verification code is: <b style='font-size:24px; color:#007bff;'>{otp}</b></p><p>If you did not request this, please ignore this email.</p>";
                mail.IsBodyHtml = true;

                SmtpClient smtp = new SmtpClient("smtp.gmail.com", 587);
                smtp.Credentials = new NetworkCredential(fromEmail, appPassword);
                smtp.EnableSsl = true; 

                smtp.Send(mail);
                return true;
            }
            catch (Exception ex)
            {
                return false;
            }
        }
    }
}