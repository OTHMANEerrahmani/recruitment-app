<%@ page contentType="text/html;charset=UTF-8" language="java" %>
    <%@ page import="java.util.List" %>
        <%@ page import="com.recruitment.entity.Message" %>
            <%@ page import="com.recruitment.entity.User" %>
                <%@ page import="com.recruitment.entity.JobOffer" %>
                    <%@ page import="com.recruitment.entity.Candidate" %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Messages - RecruttAnty</title>
                            <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/css/landing.css">
                            <link rel="preconnect" href="https://fonts.googleapis.com">
                            <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
                            <link
                                href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;500;600;700;800&display=swap"
                                rel="stylesheet">
                            <style>
                                .chat-container {
                                    display: flex;
                                    flex-direction: column;
                                    height: 60vh;
                                    background: #f8fafc;
                                    border-radius: 12px;
                                    padding: 1.5rem;
                                    overflow-y: auto;
                                    border: 1px solid #e2e8f0;
                                    margin-bottom: 1.5rem;
                                }

                                .message-bubble {
                                    max-width: 70%;
                                    padding: 0.8rem 1.2rem;
                                    border-radius: 12px;
                                    margin-bottom: 0.8rem;
                                    line-height: 1.5;
                                    position: relative;
                                }

                                .message-mine {
                                    background-color: #3b82f6;
                                    color: white;
                                    align-self: flex-end;
                                    border-bottom-right-radius: 2px;
                                }

                                .message-theirs {
                                    background-color: white;
                                    color: #1e293b;
                                    align-self: flex-start;
                                    border-bottom-left-radius: 2px;
                                    border: 1px solid #e2e8f0;
                                }

                                .message-time {
                                    font-size: 0.7rem;
                                    opacity: 0.8;
                                    margin-top: 0.25rem;
                                    display: block;
                                    text-align: right;
                                }
                            </style>
                        </head>

                        <body>
                            <header>
                                <nav class="container">
                                    <a href="#" class="logo">
                                        <div class="logo-icon">R</div>
                                        RECRUITANTY
                                    </a>
                                    <ul class="nav-links">
                                        <% User user=(User) session.getAttribute("user"); String dashboardLink=(user
                                            !=null && user.getRole()==User.Role.COMPANY) ? request.getContextPath()
                                            + "/company/dashboard" : request.getContextPath() + "/candidate/dashboard" ;
                                            %>
                                            <li><a href="<%= dashboardLink %>">Dashboard</a></li>
                                            <li><a href="${pageContext.request.contextPath}/auth/logout">Logout</a></li>
                                    </ul>
                                </nav>
                            </header>

                            <main class="container" style="padding: 3rem 2rem;">
                                <% JobOffer job=(JobOffer) request.getAttribute("jobOffer"); Candidate
                                    candidate=(Candidate) request.getAttribute("candidateTarget"); List<Message>
                                    messages = (List<Message>) request.getAttribute("messages");
                                        %>

                                        <div class="dashboard-header">
                                            <div>
                                                <a href="<%= dashboardLink %>"
                                                    style="font-size: 0.9rem; margin-bottom: 0.5rem; display: inline-block; color: #64748b; text-decoration: none;">←
                                                    Back to Dashboard</a>
                                                <h2>Conversation: <span style="color: var(--primary-color);">
                                                        <%= job.getTitle() %>
                                                    </span></h2>
                                                <p style="color: #64748b;">
                                                    With: <%= (user.getRole()==User.Role.COMPANY) ?
                                                        candidate.getFirstName() + " " + candidate.getLastName() :
                                                        job.getCompany().getCompanyName() %>
                                                </p>
                                            </div>
                                        </div>

                                        <div class="chat-container" id="chatBox">
                                            <% if (messages !=null && !messages.isEmpty()) { for (Message m : messages)
                                                { boolean isMine=(m.getSenderRole()==user.getRole()); %>
                                                <div class="message-bubble <%= isMine ? " message-mine"
                                                    : "message-theirs" %>">
                                                    <%= m.getContent() %>
                                                        <span class="message-time">
                                                            <%= m.getSentAt().toLocalTime().toString().substring(0, 5)
                                                                %>
                                                        </span>
                                                </div>
                                                <% } } else { %>
                                                    <div style="text-align: center; color: #94a3b8; margin-top: 2rem;">
                                                        <p>No messages yet. Start the conversation!</p>
                                                    </div>
                                                    <% } %>
                                        </div>

                                        <form action="${pageContext.request.contextPath}/messages" method="post"
                                            style="display: flex; gap: 1rem;">
                                            <input type="hidden" name="jobId" value="<%= job.getId() %>">
                                            <% if (user.getRole()==User.Role.COMPANY) { %>
                                                <input type="hidden" name="candidateId"
                                                    value="<%= candidate.getId() %>">
                                                <% } %>

                                                    <input type="text" name="content" placeholder="Type your message..."
                                                        required
                                                        style="flex: 1; padding: 1rem; border: 1px solid #cbd5e1; border-radius: 8px; font-family: inherit;">
                                                    <button type="submit" class="btn btn-primary"
                                                        style="padding: 0 2rem;">Send ➤</button>
                                        </form>

                                        <script>
                                            // Scroll to bottom of chat
                                            var chatBox = document.getElementById("chatBox");
                                            chatBox.scrollTop = chatBox.scrollHeight;
                                        </script>
                            </main>
                        </body>

                        </html>