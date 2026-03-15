<%@ Page Title="Manage Courses" Language="C#" MasterPageFile="~/Admin.Master" AutoEventWireup="true" CodeBehind="ManageCourses.aspx.cs" Inherits="FitHome.ManageCourses" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style>
        /* Modern Card Styles */
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

        /* Form Input Styling */
        .form-control, .form-select {
            border-radius: 8px;
            padding: 10px 15px;
            border: 1px solid #e0e4e8;
            background-color: #fcfcfc;
            transition: all 0.3s;
        }

        .form-control:focus, .form-select:focus {
            background-color: white;
            border-color: var(--fh-orange);
            box-shadow: 0 0 0 0.2rem rgba(255, 157, 0, 0.15);
        }

        .form-label {
            font-weight: 600;
            color: var(--fh-navy);
            font-size: 0.9rem;
            margin-bottom: 8px;
        }

        /* Brand Button */
        .btn-brand {
            background-color: var(--fh-orange);
            color: white;
            font-weight: bold;
            border-radius: 8px;
            padding: 10px;
            transition: all 0.3s;
            border: none;
        }

        .btn-brand:hover {
            background-color: #e68d00;
            color: white;
            transform: translateY(-2px);
            box-shadow: 0 4px 10px rgba(255, 157, 0, 0.3);
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

        /* GridView Action Buttons (Edit/Delete/Update/Cancel) */
        .modern-table a {
            text-decoration: none;
            padding: 6px 12px;
            border-radius: 6px;
            font-size: 0.85rem;
            font-weight: bold;
            display: inline-block;
            margin: 2px;
            transition: all 0.2s;
        }

        /* Target the Edit/Update buttons */
        .modern-table a:first-child {
            color: var(--fh-navy);
            background-color: rgba(0, 45, 90, 0.1);
        }
        .modern-table a:first-child:hover {
            background-color: var(--fh-navy);
            color: white;
        }

        /* Target the Delete/Cancel buttons */
        .modern-table a:last-child {
            color: #dc3545;
            background-color: rgba(220, 53, 69, 0.1);
        }
        .modern-table a:last-child:hover {
            background-color: #dc3545;
            color: white;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    
    <div class="d-flex justify-content-between align-items-center mb-4">
        <div>
            <h3 class="fw-bold text-dark mb-1">Course Management</h3>
            <p class="text-muted mb-0">Upload, edit, and organize fitness programs.</p>
        </div>
    </div>

    <asp:Label ID="lblMessage" runat="server" CssClass="d-block mb-3 fw-bold" Visible="false"></asp:Label>

    <div class="admin-card mb-4 shadow-sm">
        <div class="admin-card-header d-flex align-items-center bg-white">
            <div class="bg-light rounded-circle p-2 me-3 text-warning">
                <i class="fas fa-plus-circle fa-lg"></i>
            </div>
            <h5 class="mb-0 fw-bold text-dark">Add New Course</h5>
        </div>
        
        <div class="card-body p-4 bg-white">
            <div class="row g-3">
                
                <div class="col-md-4">
                    <label class="form-label">Course Title</label>
                    <asp:TextBox ID="txtTitle" runat="server" CssClass="form-control" placeholder="e.g. 15-Min Morning Yoga"></asp:TextBox>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Category</label>
                    <asp:DropDownList ID="ddlCategory" runat="server" CssClass="form-select">
                        <asp:ListItem Text="Select Category" Value=""></asp:ListItem>
                        <asp:ListItem Text="Yoga" Value="Yoga"></asp:ListItem>
                        <asp:ListItem Text="Cardio" Value="Cardio"></asp:ListItem>
                        <asp:ListItem Text="Strength" Value="Strength"></asp:ListItem>
                        <asp:ListItem Text="Flexibility" Value="Flexibility"></asp:ListItem>
                    </asp:DropDownList>
                </div>

                <div class="col-md-4">
                    <label class="form-label">Video Link (URL)</label>
                    <asp:TextBox ID="txtVideoLink" runat="server" CssClass="form-control" placeholder="https://youtube.com/..."></asp:TextBox>
                </div>
                
                <div class="col-md-4">
                    <label class="form-label">Thumbnail Image</label>
                    <asp:FileUpload ID="fuThumbnail" runat="server" CssClass="form-control" />
                </div>

                <div class="col-md-6">
                    <label class="form-label">Description</label>
                    <asp:TextBox ID="txtDescription" runat="server" CssClass="form-control" TextMode="MultiLine" Rows="2" placeholder="Briefly describe the course..."></asp:TextBox>
                </div>

                <div class="col-md-2 d-flex align-items-end">
                    <asp:Button ID="btnAddCourse" runat="server" Text="Upload Course" CssClass="btn btn-brand w-100 py-2" OnClick="btnAddCourse_Click" />
                </div>

            </div>
        </div>
    </div>

    <div class="admin-card shadow-sm">
        <div class="admin-card-header d-flex justify-content-between align-items-center bg-white">
            <div class="d-flex align-items-center">
                <div class="bg-light rounded-circle p-2 me-3" style="color: var(--fh-navy);">
                    <i class="fas fa-list fa-lg"></i>
                </div>
                <h5 class="mb-0 fw-bold text-dark">Course Repository</h5>
            </div>
            <span class="badge bg-light text-secondary border">Live Data</span>
        </div>
        
        <div class="card-body p-0 bg-white">
            <div class="table-responsive">
                
            <asp:GridView ID="gvCourses" runat="server" CssClass="table modern-table w-100" 
                AutoGenerateColumns="False" DataKeyNames="CourseID,Thumbnail" GridLines="None"
                OnRowEditing="gvCourses_RowEditing" 
                OnRowCancelingEdit="gvCourses_RowCancelingEdit" 
                OnRowUpdating="gvCourses_RowUpdating" 
                OnRowDeleting="gvCourses_RowDeleting">
    
                <Columns>
                    <asp:BoundField DataField="CourseID" HeaderText="ID" ReadOnly="True">
                        <ItemStyle CssClass="fw-bold text-muted text-center" Width="60px" />
                    </asp:BoundField>
        
                    <asp:TemplateField HeaderText="Thumbnail">
                        <ItemTemplate>
                            <img src='<%# ResolveUrl("~/assets/img/courses/" + Eval("Thumbnail")) %>' alt="Course Image" 
                                 style="width: 140px; height: 85px; object-fit: cover; border-radius: 8px;" 
                                 onerror="this.src='assets/img/logo.webp'" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:FileUpload ID="fuEditThumbnail" runat="server" CssClass="form-control form-control-sm mb-1" />
                            <small class="text-muted d-block mt-1">Leave empty to keep current image</small>
                        </EditItemTemplate>
                        <ItemStyle Width="160px" CssClass="text-center" />
                    </asp:TemplateField>

                    <%-- Updated Title Column to TemplateField --%>
                    <asp:TemplateField HeaderText="Course Title">
                        <ItemTemplate>
                            <asp:Label ID="lblTitle" runat="server" Text='<%# Eval("Title") %>' CssClass="fw-semibold text-dark fs-6"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditTitle" runat="server" Text='<%# Bind("Title") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
        
                    <asp:TemplateField HeaderText="Category">
                        <ItemTemplate>
                            <span class="badge bg-light text-dark border px-3 py-2"><%# Eval("Category") %></span>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlEditCategory" runat="server" CssClass="form-select" SelectedValue='<%# Bind("Category") %>'>
                                <asp:ListItem Text="Yoga" Value="Yoga"></asp:ListItem>
                                <asp:ListItem Text="Cardio" Value="Cardio"></asp:ListItem>
                                <asp:ListItem Text="Strength" Value="Strength"></asp:ListItem>
                                <asp:ListItem Text="Flexibility" Value="Flexibility"></asp:ListItem>
                            </asp:DropDownList>
                        </EditItemTemplate>
                        <ItemStyle Width="140px" />
                    </asp:TemplateField>

                    <%-- Updated Video Link Column to TemplateField --%>
                    <asp:TemplateField HeaderText="Video Link">
                        <ItemTemplate>
                            <asp:Label ID="lblVideo" runat="server" Text='<%# Eval("VideoLink") %>' CssClass="text-primary"></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="txtEditVideo" runat="server" Text='<%# Bind("VideoLink") %>' CssClass="form-control form-control-sm"></asp:TextBox>
                        </EditItemTemplate>
                    </asp:TemplateField>
        
                    <asp:TemplateField HeaderText="Actions">
                        <ItemTemplate>
                            <asp:LinkButton ID="btnEdit" runat="server" CommandName="Edit">Edit</asp:LinkButton>
                            <asp:LinkButton ID="btnDelete" runat="server" CommandName="Delete" 
                                OnClientClick="return confirm('Are you sure you want to delete this course?');">Delete</asp:LinkButton>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:LinkButton ID="btnUpdate" runat="server" CommandName="Update">Update</asp:LinkButton>
                            <asp:LinkButton ID="btnCancel" runat="server" CommandName="Cancel">Cancel</asp:LinkButton>
                        </EditItemTemplate>
                        <ItemStyle Width="180px" CssClass="text-center" />
                    </asp:TemplateField>
                </Columns>
            </asp:GridView>

            </div>
        </div>
    </div>

</asp:Content>