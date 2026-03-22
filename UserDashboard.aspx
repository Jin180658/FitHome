<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="FitHome.UserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12" data-aos="fade-down">
                <h2 class="fw-bold">Welcome back, <asp:Label ID="lblUsername" runat="server" Text="Member"></asp:Label> 👋</h2>
                <p class="text-muted fs-5"><asp:Label ID="lblQuote" runat="server"></asp:Label></p>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-4 mb-4" data-aos="fade-right" data-aos-delay="100">
                <div class="card shadow-sm border-0 rounded-4 text-center h-100 pb-3">
                    <div class="card-body pt-5">
                        <asp:Image ID="imgProfileLarge" runat="server" ImageUrl="~/assets/img/profiles/defaultUser.png" 
                            CssClass="rounded-circle mb-3 border border-3 border-secondary-subtle" 
                            style="width: 130px; height: 130px; object-fit: cover;" />
                        
                        <h3 class="fw-bold"><asp:Label ID="lblCardName" runat="server" Text="Member"></asp:Label></h3>
                        <p class="text-muted mb-4">FitHome Member</p>
                        
                        <div class="mb-4 text-start w-75 mx-auto">
                            <div class="d-flex justify-content-between small text-muted mb-1">
                                <span>Profile Completion</span>
                                <span class="fw-bold"><asp:Label ID="lblProgressText" runat="server">0%</asp:Label></span>
                            </div>
                            <div class="progress" style="height: 6px;">
                                <div id="divProgressBar" runat="server" class="progress-bar bg-success" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="100"></div>
                            </div>
                        </div>

                        <ul class="list-group list-group-flush text-start w-75 mx-auto mb-4">
                            <li class="list-group-item bg-transparent px-0 d-flex justify-content-between align-items-center border-bottom-dashed">
                                <span class="fw-bold"><i class="bi bi-envelope me-2 text-primary"></i>Email</span> 
                                <asp:Label ID="lblEmail" runat="server" CssClass="text-muted" Text="Not set"></asp:Label>
                            </li>
                            <li class="list-group-item bg-transparent px-0 d-flex justify-content-between align-items-center border-bottom-dashed">
                                <span class="fw-bold"><i class="bi bi-rulers me-2 text-success"></i>Height</span> 
                                <asp:Label ID="lblHeight" runat="server" CssClass="text-muted" Text="-- cm"></asp:Label>
                            </li>
                            <li class="list-group-item bg-transparent px-0 d-flex justify-content-between align-items-center">
                                <span class="fw-bold"><i class="bi bi-speedometer2 me-2 text-warning"></i>Weight</span> 
                                <asp:Label ID="lblWeight" runat="server" CssClass="text-muted" Text="-- kg"></asp:Label>
                            </li>
                        </ul>

                        <asp:Button ID="btnLogout" runat="server" Text="Logout" CssClass="btn btn-outline-danger px-4 rounded-pill fw-bold" OnClick="btnLogout_Click" />
                    </div>
                </div>
            </div>

            <div class="col-lg-8">
                
                <div class="row mb-4" data-aos="fade-up" data-aos-delay="150">
                    <div class="col-12">
                        <div class="card shadow-sm border-0 rounded-4 dashboard-card p-2 bg-light">
                            <div class="card-body d-flex align-items-center">
                                <div class="icon-box me-3 shadow-sm">
                                    <i class="bi bi-trophy text-warning fs-3"></i>
                                </div>
                                <div>
                                    <h5 class="fw-bold mb-1">Your Latest Progress</h5>
                                    <p class="mb-0 text-muted"><asp:Label ID="lblRecentProgress" runat="server"></asp:Label></p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <div class="col-md-6 mb-4" data-aos="fade-up" data-aos-delay="200">
                        <a href="TrainingHistory.aspx" class="text-decoration-none">
                            <div class="card shadow-sm border-0 h-100 rounded-4 dashboard-card hover-effect text-start">
                                <div class="card-body p-4 d-flex flex-column">
                                    <div class="icon-box mb-3">
                                        <i class="bi bi-clipboard2-data display-5 text-primary"></i>
                                    </div>
                                    <h4 class="fw-bold mb-2">Training History</h4>
                                    <p class="text-muted small mb-0">View your past workouts, completed courses, and track your fitness consistency.</p>
                                </div>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-6 mb-4" data-aos="fade-up" data-aos-delay="300">
                        <a href="BMICalculator.aspx" class="text-decoration-none">
                            <div class="card shadow-sm border-0 h-100 rounded-4 dashboard-card hover-effect text-start">
                                <div class="card-body p-4 d-flex flex-column">
                                    <div class="icon-box mb-3">
                                        <i class="bi bi-heart-pulse display-5 text-success"></i>
                                    </div>
                                    <h4 class="fw-bold mb-2">BMI Calculator</h4>
                                    <p class="text-muted small mb-0">Check your current Body Mass Index and understand your overall health status.</p>
                                </div>
                            </div>
                        </a>
                    </div>

                    <div class="col-md-12 mb-4" data-aos="fade-up" data-aos-delay="400">
                        <a href="EditProfile.aspx" class="text-decoration-none">
                            <div class="card shadow-sm border-0 rounded-4 dashboard-card hover-effect text-start">
                                <div class="card-body p-4 d-flex align-items-center">
                                    <div class="icon-box me-4">
                                        <i class="bi bi-person-gear display-5 text-secondary"></i>
                                    </div>
                                    <div>
                                        <h4 class="fw-bold mb-1">Account Settings</h4>
                                        <p class="text-muted small mb-0">Update your password, email, weight, and height to keep your data accurate.</p>
                                    </div>
                                    <div class="ms-auto d-none d-sm-block">
                                        <span class="btn btn-sm btn-outline-secondary rounded-pill px-3 fw-bold">Edit Profile</span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div> 
        </div>
    </div>

    <style>
        .hover-effect { 
            transition: transform 0.3s ease, box-shadow 0.3s ease, border-color 0.3s ease; 
            border: 1px solid transparent;
        }
        .hover-effect:hover { 
            transform: translateY(-5px); 
            box-shadow: 0 1rem 2.5rem rgba(0,0,0,.08) !important; 
            border-color: rgba(0,0,0,.1) !important;
        }
        
        .border-bottom-dashed { border-bottom: 1px dashed #dee2e6; }
        
        .icon-box {
            width: 60px; height: 60px; 
            background: rgba(128, 128, 128, 0.1); 
            border-radius: 12px; 
            display: flex; align-items: center; justify-content: center;
        }
    </style>
</asp:Content>