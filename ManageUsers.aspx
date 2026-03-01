<%@ Page Title="User List" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ManageUsers.aspx.cs" Inherits="FitHome.ManageUsers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="card shadow-sm mt-4">
        <div class="card-header bg-danger text-white">
            <h5 class="mb-0">👥 Registered Users Management</h5>
        </div>
        <div class="card-body" style="overflow-x: auto;">
            
            <asp:GridView ID="gvUsers" runat="server" CssClass="table table-bordered table-hover" 
                AutoGenerateColumns="False" DataKeyNames="UserID"
                OnRowDeleting="gvUsers_RowDeleting">
                
                <Columns>
                    <asp:BoundField DataField="UserID" HeaderText="ID" ReadOnly="True" />
                    <asp:BoundField DataField="Username" HeaderText="Username" />
                    <asp:BoundField DataField="Email" HeaderText="Email" />
                    <asp:BoundField DataField="Weight" HeaderText="Weight (kg)" />
                    <asp:BoundField DataField="Height" HeaderText="Height (cm)" />
                    
                    <asp:CommandField ShowDeleteButton="True" HeaderText="Action" ControlStyle-CssClass="btn btn-sm btn-outline-danger" />
                </Columns>
                
            </asp:GridView>

        </div>
    </div>
</asp:Content>
