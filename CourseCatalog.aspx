<%@ Page Title="Course Catalog"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="CourseCatalog.aspx.cs"
    Inherits="FitHome.CourseCatalog" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<section class="course-hero">
    <div class="container text-center text-white">
        <h1 class="fw-bold mb-3 hero-title" data-aos="fade-down">
            Explore Our Courses!
        </h1>
        <p class="lead mb-4 hero-subtitle" data-aos="fade-up">
            Learn new skills with structured, high-quality video courses
        </p>
    </div>
</section>

<div class="container mt-5 pt-5">

    <asp:Panel ID="pnlMyFavorites" runat="server" Visible="false" CssClass="text-center mb-4">
        <a href="MyFavorites.aspx" class="btn btn-warning btn-lg">
            My Favorite Courses
        </a>
    </asp:Panel>

    <div class="row mb-4">
        <div class="col-md-6 mb-2">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control"
                Placeholder="Search by course title" />
        </div>

        <div class="col-md-4 mb-2">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                <asp:ListItem Text="All Categories" Value="" />
                <asp:ListItem Text="Yoga" Value="Yoga" />
                <asp:ListItem Text="Cardio" Value="Cardio" />
                <asp:ListItem Text="Strength" Value="Strength" />
            </asp:DropDownList>
        </div>

        <div class="col-md-2 mb-2">
            <asp:Button ID="btnSearch" runat="server"
                Text="Search"
                CssClass="btn btn-primary w-100"
                OnClick="btnSearch_Click" />
        </div>
    </div>

    <asp:Panel ID="pnlFeatured" runat="server">
        <h2 class="fw-bold mb-4">Featured Courses</h2>
        
        <asp:Repeater ID="rptFeatured" runat="server">
            <ItemTemplate>
                <div class="featured-card mb-4 course-card-hover" data-aos="zoom-in">
                    <div class="row g-0 align-items-center">
                        <div class="col-md-5">
                            <img src='<%# ResolveUrl("~/assets/img/courses/" + Eval("Thumbnail")) %>' class="img-fluid rounded-start featured-img" alt="Course Thumbnail" />
                        </div>
                        <div class="col-md-7 p-4">
                            <span class="badge bg-warning text-dark mb-2">FEATURED</span>
                            <h3 class="fw-bold"><%# Eval("Title") %></h3>
                            <p class="text-muted"><%# Eval("Description") %></p>
                            <a href='<%# GetCourseLink(Eval("CourseID")) %>' class="btn btn-primary mt-2">
                                Start Learning
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </asp:Panel>

    <h2 id="lblAllCoursesTitle" runat="server" class="fw-bold mt-5 mb-4">All Courses</h2>

    <asp:Panel ID="pnlNoResults" runat="server" Visible="false" CssClass="text-center mt-5 mb-5" data-aos="fade-up">
        <h3 class="text-muted">Oops! No courses found.</h3>
        <p class="text-muted">Try using different keywords or selecting a different category.</p>
    </asp:Panel>

    <div class="row">
        <asp:Repeater ID="rptCourses" runat="server">
            <ItemTemplate>
                <div class="col-md-6 col-lg-4 mb-4" data-aos="fade-up">
                    <div class="course-card h-100 course-card-hover">
                        <div class="course-img">
                            <img src='<%# ResolveUrl("~/assets/img/courses/" + Eval("Thumbnail")) %>' alt="Course Image" />
                            <span class="course-category"><%# Eval("Category") %></span>
                        </div>
                        <div class="course-body">
                            <h5 class="fw-bold"><%# Eval("Title") %></h5>
                            <p class="text-muted">
                                <%# Eval("Description").ToString().Length > 90 ?
                                    Eval("Description").ToString().Substring(0,90) + "..." :
                                    Eval("Description") %>
                            </p>
                            <a href='<%# GetCourseLink(Eval("CourseID")) %>'
                               class="btn btn-outline-primary w-100">
                                View Course
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

<style>
.course-hero {
    background: linear-gradient(135deg, #4facfe, #00f2fe);
    padding: 80px 0;
}
.hero-title { font-size: 3rem; text-shadow: 2px 2px 8px rgba(0,0,0,0.3);}
.hero-subtitle { font-size: 1.25rem; }
.featured-card, .course-card {
    background: #fff;
    border-radius: 15px;
    overflow: hidden;
    box-shadow: 0 10px 25px rgba(0,0,0,0.1);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
}
.course-card-hover:hover {
    transform: translateY(-6px);
    box-shadow: 0 15px 35px rgba(0,0,0,0.2);
}
.course-img { position: relative; }
.course-img img { width: 100%; height: 200px; object-fit: cover; }
.course-category {
    position: absolute;
    top: 15px; left: 15px;
    background: #0d6efd; color: #fff;
    padding: 5px 12px; font-size: 12px; border-radius: 20px;
}
.course-body { padding: 20px; }

/* Ensure all featured images have the same height and don't stretch */
.featured-img {
    height: 250px;
    object-fit: cover;
    width: 100%;
}
</style>

<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet" />
<script> AOS.init({ duration: 800, once: true }); </script>

</asp:Content>