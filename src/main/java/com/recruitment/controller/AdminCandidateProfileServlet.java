package com.recruitment.controller;

import com.recruitment.dao.ApplicationDAO;
import com.recruitment.entity.Application;
import com.recruitment.entity.Candidate;
import com.recruitment.entity.User;
import com.recruitment.service.UserService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Optional;

@WebServlet("/admin/candidate-profile")
public class AdminCandidateProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();
    private final ApplicationDAO applicationDAO = new ApplicationDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || admin.getRole() != User.Role.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String candidateIdStr = req.getParameter("candidateId");
        if (candidateIdStr == null || candidateIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            Long candidateId = Long.parseLong(candidateIdStr);
            Optional<User> userOptional = userService.findById(candidateId);

            if (userOptional.isPresent() && userOptional.get().getRole() == User.Role.CANDIDATE) {
                Candidate candidate = (Candidate) userOptional.get();
                List<Application> applications = applicationDAO.findByCandidateId(candidateId);

                req.setAttribute("candidate", candidate);
                req.setAttribute("applications", applications);
                req.getRequestDispatcher("/WEB-INF/views/admin/candidate_profile.jsp").forward(req, resp);
            } else {
                req.setAttribute("message", "Candidate not found or invalid.");
                req.setAttribute("messageType", "error");
                req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp); // Forward to
                                                                                                   // preserve attribute
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Error loading profile: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
        }
    }
}
