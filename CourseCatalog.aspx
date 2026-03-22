<%@ Page Title="Course Catalog"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="CourseCatalog.aspx.cs"
    Inherits="FitHome.CourseCatalog" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<style>
    /* Magic Dictionary for Course Catalog Page */
    :root {
        --cc-card-bg: #ffffff;
        --cc-card-border: #eeeeee;
        --cc-text-main: #222222;
        --cc-text-muted: #666666;
        --cc-input-bg: #ffffff;
        --cc-input-border: #ced4da;
    }

    /* 🌙 Auto-invert colors on Dark Mode */
    [data-theme="dark"] {
        --cc-card-bg: #1e1e1e;
        --cc-card-border: #333333;
        --cc-text-main: #ffffff;
        --cc-text-muted: #bbbbbb;
        --cc-input-bg: #2a2a2a;
        --cc-input-border: #444444;
    }

    /* Magic Classes to safely override hardcoded colors */
    .cc-magic-card { 
        background-color: var(--cc-card-bg) !important; 
        border: 1px solid var(--cc-card-border) !important; 
        transition: background-color 0.3s ease, border-color 0.3s ease; 
    }
    .cc-magic-text-main { color: var(--cc-text-main) !important; transition: color 0.3s ease; }
    .cc-magic-text-muted { color: var(--cc-text-muted) !important; transition: color 0.3s ease; }
    
    /* Input Field Overrides */
    .cc-magic-input { 
        background-color: var(--cc-input-bg) !important; 
        color: var(--cc-text-main) !important; 
        border-color: var(--cc-input-border) !important; 
        transition: background-color 0.3s ease, color 0.3s ease;
    }
    .cc-magic-input::placeholder { color: var(--cc-text-muted) !important; }

    /* Original Page Styles Maintained */
    .course-hero {
        background: linear-gradient(135deg, #4facfe, #00f2fe);
        padding: 80px 0;
    }
    .hero-title { font-size: 3rem; text-shadow: 2px 2px 8px rgba(0,0,0,0.3);}
    .hero-subtitle { font-size: 1.25rem; }
    
    .featured-card, .course-card {
        /* background: #fff; -> Removed to allow magic-card to take over */
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

    .featured-img {
        height: 250px;
        object-fit: cover;
        width: 100%;
    }

    .line-clamp-3 {
        display: -webkit-box;
        -webkit-line-clamp: 3;
        -webkit-box-orient: vertical;
        overflow: hidden;
        text-overflow: ellipsis;
    }
</style>

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

    <div class="row mb-4">
        <div class="col-md-6 mb-2">
            <asp:TextBox ID="txtSearch" runat="server"
                CssClass="form-control cc-magic-input"
                Placeholder="Search by course title" />
        </div>

        <div class="col-md-4 mb-2">
            <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select cc-magic-input">
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
        <h2 class="fw-bold mb-4 cc-magic-text-main">Featured Courses</h2>
        
        <asp:Repeater ID="rptFeatured" runat="server">
            <ItemTemplate>
                <div class="featured-card mb-4 course-card-hover cc-magic-card" data-aos="zoom-in">
                    <div class="row g-0 align-items-center">
                        <div class="col-md-5">
                            <img src='<%# ResolveUrl("~/assets/img/courses/" + Eval("Thumbnail")) %>' class="img-fluid rounded-start featured-img" alt="Course Thumbnail" />
                        </div>
                        <div class="col-md-7 p-4 d-flex flex-column justify-content-center" style="min-height: 250px;">
                            <div>
                                <span class="badge bg-warning text-dark mb-2">FEATURED</span>
                                <h3 class="fw-bold cc-magic-text-main"><%# Eval("Title") %></h3>
                                <p class="line-clamp-3 mb-3 cc-magic-text-muted"><%# Eval("Description") %></p>
                            </div>
                            <div class="mt-auto">
                                <a href='<%# GetCourseLink(Eval("CourseID")) %>' class="btn btn-primary">
                                    Start Learning
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </asp:Panel>

    <h2 id="lblAllCoursesTitle" runat="server" class="fw-bold mt-5 mb-4 cc-magic-text-main">All Courses</h2>

    <asp:Panel ID="pnlNoResults" runat="server" Visible="false" CssClass="text-center mt-5 mb-5" data-aos="fade-up">
        <h3 class="cc-magic-text-muted">Oops! No courses found.</h3>
        <p class="cc-magic-text-muted">Try using different keywords or selecting a different category.</p>
    </asp:Panel>

    <div class="row">
        <asp:Repeater ID="rptCourses" runat="server">
            <ItemTemplate>
                <div class="col-md-6 col-lg-4 mb-4" data-aos="fade-up">
                    <div class="course-card h-100 course-card-hover d-flex flex-column cc-magic-card">
                        <div class="course-img">
                            <img src='<%# ResolveUrl("~/assets/img/courses/" + Eval("Thumbnail")) %>' alt="Course Image" />
                            <span class="course-category"><%# Eval("Category") %></span>
                        </div>
                        <div class="course-body d-flex flex-column flex-grow-1">
                            <h5 class="fw-bold cc-magic-text-main"><%# Eval("Title") %></h5>
                            
                            <p class="line-clamp-3 mb-4 cc-magic-text-muted">
                                <%# Eval("Description") %>
                            </p>
                            
                            <a href='<%# GetCourseLink(Eval("CourseID")) %>'
                               class="btn btn-outline-primary w-100 mt-auto">
                                View Course
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

</div>

<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet" />
<script> AOS.init({ duration: 800, once: true }); </script>

</asp:Content>