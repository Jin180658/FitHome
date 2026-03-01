<%@ Page Title="BMI Calculator" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BMICalculator.aspx.cs" Inherits="FitHome.BMICalculator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-5 mb-5">
        
        <div class="row mb-4">
            <div class="col-12 text-center" data-aos="fade-down">
                <h2 class="fw-bold text-dark">⚖️ BMI Calculator</h2>
                <p class="text-muted fs-5">Enter your metrics below to calculate your Body Mass Index.</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-md-6" data-aos="fade-up" data-aos-delay="100">
                <div class="card shadow-sm border-0 rounded-4">
                    <div class="card-body p-5">
                        
                        <div class="mb-3">
                            <label for="txtWeight" class="form-label fw-medium">Weight (kg)</label>
                            <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control form-control-lg bg-light border-0" placeholder="e.g. 70"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <label for="txtHeight" class="form-label fw-medium">Height (cm)</label>
                            <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control form-control-lg bg-light border-0" placeholder="e.g. 165"></asp:TextBox>
                        </div>
                        
                        <asp:Button ID="btnCalculateBMI" runat="server" Text="Calculate BMI" CssClass="btn btn-primary btn-lg w-100 shadow-sm rounded-pill" OnClick="btnCalculateBMI_Click" />
                        
                        <div class="mt-4 text-center border-top pt-4">
                            <asp:Label ID="lblBMIResult" runat="server" CssClass="fs-4 fw-bold"></asp:Label>
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