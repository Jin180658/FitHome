<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FitHome.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .login-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
            min-height: 80vh;
            position: relative;
        }

        .login-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 420px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1);
            border: 1px solid var(--border-color);
        }

        .back-link {
            position: absolute;
            top: 20px;
            left: 20px;
            text-decoration: none;
            color: #666;
            font-weight: 600;
            display: flex;
            align-items: center;
            transition: 0.3s;
        }
        .back-link:hover { color: #007bff; transform: translateX(-5px); }

        .form-group { margin-bottom: 20px; }
        .form-group label { color: var(--text-color); }
        .form-control-custom {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            transition: 0.3s;
            outline: none;
        }
        .form-control-custom:focus { border-color: #007bff; box-shadow: 0 0 8px rgba(0,123,255,0.2); }

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

        .form-header { text-align: center; margin-bottom: 30px; }
        .form-header h2 { color: var(--text-color); }
        .form-header p { color: #777; font-size: 0.9em; }

        .link-hover:hover { color: #0056b3 !important; text-decoration: underline !important; }
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
                <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Enter your password"></asp:TextBox>
            </div>

            <asp:Button ID="btnLogin" runat="server" Text="Log In" CssClass="btn-login-premium" OnClick="btnLogin_Click" />
            
            <div style="display: flex; justify-content: space-between; margin-top: 20px; font-size: 0.85em;">
                <asp:HyperLink ID="lnkForgotPassword" runat="server" NavigateUrl="~/ForgotPassword.aspx" style="color: #777; text-decoration: none; transition: 0.2s;" CssClass="link-hover">Forgot Password?</asp:HyperLink>
                <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx" style="color: #007bff; text-decoration: none; font-weight: 600; transition: 0.2s;" CssClass="link-hover">Create Account</asp:HyperLink>
            </div>
        </div>
    </div>
</asp:Content>