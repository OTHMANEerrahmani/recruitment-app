<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Post Job - RecruttAnty</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body>
        <header>
            <div class="container">
                <nav>
                    <a href="${pageContext.request.contextPath}/company/dashboard" class="logo">RecruttAnty</a>
                    <ul>
                        <li><a href="${pageContext.request.contextPath}/company/dashboard">Dashboard</a></li>
                        <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                    </ul>
                </nav>
            </div>
        </header>

        <div class="container">
            <div class="card">
                <h2>Post a Job Offer</h2>
                <form action="${pageContext.request.contextPath}/company/create-job" method="post">
                    <label>Job Title</label>
                    <input type="text" name="title" required>

                    <label>Description</label>
                    <textarea name="description" rows="5" required></textarea>

                    <label>Required Skills (comma separated)</label>
                    <input type="text" name="requiredSkills" required placeholder="Java, Spring, MySql">

                    <label>Salary</label>
                    <input type="number" name="salary" step="100">

                    <button type="submit" class="btn">Post Job</button>
                </form>
            </div>
        </div>
    </body>

    </html>