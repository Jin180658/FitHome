<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="FitHome.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12 text-center text-md-start" data-aos="fade-down">
                <div class="d-inline-flex align-items-center justify-content-center bg-secondary bg-opacity-10 rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="bi bi-person-gear text-secondary fs-2"></i>
                </div>
                <h2 class="fw-bold text-dark">Account Settings</h2>
                <p class="text-muted fs-5">Manage your personal information and security preferences.</p>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-4 text-center"></asp:Label>

        <div class="row">
            <div class="col-lg-4 mb-4" data-aos="fade-right" data-aos-delay="100">
                <div class="card shadow-sm border-0 rounded-4 text-center h-100">
                    <div class="card-body p-4 d-flex flex-column align-items-center justify-content-center">
                        <div class="w-100 text-start mb-4">
                            <h5 class="fw-bold text-dark mb-1">Profile Image</h5>
                            <span class="text-muted small">This is how others see you.</span>
                        </div>
                        
                        <div class="position-relative mb-4">
                            <asp:Image ID="imgProfile" runat="server" ImageUrl="~/assets/img/profiles/defaultUser.png" 
                                CssClass="rounded-circle border border-4 border-white shadow profile-img" />
                        </div>

                        <div class="w-100 text-start bg-light p-3 rounded-3">
                            <label class="form-label text-dark small fw-bold">Update Photo</label>
                            <asp:FileUpload ID="fileProfilePic" runat="server" CssClass="form-control form-control-sm border-0 shadow-none" accept="image/*" onchange="previewImage(this);" />
                            <small class="text-muted d-block mt-2" style="font-size: 0.75rem;">JPG, PNG or WEBP. Max 2MB.</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8" data-aos="fade-up" data-aos-delay="200">
                
                <div class="card shadow-sm border-0 rounded-4 mb-4">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-info-circle me-2 text-primary"></i>
                            <h5 class="fw-bold text-dark mb-0">Basic Information</h5>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-muted small">Username</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control bg-light border-0 py-2 px-3"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-muted small">Email Address</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control bg-light border-0 py-2 px-3 text-muted" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 rounded-4 mb-4">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-rulers me-2 text-success"></i>
                            <h5 class="fw-bold text-dark mb-0">Physical Metrics</h5>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-muted small">Weight (kg)</label>
                                <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control bg-light border-0 py-2 px-3" placeholder="70"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-muted small">Height (cm)</label>
                                <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control bg-light border-0 py-2 px-3" placeholder="165"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 rounded-4 mb-4">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-shield-lock me-2 text-warning"></i>
                            <h5 class="fw-bold text-dark mb-0">Security</h5>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-muted small">New Password</label>
                                <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="••••••••" CssClass="form-control bg-light border-0 py-2 px-3"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium text-muted small">Confirm Password</label>
                                <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="••••••••" CssClass="form-control bg-light border-0 py-2 px-3"></asp:TextBox>
                            </div>
                        </div>
                        <p class="text-muted small mb-0 mt-2"><i class="bi bi-info-circle me-1"></i> Leave blank to keep your current password.</p>
                    </div>
                </div>

                <div class="text-end mb-5">
                    <a href="UserDashboard.aspx" class="btn btn-link text-decoration-none text-muted me-3 fw-bold">Discard Changes</a>
                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save Profile" CssClass="btn btn-primary fw-bold rounded-pill px-5 py-2 shadow-sm" OnClick="btnSaveChanges_Click" />
                </div>

            </div>
        </div>
    </div>

    <style>
        .profile-img { width: 140px; height: 140px; object-fit: cover; }
        
        /* Smooth transitions for input fields to improve user experience */
        .form-control { transition: all 0.2s ease; }
        .form-control:focus { background-color: #fff !important; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .border-start-success { border-left: 4px solid #198754 !important; }
    </style>

    <script>
        // Provides a real-time local preview of the selected profile image
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgProfile.ClientID %>').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }
    </script>
</asp:Content>