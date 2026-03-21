<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="FitHome.Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <style>
        :root {
            --hero-title: #222222;
            --hero-desc: #555555; 
            --card-bg: #ffffff;      
            --card-border: #eeeeee; 
            --card-title: #000000;  
            --card-desc: #333333; 
            --img-box-bg: #f9f9f9;  
            --img-box-text: #aaaaaa;  
        }

        [data-theme="dark"] {
            --hero-title: #ffffff;  
            --hero-desc: #cccccc;  
            --card-bg: #1e1e1e;  
            --card-border: #333333; 
            --card-title: #ffffff; 
            --card-desc: #bbbbbb;  
            --img-box-bg: #2a2a2a;  
            --img-box-text: #666666;
        }

        .fit-hero {
            padding: 60px 20px; text-align: center; border-bottom: 2px solid var(--card-border) !important;
            border-radius: 10px; margin-top: 20px; position: relative; overflow: hidden;
            background-color: transparent !important; z-index: 1;
        }
        .fit-hero::before {
            content: ""; position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background-image: url('assets/img/default/bg.jpg');
            background-size: cover; background-position: center; opacity: 0.15; z-index: -1;
        }

        .btn-hero {
            padding: 12px 28px; border-radius: 8px; font-weight: bold; font-size: 1.1em;
            text-decoration: none !important; display: inline-block;
            transition: all 0.3s ease !important;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1); margin: 5px; cursor: pointer;
        }
        .btn-hero-primary { background-color: #007bff !important; color: #ffffff !important; }
        .btn-hero-secondary { background-color: #6c757d !important; color: #ffffff !important; }
        .btn-hero:hover { transform: scale(1.08) translateY(-4px) !important; box-shadow: 0 12px 20px rgba(0,0,0,0.2) !important; }
        .btn-hero-primary:hover { background-color: #0056b3 !important; }
        .btn-hero-secondary:hover { background-color: #5a6268 !important; }

        .main-wrapper { max-width: 1200px; margin: 0 auto; padding: 0 20px; }
        .cards-container { display: grid; grid-template-columns: repeat(3, 1fr); gap: 25px; padding: 70px 0; text-align: center; }
        

        .info-card {
            background-color: var(--card-bg) !important;
            border: 1px solid var(--card-border) !important;
            border-radius: 15px; padding: 40px;
            box-shadow: 0 10px 40px rgba(0,0,0,0.1); 
            transition: all 0.4s ease;
        }
        .info-card:hover { transform: translateY(-8px); border-color: #007bff !important; }
        
        .hero-title { color: var(--hero-title) !important; transition: color 0.4s ease; }
        .hero-desc { color: var(--hero-desc) !important; transition: color 0.4s ease; }
        .card-title { color: var(--card-title) !important; transition: color 0.4s ease; }
        .card-desc { color: var(--card-desc) !important; transition: color 0.4s ease; }
        
        .card-image-box { 
            height: 100px; background-color: var(--img-box-bg) !important; color: var(--img-box-text) !important;
            line-height: 100px; margin-bottom: 20px; border-radius: 8px; border: 1px dashed var(--card-border) !important; 
            transition: all 0.4s ease;
        }
    </style>

    <div class="main-wrapper">
        <div class="fit-hero">
            <h1 class="hero-title" style="font-size: 2.8em; margin-bottom: 10px; font-weight: 800;">Welcome to FitHome</h1>
            <p class="hero-desc" style="font-size: 1.25em; max-width: 750px; margin: 0 auto 25px auto; line-height: 1.6;">
                Your personal hub for fitness training, BMI tracking, and expert courses.
            </p>
            <div style="margin-top: 30px; display: flex; justify-content: center; gap: 15px; flex-wrap: wrap;">
                <asp:HyperLink ID="btnRegister" runat="server" NavigateUrl="~/Register.aspx" CssClass="btn-hero btn-hero-primary">Join Now (Register)</asp:HyperLink>
                <asp:HyperLink ID="btnLogin" runat="server" NavigateUrl="~/Login.aspx" CssClass="btn-hero btn-hero-secondary">Member Login</asp:HyperLink>
                <asp:HyperLink ID="btnBrowse" runat="server" NavigateUrl="~/CourseCatalog.aspx" CssClass="btn-hero btn-hero-secondary">Explore Courses</asp:HyperLink>
            </div>
        </div>

        <div class="cards-container">
            <div class="info-card">
                <img src="assets/img/default/professional_course.jpg" alt="Course Image" style="width: 100%; height: 150px; object-fit: cover; border-radius: 5px; margin-bottom: 15px;" />
                <h3 class="card-title" style="font-size: 1.4em; margin-bottom: 12px;">Professional Courses</h3>
                <p class="card-desc" style="font-size: 0.95em; line-height: 1.6;">Access high-quality training videos curated by experts.</p>
            </div>

            <div class="info-card">
                <img src="assets/img/default/bmi_tool.jpg" alt="BMI Tool" style="width: 100%; height: 150px; object-fit: cover; border-radius: 5px; margin-bottom: 15px;" />
                <h3 class="card-title" style="font-size: 1.4em; margin-bottom: 12px;">Track Your Progress</h3>
                <p class="card-desc" style="font-size: 0.95em; line-height: 1.6;">Calculate your BMI and keep a history of your workouts.</p>
            </div>

            <div class="info-card">
                <img src="assets/img/default/member_image.jpg" alt="Member Image" style="width: 100%; height: 150px; object-fit: cover; border-radius: 5px; margin-bottom: 15px;" />
                <h3 class="card-title" style="font-size: 1.4em; margin-bottom: 12px;">Join Our Community</h3>
                <p class="card-desc" style="font-size: 0.95em; line-height: 1.6;">Create an account today to save your favorites and records.</p>
            </div>
        </div>
    </div>
</asp:Content>