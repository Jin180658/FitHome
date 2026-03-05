<%@ Page Title="User List" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="FitHome.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Shared Card Styles from ManageCourses */
        .admin-card {
            border: none;
            border-radius: 15px;
            box-shadow: 0 8px 20px rgba(0,0,0,0.05);
            background-color: white;
            overflow: hidden;
        }

        .admin-card-header {
            background-color: transparent;
            border-bottom: 1px solid rgba(0,0,0,0.05);
            padding: 20px 25px;
        }

        /* Form Input Styling for Search Bar */
        .form-control {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #e0e4e8;
            background-color: #fcfcfc;
            transition: all 0.3s;
        }

        .form-control:focus {
            background-color: white;
            border-color: var(--fh-navy);
            box-shadow: 0 0 0 0.2rem rgba(0, 45, 90, 0.15);
        }

        /* Brand Button */
        .btn-brand {
            background-color: var(--fh-navy);
            color: white;
            font-weight: bold;
            border-radius: 8px;
            padding: 10px;
            transition: all 0.3s;
            border: none;
        }

        .btn-brand:hover {
            background-color: #001f3f;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(0, 45, 90, 0.3);
        }

        /* GridView (Table) Styling */
        .modern-table {
            margin-bottom: 0;
            border-collapse: separate;
            border-spacing: 0;
        }

        .modern-table th {
            background-color: #f8f9fa;
            color: #6c757d;
            font-size: 0.85rem;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            border-bottom: 2px solid #e9ecef !important;
            padding: 15px;
            font-weight: 600;
        }

        .modern-table td {
            padding: 15px;
            vertical-align: middle;
            border-bottom: 1px solid #f1f3f5;
            color: #495057;
        }

        .modern-table tr:hover td {
            background-color: #fdfdfe;
        }

        /* GridView Action Button (Delete) */
        .modern-table a {
            text-decoration: none;
            padding: 8px 16px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: bold;
            display: inline-block;
            transition: all 0.2s;
            color: #dc3545;
            background-color: rgba(220, 53, 69, 0.1);
        }

        .modern-table a:hover {
            background-color: #dc3545;
            color: white;
        }
        
        /* Avatar styling */
        .user-avatar {
            width: 45px;
            height: 45px;
            border-radius: 50%;
            object-fit: cover;
            border: 2px solid #fff;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">User Management</h3>
            <p class="text-muted mb-0">Search, monitor, and manage registered members.</p>
        </div>
    </div>

    <div class="admin-card mb-4 shadow-sm">
        <div class="card-body p-4 bg-white">
            <div class="row g-3 align-items-center">
                <div class="col-md-8">
                    <div class="input-group">
                        <span class="input-group-text bg-white border-end-0 text-muted"><i class="fas fa-search"></i></span>
                        <asp:TextBox ID="txtSearch" runat="server" CssClass="form-control border-start-0 ps-0" placeholder="Search by Username or Email address..."></asp:TextBox>
                    </div>
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnSearch" runat="server" Text="Search Users" CssClass="btn btn-brand w-100 py-2" OnClick="btnSearch_Click" />
                </div>
                <div class="col-md-2">
                    <asp:Button ID="btnClear" runat="server" Text="Clear" CssClass="btn btn-light border w-100 py-2 fw-bold text-secondary" OnClick="btnClear_Click" />
                </div>
            </div>
        </div>
    </div>

    <div class="admin-card shadow-sm">
        <div class="admin-card-header d-flex justify-content-between align-items-center bg-white">
            <div class="d-flex align-items-center">
                <div class="bg-light rounded-circle p-2 me-3 text-success">
                    <i class="fas fa-users fa-lg"></i>
                </div>
                <h5 class="mb-0 fw-bold text-dark">Registered Members Directory</h5>
            </div>
            <asp:Label ID="lblUserCount" runat="server" CssClass="badge bg-light text-secondary border px-3 py-2"></asp:Label>
        </div>
        
        <div class="card-body p-0 bg-white">
            <div class="table-responsive">
                
                <asp:GridView ID="gvUsers" runat="server" CssClass="table modern-table w-100" 
                    AutoGenerateColumns="False" DataKeyNames="UserID" GridLines="None"
                    OnRowDeleting="gvUsers_RowDeleting">
                    
                    <Columns>
                        <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True">
                            <ItemStyle CssClass="fw-bold text-muted text-center" Width="60px" />
                        </asp:BoundField>
                        
                        <asp:TemplateField HeaderText="Profile">
                            <ItemTemplate>
                                <img src='<%# ResolveUrl("~/assets/img/profiles/" + Eval("ProfilePic")) %>' alt="Avatar" class="user-avatar" onerror="this.src='assets/img/profiles/defaultUser.png'" />
                            </ItemTemplate>
                            <ItemStyle Width="80px" CssClass="text-center" />
                        </asp:TemplateField>

                        <asp:BoundField DataField="Username" HeaderText="Username">
                            <ItemStyle CssClass="fw-bold text-dark fs-6" />
                        </asp:BoundField>
                        
                        <asp:BoundField DataField="Email" HeaderText="Email Address">
                            <ItemStyle CssClass="text-muted" />
                        </asp:BoundField>

                        <asp:BoundField DataField="Weight" HeaderText="Weight (kg)">
                            <ItemStyle Width="120px" CssClass="text-center" />
                        </asp:BoundField>
                        
                        <asp:BoundField DataField="Height" HeaderText="Height (cm)">
                            <ItemStyle Width="120px" CssClass="text-center" />
                        </asp:BoundField>
                        
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                    OnClientClick="return confirm('🚨 WARNING: Are you sure you want to PERMANENTLY delete this user?\n\nThis action cannot be undone and all their data will be lost.');">
                                    <i class="fas fa-user-times me-1"></i> Delete
                                </asp:LinkButton>
                            </ItemTemplate>
                            <ItemStyle Width="140px" CssClass="text-center" />
                        </asp:TemplateField>
                    </Columns>
                    
                </asp:GridView>

            </div>
        </div>
    </div>

</asp:Content>