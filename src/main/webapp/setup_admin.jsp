<%@ page import="com.recruitment.util.JPAUtil" %>
    <%@ page import="com.recruitment.entity.User" %>
        <%@ page import="com.recruitment.entity.Admin" %>
            <%@ page import="com.recruitment.entity.Candidate" %>
                <%@ page import="jakarta.persistence.EntityManager" %>
                    <%@ page import="java.util.List" %>
                        <%@ page contentType="text/html;charset=UTF-8" language="java" %>
                            <% EntityManager em=JPAUtil.getEntityManager(); String message="" ; try { try {
                                em.getTransaction().begin(); // FIX SCHEMA: Manually create admins table if Hibernate
                                didn't (Safe check) // We catch the exception in case the user doesn't have CREATE
                                permissions, but they likely do. try { em.createNativeQuery("CREATE TABLE IF NOT EXISTS
                                admins (" + "id BIGINT NOT NULL, " + "PRIMARY KEY (id), "
                                + "CONSTRAINT fk_admins_users FOREIGN KEY (id) REFERENCES users (id) ON DELETE CASCADE"
                                + ")" ).executeUpdate(); } catch (Exception ex) { // Ignore if table exists or
                                permission issue (Hibernate might have done it) System.out.println("Notice: Table
                                creation attempt: " + ex.getMessage());
        }
        
        // CLEANUP: Delete any existing user with this email to prevent conflicts
        em.createNativeQuery(" DELETE FROM users WHERE email='admin@recruitment.com'").executeUpdate();
        
        // Create proper Admin entity
        Admin admin = new Admin();
                                        .card {
                                            background: #f9f9f9;
                                            padding: 2rem;
                                            border-radius: 10px;
                                            display: inline-block;
                                            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
                                        }

                                        h1 {
                                            color: #333;
                                        }

                                        b {
                                            color: #2563eb;
                                        }
                                    </style>
                                </head>

                                <body>
                                    <div class=" card">
                                <h1>Admin Setup</h1>
                                <p>
                                    <%= message %>
                                </p>
                                </div>
                                </body>

                                </html>