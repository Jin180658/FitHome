<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FitHome.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* This centers the whole page content */
        .main-wrapper {
            max-width: 1200px; /* Limits the width so it doesn't stretch too far on big screens */
            margin: 0 auto;    /* The magic trick: 0 top/bottom, auto left/right centers it */
            padding: 0 20px;   /* Adds a little breathing room on the sides for mobile */
        }
    </style>

    <div class="main-wrapper">
        <div style="background-color: #f4f4f4; padding: 60px 20px; text-align: center; border-bottom: 2px solid #ddd; border-radius: 10px; margin-top: 20px;">
            <h1 style="font-size: 2.5em; margin-bottom: 10px;">Welcome to FitHome</h1>
            <p style="font-size: 1.2em; color: #666; max-width: 700px; margin: 0 auto 25px auto;">
                Your personal hub for fitness training, BMI tracking, and expert courses.
            </p>
            
            <div style="margin-top: 30px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap;">
                <asp:HyperLink ID="btnRegister" runat="server" NavigateUrl="~/Register.aspx" 
                style="padding: 12px 28px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; transition: 0.3s; display: inline-block;">
                Join Now (Register)
                </asp:HyperLink>

            <asp:HyperLink ID="btnLogin" runat="server" NavigateUrl="~/Login.aspx" 
                style="padding: 12px 28px; background-color: #6c757d; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; transition: 0.3s; display: inline-block;">
                Member Login
                </asp:HyperLink>

            <asp:HyperLink ID="btnBrowse" runat="server" NavigateUrl="~/Courses.aspx" 
                style="padding: 12px 28px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; transition: 0.3s; display: inline-block;">
                Explore Courses
                </asp:HyperLink>
            </div>
        </div>

        <div style="display: flex; justify-content: space-between; padding: 60px 0; text-align: center; gap: 20px;">
            
            <div style="flex: 1; padding: 20px; background: #fff; border: 1px solid #eee; border-radius: 8px;">
                <div style="height: 100px; background: #f9f9f9; line-height: 100px; margin-bottom: 15px; border-radius: 5px; color: #ccc;">[Course Image]</div>
                <h3 style="margin-bottom: 10px;">Professional Courses</h3>
                <p style="color: #777; font-size: 0.95em;">Access high-quality training videos curated by experts.</p>
            </div>

            <div style="flex: 1; padding: 20px; background: #fff; border: 1px solid #eee; border-radius: 8px;">
                <div style="height: 100px; background: #f9f9f9; line-height: 100px; margin-bottom: 15px; border-radius: 5px; color: #ccc;">[BMI Tool]</div>
                <h3 style="margin-bottom: 10px;">Track Your Progress</h3>
                <p style="color: #777; font-size: 0.95em;">Calculate your BMI and keep a history of your workouts.</p>
            </div>

            <div style="flex: 1; padding: 20px; background: #fff; border: 1px solid #eee; border-radius: 8px;">
                <div style="height: 100px; background: #f9f9f9; line-height: 100px; margin-bottom: 15px; border-radius: 5px; color: #ccc;">[Member Image]</div>
                <h3 style="margin-bottom: 10px;">Join Our Community</h3>
                <p style="color: #777; font-size: 0.95em;">Create an account today to save your favorites and records.</p>
            </div>

        </div>
    </div>
</asp:Content>