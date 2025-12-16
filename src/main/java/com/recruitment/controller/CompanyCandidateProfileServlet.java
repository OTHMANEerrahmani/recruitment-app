package com.recruitment.controller;

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
import java.util.Optional;

@WebServlet("/company/candidate-profile")
public class CompanyCandidateProfileServlet extends HttpServlet {

    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || user.getRole() != User.Role.COMPANY) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String candidateIdStr = req.getParameter("candidateId");
        if (candidateIdStr == null || candidateIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/company/dashboard");
            return;
        }

        try {
            Long candidateId = Long.parseLong(candidateIdStr);
            Optional<User> userOptional = userService.findById(candidateId);

            if (userOptional.isPresent() && userOptional.get().getRole() == User.Role.CANDIDATE) {
                Candidate candidate = (Candidate) userOptional.get();
                req.setAttribute("candidate", candidate);
                // We do NOT load all application history for privacy/security reasons,
                // unless it's specific to this company, but the requirement only asked for
                // profile data.
                req.getRequestDispatcher("/WEB-INF/views/company/candidate_profile.jsp").forward(req, resp);
            } else {
                // If not found or not a candidate, redirect back
                resp.sendRedirect(req.getContextPath() + "/company/dashboard");
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/company/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/company/dashboard");
        }
    }
}
