<%@ Page Title="User Dashboard" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="UserDashboard.aspx.cs" Inherits="FitHome.UserDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5 mb-5">
        
        <div class="row mb-5">
            <div class="col-12 text-center" data-aos="fade-down">
                <h2 class="fw-bold text-dark">Welcome to your Dashboard, <asp:Label ID="lblUsername" runat="server" Text="Member"></asp:Label>! 👋</h2>
                <p class="text-muted fs-5">What would you like to do today?</p>
            </div>
        </div>

        <div class="row justify-content-center align-items-stretch text-center">
            
            <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="100">
                <a href="TrainingHistory.aspx" class="text-decoration-none">
                    <div class="card shadow-sm border-0 h-100 rounded-4 dashboard-card hover-effect">
                        <div class="card-body p-5">
                            <h1 class="display-4 mb-3">📋</h1>
                            <h4 class="fw-bold text-dark">Training History</h4>
                            <p class="text-muted">View your past workouts and track your consistency.</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="200">
                <a href="BMICalculator.aspx" class="text-decoration-none">
                    <div class="card shadow-sm border-0 h-100 rounded-4 dashboard-card hover-effect">
                        <div class="card-body p-5">
                            <h1 class="display-4 mb-3">⚖️</h1>
                            <h4 class="fw-bold text-dark">BMI Calculator</h4>
                            <p class="text-muted">Check your current Body Mass Index and health status.</p>
                        </div>
                    </div>
                </a>
            </div>

            <div class="col-md-4 mb-4" data-aos="fade-up" data-aos-delay="300">
                <a href="EditProfile.aspx" class="text-decoration-none">
                    <div class="card shadow-sm border-0 h-100 rounded-4 dashboard-card hover-effect">
                        <div class="card-body p-5">
                            <h1 class="display-4 mb-3">⚙️</h1>
                            <h4 class="fw-bold text-dark">Edit Profile</h4>
                            <p class="text-muted">Update your weight, height, and account password.</p>
                        </div>
                    </div>
                </a>
            </div>

        </div>
    </div>

    <style>
        .hover-effect { transition: transform 0.3s ease, box-shadow 0.3s ease; }
        .hover-effect:hover { transform: translateY(-5px); box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important; }
    </style>
</asp:Content>