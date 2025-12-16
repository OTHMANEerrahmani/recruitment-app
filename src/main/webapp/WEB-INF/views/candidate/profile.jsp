<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.recruitment.entity.Candidate" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>My Profile - RecruttAnty</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
            <link rel="preconnect" href="https://fonts.googleapis.com">
            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
            <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                rel="stylesheet">
        </head>

        <body>
            <header>
                <nav class="container">
                    <a href="${pageContext.request.contextPath}/candidate/dashboard" class="logo">
                        <div class="logo-icon">R</div>
                        RECRUITANTY
                    </a>
                    <ul class="nav-links">
                        <li><a href="${pageContext.request.contextPath}/candidate/dashboard">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                    </ul>
                </nav>
            </header>

            <main class="container" style="padding: 3rem 2rem;">
                <div class="auth-card"
                    style="max-width: 600px; margin: 0 auto; box-shadow: 0 4px 20px rgba(0,0,0,0.05);">
                    <div class="auth-header">
                        <h2>Edit Your Profile</h2>
                        <p>Keep your details up to date</p>
                    </div>

                    <% Candidate candidate=(Candidate) request.getAttribute("candidate"); %>
                        <form action="${pageContext.request.contextPath}/candidate/profile" method="post">
                            <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem;">
                                <div class="form-group">
                                    <label>First Name</label>
                                    <input type="text" name="firstName"
                                        value="<%= candidate != null && candidate.getFirstName() != null ? candidate.getFirstName() : "" %>">
                                </div>

                                <div class="form-group">
                                    <label>Last Name</label>
                                    <input type="text" name="lastName"
                                        value="<%= candidate != null && candidate.getLastName() != null ? candidate.getLastName() : "" %>">
                                </div>
                            </div>

                            <div class="form-group">
                                <label>Skills <span style="font-weight: normal; opacity: 0.6;">(Comma
                                        separated)</span></label>
                                <input type="text" name="skills"
                                    value="<%= candidate != null && candidate.getSkills() != null ? candidate.getSkills() : "" %>"
                                    placeholder="e.g. Java, SQL, Docker">
                                <p style="font-size: 0.85rem; color: #64748b; margin-top: 0.5rem;">These skills will be
                                    used to calculate your match score with job offers.</p>
                            </div>

                            <div class="form-group">
                                <label>Resume URL</label>
                                <input type="text" name="resumeUrl"
                                    value="<%= candidate != null && candidate.getResumeUrl() != null ? candidate.getResumeUrl() : "" %>"
                                    placeholder="https://linkedin.com/in/...">
                            </div>

                            <div style="display: flex; gap: 1rem; margin-top: 2rem;">
                                <a href="${pageContext.request.contextPath}/candidate/dashboard"
                                    class="btn btn-secondary" style="flex: 1; text-align: center;">Cancel</a>
                                <button type="submit" class="btn btn-primary" style="flex: 2;">Save Changes</button>
                            </div>
                        </form>
                </div>
            </main>
        </body>

        </html>