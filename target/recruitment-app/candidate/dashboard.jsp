<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.JobOffer" %>
            <%@ page import="com.recruitment.entity.Candidate" %>
                <%@ page import="com.recruitment.service.JobService" %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Candidate Dashboard - RecruttAnty</title>
                        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
                    </head>

                    <body>
                        <header>
                            <div class="container">
                                <nav>
                                    <a href="#" class="logo">RecruttAnty</a>
                                    <ul>
                                        <li><a href="${pageContext.request.contextPath}/candidate/profile">My
                                                Profile</a></li>
                                        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                                    </ul>
                                </nav>
                            </div>
                        </header>

                        <div class="container">
                            <% String success=request.getParameter("success"); if ("applied".equals(success)) { %>
                                <div class="card" style="background-color: #dff0d8; color: #3c763d;">
                                    Successfully applied to job!
                                </div>
                                <% } %>

                                    <h2>Available Jobs</h2>
                                    <% List<JobOffer> offers = (List<JobOffer>) request.getAttribute("offers");
                                            Candidate candidate = (Candidate) request.getAttribute("candidate");
                                            JobService jobService = (JobService) request.getAttribute("jobService");

                                            if (offers != null) {
                                            for (JobOffer offer : offers) {
                                            int score = 0;
                                            if (candidate != null && jobService != null) {
                                            score = jobService.calculateMatchScore(candidate.getSkills(),
                                            offer.getRequiredSkills());
                                            }
                                            %>
                                            <div class="card job-offer">
                                                <h3>
                                                    <%= offer.getTitle() %>
                                                </h3>
                                                <p><strong>Company:</strong>
                                                    <%= offer.getCompany().getCompanyName() %>
                                                </p>
                                                <p>
                                                    <%= offer.getDescription() %>
                                                </p>
                                                <p><strong>Salary:</strong> $<%= offer.getSalary() %>
                                                </p>
                                                <p><strong>Required Skills:</strong>
                                                    <%= offer.getRequiredSkills() %>
                                                </p>
                                                <p class="match-score">Match Score: <%= score %>%</p>

                                                <form action="${pageContext.request.contextPath}/candidate/apply"
                                                    method="post">
                                                    <input type="hidden" name="jobId" value="<%= offer.getId() %>">
                                                    <button type="submit" class="btn">Apply Now</button>
                                                </form>
                                            </div>
                                            <% } } else { %>
                                                <p>No job offers available.</p>
                                                <% } %>
                        </div>
                    </body>

                    </html>