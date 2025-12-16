<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.User" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin Dashboard - RecruttAnty</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
                <link rel="preconnect" href="https://fonts.googleapis.com">
                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                    rel="stylesheet">
            </head>

            <body>
                <header>
                    <nav class="container">
                        <a href="#" class="logo">
                            <div class="logo-icon">R</div>
                            RECRUITANTY Admin
                        </a>
                        <ul class="nav-links">
                            <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                        </ul>
                    </nav>
                </header>

                <main class="admin-container">
                    <!-- Error Message Alert -->
                    <% String errorMessage=(String) request.getAttribute("errorMessage"); if (errorMessage !=null) { %>
                        <div
                            style="background-color: #fef2f2; color: #dc2626; border: 1px solid #fee2e2; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; display: flex; align-items: center; gap: 0.8rem; font-weight: 500; font-size: 0.95rem;">
                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                stroke-width="2">
                                <circle cx="12" cy="12" r="10"></circle>
                                <line x1="12" y1="8" x2="12" y2="12"></line>
                                <line x1="12" y1="16" x2="12.01" y2="16"></line>
                            </svg>
                            <%= errorMessage %>
                        </div>
                        <% } %>

                            <!-- Success Message Alert -->
                            <% String msg=(String) session.getAttribute("message"); String msgType=(String)
                                session.getAttribute("messageType"); if (msg !=null) { String bgColor="success"
                                .equals(msgType) ? "#ecfdf5" : "#fef2f2" ; String color="success" .equals(msgType)
                                ? "#059669" : "#dc2626" ; String borderColor="success" .equals(msgType) ? "#d1fae5"
                                : "#fee2e2" ; %>
                                <div
                                    style="background-color: <%= bgColor %>; color: <%= color %>; border: 1px solid <%= borderColor %>; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; display: flex; align-items: center; gap: 0.8rem; font-weight: 500; font-size: 0.95rem;">
                                    <% if ("success".equals(msgType)) { %>
                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                            stroke="currentColor" stroke-width="2">
                                            <path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path>
                                            <polyline points="22 4 12 14.01 9 11.01"></polyline>
                                        </svg>
                                        <% } else { %>
                                            <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                stroke="currentColor" stroke-width="2">
                                                <circle cx="12" cy="12" r="10"></circle>
                                                <line x1="12" y1="8" x2="12" y2="12"></line>
                                                <line x1="12" y1="16" x2="12.01" y2="16"></line>
                                            </svg>
                                            <% } %>
                                                <%= msg %>
                                </div>
                                <% session.removeAttribute("message"); session.removeAttribute("messageType"); } %>

                                    <!-- User Management Card -->
                                    <div class="admin-card">
                                        <div class="admin-card-header">
                                            <h2 class="admin-title">User Management</h2>
                                            <div class="header-actions">
                                                <!-- Future: <button class="btn btn-primary btn-sm">Add User</button> -->
                                            </div>
                                        </div>

                                        <div class="admin-table-container">
                                            <table class="admin-table">
                                                <thead>
                                                    <tr>
                                                        <th width="80">ID</th>
                                                        <th>User Details</th>
                                                        <th>Role</th>
                                                        <th>Status</th>
                                                        <th style="text-align: right;">Actions</th>
                                                    </tr>
                                                </thead>
                                                <tbody>
                                                    <% @SuppressWarnings("unchecked") List<User> users = (List<User>)
                                                            request.getAttribute("users");
                                                            if (users != null && !users.isEmpty()) {
                                                            for (User u : users) {
                                                            %>
                                                            <tr>
                                                                <td style="color: #64748b; font-family: monospace;">#<%=
                                                                        u.getId() %>
                                                                </td>
                                                                <td>
                                                                    <div
                                                                        style="display: flex; align-items: center; gap: 0.8rem;">
                                                                        <div
                                                                            style="width: 32px; height: 32px; background: #eff6ff; border-radius: 50%; display: flex; align-items: center; justify-content: center; color: #3b82f6; font-weight: 700; font-size: 0.85rem;">
                                                                            <%= u.getEmail().substring(0,
                                                                                1).toUpperCase() %>
                                                                        </div>
                                                                        <span style="font-weight: 500;">
                                                                            <%= u.getEmail() %>
                                                                        </span>
                                                                    </div>
                                                                </td>
                                                                <td>
                                                                    <span class="badge badge-role-<%= u.getRole() %>">
                                                                        <%= u.getRole() %>
                                                                    </span>
                                                                </td>
                                                                <td>
                                                                    <% if (u.isActive()) { %>
                                                                        <span
                                                                            class="badge badge-status-active">Active</span>
                                                                        <% } else { %>
                                                                            <span
                                                                                class="badge badge-status-inactive">Inactive</span>
                                                                            <% } %>
                                                                </td>
                                                                <td style="text-align: right;">
                                                                    <div class="actions-cell">
                                                                        <% if (u.getRole()==User.Role.COMPANY) { %>
                                                                            <a href="${pageContext.request.contextPath}/admin/company-offers?companyId=<%= u.getId() %>"
                                                                                class="action-btn"
                                                                                data-tooltip="View Offers"
                                                                                style="color: #0284c7;">
                                                                                <svg width="16" height="16"
                                                                                    viewBox="0 0 24 24" fill="none"
                                                                                    stroke="currentColor"
                                                                                    stroke-width="2"
                                                                                    stroke-linecap="round"
                                                                                    stroke-linejoin="round">
                                                                                    <path
                                                                                        d="M14 2H6a2 2 0 0 0-2 2v16a2 2 0 0 0 2 2h12a2 2 0 0 0 2-2V8z">
                                                                                    </path>
                                                                                    <polyline points="14 2 14 8 20 8">
                                                                                    </polyline>
                                                                                    <line x1="16" y1="13" x2="8"
                                                                                        y2="13"></line>
                                                                                    <line x1="16" y1="17" x2="8"
                                                                                        y2="17"></line>
                                                                                    <polyline points="10 9 9 9 8 9">
                                                                                    </polyline>
                                                                                </svg>
                                                                            </a>
                                                                            <% } %>

                                                                                <% if (u.getRole()==User.Role.CANDIDATE)
                                                                                    { %>
                                                                                    <a href="${pageContext.request.contextPath}/admin/candidate-profile?candidateId=<%= u.getId() %>"
                                                                                        class="action-btn"
                                                                                        data-tooltip="View Profile"
                                                                                        style="color: #7c3aed;">
                                                                                        <svg width="16" height="16"
                                                                                            viewBox="0 0 24 24"
                                                                                            fill="none"
                                                                                            stroke="currentColor"
                                                                                            stroke-width="2"
                                                                                            stroke-linecap="round"
                                                                                            stroke-linejoin="round">
                                                                                            <path
                                                                                                d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2">
                                                                                            </path>
                                                                                            <circle cx="12" cy="7"
                                                                                                r="4"></circle>
                                                                                        </svg>
                                                                                    </a>
                                                                                    <% } %>

                                                                                        <a href="${pageContext.request.contextPath}/admin/edit-user?id=<%= u.getId() %>"
                                                                                            class="action-btn btn-edit"
                                                                                            data-tooltip="Edit User">
                                                                                            <svg width="16" height="16"
                                                                                                viewBox="0 0 24 24"
                                                                                                fill="none"
                                                                                                stroke="currentColor"
                                                                                                stroke-width="2"
                                                                                                stroke-linecap="round"
                                                                                                stroke-linejoin="round">
                                                                                                <path
                                                                                                    d="M11 4H4a2 2 0 0 0-2 2v14a2 2 0 0 0 2 2h14a2 2 0 0 0 2-2v-7">
                                                                                                </path>
                                                                                                <path
                                                                                                    d="M18.5 2.5a2.121 2.121 0 0 1 3 3L12 15l-4 1 1-4 9.5-9.5z">
                                                                                                </path>
                                                                                            </svg>
                                                                                        </a>

                                                                                        <button type="button"
                                                                                            onclick="showDeleteModal(<%= u.getId() %>, '<%= u.getEmail() %>')"
                                                                                            class="action-btn btn-delete"
                                                                                            data-tooltip="Delete User">
                                                                                            <svg width="16" height="16"
                                                                                                viewBox="0 0 24 24"
                                                                                                fill="none"
                                                                                                stroke="currentColor"
                                                                                                stroke-width="2"
                                                                                                stroke-linecap="round"
                                                                                                stroke-linejoin="round">
                                                                                                <polyline
                                                                                                    points="3 6 5 6 21 6">
                                                                                                </polyline>
                                                                                                <path
                                                                                                    d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2">
                                                                                                </path>
                                                                                                <line x1="10" y1="11"
                                                                                                    x2="10" y2="17">
                                                                                                </line>
                                                                                                <line x1="14" y1="11"
                                                                                                    x2="14" y2="17">
                                                                                                </line>
                                                                                            </svg>
                                                                                        </button>
                                                                    </div>
                                                                </td>
                                                            </tr>
                                                            <% } } else { %>
                                                                <tr>
                                                                    <td colspan="5"
                                                                        style="text-align: center; padding: 4rem; color: #64748b;">
                                                                        <div
                                                                            style="font-size: 3rem; margin-bottom: 1rem;">
                                                                            🤔</div>
                                                                        <p>No users found in the system yet.</p>
                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                </tbody>
                                            </table>
                                        </div>
                                    </div>
                </main>

                <!-- Professional Delete Modal -->
                <div id="deleteModal" class="modal-overlay">
                    <div class="modal-dialog">
                        <div class="modal-body">
                            <div class="modal-icon-danger">
                                <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                    stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                                    <path
                                        d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z">
                                    </path>
                                    <line x1="12" y1="9" x2="12" y2="13"></line>
                                    <line x1="12" y1="17" x2="12.01" y2="17"></line>
                                </svg>
                            </div>
                            <h3 class="modal-title">Delete User Account</h3>
                            <p class="modal-desc">Are you sure you want to delete <strong
                                    id="deleteUserEmail"></strong>?<br>This action cannot be undone.</p>
                        </div>
                        <div class="modal-actions">
                            <button onclick="closeDeleteModal()" class="btn-modal btn-cancel">Cancel</button>
                            <a id="confirmDeleteBtn" href="#" class="btn-modal btn-danger">Delete User</a>
                        </div>
                    </div>
                </div>

                <script>
                    function showDeleteModal(userId, userEmail) {
                        const modal = document.getElementById('deleteModal');
                        if (modal) {
                            document.getElementById('deleteUserEmail').textContent = userEmail;
                            document.getElementById('confirmDeleteBtn').href = '${pageContext.request.contextPath}/admin/delete-user?id=' + userId;
                            modal.classList.add('active');
                        }
                    }

                    function closeDeleteModal() {
                        const modal = document.getElementById('deleteModal');
                        if (modal) {
                            modal.classList.remove('active');
                        }
                    }

                    const modal = document.getElementById('deleteModal');
                    if (modal) {
                        modal.addEventListener('click', function (e) {
                            if (e.target === this) closeDeleteModal();
                        });
                    }
                </script>
            </body>

            </html>