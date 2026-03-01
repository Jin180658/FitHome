<%@ Page Title="Course Catalog"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="CourseCatalog.aspx.cs"
    Inherits="FitHome.CourseCatalog" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <!-- Hero Section -->
    <section class="course-hero">
        <div class="container text-center text-white">
            <h1 class="fw-bold mb-3 hero-title" data-aos="fade-down">
                📚 Explore Our Courses! 💪
            </h1>
            <p class="lead mb-4 hero-subtitle" data-aos="fade-up">
                Learn new skills with structured, high-quality video courses
            </p>
        </div>
    </section>

    <div class="container mt-5 pt-5">

        <!-- Search & Filter -->
        <div class="row mb-4">
            <div class="col-md-6 mb-2">
                <asp:TextBox 
                    ID="txtSearch" 
                    runat="server" 
                    CssClass="form-control"
                    Placeholder="Search by course title">
                </asp:TextBox>
            </div>

            <div class="col-md-4 mb-2">
                <asp:DropDownList 
                    ID="ddlCategory" 
                    runat="server" 
                    CssClass="form-select">
                    <asp:ListItem Text="All Categories" Value="" />
                    <asp:ListItem Text="Yoga" Value="Yoga" />
                    <asp:ListItem Text="Cardio" Value="Cardio" />
                    <asp:ListItem Text="Strength" Value="Strength" />
                </asp:DropDownList>
            </div>

            <div class="col-md-2 mb-2">
                <asp:Button 
                    ID="btnSearch" 
                    runat="server" 
                    Text="Search"
                    CssClass="btn btn-primary w-100"
                    OnClick="btnSearch_Click" />
            </div>
        </div>

        <!-- Featured Courses -->
        <h2 class="fw-bold mb-4">Featured Courses</h2>
        <asp:Repeater ID="rptFeatured" runat="server">
            <ItemTemplate>
                <div class="featured-card mb-4" data-aos="zoom-in">
                    <div class="row g-0 align-items-center">
                        <div class="col-md-5">
                            <img src="assets/img/<%# Eval("Thumbnail") %>" class="img-fluid rounded-start">
                        </div>
                        <div class="col-md-7 p-4">
                            <span class="badge bg-warning text-dark mb-2">FEATURED</span>
                            <h3 class="fw-bold"><%# Eval("Title") %></h3>
                            <p class="text-muted"><%# Eval("Description") %></p>
                            <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>' 
                               class="btn btn-primary mt-2">
                                Start Learning
                            </a>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>

        <!-- All Courses -->
        <h2 class="fw-bold mt-5 mb-4">All Courses</h2>
        <div class="row">
            <asp:Repeater ID="rptCourses" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 mb-4"
                         data-aos="fade-up"
                         data-aos-delay='<%# Container.ItemIndex * 100 %>'>

                        <div class="course-card h-100">

                            <div class="course-img">
                                <img src="assets/img/<%# Eval("Thumbnail") %>" alt="">
                                <span class="course-category"><%# Eval("Category") %></span>
                            </div>

                            <div class="course-body">
                                <h5 class="fw-bold"><%# Eval("Title") %></h5>
                                <p class="text-muted">
                                    <%# Eval("Description").ToString().Length > 90 ?
                                        Eval("Description").ToString().Substring(0,90) + "..." :
                                        Eval("Description") %>
                                </p>

                                <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>' 
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

    <!-- Inline CSS -->
    <style>
    /* Hero Section */
    .course-hero {
        background: linear-gradient(135deg, #4facfe, #00f2fe); 
        padding: 80px 0;
    }

    .hero-title {
        color: #ffffff;
        text-shadow: 2px 2px 8px rgba(0,0,0,0.3);
        font-size: 3rem;
    }

    .hero-subtitle {
        color: #f0f8ff;
        text-shadow: 1px 1px 5px rgba(0,0,0,0.2);
        font-size: 1.25rem;
    }

    /* Featured Card */
    .featured-card {
        background: #fff;
        border-radius: 15px;
        overflow: hidden;
        box-shadow: 0 15px 40px rgba(0,0,0,0.12);
    }

    /* All Course Card */
    .course-card {
        background: #fff;
        border-radius: 15px;
        overflow: hidden;
        transition: all 0.3s ease;
        box-shadow: 0 10px 25px rgba(0,0,0,0.08);
    }

    .course-card:hover {
        transform: translateY(-8px);
        box-shadow: 0 20px 40px rgba(0,0,0,0.15);
    }

    .course-img {
        position: relative;
    }

    .course-img img {
        width: 100%;
        height: 200px;
        object-fit: cover;
    }

    .course-category {
        position: absolute;
        top: 15px;
        left: 15px;
        background: #0d6efd;
        color: #fff;
        padding: 5px 12px;
        font-size: 12px;
        border-radius: 20px;
    }

    .course-body {
        padding: 20px;
    }
    </style>

    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
    <script>
        AOS.init({
            duration: 800,
            once: true
        });
    </script>

</asp:Content>