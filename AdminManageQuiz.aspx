<%@ Page Title="Manage Quizzes" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminManageQuiz.aspx.cs" Inherits="FitHome.AdminManageQuiz" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="container-fluid px-4 py-4 mb-5">
        
        <div class="d-flex justify-content-between align-items-center mb-4 pb-2 border-bottom">
            <h3 class="fw-bold text-dark m-0">
                <i class="bi bi-ui-checks text-primary me-2"></i>Manage Course Quizzes
            </h3>
        </div>

        <div class="card border-0 shadow-sm rounded-3 mb-4">
            <div class="card-body p-4 d-flex flex-column flex-md-row align-items-md-center gap-3">
                <h5 class="fw-bold text-secondary m-0 text-nowrap">
                    <i class="bi bi-book me-2"></i>Target Course
                </h5>
                <asp:DropDownList ID="ddlCourses" runat="server" CssClass="form-select form-select-lg w-auto flex-grow-1" AutoPostBack="true" OnSelectedIndexChanged="ddlCourses_SelectedIndexChanged" style="max-width: 400px;">
                    <asp:ListItem Text="-- Select a Course --" Value="0"></asp:ListItem>
                </asp:DropDownList>
            </div>
        </div>

        <asp:Panel ID="pnlManageQuiz" runat="server" Visible="false">
            <div class="row g-4">
                
                <div class="col-lg-5">
                    <div class="card border-0 shadow-sm rounded-3 h-100">
                        <div class="card-body p-4">
                            <h5 class="fw-bold text-dark mb-4 border-bottom pb-2">
                                <i class="bi bi-plus-circle-dotted me-2 text-success"></i>Add Question
                            </h5>
                            
                            <div class="mb-3">
                                <label class="form-label text-muted fw-bold small text-uppercase">Question Text</label>
                                <asp:TextBox ID="txtQuestion" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3" Placeholder="e.g. What is the main benefit of Cardio?"></asp:TextBox>
                            </div>

                            <div class="row g-3 mb-4">
                                <div class="col-md-6">
                                    <label class="form-label text-muted small mb-1">Option A</label>
                                    <asp:TextBox ID="txtOptionA" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label text-muted small mb-1">Option B</label>
                                    <asp:TextBox ID="txtOptionB" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label text-muted small mb-1">Option C</label>
                                    <asp:TextBox ID="txtOptionC" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                                <div class="col-md-6">
                                    <label class="form-label text-muted small mb-1">Option D</label>
                                    <asp:TextBox ID="txtOptionD" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                </div>
                            </div>

                            <div class="mb-4 p-3 bg-light rounded border">
                                <label class="form-label fw-bold text-dark mb-2">Set Correct Answer</label>
                                <asp:DropDownList ID="ddlCorrectAnswer" runat="server" CssClass="form-select border-primary">
                                    <asp:ListItem Text="Option A" Value="A"></asp:ListItem>
                                    <asp:ListItem Text="Option B" Value="B"></asp:ListItem>
                                    <asp:ListItem Text="Option C" Value="C"></asp:ListItem>
                                    <asp:ListItem Text="Option D" Value="D"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            
                            <div class="d-grid">
                                <asp:Button ID="btnAddQuestion" runat="server" Text="Save Question" CssClass="btn btn-primary" OnClick="btnAddQuestion_Click" />
                            </div>

                            <asp:Label ID="lblMessage" runat="server" CssClass="fw-bold mt-3 d-block text-center" Visible="false"></asp:Label>
                        </div>
                    </div>
                </div>

                <div class="col-lg-7">
                    <div class="card border-0 shadow-sm rounded-3 h-100">
                        <div class="card-body p-4">
                            <h5 class="fw-bold text-dark mb-4 border-bottom pb-2">
                                <i class="bi bi-card-list me-2 text-info"></i>Question Bank
                            </h5>
                            
                            <div class="table-responsive">
                                <asp:GridView ID="gvQuestions" runat="server" CssClass="table table-hover align-middle custom-grid" 
                                    AutoGenerateColumns="false" DataKeyNames="QuestionID" OnRowDeleting="gvQuestions_RowDeleting"
                                    EmptyDataText="<div class='text-center text-muted py-5'><i class='bi bi-inbox fs-1 d-block mb-2'></i>No questions in this course yet.</div>"
                                    GridLines="None" BorderWidth="0">
                                    
                                    <HeaderStyle CssClass="table-light text-secondary text-uppercase small" />
                                    <RowStyle CssClass="border-bottom" />
                                    
                                    <Columns>
                                        <asp:TemplateField HeaderText="Question Details">
                                            <ItemTemplate>
                                                <div class="fw-bold text-dark mb-1" style="font-size: 0.95rem;">
                                                    <%# Eval("QuestionText") %>
                                                </div>
                                                <div class="small fw-bold text-success bg-success bg-opacity-10 d-inline-block px-2 py-1 rounded">
                                                    <i class="bi bi-check-circle-fill me-1"></i>Answer: <%# Eval("CorrectAnswer") %>
                                                </div>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                        
                                        <asp:TemplateField HeaderText="Action" ItemStyle-Width="90px" ItemStyle-CssClass="text-end" HeaderStyle-CssClass="text-end">
                                            <ItemTemplate>
                                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                                    CssClass="btn btn-sm btn-outline-danger rounded-pill px-3" 
                                                    OnClientClick="return confirm('Are you sure you want to delete this question?');">
                                                    Delete
                                                </asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>

                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </asp:Panel>
    </div>

    <style>
        .custom-grid th, .custom-grid td {
            padding: 1rem 0.5rem;
        }
        .form-label {
            letter-spacing: 0.5px;
        }
    </style>

</asp:Content>