package com.recruitment.controller;

import com.recruitment.dao.UserDAO;
import com.recruitment.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/*")
public class AdminServlet extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        List<User> users = userDAO.findAll();
        req.setAttribute("users", users);
        req.getRequestDispatcher("/admin/dashboard.jsp").forward(req, resp);
    }
}
