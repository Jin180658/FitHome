<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="FitHome.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* Container for the entire registration form */
        .register-container {
            max-width: 600px;
            margin: 20px auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }

        /* Grouping label and input field in the same row */
        .form-group {
            display: flex;
            align-items: center;
            margin-bottom: 15px;
        }

        /* Fixed width for labels to ensure all textboxes align vertically */
        .form-group label {
            width: 160px;
            text-align: right;
            margin-right: 15px;
            font-weight: bold;
        }

        /* Styling for the input boxes */
        .form-group .form-input {
            width: 250px;
            padding: 5px;
        }

        /* Error message styling for Accessibility */
        .error-msg {
            margin-left: 10px;
            font-size: 0.85em;
            font-style: italic;
        }

        /* Button alignment to match the input boxes */
        .button-row {
            margin-left: 175px;
            margin-top: 10px;
        }
    </style>

    <div class="register-container">
        <h2>Create Your Account</h2>
        <p>Join FitHome to start your training journey.</p>

        <div class="form-group">
            <asp:Label ID="lblUser" runat="server" AssociatedControlID="txtUsername">Username:</asp:Label>
            <asp:TextBox ID="txtUsername" runat="server" CssClass="form-input"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvUsername" runat="server" 
                ControlToValidate="txtUsername" ErrorMessage="Required" 
                ForeColor="Red" CssClass="error-msg"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <asp:Label ID="lblPass" runat="server" AssociatedControlID="txtPassword">Password:</asp:Label>
            <asp:TextBox ID="txtPassword" runat="server" TextMode="Password" CssClass="form-input"></asp:TextBox>
            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" 
                ControlToValidate="txtPassword" ErrorMessage="Required" 
                ForeColor="Red" CssClass="error-msg"></asp:RequiredFieldValidator>
        </div>

        <div class="form-group">
            <asp:Label ID="lblConfirm" runat="server" AssociatedControlID="txtConfirm">Confirm Password:</asp:Label>
            <asp:TextBox ID="txtConfirm" runat="server" TextMode="Password" CssClass="form-input"></asp:TextBox>
            <asp:CompareValidator ID="cvPassword" runat="server" 
                ControlToValidate="txtConfirm" ControlToCompare="txtPassword" 
                ErrorMessage="Mismatch" ForeColor="Red" CssClass="error-msg"></asp:CompareValidator>
        </div>

        <div class="form-group">
            <asp:Label ID="lblEmail" runat="server" AssociatedControlID="txtEmail">Email Address:</asp:Label>
            <asp:TextBox ID="txtEmail" runat="server" CssClass="form-input"></asp:TextBox>
            <asp:RegularExpressionValidator ID="revEmail" runat="server" 
                ControlToValidate="txtEmail" 
                ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*" 
                ErrorMessage="Invalid Email" ForeColor="Red" CssClass="error-msg"></asp:RegularExpressionValidator>
        </div>

        <div class="form-group">
            <asp:Label ID="lblWeight" runat="server" AssociatedControlID="txtWeight">Weight (kg):</asp:Label>
            <asp:TextBox ID="txtWeight" runat="server" CssClass="form-input" placeholder="e.g. 70.5"></asp:TextBox>
            <asp:RangeValidator ID="rvWeight" runat="server" ControlToValidate="txtWeight" 
                MinimumValue="20" MaximumValue="300" Type="Double" 
                ErrorMessage="Invalid weight" ForeColor="Red" CssClass="error-msg"></asp:RangeValidator>
        </div>

        <div class="form-group">
            <asp:Label ID="lblHeight" runat="server" AssociatedControlID="txtHeight">Height (cm):</asp:Label>
            <asp:TextBox ID="txtHeight" runat="server" CssClass="form-input" placeholder="e.g. 175"></asp:TextBox>
            <asp:RangeValidator ID="rvHeight" runat="server" ControlToValidate="txtHeight" 
                MinimumValue="50" MaximumValue="250" Type="Double" 
                ErrorMessage="Invalid height" ForeColor="Red" CssClass="error-msg"></asp:RangeValidator>
        </div>

        <div class="button-row">
            <asp:Button ID="btnRegister" runat="server" Text="Register Now" OnClick="btnRegister_Click" />
            <br />
            <asp:Label ID="lblMessage" runat="server" Text="" style="display:block; margin-top:10px;"></asp:Label>
        </div>
    </div>
</asp:Content>