<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Login - RecruttAnty</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
    </head>

    <body>
        <header>
            <div class="container">
                <nav>
                    <a href="${pageContext.request.contextPath}/" class="logo">RecruttAnty</a>
                </nav>
            </div>
        </header>

        <div class="container">
            <div class="card">
                <h2 style="text-align: center;">Login</h2>
                <% if (request.getAttribute("error") !=null) { %>
                    <div style="color: red; text-align: center;">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                        <form action="${pageContext.request.contextPath}/auth/login" method="post">
                            <label>Email</label>
                            <input type="email" name="email" required>

                            <label>Password</label>
                            <input type="password" name="password" required>

                            <button type="submit" class="btn">Login</button>
                        </form>
                        <p style="text-align: center;">New here? <a
                                href="${pageContext.request.contextPath}/auth/register">Register</a></p>
            </div>
        </div>
    </body>

    </html>