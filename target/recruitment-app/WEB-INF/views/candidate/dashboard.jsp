<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.JobOffer" %>
            <%@ page import="com.recruitment.entity.Candidate" %>
                <%@ page import="com.recruitment.entity.Application" %>
                    <%@ page import="com.recruitment.entity.Notification" %>
                        <%@ page import="com.recruitment.service.JobService" %>
                            <!DOCTYPE html>
                            <html>

                            <head>
                                <title>Candidate Dashboard - RecruttAnty</title>
                                <link rel="stylesheet"
                                    href="${pageContext.request.contextPath}/assets/css/dashboard.css">
                                <link rel="preconnect" href="https://fonts.googleapis.com">
                                <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                                <link
                                    href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                                    rel="stylesheet">
                            </head>

                            <body>

                                <!-- SIDEBAR -->
                                <aside class="sidebar">
                                    <a href="#" class="brand">
                                        <div class="brand-icon">R</div>
                                        RECRUITANTY
                                    </a>

                                    <ul class="nav-menu">
                                        <li class="nav-item active" onclick="switchTab('overview')">
                                            <span>📊</span> Overview
                                        </li>
                                        <li class="nav-item" onclick="switchTab('applications')">
                                            <span>📁</span> My Applications
                                        </li>
                                        <li class="nav-item" onclick="switchTab('jobs')">
                                            <span>💼</span> Available Jobs
                                        </li>
                                        <a href="${pageContext.request.contextPath}/messages"
                                            style="text-decoration: none;">
                                            <li class="nav-item">
                                                <span>💬</span> Messages
                                            </li>
                                        </a>
                                    </ul>

                                    <div class="user-profile">
                                        <div class="avatar">
                                            <% Candidate cProfile=(Candidate) request.getAttribute("candidate"); String
                                                initial="U" ; if(cProfile !=null && cProfile.getFirstName() !=null &&
                                                !cProfile.getFirstName().isEmpty()){
                                                initial=cProfile.getFirstName().substring(0, 1); } %>
                                                <%= initial %>
                                        </div>
                                        <div>
                                            <div style="font-weight: 600; font-size: 0.9rem;">
                                                <%= (cProfile !=null) ? cProfile.getFirstName() + " " +
                                                    cProfile.getLastName() : "User" %>
                                            </div>
                                            <div style="font-size: 0.8rem; color: #64748b;">Candidate</div>
                                        </div>
                                        <a href="${pageContext.request.contextPath}/auth/logout"
                                            style="margin-left: auto; text-decoration: none; color: #ef4444;">
                                            🛑
                                        </a>
                                    </div>
                                </aside>

                                <!-- MAIN CONTENT -->
                                <main class="main-content">

                                    <!-- Top Bar -->
                                    <div class="top-bar">
                                        <h1 class="page-title" id="pageTitle">Dashboard Overview</h1>
                                        <a href="${pageContext.request.contextPath}/candidate/profile"
                                            class="btn btn-secondary">
                                            👤 My Profile
                                        </a>
                                    </div>

                                    <!-- Success Message -->
                                    <% String success=request.getParameter("success"); if ("applied".equals(success)) {
                                        %>
                                        <div
                                            style="background-color: #ecfdf5; color: #065f46; padding: 1rem; border-radius: 12px; margin-bottom: 2rem; border: 1px solid #a7f3d0; display: flex; align-items: center; gap: 0.5rem;">
                                            <span>✅</span> Application submitted successfully! Good luck.
                                        </div>
                                        <% } %>


                                            <!-- TAB: OVERVIEW -->
                                            <div id="tab-overview" class="tab-content active">

                                                <div class="stats-grid">
                                                    <% List<Application> myAppsCount = (List<Application>)
                                                            request.getAttribute("myApplications");
                                                            int appCount = (myAppsCount != null) ? myAppsCount.size() :
                                                            0;

                                                            List<Notification> notifList = (List<Notification>)
                                                                    request.getAttribute("notifications");
                                                                    int notifCount = 0;
                                                                    if(notifList != null) {
                                                                    for(Notification n : notifList) {
                                                                    if(!n.isRead()) notifCount++;
                                                                    }
                                                                    }
                                                                    %>
                                                                    <div class="stat-card">
                                                                        <div class="stat-label">Total Applications</div>
                                                                        <div class="stat-value">
                                                                            <%= appCount %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="stat-card">
                                                                        <div class="stat-label">Unread Notifications
                                                                        </div>
                                                                        <div class="stat-value">
                                                                            <%= notifCount %>
                                                                        </div>
                                                                    </div>
                                                                    <div class="stat-card">
                                                                        <div class="stat-label">Profile Status</div>
                                                                        <div class="stat-value"
                                                                            style="font-size: 1.2rem; margin-top: 1rem;">
                                                                            <%= (cProfile !=null && cProfile.getSkills()
                                                                                !=null &&
                                                                                !cProfile.getSkills().isEmpty())
                                                                                ? "✅ Complete" : "⚠️ Incomplete" %>
                                                                        </div>
                                                                    </div>
                                                </div>

                                                <div class="dashboard-header">
                                                    <h3>🔔 Recent Notifications</h3>
                                                </div>

                                                <% if (notifList !=null && !notifList.isEmpty()) { %>
                                                    <div style="display: flex; flex-direction: column; gap: 0.75rem;">
                                                        <% for (Notification n : notifList) { String bgColor=n.isRead()
                                                            ? "#ffffff" : "#f0f9ff" ; String borderColor=n.isRead()
                                                            ? "#e2e8f0" : "#bae6fd" ; String borderLeft=n.isRead()
                                                            ? "#cbd5e1" : "#0ea5e9" ; String fw=n.isRead() ? "400"
                                                            : "600" ; %>
                                                            <div
                                                                style="background: <%= bgColor %>; border: 1px solid <%= borderColor %>; border-left: 4px solid <%= borderLeft %>; padding: 1rem; border-radius: 8px; display: flex; justify-content: space-between; align-items: center;">
                                                                <div>
                                                                    <p
                                                                        style="margin: 0; color: #1e293b; font-weight: <%= fw %>;">
                                                                        <%= n.getMessage() %>
                                                                    </p>
                                                                    <span style="font-size: 0.8rem; color: #94a3b8;">
                                                                        <%= n.getCreatedAt().toLocalDate() %>
                                                                    </span>
                                                                </div>
                                                                <% if (!n.isRead()) { %>
                                                                    <span
                                                                        style="font-size: 0.8rem; background: #0ea5e9; color: white; padding: 2px 6px; border-radius: 4px;">NEW</span>
                                                                    <% } %>
                                                            </div>
                                                            <% } %>
                                                    </div>
                                                    <% } else { %>
                                                        <div style="color: #64748b; font-style: italic;">No new
                                                            notifications.</div>
                                                        <% } %>

                                            </div>


                                            <!-- TAB: MY APPLICATIONS -->
                                            <div id="tab-applications" class="tab-content">
                                                <div class="table-card">
                                                    <% if (myAppsCount !=null && !myAppsCount.isEmpty()) { %>
                                                        <table class="styled-table">
                                                            <thead>
                                                                <tr>
                                                                    <th>Job Title</th>
                                                                    <th>Company</th>
                                                                    <th>Date</th>
                                                                    <th>Status</th>
                                                                    <th>Action</th>
                                                                </tr>
                                                            </thead>
                                                            <tbody>
                                                                <% for (Application app : myAppsCount) { %>
                                                                    <tr>
                                                                        <td style="font-weight: 600;">
                                                                            <%= app.getJobOffer().getTitle() %>
                                                                        </td>
                                                                        <td>
                                                                            <%= app.getJobOffer().getCompany().getCompanyName()
                                                                                %>
                                                                        </td>
                                                                        <td style="color: #64748b;">
                                                                            <%= app.getApplicationDate().toLocalDate()
                                                                                %>
                                                                        </td>
                                                                        <td>
                                                                            <span
                                                                                class="status-pill status-<%= app.getStatus() %>">
                                                                                <%= app.getStatus() %>
                                                                            </span>
                                                                        </td>
                                                                        <td>
                                                                            <% if
                                                                                (app.getStatus()==Application.ApplicationStatus.ACCEPTED)
                                                                                { %>
                                                                                <a href="${pageContext.request.contextPath}/messages?jobId=<%= app.getJobOffer().getId() %>"
                                                                                    class="btn btn-primary"
                                                                                    style="padding: 0.3rem 0.6rem; font-size: 0.8rem;">
                                                                                    💬 Message
                                                                                </a>
                                                                                <% } else { %>
                                                                                    <span
                                                                                        style="color: #cbd5e1;">—</span>
                                                                                    <% } %>
                                                                        </td>
                                                                    </tr>
                                                                    <% } %>
                                                            </tbody>
                                                        </table>
                                                        <% } else { %>
                                                            <div
                                                                style="text-align: center; padding: 3rem; color: #94a3b8;">
                                                                You haven't applied to any jobs yet.
                                                            </div>
                                                            <% } %>
                                                </div>
                                            </div>


                                            <!-- TAB: AVAILABLE JOBS -->
                                            <div id="tab-jobs" class="tab-content">
                                                <div class="jobs-grid">
                                                    <% List<JobOffer> offers = (List<JobOffer>)
                                                            request.getAttribute("offers");
                                                            JobService jobService = (JobService)
                                                            request.getAttribute("jobService");

                                                            if (offers != null && !offers.isEmpty()) {
                                                            for (JobOffer offer : offers) {
                                                            // Safe Logic for Match Score
                                                            int score = 0;
                                                            if (cProfile != null && jobService != null &&
                                                            cProfile.getSkills() != null && offer.getRequiredSkills() !=
                                                            null) {
                                                            try {
                                                            score = jobService.calculateMatchScore(cProfile.getSkills(),
                                                            offer.getRequiredSkills());
                                                            } catch (Exception e) { score = 0; }
                                                            }

                                                            // Safe Logic for Company Name
                                                            String companyName = "Unknown";
                                                            String firstLetter = "C";
                                                            if (offer.getCompany() != null) {
                                                            companyName = offer.getCompany().getCompanyName();
                                                            if(companyName.length() > 0) firstLetter =
                                                            companyName.substring(0, 1);
                                                            }
                                                            %>
                                                            <div class="job-card">
                                                                <div class="job-header">
                                                                    <div class="company-logo-small">
                                                                        <%= firstLetter %>
                                                                    </div>
                                                                    <% if (offer.getSalary() !=null &&
                                                                        offer.getSalary()> 0) { %>
                                                                        <span class="status-pill status-PENDING"
                                                                            style="color: #1e293b; background: #f1f5f9;">
                                                                            $<%= String.format("%.0f",
                                                                                offer.getSalary()) %>
                                                                        </span>
                                                                        <% } %>
                                                                </div>

                                                                <h3 class="job-title">
                                                                    <%= offer.getTitle() %>
                                                                </h3>
                                                                <div class="company-name">🏢 <%= companyName %>
                                                                </div>

                                                                <p
                                                                    style="font-size: 0.9rem; color: #475569; margin-bottom: 1rem; line-height: 1.5; flex: 1;">
                                                                    <%= offer.getDescription() %>
                                                                </p>

                                                                <div
                                                                    style="display: flex; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 1rem;">
                                                                    <% if (offer.getRequiredSkills() !=null) { for
                                                                        (String skill :
                                                                        offer.getRequiredSkills().split(",")) { if
                                                                        (skill.trim().length()> 0) {
                                                                        %>
                                                                        <span
                                                                            style="background: #eff6ff; color: #2563eb; padding: 2px 8px; border-radius: 4px; font-size: 0.75rem;">
                                                                            <%= skill.trim() %>
                                                                        </span>
                                                                        <% } } } %>
                                                                </div>

                                                                <div class="job-footer">
                                                                    <% if (score> 0) { %>
                                                                        <span
                                                                            style="color: #059669; font-weight: 600; font-size: 0.9rem;">
                                                                            ⚡ <%= score %>% Match
                                                                        </span>
                                                                        <% } else { %>
                                                                            <span></span>
                                                                            <% } %>

                                                                                <form
                                                                                    action="${pageContext.request.contextPath}/candidate/apply"
                                                                                    method="post" style="margin: 0;">
                                                                                    <input type="hidden" name="jobId"
                                                                                        value="<%= offer.getId() %>">
                                                                                    <button type="submit"
                                                                                        class="btn btn-primary">Apply
                                                                                        Now</button>
                                                                                </form>
                                                                </div>
                                                            </div>
                                                            <% } } else { %>
                                                                <div
                                                                    style="grid-column: 1/-1; text-align: center; padding: 3rem; background: white; border-radius: 12px;">
                                                                    <h3>No jobs available right now.</h3>
                                                                </div>
                                                                <% } %>
                                                </div>
                                            </div>

                                </main>

                                <!-- JavaScript for Tabs -->
                                <script>
                                    function switchTab(tabId) {
                                        // Remove active class from all tabs
                                        document.querySelectorAll('.tab-content').forEach(tab => {
                                            tab.classList.remove('active');
                                        });
                                        document.querySelectorAll('.nav-item').forEach(item => {
                                            item.classList.remove('active');
                                        });

                                        // Add active class to selected tab
                                        document.getElementById('tab-' + tabId).classList.add('active');

                                        // Highlight nav item (simple implementation based on text content matching would require IDs, 
                                        // so we'll just set it on the element passed via onclick in a real app, 
                                        // but here we can just use the click event target or simpler approach below).

                                        // Updating Title
                                        const titles = {
                                            'overview': 'Dashboard Overview',
                                            'applications': 'My Applications',
                                            'jobs': 'Available Opportunities'
                                        };
                                        document.getElementById('pageTitle').innerText = titles[tabId];

                                        // Since we don't have unique IDs on nav items in the JSP loop easily without extra code,
                                        // we will just use a simple DOM query match for this demo.
                                        const navItems = document.querySelectorAll('.nav-item');
                                        if (tabId === 'overview') navItems[0].classList.add('active');
                                        if (tabId === 'applications') navItems[1].classList.add('active');
                                        if (tabId === 'jobs') navItems[2].classList.add('active');
                                    }
                                </script>
                            </body>

                            </html>