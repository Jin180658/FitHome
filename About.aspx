<%@ Page Title="About FitHome" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="About.aspx.cs" Inherits="FitHome.About" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">

<style>
/* Magic Dictionary for About Page */
:root {
    --about-card-bg: #ffffff;
    --about-text-main: #333333;
    --about-text-muted: #555555;
    --about-border: #eeeeee;
    --about-img-border: #eeeeee;
}

/* 🌙 Auto-invert colors on Dark Mode */
[data-theme="dark"] {
    --about-card-bg: #1e1e1e;
    --about-text-main: #ffffff;
    --about-text-muted: #bbbbbb;
    --about-border: #333333;
    --about-img-border: #2a2a2a;
}

body {
    font-family: Arial, sans-serif;
}


.about-container { width: 85%; margin: auto; }


.title {
    text-align: center; font-size: 36px; font-weight: bold;
    margin-top: 40px; margin-bottom: 20px;
    color: var(--about-text-main) !important;
    transition: color 0.3s ease;
}

.project-section {
    display: flex; justify-content: space-between; align-items: stretch; 
    gap: 40px; margin-bottom: 80px; flex-wrap: wrap;
}

.project-card {
    background: var(--about-card-bg) !important;
    padding: 35px; border-radius: 12px;
    box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    flex: 1 1 450px; min-width: 300px;
    border: 1px solid var(--about-border) !important;
    transition: background-color 0.3s ease, border-color 0.3s ease;
}

.project-text {
    font-size: 18px; line-height: 1.8; text-align: justify;
    color: var(--about-text-muted) !important;
    transition: color 0.3s ease;
}

.logo-container {
    flex: 1 1 300px; text-align: center; display: flex;
    justify-content: center; align-items: center;
    background: var(--about-card-bg) !important; 
    border-radius: 12px; box-shadow: 0 6px 18px rgba(0,0,0,0.08);
    padding: 20px; border: 1px solid var(--about-border) !important;
    transition: background-color 0.3s ease, border-color 0.3s ease;
}

.logo-container img { max-width: 100%; max-height: 100%; object-fit: contain; }

.team-container {
    display: flex; justify-content: space-around; flex-wrap: wrap;
    gap: 30px; margin-top: 60px;
}

.member {
    background: var(--about-card-bg) !important;
    width: 250px; border-radius: 12px;
    box-shadow: 0 6px 15px rgba(0,0,0,0.08);
    text-align: center; transition: 0.3s;
    border: 1px solid var(--about-border) !important;
    padding-top: 25px;
    padding-bottom: 20px;
}

.member:hover {
    transform: translateY(-6px);
    box-shadow: 0 10px 22px rgba(0,0,0,0.15);
    border-color: #0d6efd !important;
}

.member img {
    width: 180px; height: 180px; border-radius: 50%;
    object-fit: cover; border: 4px solid var(--about-img-border) !important;
    margin-bottom: 15px; transition: border-color 0.3s ease;
}

.member-name {
    font-size: 20px; font-weight: bold; margin-bottom: 6px;
    color: var(--about-text-main) !important; 
    transition: color 0.3s ease;
}
</style>

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

<div class="about-container">

    <div class="title">About FitHome Academy</div>

    <div class="project-section">

        <div class="project-card">
            <div class="project-text">
                <p>
                    <b>FitHome Academy</b> is a web-based fitness learning system designed for home-based fitness education. 
                    The platform allows administrators to manage courses while users can access structured fitness learning 
                    materials after registration.
                </p>
                <p>
                    Visitors can browse previews of available fitness courses before creating an account. 
                    After registering and logging in, users can access full workout tutorials, track progress, 
                    and manage their personal fitness information.
                </p>
                <p>
                    The system also provides administrators with a dedicated management interface to upload new learning materials, 
                    update course information, and manage user accounts.
                </p>
                <p>
                    The objective of FitHome Academy is to provide an accessible digital platform that encourages 
                    healthy workout habits through structured tutorials suitable for home exercise without specialized gym equipment.
                </p>
            </div>
        </div>

        <div class="logo-container">
            <img src="assets/img/logo.png" alt="FitHome Logo"/>
        </div>
    </div>


    <div class="title">Team Members</div>
    <div class="team-container">

        <div class="member">
            <img src="assets/img/member1.jpeg"/>
            <div class="member-name">Wong Jin Jie</div>
        </div>

        <div class="member">
            <img src="assets/img/member2.jpeg"/>
            <div class="member-name">Wong Zi Yee</div>
        </div>

        <div class="member">
            <img src="assets/img/member3.jpg"/>
            <div class="member-name">Jay Chew Jie Lun</div>
        </div>

        <div class="member">
            <img src="assets/img/member4.jpeg"/>
            <div class="member-name">Pang Jin Yit</div>
        </div>

    </div>

    <div style="height:80px;"></div>

</div>

</asp:Content>