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

                    <main class="container" style="padding: 3rem 2rem;">
                        <% JobOffer offer=(JobOffer) request.getAttribute("jobOffer"); List<Application> applications =
                            (List<Application>) request.getAttribute("applications");
                                %>

                                <div class="dashboard-header">
                                    <div>
                                        <a href="${pageContext.request.contextPath}/company/dashboard"
                                            style="font-size: 0.9rem; margin-bottom: 0.5rem; display: inline-block; color: #64748b; text-decoration: none;">←
                                            Back to Dashboard</a>
                                        <h2>Applications for: <span style="color: var(--primary-color);">
                                                <%= offer !=null ? offer.getTitle() : "Unknown Job" %>
                                            </span></h2>
                                    </div>
                                </div>

                                <div class="table-container">
                                    <% if (applications !=null && !applications.isEmpty()) { %>
                                        <table class="styled-table">
                                            <thead>
                                                <tr>
                                                    <th width="30%">Candidate</th>
                                                    <th width="25%">Email</th>
                                                    <th width="15%">Applied On</th>
                                                    <th width="15%">Resume</th>
                                                    <th width="15%" style="text-align: right;">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Application app : applications) { String
                                                    resumeUrl=app.getCandidate().getResumeUrl(); %>
                                                    <tr>
                                                        <td>
                                                            <div
                                                                style="display: flex; align-items: center; gap: 0.75rem;">
                                                                <div
                                                                    style="width: 36px; height: 36px; background: #e0e7ff; color: #4338ca; border-radius: 50%; display: flex; align-items: center; justify-content: center; font-weight: 600; font-size: 0.9rem;">
                                                                    <%= app.getCandidate().getFirstName().substring(0,
                                                                        1) %>
                                                                        <%= app.getCandidate().getLastName().substring(0,
                                                                            1) %>
                                                                </div>
                                                                <div>
                                                                    <div style="font-weight: 600; color: #1e293b;">
                                                                        <%= app.getCandidate().getFirstName() %>
                                                                            <%= app.getCandidate().getLastName() %>
                                                                    </div>
                                                                </div>
                                                            </div>
                                                        </td>
                                                        <td style="color: #64748b;">
                                                            <%= app.getCandidate().getEmail() %>
                                                        </td>
                                                        <td style="color: #64748b;">
                                                            <%= app.getApplicationDate().toLocalDate() %>
                                                        </td>
                                                        <td>
                                                            <% if (resumeUrl !=null && !resumeUrl.isEmpty()) { %>
                                                                <a href="<%= resumeUrl %>" target="_blank"
                                                                    style="color: #2563eb; text-decoration: none; font-weight: 500; font-size: 0.9rem; display: inline-flex; align-items: center; gap: 0.25rem;">
                                                                    <span>📄 View Resume</span>
                                                                </a>
                                                                <% } else { %>
                                                                    <span style="color: #94a3b8; font-size: 0.9rem;">No
                                                                        resume</span>
                                                                    <% } %>
                                                        </td>
                                                        <td style="text-align: right;">
                                                            <% if (app.getStatus() !=null && "PENDING"
                                                                .equals(app.getStatus().name())) { %>
                                                                <div
                                                                    style="display: flex; gap: 0.5rem; justify-content: flex-end;">
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
                                                                            class="status-pill status-accepted"
                                                                            style="border: 1px solid #84e1bc; cursor: pointer; padding: 0.3rem 0.6rem;">Accept</button>
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
                                                                        <button type="submit" <button type="submit"
                                                                            class="status-pill status-rejected"
                                                                            style="border: 1px solid #f8b4b4; cursor: pointer; padding: 0.3rem 0.6rem;">Reject</button>
                                                                    </form>
                                                                </div>
                                                                <% } else { %>
                                                                    <span
                                                                        class="status-pill status-<%= app.getStatus() %>">
                                                                        <%= app.getStatus() %>
                                                                    </span>
                                                                    <% if ("ACCEPTED".equals(app.getStatus().name())) {
                                                                        %>
                                                                        <a href="${pageContext.request.contextPath}/messages?jobId=<%= offer.getId() %>&candidateId=<%= app.getCandidate().getId() %>"
                                                                            style="margin-left: 0.5rem; text-decoration: none; font-size: 1.1rem;"
                                                                            title="Message Candidate">💬</a>
                                                                        <% } %>
                                                                            <% } %>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                        <% } else { %>
                                            <div style="padding: 6rem; text-align: center; background: white;">
                                                <div
                                                    style="width: 80px; height: 80px; background: #f1f5f9; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2rem;">
                                                    📫
                                                </div>
                                                <h3 style="margin-bottom: 0.5rem; color: #1e293b;">No applications yet
                                                </h3>
                                                <p style="color: #64748b;">When candidates apply to this position, they
                                                    will appear here.</p>
                                            </div>
                                            <% } %>
                                </div>
                    </main>
                </body>

                </html>