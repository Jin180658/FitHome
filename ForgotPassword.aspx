<%@ Page Title="Forgot Password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="FitHome.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Magic Dictionary for Forgot Password Page */
        :root {
            --fp-card-bg: rgba(255, 255, 255, 0.95);
            --fp-border: #eeeeee;
            --fp-text: #333333;
            --fp-muted: #666666;
            --fp-input-bg: #ffffff;
            --fp-input-border: #dddddd;
        }

        /* 🌙 Auto-invert colors on Dark Mode */
        [data-theme="dark"] {
            --fp-card-bg: rgba(30, 30, 30, 0.85);
            --fp-border: #444444;
            --fp-text: #ffffff;
            --fp-muted: #bbbbbb;
            --fp-input-bg: #2a2a2a;
            --fp-input-border: #555555;
        }

        .login-container {
            display: flex; justify-content: center; align-items: center;
            padding: 60px 20px; min-height: 80vh; position: relative;
        }
        
        .login-card {
            background: var(--fp-card-bg) !important;
            backdrop-filter: blur(10px);
            border-radius: 15px; padding: 40px;
            width: 100%; max-width: 450px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            border: 1px solid var(--fp-border) !important;
            transition: all 0.3s ease;
        }
        
        .back-link {
            position: absolute; top: 20px; left: 20px;
            text-decoration: none; color: var(--fp-muted) !important; font-weight: 600;
            display: flex; align-items: center; transition: 0.3s;
        }
        .back-link:hover { color: #007bff !important; transform: translateX(-5px); }
        
        .form-group { margin-bottom: 20px; }
        .form-group label { color: var(--fp-text) !important; transition: color 0.3s ease; }
        
        .form-control-custom {
            width: 100%; padding: 12px 15px; 
            border: 1px solid var(--fp-input-border) !important;
            background-color: var(--fp-input-bg) !important;
            color: var(--fp-text) !important;
            border-radius: 8px; transition: 0.3s; outline: none;
        }
        .form-control-custom::placeholder { color: var(--fp-muted) !important; }
        .form-control-custom:focus { border-color: #007bff !important; box-shadow: 0 0 8px rgba(0,123,255,0.2); }
        
        .btn-premium {
            width: 100%; padding: 14px; background: #007bff; color: white;
            border: none; border-radius: 8px; font-size: 1.1em;
            font-weight: bold; cursor: pointer; transition: 0.3s; margin-top: 10px;
        }
        .btn-premium:hover { background: #0056b3; transform: translateY(-2px); box-shadow: 0 5px 15px rgba(0,123,255,0.3); }
        
        .form-header { text-align: center; margin-bottom: 30px; }
        .form-header h2 { color: var(--fp-text) !important; transition: color 0.3s ease; }
        .form-header p { color: var(--fp-muted) !important; font-size: 0.9em; transition: color 0.3s ease; }

        /* ========================================================
           Password Toggle Button Styles
           ======================================================== */
        .password-container {
            position: relative;
            display: flex;
            align-items: center;
        }
        .password-container .form-control-custom {
            padding-right: 45px; 
        }
        .toggle-password-btn {
            position: absolute;
            right: 12px;
            background: transparent;
            border: none;
            color: var(--fp-muted);
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
        <asp:HyperLink ID="lnkBack" runat="server" NavigateUrl="~/Login.aspx" CssClass="back-link">
            <span style="margin-right:8px;">&#8592;</span> Back to Login
        </asp:HyperLink>

        <div class="login-card">
            <div class="form-header">
                <h2>Reset Password</h2>
                <p>Verify your email to create a new password</p>
            </div>

            <asp:Panel ID="PanelEmail" runat="server" Visible="true">
                <div class="form-group">
                    <label>Enter your registered Email</label>
                    <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control-custom" placeholder="name@example.com"></asp:TextBox>
                </div>
                <asp:Button ID="btnSendOTP" runat="server" Text="Send Verification Code" CssClass="btn-premium" OnClick="btnSendOTP_Click" />
            </asp:Panel>

            <asp:Panel ID="PanelOTP" runat="server" Visible="false">
                <div class="form-group">
                    <label>Enter the 6-digit code sent to your email</label>
                    <asp:TextBox ID="txtOTP" runat="server" CssClass="form-control-custom" placeholder="e.g. 123456" MaxLength="6"></asp:TextBox>
                </div>
                <asp:Button ID="btnVerifyOTP" runat="server" Text="Verify Code" CssClass="btn-premium" OnClick="btnVerifyOTP_Click" />
            </asp:Panel>

            <asp:Panel ID="PanelReset" runat="server" Visible="false">
                <div class="form-group">
                    <label>New Password</label>
                    <div class="password-container">
                        <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Enter new password"></asp:TextBox>
                        <button type="button" class="toggle-password-btn" onclick="toggleResetPassword('<%= txtNewPassword.ClientID %>', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                
                <div class="form-group">
                    <label>Confirm New Password</label>
                    <div class="password-container">
                        <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Repeat new password"></asp:TextBox>
                        <button type="button" class="toggle-password-btn" onclick="toggleResetPassword('<%= txtConfirmPassword.ClientID %>', this)">
                            <i class="bi bi-eye"></i>
                        </button>
                    </div>
                </div>
                
                <asp:Button ID="btnResetPassword" runat="server" Text="Update Password" CssClass="btn-premium" OnClick="btnResetPassword_Click" />
            </asp:Panel>

        </div>
    </div>

    <script>
        function toggleResetPassword(inputId, btn) {
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