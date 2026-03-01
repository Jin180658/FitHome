<%@ Page Title="Training History" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TrainingHistory.aspx.cs" Inherits="FitHome.TrainingHistory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5 mb-5">
        
        <div class="row mb-4">
            <div class="col-12 text-center" data-aos="fade-down">
                <h2 class="fw-bold text-dark">📋 Training History</h2>
                <p class="text-muted fs-5">Review your completed workouts and track your consistency.</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-10" data-aos="fade-up" data-aos-delay="100">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-4 p-md-5">
                        
                        <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-3 text-center"></asp:Label>

                        <div class="table-responsive">
                            <asp:GridView ID="gvTrainingHistory" runat="server" AutoGenerateColumns="False" 
                                DataKeyNames="ProgressID" OnRowDeleting="gvTrainingHistory_RowDeleting"
                                CssClass="table table-hover align-middle border-bottom" GridLines="None" BorderStyle="None">
                                
                                <HeaderStyle CssClass="table-light text-secondary text-uppercase" />
                                
                                <Columns>
                                    <asp:BoundField DataField="Title" HeaderText="Course Name" />
                                    <asp:BoundField DataField="Category" HeaderText="Category" />
                                    
                                    <asp:BoundField DataField="DateCompleted" HeaderText="Completed On" DataFormatString="{0:dd MMM yyyy, hh:mm tt}" />
                                    
                                    <asp:TemplateField>
                                        <ItemTemplate>
                                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                                CssClass="btn btn-sm btn-outline-danger rounded-pill px-3"
                                                OnClientClick="return confirm('Are you sure you want to delete this workout record?');">
                                                <i class="bi bi-trash"></i> Delete
                                            </asp:LinkButton>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                
                                <EmptyDataTemplate>
                                    <div class="text-center py-5">
                                        <h4 class="text-muted">You haven't completed any workouts yet!</h4>
                                        <a href="Courses.aspx" class="btn btn-primary mt-3 rounded-pill px-4">Find a Course</a>
                                    </div>
                                </EmptyDataTemplate>
                            </asp:GridView>
                        </div>

                        <div class="mt-4 text-center">
                            <a href="UserDashboard.aspx" class="text-secondary text-decoration-none">← Back to Dashboard</a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>