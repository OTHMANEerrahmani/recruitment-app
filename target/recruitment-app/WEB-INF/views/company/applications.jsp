<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.Application" %>
            <%@ page import="com.recruitment.entity.JobOffer" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Applications - RecruttAnty</title>
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
                            <a href="${pageContext.request.contextPath}/company/dashboard" class="logo">
                                <div class="logo-icon">R</div>
                                RECRUITANTY
                            </a>
                            <ul class="nav-links">
                                <li><a href="${pageContext.request.contextPath}/company/dashboard">Dashboard</a></li>
                                <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                            </ul>
                        </nav>
                    </header>

                    <main class="container" style="padding: 3rem 0; max-width: 1200px;">
                        <% JobOffer offer=(JobOffer) request.getAttribute("jobOffer"); List<Application> applications =
                            (List<Application>) request.getAttribute("applications");
                                %>

                                <div class="dashboard-header"
                                    style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 2rem;">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/company/dashboard"
                                            style="font-size: 0.9rem; margin-bottom: 0.75rem; display: inline-flex; align-items: center; gap: 0.5rem; color: #64748b; text-decoration: none; font-weight: 500;">
                                            ← Back to Dashboard
                                        </a>
                                        <h2 style="font-size: 1.75rem; color: #0f172a; margin-bottom: 0.25rem;">
                                            Applications for <span style="color: #2563eb;">
                                                <%= offer !=null ? offer.getTitle() : "Unknown Job" %>
                                            </span>
                                        </h2>
                                        <p style="color: #64748b; font-size: 0.95rem;">Review and manage candidates for
                                            this position.</p>
                                    </div>
                                </div>

                                <div class="recruiter-table-wrapper">
                                    <% if (applications !=null && !applications.isEmpty()) { %>
                                        <table class="recruiter-table">
                                            <thead>
                                                <tr>
                                                    <th width="35%">Candidate</th>
                                                    <th width="25%">Contact</th>
                                                    <th width="15%">Applied On</th>
                                                    <th width="25%" style="text-align: right;">Actions & Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Application app : applications) { String
                                                    resumeUrl=app.getCandidate().getResumeUrl(); %>
                                                    <tr>
                                                        <td>
                                                            <div class="candidate-identity">
                                                                <div class="candidate-avatar">
                                                                    <%= app.getCandidate().getFirstName().substring(0,
                                                                        1) %>
                                                                        <%= app.getCandidate().getLastName().substring(0,
                                                                            1) %>
                                                                </div>
                                                                <div>
                                                                    <div
                                                                        style="font-weight: 600; color: #1e293b; font-size: 1rem;">
                                                                        <%= app.getCandidate().getFirstName() %>
                                                                            <%= app.getCandidate().getLastName() %>
                                                                    </div>
                                                                    <% if (resumeUrl !=null && !resumeUrl.isEmpty()) {
                                                                        %>
                                                                        <a href="<%= resumeUrl %>" target="_blank"
                                                                            style="font-size: 0.85rem; color: #2563eb; text-decoration: none; margin-top: 2px; display: inline-block;">
                                                                            View Resume ↗
                                                                        </a>
                                                                        <% } else { %>
                                                                            <span
                                                                                style="font-size: 0.85rem; color: #94a3b8;">No
                                                                                resume uploaded</span>
                                                                            <% } %>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td style="color: #475569; font-size: 0.95rem;">
                                                            <%= app.getCandidate().getEmail() %>
                                                        </td>
                                                        <td style="color: #64748b; font-size: 0.95rem;">
                                                            <%= app.getApplicationDate().toLocalDate() %>
                                                        </td>
                                                        <td style="text-align: right;">
                                                            <div class="status-actions">
                                                                <% if (app.getStatus() !=null && "PENDING"
                                                                    .equals(app.getStatus().name())) { %>
                                                                    <form
                                                                        action="${pageContext.request.contextPath}/company/update-application"
                                                                        method="post" style="margin: 0;">
                                                                        <input type="hidden" name="applicationId"
                                                                            value="<%= app.getId() %>">
                                                                        <input type="hidden" name="jobOfferId"
                                                                            value="<%= offer.getId() %>">
                                                                        <input type="hidden" name="status"
                                                                            value="ACCEPTED">
                                                                        <button type="submit"
                                                                            class="btn-action-icon btn-action-accept"
                                                                            title="Accept Candidate">
                                                                            <svg width="20" height="20"
                                                                                viewBox="0 0 24 24" fill="none"
                                                                                stroke="currentColor" stroke-width="2.5"
                                                                                stroke-linecap="round"
                                                                                stroke-linejoin="round">
                                                                                <polyline points="20 6 9 17 4 12">
                                                                                </polyline>
                                                                            </svg>
                                                                        </button>
                                                                    </form>
                                                                    <form
                                                                        action="${pageContext.request.contextPath}/company/update-application"
                                                                        method="post" style="margin: 0;">
                                                                        <input type="hidden" name="applicationId"
                                                                            value="<%= app.getId() %>">
                                                                        <input type="hidden" name="jobOfferId"
                                                                            value="<%= offer.getId() %>">
                                                                        <input type="hidden" name="status"
                                                                            value="REJECTED">
                                                                        <button type="submit"
                                                                            class="btn-action-icon btn-action-reject"
                                                                            title="Reject Candidate">
                                                                            <svg width="20" height="20"
                                                                                viewBox="0 0 24 24" fill="none"
                                                                                stroke="currentColor" stroke-width="2.5"
                                                                                stroke-linecap="round"
                                                                                stroke-linejoin="round">
                                                                                <line x1="18" y1="6" x2="6" y2="18">
                                                                                </line>
                                                                                <line x1="6" y1="6" x2="18" y2="18">
                                                                                </line>
                                                                            </svg>
                                                                        </button>
                                                                    </form>
                                                                    <% } else { %>
                                                                        <a href="${pageContext.request.contextPath}/company/candidate-profile?candidateId=<%= app.getCandidate().getId() %>"
                                                                            class="btn-action-icon"
                                                                            style="color: #64748b; margin-right: 0.5rem;"
                                                                            title="View Profile">
                                                                            <svg width="20" height="20"
                                                                                viewBox="0 0 24 24" fill="none"
                                                                                stroke="currentColor" stroke-width="2"
                                                                                stroke-linecap="round"
                                                                                stroke-linejoin="round">
                                                                                <path
                                                                                    d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z">
                                                                                </path>
                                                                                <circle cx="12" cy="12" r="3"></circle>
                                                                            </svg>
                                                                        </a>
                                                                        <span
                                                                            class="status-pill status-<%= app.getStatus() %>"
                                                                            style="padding: 0.35rem 0.75rem; font-size: 0.8rem;">
                                                                            <%= app.getStatus() %>
                                                                        </span>
                                                                        <% if
                                                                            ("ACCEPTED".equals(app.getStatus().name()))
                                                                            { %>
                                                                            <a href="${pageContext.request.contextPath}/messages?jobId=<%= offer.getId() %>&candidateId=<%= app.getCandidate().getId() %>"
                                                                                style="margin-left: 0.75rem; text-decoration: none; color: #3b82f6; display: flex; align-items: center; justify-content: center; width: 32px; height: 32px; background: #eff6ff; border-radius: 6px;"
                                                                                title="Message Candidate">
                                                                                <svg width="18" height="18"
                                                                                    viewBox="0 0 24 24" fill="none"
                                                                                    stroke="currentColor"
                                                                                    stroke-width="2"
                                                                                    stroke-linecap="round"
                                                                                    stroke-linejoin="round">
                                                                                    <path
                                                                                        d="M21 15a2 2 0 0 1-2 2H7l-4 4V5a2 2 0 0 1 2-2h14a2 2 0 0 1 2 2z">
                                                                                    </path>
                                                                                </svg>
                                                                            </a>
                                                                            <% } %>
                                                                                <% } %>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                        <% } else { %>
                                            <div style="padding: 6rem; text-align: center; background: white;">
                                                <div
                                                    style="width: 80px; height: 80px; background: #f8fafc; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2.5rem;">
                                                    📫
                                                </div>
                                                <h3 style="margin-bottom: 0.5rem; color: #1e293b; font-size: 1.25rem;">
                                                    No applications yet</h3>
                                                <p style="color: #64748b;">When candidates apply to this position, they
                                                    will appear here.</p>
                                            </div>
                                            <% } %>
                                </div>
                    </main>
                </body>

                </html>