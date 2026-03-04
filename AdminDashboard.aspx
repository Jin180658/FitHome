<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="FitHome.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    
    <style>
        /* Modern Metric Card Styles */
        .metric-card {
            border: none;
            border-radius: 15px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
            background-color: white;
        }
        
        .metric-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.08) !important;
        }

        /* Accent border on the left side */
        .border-left-primary { border-left: 5px solid var(--fh-navy) !important; }
        .border-left-success { border-left: 5px solid var(--fh-orange) !important; }

        /* Icon background circle */
        .icon-circle {
            width: 60px;
            height: 60px;
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.5rem;
        }
        
        .bg-navy-light { background-color: rgba(0, 45, 90, 0.1); color: var(--fh-navy); }
        .bg-orange-light { background-color: rgba(255, 157, 0, 0.1); color: var(--fh-orange); }
        
        /* Chart container */
        .chart-container {
            position: relative;
            height: 300px;
            width: 100%;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h3 class="fw-bold text-dark">Welcome back, <asp:Label ID="lblAdminName" runat="server" Text="Admin"></asp:Label> 👋</h3>
        <p class="text-muted mb-0">Here is what's happening today.</p>
    </div>

    <div class="row mb-4">
        
        <div class="col-md-6 mb-3">
            <div class="card metric-card shadow-sm border-left-primary h-100 py-2" 
                 onclick="window.location.href='ManageCourses.aspx';" 
                 style="cursor: pointer;" title="Click to view all courses">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs fw-bold text-uppercase mb-1" style="color: var(--fh-navy);">Total Courses</div>
                            <div class="h2 mb-0 fw-bold text-dark">
                                <asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>
                        <div class="col-auto">
                            <div class="icon-circle bg-navy-light">
                                <i class="fas fa-video"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-6 mb-3">
            <div class="card metric-card shadow-sm border-left-success h-100 py-2" 
                 onclick="window.location.href='ManageUsers.aspx';" 
                 style="cursor: pointer;" title="Click to view all users">
                <div class="card-body">
                    <div class="row align-items-center">
                        <div class="col mr-2">
                            <div class="text-xs fw-bold text-uppercase mb-1" style="color: var(--fh-orange);">Registered Users</div>
                            <div class="h2 mb-0 fw-bold text-dark">
                                <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                            </div>
                        </div>
                        <div class="col-auto">
                            <div class="icon-circle bg-orange-light">
                                <i class="fas fa-users"></i>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row">
        <div class="col-md-8 mb-4">
            <div class="card shadow-sm border-0" style="border-radius: 15px;">
                <div class="card-header bg-white border-0 pt-4 pb-0">
                    <h5 class="fw-bold text-dark"><i class="fas fa-chart-pie me-2 text-warning"></i>Course Distribution by Category</h5>
                </div>
                <div class="card-body">
                    <div class="chart-container d-flex justify-content-center">
                        <canvas id="categoryChart"></canvas>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm border-0 h-100" style="border-radius: 15px;">
                <div class="card-header bg-white border-0 pt-4 pb-0">
                    <h5 class="fw-bold text-dark"><i class="fas fa-user-plus me-2 text-success"></i>Newest Members</h5>
                </div>
                <div class="card-body p-0">
                    <ul class="list-group list-group-flush mt-2">
                        
                        <asp:Repeater ID="rptRecentUsers" runat="server">
                            <ItemTemplate>
                                <li class="list-group-item d-flex justify-content-between align-items-center border-0 px-4 py-3">
                                    <div class="d-flex align-items-center">
                                        <div class="icon-circle bg-light text-secondary me-3" style="width: 45px; height: 45px; font-size: 1.2rem;">
                                            <i class="fas fa-user"></i>
                                        </div>
                                        <div>
                                            <h6 class="mb-0 fw-bold text-dark"><%# Eval("Username") %></h6>
                                            <small class="text-muted"><%# Eval("Email") %></small>
                                        </div>
                                    </div>
                                </li>
                            </ItemTemplate>
                        </asp:Repeater>

                        <asp:PlaceHolder ID="phNoUsers" runat="server" Visible="false">
                            <li class="list-group-item border-0 text-center text-muted py-4">No users registered yet.</li>
                        </asp:PlaceHolder>

                    </ul>
                </div>
                <div class="card-footer bg-white border-0 text-center pb-3">
                    <a href="ManageUsers.aspx" class="text-decoration-none small fw-bold" style="color: var(--fh-navy);">View All Users <i class="fas fa-arrow-right ms-1"></i></a>
                </div>
            </div>
        </div>
    </div>

    <asp:Literal ID="litChartScript" runat="server"></asp:Literal>

</asp:Content>