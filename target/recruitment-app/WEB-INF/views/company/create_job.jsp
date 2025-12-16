<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Post Job - RecruttAnty</title>
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
                    <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                </ul>
            </nav>
        </header>

        <main class="container" style="padding: 3rem 2rem;">
            <div class="auth-card"
                style="max-width: 700px; margin: 0 auto; box-shadow: 0 10px 40px -10px rgba(0,0,0,0.1); border: 1px solid #e2e8f0;">
                <div class="auth-header"
                    style="text-align: left; border-bottom: 1px solid #f1f5f9; padding-bottom: 2rem; margin-bottom: 2rem;">
                    <h2 style="font-size: 1.8rem;">Post a New Opportunity</h2>
                    <p style="font-size: 1rem;">Share your open role with thousands of qualified talents.</p>
                </div>

                <form action="${pageContext.request.contextPath}/company/create-job" method="post">
                    <div class="form-group">
                        <label style="color: #334155; font-weight: 600;">Job Title</label>
                        <input type="text" name="title" required placeholder="e.g. Senior Java Engineer"
                            style="padding: 1rem 1.25rem;">
                    </div>

                    <div class="form-group">
                        <label style="color: #334155; font-weight: 600;">Description</label>
                        <textarea name="description" rows="8" required
                            placeholder="Describe the role responsibilities, requirements, and benefits..."
                            style="width: 100%; padding: 1rem 1.25rem; border-radius: 12px; border: 1px solid #e2e8f0; font-family: inherit; font-size: 1rem; background: #fcfcfc; line-height: 1.6;"></textarea>
                    </div>

                    <div style="display: grid; grid-template-columns: 2fr 1fr; gap: 1.5rem;">
                        <div class="form-group">
                            <label style="color: #334155; font-weight: 600;">Required Skills <span
                                    style="font-weight: 400; color: #94a3b8; font-size: 0.85rem;">(Comma
                                    separated)</span></label>
                            <input type="text" name="requiredSkills" required
                                placeholder="e.g. Java, Spring Boot, MySQL" style="padding: 1rem 1.25rem;">
                        </div>

                        <div class="form-group">
                            <label style="color: #334155; font-weight: 600;">Annual Salary ($)</label>
                            <input type="number" name="salary" step="1000" placeholder="e.g. 120000"
                                style="padding: 1rem 1.25rem;">
                        </div>
                    </div>

                    <div
                        style="display: flex; gap: 1rem; margin-top: 2.5rem; padding-top: 1.5rem; border-top: 1px solid #f1f5f9;">
                        <a href="${pageContext.request.contextPath}/company/dashboard" class="btn btn-secondary"
                            style="padding: 0.8rem 1.5rem; border-radius: 12px; font-weight: 600; color: #475569;">Cancel</a>
                        <button type="submit" class="btn btn-primary"
                            style="flex: 1; border-radius: 12px; font-weight: 600; padding: 0.8rem;">🚀 Publish Job
                            Offer</button>
                    </div>
                </form>
            </div>
        </main>
    </body>

    </html>