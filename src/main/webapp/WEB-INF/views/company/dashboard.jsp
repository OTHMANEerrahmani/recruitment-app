<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.JobOffer" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Company Dashboard - RecruttAnty</title>
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
                            <li><a href="${pageContext.request.contextPath}/notifications"
                                    style="font-size: 1.2rem; text-decoration: none;">🔔</a></li>
                            <li><a href="${pageContext.request.contextPath}/company/create-job" class="btn btn-primary"
                                    style="padding: 0.6rem 1.2rem;">+ Post New Job</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                        </ul>
                    </nav>
                </header>

                <main class="container" style="padding: 3rem 0; max-width: 1200px;">
                    <div class="dashboard-header"
                        style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 2rem;">
                        <div>
                            <h2 style="font-size: 1.75rem; color: #0f172a; margin-bottom: 0.5rem;">Job Listings</h2>
                            <p style="color: #64748b;">Manage your open positions and track candidates.</p>
                        </div>
                        <a href="${pageContext.request.contextPath}/company/create-job" class="btn-recruit-primary">
                            <span style="font-size: 1.2rem;">+</span> Post New Job
                        </a>
                    </div>

                    <div class="recruiter-grid">
                        <% List<JobOffer> offers = (List<JobOffer>) request.getAttribute("offers");
                                if (offers != null && !offers.isEmpty()) {
                                for (JobOffer offer : offers) {
                                %>
                                <div class="recruiter-job-card">
                                    <div class="recruiter-card-header">
                                        <div>
                                            <h3 class="recruiter-job-title">
                                                <%= offer.getTitle() %>
                                            </h3>
                                            <div style="font-size: 0.85rem; color: #94a3b8; font-weight: 500;">Posted
                                                recently</div>
                                        </div>
                                        <div
                                            style="width: 40px; height: 40px; background: #e0f2fe; color: #0284c7; border-radius: 8px; display: flex; align-items: center; justify-content: center; font-weight: 700;">
                                            J
                                        </div>
                                    </div>

                                    <div class="recruiter-job-meta">
                                        <% if (offer.getSalary() !=null) { %>
                                            <span class="recruiter-badge recruiter-badge-salary">
                                                $<%= String.format("%,.0f", offer.getSalary()) %> / yr
                                            </span>
                                            <% } %>
                                                <span class="recruiter-badge recruiter-badge-skill">
                                                    <%= offer.getRequiredSkills() %>
                                                </span>
                                    </div>

                                    <p class="recruiter-description">
                                        <%= offer.getDescription() !=null && offer.getDescription().length()> 140
                                            ? offer.getDescription().substring(0, 140) + "..."
                                            : offer.getDescription() %>
                                    </p>

                                    <div class="recruiter-card-footer">
                                        <div style="font-size: 0.85rem; color: #64748b; font-weight: 500;">
                                            <span
                                                style="display: inline-block; width: 8px; height: 8px; background: #22c55e; border-radius: 50%; margin-right: 6px;"></span>
                                            Active
                                        </div>
                                        <a href="${pageContext.request.contextPath}/company/applications?jobOfferId=<%= offer.getId() %>"
                                            style="color: #2563eb; font-weight: 600; font-size: 0.9rem; text-decoration: none; display: inline-flex; align-items: center; gap: 4px;">
                                            View Applications →
                                        </a>
                                    </div>
                                </div>
                                <% } } else { %>
                                    <div
                                        style="grid-column: 1 / -1; text-align: center; padding: 6rem 2rem; background: white; border-radius: 20px; border: 2px dashed #e2e8f0;">
                                        <div
                                            style="width: 80px; height: 80px; background: #f8fafc; border-radius: 50%; display: flex; align-items: center; justify-content: center; margin: 0 auto 1.5rem; font-size: 2.5rem;">
                                            📝
                                        </div>
                                        <h3 style="margin-bottom: 0.75rem; color: #1e293b; font-size: 1.5rem;">No active
                                            job listings</h3>
                                        <p
                                            style="color: #64748b; margin-bottom: 2rem; max-width: 400px; margin-left: auto; margin-right: auto;">
                                            Post your first job offer to reach thousands of qualified candidates.
                                        </p>
                                        <a href="${pageContext.request.contextPath}/company/create-job"
                                            class="btn-recruit-primary">Create Job Offer</a>
                                    </div>
                                    <% } %>
                    </div>
                </main>
            </body>

            </html>