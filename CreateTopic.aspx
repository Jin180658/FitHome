<%@ Page Title="Start a Discussion" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateTopic.aspx.cs" Inherits="FitHome.CreateTopic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-3">
            <div class="col-12" data-aos="fade-down">
                <a href="CommunityBoard.aspx" class="text-decoration-none text-muted fw-bold hover-primary transition-all">
                    <i class="bi bi-arrow-left me-1"></i> Back to Community Board
                </a>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-12 text-center text-md-start" data-aos="fade-down" data-aos-delay="50">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="bi bi-pencil-square text-primary fs-2"></i>
                </div>
                <h2 class="fw-bold text-dark">Start a New Discussion</h2>
                <p class="text-muted fs-5">Share your fitness journey, ask questions, or provide helpful tips.</p>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8 mb-4 mb-lg-0" data-aos="fade-up" data-aos-delay="100">
                <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3 text-center"></asp:Label>

                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-4 p-md-5">
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold text-dark">Discussion Title</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control form-control-lg bg-light border-0 py-2 px-3" placeholder="e.g., What's your favorite post-workout meal?"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold text-dark">Details</label>
                            <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="8" CssClass="form-control bg-light border-0 py-3 px-3 custom-scrollbar" placeholder="Write your thoughts here..."></asp:TextBox>
                        </div>
                        
                        <div class="text-end mt-5 pt-3 border-top border-secondary-subtle">
                            <a href="CommunityBoard.aspx" class="btn btn-link text-decoration-none text-muted me-3 fw-bold">Cancel</a>
                            <asp:Button ID="btnPost" runat="server" Text="Post Discussion" CssClass="btn btn-primary fw-bold rounded-pill px-5 py-2 shadow-sm" OnClick="btnPost_Click" />
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-lg-4" data-aos="fade-left" data-aos-delay="200">
                <div class="card bg-light border-0 rounded-4 h-100">
                    <div class="card-body p-4">
                        <h6 class="fw-bold text-dark mb-4 border-bottom pb-2">
                            <i class="bi bi-lightbulb text-warning me-2 fs-5"></i>Posting Guidelines
                        </h6>
                        <ul class="text-muted small ps-3 mb-0" style="line-height: 2;">
                            <li>Be respectful and supportive of other members.</li>
                            <li>Keep the title clear and concise so others know what the topic is about.</li>
                            <li>Avoid sharing sensitive personal information.</li>
                            <li>Make sure your topic is related to fitness, health, or wellbeing.</li>
                        </ul>
                    </div>
                </div>
            </div>

        </div>
    </div>

    <style>
        .form-control { transition: all 0.2s ease; resize: none; }
        .form-control:focus { background-color: #fff !important; box-shadow: 0 5px 15px rgba(0,0,0,0.05); }
        .hover-primary:hover { color: #0d6efd !important; transform: translateX(-5px); display: inline-block; }
        .transition-all { transition: all 0.2s ease; }
    </style>
</asp:Content>