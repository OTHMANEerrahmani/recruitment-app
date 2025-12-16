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

                                    <% @SuppressWarnings("unchecked") List<User> users = (List<User>)
                                            request.getAttribute("users");
                                            int totalUsers = 0;
                                            int totalCandidates = 0;
                                            int totalCompanies = 0;

                                            if (users != null) {
                                            totalUsers = users.size();
                                            for (User u : users) {
                                            if (u.getRole() == User.Role.CANDIDATE) {
                                            totalCandidates++;
                                            } else if (u.getRole() == User.Role.COMPANY) {
                                            totalCompanies++;
                                            }
                                            }
                                            }
                                            %>

                                            <!-- Key Metrics (Compact Row) -->
                                            <div class="admin-stats-grid">
                                                <div class="admin-stat-card">
                                                    <div class="admin-stat-info">
                                                        <div class="admin-stat-label">Total Users</div>
                                                        <div class="admin-stat-value">
                                                            <%= totalUsers %>
                                                        </div>
                                                    </div>
                                                    <div class="admin-stat-icon">
                                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-width="2">
                                                            <path d="M17 21v-2a4 4 0 0 0-4-4H5a4 4 0 0 0-4 4v2"></path>
                                                            <circle cx="9" cy="7" r="4"></circle>
                                                            <path d="M23 21v-2a4 4 0 0 0-3-3.87"></path>
                                                            <path d="M16 3.13a4 4 0 0 1 0 7.75"></path>
                                                        </svg>
                                                    </div>
                                                </div>

                                                <div class="admin-stat-card">
                                                    <div class="admin-stat-info">
                                                        <div class="admin-stat-label">Candidates</div>
                                                        <div class="admin-stat-value">
                                                            <%= totalCandidates %>
                                                        </div>
                                                    </div>
                                                    <div class="admin-stat-icon"
                                                        style="color: #7c3aed; background: #f5f3ff;">
                                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-width="2">
                                                            <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                                                            <circle cx="12" cy="7" r="4"></circle>
                                                        </svg>
                                                    </div>
                                                </div>

                                                <div class="admin-stat-card">
                                                    <div class="admin-stat-info">
                                                        <div class="admin-stat-label">Companies</div>
                                                        <div class="admin-stat-value">
                                                            <%= totalCompanies %>
                                                        </div>
                                                    </div>
                                                    <div class="admin-stat-icon"
                                                        style="color: #0284c7; background: #f0f9ff;">
                                                        <svg width="20" height="20" viewBox="0 0 24 24" fill="none"
                                                            stroke="currentColor" stroke-width="2">
                                                            <rect x="2" y="7" width="20" height="14" rx="2" ry="2">
                                                            </rect>
                                                            <path d="M16 21V5a2 2 0 0 0-2-2h-4a2 2 0 0 0-2 2v16"></path>
                                                        </svg>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Tabs Navigation -->
                                            <div class="admin-tabs">
                                                <button class="admin-tab active" onclick="switchTab('all')">All
                                                    Users</button>
                                                <button class="admin-tab"
                                                    onclick="switchTab('candidates')">Candidates</button>
                                                <button class="admin-tab"
                                                    onclick="switchTab('companies')">Companies</button>
                                            </div>

                                            <!-- All Users Section -->
                                            <div id="section-all" class="admin-section active">
                                                <div class="admin-card">
                                                    <div class="admin-card-header">
                                                        <div>
                                                            <h2 class="admin-title">All Users</h2>
                                                            <p
                                                                style="margin: 0.2rem 0 0; font-size: 0.85rem; color: #64748b;">
                                                                Complete user registry</p>
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
                                                                <% if (users !=null && !users.isEmpty()) { for (User u :
                                                                    users) { %>
                                                                    <%@ include
                                                                        file="/WEB-INF/views/admin/fragments/user_row.jspf"
                                                                        %>
                                                                        <% } } else { %>
                                                                            <tr>
                                                                                <td colspan="5"
                                                                                    style="text-align: center; padding: 2rem;">
                                                                                    No users found.</td>
                                                                            </tr>
                                                                            <% } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Candidates Section -->
                                            <div id="section-candidates" class="admin-section" style="display: none;">
                                                <div class="admin-card">
                                                    <div class="admin-card-header">
                                                        <div>
                                                            <h2 class="admin-title">Candidate Management</h2>
                                                            <p
                                                                style="margin: 0.2rem 0 0; font-size: 0.85rem; color: #64748b;">
                                                                View and manage job seekers</p>
                                                        </div>
                                                    </div>
                                                    <div class="admin-table-container">
                                                        <table class="admin-table">
                                                            <thead>
                                                                <tr>
                                                                    <th width="80">ID</th>
                                                                    <th>User Details</th>
                                                                    <th>Status</th>
                                                                    <th style="text-align: right;">Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% if (users !=null) { for (User u : users) { if
                                                                    (u.getRole()==User.Role.CANDIDATE) { %>
                                                                    <%@ include
                                                                        file="/WEB-INF/views/admin/fragments/user_row.jspf"
                                                                        %>
                                                                        <% } } } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                            <!-- Companies Section -->
                                            <div id="section-companies" class="admin-section" style="display: none;">
                                                <div class="admin-card">
                                                    <div class="admin-card-header">
                                                        <div>
                                                            <h2 class="admin-title">Company Management</h2>
                                                            <p
                                                                style="margin: 0.2rem 0 0; font-size: 0.85rem; color: #64748b;">
                                                                Manage recruiters and offers</p>
                                                        </div>
                                                    </div>
                                                    <div class="admin-table-container">
                                                        <table class="admin-table">
                                                            <thead>
                                                                <tr>
                                                                    <th width="80">ID</th>
                                                                    <th>Company Details</th>
                                                                    <th>Status</th>
                                                                    <th style="text-align: right;">Actions</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% if (users !=null) { for (User u : users) { if
                                                                    (u.getRole()==User.Role.COMPANY) { %>
                                                                    <%@ include
                                                                        file="/WEB-INF/views/admin/fragments/user_row.jspf"
                                                                        %>
                                                                        <% } } } %>
                                                            </tbody>
                                                        </table>
                                                    </div>
                                                </div>
                                            </div>

                                            <script>
                                                function switchTab(tabName) {
                                                    // Hide all sections
                                                    document.getElementById('section-all').style.display = 'none';
                                                    document.getElementById('section-candidates').style.display = 'none';
                                                    document.getElementById('section-companies').style.display = 'none';

                                                    // Remove active class from tabs
                                                    document.querySelectorAll('.admin-tab').forEach(t => t.classList.remove('active'));

                                                    // Show selected section
                                                    document.getElementById('section-' + tabName).style.display = 'block';

                                                    // Add active class to clicked tab
                                                    event.currentTarget.classList.add('active');
                                                }
                                            </script>
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