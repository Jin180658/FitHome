<%@ Page Title="Course Details"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="CourseDetails.aspx.cs"
    Inherits="FitHome.CourseDetails" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
<div class="container mt-5 pt-5">
    <h2 class="fw-bold mb-3">
        <asp:Label ID="lblTitle" runat="server" />
    </h2>
    <p class="text-muted mb-4">
        <asp:Label ID="lblDescription" runat="server" />
    </p>

    <asp:Panel ID="pnlVideo" runat="server" Visible="false" CssClass="mb-4">
        <div class="video-wrapper shadow-sm rounded-4 overflow-hidden">
            <asp:Literal ID="litVideo" runat="server" />
        </div>
    </asp:Panel>

    <!-- Add to Favorite -->
    <asp:Panel ID="pnlFavorite" runat="server" Visible="false">
        <button id="btnFavorite" runat="server" onserverclick="btnFavorite_Click"
            class="btn btn-outline-warning w-100 mb-3">
            <span id="favoriteStar" runat="server">☆</span>
            <asp:Label ID="lblFavoriteText" runat="server" Text="Add to Favorites" />
        </button>
    </asp:Panel>

    <!-- Start Training -->
    <asp:Button ID="btnStart" runat="server"
        Text="Start Training"
        CssClass="btn btn-success w-100 mb-2"
        OnClick="btnStart_Click" />
    <asp:Button ID="btnComplete" runat="server"
        Text="Complete"
        CssClass="btn btn-primary w-100 mb-2"
        Visible="false"
        OnClick="btnComplete_Click" />

    <a href="CourseCatalog.aspx" class="btn btn-secondary w-100">Back</a>
</div>

<style>
.video-wrapper iframe,
.video-wrapper video { width: 100%; height: 400px; }
</style>
</asp:Content>