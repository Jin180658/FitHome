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

        <div class="row">
            <asp:Repeater ID="rptFavorites" runat="server">
                <ItemTemplate>
                    <div class="col-md-6 col-lg-4 mb-4">
                        <div class="card shadow-sm h-100 feature-course" data-aos="fade-up">
                            <div class="card-img-top overflow-hidden">
                                <img src="assets/img/<%# Eval("Thumbnail") %>" 
                                     class="img-fluid" 
                                     alt="<%# Eval("Title") %>">
                            </div>
                            <div class="card-body d-flex flex-column">
                                <h5 class="card-title fw-bold"><%# Eval("Title") %></h5>
                                <p class="card-text text-muted mb-2">
                                    <%# Eval("Description").ToString().Length > 100 ? 
                                        Eval("Description").ToString().Substring(0,100) + "..." : Eval("Description") %>
                                </p>
                                <span class="badge bg-primary mb-2"><%# Eval("Category") %></span>
                                <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>' class="btn btn-outline-primary mt-auto">
                                    View Details
                                </a>
                            </div>
                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
        </div>

        <asp:Label ID="lblNoFavorites" runat="server" CssClass="text-center text-muted fs-5 mt-5" Visible="false" Text="You have no favorite courses yet."></asp:Label>

    </div>

    <!-- AOS -->
    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 800, once: true });
    </script>

</asp:Content>