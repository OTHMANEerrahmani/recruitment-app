package com.recruitment.controller;

import com.recruitment.entity.JobOffer;
import com.recruitment.entity.User;
import com.recruitment.service.JobService;
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

@WebServlet("/admin/company-offers")
public class AdminCompanyOffersServlet extends HttpServlet {

    private final JobService jobService = new JobService();
    private final UserService userService = new UserService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        User admin = (User) session.getAttribute("user");

        if (admin == null || admin.getRole() != User.Role.ADMIN) {
            resp.sendRedirect(req.getContextPath() + "/auth/login");
            return;
        }

        String companyIdStr = req.getParameter("companyId");
        if (companyIdStr == null || companyIdStr.isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
            return;
        }

        try {
            Long companyId = Long.parseLong(companyIdStr);
            Optional<User> company = userService.findById(companyId);

            if (company.isPresent() && company.get().getRole() == User.Role.COMPANY) {
                List<JobOffer> offers = jobService.getJobOffersByCompany(companyId);
                req.setAttribute("offers", offers);
                req.setAttribute("company", company.get());
                req.getRequestDispatcher("/WEB-INF/views/admin/company_offers.jsp").forward(req, resp);
            } else {
                req.setAttribute("message", "Company not found or invalid.");
                req.setAttribute("messageType", "error");
                req.getRequestDispatcher("/admin/dashboard").forward(req, resp);
            }
        } catch (NumberFormatException e) {
            resp.sendRedirect(req.getContextPath() + "/admin/dashboard");
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("errorMessage", "Error loading offers: " + e.getMessage());
            req.getRequestDispatcher("/WEB-INF/views/admin/dashboard.jsp").forward(req, resp);
        }
    }
}
