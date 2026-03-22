<%@ Page Title="BMI Calculator" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="BMICalculator.aspx.cs" Inherits="FitHome.BMICalculator" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="container mt-5 pt-4 mb-5">
        
        <div class="row mb-4">
            <div class="col-12 text-center" data-aos="fade-down">
                <div class="d-inline-flex align-items-center justify-content-center bg-success bg-opacity-10 rounded-circle mb-3" style="width: 60px; height: 60px;">
                    <i class="bi bi-heart-pulse text-success fs-2"></i>
                </div>
                <h2 class="fw-bold text-dark">BMI Calculator</h2>
                <p class="text-muted fs-5">Enter your height and weight below to calculate your Body Mass Index (BMI).</p>
            </div>
        </div>

        <div class="row justify-content-center">
            <div class="col-lg-5 col-md-7" data-aos="fade-up" data-aos-delay="100">
                <div class="card shadow-sm border-0 rounded-4 bg-light">
                    <div class="card-body p-4 p-md-5">
                        
                        <div class="mb-3">
                            <label for="txtWeight" class="form-label fw-medium text-dark">Weight (kg)</label>
                            <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control form-control-lg bg-white border-0 shadow-sm" placeholder="Enter your weight"></asp:TextBox>
                        </div>
                        
                        <div class="mb-4">
                            <label for="txtHeight" class="form-label fw-medium text-dark">Height (cm)</label>
                            <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control form-control-lg bg-white border-0 shadow-sm" placeholder="Enter your height"></asp:TextBox>
                        </div>
                        
                        <asp:Button ID="btnCalculateBMI" runat="server" Text="Check BMI" CssClass="btn btn-success btn-lg w-100 shadow-sm rounded-pill fw-bold mb-3 hover-lift" OnClick="btnCalculateBMI_Click" />
                        
                        <div class="text-center">
                            <asp:Label ID="lblBMIResult" runat="server" CssClass="d-block"></asp:Label>
                        </div>

                        <div class="mt-4 pt-4 border-top border-secondary-subtle">
                            <h6 class="fw-bold text-muted mb-3 text-center fs-6">BMI Classification Guide</h6>
                            <ul class="list-group list-group-flush bg-transparent small">
                                <li id="liUnderweight" runat="server" class="list-group-item bg-transparent px-2 d-flex justify-content-between border-0 py-2 text-muted rounded-3">
                                    <span>Underweight</span> <span>&lt; 18.5</span>
                                </li>
                                <li id="liNormal" runat="server" class="list-group-item bg-transparent px-2 d-flex justify-content-between border-0 py-2 text-muted rounded-3">
                                    <span>Normal Weight</span> <span>18.5 &ndash; 24.9</span>
                                </li>
                                <li id="liOverweight" runat="server" class="list-group-item bg-transparent px-2 d-flex justify-content-between border-0 py-2 text-muted rounded-3">
                                    <span>Overweight</span> <span>25 &ndash; 29.9</span>
                                </li>
                                <li id="liObese" runat="server" class="list-group-item bg-transparent px-2 d-flex justify-content-between border-0 py-2 text-muted rounded-3">
                                    <span>Obese</span> <span>30.0+</span>
                                </li>
                            </ul>
                        </div>

                        <div class="mt-4 text-center pt-3">
                            <a href="UserDashboard.aspx" class="text-decoration-none small fw-bold hover-primary bmi-magic-muted">
                                <i class="bi bi-arrow-left me-1"></i> Return to Dashboard
                            </a>
                        </div>
                        
                    </div>
                </div>
            </div>
        </div>
    </div>

    <style>
        /* Interactive button elevation effect */
        .hover-lift { transition: transform 0.2s ease, box-shadow 0.2s ease; }
        .hover-lift:hover { transform: translateY(-2px); box-shadow: 0 .5rem 1rem rgba(0,0,0,.15)!important; }
        
        /* Smooth color transition for navigation links */
        .hover-primary { transition: color 0.2s ease; }
        .hover-primary:hover { color: #198754 !important; }
        
        /* Logic for highlighting the current BMI category row */
        .transition-all { transition: all 0.3s ease; }
        .scale-up { transform: scale(1.02); }
        :root {
            --bmi-card-bg: #ffffff;
            --bmi-card-border: #eeeeee;
            --bmi-text-main: #222222;
            --bmi-text-muted: #666666;
            --bmi-input-bg: #ffffff;
            --bmi-input-border: #cccccc;
        }

        [data-theme="dark"] {
            --bmi-card-bg: #1e1e1e;
            --bmi-card-border: #333333;
            --bmi-text-main: #ffffff;  
            --bmi-text-muted: #bbbbbb; 
            --bmi-input-bg: #2a2a2a; 
            --bmi-input-border: #444444;
        }

        .bmi-magic-card { background-color: var(--bmi-card-bg) !important; border: 1px solid var(--bmi-card-border) !important; transition: all 0.4s ease; }
        .bmi-magic-text { color: var(--bmi-text-main) !important; transition: color 0.4s ease; }
        .bmi-magic-muted { color: var(--bmi-text-muted) !important; transition: color 0.4s ease; }
        
        .bmi-magic-input { 
            background-color: var(--bmi-input-bg) !important; 
            color: var(--bmi-text-main) !important; 
            border: 1px solid var(--bmi-input-border) !important; 
            transition: all 0.4s ease;
        }
    </style>
</asp:Content>