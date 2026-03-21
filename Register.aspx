<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FitHome.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .register-container {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 60px 20px;
            min-height: 80vh;
            position: relative;
        }

        .register-card {
            background: var(--card-bg);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 40px;
            width: 100%;
            max-width: 500px;
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

        .form-header { text-align: center; margin-bottom: 30px; }
        .form-header h2 { color: var(--text-color); }
        .form-header p { color: #777; font-size: 0.9em; }
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
                    <asp:TextBox ID="txtPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Min 6 chars"></asp:TextBox>
                </div>
                <div class="form-group" style="flex:1;">
                    <label>Confirm</label>
                    <asp:TextBox ID="txtConfirmPassword" runat="server" CssClass="form-control-custom" TextMode="Password" placeholder="Repeat password"></asp:TextBox>
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
            
            <p style="text-align:center; margin-top:20px; font-size:0.85em; color:#888;">
                Already have an account? <asp:HyperLink ID="lnkLogin" runat="server" NavigateUrl="~/Login.aspx" style="color:#007bff; text-decoration:none; font-weight:600;">Log In</asp:HyperLink>
            </p>
        </div>
    </div>
</asp:Content>