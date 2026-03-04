<%@ Page Title="My Favorites"
Language="C#"
MasterPageFile="~/Site.Master"
AutoEventWireup="true"
CodeBehind="MyFavorites.aspx.cs"
Inherits="FitHome.MyFavorites" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-5 pt-5">
    <!-- Page Title -->
    <h2 class="fw-bold text-center mb-4" style="color:#ff6600;">⭐ My Favorite Courses</h2>

    <!-- Category Filter -->
    <div class="row mb-4 justify-content-center">
        <div class="col-md-4">
            <asp:DropDownList ID="ddlCategoryFilter" runat="server" CssClass="form-select"
                AutoPostBack="true" OnSelectedIndexChanged="ddlCategoryFilter_SelectedIndexChanged">
                <asp:ListItem Text="All Categories" Value="" />
                <asp:ListItem Text="Yoga" Value="Yoga" />
                <asp:ListItem Text="Cardio" Value="Cardio" />
                <asp:ListItem Text="Strength" Value="Strength" />
            </asp:DropDownList>
        </div>
    </div>

    <!-- Favorites List -->
    <div class="row">
        <asp:Repeater ID="rptFavorites" runat="server" OnItemCommand="rptFavorites_ItemCommand">
            <ItemTemplate>
                <div class="col-md-6 col-lg-4 mb-4" data-aos="fade-up">
                    <div class="card shadow-sm h-100 feature-course course-card-hover">
                        <!-- Thumbnail -->
                        <div class="card-img-top overflow-hidden">
                            <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>'>
                                <img src="assets/img/<%# Eval("Thumbnail") %>" class="img-fluid" alt="<%# Eval("Title") %>">
                            </a>
                        </div>
                        <div class="card-body d-flex flex-column">
                            <!-- Title -->
                            <h5 class="card-title fw-bold">
                                <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>'
                                   class="text-dark text-decoration-none">
                                    <%# Eval("Title") %>
                                </a>
                            </h5>
                            <!-- Description -->
                            <p class="card-text text-muted mb-2">
                                <%# Eval("Description").ToString().Length > 100 ?
                                    Eval("Description").ToString().Substring(0,100) + "..." :
                                    Eval("Description") %>
                            </p>
                            <!-- Category -->
                            <span class="badge bg-primary mb-3"><%# Eval("Category") %></span>
                            <!-- Buttons -->
                            <div class="mt-auto d-flex gap-2">
                                <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>'
                                   class="btn btn-outline-primary flex-fill">View Details</a>
                                <asp:Button ID="btnRemove" runat="server" Text="Remove"
                                    CssClass="btn btn-outline-danger flex-fill"
                                    CommandName="Remove"
                                    CommandArgument='<%# Eval("CourseID") %>'
                                    OnClientClick="return confirm('Remove this course from favorites?');" />
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Label ID="lblNoFavorites" runat="server"
        CssClass="text-center text-muted fs-5 mt-5"
        Visible="false"
        Text="You have no favorite courses yet.">
    </asp:Label>
</div>

<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });
</script>

<style>
.card-img-top img { transition: transform 0.3s ease; }
.card-img-top img:hover { transform: scale(1.05); }
.feature-course .card-body a.text-dark { transition: color 0.3s; }
.feature-course .card-body a.text-dark:hover { color: #ff6600; }
.course-card-hover { transition: transform 0.3s ease, box-shadow 0.3s ease; }
.course-card-hover:hover { transform: translateY(-6px); box-shadow: 0 15px 35px rgba(0,0,0,0.2); }
</style>

</asp:Content>