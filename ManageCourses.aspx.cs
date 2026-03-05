using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;
using System.IO; // Required for file handling

namespace FitHome
{
    public partial class ManageCourses : System.Web.UI.Page
    {
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["AdminName"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            if (!IsPostBack)
            {
                LoadCoursesGrid();
            }
        }

        // ==========================================
        // FEATURE 1: READ (Load data)
        // ==========================================
        private void LoadCoursesGrid()
        {
            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "SELECT * FROM Courses ORDER BY CourseID DESC";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    using (SqlDataAdapter sda = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        sda.Fill(dt);
                        gvCourses.DataSource = dt;
                        gvCourses.DataBind();
                    }
                }
            }
        }

        // ==========================================
        // FEATURE 2: INSERT (Upload course & image)
        // ==========================================
        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string videoLink = txtVideoLink.Text.Trim();
            string desc = txtDescription.Text.Trim();

            // Default image if admin doesn't upload one
            string finalFileName = "default-course.jpeg";

            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(category) || string.IsNullOrEmpty(videoLink))
            {
                lblMessage.Text = "Title, Category, and Video Link are required!";
                lblMessage.CssClass = "d-block mb-3 fw-bold text-danger";
                lblMessage.Visible = true;
                return;
            }

            // ✨ Handle physical image upload
            if (fuThumbnail.HasFile)
            {
                try
                {
                    // Add timestamp to prevent filename collision (e.g., two people uploading 'yoga.jpg')
                    string fileName = DateTime.Now.ToString("yyyyMMddHHmmss_") + Path.GetFileName(fuThumbnail.PostedFile.FileName);
                    string savePath = Server.MapPath("~/assets/img/courses/") + fileName;

                    fuThumbnail.SaveAs(savePath); // Save file to project folder
                    finalFileName = fileName;     // Use this name for database
                }
                catch (Exception ex)
                {
                    lblMessage.Text = "Image upload failed: " + ex.Message;
                    lblMessage.CssClass = "d-block mb-3 fw-bold text-danger";
                    lblMessage.Visible = true;
                    return;
                }
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "INSERT INTO Courses (Title, Description, VideoLink, Category, Thumbnail) VALUES (@Title, @Desc, @Video, @Cat, @Thumb)";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", title);
                    cmd.Parameters.AddWithValue("@Desc", desc);
                    cmd.Parameters.AddWithValue("@Video", videoLink);
                    cmd.Parameters.AddWithValue("@Cat", category);
                    cmd.Parameters.AddWithValue("@Thumb", finalFileName); // Save filename to DB

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            lblMessage.Text = "Course and image uploaded successfully!";
            lblMessage.CssClass = "d-block mb-3 fw-bold text-success";
            lblMessage.Visible = true;

            txtTitle.Text = ""; txtVideoLink.Text = ""; txtDescription.Text = "";
            ddlCategory.SelectedIndex = 0;
            LoadCoursesGrid();
        }

        // ==========================================
        // FEATURE 3: UPDATE & DELETE
        // ==========================================

        protected void gvCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex;
            LoadCoursesGrid();
        }

        protected void gvCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1;
            LoadCoursesGrid();
        }

        protected void gvCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // Get ID and Old Thumbnail from DataKeys
            int courseID = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Values["CourseID"]);
            string oldThumbnail = gvCourses.DataKeys[e.RowIndex].Values["Thumbnail"].ToString();

            GridViewRow row = gvCourses.Rows[e.RowIndex];

            // Read standard textboxes
            string newTitle = (row.Cells[1].Controls[0] as TextBox).Text;
            string newVideo = (row.Cells[3].Controls[0] as TextBox).Text;

            // ✨ Read from TemplateFields (FindControl)
            DropDownList ddlEditCategory = row.FindControl("ddlEditCategory") as DropDownList;
            FileUpload fuEditThumbnail = row.FindControl("fuEditThumbnail") as FileUpload;

            string newCat = ddlEditCategory != null ? ddlEditCategory.SelectedValue : "";
            string finalThumbnail = oldThumbnail; // Default to keep old image

            // ✨ Handle new image upload during edit
            if (fuEditThumbnail != null && fuEditThumbnail.HasFile)
            {
                string fileName = DateTime.Now.ToString("yyyyMMddHHmmss_") + Path.GetFileName(fuEditThumbnail.PostedFile.FileName);
                fuEditThumbnail.SaveAs(Server.MapPath("~/assets/img/courses/") + fileName);
                finalThumbnail = fileName; // Replace old image name with new one
            }

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "UPDATE Courses SET Title=@Title, Category=@Cat, VideoLink=@Video, Thumbnail=@Thumb WHERE CourseID=@ID";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", newTitle);
                    cmd.Parameters.AddWithValue("@Cat", newCat);
                    cmd.Parameters.AddWithValue("@Video", newVideo);
                    cmd.Parameters.AddWithValue("@Thumb", finalThumbnail);
                    cmd.Parameters.AddWithValue("@ID", courseID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvCourses.EditIndex = -1;
            LoadCoursesGrid();
        }

        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseID = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Values["CourseID"]);

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "DELETE FROM Courses WHERE CourseID=@ID";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@ID", courseID);
                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            LoadCoursesGrid();
        }
    }
}