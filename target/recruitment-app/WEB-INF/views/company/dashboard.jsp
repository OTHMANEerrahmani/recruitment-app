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

                <main class="container" style="padding: 3rem 2rem;">
                    <div class="dashboard-header">
                        <h2>Your Job Listings</h2>
                    </div>

                    <div class="jobs-grid">
                        <% List<JobOffer> offers = (List<JobOffer>) request.getAttribute("offers");
                                if (offers != null && !offers.isEmpty()) {
                                for (JobOffer offer : offers) {
                                %>
                                <div class="job-card">
                                    <div
                                        style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 1rem;">
                                        <h3 class="job-title" style="margin-bottom: 0;">
                                            <%= offer.getTitle() %>
                                        </h3>
                                        <div class="company-logo-small">J</div>
                                    </div>

                                    <div class="job-meta">
                                        <% if (offer.getSalary() !=null) { %>
                                            <span class="job-salary">$<%= String.format("%,.0f", offer.getSalary()) %>
                                            </span>
                                            <% } %>
                                                <span style="display: inline-flex; align-items: center; gap: 0.4rem;">
                                                    <span
                                                        style="width: 6px; height: 6px; background: #cbd5e1; border-radius: 50%;"></span>
                                                    <span style="color: #64748b; font-size: 0.85rem;">
                                                        <%= offer.getRequiredSkills() %>
                                                    </span>
                                                </span>
                                    </div>

                                    <p class="job-description"
                                        style="color: #475569; margin-bottom: 2rem; font-size: 0.95rem; line-height: 1.6;">
                                        <%= offer.getDescription() !=null && offer.getDescription().length()> 120
                                            ? offer.getDescription().substring(0, 120) + "..."
                                            : offer.getDescription() %>
                                    </p>

                                    <div style="margin-top: auto;">
                                        <a href="${pageContext.request.contextPath}/company/applications?jobOfferId=<%= offer.getId() %>"
                                            class="btn btn-secondary btn-block"
                                            style="justify-content: center; border-radius: 12px; font-weight: 600; padding: 0.8rem;">
                                            View Applications
                                        </a>
                                    </div>
                                </div>
                                <% } } else { %>
                                    <div
                                        style="grid-column: 1 / -1; text-align: center; padding: 6rem 2rem; background: white; border-radius: 20px; border: 2px dashed #e2e8f0;">
                                        <span
                                            style="font-size: 3.5rem; display: block; margin-bottom: 1.5rem; opacity: 0.8;">📝</span>
                                        <h3 style="margin-bottom: 0.75rem; color: #1e293b; font-size: 1.5rem;">No active
                                            job listings</h3>
                                        <p
                                            style="color: #64748b; margin-bottom: 2rem; max-width: 400px; margin-left: auto; margin-right: auto;">
                                            Post your first job offer to reach thousands of qualified candidates.
                                        </p>
                                        <a href="${pageContext.request.contextPath}/company/create-job"
                                            class="btn btn-primary">Create Job Offer</a>
                                    </div>
                                    <% } %>
                    </div>
                </main>
            </body>

            </html>