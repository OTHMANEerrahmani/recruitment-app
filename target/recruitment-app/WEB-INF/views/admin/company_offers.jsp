<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.JobOffer" %>
            <%@ page import="com.recruitment.entity.User" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Offers - RecruttAnty Admin</title>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
                    <link rel="preconnect" href="https://fonts.googleapis.com">
                    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                    <link
                        href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
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
                                <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                            </ul>
                        </nav>
                    </header>

                    <main class="admin-container">

                        <div class="breadcrumb" style="margin-bottom: 1.5rem; color: #64748b; font-size: 0.9rem;">
                            <a href="${pageContext.request.contextPath}/admin/dashboard"
                                style="color: #64748b; text-decoration: none;">Dashboard</a>
                            <span style="margin: 0 0.5rem;">/</span>
                            <span style="color: #1a1a1a; font-weight: 500;">Company Offers</span>
                        </div>

                        <!-- Success Message Alert -->
                        <% String msg=(String) session.getAttribute("message"); String msgType=(String)
                            session.getAttribute("messageType"); if (msg !=null) { String bgColor="success"
                            .equals(msgType) ? "#ecfdf5" : "#fef2f2" ; String color="success" .equals(msgType)
                            ? "#059669" : "#dc2626" ; String borderColor="success" .equals(msgType) ? "#d1fae5"
                            : "#fee2e2" ; %>
                            <div
                                style="background-color: <%= bgColor %>; color: <%= color %>; border: 1px solid <%= borderColor %>; padding: 1rem; border-radius: 8px; margin-bottom: 2rem; display: flex; align-items: center; gap: 0.8rem; font-weight: 500; font-size: 0.95rem;">
                                <% if ("success".equals(msgType)) { %>
                                    <svg width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor"
                                        stroke-width="2">
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

                                <div class="admin-card">
                                    <div class="admin-card-header">
                                        <div>
                                            <% User company=(User) request.getAttribute("company"); %>
                                                <h2 class="admin-title">Job Offers for <%= company !=null ?
                                                        company.getEmail() : "Company" %>
                                                </h2>
                                                <p style="margin: 0.2rem 0 0; font-size: 0.85rem; color: #64748b;">
                                                    Read-only view of posted jobs</p>
                                        </div>
                                    </div>

                                    <div class="admin-table-container">
                                        <table class="admin-table">
                                            <thead>
                                                <tr>
                                                    <th>Title</th>
                                                    <th>Description</th>
                                                    <th>Salary</th>
                                                    <th>Status</th>
                                                    <th style="text-align: right;">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% @SuppressWarnings("unchecked") List<JobOffer> offers = (List
                                                    <JobOffer>) request.getAttribute("offers");
                                                        if (offers != null && !offers.isEmpty()) {
                                                        for (JobOffer offer : offers) {
                                                        %>
                                                        <tr>
                                                            <td style="font-weight: 600; color: #1a1a1a;">
                                                                <%= offer.getTitle() %>
                                                            </td>
                                                            <td style="max-width: 300px; color: #475569;">
                                                                <%= offer.getDescription().length()> 80 ?
                                                                    offer.getDescription().substring(0, 80) + "..." :
                                                                    offer.getDescription() %>
                                                            </td>
                                                            <td>
                                                                <%= offer.getSalary() %>
                                                            </td>
                                                            <td>
                                                                <% if (offer.isActive()) { %>
                                                                    <span
                                                                        class="badge badge-status-active">Active</span>
                                                                    <% } else { %>
                                                                        <span
                                                                            class="badge badge-status-inactive">Inactive</span>
                                                                        <% } %>
                                                            </td>
                                                            <td style="text-align: right;">
                                                                <div class="actions-cell">
                                                                    <button type="button"
                                                                        onclick="showDeleteModal(<%= offer.getId() %>, '<%= offer.getTitle().replace("'", "\\'") %>', <%= company != null ? company.getId() : "''" %>)"
                                                                        class="action-btn btn-delete"
                                                                        data-tooltip="Delete Offer">
                                                                        <svg width="16" height="16" viewBox="0 0 24 24"
                                                                            fill="none" stroke="currentColor"
                                                                            stroke-width="2" stroke-linecap="round"
                                                                            stroke-linejoin="round">
                                                                            <polyline points="3 6 5 6 21 6"></polyline>
                                                                            <path
                                                                                d="M19 6v14a2 2 0 0 1-2 2H7a2 2 0 0 1-2-2V6m3 0V4a2 2 0 0 1 2-2h4a2 2 0 0 1 2 2v2">
                                                                            </path>
                                                                            <line x1="10" y1="11" x2="10" y2="17">
                                                                            </line>
                                                                            <line x1="14" y1="11" x2="14" y2="17">
                                                                            </line>
                                                                        </svg>
                                                                    </button>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <% } } else { %>
                                                            <tr>
                                                                <td colspan="5"
                                                                    style="text-align: center; padding: 3rem; color: #94a3b8;">
                                                                    No job offers found for this company.
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
                                <h3 class="modal-title">Delete Job Offer</h3>
                                <p class="modal-desc">
                                    Are you sure you want to delete <strong id="deleteOfferTitle"></strong>?<br>
                                    <span style="color: #dc2626; font-size: 0.85rem;">
                                        Warning: This will delete all applications, messages, and notifications linked
                                        to this offer.
                                        Deletion is only possible if at least one candidate has been accepted.
                                    </span>
                                </p>

                                <form id="deleteForm" action="${pageContext.request.contextPath}/admin/delete-offer"
                                    method="post">
                                    <input type="hidden" name="id" id="deleteOfferId">
                                    <input type="hidden" name="companyId" id="deleteCompanyId">
                                    <div class="modal-actions">
                                        <button type="button" onclick="closeDeleteModal()"
                                            class="btn-modal btn-cancel">Cancel</button>
                                        <button type="submit" class="btn-modal btn-danger">Delete Offer</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>

                    <script>
                        function showDeleteModal(offerId, offerTitle, companyId) {
                            const modal = document.getElementById('deleteModal');
                            if (modal) {
                                document.getElementById('deleteOfferTitle').textContent = offerTitle;
                                document.getElementById('deleteOfferId').value = offerId;
                                document.getElementById('deleteCompanyId').value = companyId;
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