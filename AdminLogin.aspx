<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AdminLogin.aspx.cs" Inherits="FitHome.AdminLogin" %>

<!DOCTYPE html>
<html>
<head runat="server">
    <title>FitHome Admin Portal - Secure Access</title>
    
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" />
    
    <style>
        /* Define brand colors from the FitHome Logo */
        :root {
            --fh-navy: #002d5a;   /* Navy blue extracted from the Logo */
            --fh-orange: #ff9d00; /* Bright orange extracted from the Logo */
        }

        body {
            background-color: #f4f7f6; /* Light gray background to highlight the center card */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Full-screen centered container */
        .login-container {
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        /* Login card styles */
        .login-card {
            border: none;
            border-radius: 20px;
            overflow: hidden; /* Ensure child elements maintain the border radius */
            box-shadow: 0 15px 35px rgba(0,0,0,0.1); /* Soft shadow */
            width: 100%;
            max-width: 900px; /* Maximum card width */
            background-color: white;
        }

        /* Left side brand section */
        .brand-section {
            background-color: var(--fh-navy); /* Use Logo navy blue */
            color: white;
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            padding: 50px;
        }

        .logo-img {
            max-width: 220px; /* Logo size */
            margin-bottom: 30px;
        }

        /* Right side form section */
        .form-section {
            padding: 60px;
        }

        /* Brand orange button */
        .btn-fh {
            background-color: var(--fh-orange); /* Use Logo orange */
            color: white;
            border: none;
            font-weight: bold;
            padding: 12px;
            transition: all 0.3s;
        }

        .btn-fh:hover {
            background-color: #e68d00; /* Darken slightly on hover */
            color: white;
            transform: translateY(-2px); /* Slight upward hover effect */
        }

        /* Input field style optimization */
        .input-group-text {
            background-color: #f8f9fa;
            border-right: none;
            color: var(--fh-navy);
        }
        .form-control {
            border-left: none;
            padding: 12px;
        }
        .form-control:focus {
            border-color: #ced4da;
            box-shadow: none; /* Remove Bootstrap's default blue focus ring */
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <div class="login-container container">
            <div class="login-card row g-0">
                
                <div class="col-md-6 brand-section text-center">
                    <img src="assets/img/logo.png" alt="FitHome Logo" class="logo-img img-fluid" />
                    
                    <h2 class="fw-bold mb-3">Administrative Portal</h2>
                    <p class="lead text-white-50">Secure access to Manage FitHome Programs.</p>
                    
                    <div class="mt-5 small text-white-50">
                        &copy; 2026 FitHome. Authorized Access Only.
                    </div>
                </div>

                <div class="col-md-6 form-section">
                    <h3 class="fw-bold text-dark mb-2">Welcome Back</h3>
                    <p class="text-muted mb-4">Please enter your credentials to secure sign-in.</p>
                    
                    <asp:Label ID="lblError" runat="server" CssClass="alert alert-danger d-block mb-3" Visible="false"></asp:Label>
                    
                    <div class="mb-3">
                        <label class="form-label fw-semibold text-secondary">Admin Username</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-user"></i></span>
                            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control" placeholder="e.g. admin_james"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="mb-4">
                        <label class="form-label fw-semibold text-secondary">Password</label>
                        <div class="input-group">
                            <span class="input-group-text"><i class="fas fa-lock"></i></span>
                            <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control" TextMode="Password" placeholder="••••••••"></asp:TextBox>
                        </div>
                    </div>
                    
                    <div class="d-grid mb-3">
                        <asp:Button ID="btnLogin" runat="server" Text="Sign In" CssClass="btn btn-fh btn-lg rounded-pill" OnClick="btnLogin_Click" />
                    </div>
                    
                    <div class="text-center mt-4">
                        <a href="Default.aspx" class="text-muted small text-decoration-none">
                            <i class="fas fa-arrow-left me-1"></i> Back to Homepage
                        </a>
                    </div>
                </div>

            </div>
        </div>
    </form>
    
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>