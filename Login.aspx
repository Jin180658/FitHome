<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FitHome.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Magic Dictionary for Login Page */
        :root {
            --log-card-bg: rgba(255, 255, 255, 0.95);
            --log-border: #eeeeee;
            --log-text: #333333;
            --log-muted: #666666;
            --log-input-bg: #ffffff;
            --log-input-border: #dddddd;
        }

        /* 🌙 Auto-invert colors on Dark Mode */
        [data-theme="dark"] {
            --log-card-bg: rgba(30, 30, 30, 0.85);
            --log-border: #444444;
            --log-text: #ffffff;
            --log-muted: #bbbbbb;
            --log-input-bg: #2a2a2a;
            --log-input-border: #555555;
        }

        /* Container Layout */
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
            min-height: 80vh;
            position: relative;
        }

        /* Card with Magic Variables */
        .login-card {
            background: var(--log-card-bg) !important;
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            border: 1px solid var(--log-border) !important;
            transition: all 0.3s ease;
        }

        /* Back Link */
        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            text-decoration: none;
            color: var(--log-muted) !important;
            font-weight: 600;
            display: flex;
            align-items: center;
            transition: 0.3s;
        }
        .back-link:hover { color: #007bff !important; transform: translateX(-5px); }

        /* Form Group and Text */
        .form-group { margin-bottom: 20px; }
        .form-group label { color: var(--log-text) !important; transition: color 0.3s ease; }
        
        /* Input Fields with Magic Variables */
        .form-control-custom {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--log-input-border) !important;
            background-color: var(--log-input-bg) !important;
            color: var(--log-text) !important;
            border-radius: 8px;
            transition: 0.3s;
            outline: none;
        }
        .form-control-custom::placeholder { color: var(--log-muted) !important; }
        .form-control-custom:focus { border-color: #007bff !important; box-shadow: 0 0 8px rgba(0,123,255,0.2); }

        /* Primary Login Button */
        .btn-login-premium {
            width: 100%;
            padding: 14px;
            background: #007bff;
            color: white;
            border: none;
            border-radius: 8px;
            font-size: 1.1em;
            font-weight: bold;
            cursor: pointer;
            transition: 0.3s;
            margin-top: 10px;
        }
        .btn-login-premium:hover { background: #0056b3; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,123,255,0.3); }

        /* Header Elements */
        .form-header { text-align: center; margin-bottom: 30px; }
        .form-header h2 { color: var(--log-text) !important; transition: color 0.3s ease; }
        .form-header p { color: var(--log-muted) !important; font-size: 0.9em; transition: color 0.3s ease; }

        .link-hover:hover { color: #0056b3 !important; text-decoration: underline !important; }

        /* ========================================================
           Password Toggle Button Styles
           ======================================================== */
        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        /* Add padding to the right so text doesn't hide behind the eye icon */
        .password-container .form-control-custom {
            padding-right: 45px; 
        }
        .toggle-password-btn {
            position: absolute;
            right: 12px;
            background: transparent;
            border: none;
            color: var(--log-muted);
            cursor: pointer;
            font-size: 1.2rem;
            padding: 0;
            outline: none;
            transition: color 0.2s ease;
        }
        .toggle-password-btn:hover {
            color: #007bff !important;
        }
    </style>

    <div class="login-container">
        <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="~/Default.aspx" CssClass="back-link">
            <span style="margin-right:8px;">&#8592;</span> Back to Home
        </asp:HyperLink>

        <div class="login-card">
            <div class="form-header">
                <h2>Welcome Back</h2>
                <p>Log in to your FitHome account</p>
            </div>

            <div class="form-group">
                <label>Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control-custom" placeholder="e.g. jay"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Password</label>
                <div class="password-container">
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
                    <button type="button" class="toggle-password-btn" onclick="toggleLoginPassword('<%= txtPassword.ClientID %>', this)">
                        <i class="bi bi-eye"></i>
                    </button>
                </div>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn-login-premium" OnClick="btnLogin_Click" />
            
            <div style="display: flex; justify-content: space-between; margin-top: 20px; font-size: 0.85em;">
                <asp:HyperLink ID="lnkForgotPassword" runat="server" NavigateUrl="~/ForgotPassword.aspx" style="color: var(--log-muted); text-decoration: none; transition: 0.2s;" CssClass="link-hover">Forgot Password?</asp:HyperLink>
                <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx" style="color: #007bff; text-decoration: none; font-weight: 600; transition: 0.2s;" CssClass="link-hover">Create Account</asp:HyperLink>
            </div>
        </div>
    </div>

    <script>
        function toggleLoginPassword(inputId, btn) {
            var input = document.getElementById(inputId);
            var icon = btn.querySelector('i');

            if (input.type === "password") {
                input.type = "text";
                icon.classList.remove("bi-eye");
                icon.classList.add("bi-eye-slash");
            } else {
                input.type = "password";
                icon.classList.remove("bi-eye-slash");
                icon.classList.add("bi-eye");
            }
        }
    </script>
</asp:Content>