package com.recruitment.controller;

import com.recruitment.service.UserService;
import com.recruitment.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        // --- AUTH CHECK DISABLED FOR TESTING ---
        if (user == null || user.getRole() != User.Role.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        if (path == null || path.equals("/")) {
            path = "/dashboard";
        }

        switch (path) {
            case "/dashboard":
                try {
                    List<User> users = userService.findAll();
                    req.setAttribute("users", users);
                } catch (Exception e) {
                    e.printStackTrace();
                    req.setAttribute("errorMessage", "Error loading users: " + e.getMessage());
                }
                req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
                break;
            case "/edit-user":
                handleEditUser(req, resp);
                break;
            case "/delete-user":
                handleDeleteUser(req, resp);
                break;
            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleEditUser(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Long id = Long.parseLong(idStr);
                Optional<User> userToEdit = userService.findById(id);
                if (userToEdit.isPresent()) {
                    req.setAttribute("userToEdit", userToEdit.get());
                    req.getRequestDispatcher("/WEB-INF/views/admin/edit_user.jsp").forward(req, resp);
                    return;
                }
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }

    private void handleDeleteUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr != null) {
            try {
                Long id = Long.parseLong(idStr);
                userService.deleteUser(id);
                req.getSession().setAttribute("message", "User deleted successfully.");
                req.getSession().setAttribute("messageType", "success");
            } catch (Exception e) {
                e.printStackTrace();
                req.getSession().setAttribute("message", "Error deleting user: " + e.getMessage());
                req.getSession().setAttribute("messageType", "error");
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String path = req.getPathInfo();
        if ("/update-user".equals(path)) {
            handleUpdateUser(req, resp);
        } else {
            resp.sendError(HttpServletResponse.SC_NOT_FOUND);
        }
    }

    private void handleUpdateUser(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        String roleStr = req.getParameter("role");
        String action = req.getParameter("action"); // "activate", "deactivate", "save"

        if (idStr != null) {
            try {
                Long id = Long.parseLong(idStr);
                Optional<User> userOpt = userService.findById(id);

                if (userOpt.isPresent()) {
                    User userToUpdate = userOpt.get();

                    if (roleStr != null) {
                        try {
                            userToUpdate.setRole(User.Role.valueOf(roleStr));
                        } catch (IllegalArgumentException e) {
                            // Invalid role
                        }
                    }

                    if ("activate".equals(action)) {
                        userToUpdate.setActive(true);
                    } else if ("deactivate".equals(action)) {
                        userToUpdate.setActive(false);
                    }

                    userService.updateUser(userToUpdate);

                    // Trigger Notification
                    if ("activate".equals(action) || "deactivate".equals(action)) {
                        com.recruitment.service.NotificationService notificationService = new com.recruitment.service.NotificationService();
                        String statusMsg = userToUpdate.isActive() ? "activated" : "deactivated";
                        notificationService.createNotification(userToUpdate,
                                "Your account has been " + statusMsg + " by the administrator.",
                                com.recruitment.entity.Notification.NotificationType.SYSTEM);
                    }
                }
            } catch (NumberFormatException e) {
                // Ignore
            }
        }
        resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
    }
}
