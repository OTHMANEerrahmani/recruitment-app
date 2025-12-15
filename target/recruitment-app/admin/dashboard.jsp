<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.User" %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin Dashboard - RecruttAnty</title>
                <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/style.css">
            </head>

            <body>
                <header>
                    <div class="container">
                        <nav>
                            <a href="#" class="logo">RecruttAnty Admin</a>
                            <ul>
                                <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                            </ul>
                        </nav>
                    </div>
                </header>

                <div class="container">
                    <h2>Registered Users</h2>
                    <div class="card">
                        <table>
                            <thead>
                                <tr>
                                    <th>ID</th>
                                    <th>Email</th>
                                    <th>Role</th>
                                    <th>Actions</th>
                                </tr>
                            </thead>
                            <tbody>
                                <% List<User> users = (List<User>) request.getAttribute("users");
                                        if (users != null) {
                                        for (User u : users) {
                                        %>
                                        <tr>
                                            <td>
                                                <%= u.getId() %>
                                            </td>
                                            <td>
                                                <%= u.getEmail() %>
                                            </td>
                                            <td>
                                                <%= u.getRole() %>
                                            </td>
                                            <td>
                                                <!-- Add delete/edit buttons if needed -->
                                                <button class="btn"
                                                    style="padding: 5px 10px; background-color: #e74c3c;">Remove</button>
                                            </td>
                                        </tr>
                                        <% } } %>
                            </tbody>
                        </table>
                    </div>
                </div>
            </body>

            </html>