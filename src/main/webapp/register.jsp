<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Register - RecruttAnty</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
        <script>
            function toggleForm() {
                const type = document.getElementById('userType').value;
                document.getElementById('candidateFields').style.display = type === 'candidate' ? 'block' : 'none';
                document.getElementById('companyFields').style.display = type === 'company' ? 'block' : 'none';
            }
            window.onload = function () {
                const urlParams = new URLSearchParams(window.location.search);
                const type = urlParams.get('type') || 'candidate';
                document.getElementById('userType').value = type;
                toggleForm();
            }
        </script>
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
                <h2 style="text-align: center;">Register</h2>
                <% if (request.getAttribute("error") !=null) { %>
                    <div style="color: red; text-align: center;">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                        <form action="${pageContext.request.contextPath}/auth/register" method="post">
                            <label>I am a:</label>
                            <select name="type" id="userType" onchange="toggleForm()">
                                <option value="candidate">Candidate</option>
                                <option value="company">Company</option>
                            </select>

                            <label>Email</label>
                            <input type="email" name="email" required>

                            <label>Password</label>
                            <input type="password" name="password" required>

                            <div id="candidateFields">
                                <label>First Name</label>
                                <input type="text" name="firstName">

                                <label>Last Name</label>
                                <input type="text" name="lastName">
                            </div>

                            <div id="companyFields" style="display: none;">
                                <label>Company Name</label>
                                <input type="text" name="companyName">

                                <label>Address</label>
                                <input type="text" name="address">
                            </div>

                            <button type="submit" class="btn">Register</button>
                        </form>
                        <p style="text-align: center;">Already have an account? <a
                                href="${pageContext.request.contextPath}/auth/login">Login</a></p>
            </div>
        </div>
    </body>

    </html>