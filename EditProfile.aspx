<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="FitHome.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Magic Dictionary for Edit Profile Page */
        :root {
            --ep-card-bg: #ffffff;
            --ep-card-border: #eeeeee;
            --ep-text-main: #222222;
            --ep-text-muted: #666666;
            --ep-input-bg: #f8f9fa; /* Matches bootstrap bg-light */
            --ep-input-border: #dee2e6;
            --ep-img-border: #ffffff;
        }

        /* 🌙 Auto-invert colors on Dark Mode */
        [data-theme="dark"] {
            --ep-card-bg: #1e1e1e;
            --ep-card-border: #333333;
            --ep-text-main: #ffffff;
            --ep-text-muted: #bbbbbb;
            --ep-input-bg: #2a2a2a;
            --ep-input-border: #444444;
            --ep-img-border: #2a2a2a;
        }

        /* Magic Classes to override hardcoded bootstrap colors safely */
        .ep-magic-card { background-color: var(--ep-card-bg) !important; border: 1px solid var(--ep-card-border) !important; transition: all 0.3s ease; }
        .ep-magic-text-main { color: var(--ep-text-main) !important; transition: color 0.3s ease; }
        .ep-magic-text-muted { color: var(--ep-text-muted) !important; transition: color 0.3s ease; }
        
        /* Input fields and grey boxes wrapper */
        .ep-magic-input { background-color: var(--ep-input-bg) !important; color: var(--ep-text-main) !important; border-color: var(--ep-input-border) !important; transition: all 0.3s ease; }
        .ep-magic-input::placeholder { color: var(--ep-text-muted) !important; }
        
        .ep-magic-img-border { border-color: var(--ep-img-border) !important; transition: border-color 0.3s ease; }

        /* General styles preserved from original */
        .profile-img { width: 140px; height: 140px; object-fit: cover; }
        .form-control { transition: all 0.2s ease; }
        .form-control:focus { background-color: var(--ep-card-bg) !important; box-shadow: 0 5px 15px rgba(0,0,0,0.05); color: var(--ep-text-main) !important; }
        .custom-input-group:focus-within { background-color: var(--ep-card-bg) !important; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .toggle-pwd-btn:hover { color: #0d6efd !important; }
        .transition-all { transition: all 0.2s ease; }
        .hover-primary:hover { color: #0d6efd !important; transform: translateX(-5px); display: inline-block; }
    </style>

    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-3">
            <div class="col-12" data-aos="fade-down">
                <a href="UserDashboard.aspx" class="text-decoration-none fw-bold hover-primary transition-all ep-magic-text-muted">
                    <i class="bi bi-arrow-left me-1"></i> Back to Dashboard
                </a>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-12 text-center text-md-start" data-aos="fade-down" data-aos-delay="50">
                <div class="d-inline-flex align-items-center justify-content-center bg-secondary bg-opacity-10 rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="bi bi-person-gear text-secondary fs-2"></i>
                </div>
                <h2 class="fw-bold ep-magic-text-main">Account Settings</h2>
                <p class="fs-5 ep-magic-text-muted">Manage your personal information and security preferences.</p>
            </div>
        </div>

        <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-4 text-center"></asp:Label>

        <div class="row">
            <div class="col-lg-4 mb-4" data-aos="fade-right" data-aos-delay="100">
                <div class="card shadow-sm border-0 rounded-4 text-center h-100 ep-magic-card">
                    <div class="card-body p-4 d-flex flex-column align-items-center justify-content-center">
                        <div class="w-100 text-start mb-4">
                            <h5 class="fw-bold mb-1 ep-magic-text-main">Profile Image</h5>
                            <span class="small ep-magic-text-muted">This is how others see you.</span>
                        </div>
                        
                        <div class="position-relative mb-4">
                            <asp:Image ID="imgProfile" runat="server" ImageUrl="~/assets/img/profiles/defaultUser.png" 
                                CssClass="rounded-circle border border-4 shadow profile-img ep-magic-img-border" />
                        </div>

                        <div class="w-100 text-start p-3 rounded-3 ep-magic-input">
                            <label class="form-label small fw-bold ep-magic-text-main">Update Photo</label>
                            <asp:FileUpload ID="fileProfilePic" runat="server" CssClass="form-control form-control-sm border-0 shadow-none ep-magic-input" accept="image/*" onchange="previewImage(this);" />
                            <small class="d-block mt-2 ep-magic-text-muted" style="font-size: 0.75rem;">JPG, PNG or WEBP. Max 2MB.</small>
                        </div>
                    </div>
                </div>
            </div>

            <div class="col-lg-8" data-aos="fade-up" data-aos-delay="200">
                
                <div class="card shadow-sm border-0 rounded-4 mb-4 ep-magic-card">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-info-circle me-2 text-primary"></i>
                            <h5 class="fw-bold mb-0 ep-magic-text-main">Basic Information</h5>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium small ep-magic-text-muted">Username</label>
                                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control border-0 py-2 px-3 ep-magic-input"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium small ep-magic-text-muted">Email Address</label>
                                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control border-0 py-2 px-3 ep-magic-input" ReadOnly="true"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 rounded-4 mb-4 ep-magic-card">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-rulers me-2 text-success"></i>
                            <h5 class="fw-bold mb-0 ep-magic-text-main">Physical Metrics</h5>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium small ep-magic-text-muted">Weight (kg)</label>
                                <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control border-0 py-2 px-3 ep-magic-input" placeholder="70"></asp:TextBox>
                            </div>
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium small ep-magic-text-muted">Height (cm)</label>
                                <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control border-0 py-2 px-3 ep-magic-input" placeholder="165"></asp:TextBox>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 rounded-4 mb-4 ep-magic-card">
                    <div class="card-body p-4">
                        <div class="d-flex align-items-center mb-4">
                            <i class="bi bi-shield-lock me-2 text-warning"></i>
                            <h5 class="fw-bold mb-0 ep-magic-text-main">Security</h5>
                        </div>
                        <div class="row">
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium small ep-magic-text-muted">New Password</label>
                                <div class="input-group rounded-3 overflow-hidden custom-input-group ep-magic-input">
                                    <asp:TextBox ID="txtNewPassword" runat="server" TextMode="Password" placeholder="••••••••" CssClass="form-control bg-transparent border-0 py-2 px-3 shadow-none ep-magic-text-main"></asp:TextBox>
                                    <button class="btn btn-light bg-transparent border-0 px-3 shadow-none toggle-pwd-btn ep-magic-text-muted" type="button" onclick="togglePassword('<%= txtNewPassword.ClientID %>', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>
                            
                            <div class="col-md-6 mb-3">
                                <label class="form-label fw-medium small ep-magic-text-muted">Confirm Password</label>
                                <div class="input-group rounded-3 overflow-hidden custom-input-group ep-magic-input">
                                    <asp:TextBox ID="txtConfirmPassword" runat="server" TextMode="Password" placeholder="••••••••" CssClass="form-control bg-transparent border-0 py-2 px-3 shadow-none ep-magic-text-main"></asp:TextBox>
                                    <button class="btn btn-light bg-transparent border-0 px-3 shadow-none toggle-pwd-btn ep-magic-text-muted" type="button" onclick="togglePassword('<%= txtConfirmPassword.ClientID %>', this)">
                                        <i class="bi bi-eye"></i>
                                    </button>
                                </div>
                            </div>
                        </div>
                        <p class="small mb-0 mt-2 ep-magic-text-muted"><i class="bi bi-info-circle me-1"></i> Leave blank to keep your current password.</p>
                    </div>
                </div>

                <div class="text-end mb-5">
                    <a href="UserDashboard.aspx" class="btn btn-link text-decoration-none me-3 fw-bold ep-magic-text-muted">Discard Changes</a>
                    <asp:Button ID="btnSaveChanges" runat="server" Text="Save Profile" CssClass="btn btn-primary fw-bold rounded-pill px-5 py-2 shadow-sm" OnClick="btnSaveChanges_Click" />
                </div>

            </div>
        </div>
    </div>

    <script>
        // File upload image preview
        function previewImage(input) {
            if (input.files && input.files[0]) {
                var reader = new FileReader();
                reader.onload = function (e) {
                    document.getElementById('<%= imgProfile.ClientID %>').src = e.target.result;
                }
                reader.readAsDataURL(input.files[0]);
            }
        }

        // Toggle password visibility
        function togglePassword(inputId, btnElement) {
            var inputField = document.getElementById(inputId);
            var icon = btnElement.querySelector("i");

            if (inputField.type === "password") {
                inputField.type = "text";
                icon.classList.remove("bi-eye");
                icon.classList.add("bi-eye-slash");
            } else {
                inputField.type = "password";
                icon.classList.remove("bi-eye-slash");
                icon.classList.add("bi-eye");
            }
        }
    </script>
</asp:Content>