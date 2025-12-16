<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.Candidate" %>
            <%@ page import="com.recruitment.entity.Application" %>
                <%@ page import="java.time.format.DateTimeFormatter" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Candidate Profile - RecruttAnty Admin</title>
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
                                <span style="color: #1a1a1a; font-weight: 500;">Candidate Profile</span>
                            </div>

                            <% Candidate candidate=(Candidate) request.getAttribute("candidate"); %>

                                <!-- Profile Details Card -->
                                <div class="admin-card">
                                    <div class="admin-card-header">
                                        <h2 class="admin-title">Candidate Details</h2>
                                    </div>
                                    <div style="padding: 2rem;">
                                        <div
                                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(250px, 1fr)); gap: 2rem;">
                                            <div>
                                                <label
                                                    style="display: block; font-size: 0.85rem; font-weight: 600; color: #64748b; margin-bottom: 0.5rem;">Full
                                                    Name</label>
                                                <div style="font-size: 1.1rem; color: #1a1a1a; font-weight: 500;">
                                                    <%= candidate !=null ? candidate.getFirstName() + " " +
                                                        candidate.getLastName() : "-" %>
                                                </div>
                                            </div>
                                            <div>
                                                <label
                                                    style="display: block; font-size: 0.85rem; font-weight: 600; color: #64748b; margin-bottom: 0.5rem;">Email</label>
                                                <div style="font-size: 1.1rem; color: #1a1a1a; font-weight: 500;">
                                                    <%= candidate !=null ? candidate.getEmail() : "-" %>
                                                </div>
                                            </div>
                                            <div style="grid-column: 1 / -1;">
                                                <label
                                                    style="display: block; font-size: 0.85rem; font-weight: 600; color: #64748b; margin-bottom: 0.5rem;">Skills</label>
                                                <div style="font-size: 1rem; color: #334155; line-height: 1.6;">
                                                    <%= candidate !=null && candidate.getSkills() !=null ?
                                                        candidate.getSkills() : "No skills listed" %>
                                                </div>
                                            </div>
                                            <div style="grid-column: 1 / -1;">
                                                <label
                                                    style="display: block; font-size: 0.85rem; font-weight: 600; color: #64748b; margin-bottom: 0.5rem;">Resume
                                                    Link</label>
                                                <% if (candidate !=null && candidate.getResumeUrl() !=null &&
                                                    !candidate.getResumeUrl().isEmpty()) { %>
                                                    <a href="<%= candidate.getResumeUrl() %>" target="_blank"
                                                        style="color: #2563eb; text-decoration: none; font-weight: 500;">
                                                        <%= candidate.getResumeUrl() %>
                                                    </a>
                                                    <% } else { %>
                                                        <span style="color: #94a3b8;">No resume provided</span>
                                                        <% } %>
                                            </div>
                                        </div>
                                    </div>
                                </div>

                                <!-- Application History Card -->
                                <div class="admin-card">
                                    <div class="admin-card-header">
                                        <h2 class="admin-title">Application History</h2>
                                    </div>
                                    <div class="admin-table-container">
                                        <table class="admin-table">
                                            <thead>
                                                <tr>
                                                    <th>Job Title</th>
                                                    <th>Company</th>
                                                    <th>Applied Date</th>
                                                    <th>Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% @SuppressWarnings("unchecked") List<Application> applications = (List
                                                    <Application>) request.getAttribute("applications");
                                                        if (applications != null && !applications.isEmpty()) {
                                                        for (Application app : applications) {
                                                        %>
                                                        <tr>
                                                            <td style="font-weight: 600; color: #1a1a1a;">
                                                                <%= app.getJobOffer().getTitle() %>
                                                            </td>
                                                            <td style="color: #475569;">
                                                                <%= app.getJobOffer().getCompany().getCompanyName() %>
                                                            </td>
                                                            <td style="color: #64748b;">
                                                                <!-- Simple date formatting if available, else standard toString -->
                                                                <%= app.getApplicationDate() !=null ?
                                                                    app.getApplicationDate().toString().replace("T", " "
                                                                    ).substring(0, 16) : "-" %>
                                                            </td>
                                                            <td>
                                                                <% String badgeClass="badge-pending" ; if
                                                                    (app.getStatus()==Application.ApplicationStatus.ACCEPTED)
                                                                    { badgeClass="badge-accepted" ; } else if
                                                                    (app.getStatus()==Application.ApplicationStatus.REJECTED)
                                                                    { badgeClass="badge-rejected" ; } %>
                                                                    <span class="badge <%= badgeClass %>">
                                                                        <%= app.getStatus() %>
                                                                    </span>
                                                            </td>
                                                        </tr>
                                                        <% } } else { %>
                                                            <tr>
                                                                <td colspan="4"
                                                                    style="text-align: center; padding: 3rem; color: #94a3b8;">
                                                                    No applications found for this candidate.
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                        </main>
                    </body>

                    </html>