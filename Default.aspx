<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FitHome.Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        /* 1. This centers the whole page content */
        .main-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        /* 2. Style for the new Background Section */
        .fit-hero {
            /* Keep all original layouts (padding, border, margin) */
            padding: 60px 20px; 
            text-align: center; 
            border-bottom: 2px solid #ddd; 
            border-radius: 10px; 
            margin-top: 20px;
            
            /* THESE ARE REQUIRED for the faded background trick: */
            position: relative; /* Create a new coordinate system */
            overflow: hidden;    /* Ensure the image doesn't pop out */
        }

        /* 3. The magic fades the background without affecting text */
        .fit-hero::before {
            content: ""; /* Required for pseudo-elements */
            position: absolute; /* Place it absolutely within .fit-hero */
            top: 0; 
            left: 0; 
            width: 100%; 
            height: 100%;
            
            /* Add image here: */
            background-image: url('assets/img/default/bg.jpg'); /* Make sure path and name match! */
            background-size: cover;      /* Make it auto-scale to cover area */
            background-position: center; /* Center the image */
            
            /* THE CRITICAL LINE: Fades the image only */
            opacity: 0.3; 
            
            /* Push it to the bottom layer */
            z-index: -1; 
        }
    </style>

    <div class="main-wrapper">

        <div class="fit-hero">
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

            <asp:HyperLink ID="btnBrowse" runat="server" NavigateUrl="~/CourseCatalog.aspx" 
                style="padding: 12px 28px; background-color: #007bff; color: white; text-decoration: none; border-radius: 5px; font-weight: bold; transition: 0.3s; display: inline-block;">
                Explore Courses
             </asp:HyperLink>
            </div>
            </div>

        <div style="display: flex; justify-content: space-between; padding: 60px 0; text-align: center; gap: 20px;">
            
            <div style="flex: 1; padding: 20px; background: #fff; border: 1px solid #eee; border-radius: 8px;">
                <img src="assets/img/default/professional_course.jpg" alt="Course Image" style="width: 100%; height: 150px; object-fit: cover; border-radius: 5px; margin-bottom: 15px;" />
                <h3 style="margin-bottom: 10px;">Professional Courses</h3>
                <p style="color: #777; font-size: 0.95em;">Access high-quality training videos curated by experts.</p>
            </div>

            <div style="flex: 1; padding: 20px; background: #fff; border: 1px solid #eee; border-radius: 8px;">
                <img src="assets/img/default/bmi_tool.jpg" alt="BMI Tool" style="width: 100%; height: 150px; object-fit: cover; border-radius: 5px; margin-bottom: 15px;" />
                <h3 style="margin-bottom: 10px;">Track Your Progress</h3>
                <p style="color: #777; font-size: 0.95em;">Calculate your BMI and keep a history of your workouts.</p>
            </div>

            <div style="flex: 1; padding: 20px; background: #fff; border: 1px solid #eee; border-radius: 8px;">
                <img src="assets/img/default/member_image.jpg" alt="Member Image" style="width: 100%; height: 150px; object-fit: cover; border-radius: 5px; margin-bottom: 15px;" />
                <h3 style="margin-bottom: 10px;">Join Our Community</h3>
                <p style="color: #777; font-size: 0.95em;">Create an account today to save your favorites and records.</p>
            </div>

        </div>
    </div>
</asp:Content>