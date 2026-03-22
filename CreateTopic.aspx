<%@ Page Title="Start a Discussion" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CreateTopic.aspx.cs" Inherits="FitHome.CreateTopic" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Magic Dictionary for Create Topic Page */
        :root {
            --ct-card-bg: #ffffff;
            --ct-card-alt-bg: #f8f9fa; /* Equivalent to bg-light */
            --ct-text-main: #212529;
            --ct-text-muted: #6c757d;
            --ct-input-bg: #f8f9fa;
            --ct-border: #dee2e6;
        }

        /* 🌙 Auto-invert colors on Dark Mode */
        [data-theme="dark"] {
            --ct-card-bg: #1e1e1e;
            --ct-card-alt-bg: #2a2a2a;
            --ct-text-main: #ffffff;
            --ct-text-muted: #bbbbbb;
            --ct-input-bg: #222222;
            --ct-border: #444444;
        }

        /* Magic Classes for Safe Overrides */
        .ct-magic-card { background-color: var(--ct-card-bg) !important; border: 1px solid var(--ct-border) !important; transition: all 0.3s ease; }
        .ct-magic-card-alt { background-color: var(--ct-card-alt-bg) !important; border: 1px solid var(--ct-border) !important; transition: all 0.3s ease; }
        
        .ct-magic-main { color: var(--ct-text-main) !important; transition: color 0.3s ease; }
        .ct-magic-muted { color: var(--ct-text-muted) !important; transition: color 0.3s ease; }
        
        /* Input Field Magic */
        .ct-magic-input {
            background-color: var(--ct-input-bg) !important;
            color: var(--ct-text-main) !important;
            border: 1px solid var(--ct-border) !important;
            transition: all 0.3s ease;
        }
        .ct-magic-input::placeholder { color: var(--ct-text-muted) !important; }
        .ct-magic-input:focus {
            background-color: var(--ct-card-bg) !important;
            color: var(--ct-text-main) !important;
            box-shadow: 0 5px 15px rgba(0,0,0,0.1) !important;
            outline: none;
        }

        .ct-magic-border-bottom { border-bottom: 1px solid var(--ct-border) !important; }
        .ct-magic-border-top { border-top: 1px solid var(--ct-border) !important; }

        .form-control { transition: all 0.2s ease; resize: none; }
        .hover-primary:hover { color: #0d6efd !important; transform: translateX(-5px); display: inline-block; }
        .transition-all { transition: all 0.2s ease; }
    </style>

    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-3">
            <div class="col-12" data-aos="fade-down">
                <a href="CommunityBoard.aspx" class="text-decoration-none fw-bold hover-primary transition-all ct-magic-muted">
                    <i class="bi bi-arrow-left me-1"></i> Back to Community Board
                </a>
            </div>
        </div>

        <div class="row mb-4">
            <div class="col-12 text-center text-md-start" data-aos="fade-down" data-aos-delay="50">
                <div class="d-inline-flex align-items-center justify-content-center bg-primary bg-opacity-10 rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="bi bi-pencil-square text-primary fs-2"></i>
                </div>
                <h2 class="fw-bold ct-magic-main">Start a New Discussion</h2>
                <p class="fs-5 ct-magic-muted">Share your fitness journey, ask questions, or provide helpful tips.</p>
            </div>
        </div>

        <div class="row">
            <div class="col-lg-8 mb-4 mb-lg-0" data-aos="fade-up" data-aos-delay="100">
                <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3 text-center"></asp:Label>

                <div class="card shadow-sm rounded-4 ct-magic-card">
                    <div class="card-body p-4 p-md-5">
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold ct-magic-main">Discussion Title</label>
                            <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control form-control-lg py-2 px-3 ct-magic-input" placeholder="e.g., What's your favorite post-workout meal?"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <label class="form-label fw-bold ct-magic-main">Details</label>
                            <asp:TextBox ID="txtContent" runat="server" TextMode="MultiLine" Rows="8" CssClass="form-control py-3 px-3 custom-scrollbar ct-magic-input" placeholder="Write your thoughts here..."></asp:TextBox>
                        </div>
                        
                        <div class="text-end mt-5 pt-3 ct-magic-border-top">
                            <a href="CommunityBoard.aspx" class="btn btn-link text-decoration-none me-3 fw-bold ct-magic-muted">Cancel</a>
                            <asp:Button ID="btnPost" runat="server" Text="Post Discussion" CssClass="btn btn-primary fw-bold rounded-pill px-5 py-2 shadow-sm" OnClick="btnPost_Click" />
                        </div>

                    </div>
                </div>
            </div>

            <div class="col-lg-4" data-aos="fade-left" data-aos-delay="200">
                <div class="card rounded-4 h-100 ct-magic-card-alt">
                    <div class="card-body p-4">
                        <h6 class="fw-bold mb-4 pb-2 ct-magic-main ct-magic-border-bottom">
                            <i class="bi bi-lightbulb text-warning me-2 fs-5"></i>Posting Guidelines
                        </h6>
                        <ul class="small ps-3 mb-0 ct-magic-muted" style="line-height: 2;">
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
</asp:Content>