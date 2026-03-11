<%@ Page Title="Course Details"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="CourseDetails.aspx.cs"
    Inherits="FitHome.CourseDetails" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container mt-5 pt-5 mb-5 pb-5" style="min-height: 65vh;">
    
    <h2 class="fw-bold mb-3">
        <asp:Label ID="lblTitle" runat="server" />
    </h2>
    
    <div class="card shadow-sm mb-4 border-0 bg-light">
        <div class="card-body p-4">
            <h5 class="fw-bold text-dark mb-3">Course Description</h5>
            <p class="text-muted mb-0" style="line-height: 1.7;">
                <asp:Label ID="lblDescription" runat="server" />
            </p>
        </div>
    </div>

    <asp:Panel ID="pnlVideo" runat="server" Visible="false" CssClass="mb-4">
        <div class="video-wrapper shadow-sm rounded-4 overflow-hidden">
            <asp:Literal ID="litVideo" runat="server" />
        </div>
    </asp:Panel>

    <asp:Panel ID="pnlFavorite" runat="server" Visible="false">
        <button id="btnFavorite" runat="server" onserverclick="btnFavorite_Click"
            class="btn btn-outline-warning w-100 mb-3 fw-bold">
            <span id="favoriteStar" runat="server">☆</span>
            <asp:Label ID="lblFavoriteText" runat="server" Text="Add to Favorites" />
        </button>
    </asp:Panel>

    <% if (Session["UserID"] == null) { %>
        <div class="alert alert-info text-center mt-3 mb-4 border-0 shadow-sm">
            <i class="bi bi-lock-fill me-2"></i> 
            <strong>Members Only!</strong> Please login or register to watch the full video and track your progress.
        </div>
    <% } %>

    <asp:Button ID="btnStart" runat="server"
        Text="Start Training"
        CssClass="btn btn-success w-100 mb-3 py-2 fw-bold"
        OnClick="btnStart_Click" />
        
    <asp:Button ID="btnComplete" runat="server"
        Text="Complete"
        CssClass="btn btn-primary w-100 mb-4 py-2 fw-bold"
        Visible="false"
        OnClick="btnComplete_Click" />

    <asp:Panel ID="pnlAssessment" runat="server" Visible="false" CssClass="mb-4">
        <div class="card border-0 shadow-sm rounded-4" style="background: linear-gradient(135deg, #fff3cd 0%, #fff 100%);">
            <div class="row g-0 align-items-center">
                <div class="col-md-8 p-4">
                    <h4 class="fw-bold text-dark mb-2">
                        <i class="bi bi-patch-question-fill text-warning me-2"></i>Test Your Knowledge
                    </h4>
                    <p class="text-muted mb-0">
                        Finished the training? Take the official assessment to earn your score!
                    </p>
                </div>
                <div class="col-md-4 p-4 text-md-end border-start-md">
                    <asp:HyperLink ID="hlTakeQuiz" runat="server" CssClass="btn btn-warning fw-bold shadow-sm px-4 rounded-pill">
                        Take Quiz <i class="bi bi-arrow-right ms-1"></i>
                    </asp:HyperLink>
                </div>
            </div>
        </div>
    </asp:Panel>
    <a href="CourseCatalog.aspx" class="btn btn-secondary w-100 py-2 fw-bold">Back to Courses</a>

</div>

<style>
/* CSS to ensure iframe and local videos are responsive and fit the container */
.video-wrapper iframe,
.video-wrapper video { width: 100%; height: 450px; }

/* Desktop view line separator for Assessment Card */
@media (min-width: 768px) {
    .border-start-md { border-left: 1px solid rgba(0,0,0,0.1); }
}
</style>
</asp:Content>