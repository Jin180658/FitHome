using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.UI.WebControls;

namespace FitHome
{
    public partial class ManageCourses : System.Web.UI.Page
    {
        // my data connection line
        string connString = ConfigurationManager.ConnectionStrings["FitHomeDB"].ConnectionString;

        protected void Page_Load(object sender, EventArgs e)
        {
            // security check: if not admin, kick back to login
            if (Session["AdminName"] == null)
            {
                Response.Redirect("AdminLogin.aspx");
            }

            // only load the table when page first opens
            if (!IsPostBack)
            {
                LoadCoursesGrid();
            }
        }

        // ==========================================
        // FEATURE 1: READ (Load data into GridView)
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
                        sda.Fill(dt); // fill the virtual table with data from DB

                        gvCourses.DataSource = dt;
                        gvCourses.DataBind(); // stick the data to the UI grid
                    }
                }
            }
        }

        // ==========================================
        // FEATURE 2: INSERT (Upload new course)
        // ==========================================
        protected void btnAddCourse_Click(object sender, EventArgs e)
        {
            string title = txtTitle.Text.Trim();
            string category = ddlCategory.SelectedValue;
            string videoLink = txtVideoLink.Text.Trim();
            string thumbnail = txtThumbnail.Text.Trim();
            string desc = txtDescription.Text.Trim();

            // simple validation
            if (string.IsNullOrEmpty(title) || string.IsNullOrEmpty(category) || string.IsNullOrEmpty(videoLink))
            {
                lblMessage.Text = "Title, Category, and Video Link are required!";
                lblMessage.CssClass = "d-block mb-3 fw-bold text-danger";
                lblMessage.Visible = true;
                return;
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
                    cmd.Parameters.AddWithValue("@Thumb", thumbnail);

                    conn.Open();
                    cmd.ExecuteNonQuery(); // run the insert command
                }
            }

            // show success message and clear form
            lblMessage.Text = "Course added successfully!";
            lblMessage.CssClass = "d-block mb-3 fw-bold text-success";
            lblMessage.Visible = true;

            txtTitle.Text = ""; txtVideoLink.Text = ""; txtThumbnail.Text = ""; txtDescription.Text = "";
            ddlCategory.SelectedIndex = 0;

            // refresh the table to show the new course
            LoadCoursesGrid();
        }

        // ==========================================
        // FEATURE 3: UPDATE & DELETE (GridView Events)
        // ==========================================

        // when admin clicks "Edit" button
        protected void gvCourses_RowEditing(object sender, GridViewEditEventArgs e)
        {
            gvCourses.EditIndex = e.NewEditIndex; // change that row to textboxes
            LoadCoursesGrid();
        }

        // when admin clicks "Cancel" while editing
        protected void gvCourses_RowCancelingEdit(object sender, GridViewCancelEditEventArgs e)
        {
            gvCourses.EditIndex = -1; // change back to normal text
            LoadCoursesGrid();
        }

        // when admin clicks "Update" after editing
        protected void gvCourses_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            // get the ID of the course we are editing
            int courseID = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

            // get the new typed values from the grid row
            GridViewRow row = gvCourses.Rows[e.RowIndex];
            string newTitle = (row.Cells[1].Controls[0] as TextBox).Text;
            string newCat = (row.Cells[2].Controls[0] as TextBox).Text;
            string newVideo = (row.Cells[3].Controls[0] as TextBox).Text;

            using (SqlConnection conn = new SqlConnection(connString))
            {
                string sql = "UPDATE Courses SET Title=@Title, Category=@Cat, VideoLink=@Video WHERE CourseID=@ID";
                using (SqlCommand cmd = new SqlCommand(sql, conn))
                {
                    cmd.Parameters.AddWithValue("@Title", newTitle);
                    cmd.Parameters.AddWithValue("@Cat", newCat);
                    cmd.Parameters.AddWithValue("@Video", newVideo);
                    cmd.Parameters.AddWithValue("@ID", courseID);

                    conn.Open();
                    cmd.ExecuteNonQuery();
                }
            }

            gvCourses.EditIndex = -1; // close edit mode
            LoadCoursesGrid(); // refresh the table
        }

        // when admin clicks "Delete" button
        protected void gvCourses_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            int courseID = Convert.ToInt32(gvCourses.DataKeys[e.RowIndex].Value);

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

            LoadCoursesGrid(); // refresh the table
        }
    }
}