<%@ Page Title="Admin Dashboard" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="AdminDashboard.aspx.cs" Inherits="FitHome.AdminDashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <h2 class="mb-4">Welcome back, <asp:Label ID="lblAdminName" runat="server" Text="Admin"></asp:Label>! 👋</h2>

    <div class="row">
        <div class="col-md-4">
            <div class="card text-white bg-primary mb-3 shadow-sm">
                <div class="card-header">Total Courses</div>
                <div class="card-body">
                    <h1 class="card-title text-center">
                        <asp:Label ID="lblTotalCourses" runat="server" Text="0"></asp:Label>
                    </h1>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card text-white bg-success mb-3 shadow-sm">
                <div class="card-header">Registered Users</div>
                <div class="card-body">
                    <h1 class="card-title text-center">
                        <asp:Label ID="lblTotalUsers" runat="server" Text="0"></asp:Label>
                    </h1>
                </div>
            </div>
        </div>
    </div>

</asp:Content>