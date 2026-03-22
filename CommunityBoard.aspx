<%@ Page Title="Community Board" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="CommunityBoard.aspx.cs" Inherits="FitHome.CommunityBoard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Magic Dictionary for Community Board */
        :root {
            --cb-card-bg: #ffffff;
            --cb-card-border: #ffffff;
            --cb-title: #2b3452;
            --cb-muted: #6c757d;
            --cb-stats-bg: #f8f9fa; 
            --cb-stats-border: #dee2e6;
            --cb-hover-bg: #f1f4f9;
        }

        /* 🌙 Auto-invert colors on Dark Mode */
        [data-theme="dark"] {
            --cb-card-bg: #1e1e1e;
            --cb-card-border: #333333;
            --cb-title: #ffffff;
            --cb-muted: #bbbbbb;
            --cb-stats-bg: #2a2a2a;
            --cb-stats-border: #444444;
            --cb-hover-bg: #333333;
        }

        /* Override Card Colors */
        .cb-magic-card { background-color: var(--cb-card-bg) !important; border: 1px solid var(--cb-card-border) !important; transition: all 0.3s ease; }
        .cb-magic-title { color: var(--cb-title) !important; transition: color 0.3s ease; }
        .cb-magic-muted { color: var(--cb-muted) !important; transition: color 0.3s ease; }
        .cb-magic-stats { background-color: var(--cb-stats-bg) !important; border-color: var(--cb-stats-border) !important; transition: all 0.3s ease; }

        /* ☀️ Light Mode Button (White background, Blue text) */
        .cb-magic-btn {
            background-color: #ffffff !important;
            color: #0d6efd !important; 
            border: 1px solid transparent !important;
            transition: all 0.3s ease;
        }
        .cb-magic-btn:hover {
            background-color: #f8f9fa !important;
            color: #0a58ca !important;
        }

        /* 🌙 Dark Mode Button (Black/Dark background, White text) */
        [data-theme="dark"] .btn.cb-magic-btn {
            background-color: #222222 !important; /* Button becomes black/dark grey */
            color: #ffffff !important; /* Text becomes white */
            border: 1px solid #444444 !important; /* Adds a subtle dark border */
        }
        [data-theme="dark"] .btn.cb-magic-btn:hover {
            background-color: #333333 !important; /* Slightly lighter on hover */
            color: #6ea8fe !important; /* Text glows light blue on hover */
            border-color: #6ea8fe !important;
        }

        /* Hover animations */
        .transition-all { transition: all 0.2s ease-in-out; }
        .hover-lift:hover { transform: translateY(-3px); box-shadow: 0 10px 20px rgba(0,0,0,0.15)!important; }
        .hover-effect { transition: transform 0.2s ease, box-shadow 0.2s ease; border: 1px solid transparent; }
        
        .topic-card-link:hover .hover-effect { 
            transform: translateY(-4px); 
            box-shadow: 0 15px 30px rgba(0,0,0,0.2)!important; 
            border-color: rgba(13, 110, 253, 0.3) !important;
        }
        
        .topic-card-link:hover .topic-title { color: #0d6efd !important; }
        
        .topic-card-link:hover .reply-stats { 
            background-color: var(--cb-hover-bg) !important; 
            border-color: rgba(13, 110, 253, 0.3) !important; 
        }
    </style>

    <div class="container mt-5 pt-4 mb-5">
        
        <div class="card border-0 rounded-4 shadow-lg mb-5 overflow-hidden position-relative" style="background: linear-gradient(135deg, #1e3c72 0%, #2a5298 100%);">
            <div class="position-absolute top-0 end-0 p-5 opacity-25 d-none d-md-block" style="transform: translate(20%, -20%);">
                <i class="bi bi-chat-quote" style="font-size: 14rem; color: #ffffff;"></i>
            </div>
            
            <div class="card-body p-5 text-white position-relative z-1">
                <div class="row align-items-center">
                    <div class="col-lg-8 text-center text-lg-start mb-4 mb-lg-0" data-aos="fade-right">
                        <span class="badge bg-white text-primary mb-3 px-3 py-2 rounded-pill fw-bold shadow-sm" style="letter-spacing: 0.5px;">Forum & Discussions</span>
                        <h1 class="display-5 fw-bolder mb-3 text-white" style="text-shadow: 0 2px 5px rgba(0,0,0,0.3);">FitHome Community</h1>  
                        <p class="fs-5 opacity-75 mb-0 fw-light">Connect, share your progress, and get advice from fellow fitness enthusiasts.</p>
                    </div>
                    <div class="col-lg-4 text-center text-lg-end" data-aos="fade-left">
                        <asp:LinkButton ID="btnStartDiscussion" runat="server" CssClass="btn cb-magic-btn btn-lg fw-bold rounded-pill px-5 py-3 shadow hover-lift" OnClick="btnStartDiscussion_Click">
                            <i class="bi bi-pencil-square me-2"></i>New Topic
                        </asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <div class="row">
            <div class="col-12" data-aos="fade-up" data-aos-delay="100">
                
                <asp:Repeater ID="rptTopics" runat="server">
                    <ItemTemplate>
                        <a href='ForumThread.aspx?id=<%# Eval("TopicID") %>' class="text-decoration-none topic-card-link">
                            <div class="card shadow-sm rounded-4 mb-4 hover-effect overflow-hidden position-relative cb-magic-card">
                                
                                <div class="position-absolute top-0 start-0 h-100 bg-primary opacity-75" style="width: 4px;"></div>

                                <div class="card-body p-4 d-flex align-items-center">
                                    
                                    <div class="me-4 position-relative">
                                        <img src='<%# string.IsNullOrEmpty(Convert.ToString(Eval("ProfilePic"))) ? "assets/img/profiles/defaultUser.png" : "assets/img/profiles/" + Eval("ProfilePic") %>' 
                                             class="rounded-circle border border-3 border-secondary-subtle shadow-sm" style="width: 60px; height: 60px; object-fit: cover;" />
                                    </div>
                                    
                                    <div class="flex-grow-1 pe-3">
                                        <h4 class="fw-bold mb-2 topic-title transition-all cb-magic-title"><%# Eval("Title") %></h4>
                                        <div class="d-flex align-items-center small">
                                            <span class="fw-bold d-flex align-items-center cb-magic-muted"><i class="bi bi-person-fill me-1"></i><%# Eval("Username") %></span>
                                            <span class="mx-2 cb-magic-muted">•</span>
                                            <span class="cb-magic-muted"><i class="bi bi-clock me-1"></i><%# Eval("CreatedAt", "{0:MMM dd, yyyy}") %></span>
                                        </div>
                                    </div>
                                    
                                    <div class="ms-auto d-none d-md-flex align-items-center rounded-4 px-4 py-2 border transition-all reply-stats cb-magic-stats">
                                        <i class="bi bi-chat-dots-fill text-primary opacity-75 fs-4 me-3"></i>
                                        <div class="text-start">
                                            <span class="d-block fw-bolder fs-5 cb-magic-title" style="line-height: 1;"><%# Eval("ReplyCount") %></span>
                                            <span class="text-uppercase fw-bold cb-magic-muted" style="font-size: 0.65rem; letter-spacing: 0.5px;">Replies</span>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                        </a>
                    </ItemTemplate>
                    
                    <FooterTemplate>
                        <asp:Panel ID="pnlNoData" runat="server" Visible='<%# rptTopics.Items.Count == 0 %>'>
                            <div class="text-center py-5 my-5">
                                <div class="d-inline-flex align-items-center justify-content-center rounded-circle mb-3 cb-magic-stats" style="width: 100px; height: 100px;">
                                    <i class="bi bi-inboxes opacity-50 cb-magic-muted" style="font-size: 3rem;"></i>
                                </div>
                                <h4 class="fw-bold cb-magic-title">It's quiet here...</h4>
                                <p class="cb-magic-muted">Be the first to start a discussion and say hello!</p>
                            </div>
                        </asp:Panel>
                    </FooterTemplate>
                </asp:Repeater>

            </div>
        </div>
    </div>
</asp:Content>