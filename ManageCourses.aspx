<%@ Page Title="Manage Courses" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="FitHome.ManageCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div class="row">
        
        <div class="col-md-4 mb-4">
            <div class="card shadow-sm">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">➕ Add New Course</h5>
                </div>
                <div class="card-body">
                    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3 fw-bold" Visible="false"></asp:Label>

                    <div class="mb-3">
                        <label class="form-label">Course Title</label>
                        <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. Morning Yoga"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Category</label>
                        <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                            <asp:ListItem Text="Select Category" Value=""></asp:ListItem>
                            <asp:ListItem Text="Yoga" Value="Yoga"></asp:ListItem>
                            <asp:ListItem Text="Cardio" Value="Cardio"></asp:ListItem>
                            <asp:ListItem Text="Strength" Value="Strength"></asp:ListItem>
                            <asp:ListItem Text="Flexibility" Value="Flexibility"></asp:ListItem>
                        </asp:DropDownList>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Video Link (YouTube URL)</label>
                        <asp:TextBox ID="txtVideoLink" runat="server" CssClass="form-control" placeholder="https://youtube.com/..."></asp:TextBox>
                    </div>
                    
                    <div class="mb-3">
                        <label class="form-label">Thumbnail File Name</label>
                        <asp:TextBox ID="txtThumbnail" runat="server" CssClass="form-control" placeholder="e.g. yoga1.jpg"></asp:TextBox>
                    </div>

                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="3"></asp:TextBox>
                    </div>

                    <asp:Button ID="btnAddCourse" runat="server" Text="Upload Course" CssClass="btn btn-primary w-100" OnClick="btnAddCourse_Click" />
                </div>
            </div>
        </div>

        <div class="col-md-8">
            <div class="card shadow-sm">
                <div class="card-header bg-dark text-white">
                    <h5 class="mb-0">📚 Course List</h5>
                </div>
                <div class="card-body" style="overflow-x: auto;">
                    <asp:GridView ID="gvCourses" runat="server" CssClass="table table-bordered table-hover" 
                        AutoGenerateColumns="False" DataKeyNames="CourseID"
                        OnRowEditing="gvCourses_RowEditing" 
                        OnRowCancelingEdit="gvCourses_RowCancelingEdit" 
                        OnRowUpdating="gvCourses_RowUpdating" 
                        OnRowDeleting="gvCourses_RowDeleting">
                        
                        <Columns>
                            <asp:BoundField DataField="CourseID" HeaderText="ID" ReadOnly="True" />
                            <asp:BoundField DataField="Title" HeaderText="Title" />
                            <asp:BoundField DataField="Category" HeaderText="Category" />
                            <asp:BoundField DataField="VideoLink" HeaderText="Video Link" />
                            
                            <asp:CommandField ShowEditButton="True" ShowDeleteButton="True" ControlStyle-CssClass="btn btn-sm btn-outline-secondary m-1" />
                        </Columns>
                        
                    </asp:GridView>
                </div>
            </div>
        </div>

    </div>
</asp:Content>