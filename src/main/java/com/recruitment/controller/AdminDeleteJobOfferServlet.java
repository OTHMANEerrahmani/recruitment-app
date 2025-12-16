package com.recruitment.controller;

import com.recruitment.entity.User;
import com.recruitment.service.JobService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet("/admin/delete-offer")
public class AdminDeleteJobOfferServlet extends HttpServlet {

    private final JobService jobService = new JobService();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || admin.getRole() != User.Role.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String jobOfferIdStr = req.getParameter("id");
        String companyId = req.getParameter("companyId"); // To redirect back

        if (jobOfferIdStr == null) {
            session.setAttribute("message", "Invalid job offer ID.");
            session.setAttribute("messageType", "error");
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            Long jobOfferId = Long.parseLong(jobOfferIdStr);
            jobService.deleteJobOffer(jobOfferId);
            session.setAttribute("message", "Job offer deleted successfully.");
            session.setAttribute("messageType", "success");
        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("message", "Error deleting offer: " + e.getMessage());
            session.setAttribute("messageType", "error");
        }

        if (companyId != null && !companyId.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/company-offers?companyId=" + companyId);
        } else {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        }
    }
}
