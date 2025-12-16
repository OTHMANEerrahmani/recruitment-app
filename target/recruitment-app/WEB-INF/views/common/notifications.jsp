<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.recruitment.entity.Notification" %>
        <%@ page import="java.util.List" %>
            <%@ page import="java.time.format.DateTimeFormatter" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Notifications - RecruttAnty</title>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
                    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700&display=swap"
                        rel="stylesheet">
                </head>

                <body>
                    <header>
                        <nav class="container">
                            <a href="${pageContext.request.contextPath}/" class="logo">
                                <div class="logo-icon">R</div>
                                RECRUITANTY
                            </a>
                            <ul class="nav-links">
                                <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                            </ul>
                        </nav>
                    </header>

                    <main class="container" style="padding: 3rem 2rem;">
                        <div class="auth-card" style="max-width: 800px; margin: 0 auto; padding: 0;">
                            <div
                                style="padding: 2rem; border-bottom: 1px solid #e2e8f0; display: flex; justify-content: space-between; align-items: center;">
                                <h2 style="margin: 0;">Notifications</h2>
                                <form action="${pageContext.request.contextPath}/notifications" method="post"
                                    style="margin: 0;">
                                    <button type="submit" class="btn btn-secondary"
                                        style="padding: 0.5rem 1rem; font-size: 0.9rem;">Mark all read</button>
                                </form>
                            </div>

                            <div class="notification-list">
                                <% List<Notification> notifications = (List<Notification>)
                                        request.getAttribute("notifications");
                                        if (notifications != null && !notifications.isEmpty()) {
                                        for (Notification n : notifications) {
                                        String bgStyle = n.isRead() ? "white" : "#f0fdf4";
                                        String dotStyle = n.isRead() ? "transparent" : "#059669";
                                        String weightStyle = n.isRead() ? "400" : "600";
                                        String formattedDate = n.getCreatedAt().format(DateTimeFormatter.ofPattern("MMM
                                        dd, HH:mm"));
                                        %>
                                        <div
                                            style="padding: 1.5rem 2rem; border-bottom: 1px solid #f1f5f9; background: <%= bgStyle %>; display: flex; gap: 1rem; align-items: flex-start;">
                                            <div
                                                style="width: 10px; height: 10px; border-radius: 50%; background: <%= dotStyle %>; margin-top: 6px;">
                                            </div>
                                            <div style="flex: 1;">
                                                <p
                                                    style="margin-bottom: 0.25rem; color: #1e293b; font-weight: <%= weightStyle %>;">
                                                    <%= n.getMessage() %>
                                                </p>
                                                <span style="font-size: 0.8rem; color: #94a3b8;">
                                                    <%= formattedDate %> • <%= n.getType() %>
                                                </span>
                                            </div>
                                        </div>
                                        <% } } else { %>
                                            <div style="padding: 4rem; text-align: center;">
                                                <span
                                                    style="font-size: 3rem; display: block; margin-bottom: 1rem; opacity: 0.5;">🔔</span>
                                                <p style="color: #64748b;">No notifications yet.</p>
                                            </div>
                                            <% } %>
                            </div>
                        </div>
                    </main>
                </body>

                </html>