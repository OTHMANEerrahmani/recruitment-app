<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="com.recruitment.entity.Candidate" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>My Profile - RecruttAnty</title>
            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        </head>

        <body>
            <header>
                <div class="container">
                    <nav>
                        <a href="${pageContext.request.contextPath}/candidate/dashboard" class="logo">RecruttAnty</a>
                        <ul>
                            <li><a href="${pageContext.request.contextPath}/candidate/dashboard">Dashboard</a></li>
                            <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                        </ul>
                    </nav>
                </div>
            </header>

            <div class="container">
                <div class="card">
                    <h2>Edit Profile</h2>
                    <% Candidate candidate=(Candidate) request.getAttribute("candidate"); %>
                        <form action="${pageContext.request.contextPath}/candidate/profile" method="post">
                            <label>First Name</label>
                            <input type="text" name="firstName"
                                value="<%= candidate.getFirstName() != null ? candidate.getFirstName() : "" %>">

                            <label>Last Name</label>
                            <input type="text" name="lastName"
                                value="<%= candidate.getLastName() != null ? candidate.getLastName() : "" %>">

                            <label>Skills (comma separated)</label>
                            <input type="text" name="skills"
                                value="<%= candidate.getSkills() != null ? candidate.getSkills() : "" %>"
                                placeholder="Java, SQL, Docker">

                            <label>Resume URL</label>
                            <input type="text" name="resumeUrl"
                                value="<%= candidate.getResumeUrl() != null ? candidate.getResumeUrl() : "" %>">

                            <button type="submit" class="btn">Update Profile</button>
                        </form>
                </div>
            </div>
        </body>

        </html>