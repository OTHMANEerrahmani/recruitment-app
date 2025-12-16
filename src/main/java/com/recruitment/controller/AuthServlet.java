package com.recruitment.controller;

import com.recruitment.entity.User;
import com.recruitment.service.AuthService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Optional;

@WebServlet("/auth/*")
public class AuthServlet extends HttpServlet {

    private AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();

        if ("/login".equals(path)) {
            handleLogin(req, resp);
        } else if ("/register".equals(path)) {
            handleRegister(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getPathInfo();
        if ("/logout".equals(path)) {
            req.getSession().invalidate();
            resp.sendRedirect(req.getContextPath() + "/index.jsp");
        } else {
            // Forward to login page or register page
            if ("/login".equals(path)) {
                req.getRequestDispatcher("/login.jsp").forward(req, resp);
            } else if ("/register".equals(path)) {
                req.getRequestDispatcher("/register.jsp").forward(req, resp);
            }
        }
    }

    private void handleLogin(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        Optional<User> userOpt = authService.login(email, password);

        if (userOpt.isPresent()) {
            User user = userOpt.get();
            System.out.println("DEBUG: Login successful for " + email + " Role: " + user.getRole() + " Status: "
                    + user.getStatus());

            if (user.getStatus() != User.Status.ACTIVE) {
                System.out.println("DEBUG: User not active. Redirecting to pending approval.");
                // Do not create a persistent session for unapproved users, or maybe just
                // temporary?
                // For now, no session attribute "user", so they are effectively not logged in.
                resp.sendRedirect(req.getContextPath() + "/pending_approval.jsp");
                return;
            }

            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            String redirectPath;
            if (user.getRole() == User.Role.ADMIN) {
                redirectPath = "/admin/dashboard";
            } else if (user.getRole() == User.Role.COMPANY) {
                redirectPath = "/company/dashboard";
            } else {
                redirectPath = "/candidate/dashboard";
            }

            System.out.println("DEBUG: Redirecting to " + req.getContextPath() + redirectPath);
            resp.sendRedirect(req.getContextPath() + redirectPath);
        } else {
            System.out.println("DEBUG: Login failed for " + email);
            req.setAttribute("error", "Invalid credentials");
            req.getRequestDispatcher("/login.jsp").forward(req, resp);
        }
    }

    private void handleRegister(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        String type = req.getParameter("type");
        String email = req.getParameter("email");
        String password = req.getParameter("password");

        boolean success = false;
        if ("candidate".equals(type)) {
            String firstName = req.getParameter("firstName");
            String lastName = req.getParameter("lastName");
            success = authService.registerCandidate(email, password, firstName, lastName);
        } else if ("company".equals(type)) {
            String companyName = req.getParameter("companyName");
            String address = req.getParameter("address");
            success = authService.registerCompany(email, password, companyName, address);
        }

        if (success) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
        } else {
            req.setAttribute("error", "Registration failed (Email might match existing)");
            req.getRequestDispatcher("/register.jsp").forward(req, resp);
        }
    }
}
