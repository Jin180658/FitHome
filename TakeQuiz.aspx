<%@ Page Title="Course Assessment" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="TakeQuiz.aspx.cs" Inherits="FitHome.TakeQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <section class="bg-light py-5 border-bottom">
        <div class="container text-center" data-aos="fade-down">
            <h1 class="fw-bold" style="color: #ff6600;">
                <i class="bi bi-journal-check me-2"></i>Course Assessment
            </h1>
            <p class="lead text-muted mt-2" id="lblCourseTitle" runat="server">
                Test your knowledge and earn your score!
            </p>
        </div>
    </section>

    <div class="container py-5 mb-5" style="max-width: 800px;">
        
        <asp:Panel ID="pnlQuiz" runat="server">
            <asp:Repeater ID="rptQuestions" runat="server" OnItemDataBound="rptQuestions_ItemDataBound">
                <ItemTemplate>
                    <div class="card border-0 shadow-sm rounded-4 mb-4" data-aos="fade-up">
                        <div class="card-body p-4 p-md-5">
                            
                            <h5 class="fw-bold mb-4 text-dark lh-base">
                                <span class="text-primary me-1"><%# Container.ItemIndex + 1 %>.</span> 
                                <%# Eval("QuestionText") %>
                            </h5>
                            
                            <asp:HiddenField ID="hfQuestionID" runat="server" Value='<%# Eval("QuestionID") %>' />
                            <asp:HiddenField ID="hfCorrectAnswer" runat="server" Value='<%# Eval("CorrectAnswer") %>' />
                            
                            <div class="quiz-options">
                                <asp:RadioButtonList ID="rblOptions" runat="server" CssClass="custom-radio-list" RepeatLayout="Flow">
                                    <%-- The text of these options will be populated from code-behind to avoid binding errors --%>
                                    <asp:ListItem Value="A"></asp:ListItem>
                                    <asp:ListItem Value="B"></asp:ListItem>
                                    <asp:ListItem Value="C"></asp:ListItem>
                                    <asp:ListItem Value="D"></asp:ListItem>
                                </asp:RadioButtonList>
                            </div>

                        </div>
                    </div>
                </ItemTemplate>
            </asp:Repeater>
            
            <div class="text-center mt-5" data-aos="fade-up">
                <asp:Button ID="btnSubmit" runat="server" Text="Submit Assessment" 
                    CssClass="btn btn-primary btn-lg px-5 rounded-pill fw-bold shadow-sm" 
                    OnClick="btnSubmit_Click" 
                    OnClientClick="return confirm('Are you sure you want to submit your answers?');" />
            </div>
        </asp:Panel>

        <asp:Panel ID="pnlResult" runat="server" Visible="false">
            <div class="card border-0 shadow rounded-4 text-center p-5" data-aos="zoom-in">
                <h1 class="display-1 text-warning mb-3">
                    <i class="bi bi-trophy-fill"></i>
                </h1>
                <h2 class="fw-bold text-dark mb-2">Assessment Completed!</h2>
                <p class="text-muted fs-5 mb-4">You have successfully submitted your answers.</p>
                
                <div class="bg-light rounded-4 p-4 d-inline-block mx-auto mb-4 border">
                    <span class="d-block text-secondary fw-bold text-uppercase tracking-wider mb-1">Your Final Score</span>
                    <h1 class="display-3 fw-bold text-primary m-0" id="lblScore" runat="server">0 / 0</h1>
                </div>
                
                <div>
                    <a href="UserDashboard.aspx" class="btn btn-outline-primary rounded-pill px-4 me-2">Go to Dashboard</a>
                    <a href="CourseCatalog.aspx" class="btn btn-primary rounded-pill px-4">Explore More Courses</a>
                </div>
            </div>
        </asp:Panel>

    </div>

    <style>
        /* Style the RadioButtonList to look modern */
        .custom-radio-list span {
            display: block;
            margin-bottom: 12px;
            padding: 12px 20px;
            border: 1px solid #e0e0e0;
            border-radius: 8px;
            cursor: pointer;
            transition: all 0.2s ease;
            background: #fdfdfd;
        }
        .custom-radio-list input[type="radio"] {
            margin-right: 12px;
            transform: scale(1.2);
            cursor: pointer;
        }
        /* Hover effect for the option containers */
        .custom-radio-list span:hover {
            border-color: #0d6efd;
            background-color: #f0f7ff;
        }
        .tracking-wider {
            letter-spacing: 2px;
        }
    </style>

    <link href="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.css" rel="stylesheet" />
    <script src="https://cdn.jsdelivr.net/npm/aos@2.3.4/dist/aos.js"></script>
    <script>
        AOS.init({ duration: 600, once: true });
    </script>
</asp:Content>