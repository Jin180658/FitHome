<%@ Page Title="Discussion Thread" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForumThread.aspx.cs" Inherits="FitHome.ForumThread" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <style>
        .forum-card { background-color: #ffffff !important; border: 1px solid #eeeeee !important; }
        .forum-card-alt { background-color: #f8f9fa !important; border: 1px solid #dddddd !important; }
        .forum-text { color: #222222 !important; }
        .forum-muted { color: #666666 !important; }
        .forum-input { background-color: #ffffff !important; color: #222222 !important; border: 1px solid #cccccc !important; }
        
        .forum-input::placeholder { color: #999999 !important; opacity: 1 !important; }
        
        [data-theme="dark"] .forum-card { background-color: #1e1e1e !important; border-color: #333333 !important; }
        [data-theme="dark"] .forum-card-alt { background-color: #2a2a2a !important; border-color: #333333 !important; }
        
        [data-theme="dark"] .forum-text, 
        [data-theme="dark"] a.forum-text { color: #ffffff !important; }
        
        [data-theme="dark"] .forum-muted, 
        [data-theme="dark"] a.forum-muted { color: #bbbbbb !important; }

        [data-theme="dark"] .forum-input,
        [data-theme="dark"] .forum-input:focus { 
            background-color: #2a2a2a !important; 
            color: #ffffff !important; 
            border-color: #444444 !important; 
        }

        [data-theme="dark"] .forum-input::placeholder { 
            color: #aaaaaa !important; 
            opacity: 1 !important; 
        }

        .hover-primary { transition: color 0.2s ease; }
        .hover-primary:hover { color: #0d6efd !important; transform: translateX(-5px); display: inline-block; }
        .form-control:focus { box-shadow: 0 5px 15px rgba(0,0,0,0.1) !important; outline: none; }
    </style>

    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12" data-aos="fade-down">
                <a href="CommunityBoard.aspx" class="text-decoration-none fw-bold hover-primary forum-muted">
                    <i class="bi bi-arrow-left me-1"></i> Back to Community Board
                </a>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-9">
                
                <div class="card border-0 rounded-4 mb-3 shadow-sm forum-card">
                    <div class="card-body p-4 p-md-5">
                        <h2 class="fw-bold mb-4 forum-text"><asp:Label ID="lblTopicTitle" runat="server"></asp:Label></h2>
                        
                        <div class="d-flex align-items-center mb-4 pb-3 border-bottom" style="border-color: #555 !important;">
                            <asp:Image ID="imgAuthorPic" runat="server" CssClass="rounded-circle me-3 border shadow-sm" style="width: 50px; height: 50px; object-fit: cover;" />
                            <div>
                                <h6 class="fw-bold mb-0 forum-text"><asp:Label ID="lblAuthorName" runat="server"></asp:Label></h6>
                                <span class="small forum-muted"><asp:Label ID="lblPostDate" runat="server"></asp:Label></span>
                            </div>
                        </div>

                        <div class="forum-text" style="line-height: 1.8; white-space: pre-wrap; font-size: 1.05rem;"><asp:Label ID="lblTopicContent" runat="server"></asp:Label></div>
                    </div>
                </div>

                <h5 class="fw-bold mb-4 ps-2 border-start border-4 border-primary forum-muted">Replies</h5>

                <asp:Repeater ID="rptReplies" runat="server">
                    <ItemTemplate>
                        <div class="card border-0 rounded-4 mb-3 shadow-sm forum-card">
                            <div class="card-body p-4">
                                <div class="d-flex align-items-start">
                                    <img src='<%# string.IsNullOrEmpty(Convert.ToString(Eval("ProfilePic"))) ? "assets/img/profiles/defaultUser.png" : "assets/img/profiles/" + Eval("ProfilePic") %>' 
                                         class="rounded-circle me-3 border" style="width: 45px; height: 45px; object-fit: cover;" />
                    
                                    <div class="flex-grow-1">
                                        <div class="d-flex justify-content-between align-items-center mb-2">
                                            <h6 class="fw-bold mb-0 forum-text"><%# Eval("Username") %></h6>
                                            <span class="small forum-muted" style="font-size: 0.75rem;"><%# Eval("CreatedAt", "{0:MMM dd, yyyy • HH:mm}") %></span>
                                        </div>
                                        <p class="mb-0 forum-text" style="white-space: pre-wrap;"><%# Eval("ReplyContent") %></p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                    <FooterTemplate>
                        <asp:Panel ID="pnlNoReplies" runat="server" Visible='<%# rptReplies.Items.Count == 0 %>'>
                            <div class="text-center py-4 forum-muted">
                                <i class="bi bi-chat-square-dots fs-1 opacity-50 d-block mb-2"></i>
                                No replies yet. Be the first to share your thoughts!
                            </div>
                        </asp:Panel>
                    </FooterTemplate>
                </asp:Repeater>

                <div class="mt-5" data-aos="fade-up">
                    
                    <asp:Panel ID="pnlLoginPrompt" runat="server" Visible="false">
                        <div class="card border-0 rounded-4 text-center py-5 forum-card-alt">
                            <h5 class="fw-bold forum-text">Join the Conversation</h5>
                            <p class="mb-4 forum-muted">You need to be logged in to leave a reply.</p>
                            <div>
                                <a href="Login.aspx" class="btn btn-primary fw-bold rounded-pill px-4 shadow-sm">Log In / Register</a>
                            </div>
                        </div>
                    </asp:Panel>

                    <asp:Panel ID="pnlReplyForm" runat="server" Visible="false">
                        <div class="card shadow-sm border-0 rounded-4 forum-card">
                            <div class="card-body p-4">
                                <h6 class="fw-bold mb-3 forum-text"><i class="bi bi-reply-fill text-primary me-2"></i>Leave a Reply</h6>
                                <asp:Label ID="lblReplyError" runat="server" CssClass="text-danger fw-bold d-block mb-2"></asp:Label>
                                
                                <asp:TextBox ID="txtReplyContent" runat="server" TextMode="MultiLine" Rows="4" CssClass="form-control py-3 px-3 mb-3 forum-input" placeholder="Write your reply here..."></asp:TextBox>
                                
                                <div class="text-end">
                                    <asp:Button ID="btnSubmitReply" runat="server" Text="Post Reply" CssClass="btn btn-primary fw-bold rounded-pill px-4" OnClick="btnSubmitReply_Click" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>

                </div>

            </div>
        </div>
    </div>
</asp:Content>