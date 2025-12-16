<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html lang="en">

    <head>
        <meta charset="UTF-8">
        <title>Account Pending Approval - RecruttAnty</title>
        <style>
            body {
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
                background-color: #f4f7f6;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                margin: 0;
            }

            .container {
                background-color: white;
                padding: 40px;
                border-radius: 8px;
                box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                text-align: center;
                max-width: 500px;
                width: 100%;
            }

            h1 {
                color: #2c3e50;
                margin-bottom: 20px;
            }

            p {
                color: #7f8c8d;
                line-height: 1.6;
                margin-bottom: 30px;
            }

            .icon {
                font-size: 64px;
                color: #f39c12;
                /* Orange for pending */
                margin-bottom: 20px;
            }

            a {
                color: #3498db;
                text-decoration: none;
                font-weight: bold;
            }

            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>

    <body>

        <div class="container">
            <div class="icon">⏳</div>
            <h1>Account Pending Approval</h1>
            <p>
                Thank you for registering with RecruttAnty. Your account is currently under review by our
                administrators.
                <br><br>
                You will receive an email notification once your account has been approved and activated.
            </p>
            <a href="${pageContext.request.contextPath}/auth/logout">Return to Home</a>
        </div>

    </body>

    </html>