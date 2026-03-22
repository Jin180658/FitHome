<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FitHome.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Magic Dictionary for Register Page */
        :root {
            --reg-card-bg: rgba(255, 255, 255, 0.95);
            --reg-border: #eeeeee;
            --reg-text: #333333;
            --reg-muted: #666666;
            --reg-input-bg: #ffffff;
            --reg-input-border: #dddddd;
        }

        /* 🌙 Auto-invert colors on Dark Mode */
        [data-theme="dark"] {
            --reg-card-bg: rgba(30, 30, 30, 0.85);
            --reg-border: #444444;
            --reg-text: #ffffff;
            --reg-muted: #bbbbbb;
            --reg-input-bg: #2a2a2a;
            --reg-input-border: #555555;
        }

        /* Container Layout */
        .register-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
            min-height: 80vh;
            position: relative;
        }

        /* Card with Magic Variables */
        .register-card {
            background: var(--reg-card-bg) !important;
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            border: 1px solid var(--reg-border) !important;
            transition: all 0.3s ease;
        }

        /* Back Link */
        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            text-decoration: none;
            color: var(--reg-muted) !important;
            font-weight: 600;
            display: flex;
            align-items: center;
            transition: 0.3s;
        }
        .back-link:hover { color: #007bff !important; transform: translateX(-5px); }

        /* Form Group and Text */
        .form-group { margin-bottom: 20px; }
        .form-group label { color: var(--reg-text) !important; transition: color 0.3s ease; }
        
        /* Input Fields with Magic Variables */
        .form-control-custom {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid var(--reg-input-border) !important;
            background-color: var(--reg-input-bg) !important;
            color: var(--reg-text) !important;
            border-radius: 8px;
            transition: 0.3s;
            outline: none;
        }
        .form-control-custom::placeholder { color: var(--reg-muted) !important; }
        .form-control-custom:focus { border-color: #007bff !important; box-shadow: 0 0 8px rgba(0,123,255,0.2); }

        /* Primary Register Button */
        .btn-register-premium {
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
        .btn-register-premium:hover { background: #0056b3; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,123,255,0.3); }

        /* Header Elements */
        .form-header { text-align: center; margin-bottom: 30px; }
        .form-header h2 { color: var(--reg-text) !important; transition: color 0.3s ease; }
        .form-header p { color: var(--reg-muted) !important; font-size: 0.9em; transition: color 0.3s ease; }

        /* Bottom Text */
        .bottom-text { text-align: center; margin-top: 20px; font-size: 0.85em; color: var(--reg-muted) !important; transition: color 0.3s ease; }

        /* ========================================================
           Password Toggle Button Styles
           ======================================================== */
        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        /* Prevent text from hiding behind the eye icon */
        .password-container .form-control-custom {
            padding-right: 45px; 
        }
        .toggle-password-btn {
            position: absolute;
            right: 12px;
            background: transparent;
            border: none;
            color: var(--reg-muted);
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

    <div class="register-container">
        <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="~/Default.aspx" CssClass="back-link">
            <span style="margin-right:8px;">&#8592;</span> Back to Home
        </asp:HyperLink>

        <div class="register-card">
            <div class="form-header">
                <h2>Create Account</h2>
                <p>Join FitHome and start your journey</p>
            </div>

            <div class="form-group">
                <label>Username</label>
                <asp:TextBox ID="txtUsername" runat="server" CssClass="form-control-custom" placeholder="Choose a unique name"></asp:TextBox>
            </div>

            <div class="form-group">
                <label>Email Address</label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-custom" placeholder="name@example.com"></asp:TextBox>
            </div>

            <div style="display: flex; gap: 15px;">
                <div class="form-group" style="flex:1;">
                    <label>Password</label>
                    <div class="password-container">
                        <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Min 6 chars"></asp:TextBox>
                        <button type="button" class="toggle-password-btn" onclick="toggleRegisterPassword('<%= txtPassword.ClientID %>', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div class="form-group" style="flex:1;">
                    <label>Confirm</label>
                    <div class="password-container">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Repeat password"></asp:TextBox>
                        <button type="button" class="toggle-password-btn" onclick="toggleRegisterPassword('<%= txtConfirmPassword.ClientID %>', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div style="display: flex; gap: 15px;">
                <div class="form-group" style="flex:1;">
                    <label>Weight (kg)</label>
                    <asp:TextBox ID="txtWeight" runat="server" CssClass="form-control-custom" placeholder="e.g. 70"></asp:TextBox>
                </div>
                <div class="form-group" style="flex:1;">
                    <label>Height (cm)</label>
                    <asp:TextBox ID="txtHeight" runat="server" CssClass="form-control-custom" placeholder="e.g. 175"></asp:TextBox>
                </div>
            </div>

            <asp:Button ID="btnRegister" runat="server" Text="Register Now" CssClass="btn-register-premium" OnClick="btnRegister_Click" />
            
            <p class="bottom-text">
                Already have an account? <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/Login.aspx" style="color:#007bff; text-decoration:none; font-weight:600;">Log In</asp:HyperLink>
            </p>
        </div>
    </div>

    <script>
        function toggleRegisterPassword(inputId, btn) {
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