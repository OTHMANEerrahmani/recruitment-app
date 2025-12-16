<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Create Account - RecruttAnty</title>
        <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
            rel="stylesheet">
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
            <nav class="container">
                <a href="${pageContext.request.contextPath}/" class="logo">
                    <div class="logo-icon">R</div>
                    RECRUITANTY
                </a>
                <ul class="nav-links">
                    <li><a href="${pageContext.request.contextPath}/auth/login" style="color: #1a1a1a;">Sign In</a></li>
                </ul>
            </nav>
        </header>

        <div class="auth-wrapper">
            <div class="auth-card">
                <div class="auth-header">
                    <h2>Create Account</h2>
                    <p>Join RecruttAnty to find your path</p>
                </div>

                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert-danger">
                        <span>⚠️</span>
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                        <form action="${pageContext.request.contextPath}/auth/register" method="post">
                            <div class="form-group">
                                <label>I want to join as a:</label>
                                <select name="type" id="userType" onchange="toggleForm()">
                                    <option value="candidate">Candidate (Looking for jobs)</option>
                                    <option value="company">Company (Hiring)</option>
                                </select>
                            </div>

                            <div class="form-group">
                                <label>Email Address</label>
                                <input type="email" name="email" required placeholder="name@company.com">
                            </div>

                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" required placeholder="Create a strong password">
                            </div>

                            <div id="candidateFields">
                                <div class="form-grid">
                                    <div class="form-group">
                                        <label>First Name</label>
                                        <input type="text" name="firstName" placeholder="John">
                                    </div>
                                    <div class="form-group">
                                        <label>Last Name</label>
                                        <input type="text" name="lastName" placeholder="Doe">
                                    </div>
                                </div>
                            </div>

                            <div id="companyFields" style="display: none;">
                                <div class="form-group">
                                    <label>Company Name</label>
                                    <input type="text" name="companyName" placeholder="Acme Inc.">
                                </div>
                                <div class="form-group">
                                    <label>Address</label>
                                    <input type="text" name="address" placeholder="123 Business Rd">
                                </div>
                            </div>

                            <button type="submit" class="btn btn-primary btn-block">Create Account</button>
                        </form>

                        <div class="auth-footer">
                            Already have an account? <a href="${pageContext.request.contextPath}/auth/login">Log In</a>
                        </div>
            </div>
        </div>
        </div>
        </div>
        </div>
    </body>

    </html>