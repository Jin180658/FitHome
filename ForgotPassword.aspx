<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ForgotPassword.aspx.cs" Inherits="FitHome.ForgotPassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        .forgot-container {
            max-width: 450px;
            margin: 50px auto;
            padding: 30px;
            border: 1px solid #ddd;
            border-radius: 10px;
            box-shadow: 0px 4px 10px rgba(0,0,0,0.05);
            font-family: Arial, sans-serif;
        }
        .step-title { margin-bottom: 20px; text-align: center; color: #333; }
        .form-row { margin-bottom: 15px; }
        .form-row label { display: block; margin-bottom: 5px; font-weight: bold; }
        .form-control { width: 100%; padding: 10px; border: 1px solid #ccc; border-radius: 4px; box-sizing: border-box; }
        .btn-action { width: 100%; padding: 12px; border: none; border-radius: 5px; cursor: pointer; font-weight: bold; color: white; }
        .btn-verify { background-color: #007bff; }
        .btn-reset { background-color: #28a745; }
    </style>

    <div class="forgot-container">
        <h2 class="step-title">Reset Your Password</h2>

        <asp:Panel ID="pnlStep1" runat="server">
            <p style="font-size: 0.9em; color: #666;">Please enter your registered email address to continue.</p>
            <div class="form-row">
                <asp:Label runat="server" AssociatedControlID="txtEmail">Email Address:</asp:Label>
                <asp:TextBox ID="txtEmail" runat="server" CssClass="form-control" placeholder="example@mail.com"></asp:TextBox>
            </div>
            <asp:Button ID="btnVerifyEmail" runat="server" Text="Verify Email" CssClass="btn-action btn-verify" OnClick="btnVerifyEmail_Click" />
        </asp:Panel>

        <asp:Panel ID="pnlStep2" runat="server" Visible="false">
            <p style="font-size: 0.9em; color: #28a745; font-weight: bold;">Email verified! Please set your new password.</p>
            <div class="form-row">
                <asp:Label runat="server" AssociatedControlID="txtNewPassword">New Password:</asp:Label>
                <asp:TextBox ID="txtNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
            </div>
            <div class="form-row">
                <asp:Label runat="server" AssociatedControlID="txtConfirmNewPassword">Confirm New Password:</asp:Label>
                <asp:TextBox ID="txtConfirmNewPassword" runat="server" CssClass="form-control" TextMode="Password"></asp:TextBox>
                <asp:CompareValidator ID="cvPassword" runat="server" ControlToValidate="txtConfirmNewPassword" 
                    ControlToCompare="txtNewPassword" ErrorMessage="Passwords do not match!" ForeColor="Red" Display="Dynamic"></asp:CompareValidator>
            </div>
            <asp:Button ID="btnResetPassword" runat="server" Text="Update Password" CssClass="btn-action btn-reset" OnClick="btnResetPassword_Click" />
        </asp:Panel>

        <div style="margin-top: 20px; text-align: center;">
            <asp:Label ID="lblMsg" runat="server" style="display:block; margin-bottom: 10px;"></asp:Label>
            <asp:HyperLink runat="server" NavigateUrl="~/Login.aspx" style="font-size: 0.9em; color: #007bff; text-decoration: none;" ID="lnkLogin">Back to Login</asp:HyperLink>
        </div>
    </div>
</asp:Content>
