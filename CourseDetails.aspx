<%@ Page Title="Course Details"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="CourseDetails.aspx.cs"
    Inherits="FitHome.CourseDetails" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-5 pt-5">

    <!-- Course Title -->
    <h2 class="fw-bold mb-3" data-aos="fade-down">
        <asp:Label ID="lblTitle" runat="server"></asp:Label>
    </h2>

    <div class="row g-4">

        <!-- Video Section -->
        <div class="col-md-7" data-aos="fade-right">
            <div class="video-wrapper shadow-sm rounded-4 overflow-hidden mb-4">
                <asp:Literal ID="litVideo" runat="server"></asp:Literal>
            </div>
        </div>

        <!-- Info Section -->
        <div class="col-md-5" data-aos="fade-left">

            <p class="text-muted mb-4">
                <asp:Label ID="lblDescription" runat="server"></asp:Label>
            </p>

            <!-- Favorite Star Button -->
            <button id="btnFavorite" class="btn btn-outline-warning btn-lg mb-3 w-100 d-flex align-items-center justify-content-center"
                    runat="server" OnServerClick="btnFavorite_Click">
                <span id="favoriteStar" runat="server" class="me-2">☆</span>
                <asp:Label ID="lblFavoriteText" runat="server" Text="Add to Favorites"></asp:Label>
            </button>

            <!-- Training Buttons -->
            <asp:Button ID="btnStart" runat="server" CssClass="btn btn-success w-100 mb-2" Text="Start Training" OnClick="btnStart_Click"/>
            <asp:Button ID="btnComplete" runat="server" CssClass="btn btn-primary w-100 mb-2" Text="Complete" Visible="false" OnClick="btnComplete_Click"/>

            <a href="CourseCatalog.aspx" class="btn btn-secondary w-100">Back to Catalog</a>

        </div>
    </div>

</div>

<!-- CSS -->
<style>
.video-wrapper iframe {
    width: 100%;
    height: 400px;
}

#btnFavorite {
    font-size: 1.25rem;
    transition: all 0.3s ease;
}
#btnFavorite:hover {
    transform: scale(1.05);
}

#favoriteStar {
    font-size: 1.5rem;
    transition: all 0.3s ease;
}

.btn-success, .btn-primary, .btn-secondary {
    border-radius: 8px;
    padding: 12px;
    font-weight: 600;
}

@media (max-width: 768px) {
    .video-wrapper iframe {
        height: 250px;
    }
}
</style>

<!-- AOS -->
<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 800, once: true });
</script>

</asp:Content>