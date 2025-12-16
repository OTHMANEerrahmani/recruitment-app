<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.recruitment.entity.User" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Edit User - RecruttAnty Admin</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">
        </head>

        <body>
            <header>
                <nav class="container">
                    <a href="${pageContext.request.contextPath}/admin/dashboard" class="logo">
                        <div class="logo-icon">R</div>
                        RECRUITANTY Admin
                    </a>
                    <ul class="nav-links">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                    </ul>
                </nav>
            </header>

            <main class="admin-container">
                <div class="breadcrumb">
                    <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
                    <span class="breadcrumb-separator">/</span>
                    <span class="breadcrumb-active">Edit User</span>
                </div>

                <div class="admin-card" style="max-width: 550px; margin: 0 auto; padding: 3rem;">
                    <div style="text-align: center; margin-bottom: 2.5rem;">
                        <!-- Profile Avatar -->
                        <div
                            style="width: 80px; height: 80px; background: #f1f5f9; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; color: #64748b; font-weight: 700; font-size: 2rem;">
                            <%= ((User)request.getAttribute("userToEdit")).getEmail().substring(0, 1).toUpperCase() %>
                        </div>
                        <h2 style="font-size: 1.8rem; margin-bottom: 0.5rem; color: #1a1a1a;">Edit User</h2>
                        <p style="color: #64748b;">Manage role and permissions</p>
                    </div>

                    <% User userToEdit=(User) request.getAttribute("userToEdit"); %>

                        <form action="${pageContext.request.contextPath}/admin/update-user" method="post">
                            <input type="hidden" name="id" value="<%= userToEdit.getId() %>">

                            <div class="form-group" style="margin-bottom: 1.5rem;">
                                <label
                                    style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #374151; font-size: 0.9rem;">Email
                                    Address</label>
                                <input type="text" value="<%= userToEdit.getEmail() %>" disabled
                                    style="width: 100%; padding: 0.8rem 1rem; border-radius: 12px; border: 1px solid #e2e8f0; background-color: #f8fafc; color: #64748b; font-family: inherit;">
                            </div>

                            <div class="form-group" style="margin-bottom: 2rem;">
                                <label
                                    style="display: block; margin-bottom: 0.5rem; font-weight: 600; color: #374151; font-size: 0.9rem;">Role</label>
                                <div style="position: relative;">
                                    <select name="role"
                                        style="width: 100%; padding: 0.9rem 1rem; border-radius: 12px; border: 1px solid #e2e8f0; background-color: white; color: #1a1a1a; font-family: inherit; font-size: 1rem; cursor: pointer; appearance: none;">
                                        <option value="CANDIDATE" <%=userToEdit.getRole()==User.Role.CANDIDATE
                                            ? "selected" : "" %>>Candidate</option>
                                        <option value="COMPANY" <%=userToEdit.getRole()==User.Role.COMPANY ? "selected"
                                            : "" %>>Company</option>
                                        <option value="ADMIN" <%=userToEdit.getRole()==User.Role.ADMIN ? "selected" : ""
                                            %>>Admin</option>
                                    </select>
                                    <div
                                        style="position: absolute; right: 1rem; top: 50%; transform: translateY(-50%); pointer-events: none; color: #64748b;">
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="2" stroke-linecap="round"
                                            stroke-linejoin="round">
                                            <polyline points="6 9 12 15 18 9"></polyline>
                                        </svg>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group"
                                style="margin-bottom: 2.5rem; background: #f8fafc; padding: 1.5rem; border-radius: 16px; border: 1px solid #f1f5f9;">
                                <label
                                    style="display: block; margin-bottom: 1rem; font-weight: 600; color: #374151; font-size: 0.9rem;">Account
                                    Status</label>
                                <div style="display: flex; gap: 0.8rem;">
                                    <button type="submit" name="action" value="activate"
                                        style="flex: 1; border: 1px solid <%= userToEdit.isActive() ? " #10b981"
                                        : "#e5e7eb" %>; background: <%= userToEdit.isActive() ? "#ecfdf5" : "white" %>;
                                            color: <%= userToEdit.isActive() ? "#059669" : "#6b7280" %>; padding:
                                                0.8rem; border-radius: 10px; font-weight: 600; cursor: pointer;
                                                transition: all 0.2s; display: flex; align-items: center;
                                                justify-content: center; gap: 0.5rem;">
                                                <% if(userToEdit.isActive()) { %> <svg width="16" height="16"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="3">
                                                        <polyline points="20 6 9 17 4 12"></polyline>
                                                    </svg>
                                                    <% } %>
                                                        Active
                                    </button>
                                    <button type="submit" name="action" value="deactivate"
                                        style="flex: 1; border: 1px solid <%= !userToEdit.isActive() ? " #ef4444"
                                        : "#e5e7eb" %>; background: <%= !userToEdit.isActive() ? "#fef2f2" : "white" %>;
                                            color: <%= !userToEdit.isActive() ? "#dc2626" : "#6b7280" %>; padding:
                                                0.8rem; border-radius: 10px; font-weight: 600; cursor: pointer;
                                                transition: all 0.2s; display: flex; align-items: center;
                                                justify-content: center; gap: 0.5rem;">
                                                <% if(!userToEdit.isActive()) { %> <svg width="16" height="16"
                                                        viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                                        stroke-width="3">
                                                        <line x1="18" y1="6" x2="6" y2="18"></line>
                                                        <line x1="6" y1="6" x2="18" y2="18"></line>
                                                    </svg>
                                                    <% } %>
                                                        Inactive
                                    </button>
                                </div>
                            </div>

                            <div style="display: flex; gap: 1rem;">
                                <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-secondary"
                                    style="flex: 1; text-align: center; justify-content: center; border-color: #cbd5e1;">Cancel</a>
                                <button type="submit" name="action" value="save" class="btn btn-primary"
                                    style="flex: 2; justify-content: center; background: #1a1a1a;">
                                    Save Changes
                                </button>
                            </div>
                        </form>
                </div>
            </main>
        </body>

        </html>