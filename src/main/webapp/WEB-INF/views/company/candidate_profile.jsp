<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.recruitment.entity.Candidate" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Candidate Profile - RecruttAnty</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
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
                        <li style="display: flex; align-items: center; gap: 1rem;">
                            <a href="${pageContext.request.contextPath}/company/create-job" class="btn-primary"
                                style="padding: 0.5rem 1rem; font-size: 0.9rem;">+ Post Job</a>
                        </li>
                        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                    </ul>
                </nav>
            </header>

            <main class="container" style="padding: 3rem 0; max-width: 900px;">
                <div style="margin-bottom: 2rem;">
                    <a href="javascript:history.back()"
                        style="display: inline-flex; align-items: center; gap: 0.5rem; color: #64748b; text-decoration: none; font-weight: 500; font-size: 0.95rem;">
                        ← Back to Applications
                    </a>
                </div>

                <% Candidate candidate=(Candidate) request.getAttribute("candidate"); %>

                    <div class="recruiter-job-card" style="padding: 2.5rem;">
                        <div
                            style="display: flex; gap: 1.5rem; align-items: flex-start; margin-bottom: 2rem; padding-bottom: 2rem; border-bottom: 1px solid #f1f5f9;">
                            <div class="candidate-avatar" style="width: 80px; height: 80px; font-size: 2rem;">
                                <%= candidate.getFirstName().substring(0, 1) %>
                                    <%= candidate.getLastName().substring(0, 1) %>
                            </div>
                            <div>
                                <h1
                                    style="font-size: 1.75rem; color: #0f172a; margin-bottom: 0.5rem; line-height: 1.2;">
                                    <%= candidate.getFirstName() %>
                                        <%= candidate.getLastName() %>
                                </h1>
                                <div
                                    style="display: flex; align-items: center; gap: 1.5rem; color: #64748b; font-size: 0.95rem;">
                                    <span style="display: flex; align-items: center; gap: 0.5rem;">
                                        ✉️ <%= candidate.getEmail() %>
                                    </span>
                                </div>
                            </div>
                        </div>

                        <div style="display: grid; gap: 2rem;">
                            <div>
                                <h3
                                    style="font-size: 1rem; font-weight: 700; color: #0f172a; margin-bottom: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em;">
                                    Skills</h3>
                                <div
                                    style="font-size: 1rem; color: #334155; line-height: 1.7; background: #f8fafc; padding: 1rem; border-radius: 8px; border: 1px solid #e2e8f0;">
                                    <%= candidate.getSkills() !=null && !candidate.getSkills().isEmpty() ?
                                        candidate.getSkills()
                                        : "<em style='color: #94a3b8;'>No skills listed by candidate.</em>" %>
                                </div>
                            </div>

                            <div>
                                <h3
                                    style="font-size: 1rem; font-weight: 700; color: #0f172a; margin-bottom: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em;">
                                    Resume / CV</h3>
                                <% if (candidate.getResumeUrl() !=null && !candidate.getResumeUrl().isEmpty()) { %>
                                    <a href="<%= candidate.getResumeUrl() %>" target="_blank"
                                        class="btn-recruit-primary" style="display: inline-flex;">
                                        📄 View Resume / CV
                                    </a>
                                    <div style="margin-top: 0.5rem; font-size: 0.85rem; color: #64748b;">
                                        Opens in a new tab
                                    </div>
                                    <% } else { %>
                                        <div
                                            style="padding: 1rem; background: #fef2f2; color: #991b1b; border: 1px solid #fee2e2; border-radius: 8px; display: inline-block;">
                                            Reference file not available
                                        </div>
                                        <% } %>
                            </div>
                        </div>
                    </div>
            </main>
        </body>

        </html>