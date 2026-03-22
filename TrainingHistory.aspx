<%@ Page Title="Training History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainingHistory.aspx.cs" Inherits="FitHome.TrainingHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        :root {
            --th-card-bg: #ffffff;
            --th-card-border: #eeeeee;
            --th-text-title: #222222;
            --th-text-muted: #666666;
            --th-table-border: #dddddd;
        }

        [data-theme="dark"] {
            --th-card-bg: #1e1e1e;
            --th-card-border: #333333;
            --th-text-title: #ffffff; 
            --th-text-muted: #bbbbbb;  
            --th-table-border: #444444;    
            
            --bs-body-color: #ffffff !important;
            --bs-table-color: #ffffff !important;
            --bs-table-bg: transparent !important;
            --bs-table-border-color: #444444 !important;
            --bs-table-striped-color: #ffffff !important;
            --bs-table-hover-color: #ffffff !important;
            --bs-table-hover-bg: rgba(255, 255, 255, 0.05) !important;
        }

        .th-magic-card {
            background-color: var(--th-card-bg) !important;
            border: 1px solid var(--th-card-border) !important;
            transition: background-color 0.4s ease, border-color 0.4s ease;
        }

        .th-magic-title { color: var(--th-text-title) !important; transition: color 0.4s ease; }
        .th-magic-muted { color: var(--th-text-muted) !important; transition: color 0.4s ease; }

        [data-theme="dark"] .table,
        [data-theme="dark"] .table td, 
        [data-theme="dark"] .table th,
        [data-theme="dark"] .table span,
        [data-theme="dark"] .table a,
        [data-theme="dark"] .text-muted,
        [data-theme="dark"] .text-dark,
        [data-theme="dark"] .fw-bold {
            color: #ffffff !important;
            border-bottom-color: #444444 !important;
            background-color: transparent !important;
        }
        
        .hover-primary { transition: color 0.2s ease; }
        .hover-primary:hover { color: #007bff !important; }
    </style>

    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12 text-center" data-aos="fade-down">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="bi bi-activity text-primary fs-2"></i>
                </div>
                <h2 class="fw-bold th-magic-title">Training History</h2>
                <p class="fs-5 th-magic-muted">Track your completed workouts and progress over time.</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-10" data-aos="fade-up" data-aos-delay="100">
                
                <div class="card shadow-sm rounded-4 mb-4 th-magic-card">
                    <div class="card-body p-3 d-flex justify-content-around text-center">
                        <div>
                            <h5 class="fw-bold mb-0 th-magic-title"><asp:Label ID="lblTotalWorkouts" runat="server" Text="0"></asp:Label></h5>
                            <span class="small th-magic-muted">Workouts Completed</span>
                        </div>
                        <div class="border-start" style="border-color: var(--th-card-border) !important;"></div>
                        <div>
                            <h5 class="fw-bold text-success mb-0">Active</h5>
                            <span class="small th-magic-muted">Account Status</span>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm rounded-4 th-magic-card">
                    <div class="card-body p-4">
                        
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>

                        <div class="table-responsive">
                            <asp:GridView ID="gvTrainingHistory" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="ProgressID" OnRowDeleting="gvTrainingHistory_RowDeleting"
                                CssClass="table align-middle mb-0" GridLines="None" BorderStyle="None">
                                
                                <HeaderStyle CssClass="small text-uppercase" />
                                
                                <Columns>
                                    <asp:BoundField DataField="Title" HeaderText="Course Name" ItemStyle-CssClass="fw-bold th-magic-title" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" ItemStyle-CssClass="th-magic-muted" />
                                    <asp:BoundField DataField="DateCompleted" HeaderText="Completed On" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-CssClass="th-magic-muted" />
                                    
                                    <asp:TemplateField HeaderText="Assessment" ItemStyle-CssClass="text-center">
                                        <ItemTemplate>
                                            <%# GetScoreHtml(Eval("BestScore"), Eval("QuizQuestionCount"), Eval("CourseID"), Eval("ProgressID")) %>
                                        </ItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ItemStyle-CssClass="text-end">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                                CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                                OnClientClick="return confirm('Are you sure you want to remove this workout from your history?');">
                                                <i class="bi bi-trash3"></i>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                
                                <EmptyDataTemplate>
                                    <div class="text-center py-5">
                                        <div class="mb-3">
                                            <i class="bi bi-journal-x opacity-50 th-magic-muted" style="font-size: 3.5rem;"></i>
                                        </div>
                                        <h5 class="fw-bold mb-2 th-magic-title">No workouts yet</h5>
                                        <p class="mb-4 th-magic-muted">Your completed workouts will appear here.<br />Start your first training session today.</p>
                                        <a href="CourseCatalog.aspx" class="btn btn-primary rounded-pill px-4 fw-bold">Browse Courses</a>
                                    </div>
                                </EmptyDataTemplate>

                            </asp:GridView>
                        </div>

                        <div class="mt-4 text-center pt-3" style="border-top: 1px solid var(--th-card-border);">
                            <a href="UserDashboard.aspx" class="text-decoration-none small fw-bold hover-primary th-magic-muted">
                                <i class="bi bi-arrow-left me-1"></i> Return to Dashboard
                            </a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>