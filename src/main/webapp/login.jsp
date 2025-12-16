<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Login - RecruttAnty</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
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
                    <li><a href="${pageContext.request.contextPath}/" style="color: #1a1a1a;">Back to Home</a></li>
                </ul>
            </nav>
        </header>

        <div class="auth-wrapper">
            <div class="auth-card">
                <div class="auth-header">
                    <h2>Welcome Back</h2>
                    <p>Enter your details to access your account</p>
                </div>

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert-danger">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                        <form action="${pageContext.request.contextPath}/auth/login" method="post">
                            <div class="form-group">
                                <label>Email Address</label>
                                <input type="email" name="email" required placeholder="name@company.com">
                            </div>

                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" required placeholder="••••••••">
                            </div>

                            <button type="submit" class="btn btn-primary btn-block">Sign In</button>
                        </form>

                        <div class="auth-footer">
                            Don't have an account? <a href="${pageContext.request.contextPath}/auth/register">Create
                                account</a>
                        </div>
            </div>
        </div>
    </body>

    </html>