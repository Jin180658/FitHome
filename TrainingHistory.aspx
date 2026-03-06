<%@ Page Title="Training History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainingHistory.aspx.cs" Inherits="FitHome.TrainingHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12 text-center" data-aos="fade-down">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="bi bi-activity text-primary fs-2"></i>
                </div>
                <h2 class="fw-bold text-dark">Training History</h2>
                <p class="text-muted fs-5">Track your completed workouts and progress over time.</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8" data-aos="fade-up" data-aos-delay="100">
                
                <div class="card shadow-sm border-0 rounded-4 mb-4 bg-light">
                    <div class="card-body p-3 d-flex justify-content-around text-center">
                        <div>
                            <h5 class="fw-bold text-dark mb-0"><asp:Label ID="lblTotalWorkouts" runat="server" Text="0"></asp:Label></h5>
                            <span class="text-muted small">Workouts Completed</span>
                        </div>
                        <div class="border-start"></div>
                        <div>
                            <h5 class="fw-bold text-success mb-0">Active</h5>
                            <span class="text-muted small">Account Status</span>
                        </div>
                    </div>
                </div>

                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-4">
                        
                        <asp:Label ID="lblStatus" runat="server"></asp:Label>

                        <div class="table-responsive">
                            <asp:GridView ID="gvTrainingHistory" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="ProgressID" OnRowDeleting="gvTrainingHistory_RowDeleting"
                                CssClass="table table-hover align-middle border-bottom mb-0" GridLines="None" BorderStyle="None">
                                
                                <HeaderStyle CssClass="table-light text-secondary small text-uppercase" />
                                
                                <Columns>
                                    <asp:BoundField DataField="Title" HeaderText="Course Name" ItemStyle-CssClass="fw-bold text-dark" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" ItemStyle-CssClass="text-muted" />
                                    <asp:BoundField DataField="DateCompleted" HeaderText="Completed On" DataFormatString="{0:MMM dd, yyyy}" ItemStyle-CssClass="text-muted" />
                                    
                                    <asp:TemplateField ItemStyle-CssClass="text-end">
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                                CssClass="btn btn-sm btn-light text-danger rounded-pill px-3 transition-hover"
                                                OnClientClick="return confirm('Are you sure you want to remove this workout from your history?');">
                                                <i class="bi bi-trash3"></i>
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                
                                <EmptyDataTemplate>
                                    <div class="text-center py-5">
                                        <div class="mb-3">
                                            <i class="bi bi-journal-x text-muted opacity-50" style="font-size: 3.5rem;"></i>
                                        </div>
                                        <h5 class="fw-bold text-dark mb-2">No workouts yet</h5>
                                        <p class="text-muted mb-4">Your completed workouts will appear here.<br />Start your first training session today.</p>
                                        <a href="CourseCatalog.aspx" class="btn btn-primary rounded-pill px-4 fw-bold">Browse Courses</a>
                                    </div>
                                </EmptyDataTemplate>

                            </asp:GridView>
                        </div>

                        <div class="mt-4 text-center pt-3 border-top border-light">
                            <a href="UserDashboard.aspx" class="text-muted text-decoration-none small fw-bold hover-primary">
                                <i class="bi bi-arrow-left me-1"></i> Return to Dashboard
                            </a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Smooth transitions for interactive elements */
        .transition-hover { transition: all 0.2s ease; }
        .transition-hover:hover { background-color: #fee2e2 !important; color: #dc3545 !important; }
        
        /* Subtle color shift for the back-link */
        .hover-primary { transition: color 0.2s ease; }
        .hover-primary:hover { color: #0d6efd !important; }
    </style>
</asp:Content>