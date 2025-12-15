<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.Application" %>
            <%@ page import="com.recruitment.entity.JobOffer" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Applications - RecruttAnty</title>
                    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
                </head>

                <body>
                    <header>
                        <div class="container">
                            <nav>
                                <a href="${pageContext.request.contextPath}/" class="logo">RecruttAnty</a>
                                <ul>
                                    <li><a href="${pageContext.request.contextPath}/company/dashboard">Dashboard</a>
                                    </li>
                                    <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                                </ul>
                            </nav>
                        </div>
                    </header>

                    <div class="container">
                        <% JobOffer offer=(JobOffer) request.getAttribute("jobOffer"); List<Application> applications =
                            (List<Application>) request.getAttribute("applications");
                                %>

                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 20px;">
                                    <h2>Applications for: <%= offer !=null ? offer.getTitle() : "Unknown Job" %>
                                    </h2>
                                    <a href="${pageContext.request.contextPath}/company/dashboard" class="btn">Back to
                                        Dashboard</a>
                                </div>

                                <% if (applications !=null && !applications.isEmpty()) { %>
                                    <div class="card">
                                        <table style="width: 100%; border-collapse: collapse;">
                                            <thead>
                                                <tr style="text-align: left; border-bottom: 1px solid #eee;">
                                                    <th style="padding: 10px;">Candidate</th>
                                                    <th style="padding: 10px;">Email</th>
                                                    <th style="padding: 10px;">Date</th>
                                                    <th style="padding: 10px;">Status</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Application app : applications) { %>
                                                    <tr style="border-bottom: 1px solid #f9f9f9;">
                                                        <td style="padding: 10px;">
                                                            <%= app.getCandidate().getFirstName() %>
                                                                <%= app.getCandidate().getLastName() %>
                                                        </td>
                                                        <td style="padding: 10px;">
                                                            <%= app.getCandidate().getEmail() %>
                                                        </td>
                                                        <td style="padding: 10px;">
                                                            <%= app.getApplicationDate() %>
                                                        </td>
                                                        <td style="padding: 10px;">
                                                            <%= app.getStatus() %>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                    <% } else { %>
                                        <div class="card">
                                            <p>No applications received for this job offer yet.</p>
                                        </div>
                                        <% } %>
                    </div>
                </body>

                </html>