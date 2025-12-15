<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.JobOffer" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Company Dashboard - RecruttAnty</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
            </head>

            <body>
                <header>
                    <div class="container">
                        <nav>
                            <a href="#" class="logo">RecruttAnty</a>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/company/create-job">Post New Job</a>
                                </li>
                                <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                            </ul>
                        </nav>
                    </div>
                </header>

                <div class="container">
                    <h2>My Job Offers</h2>
                    <a href="${pageContext.request.contextPath}/company/create-job" class="btn"
                        style="margin-bottom: 20px;">+ Post Job</a>

                    <% List<JobOffer> offers = (List<JobOffer>) request.getAttribute("offers");
                            if (offers != null && !offers.isEmpty()) {
                            for (JobOffer offer : offers) {
                            %>
                            <div class="card job-offer">
                                <h3>
                                    <%= offer.getTitle() %>
                                </h3>
                                <p>
                                    <%= offer.getDescription() %>
                                </p>
                                <p><strong>Skills:</strong>
                                    <%= offer.getRequiredSkills() %>
                                </p>
                                <p><strong>Salary:</strong> $<%= offer.getSalary() %>
                                </p>
                                <div style="margin-top: 15px;">
                                    <a href="${pageContext.request.contextPath}/company/applications?jobOfferId=<%= offer.getId() %>"
                                        class="btn" style="background-color: #555; font-size: 0.9em;">View
                                        Applications</a>
                                </div>
                            </div>
                            <% } } else { %>
                                <p>You haven't posted any jobs yet.</p>
                                <% } %>
                </div>
            </body>

            </html>