<%@ Page Title="Edit Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="EditProfile.aspx.cs" Inherits="FitHome.EditProfile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5 mb-5">
        
        <div class="row mb-4">
            <div class="col-12 text-center" data-aos="fade-down">
                <h2 class="fw-bold text-dark">⚙️ Edit Profile</h2>
                <p class="text-muted fs-5">Keep your fitness metrics and account details up to date.</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-8" data-aos="fade-up" data-aos-delay="100">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-5">
                        
                        <asp:Label ID="lblStatus" runat="server" CssClass="fw-bold d-block mb-3 text-center"></asp:Label>

                        <div class="row">
                            <div class="col-md-6 mb-4">
                                <h5 class="fw-semibold mb-3 border-bottom pb-2">Physical Metrics</h5>
                                
                                <div class="mb-3">
                                    <label class="form-label text-muted">Current Weight (kg)</label>
                                    <asp:TextBox ID="txtEditWeight" runat="server" CssClass="form-control bg-light border-0"></asp:TextBox>
                                </div>
                                
                                <div class="mb-3">
                                    <label class="form-label text-muted">Current Height (cm)</label>
                                    <asp:TextBox ID="txtEditHeight" runat="server" CssClass="form-control bg-light border-0"></asp:TextBox>
                                </div>
                            </div>

                            <div class="col-md-6 mb-4">
                                <h5 class="fw-semibold mb-3 border-bottom pb-2">Account Security</h5>
                                
                                <div class="mb-3">
                                    <label class="form-label text-muted">Email Address (Read Only)</label>
                                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control bg-light border-0" ReadOnly="true"></asp:TextBox>
                                </div>

                                <div class="mb-3">
                                    <label class="form-label text-muted">New Password</label>
                                    <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control bg-light border-0" TextMode="Password" placeholder="Leave blank to keep current"></asp:TextBox>
                                </div>
                            </div>
                        </div>

                        <div class="mt-4 text-center">
                            <asp:Button ID="btnSaveChanges" runat="server" Text="Save Changes" CssClass="btn btn-primary btn-lg px-5 shadow-sm rounded-pill" OnClick="btnSaveChanges_Click" />
                            <a href="UserDashboard.aspx" class="btn btn-link text-secondary text-decoration-none mt-2 d-block">Cancel and return to Dashboard</a>
                        </div>

                    </div>
                </div>
            </div>
        </div>
    </div>
</asp:Content>