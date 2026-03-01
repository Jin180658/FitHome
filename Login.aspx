<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="FitHome.Login" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .login-container {
            max-width: 500px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.1);
        }
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 20px;
        }
        .form-group label {
            width: 120px;
            font-weight: bold;
        }
        .form-input {
            flex: 1;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
        }
        .login-actions {
            margin-left: 120px;
        }
        .btn-login {
            padding: 10px 25px;
            background-color: #28a745; /* Green color for Login */
            color: white;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
    </style>

    <div class="login-container">
        <h2 style="text-align: center;">Member Login</h2>
        <p style="text-align: center; color: #666;">Enter your credentials to access your fitness hub.</p>
        <hr />

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtUsername">Username:</asp:Label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input"></asp:TextBox>
        </div>

        <div class="form-group">
            <asp:Label runat="server" AssociatedControlID="txtPassword">Password:</asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input"></asp:TextBox>
        </div>
        <div class="login-actions">
    <asp:Button ID="btnLogin" runat="server" Text="Login" CssClass="btn-login" OnClick="btnLogin_Click" />
    
    <div style="margin-top: 10px;">
        <asp:HyperLink ID="lnkForgot" runat="server" NavigateUrl="~/ForgotPassword.aspx" 
            style="font-size: 0.85em; color: #6c757d; text-decoration: none; display: inline-block;">
            Forgot Password?
        </asp:HyperLink>
        </div>

    <asp:Label ID="lblMessage" runat="server" ForeColor="Red" style="display:block; margin-top:10px;"></asp:Label>

    <p style="font-size: 0.9em; margin-top: 10px;">
        New member? <asp:HyperLink ID="lnkRegister" runat="server" NavigateUrl="~/Register.aspx" style="font-weight:bold; color:#28a745;">Register here</asp:HyperLink>
        </p>
        </div>
        <hr />
    </div>
</asp:Content>