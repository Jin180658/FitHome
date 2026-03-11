<%@ Page Title="My Favorites"
    Language="C#"
    MasterPageFile="~/Site.Master"
    AutoEventWireup="true"
    CodeBehind="MyFavorites.aspx.cs"
    Inherits="FitHome.MyFavorites" %>

<asp:Content ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="container mt-5 pt-5 mb-5">
    
    <div class="d-flex flex-column flex-md-row justify-content-between align-items-md-center mb-4 border-bottom pb-3" data-aos="fade-down">
        <h2 class="fw-bold m-0" style="color:#ff6600;">
            <i class="bi bi-star-fill text-warning me-2"></i>My Favorites
        </h2>
        
        <div class="mt-3 mt-md-0" style="min-width: 200px;">
            <asp:DropDownList ID="ddlCategoryFilter" runat="server" CssClass="form-select form-select-sm"
                AutoPostBack="true" OnSelectedIndexChanged="ddlCategoryFilter_SelectedIndexChanged">
                <asp:ListItem Text="All Categories" Value="" />
                <asp:ListItem Text="Yoga" Value="Yoga" />
                <asp:ListItem Text="Cardio" Value="Cardio" />
                <asp:ListItem Text="Strength" Value="Strength" />
            </asp:DropDownList>
        </div>
    </div>

    <div class="row">
        <asp:Repeater ID="rptFavorites" runat="server" OnItemCommand="rptFavorites_ItemCommand">
            <ItemTemplate>
                <div class="col-lg-6 mb-3" data-aos="fade-up">
                    <div class="card shadow-sm h-100 course-card-hover border-0">
                        <div class="row g-0 h-100">
                            
                            <div class="col-4">
                                <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>' class="d-block h-100">
                                    <img src='<%# "assets/img/courses/" + Eval("Thumbnail") %>' 
                                         class="img-fluid rounded-start h-100 w-100 object-fit-cover" 
                                         alt='<%# Eval("Title") %>' 
                                         style="min-height: 120px; max-height: 140px;">
                                </a>
                            &nbsp;&nbsp;</div>
                            
                            <div class="col-8">
                                <div class="card-body d-flex flex-column h-100 py-2 px-3">
                                    <div class="d-flex justify-content-between align-items-start mb-1">
                                        <span class="badge bg-primary"><%# Eval("Category") %></span>
                                    </div>
                                    
                                    <h6 class="card-title fw-bold mb-2 line-clamp-2">
                                        <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>' class="text-dark text-decoration-none title-hover">
                                            <%# Eval("Title") %>
                                        </a>
                                    </h6>
                                    
                                    <div class="mt-auto d-flex gap-2">
                                        <a href='CourseDetails.aspx?id=<%# Eval("CourseID") %>' class="btn btn-sm btn-primary w-50">
                                            <i class="bi bi-play-circle me-1"></i>View
                                        </a>
                                        <asp:Button ID="btnRemove" runat="server" Text="Remove"
                                            CssClass="btn btn-sm btn-outline-danger w-50"
                                            CommandName="Remove"
                                            CommandArgument='<%# Eval("CourseID") %>'
                                            OnClientClick="return confirm('Remove this course from your favorites?');" />
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>

    <asp:Label ID="lblNoFavorites" runat="server"
        CssClass="text-center text-muted fs-5 mt-5 d-block"
        Visible="false"
        Text="You have no favorite courses yet. Go explore!">
    </asp:Label>
</div>

<link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet" />
<script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
<script>
    AOS.init({ duration: 600, once: true });
</script>

<style>
/* Customize styles to enhance the overall look */
.object-fit-cover { 
    object-fit: cover; 
}
.course-card-hover { 
    transition: transform 0.2s ease, box-shadow 0.2s ease; 
    border-radius: 8px; 
    overflow: hidden;
    background: #fdfdfd;
}
.course-card-hover:hover { 
    transform: translateY(-3px); 
    box-shadow: 0 8px 20px rgba(0,0,0,0.1) !important; 
}
.title-hover {
    transition: color 0.3s ease;
}
.title-hover:hover {
    color: #ff6600 !important;
}
/* Limits the header to a maximum of two lines; display an ellipsis if it exceeds this limit. */
.line-clamp-2 {
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
    overflow: hidden;
}
</style>

</asp:Content>