<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>RecruttAnty - Home</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
</head>
<body>
    <header>
        <div class="container">
            <nav>
                <a href="${pageContext.request.contextPath}/" class="logo">RecruttAnty</a>
                <ul>
                    <li><a href="${pageContext.request.contextPath}/auth/login">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/auth/register">Register</a></li>
                </ul>
            </nav>
        </div>
    </header>

    <div class="container">
        <div class="card" style="text-align: center; padding: 50px;">
            <h1>Welcome to RecruttAnty</h1>
            <p>The modern recruitment platform connecting talents with opportunities.</p>
            <div style="margin-top: 20px;">
                <a href="${pageContext.request.contextPath}/auth/register?type=candidate" class="btn">I am a Candidate</a>
                <a href="${pageContext.request.contextPath}/auth/register?type=company" class="btn" style="background-color: var(--secondary-color);">I am a Company</a>
            </div>
        </div>
    </div>
</body>
</html>
